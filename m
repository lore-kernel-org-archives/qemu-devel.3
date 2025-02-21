Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A4BC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 18:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlXM7-0004gT-1z; Fri, 21 Feb 2025 13:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tlXM5-0004g6-6d
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 13:02:29 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tlXM3-0003dL-8m
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 13:02:28 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso468182666b.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 10:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740160945; x=1740765745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0VIpIXlWZY4+bDWNsWFMr1NCbUgoObwDP7O2t3z6S/o=;
 b=vkBDdriMD6oFdRtfOBZy++33KZJWlp0QhLJjqmQFy8rQmy33j7Dx1wapNo7x9Hg4FI
 /RvDX0R3P21ck0AIw4SbMzqKKSmaE+j4QJ/85kophk8IyK28Rb8YHZXAbeTNPy/dAh+Y
 w6AibLdJT+Ba8Q42tLdF4AJjUYtn+i9Xd/Lntm3TClLGzAEHO9m67i7EgYzKciCYZXmv
 MZAu0olA/UuIB0JxuiFAwRQtm8/8UXwJAYpTGT6p09wBmgLekMsJ9Iwb4mm8GJ6VC/2O
 xulGq4yCQRTGsRPoO5WLVujCsQBaPzWukpitsOQk9hFGzgOFUaPSqg0J6YcwS1DKSgm2
 kLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740160945; x=1740765745;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0VIpIXlWZY4+bDWNsWFMr1NCbUgoObwDP7O2t3z6S/o=;
 b=qfpCW+sBbQ9+U3cyYNejmd8Lmkt4RiFGuHVxvoy1g2xgnEufRO4cYSRdH/rtWy7rny
 ke9D42N6nbVHlfpcbYoGvdXktbP6kZzIzt43imFkCEAoQkIotAvvlJfKjOQT5sgTmaBI
 Lkyf2XjfGtmwWsKvjWhNHQxwsDb68xQdew5BnRhpXMQ6jtJlnAR8lovxtdqDZ6gqMNr5
 in8SHEtC2tcb5p+QCXuiDxGQwVB1np+YvDXYtJhq/82Z7AU2NXSqSqAnbTJ43NnSXnU0
 IS4eeeut8kmnlWQV9riOStNrsfVg+DIZK7BuH9fZ/skfRSF59J9qUX5FYtnWR8ka17Zs
 tETQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi7oEKSFxicgYtoPokEFbFHmLLG+CmUh2oe9jqzHjC2xaV97N43Ld2GGlIbkRFiIkYl9E+HXk2FTbG@nongnu.org
X-Gm-Message-State: AOJu0YzqTqNX7/zyY3usndpM4lAemGvn8ey8CQPYV+ix+5mNNxNHjPGd
 F5lSpHgftydzXazKDe/HDcN9sSiS0ee0tmOQAhx0DrBws7mNgWWw+2flb71TJ0k=
X-Gm-Gg: ASbGncvua3CFNr/BxPHQE11XAF587Ec10T+nxrmki2Y5K4wViLwB+j7Qili9VKhJh6I
 BTt0eGiv1x/If9L8logRqMFF5qEhujC88PqBrdkgHS8XeDIeU7SQ8EnfId+co8/Bljp/FzWbhx+
 fNtpghXP/mbvR2GeCVU+Q2pnE8DqgIcM4mzkRLxf5jf24DO5NDZZT/h2zWH0JgvqRJlkAHhWu/Q
 NT2/gAa7dkUhHKtiFQLpYsXz3Tf54nWp7A14N9YRW+MIEadz6mx+XbmsBQrtZW/wBgEfhOIK9kQ
 fqdOGuzlWGAXnfcYJiI6iULGpe9s
X-Google-Smtp-Source: AGHT+IHHWkExOu3uHdwqkghhoFwrj9FhbCB4waAQ6bwGr8+kmC8W/rGRGXBUSUGCPeWShWyNrQ1Njw==
X-Received: by 2002:a17:907:6d05:b0:abc:a40:4192 with SMTP id
 a640c23a62f3a-abc0d994e7cmr392131266b.9.1740160944653; 
 Fri, 21 Feb 2025 10:02:24 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abbe1e8aa51sm486409466b.149.2025.02.21.10.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 10:02:24 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4D4B35F8C8;
 Fri, 21 Feb 2025 18:02:23 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH v3 3/9] target/arm: Make CNTPS_* UNDEF from Secure EL1
 when Secure EL2 is enabled
In-Reply-To: <20250204125009.2281315-4-peter.maydell@linaro.org> (Peter
 Maydell's message of "Tue, 4 Feb 2025 12:50:03 +0000")
References: <20250204125009.2281315-1-peter.maydell@linaro.org>
 <20250204125009.2281315-4-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 21 Feb 2025 18:02:23 +0000
Message-ID: <87wmdjgor4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> When we added Secure EL2 support, we missed that this needs an update
> to the access code for the EL3 physical timer registers.  These are
> supposed to UNDEF from Secure EL1 when Secure EL2 is enabled.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index ac8cb428925..7ec1e6cfaab 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2387,6 +2387,9 @@ static CPAccessResult gt_stimer_access(CPUARMState =
*env,
>          if (!arm_is_secure(env)) {
>              return CP_ACCESS_UNDEFINED;
>          }

Hmm this failed to apply as b4d3978c2f (target-arm: Add the AArch64 view
of the Secure physical timer) has the above as CP_ACCESS_TRAP. I guess
because I didn't apply 20250130182309.717346-1-peter.maydell@linaro.org.
I guess this needs fixing up for stable.


> +        if (arm_is_el2_enabled(env)) {
> +            return CP_ACCESS_UNDEFINED;
> +        }
>          if (!(env->cp15.scr_el3 & SCR_ST)) {
>              return CP_ACCESS_TRAP_EL3;
>          }


Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

