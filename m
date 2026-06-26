Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9327CDE014
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3eP-0008SJ-Tz; Fri, 26 Jun 2026 06:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eE-0007j0-FH
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eC-0005J5-KT
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OvQe6R2LGaw8AiLW+OHgbam2GHSnybOj9jdYYtFJyIg=;
 b=UCg0mKheWAwgxGZuqvmlmxK0P18tiR292M3yWdvFhn5DrMT9wHzzezkJVoTbx/gyJs1luO
 BiJsWC5Ov3m/LPCeGvsEuP1vdSpo+nivI/0kqiA+Y+m9kqyAnQLPoi7nqoM6LfgRPDpbbD
 hv9v7LZl4PQrTAS7PZmeAPHySyZFusU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-2aY4LuXsPuaj3gevvPAnKA-1; Fri, 26 Jun 2026 06:18:54 -0400
X-MC-Unique: 2aY4LuXsPuaj3gevvPAnKA-1
X-Mimecast-MFC-AGG-ID: 2aY4LuXsPuaj3gevvPAnKA_1782469133
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b2f22ea2so6712375e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469133; x=1783073933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OvQe6R2LGaw8AiLW+OHgbam2GHSnybOj9jdYYtFJyIg=;
 b=pkXY86aRW7CoA9oWQlQiWWzXhCsT+aWoCWaHkPdzWJeWLfLeaDudATG5TvlE+Y9ULn
 Ei/D0m+m63zZqMCEnfu9K1zJ1C1n514Do7+u7TZMii3KWUoqKbTxJ8q701yqv9qXCmML
 DMcyt6WQsBHVmKZc6Ri1/7e4COVXgu6aam1rGw1Uxp/B+EPc73y8qsWXBX1U0RzbTzuU
 mR48TMzKeWfJZ06dS90Cg0QahGhTEsvwtjxcuWwgOKSe5dR4gGfYQBNGKG0a7LSxNp9P
 blZgPUylLJ5hw/LzVJphcCWGO0ZQOrQXuX5W6KxbuV8OsNeuhhdKPlFxiPs/Pt5XD4wy
 UrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469133; x=1783073933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OvQe6R2LGaw8AiLW+OHgbam2GHSnybOj9jdYYtFJyIg=;
 b=VIZUOgmMJegD9zuEeuSl22HOKX6y5FJDN5fRQ+P3NbNp3xRMX9tKFqKvGVPpN6EO90
 elBUHFjVo1XwXvl4nWZM1FI38K6NYT3OStKRtNOPI9Nu5dx/az01CZgXvvDtu5xjMB61
 QPW9P2iq8ehNfoMHKlzZvWQdymA1CWZS4O3CDVTg04gURRiOpyCGv2P4Wsc94NK5fGLm
 qnabtYfw7E+cmrQ1hZpKvz0UOux/9GlILPyvwfLH2FqtTxudZAXeWYE72oQ+nXt6ibSu
 lMQT+lQw7k/CuvSh8VCGo5fC2+GQ3XKY0n+yA+XnLSz/dHACYVk/mle/VDcqULf6l5TM
 2E/A==
X-Gm-Message-State: AOJu0YyGuUJckI9vDOX/rOzrst6YiUBut/yY1Zf6JrJUNEr0N9rggzij
 mRCZnDIAJtp0uSTelriQFj5LsSbkJaL3wYJQMtPD0lgquclhsl7PkDdoC9p3fLZLuhL/Sd32LCm
 D7e4cbd8NbTvhzBVwuInMtdC1Y87J6rRxXVFqnYjkmP4AbDma9Up48X40CvQ3tGcT8rDHzjeLL7
 ktzfXzGJEzDFoK8nekTNZbFQNcRmgNVsGgbODIE8Jp
X-Gm-Gg: AfdE7clwBTY3Jh5GgbA+95/ObEDD67K0b4dmUUWOordDe4EdNUis/SM8RpHtNAgPVhG
 jffP8HDEOJikDgBv0A1aeDyt13j3gOPVOYQfLpZRnS1UV+vdYkPy3Q9I/+QFDJ1axgllnpWh8ed
 XWvGM6yBp3JeJcIQHVQ2osZWpq1b6W2EKgw9B3KYrVPW74ahxOasE6e7yBKpP3aAblAuTGChsNw
 R0qaFWZo5zU8Ds9t2S1znzjy231ck1PHcEzPjpGjT//x6I8GdIM/Zg7HEkz6ZTdGpSQ/939wgZK
 PD4XhXIdSmIYCY1IdeEfvL/ld9k9xILawMO9zVttVYRyyamyc6fi5aTuGobNgvXfuyM731k+ait
 aO1flAyw7F3PXDbzAMoYTbFQkLvQT56p3wttHscJrW5wSh3ZjJtefe2HpTGQtvhIJ6VtzQ8DO6R
 /FMcR2kBQ21XNe6JEj
X-Received: by 2002:a05:600d:8653:10b0:492:4e09:9fc1 with SMTP id
 5b1f17b1804b1-4926684c8c0mr71441145e9.15.1782469133453; 
 Fri, 26 Jun 2026 03:18:53 -0700 (PDT)
X-Received: by 2002:a05:600d:8653:10b0:492:4e09:9fc1 with SMTP id
 5b1f17b1804b1-4926684c8c0mr71440665e9.15.1782469132910; 
 Fri, 26 Jun 2026 03:18:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1b754471sm22956676f8f.0.2026.06.26.03.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:18:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 23/45] accel/mshv: store partition proc features
Date: Fri, 26 Jun 2026 12:17:26 +0200
Message-ID: <20260626101748.1728079-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

We retrieve and store processor features on the state, so we can query
them later when deciding which MSRs to migrate.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-19-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/hyperv/hvhdk.h |  2 +-
 include/system/mshv_int.h |  3 +++
 accel/mshv/mshv-all.c     | 57 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/include/hw/hyperv/hvhdk.h b/include/hw/hyperv/hvhdk.h
index 9ad16c47da9..9e6dcb22f61 100644
--- a/include/hw/hyperv/hvhdk.h
+++ b/include/hw/hyperv/hvhdk.h
@@ -353,7 +353,7 @@ union hv_partition_processor_features {
         uint64_t lass_support:1;
         uint64_t idle_hlt_intercept_support:1;
         uint64_t msr_list_support:1;
-    };
+    } QEMU_PACKED;
 };
 
 enum hv_translate_gva_result_code {
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 5eef2e6e2cb..0cf68d2879e 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -14,6 +14,8 @@
 #ifndef QEMU_MSHV_INT_H
 #define QEMU_MSHV_INT_H
 
+#include "hw/hyperv/hvhdk.h"
+
 #define MSHV_MSR_ENTRIES_COUNT 64
 
 typedef struct hyperv_message hv_message;
@@ -53,6 +55,7 @@ struct MshvState {
     int nr_allocated_irq_routes;
     unsigned long *used_gsi_bitmap;
     unsigned int gsi_count;
+    union hv_partition_processor_features processor_features;
 };
 
 typedef struct MshvMsiControl {
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index b06eea2a5e9..d939982eb79 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -133,6 +133,57 @@ static int get_host_partition_property(int mshv_fd, uint32_t property_code,
     return 0;
 }
 
+static int get_partition_property(int vm_fd, uint32_t feature_bank,
+                                  uint64_t *value)
+{
+    struct hv_input_get_partition_property in = {0};
+    struct hv_output_get_partition_property out = {0};
+    struct mshv_root_hvcall args = {0};
+    int ret;
+
+    in.property_code = feature_bank;
+
+    args.code    = HVCALL_GET_PARTITION_PROPERTY;
+    args.in_sz   = sizeof(in);
+    args.in_ptr  = (uint64_t)&in;
+    args.out_sz  = sizeof(out);
+    args.out_ptr = (uint64_t)&out;
+
+    ret = ioctl(vm_fd, MSHV_ROOT_HVCALL, &args);
+    if (ret < 0) {
+        error_report("Failed to get guest partition property bank: %s",
+                     strerror(errno));
+        return -1;
+    }
+
+    *value = out.property_value;
+    return 0;
+}
+
+static int get_proc_features(int vm_fd,
+                             union hv_partition_processor_features *features)
+{
+    int ret;
+
+    ret = get_partition_property(vm_fd,
+                                 HV_PARTITION_PROPERTY_PROCESSOR_FEATURES0,
+                                 features[0].as_uint64);
+    if (ret < 0) {
+        error_report("Failed to get processor features bank 0");
+        return -1;
+    }
+
+    ret = get_partition_property(vm_fd,
+                                 HV_PARTITION_PROPERTY_PROCESSOR_FEATURES1,
+                                 features[1].as_uint64);
+    if (ret < 0) {
+        error_report("Failed to get processor features bank 1");
+        return -1;
+    }
+
+    return 0;
+}
+
 static int create_partition(int mshv_fd, int *vm_fd)
 {
     int ret;
@@ -520,6 +571,12 @@ static int mshv_init(AccelState *as, MachineState *ms)
 
     s->vm = vm_fd;
     s->fd = mshv_fd;
+
+    ret = get_proc_features(vm_fd, &s->processor_features);
+    if (ret < 0) {
+        return -1;
+    }
+
     s->nr_as = 1;
     s->as = g_new0(MshvAddressSpace, s->nr_as);
 
-- 
2.54.0


