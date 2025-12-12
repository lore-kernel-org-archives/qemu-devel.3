Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E49D49232
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4hN-0001s3-QV; Fri, 12 Dec 2025 10:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4h9-0001mN-RU
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:04:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4h7-0005d7-OF
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fgE5JBgOck8bhBbl4vJwL9OjfVs83p8a3NNrk0CxA1U=;
 b=ajfUlMUs5BZuSQDmOnu5FIsYBO3pynkzOJOZaJ+k5VOgzIduDY4/eX7iIDGaplj0AJxhL2
 jrakPiEPs3+yh3s4nkEQysKQ0++Gb6PNqV3BJ1XEfMkR82p0uRZc7KcXQpHOwnj19J2eRo
 2jMhzQHu5NReVQwuYBJY0/VqNLnbCw8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-CaLLAvAPN_-WYZ-JiYp2Cg-1; Fri, 12 Dec 2025 10:04:30 -0500
X-MC-Unique: CaLLAvAPN_-WYZ-JiYp2Cg-1
X-Mimecast-MFC-AGG-ID: CaLLAvAPN_-WYZ-JiYp2Cg_1765551869
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2982b47ce35so15028315ad.2
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551869; x=1766156669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgE5JBgOck8bhBbl4vJwL9OjfVs83p8a3NNrk0CxA1U=;
 b=TNTAkGCgRIu4AzqhTjz1ceTWjiWWkd5+jGhuatiUUj1Dyr1jdIqnZq7OuQHQkSHtUj
 wvfgutqKz+GmB8jLohnYmCAMwvxAuQDdJcD0ZFnzFWHrLzCVozxtTcbNx9WT5xD1ySkN
 mhEU6XTc+cBQo+eorCsXCf/IlY0SD/XWwedc0AHQolA9vE/pqWDqagc8xedQ+KsPGm8D
 orpQNDfMNQl3aFVa/towONeDy5h3X2Tr06bX+6r3WV/Feb2pMc5Urkd5EFtzQy/Z3NPw
 cBLoCjz1GRTh2UhGVsmJPO+NmADFjNMCf6O/lwEYJVu8MCIemzvWnLC3RZqYnllvKcnU
 o62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551869; x=1766156669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fgE5JBgOck8bhBbl4vJwL9OjfVs83p8a3NNrk0CxA1U=;
 b=dgmXK7Wa8G8mhboYt18jdb73FZMIG9rJqXlFF3iohv2X/DWDX7Z2E/M4SwB9SIMjWN
 3Zi2vr+/Pz5/7AYa5VlSKn4iV0mAjV1Laimab6CBQtLAJhVmCKhiYuRk1bSyd0xHpjTM
 GHVky+3+wlZMtjzWO3ALd2KqO+SkMqQbPWEU7aeOEtiaPAkYZiFZwxrRzELHS7Jw5zsW
 ZUBV+ZhyFMxCri7WwTHTSMqbzO+UwvMShnw5nzofhWOUJojcOA5fG/guvOBJltSIniNN
 4lEV5qikCumSboWdqz7YipYp5Yj5MBkWnXPsoVqQelAtLV7WDga5ighysUEshaCogGhM
 /Xfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWECcj2492ROB1fUpn8+RpqekCvhmv8lPdRcHrMByolrN97AhoTiVsTPE4L4KBwQGQIruhqMfQmWaV8@nongnu.org
X-Gm-Message-State: AOJu0YwvmFNzx1Q4IRMtcK5BI13fprvFXsXlFp29jF8IbGeP5HBpvfhQ
 TmTqJj2IEvcWz+Y3AWIS7zC81Ghpbt9OOf8J3K/CxmqF45kCUqLMjCWglLTW49gD0aZgfNPd5M5
 ohx+F9gSqIFCduk/RAswSM0dmBjMYATppbAMorYndsgYQFvXnRoNIazhX
X-Gm-Gg: AY/fxX7AjGqO0pwac2AGCGIDZwfkSCXgWY0aD1O15CPEj/5LQDU2Ry/v7s9HvDmdVbw
 iAe41YYaCfzaZodvfPIXCjDxqY1vhOG1ZsR/M00aGWfjX12TT52ttagkEjbq3CB51P91egMYPAG
 KswWZiv3RvFCHhbbCFLqf5d8fKKA8xrV1YmUuGN0/lmVo6hRVUM6p575MdJqTbZnLH59pzAadxF
 ydGqFqGcgVheWREAC5zL7HLpqsB9hG/IfU5PCjWIQ59X3Dvz0n5tI1DomfpK+H/2SvsCMrX2Uk1
 TpCWpNMforavBBIZQQfMdSLMVhinZLy6b77z2Vzd/LJ3p84QKqCdbk7ie8ErqTWQzUQqjLA1pAy
 +MoN/GLMdK1wVEnG3g1/OpryP2wDkfqeqIsP2lLI9+tQ=
X-Received: by 2002:a17:902:bccb:b0:297:dde4:8024 with SMTP id
 d9443c01a7336-29f23e365b8mr18432405ad.23.1765551868827; 
 Fri, 12 Dec 2025 07:04:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+PdmcFYkkR2Z9SqvslbvGatym9KzL9pUSuCUc+p0DbYISKKoUV5SGEo/iS8H22JX9vmWfeA==
X-Received: by 2002:a17:902:bccb:b0:297:dde4:8024 with SMTP id
 d9443c01a7336-29f23e365b8mr18432065ad.23.1765551868285; 
 Fri, 12 Dec 2025 07:04:28 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:04:28 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v1 02/28] hw/accel: add a per-accelerator callback to change
 VM accelerator handle
Date: Fri, 12 Dec 2025 20:33:30 +0530
Message-ID: <20251212150359.548787-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251212150359.548787-1-anisinha@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When a confidential virtual machine is reset, a new guest context in the
accelerator must be generated post reset. Therefore, the old accelerator guest
file handle must closed and a new one created. To this end, a per-accelerator
callback, "reset_vmfd" is introduced that would get called when a confidential
guest is reset. Subsequent patches will introduce specific implementation of
this callback for KVM accelerator.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 include/accel/accel-ops.h |  1 +
 system/runstate.c         | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/accel/accel-ops.h b/include/accel/accel-ops.h
index 23a8c246e1..998a95ca69 100644
--- a/include/accel/accel-ops.h
+++ b/include/accel/accel-ops.h
@@ -23,6 +23,7 @@ struct AccelClass {
     AccelOpsClass *ops;
 
     int (*init_machine)(AccelState *as, MachineState *ms);
+    int (*reset_vmfd)(MachineState *ms);
     bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
     void (*cpu_common_unrealize)(CPUState *cpu);
     /* get_stats: Append statistics to @buf */
diff --git a/system/runstate.c b/system/runstate.c
index e3ec16ab74..f5e57fd1f7 100644
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
@@ -508,6 +509,8 @@ void qemu_system_reset(ShutdownCause reason)
 {
     MachineClass *mc;
     ResetType type;
+    AccelClass *ac = ACCEL_GET_CLASS(current_accel());
+    int ret;
 
     mc = current_machine ? MACHINE_GET_CLASS(current_machine) : NULL;
 
@@ -520,6 +523,23 @@ void qemu_system_reset(ShutdownCause reason)
     default:
         type = RESET_TYPE_COLD;
     }
+
+    /*
+     * different accelerators implement how to close the old file handle of
+     * the accelerator descriptor and create a new one here. Resetting
+     * file handle is necessary to create a new confidential VM context post
+     * VM reset.
+     */
+    if (current_machine->cgs && reason == SHUTDOWN_CAUSE_GUEST_RESET) {
+        if (ac->reset_vmfd) {
+            ret = ac->reset_vmfd(current_machine);
+            if (ret < 0) {
+                error_report("unable to reset vmfd: %d", ret);
+                abort();
+            }
+        }
+    }
+
     if (mc && mc->reset) {
         mc->reset(current_machine, type);
     } else {
-- 
2.42.0


