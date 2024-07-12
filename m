Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD406C3DA4B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSF0C-00063k-Bi; Fri, 12 Jul 2024 08:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSEzX-0003yf-WD; Fri, 12 Jul 2024 08:03:18 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSEzV-0005XT-41; Fri, 12 Jul 2024 08:03:11 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70b12572bd8so1634210b3a.2; 
 Fri, 12 Jul 2024 05:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720785785; x=1721390585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0DgZsKqI5Qui8xJrG3nYJqRYaaUiPlIWM1v7RfXcJUQ=;
 b=kPf1moXPF/Sb0aJ9RGI8GGJHQaIyn1+zfzZpNNGwFY5lop6x5JawS6GrgM1/V6AFqC
 RZvmvmYsKtNqire1tjzsFE5Ko0ZlqI4SLSLuG6RaDL8PHto4IGBv6RHLBbB941TBz0lL
 PZ8ufGpMu7J0n//34DvdNXh0aeMnrU1Nwp7AeEQn/8LPvsa47um+VguEV2PUwFNAPttO
 qtvYAiDC/W3rlUpA2C3KzZf+eoLcKh6inrfxgYwj2fJUtURUUFHNsxhOariKoKKmrOlm
 HG60zYBg1JlCpmH/tAoQiNN3AZdHmLza0C1RPWPJqKsFl/ZDRvcxeXyTDRdmChO9HT0F
 HKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720785785; x=1721390585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0DgZsKqI5Qui8xJrG3nYJqRYaaUiPlIWM1v7RfXcJUQ=;
 b=lcxZW42ejIksWecme3MbgsuZZnWHLGYFSQuX9Q2bxeAUgvY24yqnH/ZYeMIaH5hI4X
 AWL2GTFEXC2+GWGoYR0gKE3Ka9BEe51PBavBmYlwHyKLFCuc0yi2mhW/nPQfPOP/ak+T
 9Nvk2bsHLAbM9qeceiyOkw0h3XIwWsmEdWVR9+vZqdAeHsPQ2ixnIDKmPhQWwtWPYwEN
 NkzS1Hb/BKMQngwcUBIAM+zm/S47VWJHh90njNmuysL8aa4PfrcgL7Nvf+pmXBDS4iZx
 T1jLZe0dxVTDTXfzaD83mo3QTRueVyAMOEFigIPR/Ojt+VVpwkNo8sZF+jUr+n+Wp7ua
 5lTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/2E+sIIEw+lwoo98ZJhc1RdJBzddfGQP9oU3LXBFaWBoAgGh5mRUXKW47qUXRevxJDAOXyQUC4QO60gh68WPJRL3ZEeA=
X-Gm-Message-State: AOJu0YyRPjKZioeBNeI3pYspXxOiyiP/tV/vg8pnhbqecFgVbL+aYq4F
 uIfCFR3Dp3/53tcqtroN7H2VD/KqIvMwf5/PwFHMa/26MVWLLUbtoxDviQ==
X-Google-Smtp-Source: AGHT+IGI3nnvb3EbXrNLpWQRoWYbQEL+ranD1mZKz4/grlMRKbZGaFWg5KnmRzpzNc/vqUn/g1gwmA==
X-Received: by 2002:a05:6a00:b45:b0:705:a450:a9a2 with SMTP id
 d2e1a72fcca58-70b435561ebmr13471753b3a.13.1720785784997; 
 Fri, 12 Jul 2024 05:03:04 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438c0a1csm7308967b3a.63.2024.07.12.05.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 05:03:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 02/19] ppc/pnv: Add pointer from PnvCPUState to PnvCore
Date: Fri, 12 Jul 2024 22:02:29 +1000
Message-ID: <20240712120247.477133-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240712120247.477133-1-npiggin@gmail.com>
References: <20240712120247.477133-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

This helps move core state from CPU to core structures.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv_core.h | 1 +
 hw/ppc/pnv_core.c         | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index c6d62fd145..29cab9dfd9 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -54,6 +54,7 @@ struct PnvCoreClass {
 #define PNV_CORE_TYPE_NAME(cpu_model) cpu_model PNV_CORE_TYPE_SUFFIX
 
 typedef struct PnvCPUState {
+    PnvCore *pnv_core;
     Object *intc;
 } PnvCPUState;
 
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index f40ab721d6..2da271ffb6 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -278,6 +278,7 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
     pc->threads = g_new(PowerPCCPU *, cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
         PowerPCCPU *cpu;
+        PnvCPUState *pnv_cpu;
 
         obj = object_new(typename);
         cpu = POWERPC_CPU(obj);
@@ -288,6 +289,8 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
         object_property_add_child(OBJECT(pc), name, obj);
 
         cpu->machine_data = g_new0(PnvCPUState, 1);
+        pnv_cpu = pnv_cpu_state(cpu);
+        pnv_cpu->pnv_core = pc;
 
         object_unref(obj);
     }
-- 
2.45.1


