Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7E6C9EC8B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHvD-0005ZS-Pl; Mon, 12 Jan 2026 08:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHuh-0004ho-3p
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHud-0003uU-5e
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=86mEnb9lQKh13f1QZoUI2ApG8aM8K73+JjWMM/hRrmQ=;
 b=Ji2ED3P2+oEEqjIhSD94GNdRIHRTjrBI3/QET3YguvuH3CRJkYj1TC85BsC0opZxiMARpg
 6+wguOtYaZZmDRjvtT8HQl1TfuA/pay3fA5Kg/sF3db2dDbmi7r4JGG0P76P2CzoqOeb2E
 pg1fgj8m4El8jIC9QeSBXMqOntRinFc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-JGqP_3cINcqqbsSU-T_5dg-1; Mon, 12 Jan 2026 08:24:49 -0500
X-MC-Unique: JGqP_3cINcqqbsSU-T_5dg-1
X-Mimecast-MFC-AGG-ID: JGqP_3cINcqqbsSU-T_5dg_1768224288
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-34c6cda4a92so7002686a91.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224288; x=1768829088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86mEnb9lQKh13f1QZoUI2ApG8aM8K73+JjWMM/hRrmQ=;
 b=TP136fjea9CycgckiBYA4Z+xqk24AJJ7Z1tfpIe13bRC4orxwZ/ho3fPeun4PlPASw
 KK2bnZyDuCwGIp9nQlmdTa11ja+QtOTL8X1h15BjjqC4HgW68s4bRikodGVsEVFMs1ZR
 dBCiA8xKLzup3lUmeLxR4fhBrMp6I+QaX4F72lN0fCuvVPgAQTi3v4jen0pkIFKVR5yQ
 1IlBH2nx2PNijnRCWeUT+LlgarmLxr1VN18v2XdvUbtZFWYbGLs3GBzQX1PyYySKWJXu
 Y3ohGUzgo7SIo1VGb+AGVAEUJhDeHZixF/6EGRc1RaPTw7wp4ISqGOHvExqP6YVacZHW
 YEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224288; x=1768829088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=86mEnb9lQKh13f1QZoUI2ApG8aM8K73+JjWMM/hRrmQ=;
 b=m7zTsaI4yX3MZSQ8O3PNmmb4EpNopHICsn87hhXDCVySAEAnjNxBLF9hL8/27jz0Dz
 QERcTMdWAtNk8H3zUmi9cbCaXZJppn+2PcsC/tM82RyCaozSye5tbOdANS0RjOiqT2jx
 6dXiNAT9WjTSI5+SsM6PlnAH74AkUZZQeoKP2YvgHWhPGnNjHpMyEvmsOr4r+sBq+pqG
 ZbapJOXS4mdfWmlSHnYlONuyvCFYn/hSl8XBUIbb1iCyTJBHWftN2TO3DXbZVrrJoPbi
 AiyWm98NLDmZVQjyeq38wTodTc6ksZjDW+eKIBdh2wQLdbA4okg05jsctfPc2Nx4kfOb
 s6Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7SvY7pK6Hg9RpV1ZFYbW7n9IGFVUh7ZldwBAkByePDZEd9V+8BTFqeZzOonB0uvkJ2v9bN/DqE76r@nongnu.org
X-Gm-Message-State: AOJu0YwLe7gdSUpiZhPVYDjRs3P9bQZbeevU8Ijm7uawBMO6BH0UZ0IN
 gNcup1eG04JqV2QA+LWKEofCpoPis9BOZ4KNb3pXMeK5T8iSsGlrhOt3oLHz+SGQ5IImW/bf97m
 65g0eh+UpRhQd9/DQ8ugAp5FDgN+ClPBVyPWZErThYWaUNocMYS/JkDOf
X-Gm-Gg: AY/fxX6HjtRVz944jgdLeY5OOvwXPyhWr1O6GmhBQJ2YOuvgFTXWq/QXEA+R6D1UpGE
 9BdPGjy19nHetF46cS/nfGxHsIYkFPt1h4GW2RDy6vyR4rmldydpDChYWLniGz0X1jLTL33uKCk
 /GpAWNH6UFni57C1Ywecrk3sMrJQyfivJ+6tmz9dMPl5ub9MgKsEitSAf9Xgy14QwpC3Z6n3E38
 2pk+ZwOZWSBwHPFO5Q90P0k2NGkt0dnclfoMe+Jt0AtKc4D1U+uGCftIll/08AWxQmvJljj7qtF
 j9MGeuqf9LmxkpWEKxWkpn9gAKY3GsnSlBmXQdXjVFuj5P4S2zJ+2rCEmjpp7HvYjdLWCCfHfdk
 /7xkDaqtEiRnr88tAmxE8lWFZLjAmTTYvXJ6BcaFeH7Y=
X-Received: by 2002:a05:6a21:99a9:b0:35d:53dc:cb64 with SMTP id
 adf61e73a8af0-3898fa22672mr15732609637.54.1768224288386; 
 Mon, 12 Jan 2026 05:24:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGv4NbS7GCObyC6qOmDB5VB3QamrvwMZM2P0KglCKK5EAKJ/fSev8mbeGWKijRncBA3kfvGaQ==
X-Received: by 2002:a05:6a21:99a9:b0:35d:53dc:cb64 with SMTP id
 adf61e73a8af0-3898fa22672mr15732586637.54.1768224287989; 
 Mon, 12 Jan 2026 05:24:47 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:24:47 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 31/32] hw/machine: introduce machine specific option
 'x-change-vmfd-on-reset'
Date: Mon, 12 Jan 2026 18:52:44 +0530
Message-ID: <20260112132259.76855-32-anisinha@redhat.com>
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
 system/runstate.c        |  7 ++++++-
 3 files changed, 34 insertions(+), 1 deletion(-)

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
index 710f5882d9..a4572af2af 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -531,13 +531,18 @@ void qemu_system_reset(ShutdownCause reason)
      * file handle is necessary to create a new confidential VM context post
      * VM reset.
      */
-    if (current_machine->cgs && reason == SHUTDOWN_CAUSE_GUEST_RESET) {
+    if (reason == SHUTDOWN_CAUSE_GUEST_RESET &&
+        (current_machine->new_accel_vmfd_on_reset || current_machine->cgs)) {
         if (ac->reset_vmfd) {
             ret = ac->reset_vmfd(current_machine);
             if (ret < 0) {
                 error_report("unable to reset vmfd: %d", ret);
                 abort();
             }
+            if (current_machine->new_accel_vmfd_on_reset) {
+                qemu_log("INFO: virtual machine accel file descriptor "
+                         "has changed.\n");
+            }
         }
     }
 
-- 
2.42.0


