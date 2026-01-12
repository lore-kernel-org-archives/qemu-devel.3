Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780F3C9EC8E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHuH-0003Qw-6k; Mon, 12 Jan 2026 08:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHte-0002pd-RY
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:23:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHtd-0003jD-7w
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mXnd/EV42IZ35HCUh2hymkokKll/IVZCRGZsgYgJG/k=;
 b=Py/LkrKP/0oeEkxmMbOFADi+aW0Z+MX/kSIWkDC1jgPcU2xzlL5S2uUgu6WN6Lbj2EpFWJ
 /jCS87Yh9LunjSLbM7JtOVo36vbgBMUKC5zjpjFWFhvTLdVSIjH6Yj0iEN7usnhvuVcbBO
 aQEU/hRvmiMB6vXKAvTGRYXYmn8El8Y=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-rLDrxq4FMXOCPCx5aiOFIQ-1; Mon, 12 Jan 2026 08:23:46 -0500
X-MC-Unique: rLDrxq4FMXOCPCx5aiOFIQ-1
X-Mimecast-MFC-AGG-ID: rLDrxq4FMXOCPCx5aiOFIQ_1768224226
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c52ab75d57cso2604123a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224226; x=1768829026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mXnd/EV42IZ35HCUh2hymkokKll/IVZCRGZsgYgJG/k=;
 b=IsG+243W2p0GeKRg7JMJm3sTgt3wCbA9Xo8dnLKVBFuDmG5XftXPWyMRkr3iWQN4vG
 DIirurCKCHj1Ft9O8QccOAVrnhdbQUJF35fEebPZcSsmEppv115i/XfgGiKv2go8RXc5
 fKocNh9pxZIXUUNFjDw2ZpKHd/yYy8kejugXF02srlgSMesbbiFi9poiJgZ0rfisxw+N
 m85/ti3lMyFkOTfu7L/taozOlz8eeEhuYA7S7dGzDZWUFIZu7n4ga3ch4lMde3fnHFCM
 +gfgky2ZoKQTi7itfNRXs0Q4jYUnAJFgiN8ySG0Sr3sLKysEoyxvm1HCsPmn7XB2JRF9
 xOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224226; x=1768829026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mXnd/EV42IZ35HCUh2hymkokKll/IVZCRGZsgYgJG/k=;
 b=qEwkxFajHd/7v+jAsmFWIP9UaEqBup78GTKKVAF+zZ5d5r5AYPYDq48Zpc3Grpr3N+
 BdNXRfqhSip3KKBG5ZnZPdRfrqxv+YrzzQONz3SfQV0/t+LmTkd2hKmCaMj0D457CWys
 ZBG5m8fB74eDDpqIoT50CC20QtzAsnEG3Zhg1FQRWgtLy1ZbL72DItyZVbAGEC/BxWCQ
 YZacyqPO5IUYYiTJjpoKCfOVwTajgiAHpU94c3BuNOYFeNQHL24fttr6QdzUXZHj2IEF
 Lgoyi5VVjlg2zmb7S1oMc0HgOBYG686L1FfHZTHJLv1zcC/QKEGWoF4rVBw6oC14988Z
 rlZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBJdoteo2AOq7yysnd2yXDwTCJ9RXUpmaZh/8GdUGVzy04O3UBeygIQtMcOZOhLcOj7Pgfyo0MagAt@nongnu.org
X-Gm-Message-State: AOJu0YxO/eYxkv8rdtdoEEeVLNWnZ3Pszikby/rmtku1IEpr6sqOTdXP
 uQXGIsNVnWbzLwokf7J+izseeeyOpleEXf4+5J8HYMz2H1jL0iCOsXDXIkAxCoisgHQ4UPdDitW
 jWZPhr4uCGQeVYPvAa88S2x0GAa5Y8qZ1AO7YMXQnmWh3dlwxzqXYdjaL
X-Gm-Gg: AY/fxX4nPpPvJfA0cXyvJi38RZmrqVDloTeGQB/7jOP3VWbNB+bWo7rZ76I35CPzWab
 UGzQgyb3BulGKRoRiKY1Qv/hS25mY9TEjkq0pZH842aU8gg8e0xcj3X8DS65yeySyrV5C3+Tq4S
 6mrzM0CHWGKkL/hYLgMLqBpJTpIX2JpoKrsXPfrIcRCNSDU3Y3HEjHsQesqaEiEcaN8NUPYGmh0
 TreGaCCmhgrX7bEc/pYjyqOSQLGAjubGDHxSGzsLYVXo/QMS3FyB3mTA/5nQNDWCEjixb0scW/p
 sh2LEkejz0X1mlktZdksbpEwI62CVSPTQOHFNydEDq3X3RHVw/dHd2CyhPI63Yr72PzU2QMet/N
 762thjkbxEgI2zu7o+6RtZ2Ji58LbLmD8oQKCrffM2tg=
X-Received: by 2002:a05:6a20:a103:b0:342:d58b:561c with SMTP id
 adf61e73a8af0-3898f907cefmr14777671637.27.1768224225713; 
 Mon, 12 Jan 2026 05:23:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFs6vdKuXiT9xGiDjo8b+a6b0Gvb8YUqfg9iXUDT1nezLkJVAiTWy1CvXHvEfiiPoDEtsOJ8w==
X-Received: by 2002:a05:6a20:a103:b0:342:d58b:561c with SMTP id
 adf61e73a8af0-3898f907cefmr14777651637.27.1768224225286; 
 Mon, 12 Jan 2026 05:23:45 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:23:44 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v2 07/32] accel/kvm: add notifier to inform that the KVM VM
 file fd is about to be changed
Date: Mon, 12 Jan 2026 18:52:20 +0530
Message-ID: <20260112132259.76855-8-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
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

Various subsystems might need to take some steps before the KVM file descriptor
for a virtual machine is changed. So a new notifier is added to inform them that
kvm VM file descriptor is about to change.

Subsequent patches will add callback implementations for specific components
that need this notification.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c    | 25 +++++++++++++++++++++++++
 accel/stubs/kvm-stub.c |  8 ++++++++
 include/system/kvm.h   | 15 +++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index ef8e855af5..367968427b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -127,6 +127,9 @@ static NotifierList kvm_irqchip_change_notifiers =
 static NotifierWithReturnList register_vmfd_changed_notifiers =
     NOTIFIER_WITH_RETURN_LIST_INITIALIZER(register_vmfd_changed_notifiers);
 
+static NotifierWithReturnList register_vmfd_pre_change_notifiers =
+    NOTIFIER_WITH_RETURN_LIST_INITIALIZER(register_vmfd_pre_change_notifiers);
+
 struct KVMResampleFd {
     int gsi;
     EventNotifier *resample_event;
@@ -2193,6 +2196,22 @@ static int kvm_vmfd_change_notify(Error **errp)
                                             &vmfd_notifier, errp);
 }
 
+void kvm_vmfd_add_pre_change_notifier(NotifierWithReturn *n)
+{
+    notifier_with_return_list_add(&register_vmfd_pre_change_notifiers, n);
+}
+
+void kvm_vmfd_remove_pre_change_notifier(NotifierWithReturn *n)
+{
+    notifier_with_return_remove(n);
+}
+
+static int kvm_vmfd_pre_change_notify(Error **errp)
+{
+    return notifier_with_return_list_notify(&register_vmfd_pre_change_notifiers,
+                                            NULL, errp);
+}
+
 int kvm_irqchip_get_virq(KVMState *s)
 {
     int next_virq;
@@ -2654,6 +2673,12 @@ static int kvm_reset_vmfd(MachineState *ms)
     memory_listener_unregister(&kml->listener);
     memory_listener_unregister(&kvm_io_listener);
 
+    ret = kvm_vmfd_pre_change_notify(&err);
+    if (ret < 0) {
+        return ret;
+    }
+    assert(!err);
+
     if (s->vmfd >= 0) {
         close(s->vmfd);
     }
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index a6e8a6e16c..7f4e3c4050 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -79,6 +79,14 @@ void kvm_irqchip_change_notify(void)
 {
 }
 
+void kvm_vmfd_add_pre_change_notifier(NotifierWithReturn *n)
+{
+}
+
+void kvm_vmfd_remove_pre_change_notifier(NotifierWithReturn *n)
+{
+}
+
 void kvm_vmfd_add_change_notifier(NotifierWithReturn *n)
 {
 }
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 7df162b1f7..edc3fa5004 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -587,4 +587,19 @@ void kvm_vmfd_add_change_notifier(NotifierWithReturn *n);
  */
 void kvm_vmfd_remove_change_notifier(NotifierWithReturn *n);
 
+/**
+ * kvm_vmfd_add_pre_change_notifier - register a notifier to get notified when
+ * kvm vm file descriptor is about to be changed as a part of the confidential
+ * guest "reset" process.
+ * @n: notifier with return value.
+ */
+void kvm_vmfd_add_pre_change_notifier(NotifierWithReturn *n);
+
+/**
+ * kvm_vmfd_remove_pre_change_notifier - de-register a notifier previously
+ * registered with kvm_vmfd_add_pre_change_notifier.
+ * @n: the notifier that was previously registered.
+ */
+void kvm_vmfd_remove_pre_change_notifier(NotifierWithReturn *n);
+
 #endif
-- 
2.42.0


