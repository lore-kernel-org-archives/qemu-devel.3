Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B86DEDF04A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQBJ-0001r7-24; Thu, 12 Feb 2026 01:28:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQAc-0000Vj-U1
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:27:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQAb-0005Mh-1f
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5baHEmSS1KnRdwjNGuB0g+ltPY1ZMuCXtAxZqqNbqAo=;
 b=SCMLHjoydYn2nwVOVf4GkGvViFSQGdzd8rBuy1ikINfFZBJihuK5aZEOTTSVABU8bejW2F
 oDeTNHrSqeNi55KF6InZ6Z6StZsad5OjHwlvTB8zYUGxw5EVuIcLVllcZs+QaR1KInHfrT
 7Qn36A4hJLIJR+LWeNsoj39ajxQqYbg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-nqrUuCPFO6apyK9dRyhlOg-1; Thu, 12 Feb 2026 01:27:17 -0500
X-MC-Unique: nqrUuCPFO6apyK9dRyhlOg-1
X-Mimecast-MFC-AGG-ID: nqrUuCPFO6apyK9dRyhlOg_1770877636
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35641c14663so4472444a91.2
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877636; x=1771482436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5baHEmSS1KnRdwjNGuB0g+ltPY1ZMuCXtAxZqqNbqAo=;
 b=Pep0k52vQzvCJS5n54U+Z3ru/hMXFeT6hxMedsUKc+11j0IHusoWYwzkl2UuiGZBAK
 wZimpkShRGo4b15U1hXHWQeWhvClUx80Yd6HsRl/8K/d5wXzS6+iPFx3/WjzwcIof1bJ
 2NHpFAbMla9pdQf7zNwqSHsa7KOSGZ2pAvLuBmd1fq9lSFThuJ80Oc2QWjzKu/UWi27T
 bxQi9xhzAb0an6+EesQxedVoh3f/Tr4lZMezP2UiuPm1/mVnR59xVmz0yUqahz5nWR2C
 /x79/qh0JOdqQFBlCwrLzqKywfYULvyC6EmfRSGLi6tPGsrtf+hoccI+AO0BlAl188jA
 5FpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877636; x=1771482436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5baHEmSS1KnRdwjNGuB0g+ltPY1ZMuCXtAxZqqNbqAo=;
 b=vqz1kbFjwHjQ8W6aNxyDpw/R8urYuZpNpvOFNFrJyIEDFy12/Eul6nCUBRn2pti9T0
 YN0c3Hm96aK3AYnUWyIG2g2hqeXaLi0MTFvuYnJD41caAwRvXSk/Nw6iHwWSl5kb5rJD
 7m3PnH1LGjxLIKusWtwar3d2oAEaoPEbWIylQ+DoPp88Vr9pNvXwkX+5JuUQYLNPGYUy
 0UiPTM3BRH6AMSPh2rE0nlppoQNuucMI6O6J3r/wph6gPO12OBg5OZTpem4BDQ+VRhuk
 1nRVsRX3eYUAvZxHBDrafqouvCwtuuG6JHhTRAG03RmHwMAoMaLRtBxdUdwAajub1H/x
 Mcbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHmthH4fEfFsUu8zRx8M3JTt168A5mk0A8K6UhsLf+znM4yAyCNLQPDToXQtMa5L175uguE+Ves6yw@nongnu.org
X-Gm-Message-State: AOJu0Yxe4NDY216T6Qikr8WIGslpBxF5cykDOO/UuSiCDkr1xGnmA2fq
 +oh1rpAtZZyVenUPbRfX4Mh+cC1ZYUOUe01cJA3GOUk0vBmDKOW7gOImOFcBSOAwusb24hqMPGi
 YenlS52zfGeZGGtbNIPibw0xXK9N0vCEiiHLoHTbnuLnFRP2LBunsEiKe
X-Gm-Gg: AZuq6aLiJ++7XmufZcOnXMFtKA74NEfVi96l4s/paRin4m89YRiMydnjiXkOVgcqB0Z
 2yvCwlaJFYonMiIi9c3YPNXfY8hZrDdXaH+uQia3C4KZoDb6/V6tG7QcOE9gnNdEB6thsRp6Ss7
 /j7S3Q5RFf7jQLoaf0YJ7BUwd3CJ5V299Tm0h2YDMxkmm/NkNhCeKvuUJpXC+e1AyxEM3qXJIkF
 A/yiyfM8fDaqXlM09AymhIj26g3aROLBntXqJ4nwseyQLDIWTexyn9Gpg6jgUOKiGC/3aEgFbhG
 eHK9NQ/DCHETEQOTV6lasXagoEBhV9NXCVH812WJBGckm1dL00NPiyxuzVQQ2DlNqhkdgwOlqyK
 SCV0z/uprJG60HGHS7g5Ih3Z8Lok+0fttfsspLsqwFgIcU94lHNaZaVs=
X-Received: by 2002:a17:90b:3851:b0:34a:e9b:26b1 with SMTP id
 98e67ed59e1d1-3568f40232dmr1584981a91.26.1770877636223; 
 Wed, 11 Feb 2026 22:27:16 -0800 (PST)
X-Received: by 2002:a17:90b:3851:b0:34a:e9b:26b1 with SMTP id
 98e67ed59e1d1-3568f40232dmr1584965a91.26.1770877635918; 
 Wed, 11 Feb 2026 22:27:15 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:27:15 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 28/31] kvm/vcpu: add notifiers to inform vcpu file
 descriptor change
Date: Thu, 12 Feb 2026 11:55:12 +0530
Message-ID: <20260212062522.99565-29-anisinha@redhat.com>
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
index 5e81bf8ad2..4d4d361708 100644
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
@@ -2838,6 +2857,13 @@ static int kvm_reset_vmfd(MachineState *ms)
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


