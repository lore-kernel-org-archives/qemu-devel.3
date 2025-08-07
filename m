Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B07C87FDA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 16:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk39A-0005EZ-FK; Thu, 07 Aug 2025 12:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1uk394-00057e-Ib; Thu, 07 Aug 2025 12:07:10 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1uk391-00010e-L0; Thu, 07 Aug 2025 12:07:10 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-76bc5e68d96so1132007b3a.3; 
 Thu, 07 Aug 2025 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754582822; x=1755187622; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VZINBPu8sfj/FpGaJNR7o9bp1Y3qwK2h502aZGZ4w9c=;
 b=VuSralyizhw4nVlQV6gZ2nqnwo1wHEhKJME6VbXLpYRanWP5V/mmFLNVwFpcIkPGuY
 viWB6DXOBD2DswEp91QfNskbU8ETWpzXZnQ+kTUJRtev0Ub0fV7Ask0El1zpfzRkgvx4
 1gCMPUSG1j3G7Bavr2gSutQlkW1+OUklkLP6CRmKGHUmxx43cxSnGldjgStbYQN40nKq
 cTqlPd+yWAEbYzZ0nkSEcGS+0op8XxNL1583bU26JHWqx1k9XYjH28cCCG+yz8eDLO7s
 iKwAT9RCj8UoIRrbtlVzD65EPDmZnEPEHxYdPE7+Updb15VSP6nUXS5Eqc55OeWW2oI3
 RP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754582822; x=1755187622;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VZINBPu8sfj/FpGaJNR7o9bp1Y3qwK2h502aZGZ4w9c=;
 b=IOgTzTqpqXibIfQfSsP1MIY2RkYpT6FkTrveP86376hd9zcxKs8mcSLqhsa8JG59Yi
 2WEsP/a/D1iHelQ8vfxQHlegAY6F/DTBT8e7FfPSN0DFZMLNUMT0DHM+mUUvI/esvwFN
 t+JctGPXd2RSAgWw5fmpYGge9T92ZIPI20bw2jrcZtZ9UVkfLGQvXKpH05lPC1SZSbjB
 e2DP9Cv1gNihon9EddTQ6s9MBYm+rr3oE1sw5JDiCMYCpyZ9TETNr/XtR99rqMVKyhQL
 Dlt1Q+rOlgOLwiGSA2SOLuskmpDqv4BVHEXg84Sawz8A9rn9SIQWVPp/wO62tVRt5ryZ
 DwHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIY1iB9ZoPZdPEH5nBRxLZ6Onz09EA8p6hwqgfJ7chpuXvpBonN/IQKJK90TDtc+HdR3ysF8gFxQ==@nongnu.org,
 AJvYcCVsBE+LaHB9jYE00DxdVbMnaEajbMHjtW8mlB//LDmzoikbHlVbtS15G4gvJbeuVARsMrsPvfdx2gCqWQ==@nongnu.org,
 AJvYcCWEjFJLyBzKe17O8ARolNx3TB2bAFxa7HaQYJZm4mj2MkIm5W0RCDAjzSsWlK0o2oR787I9Sy939Ax7Bw==@nongnu.org,
 AJvYcCXpcJikvFFf1So825DaoYgWruIX8DxdINascz5aHKEkRYKyHrT9ymwptrYlzXxCgw3JLdX4cPFqo3x/VQ==@nongnu.org
X-Gm-Message-State: AOJu0YwbBfBnLGb4909wUwq0JQe7b2GjIWCbCPr6KbpVAaCt4MPEHjtL
 hjupzES/lRpupPiwwenGBny5YeMKogtamNHd1lt2HpyQ2VKZrTy3Nho3
X-Gm-Gg: ASbGnct35PcPO18DsKkbILSnUuxIrIoMMmDkst+PAdPF6r5uiaoZeaOVte5/W2x5G3p
 GyvnDgUbzfiq14sl1BZWgrpDy04vgnNkMH/6+OiG3zhE+rbrt30dytLpjOdFq0RZs9Gkk9MWhXC
 qNc699EH5l4isASlGyzkR1xT8rktWjRUGV9YW34VVMnjYqOCAdveJbCgcHiv8iAFUtBVs1lFQbN
 sTHgFt3UWjIgBGv7qNO0SbLSrVThqDZuP/l41ZRoeNA9UcYxuSxixsVa5r5FS1irvPBK4mU03la
 5MsVIG53a4wVStn4R/w9aTNu4lJrpsRRcwThdQLEASULZCCsn3LWEr0ZTRbAYeFZRmKlfDOZtbQ
 ZZ36+5MfZ7B9tFlIP/yHZ023ahYP9iy6z/2U=
X-Google-Smtp-Source: AGHT+IE+LYY5RUOOkevrxpPtre1Ir+ysH+CHBjSw9JGNCqe+Ddb1dZViDXzUhKgpE9Mwa3POrHFvlg==
X-Received: by 2002:a05:6a20:7346:b0:23d:7abe:be06 with SMTP id
 adf61e73a8af0-240314b5535mr11419797637.27.1754582821723; 
 Thu, 07 Aug 2025 09:07:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfbd98csm18341505b3a.67.2025.08.07.09.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 09:07:01 -0700 (PDT)
Date: Thu, 7 Aug 2025 09:06:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Ben Dooks <ben.dooks@codethink.co.uk>, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH-for-10.1 v2 00/11] hw/sd: Fix SD cards in SPI mode
Message-ID: <5b2dc427-f0db-4332-a997-fe0c82415acd@roeck-us.net>
References: <20250804133406.17456-1-philmd@linaro.org>
 <39982478-b3fb-46b0-bef0-c0839c123300@tls.msk.ru>
 <9dc90489-9e74-4e00-8fc6-f97e3f425495@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dc90489-9e74-4e00-8fc6-f97e3f425495@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Aug 06, 2025 at 09:22:46AM +0200, Philippe Mathieu-Daudé wrote:
> On 6/8/25 08:39, Michael Tokarev wrote:
> 
> > Philippe, do you think this series is something which should
> > go to stable-10.0 (LTS) branch?  I'm not sure for the impact if
> > it is not applied, though, - what do we miss in this case?
> 
> Only 2 machines use a SD card wired over SPI lines:
> 
> $ git grep '"ssi-sd"'
> hw/arm/stellaris.c:1302:            sddev = ssi_create_peripheral(bus,
> "ssi-sd");
> hw/riscv/sifive_u.c:671:    sd_dev = ssi_create_peripheral(s->soc.spi2.spi,
> "ssi-sd");
> hw/sd/ssi-sd.c:70:#define TYPE_SSI_SD "ssi-sd"
> 
> I don't know them enough to tell if they are that important. This
> isn't a security problem. The emulation of the transport (SPI) to the
> SD card being broken, guests can not access the emulated card.

With 10.1.0-rc2, trying to boot v6.16-11744-g9c389564fa8e on sifive_u, I get:

[    2.503619] riscv-pmu-sbi: 16 firmware and 18 hardware counters
[    2.503672] riscv-pmu-sbi: Perf sampling/filtering is not supported as sscof extension is not available
qemu-system-riscv64: ../hw/sd/ssi-sd.c:160: ssi_sd_transfer: Assertion `s->arglen > 0' failed.

This is without trying to boot from it. Oddly enough, booting from SD card
does work.

Guenter

