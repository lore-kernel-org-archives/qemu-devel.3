Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EF4FCB613
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWes-0004AJ-0Q; Fri, 06 Mar 2026 10:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWeq-00047h-BU
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:04 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWeo-0002Ro-7v
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:03 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-483a233819aso92167725e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809201; x=1773414001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p/30OD+loiPG0qPDuukguw9ZSBdl4fxTm3168Zop0uI=;
 b=eBjs/6OngDpF0rSulXPHpPpVrYldpUivY87hGfqvjDCLrXpu+MuK9mMW73yCH4CVfm
 Tsic14ENtz2sBkTj9Cf5MWPf/f2DWXiJjGhbOvzEGDW+xJkM7/onyt4WOw7n72ZmnPob
 ox6BIM0lHvur4q4UH94ZwliXKPZi9UihLKY6WpaBBRQaYFgTsYS1c8qz0u0woFT7bOHG
 kelXrAqyO0txVE0EP771fQU1wr5DnlouwOEgPjbkdYu+oHWxgZFf05l8bPQbJg6WrmAp
 z5NIwqAhNGeRlpQDemyR96lMfQNo8PJOsO9SHl7/SWiXETZpHwJBgo9UYGw+IYl06Qbt
 meFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809201; x=1773414001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p/30OD+loiPG0qPDuukguw9ZSBdl4fxTm3168Zop0uI=;
 b=QIrLJw2SjvCA1ukzZ10KWnTams0WSvvvnZqFLbvXZe4T/kyJS8PSWe5LdOMwYjXGG3
 mk9ektY7UfuVJ70U3o4zPEfOCg5RCYwR4NMTujC6IJK4AON67SLXydFIXmdcLtBC6NlW
 5f3337yQpzHrkZUj9YmEfguOPzq8Lx9PYRaE9XZSys20r+VzMuha9stEQjGJrnhen4Nb
 whPWx7Gz9o3MFH9hYE+bFXI1GgQTvWQ4u3BtU7enrG3563IxBAHuexIjWCHXMrEy/5lu
 uy5Tm3Ai46yaoJcOIR9sRQWFWTr5Gj7M1mBHjvO5FhImk4QeeCm86NWNnIRfxs7ODkkM
 5NQw==
X-Gm-Message-State: AOJu0YwcYWkhyqzar/qpI9tLW1feRTXOrfbK9znR0U05t5VtyoVEeVvE
 7pM3LaHICUAZ+4z9Y2rG+r5CqhpFVJuuWpjjvVBpqak9DxVJ9ePEz+GTZtaV+HbHBLloIUswSFF
 FRZlR
X-Gm-Gg: ATEYQzy0uYHPRelfDU9ocrll+PXquRkXheRDoVx91tXjMr/pfxo1bt12/2eZYzZQIuM
 NAH7iOBf53kAsehnUcdUVony+IoiQ2IiUvf8r5hsGAYTeawSKuEKc0UsIp4fGWFcylpylgzTxkx
 SGygE8nb6QXZEYUHs57ptv2rS/8gRPaqKbVE/B3XEZy7nuF/O40BhcjzXwHXSwsUt5l2ju9Fos7
 INQHFTkGfQXqsATY6HQgYcdnbTpRMppwRNPAvLezPVmT9AknLViOHgRmVP6E+MFrIZUOxKJVWaK
 j90IFz27LjiUkvaZFaUypQuhLuUPogPYJqwxHZ8OHjcCc+jysR/7yY5gLDDwp73e+xYKELR0Gkp
 FZMCt62qfKuv8Ro0RltTzx0rc7ugwVthpUFTWIaKzbb2rGZhdg9Yk9fQ4pTEBrQm6OOZM2iNag6
 wER50peu/CpkkVloZKNhqSR5wX8fdOnxA3q+9KGHsGtw8bPHBibK2/DZXLF8KXyiqMTz+5agYCr
 ckdQtofdD0aiFcrcqIeGbV3s5/AL9U=
X-Received: by 2002:a05:600c:1e88:b0:477:6d96:b3e5 with SMTP id
 5b1f17b1804b1-48526916beamr45748115e9.7.1772809200617; 
 Fri, 06 Mar 2026 07:00:00 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.06.59.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/49] target/arm/machine: Fix detection of unknown incoming
 cpregs
Date: Fri,  6 Mar 2026 14:59:10 +0000
Message-ID: <20260306145939.2162189-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Eric Auger <eric.auger@redhat.com>

Currently the check of cpreg index matches fail to detect
a situation where the length of both arrays is same but
- destination has an extra register not found in the incoming stream (idx1)
- source has an extra register not found in the destination (idx2)
  where idx1 < = idx2
Normally this should fail but it does not.

Fix the logic to scan all indexes.

Fixes: 721fae12536 ("target-arm: Convert TCG to using (index,value) list for cp migration")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260304101625.1962633-8-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/machine.c | 61 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 12 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 4d9158e697..476dad00ee 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1057,6 +1057,35 @@ static gchar *print_register_name(uint64_t kvm_regidx)
     }
 }
 
+/*
+ * Handle the situation where @kvmidx is on destination but not
+ * in the incoming stream. This never fails the migration.
+ */
+static void handle_cpreg_missing_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx)
+{
+    g_autofree gchar *name = print_register_name(kvmidx);
+
+    warn_report("%s: %s "
+                "expected by the destination but not in the incoming stream: "
+                 "skip it", __func__, name);
+}
+
+/*
+ * Handle the situation where @kvmidx is in the incoming stream
+ * but not on destination. This currently fails the migration but
+ * we plan to accomodate some exceptions, hence the boolean returned value.
+ */
+static bool handle_cpreg_only_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx)
+{
+    g_autofree gchar *name = print_register_name(kvmidx);
+    bool fail = true;
+
+    error_report("%s: %s in the incoming stream but unknown on the "
+                 "destination: fail migration", __func__, name);
+
+    return fail;
+}
+
 static int cpu_post_load(void *opaque, int version_id)
 {
     ARMCPU *cpu = opaque;
@@ -1096,21 +1125,12 @@ static int cpu_post_load(void *opaque, int version_id)
     for (i = 0, v = 0; i < cpu->cpreg_array_len
              && v < cpu->cpreg_vmstate_array_len;) {
         if (cpu->cpreg_vmstate_indexes[v] > cpu->cpreg_indexes[i]) {
-            g_autofree gchar *name = print_register_name(cpu->cpreg_indexes[i]);
-
-            warn_report("%s: %s "
-                        "expected by the destination but not in the incoming stream: "
-                        "skip it", __func__, name);
-            i++;
+            handle_cpreg_missing_in_incoming_stream(cpu, cpu->cpreg_indexes[i++]);
             continue;
         }
         if (cpu->cpreg_vmstate_indexes[v] < cpu->cpreg_indexes[i]) {
-            g_autofree gchar *name = print_register_name(cpu->cpreg_vmstate_indexes[v]);
-
-            error_report("%s: %s in the incoming stream but unknown on the destination: "
-                         "fail migration", __func__, name);
-            v++;
-            fail = true;
+            fail = handle_cpreg_only_in_incoming_stream(cpu,
+                                                        cpu->cpreg_vmstate_indexes[v++]);
             continue;
         }
         /* matching register, copy the value over */
@@ -1118,6 +1138,23 @@ static int cpu_post_load(void *opaque, int version_id)
         i++;
         v++;
     }
+
+    /*
+     * if we have reached the end of the incoming array but there are
+     * still regs in cpreg, continue parsing the regs which are missing
+     * in the input stream
+     */
+    for ( ; i < cpu->cpreg_array_len; i++) {
+        handle_cpreg_missing_in_incoming_stream(cpu, cpu->cpreg_indexes[i]);
+    }
+    /*
+     * if we have reached the end of the cpreg array but there are
+     * still regs in the input stream, continue parsing the vmstate array
+     */
+    for ( ; v < cpu->cpreg_vmstate_array_len; v++) {
+        fail = handle_cpreg_only_in_incoming_stream(cpu,
+                                                    cpu->cpreg_vmstate_indexes[v]);
+    }
     if (fail) {
         return -1;
     }
-- 
2.43.0


