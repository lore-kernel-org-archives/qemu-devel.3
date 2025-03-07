Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0C5C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqd5R-0002VL-ST; Fri, 07 Mar 2025 14:10:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd5O-0002TW-Lm
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:10:18 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd5M-0005tf-OQ
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:10:18 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-219f8263ae0so44755725ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374615; x=1741979415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UxupFXt8v+cWVWtDpN1/5KOGycPEEPte7T4sMzf1eqQ=;
 b=qLh7q6xKR+EFo0QUonYib+867XEL70Ep/5wEVjTqERdzp5DzowLb7wDDUtWN/J75LL
 0BwbUqRD4LyOjigpu7/2gHxdvPw4wDy2Uy7l84+lBP/wvSGMzpDokcztIjxQilSvMOp8
 Jmufd60fDjgjhSWflTb3psEjlArNczT9nTrU80e7s3eemdM3p/V05+R1bQ6jRCWTHFjV
 xFumUm07veliYIX6cMigsKPWtvJgOtGCgyhvdWMoYYjId0S5TGK57gtWjAsFqi9coD3q
 g9w0VMOsgy7cxAMBmcyN7Bw9q6SFGo/IbD23IXWxkA7gbFYhYE8wxqyqQWkTHIAJMmjH
 d72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374615; x=1741979415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UxupFXt8v+cWVWtDpN1/5KOGycPEEPte7T4sMzf1eqQ=;
 b=hVDPOwD7evWvpjO0bJB8fiJJBOiVnWIo1hRs0xxQ6gf3peuGcjFO2ACF0OJeh5NOb0
 65R8gobs83IBXTFTAI/JLZCcC8eGdx+kdYq5p3yrgmeJQD6zz4cdjO+cY9TezdZzxD2V
 Cm2Cz3FYYem55DdzS5K8fW6xYhjESbTeUExZ4a4gfoDd5KIDGwR9Ky+xOkGq8nSoXsGz
 vma3hIIc3JW9Pvm4jlC4Jf6fw5sONXcyMfDrMeg6NRgkTvoAeZfGcHm7a8V34BDjVKkg
 RIgdXVjfF2ckiTvkESKxbPMAwCz1b0MD5szjtMeioN7MgkpeUwoDyLgV8lPfHw3vxnxL
 Ke4g==
X-Gm-Message-State: AOJu0Yyaf7FGJNA808tinhZmPYOC0ucIzh/fc4b1651mY5XSM2E71Nge
 Zny/HGgMcRWtqIsVgh9rGipjtuCEzlJsPvsuOaQgEDxingoomActKiY0U1rvwf2Bm9/u43bAak5
 3
X-Gm-Gg: ASbGncvH79ogVcPcU10H3xRz80trqJ7l4QVWeP1XnOUOT4U6zxdLkwhTvhye4qyWUy+
 x/h2LCArQvdBol6TqqEmQDwFnGbOhiiEJhBxlWMVskP89zJpMfahG6BiqPCzVbNXBPl0jTgPeYU
 Nj/j7+WlfMMvr0yLa7zVGMFFchfNCqrh2U3DdbJUsILV1GkTBi4U0YbgktgB0PNEul7Sn41Bsz4
 Iv1uJCSURUuLncmuvtnOrxN7atzuOZmd1vsYdBTh9xGhnHg/ZW8NZK7Th/DFhYUowIz5weQWAjU
 flsWLpId6fdvAl6/IpB8nl9uTB3q/xJFIzCKu1lsJ+Fj
X-Google-Smtp-Source: AGHT+IFk7jHET5Rs41Ubs4P3mm50rGduCenvs6hzji3ZZTTsMDlCYtfecrZbAZzCmTi4EWlLoN77Nw==
X-Received: by 2002:a05:6a00:2e17:b0:736:a7ec:a366 with SMTP id
 d2e1a72fcca58-736aa9de241mr6584061b3a.9.1741374615256; 
 Fri, 07 Mar 2025 11:10:15 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736b2da32c6sm1449895b3a.149.2025.03.07.11.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 11:10:14 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 pierrick.bouvier@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
Subject: [PATCH v2 5/7] hw/hyperv/syndbg: common compilation unit
Date: Fri,  7 Mar 2025 11:10:01 -0800
Message-Id: <20250307191003.248950-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307191003.248950-1-pierrick.bouvier@linaro.org>
References: <20250307191003.248950-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

Replace TARGET_PAGE.* by runtime calls

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/hyperv/syndbg.c    | 10 +++++++---
 hw/hyperv/meson.build |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
index d3e39170772..ee91266c070 100644
--- a/hw/hyperv/syndbg.c
+++ b/hw/hyperv/syndbg.c
@@ -14,7 +14,7 @@
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
 #include "hw/loader.h"
-#include "cpu.h"
+#include "exec/target_page.h"
 #include "hw/hyperv/hyperv.h"
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/hyperv/hyperv-proto.h"
@@ -183,12 +183,14 @@ static bool create_udp_pkt(HvSynDbg *syndbg, void *pkt, uint32_t pkt_len,
     return true;
 }
 
+#define MSG_BUFSZ 4096
+
 static uint16_t handle_recv_msg(HvSynDbg *syndbg, uint64_t outgpa,
                                 uint32_t count, bool is_raw, uint32_t options,
                                 uint64_t timeout, uint32_t *retrieved_count)
 {
     uint16_t ret;
-    uint8_t data_buf[TARGET_PAGE_SIZE - UDP_PKT_HEADER_SIZE];
+    uint8_t data_buf[MSG_BUFSZ];
     hwaddr out_len;
     void *out_data;
     ssize_t recv_byte_count;
@@ -201,7 +203,7 @@ static uint16_t handle_recv_msg(HvSynDbg *syndbg, uint64_t outgpa,
         recv_byte_count = 0;
     } else {
         recv_byte_count = recv(syndbg->socket, data_buf,
-                               MIN(sizeof(data_buf), count), MSG_WAITALL);
+                               MIN(MSG_BUFSZ, count), MSG_WAITALL);
         if (recv_byte_count == -1) {
             return HV_STATUS_INVALID_PARAMETER;
         }
@@ -374,6 +376,8 @@ static const Property hv_syndbg_properties[] = {
 
 static void hv_syndbg_class_init(ObjectClass *klass, void *data)
 {
+    g_assert(MSG_BUFSZ > qemu_target_page_size());
+
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_props(dc, hv_syndbg_properties);
diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index c855fdcf04c..a9f2045a9af 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -1,6 +1,6 @@
 specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
 specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
 system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
-specific_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
+system_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
 specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
 system_ss.add(when: 'CONFIG_HV_BALLOON', if_false: files('hv-balloon-stub.c'))
-- 
2.39.5


