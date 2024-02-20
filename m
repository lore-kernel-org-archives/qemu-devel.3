Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961E2C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 21:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcXbB-0001Uj-QV; Tue, 20 Feb 2024 16:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcXbA-0001UX-Jb
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 16:24:20 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcXb9-0001lw-3A
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 16:24:20 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-563e6131140so5730263a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 13:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708464257; x=1709069057; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MJI9omaxiEcfzvSVsoLDG4WoW/kVvZXv9KOhUn97YF4=;
 b=MoTIH1q4IV6DoLeNk8HAVS+OIMQTn15hVIyeGe1LKzhMDB7dyP1Ez/FYMHfRMtJDAo
 8U8CNMpSr1tauBoYIX13QEssysDwMOv9u6DHmeY+ki0EX7qe+4W7p12FaD5N4gUODsYz
 gJ9Pfz2jz5/FEO/ahObRnY4pKD+9toobjtam9+vwI+QBd9e6mhLPx/56mKYM/HINgjhA
 1jJMlF8FTKYsygSYV3nRfXw+xxhfCFKDREJTZLE1ZHKUMnA7jc+JTCWmtwjeumt0HY/5
 AyeKqxnSnjp/Ct6VwC0pKMu1e/MngaJjtQeF2Eavbu7DPDuDyF00rfT+LRE9vUvz1m4K
 owMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708464257; x=1709069057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MJI9omaxiEcfzvSVsoLDG4WoW/kVvZXv9KOhUn97YF4=;
 b=dYFp2cIOCHLKrK6m+1Jvk+S6EhfaTWArQtsDziHzr7YAfCBOoU0CRdfwUJ5IJks2mz
 YlRX9BTVWuryFIBQ+Eq/FlMDtJ0+K6HrI2dEcHNXwvbcrGvdHF5/T86Uhvag33A46jSn
 Gl0qkiiHa+/8ewEpfzAaHiwEiCuz/vvvirHc54NtyR3xaa6ITr/kadNqLlirOMgamI0I
 KBKqORm2uEn8cct41f9ToNPJXKtYY6b1FVak2/oQYX8ORsVRZqHf4hodF8ysOYXJqwXE
 h3/+cKKlqOqWGB3QdjMK+b4WgMEjLe9kXDgH880Hfs3s4fV0wkPdMcw/MmSm9Wfdwx0J
 Z08w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMIjQnj3R0NusfTFwmc1nyHU+vLwEhBx+Z8cetoe2xTWzqx+DfHYu23Ays6jZ+TddUSDfV/+b7fxDnvgCcUixiZHbmlW4=
X-Gm-Message-State: AOJu0YxR2Wnwv8HZN5I6iseZA7xi30MUZQBEK8XXjnE2KTSD6+MjJcOr
 zDvnqVuHTAk49b7mUK6oT2f9XsTMpFFkpJqRvN3P5rp7/jQQ7PDUxzshRH+qAZrLcJrJmEzCiFY
 8mmH839lEiX8vdd3LE3b2uuqCNXSQXcxMewrkgQ==
X-Google-Smtp-Source: AGHT+IEtadCOijPzWTXXn1/GQp5CwmT59BKh1Z2bqnGYV4Tp1diO3VgE+05drwS8CF5AvisgOV3HxNyp6o/TvN0OR+M=
X-Received: by 2002:aa7:d046:0:b0:563:f606:3b36 with SMTP id
 n6-20020aa7d046000000b00563f6063b36mr8792017edo.8.1708464257625; Tue, 20 Feb
 2024 13:24:17 -0800 (PST)
MIME-Version: 1.0
References: <CAOpGCn+KdhjnXRHup6GXVbkoZkUBc7f-2urNzmvLjK1To_pp0A@mail.gmail.com>
 <87a5nvci5n.fsf@draig.linaro.org>
 <CAOpGCnLxVGhbJuAq+K+DNZBESEGGkSr8Sa0_cHsfMR7S-_ahkQ@mail.gmail.com>
 <87y1bfawik.fsf@draig.linaro.org>
 <CAOpGCn+_=5Uxi9mt-C1V3pguNT0OUJura-H3SwBOsJnW5tyJ4g@mail.gmail.com>
In-Reply-To: <CAOpGCn+_=5Uxi9mt-C1V3pguNT0OUJura-H3SwBOsJnW5tyJ4g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Feb 2024 21:24:06 +0000
Message-ID: <CAFEAcA-03JYx9szd3FrQ_786gaRLWCJVHeMgjBxxvgH85f-78A@mail.gmail.com>
Subject: Re: QNX VM hang on Qemu
To: Faiq Ali Sayed <faiqueali.109@gmail.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Tue, 20 Feb 2024 at 20:56, Faiq Ali Sayed <faiqueali.109@gmail.com> wrote:
>
> The image I am using is currently in use for real hardware, and
> I received it from a third party/vendor.

OK, so what exactly is the real hardware it's for?

> Could you please suggest to me what I can do now?

If QEMU has a model of the hardware the image is for:
 - use that QEMU machine type (and issues with getting it running
   will be related to making sure you're loading it at the right
   address and starting it the way it wants to be started)
If QEMU does not have a model of the hardware the image is for:
 - ask your vendor for a build that targets some machine QEMU
   does have a model of

Unfortunately in general in the Arm world guest OSes are
not "runs on anything", but only "runs on the hardware
they were built to run on". This remains true under emulation.

thanks
-- PMM

