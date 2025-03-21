Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E91C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 06:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvVr2-0002d2-FB; Fri, 21 Mar 2025 02:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVoq-0008Uu-Rl; Fri, 21 Mar 2025 02:25:28 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVoZ-00033Q-5y; Fri, 21 Mar 2025 02:25:10 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-225d66a4839so43025535ad.1; 
 Thu, 20 Mar 2025 23:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742538299; x=1743143099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQz0IzfTSBf1SfVI6stCuKzL/l4PXUG7VWLq5owfvNU=;
 b=BxghPGQSeskOj1I8Ua/arAYSKgR4cGF66kfmE9QhA0sr0w7PKYBV6yMbt+BqFgof56
 ZdZfabVqZvPisDwwTnS0useZJBSV2zgS8pKmCaw5ZqqH0zBuv/XBxr2Krs5xSFbZ0bhr
 gBmdP+GMrgUHZQwBwCLsorDKWSBfZ0/ordcSx67Twpm5xSKnD67S2TnOdIJb9rTDmN/+
 +Blj/1v/x6gsd5xBkakuIj6mIULA0l1nELlCRuXVhYcaUMWo4+AdytSEd5MZwjxEgqMU
 xq40g7SQJjK+Tp1eM8HrvsSB1/5ddVLsniTOQlAGR+7H56+oQGMP0v3XeYBbOwjICEE/
 PVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742538299; x=1743143099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IQz0IzfTSBf1SfVI6stCuKzL/l4PXUG7VWLq5owfvNU=;
 b=lUPWl4OaeqE0XQ0gr8tOet+8lw9xEzdzaGFpqYVwCig8Gs2tZbanbSRA2Sbmx7rTAP
 htivIUdaaWB9KqreKNkmEeiO5C3Eg7o1BbyOp25Ajiep1nbwjoG5DQGNT2h3TXIauv/3
 nqXl/azEu7qPVtRvhzh5/+VTRIGOCjjtrwAVCDb8gJCGxznKOtbMUHEwJfHCaHnt9Zvq
 JVIqD4TYXiyQtnN/tYmkr8r6BWRL7sdiyb32IChQrRQH60s0+GJTgl0tM2kVWdan2Y7A
 7GHMvNKrRr81ZWTcmJ8HWu4bLscQLGxeiUOM7AgCs1hL0vIWSpzThPojTUgmik5ewru7
 ZXBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF+GUMqiSBVxES6w9dg/mDYaFMJywzJ7Cmr5xB29cgZz+vIK/67RhEjdVUeZY8tTJ7BiTAvdhWw43EmhM=@nongnu.org,
 AJvYcCWvwPmCQy47mQXz+JFPLuhsCQaqC4w8gFCpSK2KDstfmWwZAXdfxXjqpOC6W8X4cGE0ZZbasIbgxw==@nongnu.org
X-Gm-Message-State: AOJu0YzlpkHO6Df/bXoE5tUxQ99mGckO78awOVFKcAJuZ0AzbJMqK8tB
 /0yat+gpKyP7uoFNaRN6tC2x1Mw2ACWK8Nny2NEI4f3Zvv3YPMEt8MAIEQ==
X-Gm-Gg: ASbGncsGBActnLqnTKRN//AFlz1y9WCXQ56We7vZjU6MbXo0TjXgTSLH6ClrDw5LlFh
 UVZOkNBiBS2hNpCgnzkHrWU87drwzSFoMW/vjAd+NnE2g5auSCs3ePNrL45hFOqeDrTnT6PTd2X
 VDKZ/dQ9K9lcUq1RrfowLRYvLrJTK7Hf7r1OIro1b9ZxKsZ5H5J1C+fP3OOPDvEBLdC0kVKayLF
 egHkZN29rE7eXVjsCZ2gYrDBO0OidW3payf0IGGjPtb0SwIALzDhlL1fmujgrv5FqgsX/sWs7rV
 OpxVoBa9laR1UkFgRHPt9dMyRwUoyVsAcMKoae1AuSBzdCXdyg==
X-Google-Smtp-Source: AGHT+IFBKszsiRLcCSTKnAe2L0Ejmbm9N2O2N/APTy53HBC3EIuf0PeIFteHj7DFu1OHKJM7tNEpBQ==
X-Received: by 2002:a05:6a20:c886:b0:1db:822f:36d8 with SMTP id
 adf61e73a8af0-1fe42770d03mr4292260637.3.1742538298915; 
 Thu, 20 Mar 2025 23:24:58 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a2a4761fsm941381a12.65.2025.03.20.23.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 23:24:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/12] ppc/spapr: fix default cpu for pre-9.0 machines.
Date: Fri, 21 Mar 2025 16:24:14 +1000
Message-ID: <20250321062421.116129-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321062421.116129-1-npiggin@gmail.com>
References: <20250321062421.116129-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

When POWER10 CPU was made as default, we missed keeping POWER9 as
default for older pseries releases (pre-9.0) at that time.
This caused breakge in default cpu evaluation for older pseries
machines and hence this fix.

Fixes: 51113013f3 ("ppc/spapr: change pseries machine default to POWER10 CPU")
Cc: qemu-stable@nongnu.org
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250313094705.2361997-1-harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9865d7147f..b0a0f8c689 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4816,6 +4816,7 @@ static void spapr_machine_8_2_class_options(MachineClass *mc)
 {
     spapr_machine_9_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_8_2, hw_compat_8_2_len);
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");
 }
 
 DEFINE_SPAPR_MACHINE(8, 2);
-- 
2.47.1


