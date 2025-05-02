Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB52C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAgu6-0003oP-1X; Thu, 01 May 2025 23:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAgu1-0003nz-6g
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:17:31 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAgtz-0003O1-F2
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:17:28 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so1544902b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155846; x=1746760646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y4nGvPDfisSj/GZ4L69AKp/Fu/wL8ilfAEpfXHq2Joo=;
 b=GJqPCAs0/k/3vs8BHfu0mIClZs/xl1fApf6kVkJJhBtagX+H757ltiIRk+5gua8ph7
 gGxach5JWWdoCNAZ9DqQzTBggxEamdvD6z1Th8MEvJ+J/Q3AT8+Z3i8mmITuVXPAnn5A
 nFcXSvGjE1Z0RwZRv/+2I1atBz/dUbQqDFdrTgbANzwIWY4gNkgC/TULrXVins2PbDxy
 CrgObjsa9aS39y+5Qq1erk6MgnLbPMGN5GebNowViPRMT4gO5FXUjIT5tCP3cSlnZKX7
 1MZc0I49IC74EcLD1ExAV9k8b0iYONECGzC8eKxAxTd9bV6ri3vm+0Au8PpSCfSSRFzf
 Xtow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155846; x=1746760646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y4nGvPDfisSj/GZ4L69AKp/Fu/wL8ilfAEpfXHq2Joo=;
 b=IJS80ky7RytfqyYm72znHzsdzWpUdkIbog2IaWEepD7ITJpuWwiKrzxPzSohjayUAQ
 0Qh7LU1LzoE1+h8KqsP2XU1yI3DQS/JAcHL75Z7XaDk2rRl7vYCNPXE0tlqQ40H9UglN
 ZqJPygoU2IxbOh0RT4Cd7rqKcV3je52X+6AL4od7Ivvy4n2jHtSKxAIOh9fUCDz9J02f
 5jiX6t2oDQzt+r3YuSVcMVgs4sTof5dkQXVfpfUNm7wUgymLR3MpFIs0flUy4/zr/+kK
 GsYz54h02CQUTSfMX4x2yAovvxqp3XgaS+rKcdTICJEj5Hbt1X59jadK0ozS1LLJqNdi
 EYpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0BEaLXtCOUXqJqtL0MuL1yjGlC1d5RcfQHPoCsXYYIS95XVw4UMnhVdz4dK8BlIwMeERJrM3B1tdj@nongnu.org
X-Gm-Message-State: AOJu0YxDL6U+fQmCQpB7l0d0NR70pqbGwaBZxrjRWGiNWC/nvpORJyIZ
 bxiWeMmpYzRozfhz52rOK1v4HmHc1CtxmE1nlrHFXaf+v2O069kb
X-Gm-Gg: ASbGncvh8Nb9MBPGxOcSwbmndH2EMgYknGGJT3QKgIHOkqF01N63IAhPmGMj/lVym91
 HwgWG5jVLZHD6D0lIQw1hsM+poS0SPBedw+Et2yQbb17bP9+5NZdRqNlcAeiNsRsemggajeMsuJ
 3Rl5o8RfS73k/Qzha0hng4+zy6kAWfX7M4K0+pvtVE5faOXZSWdKVHaaHCf3zfJ83UdP7fTJPTf
 Zzd3a4QfGSKQ5vF9Nb+iRJ5Dz/sCMAFfLtqXUGBPrEtZ+O0EimXDLRmG1NVww5D6nj1FN+7TE4n
 hAy1yqR73O/Aj0qG8mLVz/AELHgg3yq+qWEsyhztxmCB
X-Google-Smtp-Source: AGHT+IFLhUyUZYQWnAI5Yy4bIabVGxRfQm2aJUS9fsGLvfXolpoU3A9FqLfoHdqa54XcrSUt5SUdjQ==
X-Received: by 2002:a05:6a00:ad8f:b0:736:65c9:9187 with SMTP id
 d2e1a72fcca58-74058a210e8mr1492473b3a.9.1746155845779; 
 Thu, 01 May 2025 20:17:25 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058ded48fsm467883b3a.83.2025.05.01.20.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:17:25 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 02/12] net/e1000e: Permit disabling interrupt throttling
Date: Fri,  2 May 2025 13:16:54 +1000
Message-ID: <20250502031705.100768-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502031705.100768-1-npiggin@gmail.com>
References: <20250502031705.100768-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

The spec explicitly permits xITR register interval field to have a value
of zero to disable throttling. The e1000e model already allows for this
in the throttling logic, so remove the minimum value for the register.

The spec appears to say there is a maximum observable interrupt rate
when throttling is enabled, regardless of ITR value, so throttle timer
calculation is clamped to that minimum value.

EITR registers default to 0, as specified in spec 7.4.4.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/net/e1000e_core.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 24138587905..96f74f1ea14 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -51,8 +51,17 @@
 
 #include "trace.h"
 
-/* No more then 7813 interrupts per second according to spec 10.2.4.2 */
-#define E1000E_MIN_XITR     (500)
+/*
+ * A suggested range for ITR is 651-5580, according to spec 10.2.4.2, but
+ * QEMU has traditionally set 500 here.
+ */
+#define E1000E_DEFAULT_ITR (500)
+
+/*
+ * spec 7.4.4 ITR rules says the maximum observable interrupt rate from the
+ * adapter should not exceed 7813/s (corresponding to 500).
+ */
+#define E1000E_EFFECTIVE_MIN_XITR (500)
 
 #define E1000E_MAX_TX_FRAGS (64)
 
@@ -105,8 +114,9 @@ e1000e_lower_legacy_irq(E1000ECore *core)
 static inline void
 e1000e_intrmgr_rearm_timer(E1000IntrDelayTimer *timer)
 {
-    int64_t delay_ns = (int64_t) timer->core->mac[timer->delay_reg] *
-                                 timer->delay_resolution_ns;
+    uint32_t delay = MAX(timer->core->mac[timer->delay_reg],
+                         E1000E_EFFECTIVE_MIN_XITR);
+    int64_t delay_ns = (int64_t)delay * timer->delay_resolution_ns;
 
     trace_e1000e_irq_rearm_timer(timer->delay_reg << 2, delay_ns);
 
@@ -2783,7 +2793,7 @@ e1000e_set_itr(E1000ECore *core, int index, uint32_t val)
     trace_e1000e_irq_itr_set(val);
 
     core->itr_guest_value = interval;
-    core->mac[index] = MAX(interval, E1000E_MIN_XITR);
+    core->mac[index] = interval;
 }
 
 static void
@@ -2795,7 +2805,7 @@ e1000e_set_eitr(E1000ECore *core, int index, uint32_t val)
     trace_e1000e_irq_eitr_set(eitr_num, val);
 
     core->eitr_guest_value[eitr_num] = interval;
-    core->mac[index] = MAX(interval, E1000E_MIN_XITR);
+    core->mac[index] = interval;
 }
 
 static void
@@ -3444,8 +3454,7 @@ static const uint32_t e1000e_mac_reg_init[] = {
     [FACTPS]        = E1000_FACTPS_LAN0_ON | 0x20000000,
     [SWSM]          = 1,
     [RXCSUM]        = E1000_RXCSUM_IPOFLD | E1000_RXCSUM_TUOFLD,
-    [ITR]           = E1000E_MIN_XITR,
-    [EITR...EITR + E1000E_MSIX_VEC_NUM - 1] = E1000E_MIN_XITR,
+    [ITR]           = E1000E_DEFAULT_ITR,
 };
 
 static void e1000e_reset(E1000ECore *core, bool sw)
-- 
2.47.1


