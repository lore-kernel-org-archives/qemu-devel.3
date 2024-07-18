Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54664C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR3y-0000aJ-Ao; Thu, 18 Jul 2024 09:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3s-0008RV-13
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:46 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3p-0004Vg-Ms
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:43 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2eeb1051360so9682681fa.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308839; x=1721913639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=473+GlrFF1Yqb20TfeBPPe8vI6MkXX76Ali6gu23ymc=;
 b=BuXgPGCTjVv/fahBIoYaQc5bdECtg2qOTOrVDTSjqxqAkKzMoHIdp7y6mO3lDTNRyq
 wJLVWLNpShsjat3x95yzpRHHBebZV0WSSyZ0Jiz5GoHkyQQ3f6jbRC+IObGdlIZKqhFy
 YX430SP/eWirZoONcwJXQnJfJOowgYaIJGrQmJ7oX1XUCfqFJRovS3LEyBohXE4a4keG
 iEVc3NvHvbLOo2SxmWGr/ZdzMLnxnu9aunqZbnNapY7YbN6yr3Hg/6qhhlJ139MoFjv/
 M+qJtJwPmeTp9zi8q2CV9qdEgDPmveyr05y2pHyvRIZeHZxforle7P7NWzg+8zmdQrvT
 Tkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308839; x=1721913639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=473+GlrFF1Yqb20TfeBPPe8vI6MkXX76Ali6gu23ymc=;
 b=va0bRaUuOD3hqC1avRXeCwuYjhEuizVHmXTZtVuDpIJRAhAD0PhzG7GNlO2jxT+IfH
 +hS+6SxQl0GqE2xX0vldCs4VHb58BBoUl9FOIHzluWRIL1dobY+RVwZXNJhPOFrV88CG
 NxD7EtDd5eROS1m18GuSnnjewSEJTxbP5FYX0hp1nvnny8oZfWa7PaC782Uqo4Bwnm1B
 x+HZV4hJ0K+OK+lqHamxyj2snR9hezRL1FEP77P2mx5Np1jRUx0mij0XDUVOrQ53zIII
 2ZnYCyRnOZUpxrlyucaIz+UznHn3k/v8H0SpQF2L8NPDm4BSDyMnQ6KMyYPE8fdgtdLK
 I9kw==
X-Gm-Message-State: AOJu0YzSHvCTIabzRXeC4hnAhEGo87OBbXjandcB8Us4G6ChM38Btxb8
 1ZLwFFu6c0iIJTi2Erhrgf7nPQ0FOEEyDFO/Q7Aa/JW6GLwMWJBdpyEbN5SoqkCh3LSAkvocTAa
 O
X-Google-Smtp-Source: AGHT+IF2Ppsmubl2G4DlpEHnZ1veH8zF5WnDEU3bN+8QqWxpdig1hV8Q1pq+q74B6t1IDWiRmr02VA==
X-Received: by 2002:a2e:a212:0:b0:2ec:5c94:3d99 with SMTP id
 38308e7fff4ca-2ef05c4fb41mr16986391fa.2.1721308839602; 
 Thu, 18 Jul 2024 06:20:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/26] hw/arm/smmuv3: Handle translation faults according to
 SMMUPTWEventInfo
Date: Thu, 18 Jul 2024 14:20:21 +0100
Message-Id: <20240718132028.697927-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
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

From: Mostafa Saleh <smostafa@google.com>

Previously, to check if faults are enabled, it was sufficient to check
the current stage of translation and check the corresponding
record_faults flag.

However, with nesting, it is possible for stage-1 (nested) translation
to trigger a stage-2 fault, so we check SMMUPTWEventInfo as it would
have the correct stage set from the page table walk.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20240715084519.1189624-17-smostafa@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index a3cb30501e6..2d61637aed5 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -34,9 +34,10 @@
 #include "smmuv3-internal.h"
 #include "smmu-internal.h"
 
-#define PTW_RECORD_FAULT(cfg)   (((cfg)->stage == SMMU_STAGE_1) ? \
-                                 (cfg)->record_faults : \
-                                 (cfg)->s2cfg.record_faults)
+#define PTW_RECORD_FAULT(ptw_info, cfg) (((ptw_info).stage == SMMU_STAGE_1 && \
+                                        (cfg)->record_faults) || \
+                                        ((ptw_info).stage == SMMU_STAGE_2 && \
+                                        (cfg)->s2cfg.record_faults))
 
 /**
  * smmuv3_trigger_irq - pulse @irq if enabled and update
@@ -933,7 +934,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
             event->u.f_walk_eabt.addr2 = ptw_info.addr;
             break;
         case SMMU_PTW_ERR_TRANSLATION:
-            if (PTW_RECORD_FAULT(cfg)) {
+            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
                 event->type = SMMU_EVT_F_TRANSLATION;
                 event->u.f_translation.addr2 = ptw_info.addr;
                 event->u.f_translation.class = class;
@@ -941,7 +942,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
             }
             break;
         case SMMU_PTW_ERR_ADDR_SIZE:
-            if (PTW_RECORD_FAULT(cfg)) {
+            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
                 event->type = SMMU_EVT_F_ADDR_SIZE;
                 event->u.f_addr_size.addr2 = ptw_info.addr;
                 event->u.f_addr_size.class = class;
@@ -949,7 +950,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
             }
             break;
         case SMMU_PTW_ERR_ACCESS:
-            if (PTW_RECORD_FAULT(cfg)) {
+            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
                 event->type = SMMU_EVT_F_ACCESS;
                 event->u.f_access.addr2 = ptw_info.addr;
                 event->u.f_access.class = class;
@@ -957,7 +958,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
             }
             break;
         case SMMU_PTW_ERR_PERMISSION:
-            if (PTW_RECORD_FAULT(cfg)) {
+            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
                 event->type = SMMU_EVT_F_PERMISSION;
                 event->u.f_permission.addr2 = ptw_info.addr;
                 event->u.f_permission.class = class;
-- 
2.34.1


