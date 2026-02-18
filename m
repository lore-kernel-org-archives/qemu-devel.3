Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31F7E9A04C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfxf-0003D9-Bu; Wed, 18 Feb 2026 06:43:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxU-00037M-U7
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxL-0007mY-T4
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771414978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ILLZe/318SI2fwBccfO7VLFYXHx8OHK07juZHL2pnss=;
 b=ctz+YeRqqnGkx5QWnaOOt35xDpSVHsoakdEgUCbmbGL8Pun8Ntbiup/WU8Ekv7SrO8jJuy
 RsanmjIn8BbkICwn0Cfyq6xkHzX8Uje8NLaYQVTc4+BfGVC3VM6G6HabJOpNLLpixByyPh
 ZQ1L7s3KSe0MZhYbEqUq35UijpMYV5U=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-SXFvyQPSODugeHa5r82fiA-1; Wed, 18 Feb 2026 06:42:56 -0500
X-MC-Unique: SXFvyQPSODugeHa5r82fiA-1
X-Mimecast-MFC-AGG-ID: SXFvyQPSODugeHa5r82fiA_1771414976
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2aadeb3dee4so311566045ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771414976; x=1772019776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ILLZe/318SI2fwBccfO7VLFYXHx8OHK07juZHL2pnss=;
 b=olME3GTATuHySEZmGUz5Tl8bOjKT+T79OiEiauHoQnj874vINIoE9qzvFSfyVQn+sD
 qLi7FbgMbLdIh8vU/kxfp7jiqZqVL/j0YPKKarf+0YovNd7pNsA5j8pMauVtlA2TZsBC
 yE/GVS1CdmPNOVwhnbppVXKBbc57dAOSpy8y5yvFHEqgRZS8z5Wh7vYIPD0tH68Pmljp
 F+pBcMGyaczq7A7Istms36iygYFgzqH1KZusOIKtfxHyr4dEwXgd7utYWIeLG4mjHBGp
 IuCsinYd451ISoKoXw7VrGpNlGHpTQCJI6Q172u32KHFAtHHVP9vD/9P0AX5TyaqUhMZ
 HNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771414976; x=1772019776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ILLZe/318SI2fwBccfO7VLFYXHx8OHK07juZHL2pnss=;
 b=Yso2k6wOwMrTMPMQpO8rWG7Xr6dv2yhO3wcKXb8lR6EB+pmok7XZTQsaF8ELCaW5Cr
 ecLGPk5HT+1t9pO9EmT999LRHlZgfKm4V6BxEpj3MxMXyb4WXDlXwshG7stT1w7hUfNl
 D8YJvLtnLfaqsT/VOOu9iZMCdW+fuEhD1M1wqyG5ZqZ7VNIa+u7SJ55qFUDC1HSOdyhz
 AjY1nJLT8gViURVNbhMAgIWTCUglPxw8xdQHKsvTiNMzKcghV6ns+CDZV7oAnXnB3qOh
 ZE/z5puHCmnbtOtlS23BQbQqtPslcT9O9A2Ugk31HqlPQSqlQ5EMxgi/+M1BCRgY4673
 TTSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqZms6iwRZffCVSPsHLeq1W6VV84ggBS8K28TqOsAOiZM9azlOvAHn2y2dZb3ctEwQfAenAi8PdBQI@nongnu.org
X-Gm-Message-State: AOJu0Yx5JB/i5e+a7JGj1kTqG6Nev3u+gzzoP3Uc7fYnbMq0MgTt7J6s
 721WpMSweJ4Xg07Csl1YW6on2Jku040i4MfTXlV92nMT31leUoQX1dx1vTDCpQ+l+GM4vqsI0y7
 mzkSraOQWGS+lJEZRpfJogqUB1z+Cz7yArfXyaV7qwmDTKHvj8MkbTNTD
X-Gm-Gg: AZuq6aK9xJhB9yrMYYqTKpo7JT5ys0D4jQl0r9FWWkCMLZrBnGAMGWddKvMdRJ2WSde
 0XwVj237XSufavN49eG5tZaPJuGgFSM1QIuGIRwW3kj76FFNtQbBMsy5bNlEPiPC+/I94vTYV6Q
 khvgrofax5Ag2/htni8CqfrQg6NXSvuzj97FlPtS/iPiTCZ0O5NY8T+v3bvhyxK8Oc1ufRtT9+d
 gQNAXRuX7w5lnU+8wAYlFL5cyxWrT+reOWNbowWsyvoGfXPzt8niCvZeO7w04A0CtYYP6H/Km0E
 eTbQ7Ct0NMh2J0v+K2q96ANOXpKZVOT1T8TkaAwxFHqEetMn2BQt8yTUBIf47Mvj/E3HzVtqF03
 rW1qIcGO9jzAyFOlXGiEtBCwoO2INkE9CUCDIeyigM9RhNtb8rheA
X-Received: by 2002:a17:902:c94b:b0:2aa:cfee:a47b with SMTP id
 d9443c01a7336-2ab4d09c4famr209209435ad.54.1771414975855; 
 Wed, 18 Feb 2026 03:42:55 -0800 (PST)
X-Received: by 2002:a17:902:c94b:b0:2aa:cfee:a47b with SMTP id
 d9443c01a7336-2ab4d09c4famr209209245ad.54.1771414975453; 
 Wed, 18 Feb 2026 03:42:55 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:42:55 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 03/34] hw/accel: add a per-accelerator callback to change
 VM accelerator handle
Date: Wed, 18 Feb 2026 17:11:56 +0530
Message-ID: <20260218114233.266178-4-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

When a confidential virtual machine is reset, a new guest context in the
accelerator must be generated post reset. Therefore, the old accelerator guest
file handle must be closed and a new one created. To this end, a per-accelerator
callback, "rebuild_guest" is introduced that would get called when a confidential
guest is reset. Subsequent patches will introduce specific implementation of
this callback for KVM accelerator.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 include/accel/accel-ops.h |  2 ++
 system/runstate.c         | 38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/accel/accel-ops.h b/include/accel/accel-ops.h
index 23a8c246e1..f46492e3fe 100644
--- a/include/accel/accel-ops.h
+++ b/include/accel/accel-ops.h
@@ -23,6 +23,8 @@ struct AccelClass {
     AccelOpsClass *ops;
 
     int (*init_machine)(AccelState *as, MachineState *ms);
+    /* used mainly by confidential guests to rebuild guest state upon reset */
+    int (*rebuild_guest)(MachineState *ms);
     bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
     void (*cpu_common_unrealize)(CPUState *cpu);
     /* get_stats: Append statistics to @buf */
diff --git a/system/runstate.c b/system/runstate.c
index 13f32bed8c..e7b50e6a3b 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -42,6 +42,7 @@
 #include "qapi/qapi-commands-run-state.h"
 #include "qapi/qapi-events-run-state.h"
 #include "qemu/accel.h"
+#include "accel/accel-ops.h"
 #include "qemu/error-report.h"
 #include "qemu/job.h"
 #include "qemu/log.h"
@@ -509,6 +510,9 @@ void qemu_system_reset(ShutdownCause reason)
 {
     MachineClass *mc;
     ResetType type;
+    AccelClass *ac = ACCEL_GET_CLASS(current_accel());
+    bool guest_state_rebuilt = false;
+    int ret;
 
     mc = current_machine ? MACHINE_GET_CLASS(current_machine) : NULL;
 
@@ -521,6 +525,29 @@ void qemu_system_reset(ShutdownCause reason)
     default:
         type = RESET_TYPE_COLD;
     }
+
+    if (!cpus_are_resettable() &&
+        (reason == SHUTDOWN_CAUSE_GUEST_RESET ||
+         reason == SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET)) {
+        if (ac->rebuild_guest) {
+            ret = ac->rebuild_guest(current_machine);
+            if (ret < 0) {
+                error_report("unable to rebuild guest: %s(%d)",
+                             strerror(-ret), ret);
+                vm_stop(RUN_STATE_INTERNAL_ERROR);
+            } else {
+                info_report("virtual machine state has been rebuilt with new "
+                            "guest file handle.");
+                guest_state_rebuilt = true;
+            }
+        } else if (!cpus_are_resettable())  {
+            error_report("accelerator does not support reset!");
+        } else {
+            error_report("accelerator does not support rebuilding guest state,"
+                         " proceeding with normal reset!");
+        }
+    }
+
     if (mc && mc->reset) {
         mc->reset(current_machine, type);
     } else {
@@ -543,7 +570,16 @@ void qemu_system_reset(ShutdownCause reason)
      * it does _more_  than cpu_synchronize_all_post_reset().
      */
     if (cpus_are_resettable()) {
-        cpu_synchronize_all_post_reset();
+        if (guest_state_rebuilt) {
+            /*
+             * If guest state has been rebuilt, then we
+             * need to sync full cpu state for non confidential guests post
+             * reset.
+             */
+            cpu_synchronize_all_post_init();
+        } else {
+            cpu_synchronize_all_post_reset();
+        }
     }
 
     vm_set_suspended(false);
-- 
2.42.0


