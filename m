Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AEEC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvyvt-00049T-7L; Mon, 17 Aug 2026 11:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvyvs-00049D-GJ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:07:24 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvyvr-0007Ot-3z
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:07:24 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-80cebd41372so51804117b3.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 08:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786979242; cv=none;
 d=google.com; s=arc-20260327;
 b=HTnplOgcE/SNYviOVCab/vjBFyvl+Qlr0tFY8bzS/moH7IjELyuAic6npP/v0R4xrl
 z5bfrcTtwXtR6Ijv4sAQkzNFMAANz3os9xRiqlTe4a5hLDXLgjuBVLqB0Ab8fMvpzzhA
 tyEk1jXQ/6cWzRCkczqQH4NPCiQ/bmpoB3/IdOTbbsjV1OVnC9vIHiDc22CpBxg8WHdG
 5k8NKQcVKH6dc+nVvEtxU1IhiIgRHqx/G1TRwY0yRt7s/jQjfjp+6OTQ93qiyzpN889r
 +hVm0mHa9ztdSmOQPYtqQoWWnRF/V/+JrVHT6qCT9ESNhJbR4dm1veoCX/bWCAxP+0Of
 hRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eKmBegf8fZE2l/hyagB4w+ITWbNMFMbHGZPlbexBH4Q=;
 fh=XtBGW/VyvE63GThaZ7ifB4zEv4I6SKtzcqxYHMbJry4=;
 b=cANYwx2epBiITih3SHq1Uo4nWPiuoaqJUu6KOtDbZsWlwP8N4Efu0UUWF372SkjZWl
 5FsMpV4f43OTQkOs/cD8kXcpbVhK0L7segTrbDcwVVLyOcppp5ztUFoWqko3guE0DpRw
 cezSNPk6XPAjqdf2J1n4wIvqhPi+Mrl29CJECjfBCFUCqhhH0BW/EN00YvpDuQWdd6ds
 8qjTdMld5sGDM2rT1wQkh4FNn2REGfXkE2+n1LCJJ2bHDEyS1zs/UjDcmAUyRx/RZZqi
 myixsqT7m+XMEbvdKmXgIfGtxwAZn7rlN+PfAllkvy3UWorveQWBoQ5AR/Z5G+iOD/u/
 Zt7A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786979242; x=1787584042; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eKmBegf8fZE2l/hyagB4w+ITWbNMFMbHGZPlbexBH4Q=;
 b=HCX6S1HZxb16qeDghsRR+hm9765uNDLY2rAL4epw72IcWfPkxtJOs4NoA+pex3Lnfs
 skkgd9xqwcfYb33QlCpEBV8L19HXmbcmiqUORM//UMy+PQAS8KrxKaZjqtXpC5sbZJkm
 c9r3gbNVfZzVN2KNaBjCMEPyOPGPh3w4wWSbrGaHSEsaUnYRRco9zFPwfhZm7Avg29rd
 MPEUOZKg6DYpKwFI3fo+NeAVWsbWDOHlINau03VS+vZ5bh9ugEsmW1g3IYR4/Ubx7ohn
 HjpBPf3Tce7/7s0NAH1GfeI8Tqpd1PDGXZnT4JIBLGwlxOYhARh0lTMDF/FLb93S1rFn
 wAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786979242; x=1787584042;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eKmBegf8fZE2l/hyagB4w+ITWbNMFMbHGZPlbexBH4Q=;
 b=kftZjNfwuOuQ8jycFvAAzFMb9v674UmkR78YJes+gKz0TBvtoThAqN7OjpFHqdbAn5
 QMliWsLT42W7rfQBKRI+0zUWROURGodnLsQRzwhecgs9t6Z4jTGjiNJJYRAAQchcJLJO
 UREvm+4yPNn+QIFZhfLL1vJZwR93bEZaAYzgkpEhfb1137gU6EiS4tsbrbO6Q1n42pXg
 3+nfvhNstOO7VsE63bC3bgZi1naNVLscY/jBNHEUaUM0rmBlQ8nZp5kAxIcbcGDv5MZq
 BKFNKWwjs6/rtTGVfgK8BSe3PTr7aYcMaI8JBaDvpLAnFVkZ7zuxzqrKMeYYn+yUFove
 ZpmQ==
X-Gm-Message-State: AOJu0YyjEpUDW9mCvIwSnUTyaRkvLzNjT4+lchglsPOgXZrdNXja++Sr
 BUEKp9skYl5xZu06IiH0drVdw2kAr5pH0qOER1ar7FSIoY8vcpTvLYUZprC4pETReBGaJIyTVeD
 EI4sKUDh6eVOO8BPIBHiI38km+JXCIuahONV4Zngmmw==
X-Gm-Gg: AR+sD11mlMb6x0Vt3bM/emArKVabDFW5looLvgc9S19pcu6BlApsy9U9x023H9jLT4A
 I0990xnSRl+VDJhVui0+hYhoLIB2/rs8WnaqbMrJBe9dxnrD0BsOCNHG+MGEh1YOQQkLyOVzPvs
 OnhpMxAI83HZ/xMwAGU2nSZrZ58S4Frs2fb2Nvp9vN5cxgJCHRMhFwF/COCLDfZDVicbrRKi/gD
 j/CTSF22SltsU7b9AZf5qxQKspEBs9M/VD9CnhnDb+ghsCqgvBA7FU694LfKxDH91mu829kXL2O
 R58OaDR8Akmzi6hobJXf9Xd0rHtSsKfJVWq9nOUZ3ZrDM5bXfmaJep+7fGEAbT+CreFyMvvGPzg
 vbC06U6dPuRCa+0c8ZonHFiC1EnwU
X-Received: by 2002:a05:690c:c3a6:b0:833:968e:c223 with SMTP id
 00721157ae682-83710a93e86mr66950627b3.21.1786979241822; Mon, 17 Aug 2026
 08:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260812200308.289238-1-richard.henderson@linaro.org>
In-Reply-To: <20260812200308.289238-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Aug 2026 16:07:10 +0100
X-Gm-Features: AcwNN1Ul1ks14Qa_lI_pvTFwLCdvqe98gz4PU7VRwSOlajCMVOwYjhHhBJ-emCU
Message-ID: <CAFEAcA9wqo3tqC=GU2vmGJZowRfrLQZL=US+1vnf6pJsZ18DDg@mail.gmail.com>
Subject: Re: [PATCH] hw/intc: Fix arm kvm gicv3 selection
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Wed, 12 Aug 2026 at 21:03, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> While 39a8c3941e may have fixed WHPX, it certainly didn't help KVM:
>
>   $ QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/arm-cpu-features
>   ...
>   qemu-system-aarch64: unknown type 'kvm-arm-gicv3'
>
> That patch did remove a test for TARGET_AARCH64, which is fine because
> it has been a long time since we supported KVM for AArch32.
>
> Fixes: 39a8c3941e ("hw/intc/arm_gicv3: Fix ARM_GICV3 dependency for KVM / WHPX")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---



Applied to target-arm.next, thanks.

-- PMM

