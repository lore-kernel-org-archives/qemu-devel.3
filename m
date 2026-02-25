Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69FBF55455
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5wP-0003lE-Fe; Tue, 24 Feb 2026 22:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5wN-0003fo-M6
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5wL-0008EL-Tq
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lWSmk7aS39eozNMeUrD49ba8qpOrFdvcFtxo/v8o3SM=;
 b=DeIXeUZa+i6OTzls1BNn3vLetmqJQZniHzDEp01ST+zIuaSqGuRh5HRabO4E/ZrbKdHqiB
 sLjV8w+bA/6hZp+z74kZTWMhYlgkhqsoFCGai5Hqlm7h8sEzMTESMrwwLzBqeQy2Eu6ZEr
 NYfBG8qWnZStnljApSC2PKF2Ev5RcWg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-2NkqVE02PPqjsCM45043Yw-1; Tue, 24 Feb 2026 22:51:50 -0500
X-MC-Unique: 2NkqVE02PPqjsCM45043Yw-1
X-Mimecast-MFC-AGG-ID: 2NkqVE02PPqjsCM45043Yw_1771991510
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-358e425c261so1451965a91.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991510; x=1772596310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWSmk7aS39eozNMeUrD49ba8qpOrFdvcFtxo/v8o3SM=;
 b=jTtli3vonNIO19IB+Tc42kaDUPDLTAQ7/t2ZAAwabQER7KjKQS2/F3hlxnPMMzVGMg
 54A/eLI0GyWptytqw8khkvnO1Ya1F9bhSPrfbbFD/MgxcObU+F+ryiuBKfvfc468Q8HW
 KHLRzg253LdJJOD/RTEQOlMgpXMTAMAWvL0sZIgQZ0Bn/0g5gK/1uVse0u6LDRUlBYao
 0hzHR7zYMgUTCTcFg14VQF9b1nJkBOoomBKzIE+O9eeoA0SZDDqAwe5c0PHLJk/PnImG
 fwzXih5z+L3Pvnq/SLrQI/STm0B2oPpC1YztB/8VqoppjX5OL/idQre00j/t3JX/63HX
 i5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991510; x=1772596310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lWSmk7aS39eozNMeUrD49ba8qpOrFdvcFtxo/v8o3SM=;
 b=HwV4y0+LIO5rohDXk7+e1l1etYCx5nLswDlDEoMLIgDwP/ulsRnME2p/cc9FfyVuhO
 Ziqn/25hv+2OwHctLJekA5Wr6rFm1aqLY3cSfF3WCTCaozhLYaNGB+CbIDWrc22jf1XX
 5SDBQmjURUcAaU8wyhADtOxGfV1vbwL7V7IRnKGf/8rqs7ab6mw0FTWbBZrRmAnUELTT
 9VwoESn5Rv7hizNIunS6VxFArRVaP1adgrqLnVNou+4WFn4Ne6AI2inaNcOUioQQy8jf
 dcXww44xSoQan2zsyFaSVR6cGL2pfBDcCro/Qj3jgGkS4ue/H05hHNVJS4UwqMhMJHUy
 W3+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVvOKscSeKOhk6xfO2hRFovVOlBLwgrjPhrA3zIvHTHkuWjn9bvTHDPc1e6PuDlL7uP+ZVuB23yImI@nongnu.org
X-Gm-Message-State: AOJu0Yxl2ifuWaMABaqXb5YW3S9vjgEhUgoNUcmkI7F7QynO6AZka5Wo
 5+AufzNdiEoc5I+Nsq4BfT253N0+W2RRSjw2/hDXPle7SvXQWF71zjJuG1GQm0Qjap4BeCvz73R
 MzDvraN2X4dL+v7IJ//NQtqswzgXczjy11LGzu7zNB4VVAZkk8yRulrHe
X-Gm-Gg: ATEYQzxWZxOExb3qQseqsoOfGUgO2s53ourItkVZuZPqCW8SEAjHgoYkLFjYGPSNwQ3
 s4dV2UFN1ldixtXnW0JWW9hJnZDyiDro4Evz0JVC+zVVg34rwdPtCzPTb7NFs91EF3zfeRJjZkI
 OFhtOEi67d3BK2CrLRpSmMPdr364Z1xgUmji21irsbihdhLLPcPT/dbvrOmUTDWqGvq+MKeVNfV
 6D7k7B+e3bh8B+3mTS9QTSMi7Fd2JHmZgzxXs4TiUxoCmNOJQy/krAY0PxzULDaWM9Yf3D4LkDN
 JESDf5/SPA872Vcy6w3v90KPkpJwhBD45MhciMYmHUdXgQNzOwkiKjNRE/+Viv4Y6PBupTSv+Gm
 7E3pxcVXKLMXpUk0qVM9Ecn1sGb/Hb/46/x9HK1f0SLV0dWRrcQUMsjM=
X-Received: by 2002:a17:90b:5624:b0:356:2eff:df05 with SMTP id
 98e67ed59e1d1-358ae8a7d46mr13550213a91.16.1771991509832; 
 Tue, 24 Feb 2026 19:51:49 -0800 (PST)
X-Received: by 2002:a17:90b:5624:b0:356:2eff:df05 with SMTP id
 98e67ed59e1d1-358ae8a7d46mr13550190a91.16.1771991509471; 
 Tue, 24 Feb 2026 19:51:49 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:51:49 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v6 30/35] kvm/vcpu: add notifiers to inform vcpu file
 descriptor change
Date: Wed, 25 Feb 2026 09:19:35 +0530
Message-ID: <20260225035000.385950-31-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When new vcpu file descriptors are created and bound to the new kvm file
descriptor as a part of the confidential guest reset mechanism, various
subsystems needs to know about it. This change adds notifiers so that various
subsystems can take appropriate actions when vcpu fds change by registering
their handlers to this notifier.
Subsequent changes will register specific handlers to this notifier.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c    | 26 ++++++++++++++++++++++++++
 accel/stubs/kvm-stub.c | 10 ++++++++++
 include/system/kvm.h   | 17 +++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a347a71a2e..a1f910e9df 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -127,6 +127,9 @@ static NotifierList kvm_irqchip_change_notifiers =
 static NotifierWithReturnList register_vmfd_changed_notifiers =
     NOTIFIER_WITH_RETURN_LIST_INITIALIZER(register_vmfd_changed_notifiers);
 
+static NotifierWithReturnList register_vcpufd_changed_notifiers =
+    NOTIFIER_WITH_RETURN_LIST_INITIALIZER(register_vcpufd_changed_notifiers);
+
 static int map_kvm_run(KVMState *s, CPUState *cpu, Error **errp);
 static int map_kvm_dirty_gfns(KVMState *s, CPUState *cpu, Error **errp);
 static int vcpu_unmap_regions(KVMState *s, CPUState *cpu);
@@ -2314,6 +2317,22 @@ static int kvm_vmfd_change_notify(Error **errp)
                                             &vmfd_notifier, errp);
 }
 
+void kvm_vcpufd_add_change_notifier(NotifierWithReturn *n)
+{
+    notifier_with_return_list_add(&register_vcpufd_changed_notifiers, n);
+}
+
+void kvm_vcpufd_remove_change_notifier(NotifierWithReturn *n)
+{
+    notifier_with_return_remove(n);
+}
+
+static int kvm_vcpufd_change_notify(Error **errp)
+{
+    return notifier_with_return_list_notify(&register_vcpufd_changed_notifiers,
+                                            &vmfd_notifier, errp);
+}
+
 int kvm_irqchip_get_virq(KVMState *s)
 {
     int next_virq;
@@ -2841,6 +2860,13 @@ static int kvm_reset_vmfd(MachineState *ms)
     }
     assert(!err);
 
+    /* notify everyone that vcpu fd has changed. */
+    ret = kvm_vcpufd_change_notify(&err);
+    if (ret < 0) {
+        return ret;
+    }
+    assert(!err);
+
     /* these can be only called after ram_block_rebind() */
     memory_listener_register(&kml->listener, &address_space_memory);
     memory_listener_register(&kvm_io_listener, &address_space_io);
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index a6e8a6e16c..c4617caac6 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -87,6 +87,16 @@ void kvm_vmfd_remove_change_notifier(NotifierWithReturn *n)
 {
 }
 
+void kvm_vcpufd_add_change_notifier(NotifierWithReturn *n)
+{
+    return;
+}
+
+void kvm_vcpufd_remove_change_notifier(NotifierWithReturn *n)
+{
+    return;
+}
+
 int kvm_irqchip_add_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
                                        EventNotifier *rn, int virq)
 {
diff --git a/include/system/kvm.h b/include/system/kvm.h
index fbe23608a1..4b0e1b4ab1 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -590,4 +590,21 @@ void kvm_vmfd_add_change_notifier(NotifierWithReturn *n);
  */
 void kvm_vmfd_remove_change_notifier(NotifierWithReturn *n);
 
+/**
+ * kvm_vcpufd_add_change_notifier - register a notifier to get notified when
+ * a KVM vcpu file descriptors changes as a part of the confidential guest
+ * "reset" process. Various subsystems should use this mechanism to take
+ * actions such as re-issuing vcpu ioctls as a part of setting up vcpu
+ * features.
+ * @n: notifier with return value.
+ */
+void kvm_vcpufd_add_change_notifier(NotifierWithReturn *n);
+
+/**
+ * kvm_vcpufd_remove_change_notifier - de-register a notifer previously
+ * registered with kvm_vcpufd_add_change_notifier call.
+ * @n: notifier that was previously registered.
+ */
+void kvm_vcpufd_remove_change_notifier(NotifierWithReturn *n);
+
 #endif
-- 
2.42.0


