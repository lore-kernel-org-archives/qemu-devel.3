Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C1FC54FDF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpKxa-0008A0-Bq; Thu, 30 Jul 2026 03:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wpKxU-00088p-1y
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 03:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wpKxS-0007vQ-1T
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 03:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785395612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5EmYQxtfgWJQkuqsSyOE1j6hfE8WRzBw4xEeURpSQRI=;
 b=eFCa+rXA4sDFCg3kNWMgQ/hUfcwan958egIRsR1gzDyDFcpE82e9YUpb4DCyl2eCIBDItj
 sfNJWQr3vZd5Fb87i3ahoNuhKkyRKfbR+NJQhtiDKCbd+lzfu3zex7ViiqTkZ3wYH1bKg9
 yT8OH6cWtwNdBPO4cg4pfRBvTK+UyDs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-A1T0lFBaOkm1gPmzGfPYOw-1; Thu, 30 Jul 2026 03:13:29 -0400
X-MC-Unique: A1T0lFBaOkm1gPmzGfPYOw-1
X-Mimecast-MFC-AGG-ID: A1T0lFBaOkm1gPmzGfPYOw_1785395608
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cccfa32670so20406815ad.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 00:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785395608; x=1786000408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5EmYQxtfgWJQkuqsSyOE1j6hfE8WRzBw4xEeURpSQRI=;
 b=nxMn9EPws/XZ3wvGxpO75D6j6OGNMuygzBMq2aOdAN55rFoc6hxbVuUrCv/Nhi9LZK
 /rBUShe4W3lOKE67hAGPgKpJNHHBvGwBIpGK+9mEPp81kdd3JlI7y0XS0Qms0qBJtfPe
 Q/WbjA6R+juHqiHqS5bU5qGHwlg6aKuqQGyyPj8YNaAu8gGvV/CjzV33ADj0qB2bwP63
 /rb5fcYvLeDj7Dxh5XnpYAulq61sZ1y0WowGUdqXsbHqPm7JkNIVCtQYmrwpYRwn7lNz
 7sbLoLSyJ6PlCuJX7zmDZHArYXjtug+pjBduA79JSt2/xjRJb3cfHlckrH1KcvioHF+C
 4nFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785395608; x=1786000408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5EmYQxtfgWJQkuqsSyOE1j6hfE8WRzBw4xEeURpSQRI=;
 b=TCUJqjCXii2VIkMoJ+6NDopT3lHecTNyu/ZzcvD4SZhP5Gb1HcH8Aq13byaHdF0+PR
 IUi7FsO1v3gqEvREJ889fUQnzu1kebLx3UZ5pXpfUHFc6ZE2c4b9O4m9Z7D05SuSRfHo
 mQ6LqaBgq2QfHFQMCeqmrnOaEImx1Y2kDypi8C9sjhs/kap6IxW6Gd2wKLWf3PmKX7fS
 UvLSkXn3L1b+jsky5ox1+NBLvZG9LC7szaQZVYcKs/RYq2y5MLvejvTgRL7wtcdqtlEL
 FpQgVV5S44nFtsC9nhZutf4hb3uuGh+DYqrqr9LOy6JObmYqb2Kqye/xWZqj8q4RTKSh
 PkxA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqeT7rrQHOuT4dwcQ8YbxUJOr0GgfqiaP5iEEVRAYk4gYqV4L9ANOJD6qXVPwZz9VN5QKI6+d/ByAwr@nongnu.org
X-Gm-Message-State: AOJu0Yzjoy+VOG9E/Ue3z8eCxiXtUpMJVKntvlq+NY/Qx/JPUJEgaNaL
 MKzP2P1zrzF6sKX4cP8cUyhsuD00Qh1NQYlBD/jjEXLXV8qQDYlAQBiILCYdBVwQ50rCSbl6bb3
 FipO5rQ1Q0jnduQv4zJ1RjRzryKELx73WN2TIlXUZy3MfV7TWISvMDU3j
X-Gm-Gg: AR+sD10tb4xSSVg0eAQRISd4IdcNuFsG8RWwj5GZfGtOhoiZ+LRtWN6Bn14ZyjCoE4L
 TCLt7nQwe01uJrffSOaWLazfnBGr3d0OJKwLhZoS2I9YmwkTNUAuqzqAIXSSv1WoexGYRfMO7sN
 S8rOFT3K+AO5s+F9eW8DpWMN5THcmRiub1eL49c4/fMTkwwmoq+pYETv67cOsfXcwZwtl1/Y+4K
 6Mo4ZCzgDUMnz1Hz7W/0ePWhQU8KBo4ylAgjbiaDruSRYQxcx5XiK6bfa4HyHUZECHWN9bHyOXN
 7l09dbo8aqFbnhi4RZ1zvaveIzCy4AgOfd4jMF8c0ipAzT0TCkFy3uE22qh4nAd9PLAn31xKyfH
 bYAMJ+ZNlAbBUPNm1yXsbMoWp/IcTAqGuKJw=
X-Received: by 2002:a17:902:d98d:b0:2ca:ec6f:aeca with SMTP id
 d9443c01a7336-2d035c1bfa1mr14134195ad.8.1785395608478; 
 Thu, 30 Jul 2026 00:13:28 -0700 (PDT)
X-Received: by 2002:a17:902:d98d:b0:2ca:ec6f:aeca with SMTP id
 d9443c01a7336-2d035c1bfa1mr14133995ad.8.1785395608059; 
 Thu, 30 Jul 2026 00:13:28 -0700 (PDT)
Received: from rhel9-box.lan ([223.236.229.143])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2d022a15893sm21864835ad.4.2026.07.30.00.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 00:13:26 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: graf@amazon.com,
	agraf@csgraf.de,
	qemu-devel@nongnu.org
Subject: [PATCH v3 3/9] igvm: cleanup memory regions
Date: Thu, 30 Jul 2026 12:42:30 +0530
Message-ID: <20260730071254.80695-4-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260730071254.80695-1-anisinha@redhat.com>
References: <20260730071254.80695-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

From: Gerd Hoffmann <kraxel@redhat.com>

This change cleans up existing memory regions that were created by the current
IGVM. The cleanup would be necessary when a new IGVM is loaded. This cleanup
function is called in a subsequent patch.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm-cfg.c   |  2 ++
 backends/igvm.c       | 22 ++++++++++++++++++++++
 include/system/igvm.h |  1 +
 3 files changed, 25 insertions(+)

diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index 38438a7b1e..935ba54f54 100644
--- a/backends/igvm-cfg.c
+++ b/backends/igvm-cfg.c
@@ -52,6 +52,8 @@ static void igvm_reset_hold(Object *obj, ResetType type)
 
     trace_igvm_reset_hold(type);
 
+    /* cleanup existing memory regions first */
+    qigvm_cleanup_memory(igvm);
     qigvm_process_file(igvm, ms, false, &error_fatal);
 }
 
diff --git a/backends/igvm.c b/backends/igvm.c
index 9e7c90d386..c7520d58b7 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/target-info-qapi.h"
+#include "migration/vmstate.h"
 #include "system/igvm.h"
 #include "system/igvm-cfg.h"
 #include "system/igvm-internal.h"
@@ -1109,3 +1110,24 @@ cleanup_parameters:
 cleanup:
     return retval;
 }
+
+/*
+ * cleanup any memory regions created by qigvm_prepare_memory()
+ */
+void qigvm_cleanup_memory(IgvmCfg *cfg)
+{
+    IgvmMemoryRegion *imr, *tmp;
+
+    QTAILQ_FOREACH_SAFE(imr, &cfg->memory_regions, next, tmp)
+    {
+        memory_region_del_subregion(get_system_memory(), imr->mr);
+        vmstate_unregister_ram(imr->mr, NULL);
+        QTAILQ_REMOVE(&cfg->memory_regions, imr, next);
+        /*
+         * imr->mr will be freed when all references to the memory
+         * region are dropped. Freeing it here will cause memory
+         * corruption.
+         */
+        g_free(imr);
+    }
+}
diff --git a/include/system/igvm.h b/include/system/igvm.h
index 64d3542311..e219f1a4ed 100644
--- a/include/system/igvm.h
+++ b/include/system/igvm.h
@@ -20,6 +20,7 @@ typedef struct QIgvm QIgvm;
 
 int qigvm_process_file(IgvmCfg *igvm, MachineState *machine_state,
                        bool onlyVpContext, Error **errp);
+void qigvm_cleanup_memory(IgvmCfg *igvm);
 
 /* x86 native */
 int qigvm_x86_get_mem_map_entry(int index,
-- 
2.42.0


