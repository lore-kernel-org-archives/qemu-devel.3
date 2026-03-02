Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058FAD58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyyR-00041p-7N; Mon, 02 Mar 2026 03:49:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwywn-00036K-Ph
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwywl-0002CE-Ob
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kg1engNtyMV3kTVfmApLjzUVlhNQADpL4hckAHLG4iw=;
 b=hNEQrfGQLO7Tci6/DvBRBhaY7i15o47jsF0mmJCHU0AZz6ldJxDrmM02gUaOSPu5Ts7ckN
 K4LkD7pI/JDQ164OLalC/9wnknNSfzmdbKpxgKKJi/TfKMQ5l4AyJwPSKSgcYTewXdHMVl
 0edTWBTimBGVV93rE4hFyMCvFQ+tvV8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-KuTQhitgPnOGPLx7lhbqHg-1; Mon, 02 Mar 2026 03:48:07 -0500
X-MC-Unique: KuTQhitgPnOGPLx7lhbqHg-1
X-Mimecast-MFC-AGG-ID: KuTQhitgPnOGPLx7lhbqHg_1772441286
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836cf00787so48208365e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441285; x=1773046085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kg1engNtyMV3kTVfmApLjzUVlhNQADpL4hckAHLG4iw=;
 b=r9KUAltFxfF4cyXFSHUslu6SojfeKCnox0h29uSNkeNXcyGRC0tdYXuDHefm3NanB4
 X/sokjBRgu8PkU3HE9F4VBF9ty8VaDNgzjbmhP1Ml7v3c6ut1/xclchIMZwPa6dDQkKF
 HjHcU1/curoEllVSwN+5pdmL2xae57rYlZboo3rBTWZR9GFuVkSGg8k2+XbRCBaIm/w4
 n4LJ7EL0FdARyeUC/0O6/RTHE5uKXENWqihD0P725/mlIxcZaLLVO9E6g7DbELWGzWum
 lVoDqywbnveMQu0jngeHTHQPENd/737fON2WqMbVydbzzPP5O/hW6dAiCoRmrb+e1E8E
 peqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441285; x=1773046085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kg1engNtyMV3kTVfmApLjzUVlhNQADpL4hckAHLG4iw=;
 b=aFwxY13KEBFTUmy2uVF9AtOdp80RlA0R9OIjXAw+hQJu/A1DgNeHstOZ0/5bMnmPYk
 DwBAUSIBIJASBFGUiXk243h3oyRZvLPv/kbEB7g/yFwDnM6UIHx6mY7Oj7/gKic+iIK5
 z3QF6t5iz3GuGjgcOAOu1W+gogwElUv7JJ3CEiJr0pH0yQ+9LFx+3X7lC46joRSnaGe3
 G5vhmGI2utz60i0uoIVtnDwvOj/az7oumukTiAwfOzPmZHuvDKk7MxDbOXCsofKxh1oB
 +A20NuP3V/+rk1Jh2rjwCMHgMUCNDsYeFv4IIw8eHYard9GloBCdUPpY3FY8GlBFu5Xu
 jLVA==
X-Gm-Message-State: AOJu0Yz0bOgRRqnWBNEtMjQQuStcozsWkEsRnI5q6QqpxhgaA+Y3S8pr
 GLT94udsnbSLvuGIbrGtEdqZXnlfQhNTAW5GZs05z7dRCcW3+oit9rRCaUwF+KcAkKJmbOcUEXC
 zQu1jgI6bTxZ+6YPCS/YuY79VeWSjdyWCT1DY3iOUSA899L4OjpFVpmEXnmNg/tzag+43cYgIo+
 xxmofi1fW8V2DzMllwO+jV1pSM9KJOyTz1/t4dlbdl
X-Gm-Gg: ATEYQzwyJ+v111Fgv8eVClXxI7YBelvdVmEQnSfVbB/vYger9d+0uGeu1uz0JbuhTb5
 tVUMxQBxUY1s4HblYnqz+MfsqZD75VEaIYqeg3dEeHprErOTXcD0Rfs+dHv8jaP8kwTHapZvC2h
 ARkaCLUXiUCwc+78GonOMAg/KimLTkoQh0hIZ0Es/opgVK5ZwK6d4n3KA2QGXR24EaXHobQaT1W
 Xhyh8UlxxFCLEb2YYHWNdkj/eQMFms8/kGVqjJ8dbAqCwwosxj7raUYZHqvO7aZIdw3iTgGkrwo
 W6T1u/rrocSlqhXrSdUVpV4dMKcBticFvqapzqBBqiQfXxx37jfLB+B4NKEIkblBTRJwalA9pID
 6T8Ai+YLkcEoaAuxzE5p7/zgD/a6LZ08gp1pu0BJ7Z+I7Aos98fa1PVD+6fvnVQTSC0XvYWlWBT
 ToxIO9pUqU/B1/8t50nk0rzeOGkm8=
X-Received: by 2002:a05:600c:3544:b0:47a:8383:f2b2 with SMTP id
 5b1f17b1804b1-483c33f3357mr257777595e9.17.1772441285513; 
 Mon, 02 Mar 2026 00:48:05 -0800 (PST)
X-Received: by 2002:a05:600c:3544:b0:47a:8383:f2b2 with SMTP id
 5b1f17b1804b1-483c33f3357mr257777105e9.17.1772441284990; 
 Mon, 02 Mar 2026 00:48:04 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439ad3daf89sm26345480f8f.20.2026.03.02.00.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:48:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 073/102] hw/machine: introduce machine specific option
 'x-change-vmfd-on-reset'
Date: Mon,  2 Mar 2026 09:47:19 +0100
Message-ID: <20260302084749.474955-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Ani Sinha <anisinha@redhat.com>

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
Link: https://lore.kernel.org/r/20260225035000.385950-33-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/core/boards.h |  6 ++++++
 hw/core/machine.c        | 22 ++++++++++++++++++++++
 system/runstate.c        |  6 +++---
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index edbe8d03e56..12b21493789 100644
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
diff --git a/hw/core/machine.c b/hw/core/machine.c
index d4ef620c178..eae1f6be8d5 100644
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
diff --git a/system/runstate.c b/system/runstate.c
index e7b50e6a3b1..eca722b43c6 100644
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
2.53.0


