Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05EAC83F0F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 16:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYoRf-0002yK-1m; Mon, 07 Jul 2025 12:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uYoQF-00018V-C5
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 12:10:30 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uYoQB-00012I-GR
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 12:10:26 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-453398e90e9so22718775e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 09:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751904620; x=1752509420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mvlKn9k7rYCTQr3+QZYoxhTIVmuma8T4y8kkwY1v1WM=;
 b=svIk2yVACGHU/KAG2WmUZvwcfrnaELyrMbj1UeAThUje/EXtpUmRW2Kx9YeqHKx5pu
 qjnaKbpVZFCOXD6TQQ1adqC3QIEZdm98eV+KlP1fqlQoDsaJ2nJyphbCpoAFTl/BD4vf
 h8jeZkiFaG+kgbhWbwNiXVl1agJ6djKbI2oL711WxQdGrZ/Ii4P8Ub65rf8vA77+n6ZN
 57VWSO7JojTr0S9oUSOJOrcmLxqvlfACRXAOuqGCFbELK55ZQ6Ocx2XCwpCbLZ2cv7iN
 4Lc3k7t2s6GVZkNM/kxsBaQJyCiEiW28wIA3QpheI9tZckyl0lj/P8Py9wfg7EUp9yI4
 OQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751904620; x=1752509420;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mvlKn9k7rYCTQr3+QZYoxhTIVmuma8T4y8kkwY1v1WM=;
 b=mDdfjN9jKPDrMlHgZ69AHOaymA0HuEXe/tRbdE9vlP6n8PHwK8pEqUN1CloBvsr1C5
 MnwI94/4vfnx+79mjv1QipTJ82gyovJOOcDRorwTURN7TtmJbAo5at9xYstuRPRg3j/9
 TNEhAq1EpHxpJMKsnCN/DXFfhf4c7Z/0H73KT57VBlRLryDeSPW05TAmFo9xNV2wgiA/
 eV7OZruOKZQcB8g6CUxh2yFMfdxLM2cC4QvmnCh1FORsHIX6z+Pa507hepe7zvBG7X+R
 eV/LRHJudiZ8w2S9Sa2hF3mSaMHwl66efELywqC//UZzF43q0YjJKdNjlchnKHDbaDYM
 UGrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgUZ4WuQzA+D1zt8UOpQKF4DpSfTt/2S2+jY2Rg9wof1b375V/SM7cI7Ruq13DnvtftCgEjaab+U/J@nongnu.org
X-Gm-Message-State: AOJu0YwxZ96K44XFQu3XQy8Kv/TbcQEfamsp+rG6skMg42N0Tr12mqaD
 bRT/LnlzYD1im5SVzt+1+l4ntGUr9Zbz+pb/ZAObzwZeclx7mcqsEw8hwWyTc0JlVZA=
X-Gm-Gg: ASbGncsDujVXBAWYxkXYDCQ9Q4k4S/dpAhZq9cQxuFZcYqJImmvdq1VCFaOZumchlNs
 OHIV/1FemqjRbPuHbVhbppAxYxLfxjVbFj2zPUYQOC0GHMuApFINGpRQr0ihz7EUUMCmkUxgHzx
 Ad1NAqasMGJATTsU+MM3mM3YMEr118OEr7uNMeslZ2v3QOHWaOsyo04ny9RTBUtokkl/82uM/zY
 h1AIbywVqXCwISR5WjJxLhwNe3FynDbAvd+SFeYGufDtbMeAR3O4AvuOK2UulbJ8SNh3S/CIR6l
 z1qohYRu2FhVkQGx9VX6izXiI8+LlDnw27FNgd7iohORNMRvk8nHqEiArIIVBK9jebtq
X-Google-Smtp-Source: AGHT+IE/fcTwqdzEZEQOM3+7GzY86j8aNDZJsfw2xKahUjBShmo9nVTj1kgZsgFVx5j4b21LOJCoew==
X-Received: by 2002:a05:6000:4012:b0:3a4:f6b7:8b07 with SMTP id
 ffacd0b85a97d-3b4964ea37bmr11117399f8f.48.1751904620147; 
 Mon, 07 Jul 2025 09:10:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b4708d0aebsm10842820f8f.37.2025.07.07.09.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 09:10:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 0/2] hw/intc: handle GICD_TYPER2 for KVM GICv3
Date: Mon,  7 Jul 2025 17:10:15 +0100
Message-ID: <20250707161018.585469-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

The GICD_TYPER2 GICv3 distributor register is one that is added
for GICv4.1; previously this was architected as a RES0 location.
Our TCG GIC doesn't implement GICv4.1, but for KVM the kernel
might support it.

This patchset:
 * makes GICD_TYPER0 reads not trigger a bad-read trace
   event on the TCG GICv3, for the benefit of GICv4.1-aware
   guest code
 * migrates the GICD_TYPER2 register value on a KVM GIC,
   so that a mismatch between source and destination
   can be caught by the destination kernel

Note that I have only very lightly tested this, on a
host which (I believe) doesn't have a GICv4.1.

thanks
-- PMM

Peter Maydell (2):
  hw/intc/arm_gicv3_dist: Implement GICD_TYPER2 as 0
  hw/intc/arm_gicv3_kvm: Migrate GICD_TYPER2

 hw/intc/gicv3_internal.h           |  1 +
 include/hw/intc/arm_gicv3_common.h |  6 ++++++
 hw/intc/arm_gicv3_common.c         | 24 ++++++++++++++++++++++++
 hw/intc/arm_gicv3_dist.c           |  9 +++++++++
 hw/intc/arm_gicv3_kvm.c            |  6 ++++++
 5 files changed, 46 insertions(+)

-- 
2.43.0


