Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1896FF46C59
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 16:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9n28-0001SA-Ci; Mon, 06 Apr 2026 12:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w9n26-0001Rn-Hg
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 12:42:38 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w9n24-0002LA-Ta
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 12:42:38 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b9c1da7ac63so709511166b.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 09:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775493754; x=1776098554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FSp3ZZV6IXyG/rTz6Kl0bnaeCUE0wAQ06A9ZLYInE2g=;
 b=k+iUiWmeeFhxO1EpX8z0/WA51ju0i/dtMdO8p7HQsP6vXfk8kXRckhj8u15aQa2t7e
 fcxGPUTb/ci/Xog+O9pqSh9+388BdLicJl4kMBGEEKj6Y7sf5puMZ+Z2c66AYvsDeJAl
 y/H590n57s+0s2/+XMCo0eXzK3V8VpW3IAA2LurcTkKx1qUroVUqDGtHayGLA7+SSA2L
 wYfueKyyHANmqcNt9Y/bzw7Fjs6wiST7XNWjP3TXcBuWNbvSZMdRZ/WJTw1McYAS7ttM
 x5Q/q2e4czH/DyquLTneMMKZ/HIbbx2uYfVHAnC+BX3HoORpPExpouq7TOuImH4yIBzy
 DWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775493754; x=1776098554;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FSp3ZZV6IXyG/rTz6Kl0bnaeCUE0wAQ06A9ZLYInE2g=;
 b=RJQEobQm5dCwk2e1E4u72m4dUM0cG6vSxKpWdY17SgcWQUaUfjDaXj7jSefeseEL2Q
 T8NQB2oluUsvSzxAqVGGZp4ZliIgApn3VWo+8RUb1MWT0JQNxb02OCtnBZ3/hnTmDs6v
 lIg0X2Z1eML8rwtLlrp3OnDxWg6AtKLD9ZTb/7J07IAHCkeWwEaekTHCa82c7OR5Cy2s
 Q+w63dsBum7E4vND8Jh4s3OuETllbcBkhS/C8RWYGMpdP2f0LzU+IILm/H10ak1qDYD3
 F/ZGx1F7Fv4SHfjMvo/FbWvoUzlJ9iU4SdKhrLlONSbbdgEp5tqxm56rK6moDGxCyY2s
 9xFQ==
X-Gm-Message-State: AOJu0Yx2ewtrl6yym35SoiJ+3eULOFnkUKtsql7ReMuTOCciNbUjFmFh
 cryax7K7PCV5vwEK8DBlQe7uRD4En2JDRnaYmL0r7W27Q5ceZvoNIq0toa/kq3rtVcs=
X-Gm-Gg: AeBDiesuKAtc5tKpgKRC7lgbqkh9XIOwlupXKdwF89efbETJ1NO2WCf68xedxljNqXl
 Fx4+4nkJ5Jbg+j9/HOE4JLoGqHtNckRerWlIfBuYbDjk9MvkD6AOrLHfpcUF0iyyOt75FtYegI6
 S4aC3IKAaAfTQnvXMALT5hcY21Low4Uxb8ZhpcOOZMTjeC3YLjhGWnF56JjhdTwSBnbBrg2pIJa
 X9etVd6Ontzzb3yVgceDmJ83ybXvCjxZdH1hmE2k7cSRMklt2ZxVpEFCMqLKJmYZ/4r8aw+wZJ2
 96R3s7aIeyQPYz0yvXqnHq97p7gxYrNJcA0F3+912pCB2Aj/kceLhhFX3TBnBmgRewaRYf4xgZ2
 P07QRxnHEP0tSpwHqtQsUwHVclB5ys11fQ5SwY5K2cz7M5meCE+5VGbcqqSf9wdLn3MHZpxqguz
 TzNwU9N9ZTPj+15uXSaRO0FZpNaLyDubmZ3g==
X-Received: by 2002:a17:906:ee83:b0:b8f:ae35:cbdf with SMTP id
 a640c23a62f3a-b9c67b67376mr730203366b.48.1775493754227; 
 Mon, 06 Apr 2026 09:42:34 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3c9722a9sm484819566b.3.2026.04.06.09.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 09:42:33 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7BF125F920;
 Mon, 06 Apr 2026 17:42:32 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Adeoluwa Ademoye <adeoluwaademoye@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [Newcomer] Introduction and seeking guidance on TCG / memory
 architecture
In-Reply-To: <CAPxx-NymyR=iJ9CpdccOep=gO=L8gzjuTytXZ2DhGBhXpttSmg@mail.gmail.com>
 (Adeoluwa Ademoye's message of "Mon, 6 Apr 2026 00:04:25 +0100")
References: <CAPxx-NymyR=iJ9CpdccOep=gO=L8gzjuTytXZ2DhGBhXpttSmg@mail.gmail.com>
User-Agent: mu4e 1.14.0; emacs 30.1
Date: Mon, 06 Apr 2026 17:42:32 +0100
Message-ID: <8734186nwn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Adeoluwa Ademoye <adeoluwaademoye@gmail.com> writes:

> Hi everyone,
>
> I am an engineering student with a focus on systems programming and low-l=
evel execution. To build foundational knowledge, I
> recently wrote a stack-based virtual machine from scratch in C, implement=
ing a dynamic type system with runtime type dispatch, raw
> bytecode execution, and manual memory ownership across the entire object =
graph.
>
> I am now looking to channel that into real open source contribution, and =
QEMU is where I want to start. The TCG subsystem and
> memory translation layer are the areas that interest me most.
>
> Before I dive into the codebase, could anyone point me toward the right d=
ocumentation or entry-level issues in the TCG or memory
> subsystem? I want to make sure I am orientating myself correctly from
> the start.

What documentation we have is here:

  https://www.qemu.org/docs/master/devel/index-tcg.html

You can also see:

  https://www.qemu.org/docs/master/devel/codebase.html

for a quick tour of the code.

>
> Thank you for your time.
>
> Best regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

