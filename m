Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7C7D25938
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbRY-0006gn-7s; Tue, 27 Jan 2026 00:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbRW-0006gX-Nt
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:16:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbRV-0008J0-8V
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:16:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4neZNfvTortxzJ8i3PhQK7rIiHo+6riare2hmpih5To=;
 b=XyQnAsSo5XMTWVxWdmcW0U5gByJJ5XxRlvioPSuymkNOvaiDGAu+9XIoHsN+1gie18/kAA
 23BqmQrw2Qqxk2vIhuyujhG9KF+GMln+3C5OrQ2+hP3u48FcvjMTT2NZVpPtyD0yWIk7si
 zpTH9ufK+RhN39MkdJmzamM+7eXmqOU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-jxRVX861ODS6yEZAj6Q6Lw-1; Tue, 27 Jan 2026 00:16:42 -0500
X-MC-Unique: jxRVX861ODS6yEZAj6Q6Lw-1
X-Mimecast-MFC-AGG-ID: jxRVX861ODS6yEZAj6Q6Lw_1769491001
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-34c43f8ef9bso5641711a91.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491001; x=1770095801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4neZNfvTortxzJ8i3PhQK7rIiHo+6riare2hmpih5To=;
 b=lz3LBxSjwQiMzxY7qwz1DFUy9MUbWg4vvT98P9jUBI5KgT/1JASoyYG/VM1CcG2cFA
 +79pi1N3Vu9et78fl3DJsEwrFA+qXWi22L7B8rslpW2VprdOsLJAas+nnvrrlZA5w0Kx
 xFQYTkXsZZ9PfC8YF3ZQusE2dy3BFsv0zcgg8gJ8/FNFLY3pR6ZxLTxOZLTTHO4u5R2z
 8guZN7w17wP2ieqBE3U33YI+i7PNNRqNiPOhqRRN3vfCemjBpaqgXFDL2njM3KpyOHJl
 jrKg7rL85Kz20AaLojZsFeLWE4BhJAXdpQLJ/H+wQiUaLy1olxWN5jNbkxYE3Z7xNfXO
 KB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491001; x=1770095801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4neZNfvTortxzJ8i3PhQK7rIiHo+6riare2hmpih5To=;
 b=VRrYJFlbvMKh9Xo4vaFkhcAoV0maj4Zn4Vy7pBTKjad444GNp/+f/qOOtbTfZbcDBo
 klbNLopiQOfnIhjramMU2pwr1+MAhGlxJ+b2bLnYWHYrSwVQVpoZj9otlHQUGgit5HVl
 poSOWNaLjnjKmgZYjPzw0n+F1zHYtlWis9uWnZ27Gw3IDL65e721P7lfJAzyAW6K1Ufd
 1XUDGDO/Y27C96iBY1ZmCI/75n5EGzP1dBBh7ESe4CX1hs7UAt2X2AnnUNGvnTugR+/f
 ntzPco6luWP6T1ntPOKVlVYc4qTtPtVGRAH8L3VQwrZwd5/5UNGQE6TYl/J7NT+OgM/v
 28jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlUiInbtOWlnzrvIcvNCWEqNx/e+NpC7JwzDp8Ubf6V7BMxRjqAKAnNXavAjTNihnz2IqOD8XasAZf@nongnu.org
X-Gm-Message-State: AOJu0YygOxWKaUzDSM7+UdLdYwJ5kfq8YrtcWy/A6GhlnUZ6cE9yQN7k
 KKSWJRuojNEFL8cpVXMDn7jCXQw3N7j4yXGaaeq/2xi/EzwepkLFu6kFGcrrmHpSX078MI+sMx4
 nCJV3hRGKhf3W1RQizFqSAaqAu75e7re2qFCYjmLKQClju9hIRKy5Fm7u
X-Gm-Gg: AZuq6aIBvUuqrPMiVJcQ8gFxmdywUve6uwjdxLelZ/LyOgZltX7tRktdXFmC7vPA9S9
 /SxxyWv4slf3mIIB37158vVwmlbWT8UpF1zye1l09tj8+Jrvs1TgMJMx+jaw8VRLpr8KhRzo1i7
 COSHDuaZNR5XH+T1mO6CcGNdprMXsfzd1pKObOnopKhya3sNFUwaDpiefzx577m0+37NToHsfHu
 o1WeOqlQlleIW+IXllwvT4pS6ZuFtsq33QacPzOab4ZHqy1SXNbjDhCamqYQMjwsYhoCbb9FC/5
 5k4cgsZMndQ3Xk+0tZa9PCYGi/yWJ/KYp6wqFaTp81b1fudjgrqIcyxYbTHXgOKaUAeqEvGZ9FH
 ERRJdDXeZdDXuVnf0bfH3fLzufz3oGnGIpOZXYXaG5Q==
X-Received: by 2002:a05:6a20:938e:b0:38e:95f9:8cc1 with SMTP id
 adf61e73a8af0-38ec5d4fdd9mr576400637.12.1769491001384; 
 Mon, 26 Jan 2026 21:16:41 -0800 (PST)
X-Received: by 2002:a05:6a20:938e:b0:38e:95f9:8cc1 with SMTP id
 adf61e73a8af0-38ec5d4fdd9mr576380637.12.1769491000976; 
 Mon, 26 Jan 2026 21:16:40 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:16:40 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 03/33] hw/accel: add a per-accelerator callback to change
 VM accelerator handle
Date: Tue, 27 Jan 2026 10:45:31 +0530
Message-ID: <20260127051612.219475-4-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
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
 system/runstate.c         | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

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
index 5d58260ed5..d2ece27729 100644
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
@@ -509,6 +510,8 @@ void qemu_system_reset(ShutdownCause reason)
 {
     MachineClass *mc;
     ResetType type;
+    AccelClass *ac = ACCEL_GET_CLASS(current_accel());
+    int ret;
 
     mc = current_machine ? MACHINE_GET_CLASS(current_machine) : NULL;
 
@@ -521,6 +524,26 @@ void qemu_system_reset(ShutdownCause reason)
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
+    if (!cpus_are_resettable() && reason == SHUTDOWN_CAUSE_GUEST_RESET) {
+        if (ac->reset_vmfd) {
+            ret = ac->reset_vmfd(current_machine);
+            if (ret < 0) {
+                error_report("unable to reset vmfd: %s(%d)",
+                             strerror(-ret), ret);
+                vm_stop(RUN_STATE_INTERNAL_ERROR);
+            }
+        } else {
+            error_report("accelerator does not support reset");
+        }
+    }
+
     if (mc && mc->reset) {
         mc->reset(current_machine, type);
     } else {
-- 
2.42.0


