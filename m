Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D1BC9EC8F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHtT-0002ZE-G2; Mon, 12 Jan 2026 08:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtN-0002SS-0U
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:23:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtL-0003g6-3N
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:23:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J4r17Ft86Qgzjssjh54bFN1Ri7K+Nkr0hfz37LjhFXo=;
 b=C93kK8ge7k1yoKe1hBaW1dQKee6qmEGta/jqwW5xMoi01YR2jolavvCURUV5iYZPUar0Bw
 QtJdgRLcAR73mOPIy/f/93+ukaly8IgUd2FQdbgPq5gdcpMP8JE+qsako3b/+/WV/m9CB8
 g1b/du2g6xpOph95s5nyBoW2v4+Ng+g=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-C2a0Y7hSPz-48kEay518ww-1; Mon, 12 Jan 2026 08:23:29 -0500
X-MC-Unique: C2a0Y7hSPz-48kEay518ww-1
X-Mimecast-MFC-AGG-ID: C2a0Y7hSPz-48kEay518ww_1768224208
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b630b4d8d52so4537808a12.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224208; x=1768829008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J4r17Ft86Qgzjssjh54bFN1Ri7K+Nkr0hfz37LjhFXo=;
 b=HkUOu4FqlN47rTZXj4nq+PdENYjUshUDZoV0dS55+M69QL9bkOkc0hci5h3t5uR0EF
 Ap6JR4qKjAPppofsSEeYPc43q9zyIouMaWA+RsvEmMxblb1IC8yGc3S82mb0CJxGN8EL
 ar2diO1fb1zBDrvtYVU470dirkVOUKrzqBeY7kMB7oQEOtXMeuUhYUebCbGx8sWI+2pS
 PcycctD4nSgI0fHvqF4eE/T7CTuCcfAtrCK0qDbl4hhCCI6bABz1fgIthexzYhVeYP/n
 xkDVdw48ZZwI7AnsRSo6ebP1T1kWck1vQtAVAZnJBwDTRwDNTYpN1w1CkvjOztGXZzAl
 iY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224208; x=1768829008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J4r17Ft86Qgzjssjh54bFN1Ri7K+Nkr0hfz37LjhFXo=;
 b=lOcXm8ScW4qJzMPHWdZC9+DRpEcEJJfYA72RDGkj/4j8CSolPUL1XiAtLnkWdK6RyA
 /i8mqAfcsgcsriZT26XFDoIzeWdQBRK58WoRAc7yYuKrHg3eSnwV73HRSX4/Yynt1UwL
 F9RSClCtV7c5j210JtasaEybZIcdOKr/oKBNp0aiCI/lGpiF7tKDhJ2MW+igy0MRtAaj
 37+reHOgKpguRR987xsx2CU4rnm3wum8NfhO7YietFaDW5jryTULciSvLHYTe1oloqYz
 WoLL9eTAWGtw4ZBC1yuovUGoVihi8v4jGshG19Ow7YTEwVlO9GTdl+1fc7koEC4sBohJ
 tlLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvwvEFcaY0M+trHjQdD5R9u+icglGICXQ8pOUgKvbzcMIW1Vv3+0+XN8kwZwHabyxAoEjxyeWkb7S/@nongnu.org
X-Gm-Message-State: AOJu0Yx0cWRbIxdB3FQFOhPDaKgpqBQwQWmwIBrbk2NsnrOJvrIRg+Lm
 6z6dAkmbbMSrlxzfsvbYz4SHF9LawiiStgOf/uIYZSFU5Ir3qTa8opOk3Ij1c07xnMxRUOlDxmw
 FlQ9XJzYJ03Qfk4Z0plSnasmp/XUv7zoVG9Jxe4Sp+3TcPND6GKoNdiHs
X-Gm-Gg: AY/fxX6juyVd242UBkUQvQL9YFAeyZ5e1BeRn/Bqx+JrOpBoOimHih8Vxm9jyqBMSjg
 cskWth6gpO50GzC8Nnh8akzEQoKEaTqfHDt45aS/MF8oghNiEtexVC7yyQvCeX1+i3e6unMWJrj
 dsOJdo+X3f5+6w0kOmjsdWgjlmoFnXDBiFcW1VhtWcIjY7M2VfT8JVJWHGijFKJPrwUx/OZzXQ+
 0H9uUUFFrQS/lJFvU2SYUvr5gsivJ6X9OCmmNYMsBhMMnHya0J3LZFocIg2SRYFdUdSmvKWeyC4
 8a2KvzFOF08dJgUx0zpWWX3v71vihUh+dX9KGVQKtrunP9Tj40mOsyTEHZeeerZ96j+fmnOUKjz
 WxiUjZmO7BDEqZeeQRQOfevjajOjfGrzY0iuObE2ws00=
X-Received: by 2002:a05:6a20:12ce:b0:366:14b0:4b07 with SMTP id
 adf61e73a8af0-3898f993beamr17620612637.67.1768224207916; 
 Mon, 12 Jan 2026 05:23:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHm/f2phZmmT/EfkoFxcp9vC5gPdRBBU4oQhViaJUnHLPkiNObkA7wZKgkY891aWfpND+Vmrg==
X-Received: by 2002:a05:6a20:12ce:b0:366:14b0:4b07 with SMTP id
 adf61e73a8af0-3898f993beamr17620594637.67.1768224207502; 
 Mon, 12 Jan 2026 05:23:27 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:23:27 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 02/32] hw/accel: add a per-accelerator callback to change
 VM accelerator handle
Date: Mon, 12 Jan 2026 18:52:15 +0530
Message-ID: <20260112132259.76855-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index ed2db56480..b0ce0410fa 100644
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


