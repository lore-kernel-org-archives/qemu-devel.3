Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8C5E9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfzA-00052k-Q8; Wed, 18 Feb 2026 06:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyz-0004Ux-6P
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyo-0008Sd-QW
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dw4c4tBuuNn6IOR3hrguMbcnGJ7OzIOZU45K/GHwsiY=;
 b=PlsABZTqivdytMxYiuXJydNlv8opuLuubhFW6Mx1yeUXQzV9N+2A4S83yQhZkEvi3FWxOi
 5GgXjuDfbu4o72LwhGH55qZuuEcLB0GdqCBHBBomv6QgVnzDd9eL83PpQAWrXH1UaivNyl
 FYIk5jbdPmzsevD6Ep11gvMqrxMZOIM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-08tQpwVfMqyVZZ1aIog8WA-1; Wed, 18 Feb 2026 06:44:23 -0500
X-MC-Unique: 08tQpwVfMqyVZZ1aIog8WA-1
X-Mimecast-MFC-AGG-ID: 08tQpwVfMqyVZZ1aIog8WA_1771415063
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2aaf2ce5d81so62271035ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415062; x=1772019862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dw4c4tBuuNn6IOR3hrguMbcnGJ7OzIOZU45K/GHwsiY=;
 b=pcPPTraIDecCjrAAvFj67VqWBN+7rfTORvbGgRDnZYDdlIXpes3vwJjqAhFl+zUltx
 AB/DAB0I/eluvmMVB2ZOY9vUbEJ1PVC4eyxJniQteNQtD7ESGDzSHEKVCbhLh9zPOeae
 ZiSNWOnh6bOtLtuM7Hz11j/tkj2uD9FfT+/lBP1ihd7DedtoPfqJwqWgpB07wC6vsumY
 hP1HyHRfDRPc1Y3jhvmx6dZBqN9OucftBSecEbej7CPUOqj9/+UIXGpR/zAo7XTubfM3
 m53i6RKL1BjVgu0QILjtOBApvH69458nw31KcbHcaPWEjGLQxiVzNTjUyvBGBH1yvIYV
 DzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415062; x=1772019862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dw4c4tBuuNn6IOR3hrguMbcnGJ7OzIOZU45K/GHwsiY=;
 b=orAesKco68Xp2X9v6DRl3Q6PSA8A9KJHasU3ErKH1+nrBvI3tt5tZ319wCcsO7kVK1
 I0ikAxjur3Usu9C9Rr1JE07cM7NYUEUulnRv8fb+ZyOcQdBTt65j5h2gsse4ieM0v9t0
 sy5HMdsNu8IiB44e+kiEoSqC8SDGIJLhZjAbevxE7hWwY7Q+nnlaf6BnIJ0vkud52epa
 r5M0w9sIlsUolunQ18OII6fwlcj2kYpN8CokrYT98Kw25XWgOnHZV9y9HSP0Ce6xFEzE
 aG6WwpMv1Yh4bhl+maRNfX7ZLZ4vMWaRbtqdPpFiv3tngV5H3PPgJriaiLL546JbRWh+
 kbBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8WkpLA2oTHounnSZepNi2GQAffMqlBoIMDDAUol+kknJss+DrP+AHSw87NZatN3EuqdpprXBe173d@nongnu.org
X-Gm-Message-State: AOJu0Yztk1icz3WMEl4vW5X3mtRdLSlU0yhp/Qv6/o5CyhHjla0KOXun
 mTduZlkV9DxRHoaEQ3ZB3iHtP3gXZiTdSlBcNAScb+/5nFvuBzsH16IeijTU8w2x3QtIjWOViZz
 m+NuBVILmh8aSd90riXvphBAB6NlX0Ba6Dhx+t97DM9ILJdcIo5UfLD1n
X-Gm-Gg: AZuq6aKsDbWNSRhizCpN5Ri8RaDfPXwBSWqaxNyjDWUBKUv2FVNnEKtReryHUiA07dV
 au4WN6E1Z8iiu3VcfuuoTZ6QZ76aPs39C2fsylV/S2d8RF/aFWF5e5HAzs9HbyEpUYVShr6T1AS
 43adr6wI3Ax7WABMVZsTI52KE7KDQKP/0qsXO3YG1OlgjCY0Ydi+yA9t6A0B+cfieTYFGMv5KMH
 B1X1AM98GTqo48oJW5B5WoImnEv5loU3UDjJDubrA5WG1qMopUB7PXdUhLM5mjkkrFpXRfdUAal
 6Bo2M4WSPW6zAfYblkzZRGV+gk2BksNSMeFX6oeDLmMF3ZNKpHjCr+uofXyQnlsfNuXKqmTiYkY
 /lblHpK44vCsNRsCNt3J703i/g49MsVc3xh6g9MCXWjddnMe0Cqra
X-Received: by 2002:a17:902:fc46:b0:2a9:484c:ff2f with SMTP id
 d9443c01a7336-2ad1749b6ccmr171339545ad.23.1771415062654; 
 Wed, 18 Feb 2026 03:44:22 -0800 (PST)
X-Received: by 2002:a17:902:fc46:b0:2a9:484c:ff2f with SMTP id
 d9443c01a7336-2ad1749b6ccmr171339375ad.23.1771415062256; 
 Wed, 18 Feb 2026 03:44:22 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:44:21 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 31/34] hw/machine: introduce machine specific option
 'x-change-vmfd-on-reset'
Date: Wed, 18 Feb 2026 17:12:24 +0530
Message-ID: <20260218114233.266178-32-anisinha@redhat.com>
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
 system/runstate.c        |  6 +++---
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index d4ef620c17..eae1f6be8d 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -435,6 +435,21 @@ static void machine_set_dump_guest_core(Object *obj, bool value, Error **errp)
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
@@ -1183,6 +1198,13 @@ static void machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "dump-guest-core",
         "Include guest memory in a core dump");
 
+    object_class_property_add_bool(oc, "x-change-vmfd-on-reset",
+        machine_get_new_accel_vmfd_on_reset,
+        machine_set_new_accel_vmfd_on_reset);
+    object_class_property_set_description(oc, "x-change-vmfd-on-reset",
+        "Set on/off to enable/disable generating new accelerator guest handle "
+         "on guest reset. Default: off (used only for testing/debugging).");
+
     object_class_property_add_bool(oc, "mem-merge",
         machine_get_mem_merge, machine_set_mem_merge);
     object_class_property_set_description(oc, "mem-merge",
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index edbe8d03e5..12b2149378 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -448,6 +448,12 @@ struct MachineState {
     struct NVDIMMState *nvdimms_state;
     struct NumaState *numa_state;
     bool acpi_spcr_enabled;
+    /*
+     * Whether to change virtual machine accelerator handle upon
+     * reset or not. Used only for debugging and testing purpose.
+     * Set to false by default for all regular use.
+     */
+    bool new_accel_vmfd_on_reset;
 };
 
 /*
diff --git a/system/runstate.c b/system/runstate.c
index e7b50e6a3b..eca722b43c 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -526,9 +526,9 @@ void qemu_system_reset(ShutdownCause reason)
         type = RESET_TYPE_COLD;
     }
 
-    if (!cpus_are_resettable() &&
-        (reason == SHUTDOWN_CAUSE_GUEST_RESET ||
-         reason == SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET)) {
+    if ((reason == SHUTDOWN_CAUSE_GUEST_RESET ||
+         reason == SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET) &&
+        (current_machine->new_accel_vmfd_on_reset || !cpus_are_resettable())) {
         if (ac->rebuild_guest) {
             ret = ac->rebuild_guest(current_machine);
             if (ret < 0) {
-- 
2.42.0


