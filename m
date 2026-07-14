Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D3CC44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 02:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjTA7-0008OI-Eb; Mon, 13 Jul 2026 22:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wjTA3-0008Nt-Hd
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 22:46:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wjTA1-0006ba-Ne
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 22:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783997176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5EmYQxtfgWJQkuqsSyOE1j6hfE8WRzBw4xEeURpSQRI=;
 b=KpwGLmGW035aH/1QGFIyTqIF6hTcuc36R+gNksdNZXEIsSv60gnIatwAdQ/nUftqYDGglf
 T8RBhM7KefuVxuVIcR74d0CsUMXfDR/xyP0tL2bdt4r9gGok1pdrilEqLjwJ4f3sOalyHK
 4UjuiHaAlaYPu1mi8UaGQFxCOdTRfN4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-VXAKD_FtPZ-bQxfRgHKTgQ-1; Mon, 13 Jul 2026 22:46:15 -0400
X-MC-Unique: VXAKD_FtPZ-bQxfRgHKTgQ-1
X-Mimecast-MFC-AGG-ID: VXAKD_FtPZ-bQxfRgHKTgQ_1783997174
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c860544c077so1055199a12.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 19:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783997174; x=1784601974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5EmYQxtfgWJQkuqsSyOE1j6hfE8WRzBw4xEeURpSQRI=;
 b=rZOUbcte0XCgKBTek2WrwtkAitoWXMR9bYVicFI4s5vBUXZxwfXilvfH+dVAMedd4k
 ycAMfiGmYQQyiv8pokcXGFUoUE+3VvrpWs11vUgLQPSMtFy/zsIZ35Dnd8Us7f8uh0j7
 u3NA6Y8CEB74lq02MhqDLVoze27IgYpVtTZTAWrUGt1VWM5jGX8I0TjHGfDpbd8vX7TY
 MHBYNeXzobF9eEDB0Qt5wE35Sb+gKWiVISbIIXXYysSvUIvKQjeOGj1FzxvPeLvzIThs
 Sx53W0IHs6gOhfkciJ368XR0EEZIQyhOMcZn4m2iFsiYIaislrMGqgefRIAq5qoyvrdt
 bp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783997174; x=1784601974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5EmYQxtfgWJQkuqsSyOE1j6hfE8WRzBw4xEeURpSQRI=;
 b=ryKMydtnKwr/zbhNVvVOvL9rryVugtrlZZ9tSM6mYT+vqfVgmcVlAxltSYzz5JSNbE
 o2WRIsIl6WzzvoJjNKKp3IskIMeDaR6lakvVsTADTvLeCxXjeXEmvs3Rh6WQd6qCww1f
 W8PF94g+ktIuQbHKO7tjcyvBSQCPZ3lB7YxqY1ZMICuCHh9cWC47IByjV8CDQRw6sLYv
 MXe8XqysxZI5ovnff0gm+f+1w7Iq5hrZLVPJaaEqZSgng2Q86T7weO88LWh1s0mFWeow
 Ce4IZrk9bOGQIYHkwg32h7mQ25C1t2eEXQsXraTBCbF1TtL8PgRd29EyiIv/YqGBEm1s
 LnEg==
X-Gm-Message-State: AOJu0Yz8URy7bT94pEF7pr94iN+s335INjMs52gnLIPU3U5szhMbzENH
 +IIcbU1A8aBXWHUgQ5L5EkvyTY2PvprWsOnYIQnnffA3KoyCpABp4i1uVFkKSy/MqGWhOS7a//7
 XLdOUrvpkQGC6QuDtBD38XunK2SSTW2nKfFDw6Q1+KiavXP5FXcUUihiSHNy2VPZ9
X-Gm-Gg: AfdE7ckmPkq34yl3Wus1BpVaGqGQ5mf7D4l4DeHb9STfhDt39i13Rhgq0dv6HH6Z3Xr
 YstS1EjhZXIbxJqUgwp4gs7fAkMbtI9UNdlaCATwut32qKxgatZ7OkKpvXK94T8wguqa5depIxH
 oC4PLCeirbFk/dSJ9Mt+GmjCD5MmsdSGBlHAi8d65Mi+IdsesbDse4F5I0L4PGZ1mXNUq0TxXF9
 ay0Uh+5i59cZUlQqC9lh4u6hidFDCQ7fkaYyYmbJDQQN742WppNeORja+Py2+1pPK9HpPuz9MeB
 Ia+Uxsyy0O6N0dPXHZ9y/wPF6KXV7UuW+YQNJIGEmq79u7i9uEY4pZS9w2bDoZE/Rr0Ael1bOA+
 3aSVEZfYoWvlDTLWKC5SpNzGHJmf60KsHwxT1uYaC7iNN/w==
X-Received: by 2002:a05:6a21:4889:b0:3c3:477e:5de7 with SMTP id
 adf61e73a8af0-3c3477e66bemr2856812637.70.1783997174114; 
 Mon, 13 Jul 2026 19:46:14 -0700 (PDT)
X-Received: by 2002:a05:6a21:4889:b0:3c3:477e:5de7 with SMTP id
 adf61e73a8af0-3c3477e66bemr2856782637.70.1783997173628; 
 Mon, 13 Jul 2026 19:46:13 -0700 (PDT)
Received: from rhel9-box.lan ([223.236.229.143])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-13b924258a2sm60184658c88.1.2026.07.13.19.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 19:46:13 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 3/9] igvm: cleanup memory regions
Date: Tue, 14 Jul 2026 08:15:22 +0530
Message-ID: <20260714024557.204578-4-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260714024557.204578-1-anisinha@redhat.com>
References: <20260714024557.204578-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=anisinha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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


