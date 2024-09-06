Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F097CE7B1B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 14:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smZtL-0007m3-Fq; Fri, 06 Sep 2024 10:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smZtJ-0007lP-Fx
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:24:49 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smZtH-00065d-Od
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:24:49 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c245c62362so2721573a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 07:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725632686; x=1726237486; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KeDOyXC0DOtHylcA4WZ36UolU64e2fW+Pcrta2aLVvA=;
 b=cvCTa8FX8P5RNjax8uC2QbEr4xcHBtpwqhqsxzVaGgyJRcAW+4Lf9/6rSV2XxBaYIR
 tG79ZILheKDlf2M2GwXJXPU+n0K2dhsuLveHJlptlAWBn60gy7aHsnZSXY7weLhoro2F
 CpKLFlJ2a4dcyGbn8YRz6prbxRweBtHky7FRFNeKg0Fu36bRK2Pj8Lg73MrgmhJ1Jxld
 fokOdDvj9bceBU/MVO48qeZ5Tx0H+2nkiWSATGxahvotkeylZOQ2eO+UKrrtoOtud3Fj
 TKV/D0ip9541j0nWSfR2Vm+Uonb3rs80z4O3CA+Q+Pv9zbuFrSeLly0kWnXRKzKy6TYY
 v36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725632686; x=1726237486;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KeDOyXC0DOtHylcA4WZ36UolU64e2fW+Pcrta2aLVvA=;
 b=Fht2qukTLcQw7BYz5iUazhw9XkxLIuXWMuifyKaHrqz4PA0nvvv+COYY/DDk3bdRu1
 E3mvGHA8hoQ+ejnl5+Bi87bqlf/SfEvB5Otg/DphXeLdi5n8YHsOya1bRYdZFBTGA1gd
 ByZQA2zPduWRlPhsMIekSHhhybv82eEpSPZHMroc0C5YNjunKPXF2cqtBYHQ8IzqCfMc
 7oc3b/0CzMxDKN1QZBVnpVu9TAvc9SI/i2QXrwkY+y3pmZGaXsXSFlm5IX01ijpwJi6Y
 WPYFAFTtnzikH/mthLENKMV1SV9sL9qSCWPsE2LgdbSxGt2rNXJjB1PWsoIzHEuFORBk
 vyjw==
X-Gm-Message-State: AOJu0YzO2bJ8Vgl6RswVOfklwx0iZ0xFhM9H03VdGPiupCwjnqz8yGRf
 lX3gVtXozEku6+rJeBnF+/rsPABrfyDd3AF2k95JSNnaNCmP/n9Ll1izjTbH66BaI447wDWRU00
 4CeHVSNbJ+LOWsz2EhkxEkC1erlE2K9Qn+qzatyRuAlt+pV5C
X-Google-Smtp-Source: AGHT+IEHOYPZafxP09hyg0KEFTcoYpA6TbPtEQ6QHNcFZyjebozc71lliLv2o23SGnFnEtWM83Oc1QXVeJSMSQfqURk=
X-Received: by 2002:a05:6402:3596:b0:5c2:112f:aa77 with SMTP id
 4fb4d7f45d1cf-5c3dc7c6f49mr1814846a12.31.1725632685408; Fri, 06 Sep 2024
 07:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240905130100.298768-1-peter.maydell@linaro.org>
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2024 15:24:34 +0100
Message-ID: <CAFEAcA_9NnrRq4fs3tNYsaxNFa5ef3G_ZCRHQjAPXeKVVuUfiA@mail.gmail.com>
Subject: Re: [PULL 00/25] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Thu, 5 Sept 2024 at 14:01, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> First target-arm queue for 9.2. I know I have more stuff in
> my to-review queue after this...
>
> -- PMM
>
> The following changes since commit cab1afb393ea0943b3086188e91d71d594ede6bf:
>
>   Merge tag 'hppa-v9.1-fixes-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2024-09-04 13:20:17 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240905
>
> for you to fetch changes up to 99ec7b440a1d6a6ef07450b68687d24d13a25fb5:
>
>   platform-bus: fix refcount leak (2024-09-05 13:12:37 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Implement FEAT_EBF16 emulation
>  * accel/tcg: Remove dead code from rr_cpu_thread_fn()
>  * hw: add compat machines for 9.2
>  * virt: default to two-stage SMMU from virt-9.2
>  * sbsa-ref: use two-stage SMMU
>  * hw: Various minor memory leak fixes
>  * target/arm: Correct names of VFP VFNMA and VFNMS insns
>  * hw/arm/xilinx_zynq: Enable Security Extensions
>  * hw/arm/boot: Report error msg if loading elf/dtb failed
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

