Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B86EC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdWG-000103-Ch; Fri, 07 Mar 2025 14:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdVk-0000ut-2D
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:37:38 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdVh-0007Wx-I2
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:37:31 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ff6cf448b8so4273288a91.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741376248; x=1741981048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7TO8UyCMpQA9GFmU43KRp15LWAsbGPR+sOTKQ30ilM=;
 b=BFoMuCrvUuS4eXoFVuUPaxeu78aFzAQKUKHd9GgvIhJxNZMcdCJRQtiQQeVJpGNKpH
 Gim2aW71AVVhc2lvjGn+01t+jSqTTkDI9BwDxp7PopFXAmr+AybwalnZXlF1lCME8yL0
 xDCYV/PzZHUfXQkxb84RTGJfUxDYVGNI3m2qO6redEBMLmmjUt1wWL3QJdrIrhKytYY8
 IU6sXFpOKA2LNqIXmcYpw/xXmvdfg6oyu+H7z/VcfkVlxN5eZKAeIjx9L6WgZPWbrf7C
 edw5moN0bkUC/RHh7Wfcaf0Bw/uup1+qEKoM7Dq5C2Dq5kUf5fhGbNqvHAcVWIW978RL
 JD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741376248; x=1741981048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7TO8UyCMpQA9GFmU43KRp15LWAsbGPR+sOTKQ30ilM=;
 b=cMHQrdTaNUhzWNU4bVHENTUbzMSzYwIuInaNnl5jnM/lGFzAEZDzr2qAilAcP5kmGL
 G7V/srXi91BaocVmW7ppOga8C8JkFgj+BehO2fcpWxPYh6EwgOf5c4V1oBFiMMoZ6G4q
 H/p/XAb/y0+4q5zgcea39/i9PupWdMKTim2I0u6D5o1IJ3M8SfgW0fFoehZx5jyA5BxC
 AqJva9g8dKRhtwJ6aNkkcg5wNTlYYhEfiN5vtSMpfqp1YDsTmU61n8YuU2aUsWJqRQu9
 59XF0waV9zildgy8O5HiFjarYXf918NVd/cDuTy++DdCV89CdXElJo5/jlqxXOlT6wDp
 PA1Q==
X-Gm-Message-State: AOJu0YxN+lhbC6jPnw5drJWgAM4pgLWG1JNZD+O1MFEsfYrwLrYyGvH9
 th/Hn0vnScY4L6WEWIWGP0hNYVy2GuhpO79hqSPO5QNJXrVxGILEO5SBQtv8wBXmvVEKK37vD8C
 U
X-Gm-Gg: ASbGncu5z+VwV6A/MZleFq80VSnegnLOxEt1RUwfS0gQzFM3IUKkWPxvKMFCGNRQXES
 nttLpgc7aZqsTT/Pf1iPkCJPS9JBjJFxBAVcFj9CgrynWz3PN8Qrn2WFXXuM/iTRpPhLXiwjC+v
 2QAuOX2DXGip9rOVhvixlA/s/qP6y3vqqYcY+xGMYp84U8xe2I9z1DhIjKBiW8k4pEiBAiS25NS
 tNb4KuLuNiTtaKcCHn6jPsrKEjsefu8WlF3lfowSMIuHD2LB9Cs1UhEpzgASeSX5bmPyzUz/NZt
 fd64+rvRvyXBYnUfzbSV1Gopa6Czd35KUxLL4OfHsn4k
X-Google-Smtp-Source: AGHT+IFj65vtT81oEsrUT1DRviBXXeZJTWcarf5IGtmt/W5WbNQvB9z8nj3KFVpsxQFrj2wLp0iOpA==
X-Received: by 2002:a17:90b:38cd:b0:2fa:17dd:6afa with SMTP id
 98e67ed59e1d1-2ff7cea999amr8282502a91.17.1741376247034; 
 Fri, 07 Mar 2025 11:37:27 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693739ecsm3821757a91.26.2025.03.07.11.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 11:37:26 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, kvm@vger.kernel.org,
 richard.henderson@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, manos.pitsidianakis@linaro.org,
 pierrick.bouvier@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v3 5/7] hw/hyperv/syndbg: common compilation unit
Date: Fri,  7 Mar 2025 11:37:10 -0800
Message-Id: <20250307193712.261415-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307193712.261415-1-pierrick.bouvier@linaro.org>
References: <20250307193712.261415-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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
We assume that page size is 4KB only, to dimension buffer size for
receiving message.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/hyperv/syndbg.c    | 10 +++++++---
 hw/hyperv/meson.build |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
index d3e39170772..0ec71d9bfb8 100644
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
+    g_assert(MSG_BUFSZ >= qemu_target_page_size());
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


