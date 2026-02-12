Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5F8EDF04A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQBN-000299-Oa; Thu, 12 Feb 2026 01:28:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQAi-0000aK-Ia
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:27:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQAg-0005NP-U9
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M1UCM7z53H+LxOmB5d/FdTplSUqdefLOAGc/QpHzO9M=;
 b=LBdWndDSIUy2jsjsHz+zl1/do/TaK0oqel2WMMab4wsmicbJU/KAWvWPfZLEIOmevS7uSP
 oXcBkpEoEwepKczuAEbzAGwdceny7Mby97MnglFHTpmgsCMKKAbz2d9ZE18sD1ZRH5mIzu
 EH/6tlyxdWzgU+l1UJp9OnZKzhpenug=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-UPqFaFUMO8ucKxzjnivDzQ-1; Thu, 12 Feb 2026 01:27:24 -0500
X-MC-Unique: UPqFaFUMO8ucKxzjnivDzQ-1
X-Mimecast-MFC-AGG-ID: UPqFaFUMO8ucKxzjnivDzQ_1770877644
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3562171b56dso5577703a91.2
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877643; x=1771482443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M1UCM7z53H+LxOmB5d/FdTplSUqdefLOAGc/QpHzO9M=;
 b=O819v+VBCfrkmP2sNWR3Xd+qOqqzc+pMuGbpAF+KM+qepddwnB6YKg6qJ2yJa5H+39
 djMkLTuMBmkPDdRBXZWiZJ46XTeGUck47n1jqvQgpFc+9pdxNosryFi37PgoWYOQa6ig
 2r5exZ8w87e3Nfjhod0YS4A6FK5TGdARIR1+zyqGEr+Pj/9DTConwpZxGPpDqmJ9NX2i
 41y5U9pwHl5QLWYO9k3KR+WRLqgPeOfKH35TC9E7Sn/b7fBzLIHunaRIrq9cushjbLLb
 wPwGABR8MoZ+m7PG9BI3XYfartQ+GW307h5R24y+XblmE/4eB3bI+hvf8CYs6fSLVKx0
 M2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877643; x=1771482443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M1UCM7z53H+LxOmB5d/FdTplSUqdefLOAGc/QpHzO9M=;
 b=HiHTBRa9hmTsG1G3WY86MdGd8scc0Tgp+oA5k6rGPQomd3LLjRSHcw607NtyMt/ZdA
 oQ7T8Xg/s4Pkhtis9G6ymM60MlVjlmQ2w7QpDcO7OSIIiFa60c6u4KX8QUuuI+s/xObB
 Mv9NXYX4+YpYnRyL2jHy63kAfYlJekBMiroJxQQOO/ywrbabEjWaN5Yf+FasFoyHDRfI
 EbdOLUyyO9bFLjEZPWCK0dHdk3kEchOfIFzFtT8II2PGcXehG/wMaamHF5G0mJ1UMQ3L
 axOPTXv3xJgsufsBbv8sDxToftSoIdVbAxMXIDJW3kJAry9Cy1FIO3DBdxAPXtd+SQ9Z
 r50A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrmpRPHzF9Rv5gOBZH1lF/jLzqR50sroqI0wYjNyWOkzHzpeOIwCyCoE+Wbpgqa8prXzkTIQyyiD4I@nongnu.org
X-Gm-Message-State: AOJu0Yyg6MMYF5O2sI3o9bx7+j4Oabs5or05C/YtGGNcBpg+59NLMpVk
 FGZlHEg78rTuCdtPn2dBcjTbdXxk3yMv0rbXhB/2o93kif2dqemhJcx6dxQJghjRrCE9qBeV7ce
 VZWMrBBFiZdZIzdD1jiaz1kX+56zUCu5tTmxwbGwbnpBC5bUpX9B6i/RV
X-Gm-Gg: AZuq6aLjETa7fUP8U1GCsLU/DqL8/q/pIgvTrnY9FKarDdNsVDIn7sdw4C/xniZu3M3
 cwm97eWqTq3ZMKBmnlddfTdOnJ/PBags0APa5ZL/fd9VBlYzeAbB02efE+f+LJMLoIRXNd4BbZ1
 ymGpA/IC4vu7eZLGAx5FqQ3r6DKpnM4VQ3I2SLB7QJhGhaxQ5pjGQfr/yjnEku1GWf95MxO8rkc
 Vg5JvjZgYNPjZU0GFTyMuvHHr9mhttOR7mPdSN4fydJ8XoKS0zvhmMBLxgcugW0ukeaQKaZomce
 McxDLbPLRAHfPYWvRbqKbCv+pZYl5OeIPa5fxuVXJ89q1ywgHM3/8uv87Da/LoJAjmIN33SBGrD
 Cbf6jbdzmvjWR/p6vhOummzr0Yw5gOEZ545908/R/getTjh/Iqt5dcwA=
X-Received: by 2002:a17:90a:ec8d:b0:356:24c8:229d with SMTP id
 98e67ed59e1d1-3568f3deb15mr1545581a91.21.1770877643542; 
 Wed, 11 Feb 2026 22:27:23 -0800 (PST)
X-Received: by 2002:a17:90a:ec8d:b0:356:24c8:229d with SMTP id
 98e67ed59e1d1-3568f3deb15mr1545561a91.21.1770877643160; 
 Wed, 11 Feb 2026 22:27:23 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:27:22 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 30/31] hw/machine: introduce machine specific option
 'x-change-vmfd-on-reset'
Date: Thu, 12 Feb 2026 11:55:14 +0530
Message-ID: <20260212062522.99565-31-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260212062522.99565-1-anisinha@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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

A new machine specific option 'x-change-vmfd-on-reset' is introduced for
debugging and testing only (hence the 'x-' prefix). This option when enabled
will force KVM VM file descriptor to be changed upon guest reset like
in the case of confidential guests. This can be used to exercise the code
changes that are specific for confidential guests on non-confidential
guests as well (except changes that require hardware support for
confidential guests).
A new functional test has been added in the next patch that uses this new
parameter to test the VM file descriptor changes.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/core/machine.c        | 22 ++++++++++++++++++++++
 include/hw/core/boards.h |  6 ++++++
 system/runstate.c        | 20 ++++++++++----------
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6411e68856..95d7650db9 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -450,6 +450,21 @@ static void machine_set_dump_guest_core(Object *obj, bool value, Error **errp)
     ms->dump_guest_core = value;
 }
 
+static bool machine_get_new_accel_vmfd_on_reset(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return ms->new_accel_vmfd_on_reset;
+}
+
+static void machine_set_new_accel_vmfd_on_reset(Object *obj,
+                                                bool value, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    ms->new_accel_vmfd_on_reset = value;
+}
+
 static bool machine_get_mem_merge(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -1198,6 +1213,13 @@ static void machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "dump-guest-core",
         "Include guest memory in a core dump");
 
+    object_class_property_add_bool(oc, "x-change-vmfd-on-reset",
+        machine_get_new_accel_vmfd_on_reset,
+        machine_set_new_accel_vmfd_on_reset);
+    object_class_property_set_description(oc, "x-change-vmfd-on-reset",
+        "Generate new accelerator fd on reset, "
+        "to be used only for testing and debugging.");
+
     object_class_property_add_bool(oc, "mem-merge",
         machine_get_mem_merge, machine_set_mem_merge);
     object_class_property_set_description(oc, "mem-merge",
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 07f8938752..ee3cc9130e 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -447,6 +447,12 @@ struct MachineState {
     struct NVDIMMState *nvdimms_state;
     struct NumaState *numa_state;
     bool acpi_spcr_enabled;
+    /*
+     * whether to change virtual machine accelerator file descriptor upon
+     * reset or not. used only for debugging and testing purpose.
+     * It should be set to false for all regular use.
+     */
+    bool new_accel_vmfd_on_reset;
 };
 
 /*
diff --git a/system/runstate.c b/system/runstate.c
index 0a74e3ade5..29953fb088 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -526,25 +526,25 @@ void qemu_system_reset(ShutdownCause reason)
         type = RESET_TYPE_COLD;
     }
 
-    /*
-     * different accelerators implement how to close the old file handle of
-     * the accelerator descriptor and create a new one here. Resetting
-     * file handle is necessary to create a new confidential VM context post
-     * VM reset.
-     */
-    if (!cpus_are_resettable() &&
-        (reason == SHUTDOWN_CAUSE_GUEST_RESET ||
-         reason == SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET)) {
+    if ((reason == SHUTDOWN_CAUSE_GUEST_RESET ||
+         reason == SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET) &&
+        (current_machine->new_accel_vmfd_on_reset || !cpus_are_resettable())) {
         if (ac->reset_vmfd) {
             ret = ac->reset_vmfd(current_machine);
             if (ret < 0) {
                 error_report("unable to reset vmfd: %s(%d)",
                              strerror(-ret), ret);
                 vm_stop(RUN_STATE_INTERNAL_ERROR);
+            } else if (current_machine->new_accel_vmfd_on_reset) {
+                info_report("virtual machine accel file descriptor "
+                            "has changed.");
             }
             vmfd_reset = true;
+        } else if (!cpus_are_resettable())  {
+            error_report("accelerator does not support reset!");
         } else {
-            error_report("accelerator does not support reset");
+            error_report("accelerator does not support vmfd change reset, "
+                         "proceeding with normal reset!");
         }
     }
 
-- 
2.42.0


