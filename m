Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247A2C28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqfgR-00050Z-PA; Fri, 07 Mar 2025 16:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqfgP-0004zh-QF
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:56:41 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqfgN-0001k2-P7
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:56:41 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22337bc9ac3so49803275ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741384598; x=1741989398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TvAuOoN8/PzrW6ePLHQAaqYQcMX7nhU7k0OaOWGrsUU=;
 b=YnCdP0j3ITJ+3zMAyl7Xq71hQgRZyF2Vy3UuTvMYuzMT/TiiQ6jYqw2BHzISDGdIfI
 9pC3Qm6II+BEf5REWkhB7MkgdXQP5jao4yFymAGjtCFqftcv95fZcKftIMZaZibLieLe
 zXkmGFlehVGNiXcbcY+321pKVDGPiQ6xXza8ZjaPEF22vaTdmZNhf2qoQ9HFNrji6CjB
 RZ8Eo6+UWaZ+m1EugDJWJ4pCGb6DDLSOeTyOmcXocmXcOgBWi38v4fcY+kBSEmIsDI7J
 s/wefnzROfB+kZ1I6w24R7aWVnp7SRI4TZUd1UV9NW4GlVtOKv3TlZyCK9ieo497Kj7T
 csWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741384598; x=1741989398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TvAuOoN8/PzrW6ePLHQAaqYQcMX7nhU7k0OaOWGrsUU=;
 b=i9q1ALrgITodDhArvz3gdgcAEUuMha5l0D3Q/0bcRHUnlBWWzmA2I41IrWLdo/2c+y
 9efGNFxZ5vfZbQ00fikWgzPbd68CaBHwGJThrRIjRgXhUCDmWwZvKNqRptzhFru4nVCM
 LjJV5xUTfmH5eVAyBQvq0xStlrC8mGWMOD3YA3c7gaY5me+AoMgnlQL/5c/ogsM1N0g+
 bJe3OKF7gNEL8PSM4c3MW3eHkMUMPWkBd9hnnYdHrqV0Su6dLVGeXMVAif4uQQnBpT+9
 W1srmsa+gzqb5iWxF9evd8Bbyi5u8kItA6coX9gd1I/i2ZshbsR9PPBHm/cFqtTD/07x
 E07w==
X-Gm-Message-State: AOJu0YweJoKdWI1oDwbKsijVMr4E+78IPCzJo77vHTmEdjHjmGWlNKx9
 orWyLIpU3EzVCPamf0+i7qhXma4gZtjnlaiU0npz7eNpVyEGLYUh6acLNzgUrmKbyiQpVEH1H87
 a
X-Gm-Gg: ASbGncs23UTPQy+S5iOMuiQyweYRI6gR1wc7rgvrcl7EbyW7u1v45KT3FlFIv3t7DpO
 HoHoQkJgS+t/g4oVsl86BN9VPaoQLrPc4dvz9YOxGr6TCmvrMkXJjM87XhdfbuR/GScVyHHB75w
 NHWmuxJ2JbG3G1b+MaAXJ2tejyGD0vwrFgUe1T3364wMxPzJnPe+HNsGukeCQsTMcrmzHsmEZGP
 JGeKCAaAQ+gXnM20UJtZYr25rYYb4vH0Xehghb7DDg6oP7+aqkMUcIgUJ87mrss+JvBaKCOySaN
 sT3nt5kLfRZi6VMAh2mYVBqmVBDCjbZ9kKFW6wjCde0n
X-Google-Smtp-Source: AGHT+IGl3pecSAWBhv2Obh4KryTo7/9V/E2hfk69YnyQdLFubkCq88mHRjshx69HtUMmfNzcVYvwUA==
X-Received: by 2002:a05:6a00:228c:b0:736:8c0f:774f with SMTP id
 d2e1a72fcca58-736aab02cd8mr7557373b3a.22.1741384598341; 
 Fri, 07 Mar 2025 13:56:38 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736ac9247dcsm2000927b3a.125.2025.03.07.13.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 13:56:37 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 pierrick.bouvier@linaro.org, kvm@vger.kernel.org, alex.bennee@linaro.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
Subject: [PATCH v4 5/7] hw/hyperv/syndbg: common compilation unit
Date: Fri,  7 Mar 2025 13:56:21 -0800
Message-Id: <20250307215623.524987-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
References: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/hyperv/syndbg.c    | 11 ++++++++---
 hw/hyperv/meson.build |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
index d3e39170772..948829e6d89 100644
--- a/hw/hyperv/syndbg.c
+++ b/hw/hyperv/syndbg.c
@@ -10,11 +10,12 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/sockets.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
 #include "hw/loader.h"
-#include "cpu.h"
+#include "exec/target_page.h"
 #include "hw/hyperv/hyperv.h"
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/hyperv/hyperv-proto.h"
@@ -183,12 +184,14 @@ static bool create_udp_pkt(HvSynDbg *syndbg, void *pkt, uint32_t pkt_len,
     return true;
 }
 
+#define MSG_BUFSZ (4 * KiB)
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
@@ -201,7 +204,7 @@ static uint16_t handle_recv_msg(HvSynDbg *syndbg, uint64_t outgpa,
         recv_byte_count = 0;
     } else {
         recv_byte_count = recv(syndbg->socket, data_buf,
-                               MIN(sizeof(data_buf), count), MSG_WAITALL);
+                               MIN(MSG_BUFSZ, count), MSG_WAITALL);
         if (recv_byte_count == -1) {
             return HV_STATUS_INVALID_PARAMETER;
         }
@@ -374,6 +377,8 @@ static const Property hv_syndbg_properties[] = {
 
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


