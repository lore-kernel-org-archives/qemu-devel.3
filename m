Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81EFCD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3em-0001v8-8s; Fri, 26 Jun 2026 06:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3ei-0001T4-W1
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eg-0005Og-QM
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qkoE8S6UBX3o+N0SXfwXHK1tv2NXu1sYxgKB0nzO2dY=;
 b=AM+6EizPIaebpKmkinlZ7YQ1vSQCCf3TtRGGS9y53fgFRuuh0q3ZmUpgVvnRLuQA52ptYg
 fW9297KisD/tcljt5M641rUAJM/eoDNcpZMQ6t981pOpu11JvMFQTEPXLprnkpVxOLG6f/
 dd2ifNpcZyKBQSgqjgHXWv3xoCdkquw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414--jMyWzUkPu6zOWyE8wK2kA-1; Fri, 26 Jun 2026 06:19:25 -0400
X-MC-Unique: -jMyWzUkPu6zOWyE8wK2kA-1
X-Mimecast-MFC-AGG-ID: -jMyWzUkPu6zOWyE8wK2kA_1782469164
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49243626f15so6948955e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469164; x=1783073964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qkoE8S6UBX3o+N0SXfwXHK1tv2NXu1sYxgKB0nzO2dY=;
 b=blLisRH+q8PnXkpbtzKHUve5cT5zqinE3aqgBiiwnjKikvSDsO5RQQWP30p4BSh+q6
 W3CBjxYIhben6QXsc8R4meOsOgRkR7wijHBePYZDuquNVo0IDHdeQi/VcSVngb78RnMt
 QsBHyeyFjW3Vzne9cDdp/3GOi6SodH+4qQXPDFH+I4wEdsINa6HN+gZ56RoBVvh+LosA
 TKbjtX/LWuSfXv8IaExUQsRvK1YcgpERRvopiY/CEUANzCGJ0GigTLl20EAZ++OzAxCK
 pcNDIlqoaB1XVzEL20HV7ratgAL6Ri9azavRn7eAzh2gMrEQiopXLinbALpiN6Lf1y1r
 eHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469164; x=1783073964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qkoE8S6UBX3o+N0SXfwXHK1tv2NXu1sYxgKB0nzO2dY=;
 b=tTuvpt31BC1zJFW8VqeqGxn1tCK6HiFhXH5DvGWeDNk0bm4axFgR7aBOFfzs8EVxKy
 dmhEpT6Gs/roWrZ1RVaHfcdeOabO02eNXWthvbmv1AiU4W4c8rBUbhfFjBNk76IFADVb
 6X/9J4tNnXXw4IpeQlZnmplbGfYGzO/jqI0ghvFn9kVYT8AFLNWFKjnxGh0dcTfZh8fu
 MU+zby/sePtKMSkBctJ3J5gGf+ZQ5LzNvu8dA2q1MG+HBUOTOlBtkHBQU7JwGa1E3mt+
 zCm8XkLzVoMj8zcKvUo4O10v6INqxkt9DJ1Mi0Td8x98ByiwO1QhOHzFGPhlR6j/oIDD
 rFLw==
X-Gm-Message-State: AOJu0Ywwu+Elj3jkFz/FfibQLqyOczXcywhBPD5qF+Qopd0OBIPd5zWb
 OgjPW0qIYmGz9F7nHAixevF8vQObe2DJn7gEvCYhF2U7PNex8ysDrU6Cp8SABbSxtUmB+keVF5K
 5nqNhqTIrX2Xgu5Ix1abVuul356RtM5xmWgOnSHAa2xwTWePJ44E0lFeJscRO7XEux0E2E08an7
 3Guw+fZTWX6DwB1+igoSb88lwieceF4dPrk6+HUmMx
X-Gm-Gg: AfdE7cmG57C4Xv422YYPxYADG4PpBdDeZF5MBB6hh5QDFB0Qqv4zXIMOhqEii8J1EIL
 OzvZ/KbmVOb+zAO/kUj9rlpZ+2AclB6NKVHPxVn84rL1Gqgx4sl6CpkzdlHo2LbiRxnLnG2kmg+
 ZoJY3dwHejqsDHlYiFxroTVH92cRa2nCH5A75yrz6qkLpURDvSqdky7CeKziLEwSN1r9vsZYDtC
 SyGF81CIWUuYl6Lfco7lfYWejhfGQWQIVJ7fWK45FpKqZsqMS2z5Ws0eBNRk+uIrFCcc5HK1lKa
 JdtIBu9rZs+TVReCdg50yjTB62yNpiRlurkmD/BGMbjf52cn6DR0wOGO8Kis9QCmFbs3IBZX1+H
 Dcdv7+kylbW9TNc2Wd6sgXyHk17eIUE/AViiIlsuAf92C7LvaK5KRbwIDz27zV18d8K8IO1UXr2
 jn55v5W2qqi/2vYEOT
X-Received: by 2002:a05:600c:4745:b0:490:b355:9c70 with SMTP id
 5b1f17b1804b1-49266873f5bmr86529425e9.11.1782469163648; 
 Fri, 26 Jun 2026 03:19:23 -0700 (PDT)
X-Received: by 2002:a05:600c:4745:b0:490:b355:9c70 with SMTP id
 5b1f17b1804b1-49266873f5bmr86528915e9.11.1782469163154; 
 Fri, 26 Jun 2026 03:19:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492690168d5sm92222235e9.14.2026.06.26.03.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:19:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 34/45] include/hw/hyperv: add hv_vp_register_page struct
 definition
Date: Fri, 26 Jun 2026 12:17:37 +0200
Message-ID: <20260626101748.1728079-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

Define the `hv_vp_register_page` structure that the linux kernel uses
to allow access to vcpu registers.

This structure is going to be used in later patches to access vcpu
registers.

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260428135053.251200-4-dblanzeanu@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/hyperv/hvgdk_mini.h | 103 +++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index c6749a95255..f8838a31bbe 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -504,6 +504,109 @@ struct hv_input_assert_virtual_interrupt {
     uint16_t rsvd_z1;
 } QEMU_PACKED;
 
+/* Flags for dirty mask of hv_vp_register_page */
+enum hv_x64_register_class_type {
+    HV_X64_REGISTER_CLASS_GENERAL = 0,
+    HV_X64_REGISTER_CLASS_IP = 1,
+    HV_X64_REGISTER_CLASS_XMM = 2,
+    HV_X64_REGISTER_CLASS_SEGMENT = 3,
+    HV_X64_REGISTER_CLASS_FLAGS = 4,
+};
+
+#define HV_VP_REGISTER_PAGE_MAX_VECTOR_COUNT  7
+
+union hv_vp_register_page_interrupt_vectors {
+    uint64_t as_uint64;
+    struct {
+        uint8_t vector_count;
+        uint8_t vector[HV_VP_REGISTER_PAGE_MAX_VECTOR_COUNT];
+    };
+};
+
+struct hv_vp_register_page {
+    uint16_t version;
+    uint8_t isvalid;
+    uint8_t rsvdz;
+    uint32_t dirty;
+
+    union {
+        struct {
+            /* General purpose registers (HV_X64_REGISTER_CLASS_GENERAL) */
+            union {
+                struct {
+                    uint64_t rax;
+                    uint64_t rcx;
+                    uint64_t rdx;
+                    uint64_t rbx;
+                    uint64_t rsp;
+                    uint64_t rbp;
+                    uint64_t rsi;
+                    uint64_t rdi;
+                    uint64_t r8;
+                    uint64_t r9;
+                    uint64_t r10;
+                    uint64_t r11;
+                    uint64_t r12;
+                    uint64_t r13;
+                    uint64_t r14;
+                    uint64_t r15;
+                } QEMU_PACKED;
+
+                uint64_t gp_registers[16];
+            };
+            /* Instruction pointer (HV_X64_REGISTER_CLASS_IP) */
+            uint64_t rip;
+            /* Flags (HV_X64_REGISTER_CLASS_FLAGS) */
+            uint64_t rflags;
+        } QEMU_PACKED;
+
+        uint64_t registers[18];
+    };
+    uint8_t reserved[8];
+    /* Volatile XMM registers (HV_X64_REGISTER_CLASS_XMM) */
+    union {
+        struct {
+            struct hv_u128 xmm0;
+            struct hv_u128 xmm1;
+            struct hv_u128 xmm2;
+            struct hv_u128 xmm3;
+            struct hv_u128 xmm4;
+            struct hv_u128 xmm5;
+        } QEMU_PACKED;
+
+        struct hv_u128 xmm_registers[6];
+    };
+    /* Segment registers (HV_X64_REGISTER_CLASS_SEGMENT) */
+    union {
+        struct {
+            struct hv_x64_segment_register es;
+            struct hv_x64_segment_register cs;
+            struct hv_x64_segment_register ss;
+            struct hv_x64_segment_register ds;
+            struct hv_x64_segment_register fs;
+            struct hv_x64_segment_register gs;
+        } QEMU_PACKED;
+
+        struct hv_x64_segment_register segment_registers[6];
+    };
+    /* Misc. control registers (cannot be set via this interface) */
+    uint64_t cr0;
+    uint64_t cr3;
+    uint64_t cr4;
+    uint64_t cr8;
+    uint64_t efer;
+    uint64_t dr7;
+    union hv_x64_pending_interruption_register pending_interruption;
+    union hv_x64_interrupt_state_register interrupt_state;
+    uint64_t instruction_emulation_hints;
+    uint64_t xfem;
+
+    uint8_t reserved1[0x100];
+
+    /* Interrupts injected as part of HvCallDispatchVp. */
+    union hv_vp_register_page_interrupt_vectors interrupt_vectors;
+} QEMU_PACKED;
+
 /* /dev/mshv */
 #define MSHV_CREATE_PARTITION   _IOW(MSHV_IOCTL, 0x00, struct mshv_create_partition)
 #define MSHV_CREATE_VP          _IOW(MSHV_IOCTL, 0x01, struct mshv_create_vp)
-- 
2.54.0


