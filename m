Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9AEC47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUl1U-0005qO-5E; Tue, 30 Jan 2024 05:07:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rUl1S-0005pu-01
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:07:18 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rUl1Q-0003Zm-C7
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:07:17 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40ef64d8955so17140475e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 02:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706609235; x=1707214035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGjj4t6Tt0bfPXKL4DzHKstkGoaCWrviJvk5cF8v3JI=;
 b=SiS8G39R1LJwIXxWgiIEjX9GNo8G/UgrN2ppKPORUMu74Z5PBMGxgVg8FYPWcnCdvG
 egQVOXY0Ejx009py8jVFDuzRbQJ9yX9eU8ozzS30UDU/9cl5ewE71Zua6xLvkN6w6cMu
 6ox3bHmwd0po9ba3oveifPz7otFQutCLMCbQvW3Uuo5tKG8p36CViUOIHIfv2s+VqY1p
 zCD72HW+lHGLSpKxZeG9ZjkXUIIvsVYAKKMSmjObXDEkMLw6hE/4VBmwBZBaNMOPZdgQ
 V8jv9XOuxxV2Pul5CPSgpVDIasDWDyjroOx5jORlTrwNyP9tKkSYd2pp8PaA+b1KlEls
 yiog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706609235; x=1707214035;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PGjj4t6Tt0bfPXKL4DzHKstkGoaCWrviJvk5cF8v3JI=;
 b=lQtnUBSuhnG+vpZpRbxMej6Oi+QmmmJhL3S7CgXfc6yeHI8Yz1po54koopbcNf+E8B
 TZmuOlK3Xa3jUksTjTnQi5bt7+tv90DAe4iPZqAPev/7Su4ZEMU5JyLJ33Uxl2vkoCRG
 6NuEyd+bJ0q94skPg8DiKjzqjcw4iFUyYWnwNhuaLWdTtsFmKGhsYlolkGzOP0ExslWQ
 tld446vCgVX/wAaqzpYTpxRT8o6oDGxnXnXiFW/pSaPZNv5ULs9fHF9ay/ppdxwNDUSK
 M4dfEigx1QKM0anIuAaeSHiq22vkgtxTcPnvsNw2t1GlDhtHE9mKXCs4NBj37fYTzMuY
 EIHg==
X-Gm-Message-State: AOJu0Yzbsj1TYZELQjaK455vA8ddNnlhB8w+93Zv+Q6Bk1lzr2uQ0t8U
 68PuitopcC8+OJgLm46jY0/XgrVgy4BnuJLzwxMI2YFfx+pJML7CPQ4m9Uf66zY=
X-Google-Smtp-Source: AGHT+IE7QsQJ7kkSQIjk2V0TGDwvEWJaRk+GZiIrwssmHhuaqa3cvXIIzBIMhev6goWvmAyhrCETMg==
X-Received: by 2002:a05:600c:458d:b0:40e:fb90:207 with SMTP id
 r13-20020a05600c458d00b0040efb900207mr2695218wmo.25.1706609235041; 
 Tue, 30 Jan 2024 02:07:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o4-20020a05600c510400b0040ef7186b7esm5407320wms.29.2024.01.30.02.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 02:07:14 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6D6A85F9D3;
 Tue, 30 Jan 2024 10:07:14 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-block@nongnu.org,
 peter.maydell@linaro.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,  Anthony Perard
 <anthony.perard@citrix.com>,  Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 5/6] hw/xen/xen-hvm-common.c: convert DPRINTF to
 tracepoints
In-Reply-To: <b000ab73022dfeb7a7ab0ee8fd0f41fb208adaf0.1706544115.git.manos.pitsidianakis@linaro.org>
 (Manos Pitsidianakis's message of "Mon, 29 Jan 2024 18:09:41 +0200")
References: <cover.1706544115.git.manos.pitsidianakis@linaro.org>
 <b000ab73022dfeb7a7ab0ee8fd0f41fb208adaf0.1706544115.git.manos.pitsidianakis@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Tue, 30 Jan 2024 10:07:14 +0000
Message-ID: <875xzbqgml.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Tracing DPRINTFs to stderr might not be desired. A developer that relies
> on tracepoints should be able to opt-in to each tracepoint and rely on
> QEMU's log redirection, instead of stderr by default.
>
> This commit converts DPRINTFs in this file that are used for tracing
> into tracepoints.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

