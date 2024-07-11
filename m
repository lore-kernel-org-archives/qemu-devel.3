Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73445C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRudh-00030j-Ag; Thu, 11 Jul 2024 10:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRudf-0002ss-4z; Thu, 11 Jul 2024 10:19:15 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRudd-0005Rd-Jb; Thu, 11 Jul 2024 10:19:14 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70b6003c3d2so633769b3a.0; 
 Thu, 11 Jul 2024 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720707550; x=1721312350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0DgZsKqI5Qui8xJrG3nYJqRYaaUiPlIWM1v7RfXcJUQ=;
 b=HzUBqwLPr9vArabkZWIizULY7uwz/vFZFgQRhL1a/ULPwF8MMmLRqMsrCz/9Xx+q8l
 tXUl4UxjJPD15q/4lBqYJpEzSiJ4STezkpNaCC5Z9Z9dROv2b5LuoXUUUJEGU2+Mb6wZ
 ibxnewmpoHLmjoD3CxoiDvtLTcGdSXTqNUUZBWo6qmhOWZs6KMwqs24B6WZSi3Muq0nZ
 jPTLbMGs3SLr22/ASjY5cze0C2K9/RwvblgLdvN42zTYcCIhvLRy8D5SVKbKFL/sB/N7
 gcBZE8qI3dYooUXrHrS+pagPXsy66ClEI7XQqn5yc6G9GxCJQ3+K4isSJqEnfqV+znW2
 pEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720707550; x=1721312350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0DgZsKqI5Qui8xJrG3nYJqRYaaUiPlIWM1v7RfXcJUQ=;
 b=MSf5pjbyyPRMlRfwUyQh/zMFQFP/xhU3YVliDkwdWL6GA3f9dgrT5PXDq7b017A1MF
 g4JDR4TwIKNhGk2sFkvYOAVANtz6DA5ys5ESQisWG7u8O/jzoOWSQET57lz9FFCOC+MP
 6YNNGfL1I93ucT0/tBJSWkGWtGKEZR4hl6wXCOm+yorGIu/zTJNpoRnUMeoU4GeyRcQ2
 +5hh/DTVKWbm6GzRPxrMhNTa66yQzjveeC/kL5v8KRCvY2o+wDklwsJeA99MsJYbWGKK
 OqZPasmn0Pc51R078/haKsy1k/8CoPp2HSphWTzeK8bUqdWLZgPnINQn/BVT5HQSrSl/
 Pc3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV0IyUMSh1DVCaBl8fC7FiYKeKobq8ud1qaL2TrhEo9/2wXOF2+HRPaox3eD21vWqrQDSXn1X8mfBP/BLBEE7uWBYeq2A=
X-Gm-Message-State: AOJu0YzBmo1q4fuGT9zD+mwasyPsMBmxqyaDEX4r1gl7tL9Uu9Qm96oT
 ULV8ax+up3DlaVLibKm7iTshVm8/z5PtyY/6iVFejDjIfaNwX6R1y4Bo4L3j
X-Google-Smtp-Source: AGHT+IEklDeaqTNY8/incWvI8MIqhlhhVgYrQDVIMhozgbGm3pC2G7+pFNCAW/iJDtJAJ3zCpdRmiQ==
X-Received: by 2002:a05:6a00:1ca2:b0:70b:17df:cbc1 with SMTP id
 d2e1a72fcca58-70b4361b82amr9217369b3a.30.1720707549695; 
 Thu, 11 Jul 2024 07:19:09 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b54ec730fsm3308904b3a.173.2024.07.11.07.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 07:19:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 02/18] ppc/pnv: Add pointer from PnvCPUState to PnvCore
Date: Fri, 12 Jul 2024 00:18:34 +1000
Message-ID: <20240711141851.406677-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240711141851.406677-1-npiggin@gmail.com>
References: <20240711141851.406677-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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


