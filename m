Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806EAC48260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz44-0002x6-T7; Mon, 19 Feb 2024 03:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz43-0002uL-LR; Mon, 19 Feb 2024 03:31:51 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz3o-0002NR-KK; Mon, 19 Feb 2024 03:31:51 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1db5212e2f6so28788975ad.1; 
 Mon, 19 Feb 2024 00:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331494; x=1708936294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZX8n0tNdAmuLPTHJh8fiQt/+xqsTkEf/Jf+VNbC4LxM=;
 b=GoDnr7VP0iWaEuk7QEdA6zbMr6wj6sGD4zXrbJlxBxWEDZ0kw8lNHn+f5YaqSNEab3
 nT6f5mwPNM2gm1h81xyNR2gMa9kJAU1thEnOjV470XEM5sjNZkFW/jo4rLwLdr6ngT7m
 Epl8aemcYMKGebNkLduR5oFvElKQu0tNuugDvLVyuG/1vgyPPOkpEmhZghzXy35nJQ5x
 IhlzFzS3JPNsfu/zpecNboaniNIc4gSIBE/j2QSOtmpGMePk4AhW0s2647GSpfpMD1GK
 d3FN5kdqEGYPt88hcz6Ug2b2GF4mFWoZclkGk8DIB12DVPCktAgQS1dnMriS7cC3P4db
 YxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331494; x=1708936294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZX8n0tNdAmuLPTHJh8fiQt/+xqsTkEf/Jf+VNbC4LxM=;
 b=g7eF6dkRL/fI7WAd3qB9yCg6JBek8xOXLIhjbdGC5qgewFjxpEgrDIaUwzGl+qAUMz
 Lk8sTTOkeHIv5JDi/0PwYytyOqnksrUyynitSQb98xZ6pSK48BSeAJO2IcRKwz5ZGzEb
 TRL1he7j45suxHmnGMZ/LQtGyX+SwAxgZFAmR5Lyxex1FpiP6bMPBpdLPYkEBLZFjirC
 NhdiX8aQFe7pEDEztL4rldFkkkp0cpdPQBgcvexZQUvfPDi378ABLUz3sLBN/VjDNmm8
 GKU4klxucCUYd+AFhwCvplHDvLtVml/an9JQOEDuPJ1Qzcwc5PaEt3C8v+U5As5Hb4+Y
 ZLug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdxV28iUmEkkrh4Ry4I8aGPOVZLlwq7oKUnePUueOhnbx6UFQ+WogGy7lvDeJ2rj2WEzGTEw+xJ5v8CZsnAKLj0kYl
X-Gm-Message-State: AOJu0YwqhyjPF/uIOfS+WP9e1hzGieiWQgAJ1P9XU0JfT2lf1GKC35we
 iYVA7x+GcjFPDUqIMLP+6+mUXnVc6bXasahE5SBTqFO+AkoeA1e9v7h/uOIY
X-Google-Smtp-Source: AGHT+IHhG4w6wtSICGk2xBFznHuo9IcZb+O5mrFh30CMfljz2xslfq8ER8szmeRJxw3b7x1K8u6zJg==
X-Received: by 2002:a17:902:ecd2:b0:1dc:26f:813a with SMTP id
 a18-20020a170902ecd200b001dc026f813amr961031plh.6.1708331494573; 
 Mon, 19 Feb 2024 00:31:34 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:31:34 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 21/49] ppc/pnv: Change powernv default to powernv10
Date: Mon, 19 Feb 2024 18:29:10 +1000
Message-ID: <20240219082938.238302-22-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

POWER10 is the latest IBM Power machine. Although it is not offered in
"OPAL mode" (i.e., powernv configuration), so there is a case that it
should remain at powernv9, most of the development work is going into
powernv10 at the moment.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0297871bdd..b949398689 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2242,8 +2242,6 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
 
     xfc->match_nvt = pnv_match_nvt;
 
-    mc->alias = "powernv";
-
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
     pmc->dt_power_mgt = pnv_dt_power_mgt;
@@ -2267,6 +2265,8 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
     compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
 
+    mc->alias = "powernv";
+
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
     pmc->dt_power_mgt = pnv_dt_power_mgt;
-- 
2.42.0


