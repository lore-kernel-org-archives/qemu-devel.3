Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D62ED25939
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbT8-0000zL-Px; Tue, 27 Jan 2026 00:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbT0-0000fX-QY
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:18:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbSz-0000Hn-9h
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yFYMvKOUQKIGJ/bgL+z2/AhFQ5ODxClXmfogU8hnHt8=;
 b=VB1mvM89C/GbPWGkDmQ2aZuM9/a1yaCOrXgoe/kP0+JBIkrjxpzlgnva0SpX24SqN2ziAy
 /VslV242WA8aKUjhnGGI5SA1yYzHjbEiBlRQGgqa05yrLlEZ/OwT1vwRj4rZDIo3R93IKo
 2WQ7honG8AIu/WFCfCcuudWH9l45fgI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-DL-ZCg00OZiqed8CNUm-sw-1; Tue, 27 Jan 2026 00:18:12 -0500
X-MC-Unique: DL-ZCg00OZiqed8CNUm-sw-1
X-Mimecast-MFC-AGG-ID: DL-ZCg00OZiqed8CNUm-sw_1769491092
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-34c48a76e75so4683046a91.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491092; x=1770095892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yFYMvKOUQKIGJ/bgL+z2/AhFQ5ODxClXmfogU8hnHt8=;
 b=mJj6xz1ii9dKXqT7GCHCY65TVzL4Z2Au0BROR+R9v1zGTPFoIxfXbYDrDclh/zAFZ6
 ecMeq+iDjpzrISpVRbTkM8T9BmPrj6LIeepAncRgWmpltqHksSqSnCYIc32VBw5HGwaS
 VLccr2FDaOKDAojoju5YLcvxnCJ5now+0Rf7JYZ+9cv7KR29ngf+PJzqO7bvpH49WBV1
 pNYHNl4igV8MhfOSJ5O5G6I4H7VuFMmKc4CPHQ+Vj4yAp4v44eGMOfcHMgSkDN5NlBCq
 XK9RqILHx5yAM9rUJSpG1WlAZfbkZmSlMcNsEh5fA36O1PN6s05klaw2EOe5p0BlLpt0
 XvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491092; x=1770095892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yFYMvKOUQKIGJ/bgL+z2/AhFQ5ODxClXmfogU8hnHt8=;
 b=pzqtoJZE3A/OobTC+ChPq5IOuhxCH2Wry/hcoEIyzqMjJGNOVDZZjLBXfMefPjZdmS
 cFjvq0hyEgNdv/eZk9FCzGSHp7xUGAEXUF0n4IDZzDhfcJfqyvLvkZ/MxjjzEpybB8k/
 q7AoVsnfaRyISH7b3kkDOvPGh31rtCxKWxy0mB+FBF4wxfaP4Wmogr9Hg4hpLbIS02YZ
 imhCBy1tkDkyv4tRChZPlajhQDccrLBS+DjT1CJwA3foEUmfaB80gK9LeAbHoIB0/DFh
 +fTaLvnkG+q56NEHeD/MQrFlLDx3d+XYIDI32EOUYjayBB8XJp/XSkJm78mYUtC+UlUF
 pi6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpbjheibhBrg1gPdX7QR1CEYUKOiD/6RsFsXa7iLbIhpHQsXpEhmyy4bLbU82xohf+pfPytxO2cAEX@nongnu.org
X-Gm-Message-State: AOJu0Yy/WRYqb9Dlz5iSUc6bP8RZ2T3PSBfxauVsxB6oorSoJ2ORCaR2
 FcJJm2I+Shpe/83bhEj6f+BNUJkiScxXqA7DR9xL1kUHdVlB3DCPn/mzrRZSxBJhOdh/jVJd6ll
 Y/pShuyZ2aX+Lb1M0w68ebsrKJPWetYAZHSOWePTiSm8XoLWNBBjfd/ae
X-Gm-Gg: AZuq6aIc2AXd05CIkqT9wF/3CqFtUh7ZGo27hC7EMQKts5yMhE+hfLiYNvBzB5KzCfe
 m5MZIk9+30/h804e4alrVPZ787LpM6D75GYTAua/Kb6CWRVyMbG3pF4P7ypV39/8NC0WuKzNz0m
 bi4co424g415Crr5ydPqSC5/tP/afCmpGhH6uosVTh8Fn9FFGm0Yw6lKMSumzS0qdvPZ5Pk3vQp
 LUlVVcYE9LrzHEmoS1h8YLaEcqN5Jh3OuXKFZjPtOL6AOdYjjb5BRKFA6EQAkLUxU5drLxCmSX1
 XdeVRK03cm0ytAzfCLwXd0NLKZLwDgm/ZnYGk8B4z+E/l72GoUgOkG/AABBMjM2IsO0sGLIojGZ
 VywrGojL45pOBnhmhJIINyh2XxiYVwEEMhKQQzWxTig==
X-Received: by 2002:a17:90a:c2cb:b0:34a:b4a2:f0bf with SMTP id
 98e67ed59e1d1-353fecdb3d5mr741019a91.16.1769491091783; 
 Mon, 26 Jan 2026 21:18:11 -0800 (PST)
X-Received: by 2002:a17:90a:c2cb:b0:34a:b4a2:f0bf with SMTP id
 98e67ed59e1d1-353fecdb3d5mr740991a91.16.1769491091411; 
 Mon, 26 Jan 2026 21:18:11 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:18:11 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 32/33] hw/machine: introduce machine specific option
 'x-change-vmfd-on-reset'
Date: Tue, 27 Jan 2026 10:46:00 +0530
Message-ID: <20260127051612.219475-33-anisinha@redhat.com>
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

A new machine specific option 'x-change-vmfd-on-reset' is introduced for
debugging and testing only (hence the 'x-' prefix). This option when enabled
will force KVM VM file descriptor to be changed upon guest reset like
in the case of confidential guests. This can be used to exercize the code
changes that are specific for confidential guests on non-confidential
guests as well (except changes that require hardware support for
confidential guests).
A new functional test has been added in the next patch that uses this new
parameter to test the VM file descriptor changes.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/core/machine.c        | 22 ++++++++++++++++++++++
 include/hw/core/boards.h |  6 ++++++
 system/runstate.c        | 17 +++++++++--------
 3 files changed, 37 insertions(+), 8 deletions(-)

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
index d2ece27729..06036a9170 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -525,22 +525,23 @@ void qemu_system_reset(ShutdownCause reason)
         type = RESET_TYPE_COLD;
     }
 
-    /*
-     * different accelerators implement how to close the old file handle of
-     * the accelerator descriptor and create a new one here. Resetting
-     * file handle is necessary to create a new confidential VM context post
-     * VM reset.
-     */
-    if (!cpus_are_resettable() && reason == SHUTDOWN_CAUSE_GUEST_RESET) {
+    if (reason == SHUTDOWN_CAUSE_GUEST_RESET &&
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


