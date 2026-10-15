Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F75CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHM20-0005MM-Lz; Thu, 15 Oct 2026 10:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHM1q-0005JV-Ih
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 10:01:54 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHM1o-0001x2-G0
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 10:01:54 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-677d35fd1d2so1788341d50.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 07:01:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792072911; cv=none;
 d=google.com; s=arc-20260327;
 b=GKP4HAFIlj1bWrxMDlI7KQqYrfZN4rl6tfyu0ZJS2wl8+EePfqtOKpmZ3klNvRgtb6
 IS6eYrX4IHL+uBWYj7MRUljY7xh8DHEfic2HMu8o9jAsSkQ2mqGKfye5mNJurEGBNBIc
 jXcidSOyTTGu3Rh9yEOT70uQxL+lGioVIBd9EEn0IrdGige9Xmh6TfvO75vViIKmhpGZ
 IjPz1sp/ral+ms5uDVGIVoZDqyRUgna8DAcpBZujVIqHmnx290P6RwA7JP+eKVlTpI2T
 +kmfJL/a3qbKaoBNTh5k2C5T9cu/G+g0oLoQ0GA04LikaiPIYBY2FGskR0H+N0mtRrgp
 rj7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7oNQfHG6Y05NR+ProUSz8aihaiu4aa6Lf03BAJlyuYg=;
 fh=NEyRVjg04fVR3TycHvG0jl9zlGvJgXNyHVqB9OOnoxM=;
 b=Ihd1QboG/Q96oHOo/vup7pbeN5oMUJ8fTUnQC4WZZk5w2zPpaDH02djobnKguep/Cl
 aV+Exx91cW+t/rrFte3Q07LnrwHZaE8yYddBNkIGE9A7mLzLWLdVN71tOzDRVf7o5ajp
 /ILE1dRg7zii5cyhrq8Wlvj+SXZgILYfchy1tgN9ZdgtQXjJqnuG4EKfvvNu8ugdehz0
 Mi7JKGrpKPvNOWcVxre9ruGMu8p0y9pduiivLN0si5elMV5LQ0dwAN688qoIlb6fTpIM
 Ut04whKfl+fDYkAdBB8oXWpUgrqDWYv5fMUPGv2Wuji1dzkvDNgWRABbqG3H8Rqu0WrC
 tg/Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792072911; x=1792677711; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7oNQfHG6Y05NR+ProUSz8aihaiu4aa6Lf03BAJlyuYg=;
 b=eZ5bOhrStDwiPucZsxZbcxsv+dt1PQfbPs2hOXwiBsjlPHMfD2klkF2gnb8kCvyawK
 89IBJ/krJEGPWRQwNwiDl8+smjyyXDi5/ctCAI1QVrqEbi5qyH4aEBxhGYdz2uV8J6fg
 643DB33N2vEFZs5Xg8O5e0dewTB2O1JjTZ6EFdNz832ltWZOQfJChH5pwV4L6T5ZQJrH
 hceLhfj67Me5zbuTWYYI+Dju84lsRPpChQCDU6qOR7ggnuj2LQdhrdh6kRdkiPL3BGUe
 b17XCctdR1uKvRV+JHx57+9P6txWtwjLbJkFZ/mkNtxyTHaH6aXDjbh2/ne2alI2dCer
 V+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792072911; x=1792677711;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7oNQfHG6Y05NR+ProUSz8aihaiu4aa6Lf03BAJlyuYg=;
 b=hspeQn1l7mYaewZPkcU08Nb5fR4wG0FgChqClg0dNr7HRxcPuRKkgDP+S1CWUe3Ek8
 1fe+sWFKB8AQpsp7Y6x/jlqvGXhGo+wt/3J/5AS4ydIYSHIFLzc2td+wvfdJOrWzcbNo
 uOfqvmZ0EW6hV5vnYPWUh745CoZWxWtyAQHM8cU67PgLe/b3eVV+MZ5b35efXn/hDhm6
 LZvlqiIvZN6AactNt5kZ9z0Y7j2gAuM9HqaGyOXdTsIhnA/B9x/JFmY0E76CyRZCnM8d
 MxR9U8Ww3Nm5b/bdPJ6fKIrQtcfZ171S/MG2gACnohC1zPfClGUZwYHhOOfLLG8dLde/
 efPg==
X-Gm-Message-State: AFq9FYIgAt1wYS+POhOpKgdYNOqzmMN3Jz5CpzT6YXb4O1vvJ8Z6r+S1
 sL0LsSVYb0+2zFjdaVn4R58zuSgDuLORGHiih2dImPL7Kq7qz8v0eArHeyfVuXCsOrHGjRe9x8t
 ctaf7hRDpZm1skx7SfQGKvvp+dGuONBv+fTfRTbPISQ==
X-Gm-Gg: AYBFou3JPtGk9cE1hn95y1tsplX/FxbVpeT75tewKlwCs35flOiRjJWNZ2YgkRTqqA2
 U/kxH9nBj9pjmm6vdudLIPtpM29EY6OztFP5Ge+GCyqM2kGM2B0eew1Ziu1aLNK6A7rxkEvhGZ2
 fxsk23s8yrXfmAN8GTyZt7E9aASxfAEx4RbG3N3LbU+rn2pTlm0YMiTdhsbs0JtS95MIaexHR/9
 q4SIWyeL37swkCKd0iqr+IU7cCDg7j+rZ1FCX9ZrGghbFsCYuEGTBdHtwdZZn0wWQ2IxqPUIruC
 KVSrH56F1Sl7HP07vG2gKnAYwwHFHL9LOByq9T5BiFMGCUANS2lIpid6paowcZfwK24cUhWowVd
 lzwvEn6EHfNroXHSXL7/mNHwecppadJ+sEq4JSQo=
X-Received: by 2002:a05:690c:e1cf:10b0:8ab:3246:4abd with SMTP id
 00721157ae682-8b07ee00c32mr45113657b3.57.1792072908857; Thu, 15 Oct 2026
 07:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20261014045605.399684-1-bin.meng@processmission.com>
 <20261014045605.399684-2-bin.meng@processmission.com>
In-Reply-To: <20261014045605.399684-2-bin.meng@processmission.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2026 15:01:37 +0100
X-Gm-Features: AclHuK8O0VgXq5DeTKRBO1XxrYp12VcAG0ZgJ-ioRxFsP-v4hCjkf2-e1cxUVt0
Message-ID: <CAFEAcA8vYgmm+8YZtcAHccP9KUt8oJjc2WAS9OgEHAsa9fMTBw@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] hw/cpu: a15mpcore: Model the reserved page as
 RAZ/WI
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 14 Oct 2026 at 05:56, Bin Meng <bin.meng@processmission.com> wrote:
>
> U-Boot's shared i.MX6 identification code reads PERIPHBASE + 0x4 on
> MCIMX6UL-EVK. The first private peripheral page is currently unmapped,
> so that access causes a data abort before the console is ready.
>
> The Cortex-A15 and Cortex-A7 TRMs describe errors for reserved
> accesses, while the related GIC-400 TRM documents RAZ/WI. Follow
> the behaviour relied on by existing U-Boot on i.MX6 boards and
> log these accesses as guest errors. Keep the reserved page in the
> private peripheral device.
>
> A U-Boot fix has been posted:
> <20261013232700.289717-1-bin.meng@processmission.com>
>
> Reference: GIC-400 TRM (ARM DDI 0471B), section 3.1 and 3.2
> https://documentation-service.arm.com/static/5e8f15e27100066a414f7424
>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

