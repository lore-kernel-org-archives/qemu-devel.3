Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB1CEF8FE4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCTF-00040F-61; Thu, 05 Mar 2026 12:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vyCTC-0003zc-99
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:26:42 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vyCT8-0007Wp-5U
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:26:41 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b940a00415cso160645266b.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 09:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772731596; x=1773336396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hx6Imw3ryIeCmAJeChihmuK5I2hzAWvFhB+n+S/auJM=;
 b=cgNEMYdrAICuTLUdFzLXj5iyOZ7H9OaMWEfyzV76KsrbZKsKOCSecy9NQwzTSHIxCH
 UDkcVQdVdanMX1n0OMf/gsbryCjD/4aJltjZMVoZP9dv0JWh+WOO27obpYpBU7CTUuNp
 AbhYilI2K5/w8G5hMMYKZHiuf9f+SEKXyA6aSn0g/MqGNN68k8/zK/Ln4T9TqXGn1jBy
 js1kh2uQEusREIMWH4W9tluc9Po9g5GbpmE1m0GvMDupEKiyqZeO4Pgo4yYjAnEvGdzQ
 59MqYquIGCJRwu5EzXTr/H/F3AjkF1K5k6xZ4437ucSkk7jN67aoaYM1zr6t4yo7B56n
 HtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772731596; x=1773336396;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hx6Imw3ryIeCmAJeChihmuK5I2hzAWvFhB+n+S/auJM=;
 b=ccr3Xlg6nxHXvNkwSrQvnbzsRKzZ06SuFfR0EcOukL+TkRc6mV/zDjmLI+7Gg8WqL6
 8lNP5xAx6LBaP0Xc06IOkSvRoxCi1jmRdl1jD/g4SEHqTbztO5Bzddkf/pKv84bznOd9
 POVzQuxHw33tj7bRXWJGp9A0BTCNwJJ5KZKw7kqWY4HG/ZH6rkFRuQ2mq2j4olbumtwT
 6+e7h619PnawLHqPnOGzUTmzLfxflBf1nqfc89Pbz+kT9gEutCoC2OAghFelq8p46xaa
 lcUN5ryRbJTly7DbHV1yRIrCqznRgaPSqE84vyAm0J6Y+KgPvPsLuMaCj69mAgVnSBHM
 4acw==
X-Gm-Message-State: AOJu0YzNU46kL/X8jREKNIZZilLdJ7R5FPqYHiIEzviB2tVlvD9tZ1g3
 reY35D2NEXC2WOp9/VATI3KPbV3OAHY53TRdGevhuGcEZElbQmDgK93ksicNBJMThI6ftebuI5u
 4QPsK
X-Gm-Gg: ATEYQzwGxvIghDhr+VeL/Uve6MRbGulMfHghsSvo13izcApbCFpyEG7HA/vq9z184GO
 9I4y48TwrphHq26BcWydcmD4VvoVBc7uocIf+QOttJtxqnjvnIDe/uUyBoX7rfiiW4PHSJpgcxw
 dJnMi2lQ3mM9hmJuXMAyGgsUhbH+y0Ifzyv5wv0MhiOC0nBeY+httZ2g/J2V++uGACLREyhUYPG
 X84DuDPMj+hcSPJtzed+BllHMtuD/YO+OdjZtCCdMQ5YJsuilxxviU0MII11HEfVY6Nf70XtWTB
 tT5jCAwWzo9uzE/PdfEe7nxrl11s5qaFn3Z73ParGvd6rD3xGyY5QcXPHsKqqN0obZIGfXReijW
 WmfSMiVTEfbeattkI9v3qBC3rlwt5AmvR51gNFsoFMl/zHZDoabs85mkC6NyTkvbZX9/KoyZxAH
 T/Yxj2+Jby+EdV5FqHuENPC2w7RKCRaUyizw==
X-Received: by 2002:a17:907:d24:b0:b94:29e:a94c with SMTP id
 a640c23a62f3a-b942284f7abmr26556566b.15.1772731596212; 
 Thu, 05 Mar 2026 09:26:36 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935afe7d28sm909860666b.67.2026.03.05.09.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 09:26:35 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 58B0F5F809;
 Thu, 05 Mar 2026 17:26:34 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v7 1/8] plugins/core: clamp syscall arguments if target
 is 32-bit
In-Reply-To: <20260305-setpc-v5-v7-1-4c3adba52403@epfl.ch> (Florian
 Hofhammer's message of "Thu, 5 Mar 2026 11:05:59 +0100")
References: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
 <20260305-setpc-v5-v7-1-4c3adba52403@epfl.ch>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Thu, 05 Mar 2026 17:26:34 +0000
Message-ID: <871phynq5x.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Florian Hofhammer <florian.hofhammer@epfl.ch> writes:

> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>
> Syscall arguments are abi_long in user code, and plugin syscall
> interface works with uint64_t only.
>
> According to C integer promotion rules, the value is sign extended
> before becoming unsigned, thus setting high bits when only 32-bit lower
> ones should have a significant value.
>
> As a result, we need to clamp values we receive from user-code
> accordingly.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

