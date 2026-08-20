Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39744C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5zU-0007Qc-Cx; Thu, 20 Aug 2026 12:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zR-0007JE-Lq
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zP-0005ha-TE
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nmec4Eqd7RVxYyh0QcRMr93BghItkMQNi2fRiGihobY=;
 b=XvU2N0UKxN0X8CWKc0QGSaV3O2XwRIQQPnIbVaBXrT7DZRxGAbJEQ0UuHOYT0YzMwbNWyn
 ioJXRJfWzkwfgwjp8/LC4cwK4XCI6vFw47FIdHhbBKwjeT34xsTdu1m5WSDHAn0CahpyE5
 Rmu/d3HyYR0xgq+RSe6YuFiiP5XM3Rs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-b-dXpq78PICSfKYfN5BYcw-1; Thu, 20 Aug 2026 12:51:32 -0400
X-MC-Unique: b-dXpq78PICSfKYfN5BYcw-1
X-Mimecast-MFC-AGG-ID: b-dXpq78PICSfKYfN5BYcw_1787244691
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f4bff865cso77165f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244691; x=1787849491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nmec4Eqd7RVxYyh0QcRMr93BghItkMQNi2fRiGihobY=;
 b=afKgrKJ08kSH1uZpDmF5upYyfzWB5mCPqcZP97EHTGfMPm7eS12Rn+0eOeIcbRX71g
 g3Q50w4FF/FQuIW7rnLnTahHzVfy7gerTqQh83dGgP2vRvSQlFsVzgz+4tN9DrNMmPmr
 aCiL4v9ZXmKn1VhxQ2jejxYZRpz4iaBihOGmx8CeB2XmAM3ZnHeXeEtEhO8CQdAc3YhV
 xTxQfZaRiiHzLsi7bRTCN5eNACbB6to2tx6gowrt4pMDrbL3bhbXpm8Y0kgDwn0tugkx
 HVt3wC4owDFMEP1jg7bn4F6JyMxTKCxzFFiOAg0lxiu0ZK2TIlGtB/nV39diGTyMs6s4
 xX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244691; x=1787849491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nmec4Eqd7RVxYyh0QcRMr93BghItkMQNi2fRiGihobY=;
 b=RR9opYZ7+/QzXrUTKKhYG5SIUr4YlEcy9iqrcSDxsqBWGScedpjazND38/gbMTXBK/
 R0y654mBvoTxGVzt3HI7gIKKtVsKlNmQySgA8wMo7PIXVFGs00lgP1GDtKiqz/uOlYXD
 ryEf+F+YQracT4N7XT0g35Wgmov/QbQx95nPXmV0My03sqJX53moEy1z/XDYAjJ0wTJB
 8pAuAHVkgBJRvQVyUqH5wA4JNtkZZwDFAK6UbMonvc3MvQ70gl84PdgdwR/465BmVJxB
 dAzgQenec+eyG1Jq1akXOv9WKGnOD/LC5T7VCsL3C2tCKSCi1yv41AaHhHXscaRECHqK
 nLMw==
X-Gm-Message-State: AFuF++nmwQvB72Y9BkjjAElCeK+bYqsFhYrukPtfTztFKZBC5Fb/ugFt
 1hMKS2vP2eeJwfDKVg1I4XngndgexqZtBpxA89ydPbTT3sPYlpA0/ik9J8xqAhFAwKqRsTzCCPf
 DJhAZjPC7dshpcRrtKvv028pmDeY5sWJ0AGwKb9YAklSlPwUGyV9B61Pb9+Cn2Att2BQ4Wvbbp1
 78P42f5dm2DYTqD8Br9SbKGhhI/5IDxOgWN+0PKYhg
X-Gm-Gg: AR+sD13ABv8lIK+T7E5o55bGeZXN4jKoa+RBahf3hXtwI/0veYMKmuv6TRzcJ106H3P
 Vg7a39IPCz53h1rB+btLH2nG5Iq+83t8mXbv56lNh8ie0eDpht86WNZkeX66NSDVnqpy4j9G4Ff
 JZJcFNlVYkX6PA+QuVQBqvbDrP1KJmk/6hauUCg7SwSjRzMxBTLW+4YWRPXJ8DIJG6L2kdrrtvH
 bqoTzhLUPs9Pk7DLH8PNy1aS2pXauvVSpxZqC5hj0sYKHHY95c7tOm2ttQqOvonGy1zLj3/+xkl
 ieLuTJLOiZkyF3UPUEotbHKBF5IjZQ5cIJEl+8IL5DA4UcdeXvNizg9i0Ltn/MKcV1nJ6mOK9Al
 9ZVZDsi6y/bi6NvkBxhF6jqh1eN0vk1NRkwInYM6HTRVuj1llO0yqzFIrR6JXu5CLujPSWGcfo9
 P/PaY=
X-Received: by 2002:a05:6000:1acb:b0:47f:90a4:ff42 with SMTP id
 ffacd0b85a97d-482c0b5488dmr23695f8f.5.1787244690763; 
 Thu, 20 Aug 2026 09:51:30 -0700 (PDT)
X-Received: by 2002:a05:6000:1acb:b0:47f:90a4:ff42 with SMTP id
 ffacd0b85a97d-482c0b5488dmr23615f8f.5.1787244690367; 
 Thu, 20 Aug 2026 09:51:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441b0fsm13690961f8f.4.2026.08.20.09.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 32/53] hw/i386: fw_cfg: do not set VMX feature control on WHPX
Date: Thu, 20 Aug 2026 18:49:35 +0200
Message-ID: <20260820164957.1895963-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Hyper-V doesn't allow setting this bit on build 26100.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260812082814.27217-3-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/fw_cfg.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index d422302c1c9..5903994a7cb 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -13,6 +13,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "system/mshv.h"
+#include "system/whpx.h"
 #include "system/numa.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
@@ -182,8 +184,15 @@ void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_cfg)
     uint64_t *val;
 
     cpu_x86_cpuid(env, 1, 0, &unused, &unused, &ecx, &edx);
-    if (ecx & CPUID_EXT_VMX) {
-        feature_control_bits |= FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
+
+    /*
+     * Hyper-V in 26100 disallows this bit to be set.
+     * Otherwise a #GP gets raised.
+     */
+    if (!(whpx_enabled())) {
+        if (ecx & CPUID_EXT_VMX) {
+            feature_control_bits |= FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
+        }
     }
 
     if ((edx & (CPUID_EXT2_MCE | CPUID_EXT2_MCA)) ==
-- 
2.55.0


