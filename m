Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D269C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 04:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u363T-0004hE-F9; Fri, 11 Apr 2025 00:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u363R-0004gq-RR
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 00:31:49 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u363Q-0007WT-69
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 00:31:49 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-227b650504fso15128795ad.0
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 21:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744345907; x=1744950707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y4nGvPDfisSj/GZ4L69AKp/Fu/wL8ilfAEpfXHq2Joo=;
 b=aOkXwHu2ulXfTwwWilpv8B+UL2wZgxmu/BZTiwLltFJjSXDMqrE0/BhV2ptLGmBecu
 XCe8Eeq4zc4l/sFsW0vA32t/AJrruCX7ziVRFtjS26QtEziK/tf5VuF85AONlg0oJ3em
 voP6gEgPefpAOlDjjwr/vu0Kx5IaMlRG0HRs/7px1lVGCzIKNjEayJXGiTGv+1ci4yhH
 m7eWmKKhoH7riHR7/+HMu0Y7+ck0qyUMLDDg+Qw4xgBaTqBfjXn1FNUBoAj2GblgZtvY
 YjyMRBiYTm67CsR29pV7CA7K+5JIG/nD4sa/DGWGE65lijsVtg4Kmvk283s+Cb/p1+am
 SALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744345907; x=1744950707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y4nGvPDfisSj/GZ4L69AKp/Fu/wL8ilfAEpfXHq2Joo=;
 b=ka3NPBWkV4lbyMlhryp69F5X+s0ca9vCq8nPToTuEkc4GDEToQhy7Z3cwtjLsAlP0W
 Qswf1NDRjnWBEKIVxmLZp3ADTSljABwDxrYFRrrRzifqIJOx8UIhJfb5rlPHpq3qebw1
 cT4UyRQ8g4pu5RwPV8qkTo9Zq9luYhw4d4cQdN2KuwAIQIRGqfEF8sD3lgzTnyLs9M/3
 1gc+zVkZq+E0Q2SmZ1cVLW+vI0RY1ug+j+g1UJFkj0kUOZh0uyFiMcTz6xPAc5zIWrYO
 3uwIsucP+Wl2ZGgMjGflEiulORzLfumC/To8NkW7ES1nX73zlrvFI+fSJCio2GS3AmZn
 3iVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8uZhHJCkOzEQs+c04CShLbRjBKM+TzXKuC/v2M9v5c/V4rGzlQEfrizJC8AMTdDoQ5x02KwOTvHGM@nongnu.org
X-Gm-Message-State: AOJu0YxKeXI2Mc9aGNRVLUhCFK3JhTAFl6X+S1UvfGBp1PWbWsc/FXJv
 9YMJ3Sz7ESVxzGE6qAgqCY/Lj/xOfG3gsAKAbzWTp/oOEooRrrYE
X-Gm-Gg: ASbGnctmFM33mXNONRMy8NRxFnfp4ptMjqTGhrWnB+q4QitTsr90DluduLvut6ZRofj
 4bY5JWZKU5MeCoc9vBlOs65OADpWI0YGi9SeMiz9C5J9NAeZ8DaLM+6v/+aeSFb+GvJ5ZWtYJzk
 cxg98JpAUXk12UQRsMpoBN+laIVg7efPhufT27lRUQ1bJUJJUUwuIHpozG+fXtR9oFMLhwWN86x
 mPNEPE0+V6Rj1Mim9qU2Isu/l0rDLQNUcwP9GalVz9eRwLPL0AywhEPH/driTlelYfIYA2uWl8d
 7UD1afM5cR2qL4Z1R0KWL81b1xCrv+nMyBCbxXa2HqQO
X-Google-Smtp-Source: AGHT+IGf8u7tecFEIP2R8XxTn2lqoYtq4GnL9u3ix4pWfO6ecs95Uqzx+KX66d8y8673IJHrSDhZYQ==
X-Received: by 2002:a17:902:e788:b0:223:4c09:20b8 with SMTP id
 d9443c01a7336-22bea4f0043mr19086095ad.37.1744345906792; 
 Thu, 10 Apr 2025 21:31:46 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7b64906sm39361625ad.48.2025.04.10.21.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 21:31:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 2/8] net/e1000e: Permit disabling interrupt throttling
Date: Fri, 11 Apr 2025 14:31:22 +1000
Message-ID: <20250411043128.201289-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411043128.201289-1-npiggin@gmail.com>
References: <20250411043128.201289-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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


