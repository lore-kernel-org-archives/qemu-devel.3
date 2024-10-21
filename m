Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDD3D0E6F5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qi3-0003Ga-21; Mon, 21 Oct 2024 07:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2qhu-0003Bn-5p
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:36:18 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2qhs-0001nQ-CF
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:36:17 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c9c28c1ecbso5539354a12.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 04:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729510575; x=1730115375; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uxtaWv6u/HvymZS8etCMb6RC5ms11Z/1DsPQMlxfEfs=;
 b=L5p8XRMAMDKtYSuwCGk0bH/2Rb6RHNiimCMKx5hF3W5G8Iz+0pUSkAmkW1WVv2lDsN
 gqN7VcdFAxHn5MbRwHF6i0Pr0H0sOuVl9vmV/2iXfK+4z6jR2uvuxETQ9/mLYheUCkEg
 QEfbERsRUTtfky3djMpNS/D3OzU6CmdQ9b96dsGUIS8E/kwwYX7PO4MfKF4V61Gb5CdA
 QWcTUXfmsNqw30fIalmMoBPLnuplF5/YdrsTfOsZmyy2cxcey34tDj9oo+tXnpMSq7MZ
 2dr/zzcs+12WDa8v94OtosowU0osC5NL/p47Fq67nr8bVppbfEn+XSre16dybKeXrh9p
 qUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510575; x=1730115375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uxtaWv6u/HvymZS8etCMb6RC5ms11Z/1DsPQMlxfEfs=;
 b=WG9c71pTepRdKwjJzp9WJNS7EyHGPtPMJqmRHsjdxh7zZnThrOXlUgnpSs/nDALVi7
 XvEyBpM7PHSC48Cv5kpRHAqoFCxE7mgvLNIVULaf1zwoeUANcsOVR2YN0fP9xqc4PeYW
 IbF8ay/4YMQ6g1FgwgSgUvtkBHmFT0+C+moPCgSJ61pgy7mXhF2q+VWHu7XjrxxUP1b0
 Wgky03NBQgDZ68aBcaTpps2Cx69J5gsc/dKvwqtfXKfB962YH5Qny5WLgY1Oq/DW/sGI
 XmdVmOaDh88DyNa5EDpqz4pEgMEVptAKoaerzV/fRqFACX/OV9rhVBezHvC9FXOJS4ca
 zfPg==
X-Gm-Message-State: AOJu0YzVVXfDPdwGtR/9Kz0Fn6gcIKYua6rvOiY3+myoKvhcn7y0cVMv
 tZ7wN0xzMpXKgZjYrMxUPZoDhrhUjC9GBfeF9DldZQ8jlaPBcupA3okxeYDKz2YbNiAfliZ2pYc
 /iTwrXQIc4dMWnFnon2fPzLOr4YjaT1guY/xE8w==
X-Google-Smtp-Source: AGHT+IEMDabWuEvyVInUFcJ93m5cRSBw2o7rz+UzgpFW3spHLGpBj/oBk/xoVFitoNDPU/izbHNL2jcYIE11tP+kOCI=
X-Received: by 2002:a05:6402:26c1:b0:5c9:8ab0:2975 with SMTP id
 4fb4d7f45d1cf-5ca0ac79006mr7035016a12.6.1729510574646; Mon, 21 Oct 2024
 04:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20241018132824.3379780-1-armbru@redhat.com>
In-Reply-To: <20241018132824.3379780-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2024 12:36:03 +0100
Message-ID: <CAFEAcA_FMqYZpPuK7HHX_su_CVb-9=DovB5D0nYdLysYGc7pdg@mail.gmail.com>
Subject: Re: [PULL 0/9] Error reporting patches for 2024-10-18
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Fri, 18 Oct 2024 at 14:28, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 95a16ee753d6da651fce8df876333bf7fcf134d9:
>
>   Merge tag 'pull-loongarch-20241016' of https://gitlab.com/gaosong/qemu into staging (2024-10-17 12:42:23 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/armbru.git tags/pull-error-2024-10-18
>
> for you to fetch changes up to 1824e9fc646c68e42e3f823b208382563ce5dc83:
>
>   qerror: QERR_PROPERTY_VALUE_OUT_OF_RANGE is no longer used, drop (2024-10-18 15:03:35 +0200)
>
> ----------------------------------------------------------------
> Error reporting patches for 2024-10-18
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

