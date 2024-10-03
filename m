Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCF3CF8577
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 10:38:03 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swIOm-00034i-Uy; Thu, 03 Oct 2024 05:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swINZ-0002r2-Oy
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 05:44:41 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swIMd-0003Hw-MJ
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 05:43:56 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37cd8972738so594142f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 02:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727948505; x=1728553305; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vOtGcluMFXsWvMUL4dkFlwOKf8Uf0Hpu0Rj+cXP7+Kk=;
 b=F6ubme7dDzwfnn8SU2Q9cxfEkl/dsJlwbiZ3NGRThMQowAxqaXCkkV0g0jn/TFeMVu
 B7/GOjTrMp7KRnSSt2HTY2Dk5jrdbKyMiXXaHMJupCzezMWm/VY8Og75wCsHsun12WId
 Ke4/8s2vTwDQhEtBSen561JUsEL76frPKjUVHmvUJ+VSDoZZvKOeZV23buz8SNBzBx1r
 2AteBjiWZSXfpgtQDTrmHDDSz8TrSw3U4WRlNwxuA7S9P9f46vx+Zi7AEogToJAwOrWz
 dJE5GgdzqItPKYPvQz+71/fGHZb+pA0co3l9vH5ZvUbFRsAcqlyYnMyWT64+fEyH+v1g
 rfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727948505; x=1728553305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vOtGcluMFXsWvMUL4dkFlwOKf8Uf0Hpu0Rj+cXP7+Kk=;
 b=IRipaQRA5AyFjMFGdpnTnKGBVkFVgQFK0vKfeGUkkm+qqkC2O52KPh6uPEgNsXafXe
 Ya607Q8MqEYFYxUI9DgIuWqk6jriQpXwrooLpJRx3UBFffaIYgaA8XA+UMgqaL1M61DK
 rToE1CSSzeR2xYneGzunuNp4wVOD1vzqlDiWDDhH8p93bYqLDpAhoKbiQnS/DRzmImp4
 alW/kTdxizexHDDXSqViagTDbFSlHLCloN81DSzVksOIAe4kdy1c5oa0rHGtoV49m3dX
 dk5ONx8xAOwMhpw2cDuEOe8B+UKIEXCzFm9bQZFWsQPDb4AJQikxmDjxChgzK8ovdF6u
 t1Rg==
X-Gm-Message-State: AOJu0YyMTXLaObElbStYbEg9RLx5tnkNakjmueAeZZM29J3Uw6/iWtEr
 TUJx4qCf1OiMqQ1KA5DH8m4idrgcTrRWlDlhcz7dV1k8r5gMz4S+DodJC5dIBZr16130puwX9Nr
 G1Oa3F3B2Q5vC+tM/ic8zzkqLkFR5TciJjZC6xUnCDQx81F2m
X-Google-Smtp-Source: AGHT+IEg53yJ8HqrQvPcQ7pFBjg8Syaxf8ikpYEQFS3ZqEKIirHfCq1XHQnSKrvEEEYd8uRZh3I25vqmhyEW+qfmcy8=
X-Received: by 2002:a05:6402:2710:b0:5c8:8db1:1d55 with SMTP id
 4fb4d7f45d1cf-5c8b192900cmr3891193a12.10.1727947936007; Thu, 03 Oct 2024
 02:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20241002055048.556083-1-alistair.francis@wdc.com>
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Oct 2024 10:32:03 +0100
Message-ID: <CAFEAcA_qZttQ=quVj+Z=kSZHHR7Rv4YobF_0JaqWUctgDVP6Cg@mail.gmail.com>
Subject: Re: [PULL v3 00/35] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Wed, 2 Oct 2024 at 06:51, Alistair Francis <alistair23@gmail.com> wrote:
>
> The following changes since commit 718780d20470c66a3a36d036b29148d5809dc855:
>
>   Merge tag 'pull-nvme-20241001' of https://gitlab.com/birkelund/qemu into staging (2024-10-01 11:34:07 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20241002
>
> for you to fetch changes up to 74b493244d0624afed22606e76fc7fca62777401:
>
>   bsd-user: Add RISC-V 64-bit Target Configuration and Debug XML Files (2024-10-02 15:11:52 +1000)
>
> ----------------------------------------------------------------
> RISC-V PR for 9.2
>
> * Add a property to set vl to ceil(AVL/2)
> * Enable numamem testing for RISC-V
> * Consider MISA bit choice in implied rule
> * Fix the za64rs priv spec requirements
> * Enable Bit Manip for OpenTitan Ibex CPU
> * Fix the group bit setting of AIA with KVM
> * Stop timer with infinite timecmp
> * Add 'fcsr' register to QEMU log as a part of F extension
> * Fix riscv64 build on musl libc
> * Add preliminary textra trigger CSR functions
> * RISC-V bsd-user support
> * Respect firmware ELF entry point
> * Add Svvptc extension support
> * Fix masking of rv32 physical address
> * Fix linking problem with semihosting disabled
> * Fix IMSIC interrupt state updates


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

