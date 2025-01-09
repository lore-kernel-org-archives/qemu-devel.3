Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA861E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 13:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVssC-0007Xi-KC; Thu, 09 Jan 2025 08:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVssA-0007X8-IM
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 08:46:54 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVss8-0004At-Qw
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 08:46:54 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d9837f201aso2044839a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 05:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736430411; x=1737035211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LI2uRGOP3s7NrT+u7oSzBa0sVGOsXjxvRLarDImf9oo=;
 b=vg4T8KH3frrzx5Zr4o1ZeB56354Vsrz1gN4/ScHqCZwpSit4U+mWPc7vbqLpeEjr+y
 FypAiF7y2vEkOtzZwcx4zqsMDRFv03iJVs0NTHrVa39sWzdYPTGnto8LjtAq5Mlsgopz
 SwhrY95DJ42jMG2R9VSnroTRfHEefAX1M7VG4r8o8ED988vGJ7Qj/OajNoqs9G5jQ8gY
 ePjs3rc6BBRaO1Uk7bkYNanheExgP6uFKO7WYqsFvUo+4ALIDRdnlUgVi9IwfseY/miR
 KiXyJXivvxOUWHcoQ61CciFOQjXw+fIPJrkqzgyIC3NS1LaR875d8gnSQUlJUw4Qrpah
 8ucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736430411; x=1737035211;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LI2uRGOP3s7NrT+u7oSzBa0sVGOsXjxvRLarDImf9oo=;
 b=W8JKUs2VpD2q9iDEu0LYl9nqgbCcjlfWnW6FTDCICWaeXNASyzUArnUljEHHXpuI9r
 V736JAP8UxLEqZlb3slgmuf1DF3gICjrz6S30G0TPQHN7HUg1cnWnfF5mm0Sn/PYpDgS
 mHy5SuO6d+WtAKki+cbPLLVS5cMnAtqorpKE6sYYEmCnUKxe0oKSTFw/z/T5RbM/mRiz
 z9TT28i6xiQYBt11EM5wiwkRsJtCgsHmnx2YKvL777cEfJwRTy3WyxmDpU/oe/i803yB
 l4LdMpzWQPF1I/KNDF36YAnTnOYuTob23WT77pdwS33o6+FJYYHXoR1xdDxHLd2ic79J
 urkQ==
X-Gm-Message-State: AOJu0YwsYUEU9CoRc/KPmlI5/N4nuq64+rYj8AdCo6i6FtQcNQZjd2js
 EyoSMfiemZRFosx2slpAh8d5qPjKiuQ+JoBnHTZ2qvFnGj/aYz3dP4bt7CjnuOzLjX0XOxuEWQT
 xt7U=
X-Gm-Gg: ASbGncvzoUcfDVIIGxMFZ5vCatweYPlpXfy5XcdzKNRdGle9oRpU24EsOPXgBIYI0o+
 NRVkP7njzytgHaMEwOwRzWiXOaUa6KGXEDlWBfen22ohFuD2lt2rshcVu1GtzPECvB9wlF4jSkX
 QLpq1kPgUEOWwl3amHo/20cjPZsq3EqvZiyVTGW1ie7qw0AnJblKUWJkqJ3Legiex6PUXuevJhT
 mCbQ8TXKvli3aJrmfdYAlXx4WFYhVe6Bvh686GBs1qWT0/wrIR/Hwo=
X-Google-Smtp-Source: AGHT+IGeo2eOGH8/KNaZl4odCzs4WUVomGcvoIwQsbGKiixXs99k2ALhgfdI6TYSyYDcQszyT0eK0w==
X-Received: by 2002:a17:907:3f12:b0:aa6:112f:50ba with SMTP id
 a640c23a62f3a-ab2c3c78887mr304012766b.13.1736430410929; 
 Thu, 09 Jan 2025 05:46:50 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95aedf6sm74117866b.138.2025.01.09.05.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 05:46:49 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 326435F75D;
 Thu,  9 Jan 2025 13:46:49 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Artyom Tarasenko <atar4qemu@gmail.com>
Subject: Re: [RFC PATCH v3 10/11] target/sparc: call plugin trap callbacks
In-Reply-To: <51c6069c8a2d50d70d21a10c167066e5f0aa096a.1733063076.git.neither@nut.email>
 (Julian Ganz's message of "Mon, 2 Dec 2024 20:41:36 +0100")
References: <cover.1733063076.git.neither@nut.email>
 <51c6069c8a2d50d70d21a10c167066e5f0aa096a.1733063076.git.neither@nut.email>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 09 Jan 2025 13:46:49 +0000
Message-ID: <8734hs85h2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

Julian Ganz <neither@nut.email> writes:

> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
>
> This change places hooks for SPARC (32bit and 64bit) targets. We treat
> any interrupt other than EXTINT and IVEC as exceptions as they appear to
> be synchroneous events.
> ---
>  target/sparc/int32_helper.c |  7 +++++++
>  target/sparc/int64_helper.c | 10 ++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
> index f2dd8bcb2e..86b21eecb6 100644
> --- a/target/sparc/int32_helper.c
> +++ b/target/sparc/int32_helper.c
> @@ -24,6 +24,7 @@
>  #include "exec/cpu_ldst.h"
>  #include "exec/log.h"
>  #include "sysemu/runstate.h"
> +#include "qemu/plugin.h"

Also a merge failure due to tidying up of target/sparc/sysemu
directories.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

