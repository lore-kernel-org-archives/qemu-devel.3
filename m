Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150CFF55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5wS-0003uc-Ls; Tue, 24 Feb 2026 22:52:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5wR-0003s0-5a
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:52:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5wP-0008F2-Bm
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dw4c4tBuuNn6IOR3hrguMbcnGJ7OzIOZU45K/GHwsiY=;
 b=I+zI0K65FFR1u7/BtAp/75dYUxQlqUXotaVzncirMyCQH0yzvHuPP5+sNAnmDcE7rtrPg7
 /x61A1281fDGE+2copEi3wzVNxEDSMQpGWlXXYiKpE8VuWM+LKsPgn6vNh1kZhI2Ner5Y5
 2G3CG9UCj5zgqOwsz0dAJxB+vaY+QFU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-Dexh6iUOOHqOkwRfHFHvyQ-1; Tue, 24 Feb 2026 22:51:58 -0500
X-MC-Unique: Dexh6iUOOHqOkwRfHFHvyQ-1
X-Mimecast-MFC-AGG-ID: Dexh6iUOOHqOkwRfHFHvyQ_1771991518
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-358f058973fso1013462a91.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991518; x=1772596318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dw4c4tBuuNn6IOR3hrguMbcnGJ7OzIOZU45K/GHwsiY=;
 b=nyhYdi+GLecAewR410KDoQ0mriKFdPfaAZhMUY/rRZ2Uj/REUKWCarhQYchGq8LEqf
 SuczF6IfxPgGyFzI9az8f0qQ4T2HxvKFwW5lIIQwd5TjvybVt/ICtQt3pHCGHY7xAaMF
 xbzGo0KWw2QkAsLB17rBZzKFnS85v0nGuhfBbwJX4i1PEEofCDdGNi9k3KNHniQVhGlm
 SFcp/hO6iW/D8ydwE0owumS8pOyt3jkOoTwhe8EQ/MXpHVBm04uFL+8DjEAu4dt1QGiQ
 4UJyHxh4wGM98xdHVDywRZvMoyZgAMuj3vFXam8YWO74/tH553951BjbLyPZbSjqWlaO
 nrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991518; x=1772596318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dw4c4tBuuNn6IOR3hrguMbcnGJ7OzIOZU45K/GHwsiY=;
 b=Y8cSjcgCU+J06XdPecIXQTKpq27yXy/m1Oxa3PlKm4tg/PRT8xHpsI5wjvGSg2C2LR
 SHzWC6BDjXGgP8LlO3GV4pZwg8mWRSGJsXzcDiV7+63lJBBPonWkcPPqxN/ipOSY/Nww
 j6WRDlHab9520DPrd5TNDEUtU72FYf74gYJnN0AczwK76ga80958B+uSO3wlyHFxsHrd
 MvJ6Mt2d1X0palE7EiCraqDW6KmpVcNc4Sqh+Ubl+wu5fKjxT/aekccgEplbu1w3s37i
 TK6Ik4Go+2AaPlk4fhlNSbTiZSV4F5N2YXstn74y7Pj066ZMDEp0L5Ng2Iv8j/RIQdlz
 h6Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO6W/s21dq727oaCnXeu+qURd7HP2+zpRfZtby9utSYYQcH4BORxvQQu0gJ9Yg2ASvrI1H9Ua1OH2J@nongnu.org
X-Gm-Message-State: AOJu0Yx/tRvEkF8nk/DxbvY6h+56lTr3ZmIxG5eAdWDuF8cg7hBydINT
 Fd1R7H032qaAWU3OJACerHwT4WJb56u+TdoWfVYGV4krOWwio7loV7LBLjyyytDWCYDrtqgopz6
 rK+0nhh4RA/pbxwWyGqLBZ80l3vUeUfh/oExVgw6/cGxu9kArrTnZ7GNJ
X-Gm-Gg: ATEYQzxfgHS8dgmqCg3NIo2/23uibUVhzwku0IY0/YYPm2rDjjsliGnvCHJj+d+u0wU
 kUMDPNTFmyj/Oy5kFnMYbm/8NjBcZlZ5qO0sSNf3rGnyKUb81m8yzR166t2VnlQWQy6x84Df0Gy
 Tp983qu8XK7RMOULIk1teJLtzIrfRBiMVKoY6jDTigpoTpxg887H/D7zzR99RhYZ71H4JyVj3n5
 kJ6YpIz411JBjbEYxetH1JzLcTVxbWI/DR4XQ6T/h570JYe374dy8q2KvWVXThpKJLtnWddrEau
 /B7E3Zm/fwr7jcz43u9vSk80cQOypos/Bv2Vh7R4z1g3f8dhDKt2UBXl3WNxStOo/4nFCTmfC8n
 xtXzoDJ+XU5y8AMZlac7rsD5V2IcoFNf+CTfh2rl/u3oIKeOgrZW0X/g=
X-Received: by 2002:a17:90b:248f:b0:359:1130:1042 with SMTP id
 98e67ed59e1d1-359113010d7mr516817a91.23.1771991517676; 
 Tue, 24 Feb 2026 19:51:57 -0800 (PST)
X-Received: by 2002:a17:90b:248f:b0:359:1130:1042 with SMTP id
 98e67ed59e1d1-359113010d7mr516810a91.23.1771991517261; 
 Tue, 24 Feb 2026 19:51:57 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:51:56 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 qemu-devel@nongnu.org
Subject: [PATCH v6 32/35] hw/machine: introduce machine specific option
 'x-change-vmfd-on-reset'
Date: Wed, 25 Feb 2026 09:19:37 +0530
Message-ID: <20260225035000.385950-33-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


