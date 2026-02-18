Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EE0E9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfxs-0003JT-A9; Wed, 18 Feb 2026 06:43:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxf-0003Cs-8W
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxa-0007pN-2b
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771414993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eq6qLXbyXLJc54ZDJbb9jP08uxtrOMIUIN9nTu5R5VE=;
 b=L6yQ8cRnnTzIMP24fhwHyAUuq97qo7Xmk7MJ0vLzZrSLUrfCh6uUChlD5tbC3wKefCSU5g
 LwyMCTT6nRSmCIsJNpdFRDKOxYneGd1ANr6M4hGwlwXkS9lGu7sob1Aif5sW6m9iam/0BQ
 05+Ha8JMU3Ke/QzdNMHaq58lHeZaFgA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-VRY-ii9fN16fNuk305Fr5w-1; Wed, 18 Feb 2026 06:43:11 -0500
X-MC-Unique: VRY-ii9fN16fNuk305Fr5w-1
X-Mimecast-MFC-AGG-ID: VRY-ii9fN16fNuk305Fr5w_1771414991
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2aadeb3dee4so311578665ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771414991; x=1772019791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eq6qLXbyXLJc54ZDJbb9jP08uxtrOMIUIN9nTu5R5VE=;
 b=sHcApYw1MH48Dd4bVvJcrvb6+yIc9ixK3eJMHpDZXSdhBssNu5SANyLuiu0kxSvOBi
 gij1sfq8vE3ubOmaJILFJzRispD8EZutZAFnYa7ih1pzTdclo6dLQMBAZw7G4tA6+3Az
 61okT4LNTogjI5i+Xs09Ed28xsVeVu1nWZ+8Nad+qbDYuldJXD4AP5XINRj2Y7Pnnqx3
 UepmtA56nynLAIiorGWU2NaObqOKhsjdSl1HilwKlOtw8dFvPtPSL5gjyOnDb/t/VKA8
 lV0eFjVguBPZ8Wd4M7Ku8z7o3AQSDw0zaZXFr5S5ZhRkL4URLylJ+hCETEVxJXlA5+8s
 ig9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771414991; x=1772019791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eq6qLXbyXLJc54ZDJbb9jP08uxtrOMIUIN9nTu5R5VE=;
 b=OqUYEosz3iK3f7mg4tLbLJEM7IXNV6e21zE8KlFeoe8iHUSvM8wz8W53oG697nFVqT
 Hu1fBbQYXQ8vtDHdxu8goE0debZXCXaTNK+6jMfgIsYifKnhz3VeWOUCCKEZ8JIySz7/
 PHl4yu66prVzjTfZbWC1ycmvxh96SVyB9u2tcTGkY8oBRCVm82hUM92MnhINZoQ1tBDh
 1tZAU4opNV7VIqFkT/wITHit0xS3mNnuxJ7QMruGzhpLrXABeHGD7jpGYqHMSst3Agbt
 Q3mUlqvx/hMwX27AfcNJnt8V1esiJ+7ICY4ZGx4YD1hSBAD6sxLKng8T8QsaiPy9g7f/
 8mfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh2SQkPenQTDzazBmZRK/PygqRfg5ABbrSjBuoBsqFPUtl8IHyBRKGt6EM5bdRibELgiFIfzkWV6Zf@nongnu.org
X-Gm-Message-State: AOJu0YxXsTurTZ/7eH+PLRF/LAHwYe9aTkNY+b1pL20hugXiLmFHye+s
 XbSP9NOAS4vN5azvN7Px0myBOcUAUr2GPJy9h6bgCdcXjj00oRxA+WQXJaQbAgxCto9oXiPZMjL
 XjSXdXUH/U60ICNbmybCufK8um0pPt5edRr/ohzvezXJCb9VPl0QeOtn3
X-Gm-Gg: AZuq6aJhWv9hzluaJB1h+FHa/iTd4CtxPH/eQbGcgAVn9uonBgu41Lq7KEXHcHs/4Bx
 6c7Bxb/WFwVqpiBK+5BXjAKBOK7t0jcPEwL1gORZ81kIG7pPS+sqJDKtbAn/HbH7CLUCmQP6oTn
 QkObFkupyWG2EHCZhpvUKRllyUKXQHx3rUxxhL1d7MQMQJua1RaKk0Gs9IO6k4TmTHeEs0tInYH
 eflFPAJvWjJEBbvE+Yteta4eP9t8K/NCK7s2wm0z5KxJSso5XAmIXOyKku4835Sxd7BZnVVFFxE
 mW657wdAAldc3QeF/KzkwWc4XKbVErLpbNAwkpcU4j+DEj52SQmARbW8+xTRumAiIhXwQ0KCWRY
 Xnw1Tdf2biKUE00rJwy/zCHZ2cNLgqfIK+tBbPwRGcJYt9F87kDWz
X-Received: by 2002:a17:903:2282:b0:2aa:e238:e219 with SMTP id
 d9443c01a7336-2ab4d0b2e48mr167750695ad.58.1771414990741; 
 Wed, 18 Feb 2026 03:43:10 -0800 (PST)
X-Received: by 2002:a17:903:2282:b0:2aa:e238:e219 with SMTP id
 d9443c01a7336-2ab4d0b2e48mr167750475ad.58.1771414990343; 
 Wed, 18 Feb 2026 03:43:10 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:43:10 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 08/34] i386/kvm: unregister smram listeners prior to vm
 file descriptor change
Date: Wed, 18 Feb 2026 17:12:01 +0530
Message-ID: <20260218114233.266178-9-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We will re-register smram listeners after the VM file descriptors has changed.
We need to unregister them first to make sure addresses and reference counters
work properly.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a4e18734b1..83657fe832 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -112,6 +112,11 @@ typedef struct {
 static void kvm_init_msrs(X86CPU *cpu);
 static int kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
                           QEMUWRMSRHandler *wrmsr);
+static int unregister_smram_listener(NotifierWithReturn *notifier,
+                                     void *data, Error** errp);
+NotifierWithReturn kvm_vmfd_change_notifier = {
+    .notify = unregister_smram_listener,
+};
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(SET_TSS_ADDR),
@@ -2885,6 +2890,17 @@ static void register_smram_listener(Notifier *n, void *unused)
     }
 }
 
+static int unregister_smram_listener(NotifierWithReturn *notifier,
+                                     void *data, Error** errp)
+{
+    if (!((VmfdChangeNotifier *)data)->pre) {
+        return 0;
+    }
+
+    memory_listener_unregister(&smram_listener.listener);
+    return 0;
+}
+
 /* It should only be called in cpu's hotplug callback */
 void kvm_smm_cpu_address_space_init(X86CPU *cpu)
 {
@@ -3538,6 +3554,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
 
     pmu_cap = kvm_check_extension(s, KVM_CAP_PMU_CAPABILITY);
+    kvm_vmfd_add_change_notifier(&kvm_vmfd_change_notifier);
 
     return 0;
 }
-- 
2.42.0


