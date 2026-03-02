Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6D6D58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvI-0006Pf-Gf; Mon, 02 Mar 2026 03:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyum-0005Kf-1n
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyuc-0001wT-U7
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lrh321sUlZncTweQpqmP4/PZMRj0UiAkskbKxK9u3DA=;
 b=SyherBEgXAMfA5CRJINxatSTQdGHOz11aReGIS0wNkQUGmd+wKzXr36itWPrS+W4IyJBdG
 2s0auBDf0JzY46iLAwbv4BS1EjckKp1OakEboyvcV9aTFEH2DuWZnxxsKKdsYfZNf/33VE
 Kn8V2xTqIToBg4evicCUeMbNOt059eI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-Qz8YSp4BP5GA47Vv1wExAA-1; Mon, 02 Mar 2026 03:45:53 -0500
X-MC-Unique: Qz8YSp4BP5GA47Vv1wExAA-1
X-Mimecast-MFC-AGG-ID: Qz8YSp4BP5GA47Vv1wExAA_1772441152
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837f288194so30283315e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441151; x=1773045951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lrh321sUlZncTweQpqmP4/PZMRj0UiAkskbKxK9u3DA=;
 b=L0AWapcNXkJN/DH0SxFYAH6hbKdzyu1OCcXBvW7/O2/Qki6LSlL6sOWjVC9hObU3Hn
 S648THADS1PhxuGuHbCa9jMT0Krh69wpZGD4wM8Z+O72dc2bsgUpSOKFtT1B9k2UvYBd
 NJK9aOCwwNVowOQ3qrqHmNLx5njdSgciYbdEbc28iKREoYT8RNaljivAu4n6SdX5c+f5
 hSyQmhyOVjC/Ki2htJfXqtcBEre1kAtiwd7TwXE1iK60u4SkyK519XGxC5XP1BFjxhiU
 Mre7iq+4t2A6oXB33yT9OrbdGHHcAyidQ0ETQF1BPq1S7Ph63CE71dMucVWsGcFB78+x
 nkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441151; x=1773045951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lrh321sUlZncTweQpqmP4/PZMRj0UiAkskbKxK9u3DA=;
 b=TyScpwkg3oOXSmSM5lRUScIC3dvNGg3Em0VXurruqUlrJeKXXmFtZGFnFJpFQld/+a
 74CLbE5dtshYjwnQff53azSG6N68G4sAwpIbVVNyMzZUnceHoivLv12v4a8IsURim4gK
 8YA9vvIG1/E5iyuJvlTkHiGf05MzxCNwK8gOw1M+Z1SaBQzPOJWU51PwWDbDKb4bvs7I
 qPBc9J/CjSNdQbB7VzRShMzsVD2LD/E9kBdhlxykoTGT67t8sCFq3cghXpYJtOW+c6NO
 ZBFdaa2vNQZKt4zM8akOm/8ZHPWMfAMswey8JeqW8UzjtYiEkmuD7aimtV6ZkE8r/oQh
 KO4A==
X-Gm-Message-State: AOJu0YzLxCsfw93WbOfFVuQ4rrb9nve7od+lXr2Q+Hx1Xni9fsaJ7XPZ
 o2NQ53GNo7Mczu76e0meUoKvKEydFKRzQEKJr4GXIwH9kB399pLkQu8yurEBoNIvyAuxRyqsWej
 Y6MTY/H1FJdiJMgNXHgpDLW+DpWtKL1I5R5aP0r0j9WnlS6j+sBdKG2qDL0gxD5ww1Dd1tZol4r
 WOj9NGAWY0g4KKA3pP3E5vmnpBA9Xau4bRCIHYXNyA
X-Gm-Gg: ATEYQzxHzRUHsd58wJEKfDfHQemGhOOmXWVf+t4r5+AKVP/aCAABLbXuBOKtErSVfiA
 qf/QSlatXP0NpBw37ulyv93F8O8DqCNwPr725ZuhPiilpTaQ0JgNZvudu1vl/XKSUfsIvd/YVHJ
 A6an0/nPaAxh2hPLWOsrIIdQ76Ue6uqfAGHy2AF8aJ43C2yeF5X9HFqJvThuwoN5KC/oGWyNIEl
 XwNELhPSYytdwYg3/Gu/kgBqJolpMz/qt8cY6D/m2bvgRHnn4OnVYRCALQVHsGldqLZJSiCpL7n
 X+63IBMsnglHpyEvhnokx+ZN7yKIvprJ4EX0QpCzodgyc5Bbe4VmelFBTU1uurE8L8FvPwcYJ4S
 FjF3h8rkD8DSEtAu7ekTaQEZHoJXmk3ujiB9QsNkQ2i7Hp9aJmR3hnYbMjnesXMlNRmU8bE/Mev
 T52Hyu3bMxsKrZgLBdYiSknQZ50DE=
X-Received: by 2002:a05:600c:350c:b0:480:4a8f:2d5c with SMTP id
 5b1f17b1804b1-483c9c2c2b8mr184252495e9.29.1772441150516; 
 Mon, 02 Mar 2026 00:45:50 -0800 (PST)
X-Received: by 2002:a05:600c:350c:b0:480:4a8f:2d5c with SMTP id
 5b1f17b1804b1-483c9c2c2b8mr184252025e9.29.1772441149840; 
 Mon, 02 Mar 2026 00:45:49 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b130abfasm10471304f8f.34.2026.03.02.00.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:45:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 049/102] accel/kvm: notify when KVM VM file fd is about to be
 changed
Date: Mon,  2 Mar 2026 09:42:44 +0100
Message-ID: <20260302084338.473368-50-pbonzini@redhat.com>
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

Various subsystems might need to take some steps before the KVM file descriptor
for a virtual machine is changed. So a new boolean attribute is added to the
vmfd_notifier structure which is passed to the notifier callbacks.
vmfd_notifer.pre is true for pre-notification of vmfd change and false for
post notification. Notifier callback implementations can simply check
the boolean value for (vmfd_notifer*)->pre and can take actions for pre or
post vmfd change based on the value.

Subsequent patches will add callback implementations for specific components
that need this pre-notification.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-9-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/kvm.h | 6 ++++--
 accel/kvm/kvm-all.c  | 9 +++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index f11729f432c..fbe23608a16 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -571,12 +571,14 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);
 /* argument to vmfd change notifier */
 typedef struct VmfdChangeNotifier {
     int vmfd;
+    bool pre;
 } VmfdChangeNotifier;
 
 /**
  * kvm_vmfd_add_change_notifier - register a notifier to get notified when
- * a KVM vm file descriptor changes as a part of the confidential guest "reset"
- * process. Various subsystems should use this mechanism to take actions such
+ * a KVM vm file descriptor changes or about to be changed as a part of the
+ * confidential guest "reset" process.
+ * Various subsystems should use this mechanism to take actions such
  * as creating new fds against this new vm file descriptor.
  * @n: notifier with return value.
  */
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 3b57d2f9769..d244156f6f4 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2654,6 +2654,13 @@ static int kvm_reset_vmfd(MachineState *ms)
     memory_listener_unregister(&kml->listener);
     memory_listener_unregister(&kvm_io_listener);
 
+    vmfd_notifier.pre = true;
+    ret = kvm_vmfd_change_notify(&err);
+    if (ret < 0) {
+        return ret;
+    }
+    assert(!err);
+
     if (s->vmfd >= 0) {
         close(s->vmfd);
     }
@@ -2695,6 +2702,8 @@ static int kvm_reset_vmfd(MachineState *ms)
      * notify everyone that vmfd has changed.
      */
     vmfd_notifier.vmfd = s->vmfd;
+    vmfd_notifier.pre = false;
+
     ret = kvm_vmfd_change_notify(&err);
     if (ret < 0) {
         return ret;
-- 
2.53.0


