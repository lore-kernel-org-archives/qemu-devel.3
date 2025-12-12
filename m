Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B21BD49232
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4i5-0002YT-Cw; Fri, 12 Dec 2025 10:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hn-0002Fe-A5
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hl-00062w-N3
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oEIEJzPUM8lszorjY76ZFvjs6ACj0dKr14L1nFW+0jg=;
 b=TRzNiVyp9W4xfv5pbbZuzFFaG1YBfuqQ61OJUTVYrsJHzztDU/G1irnxF+BxyxjTvX537E
 pTNUFNPr9PM9oDo2vjBjdQT8vWzkCGRJOq3zKB2wvHmILtgEOKQU0uLdFYCJaU8Lz0NbcB
 4rSM0t76KwpHHnCCh0Rcc0WkE//XDkQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-nGBj8aMFP-i1ih8c6RjdFA-1; Fri, 12 Dec 2025 10:05:10 -0500
X-MC-Unique: nGBj8aMFP-i1ih8c6RjdFA-1
X-Mimecast-MFC-AGG-ID: nGBj8aMFP-i1ih8c6RjdFA_1765551910
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-29f29ae883bso7076255ad.3
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551910; x=1766156710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oEIEJzPUM8lszorjY76ZFvjs6ACj0dKr14L1nFW+0jg=;
 b=GR5VLnSN2eR98d+/18fQvtW6vnJnwvc92PaCCBVraE9RhYU2UVdtUkkt4cnIoHDVVF
 7MpYFhiMBLKRNiP+zxovslQDhiy5cNn5s0BVBaPqHl2/XOFvBhqZnxuaWYdji5XQMjaP
 UOpUnoWbPNcA6K5hR/PRh2nGW0Ky01u8Od6V2jcwY7LoEEOCw1E2vH4Me/AWxuQ79EU1
 Tbm9r+2+RnOxupd5sWVqAfSUVzr35+7WD1N/GJu/x1vgU8b+xe9VrPiSlzRwm1n3dqTh
 TgFTU+ayyuiWEn9CR9ch6hd0k8zU1gdYHDzuZxpirqhfZJdBYleaVvBnobPzO5HHraDq
 9fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551910; x=1766156710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oEIEJzPUM8lszorjY76ZFvjs6ACj0dKr14L1nFW+0jg=;
 b=Lqq/pMENZ2OvNJeXFwcU2w1IiHPHfOgAtldpOsO1FNwp0AAPAWp8+kLK1vfPMRWbhn
 QxLt2IMyeMCBmMJXaQ5GBMh/eNo9A8mcn2YiwUo4ea/LTTs/DTw0T5Zkt7RtfImBsiQN
 oCmSkFQIxTf/Ax/0yNyntPnhPOS/p7tWDOXVV41u5h4cScZWfmmixN8+AY/9V2n8Qjl0
 nb+pAM2aeAYJMKrOlJcdw84otP1K4qwtS6WpGeqPz0PBdHyRtoab+UCvCcTAI8960NxD
 6CdTFrSlEYqIxPZx5ROUFEgGiz0g8no5AOycIAy4dK+jm3s5rQJngCqHd4bg1254qj2p
 lrEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUscJyD7CRI4Fy2S/pYvUePGRp9+J0ptrkJV8evkaTPd5HVwH+AL9SfBgnQmeTvIcc7TlFjs8X6IPGl@nongnu.org
X-Gm-Message-State: AOJu0Yx0ntPy3TcbPHWqJLSSRd+Hs6V1AmxJc6rq6zSiiXvQQAdzDDOq
 tD9rHDl9AoqUTyrLjJECf3qUADiV7z+Ngn6ugcol9urZxy7uwyal5rEwMpKcuMvWylteRtOdwqG
 uZtXBDQ2MVJUZHhL0Inh+osd4Z0RCcGtOTT8AAFy7Rf0iLIsF8jgf3kHn
X-Gm-Gg: AY/fxX6MOllCJXlGZa1unzFkbD8C93F9V00Zowh2xTCMAiI7x6pgpl3MVDoYNhcIrVk
 JvMmuK6fiFRBy4PN+AZXO4FGnQDf3GuxLj3Px1CaWsAacWhUIJJAGDXITylncK8dVs04oF+1wFY
 DViiSwUZ8IO8bvy1uvSngonGNXWub7BXHu9RieBnIsVoVQxdVJkLn2FXfXo6kKIU305814he2HO
 WPgvIZSOIXcxv+CIgISgNrFC1eqhhYyeTGf+UvZrCFn90j6j2BuGOyh7S5cgTMB0A98kt6+KbMA
 WV1glabqurd+kOJlASzEhTPgjeQCjPuoWgH7TbJ3EDF4Ffvd1wfLADqOgYwQTb3kyn+Y0PazFCO
 Xri0N+dHxES/5LtIma3KkvMJi9xD0lZ3Hq/l9PTwXzc0=
X-Received: by 2002:a17:903:244a:b0:295:fc0:5a32 with SMTP id
 d9443c01a7336-29f26ceb95bmr19881655ad.3.1765551909578; 
 Fri, 12 Dec 2025 07:05:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IET9ImeOBpvT3cnvF8vtwzmhT6W/Ab/9Nek/sYkQoLeG9AkBTnkGRFc8OBeHTEwi3vM/PO5yg==
X-Received: by 2002:a17:903:244a:b0:295:fc0:5a32 with SMTP id
 d9443c01a7336-29f26ceb95bmr19877865ad.3.1765551905720; 
 Fri, 12 Dec 2025 07:05:05 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:05:05 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v1 13/28] i386/tdx: finalize TDX guest state upon reset
Date: Fri, 12 Dec 2025 20:33:41 +0530
Message-ID: <20251212150359.548787-14-anisinha@redhat.com>
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

When the confidential virtual machine KVM file descriptor changes due to the
guest reset, some TDX specific setup steps needs to be done again. This
includes finalizing the inital guest launch state again. This change
re-executes some parts of the TDX setup during the device reset phaze using a
resettable interface. This finalizes the guest launch state again and locks
it in. Also care has been taken so that notifiers are installed only once.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/tdx.c | 39 +++++++++++++++++++++++++++++++++++++--
 target/i386/kvm/tdx.h |  1 +
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index bafaf62cdb..1903cc2132 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -19,6 +19,7 @@
 #include "crypto/hash.h"
 #include "system/kvm_int.h"
 #include "system/runstate.h"
+#include "system/reset.h"
 #include "system/system.h"
 #include "system/ramblock.h"
 #include "system/address-spaces.h"
@@ -389,6 +390,19 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
     CONFIDENTIAL_GUEST_SUPPORT(tdx_guest)->ready = true;
 }
 
+static void tdx_handle_reset(Object *obj, ResetType type)
+{
+    if (!runstate_is_running()) {
+        return;
+    }
+
+    if (!kvm_enable_hypercall(BIT_ULL(KVM_HC_MAP_GPA_RANGE))) {
+        error_setg(&error_fatal, "KVM_HC_MAP_GPA_RANGE not enabled for guest");
+    }
+
+    tdx_finalize_vm(NULL, NULL);
+}
+
 static Notifier tdx_machine_done_notify = {
     .notify = tdx_finalize_vm,
 };
@@ -689,6 +703,7 @@ static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     X86MachineState *x86ms = X86_MACHINE(ms);
     TdxGuest *tdx = TDX_GUEST(cgs);
     int r = 0;
+    static bool notifier_added;
 
     kvm_mark_guest_state_protected();
 
@@ -736,8 +751,10 @@ static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
      */
     kvm_readonly_mem_allowed = false;
 
-    qemu_add_machine_init_done_notifier(&tdx_machine_done_notify);
-
+    if (!notifier_added) {
+        qemu_add_machine_init_done_notifier(&tdx_machine_done_notify);
+        notifier_added = true;
+    }
     tdx_guest = tdx;
     return 0;
 }
@@ -1503,6 +1520,7 @@ OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
                                    TDX_GUEST,
                                    X86_CONFIDENTIAL_GUEST,
                                    { TYPE_USER_CREATABLE },
+                                   { TYPE_RESETTABLE_INTERFACE },
                                    { NULL })
 
 static void tdx_guest_init(Object *obj)
@@ -1536,20 +1554,37 @@ static void tdx_guest_init(Object *obj)
 
     tdx->event_notify_vector = -1;
     tdx->event_notify_apicid = -1;
+    qemu_register_resettable(obj);
 }
 
 static void tdx_guest_finalize(Object *obj)
 {
 }
 
+static ResettableState *tdx_reset_state(Object *obj)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+    return &tdx->reset_state;
+}
+
 static void tdx_guest_class_init(ObjectClass *oc, const void *data)
 {
     ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
     X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
 
     klass->kvm_init = tdx_kvm_init;
     x86_klass->kvm_type = tdx_kvm_type;
     x86_klass->cpu_instance_init = tdx_cpu_instance_init;
     x86_klass->adjust_cpuid_features = tdx_adjust_cpuid_features;
     x86_klass->check_features = tdx_check_features;
+
+    /*
+     * the exit phase makes sure sev handles reset after all legacy resets
+     * have taken place (in the hold phase) and IGVM has also properly
+     * set up the boot state.
+     */
+    rc->phases.exit = tdx_handle_reset;
+    rc->get_state = tdx_reset_state;
+
 }
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 1c38faf983..264fbe530c 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -70,6 +70,7 @@ typedef struct TdxGuest {
 
     uint32_t event_notify_vector;
     uint32_t event_notify_apicid;
+    ResettableState reset_state;
 } TdxGuest;
 
 #ifdef CONFIG_TDX
-- 
2.42.0


