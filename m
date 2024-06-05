Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96731C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 14:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sErr1-0000z8-TL; Wed, 05 Jun 2024 10:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sErr0-0000yP-1l; Wed, 05 Jun 2024 10:43:06 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sErqy-0004PQ-DI; Wed, 05 Jun 2024 10:43:05 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52b7e693b8aso966535e87.1; 
 Wed, 05 Jun 2024 07:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717598582; x=1718203382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NuM0SJHpvaHcxy+iXNZ7kDqCop25Iq6ak8eZqMlRros=;
 b=PNMW5L+QVmi8SbuH5avCcOOE+lY5CmNkUzQwqDhZNdTYFbSPXBLGbYldVZlYZM9zPX
 jDIExcuOFzMrLW1JIcT7iN30KbKiKuWmMsavbmZV7K2h+jmNZjiv0gTgCvG105cJo9VF
 uZeXSAzkvzyorYs2kk0Y5L/+Lz7Cy0Enfpe1a7K2JiAKzIon9K27D2wNShTjTRTz74Vc
 EYFd/ZTq1lf0E35EoNRkzDrgFOgItMdFyNFQ1/aSHjVKZQUcS1HnvBxkSM7/Z3MVis7U
 H1HnBcRFLkES9CPWP825R7DNyxTQdl115LtYerkOfbfLo69iWEDF0TwXGwFMTmzspOTg
 /nqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717598582; x=1718203382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NuM0SJHpvaHcxy+iXNZ7kDqCop25Iq6ak8eZqMlRros=;
 b=sOJLAS6wvB4mvvsY4J0Bbjed1I1BMGK0DR43JvwgcBKmk1qI6MjpSQB7mRacEndCLr
 6/c3BY8W+/H1aXGNdzrbdJrsaBU2JfESq7dQaqfmqxeBgemdMCb3Hl8btprK0lkFnvfo
 hEu8ukGSs74pcQ7M6vjgqmBPrdO5uD9faghJ5kN5VQt84f4LdxO8MOXhiUAftKASAGtR
 Zp3q5Adln+oapz1qapD9UWqyjDnAz8TcadVVE1RItGe425WJ0+EamMUe9UmEYXVJdHLm
 cYMatPeKMQt1Iq6NUkABQfI3DtOVTlUiCG7pFnVH1C0UKPkeThXFIl83cPsSP24ObkM1
 vn0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlyLOsSajLdnAQ6KAqup4yCFZEJbX1OT4y1pB5kQp33KG9/zZi4qkCOpd+WbbCUKKt41iBSXpDK2LkBQQgpDkTIZseI9XBJVPGJ2qI3GwnUl40kBBCPBv6eKE=
X-Gm-Message-State: AOJu0Yw9K2y1p59jYWivdarn66WVmOeZri3Yf+AtK8JjteWV0IR+okxZ
 wAZ9Q7RR3yVTJWb+KAAGZbFN08ROe9DS8GB6+RRk+I9ffBkAnsld
X-Google-Smtp-Source: AGHT+IFKACU/iZUjt+cBpfC2tegLARrL5dIeVRrY5MEbz6/2owAUe+mroZH27+ihRl5hrWM2TOKb4Q==
X-Received: by 2002:ac2:5196:0:b0:52b:825a:d627 with SMTP id
 2adb3069b0e04-52ba22406aamr1692249e87.2.1717598581617; 
 Wed, 05 Jun 2024 07:43:01 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52b84d3f4f7sm1800353e87.89.2024.06.05.07.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 07:43:00 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: sstabellini@kernel.org, julien@xen.org, bertrand.marquis@arm.com,
 edgar.iglesias@amd.com
Subject: [PATCH v1 0/1] hw/intc/arm_gic: Fix deactivation of SPI lines
Date: Wed,  5 Jun 2024 16:30:43 +0200
Message-Id: <20240605143044.2029444-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Julien reported that he has seen strange behaviour when running
Xen on QEMU using GICv2. When Xen migrates a guest's vCPU to
another pCPU while the vCPU is handling an interrupt the guest
is unable to properly deactivate interrupts.

It sounds like something rare but in some setups it actually
happens all the time.

Looking at it a little closer, our GICv2 model treats
deactivation of SPI lines as if they were PPI's, i.e banked per
CPU core. The state for active interrupts should only be banked
for PPI lines, not for SPI lines.

When deactivating SPI lines, I think we need to handle the state
as unbanked, similar to how we handle writes to GICD_ICACTIVER.

This fixes the problem on my side.

Cheers,
Edgar


Edgar E. Iglesias (1):
  hw/intc/arm_gic: Fix deactivation of SPI lines

 hw/intc/gic_internal.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)


base-commit: d16cab541ab9217977e2a39abf3d79f914146741
-- 
2.40.1


