Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86DFC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x781T-0008Ji-1R; Thu, 17 Sep 2026 05:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x781R-0008Ja-Ib
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:03:13 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x781Q-0006Ji-1y
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:03:13 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6598dd44so3034715e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 02:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789635790; x=1790240590; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OrD6mzulYG3wTTiXBd52xHJ8NjcmhThk6ok4rRcwHQE=;
 b=Ncy12g96JyZBclMgcRWX8pAdZselEKoftbKVjw2+ZLELuep6OlmxjKqtQ0OAP2ADhC
 /cxXMBoiXbbi3qXI0SAXzVRuPwhSmyXnJ2X2MEOd3p1k1uwJjHKPnWSEqkXqQ4mYN/FE
 HrGh2Iv09o+0mMFHzl4TVf0gEfLbdXsO2B1YR5orjh2PW1/w5b85nD4H13xrEMl3R0vN
 ELWRlZcRUZMik/SuvIYSbHvCHtjaK8gskTnw5R4NWCwhdfEzCNiVshfAWnXV48T+dsST
 gS880EOFKba3PRgCZDpwDFUNLohIO42UfpOPMkTtPNxsnEeMJj2EHrbRpBGqRQNXsR5H
 1Idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789635790; x=1790240590;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OrD6mzulYG3wTTiXBd52xHJ8NjcmhThk6ok4rRcwHQE=;
 b=y8WHwi881wD1kFOjYR9eAsYXstzqZUR6OAhbjL2yZhIMmNYbA78j1IJUOO9db1lBl/
 NxQCoBW2o9g8Q565ieG08OuRB8kHeCKnISkE2E1uRAVkXgiiO5Rdysmm33xuHLLMsREy
 efu3HbAeoFCYk06yx0sYYcGnZWE9xbfo41eTgG+IZGOykLB+6K2KxL04T+OJKsYMQy8L
 7ckYzxcCQouBTW5fo8IuO/1sk7/Fo2eiXSCxhzA62R3VTjjlMMT100Tx8ZJx6JH08AV+
 OTBRpBsIFr0gEW8BUN8ztzE1xtpOczHhIln1cSFI7uA2B2F4V38cOoTiooov5H4dpiix
 6eJA==
X-Gm-Message-State: AFuF++kl6AiZUdQdr+1YrlVpSHsgHdDbB+JXA7ga0foGZDZ/hBu/djsb
 G5MaxDfxguXRAFBrlK9y5Liq54Ak04T+jQdFLf7hm4mZwLxQWL8AYVfSpQICHOV8Bi2ze9Sc2YK
 Hy2tjrBI=
X-Gm-Gg: AYBFou22f4XL/eAZuflQlUyt0HpG+WgfGerqWGh+ZbkERM0wElQbsFfERCMo4b2plOP
 WAuxAXI3v6GnzhP+84CsR5nlWgwuDB0Wkgx/Tl6TU8guIps71ZOzGs1vZhrmjwO2lWKnltWhhMt
 vGrzcQ3vX19AAy+UHi9VUWQCIG25uRfOK/o008hyvtAk7ZIZVycaevljHXSbPDbIzAPGbIlP+Fa
 iEBhU1OBcGJwMZlmQOGNlaCf0TaAGzaAOTnoirajn/Xa/KQ0Vs5b5j/RKLYc5DALb1grQnJBkX5
 VJnSu/jBg8qSonDon7Luz5veZuKdv0NUuV0jkmy0//YTSbq37q2lFcPwKrFUn55E9itbZ2YiEQA
 e7oMwjqXZ2V0Qhlqhixmx4QUgXUCXMTLTF2zYc/DnWD46CtAypIZTGVYantfchIiY9Wi26r2tXu
 U032pugxkmE79erktlDcDS2aHau/q2SeJjzvqf+WMoCFyuM11vlb8d1PD1QzVAdqMSb9nHJ+c=
X-Received: by 2002:a05:600c:19c6:b0:49e:645e:2616 with SMTP id
 5b1f17b1804b1-49eac463955mr64793865e9.5.1789635789825; 
 Thu, 17 Sep 2026 02:03:09 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd2563ccsm71788595e9.13.2026.09.17.02.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:03:08 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 63DC65F834;
 Thu, 17 Sep 2026 10:03:07 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,  thuth@redhat.com
Subject: Re: [qemu-web RFC PATCH] blog post: some notes on the bugpocolypse
In-Reply-To: <20260911173420.1581755-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Fri, 11 Sep 2026 18:34:20 +0100")
References: <20260911173420.1581755-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Thu, 17 Sep 2026 10:03:07 +0100
Message-ID: <87jyok8d2s.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> As we've been going throw the growing pains of AI bug bots I thought
> it might be worth addressing in a blog post. I'm mainly just trying to
> outline the challenges and maybe dissuade people from spam bombing the
> bug tracker with lots of low value bugs in the more dusty corners of
> the code base.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Gentle ping.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

