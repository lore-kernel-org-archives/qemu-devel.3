Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A2DC28B23
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4vb-00026b-0q; Thu, 06 Mar 2025 01:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tq4vH-0001zP-MC
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:41:36 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tq4vE-0006Ft-6X
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:41:34 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2239f8646f6so4113425ad.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 22:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741243291; x=1741848091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GuCnrkSUR2vP9owV0mamaIN+gV2Z3JtFzZ89seSCxZQ=;
 b=lTAaet5w11kpsa0a+RfuLrqWOKFoWuZvWIPt/Uuzu3GJ26QFdK32qdQl+IzNqX6CKH
 DI/ChGTA6Cnbiz8q4u+WK337O+nRHfZqsE/pOmfNML8pnGum9HufhhPZ4R3U+mBmcz6/
 39GqK5fT6b6ynT1A9uSEbMDr4PtPf3ZdjN/L9Wa9HNaCk0uTfDv2rphN1WZsLNVH9AI4
 y+65lHrFslef3ayCGUp5dJsX772eFeKOAtDRcmPBhWjAcA0FN1fuu5s3cJHN7hqFmOKr
 dJtvgFnyrg5GBgX37MOFSnp3oFdKNFVvNQyDsGfvrwdfqYObEFsfzZ8E0kFlqnClFITY
 PkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741243291; x=1741848091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GuCnrkSUR2vP9owV0mamaIN+gV2Z3JtFzZ89seSCxZQ=;
 b=CUxmI/VX132CpIgmmpw8TCA0bh+jLeYFWBGjJG2GcQjJvm8jNIVXAIW9QteJhObdov
 wXVyaKVHd3/ZpZQk64/6sqbD5FanIbIKZX4M0AYGHcclKJCJIjxqAh4ir9ZVAki4YwLN
 +4kP8N0BC7XQfW0yFN8u1qRSYWyXpRUbJyZV7x4swti39MxmZL8lPzwDQzbk3kVvVakw
 A10GRAbuuiiUUkB5ntOIObhfcc6ncPkiVgIxycCS6Wxuw4LEVeqiqFSQMccCrFNx/yFf
 GK88e2Ra5MSKdW1ueDvZT86NXbXT/4xKkKEMDhzM5msWlv/LOHA9ClchY7TI2THt8UYF
 tL6A==
X-Gm-Message-State: AOJu0YwLYpUdon3XlaovXknWcCdvyWfS/JruBgCr9l05wWM0NIUdoHt2
 nmBcR4grmdZ8lTQu0vX4V4HibFHlYJsy9AhWk6PSFFU24U7DVc3ym6E6OswQqbmG5kS70l4mxwm
 s
X-Gm-Gg: ASbGncsKg3KYd2E/1MkqWAzRU9cauLy1t8bYhPLWydaZRE+WvhW4V6Ijb2D3Thvu1y1
 0wp0aMuOu953Qr96LUqSg+bPNDU4t3EQosepEtDZHBSVr/3hqTUNqrmmnTWO9TPmHWYKkUf4cyB
 TI9Bd8RqMGIMcK1w9GiZUY5RyO79ZjFJWgW29+xZiRyN4m65pJu5G7kprtHBEbAK5KFod7iIFbT
 8II+YlxUsgThE0gNDKwIX1pysOtpqv7Bdfh2x6it6/93zBcHlj09DMxW3wBucaN1SZp1Wr73msR
 JLmnkCHmnijpCgyNAb2PQS4QyYGSQ/ZYcD0Yp4YJ1YRp
X-Google-Smtp-Source: AGHT+IHmSsM1kkDcmTxoFOVsBQF1tnSFXKKhw9nMkZpecN08X8sctJUMqzo/rUf0aG8IqTUlNfwwtA==
X-Received: by 2002:a17:902:f606:b0:223:f9a4:3f99 with SMTP id
 d9443c01a7336-223f9a457a2mr79524075ad.29.1741243290828; 
 Wed, 05 Mar 2025 22:41:30 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91cffsm4769355ad.174.2025.03.05.22.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 22:41:30 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, pierrick.bouvier@linaro.org,
 manos.pitsidianakis@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>,
 alex.bennee@linaro.org
Subject: [PATCH 5/7] hw/hyperv/syndbg: common compilation unit
Date: Wed,  5 Mar 2025 22:41:16 -0800
Message-Id: <20250306064118.3879213-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
References: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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
 hw/hyperv/syndbg.c    | 7 ++++---
 hw/hyperv/meson.build | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
index d3e39170772..f9382202ed3 100644
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
@@ -188,7 +188,8 @@ static uint16_t handle_recv_msg(HvSynDbg *syndbg, uint64_t outgpa,
                                 uint64_t timeout, uint32_t *retrieved_count)
 {
     uint16_t ret;
-    uint8_t data_buf[TARGET_PAGE_SIZE - UDP_PKT_HEADER_SIZE];
+    const size_t buf_size = qemu_target_page_size() - UDP_PKT_HEADER_SIZE;
+    uint8_t *data_buf = g_alloca(buf_size);
     hwaddr out_len;
     void *out_data;
     ssize_t recv_byte_count;
@@ -201,7 +202,7 @@ static uint16_t handle_recv_msg(HvSynDbg *syndbg, uint64_t outgpa,
         recv_byte_count = 0;
     } else {
         recv_byte_count = recv(syndbg->socket, data_buf,
-                               MIN(sizeof(data_buf), count), MSG_WAITALL);
+                               MIN(buf_size, count), MSG_WAITALL);
         if (recv_byte_count == -1) {
             return HV_STATUS_INVALID_PARAMETER;
         }
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


