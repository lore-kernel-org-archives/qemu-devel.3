Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4ADC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvyCo-00005u-PL; Mon, 17 Aug 2026 10:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wvyCk-00005c-MZ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:20:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wvyCj-0002eA-63
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786976444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oyr4GIu9nnuR3+KUBEFmE8MavH0ehn7PwDYD/eNOVzQ=;
 b=LNXXYmJ1F5I582SjwuT9Bph3wd1nFt95rArVEOb6ZBlhDNenmf7kNEHAAxb6oAqATA+MbX
 psIxkvxKmFW6b+lgkRhG6dy0gd6xtiZBu0EcC6Xy4x8pPtvrQJBD/7Lm3/tsmD8v0wJbLH
 7rmrUL21r9Bsk9fTrMJ60z2LALIn730=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-567MciMqPBmysyzewZTSyw-1; Mon, 17 Aug 2026 10:20:42 -0400
X-MC-Unique: 567MciMqPBmysyzewZTSyw-1
X-Mimecast-MFC-AGG-ID: 567MciMqPBmysyzewZTSyw_1786976442
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cceabd70f5so82359495ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 07:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786976442; x=1787581242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oyr4GIu9nnuR3+KUBEFmE8MavH0ehn7PwDYD/eNOVzQ=;
 b=V721GmB3hiUYBf39TXH8MD6Lf5RvBcYo2rABbgnvz6lLZJbEyyP/SHnxcNgxH1zC8O
 V5bwSOMmlFOvtRIEKLiTysJjbmBIuyO62SRxO6roBeuqK6YCuHXF3nsBwOHf64Xajtat
 jVk5Z08qSfLDWZ/Wj8MONdbCGpGBai0oQ7QCSerCGqju8qCDtb/cI9BNy/OsE9ji++5u
 jsKoQuwVqfFtGd2w5N/LFM1a0lNn3UhEQ3vKHP4uogY9RcaT84XDc4Yh8KtoIJ51xeR9
 THQsD7qxGnXezdDd3MLAUZl9WHQFWHcOAWQ5QapZNOuNj7CMKNuqkoG31Pm/gbAbGJKJ
 /+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976442; x=1787581242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oyr4GIu9nnuR3+KUBEFmE8MavH0ehn7PwDYD/eNOVzQ=;
 b=bckpHefaiwc9R0Ept/sQ35wxZtTckxB87917mhvezomVJQr77etWgE2IG1bWX7yJ/0
 UlvNk4gViqavAQu1g6/nXGhQSAALyYS9g5Wkhgm46AuVKIjnbaJbbGbcy/LfmqEci37A
 PSbsiXnSddW9ppWmgjKCw0SnV1VIwIsqVlS6xLyankpAlHbJaOb6nfZE+f+fkEvwTSrf
 0tVD5QgnhlrJQLTDGhnSy9vxCS4iMcatHUXQsDah/s8c0VOi9d7frARSGSzsxomPTG7A
 5pGamLrK38+hJpBcfxrNc5LePvqjz470+7KcENzB8ptKr58cASzqevkXJf2GDl7ZcYS0
 C6pg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro1WxTqOn0HUVXfXa3By9S/fVcsDYz5QPWhkKSCG80UNNmgaWwrhn/xMAK6mZwOc4VPN0/4PJieLp3e@nongnu.org
X-Gm-Message-State: AOJu0Ywk/jsQQlMZxgcU/CDb1qoIZwdq2jIRc7WYQJjgw8MQJ50Lx/Qu
 qAdbBd9OWCznloQfOXhQGHCP2BZHEZ9ywR+tkBsdR127JsKA5Dw6GE+6gI1dE4LxKaaAHTAsVUH
 Gs2u981omHE2mnfuL8zTgoiyrI96ykLnXlcIsSsZExImtvALKoD8hc6gE
X-Gm-Gg: AR+sD121DeWC6L/x8S+x5pmyqK/OhOTlmrbz+K054kW8Q1ZMvTrqMD2eXuhaxZz7O9u
 kh4MAjezkIV+pR/nFRNM/1B/7sd0nmrUvFlAv0YsZyIGERZOddw2Y/9Mi9REYZupEg3lzbreS1t
 cMcBSKqGDkQR5NmfzWpczdceqp7JWRckoi10CiYLyHQerC2Pes8QfGy4ugX9EDOGW/N2f/8fMoT
 NoqrMH0EGspOochOtuwJXkohiXn0U/UzDY/NgKUwrH5OZFgdG6UUVuBDF+BKdSV0cDOB6lAgO4I
 KqOGiGXUCRRrFmyBd29F1H5XLvwRo8SDAgog6xSSegCvx3kI4MBA+mwrgkPZv5/5UfPDeFREIpU
 xpxCHcAs8QnXW4WSL8x/fV5m8xR/D01M3RA==
X-Received: by 2002:a17:902:ffd0:b0:2c7:1200:bd7e with SMTP id
 d9443c01a7336-2d3b0c9fa6dmr273330305ad.18.1786976441575; 
 Mon, 17 Aug 2026 07:20:41 -0700 (PDT)
X-Received: by 2002:a17:902:ffd0:b0:2c7:1200:bd7e with SMTP id
 d9443c01a7336-2d3b0c9fa6dmr273329575ad.18.1786976441013; 
 Mon, 17 Aug 2026 07:20:41 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2d5c1efd10fsm3705105ad.81.2026.08.17.07.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:20:40 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: ani@anisinha.ca, agraf@csgraf.de, graf@amazon.com, qemu-devel@nongnu.org
Subject: [PATCH v6 03/11] igvm: cleanup memory regions
Date: Mon, 17 Aug 2026 19:49:58 +0530
Message-ID: <20260817142010.80693-4-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260817142010.80693-1-anisinha@redhat.com>
References: <20260817142010.80693-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Gerd Hoffmann <kraxel@redhat.com>

This change cleans up existing memory regions that were created by the current
IGVM. The cleanup would be necessary when a new IGVM is loaded. This cleanup
function is called in a subsequent patch.

Reviewed-by: Alexander Graf <graf@amazon.com>
Tested-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm-cfg.c   |  2 ++
 backends/igvm.c       | 19 +++++++++++++++++++
 include/system/igvm.h |  1 +
 3 files changed, 22 insertions(+)

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
index 9e7c90d386..9b101c8182 100644
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
@@ -1109,3 +1110,21 @@ cleanup_parameters:
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
+        /* this triggers MemoryRegion cleanup */
+        object_unparent(OBJECT(imr->mr));
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


