Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E93EF55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5v9-0007N4-3A; Tue, 24 Feb 2026 22:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5v7-0007Mg-2n
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5v5-00087f-Hb
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiDP313hLYqjOYRS0lxOjLmlSH8sKARSr3ovVB1pph4=;
 b=L1md0EdVP8Tv1d2AkZkK+SlB1j0wOANp7IVMVaHGBrIo74LLrE04G75riAnOAtr+ukqMLT
 ZHYgiMwU1uQoC0BeDM5Va+ExW7mcg3x494WsX8GtDL+vAjn4W6uTdofxjq2u93FvWDkhDf
 6iBZKhkuKoWEEhTYyK884go1bBDMjAk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-8fU2dCNTNXivZyMIZuKiEA-1; Tue, 24 Feb 2026 22:50:36 -0500
X-MC-Unique: 8fU2dCNTNXivZyMIZuKiEA-1
X-Mimecast-MFC-AGG-ID: 8fU2dCNTNXivZyMIZuKiEA_1771991435
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-358e425c261so1450711a91.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991435; x=1772596235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NiDP313hLYqjOYRS0lxOjLmlSH8sKARSr3ovVB1pph4=;
 b=WlYMig3m8GsQJMRN8yPHAMoI7Bp1EGakg1r2gJMtsTU/3gLpZaEPHAM6rzvU2cKhaV
 Y7/8pmDx4TIWpQdZjqV17/r9YPSgzr7mEDIOe7BoIxFZdLqwZaRysRXpsg2Ma9v45yUD
 GoznJRMgS7y+qLodhfPvn8qA1PgGwSsx0ZZtjHmTN+KW7tMFgVV5R2wSAWsAzp6UIQqy
 bnz5CUwFJ78a2x4qc4AtBGhNNpLgVUW/GHqbbTWyVGG0G5NljFrare5ta4mMZdyGJGuE
 kDOavCvLINxayZDAarhLpnoWnrFy1G0UlPq+xGQXWbEGj1s7F1MSk1AwLwf+aNAAu5Kc
 MWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991435; x=1772596235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NiDP313hLYqjOYRS0lxOjLmlSH8sKARSr3ovVB1pph4=;
 b=Xu/q/mDX5QtNefuSzcwMVFH3qdqmCBC9iz5wxywN5jiZ6qf/+T7i6TTmVY3KAlYzmi
 454XBFOYAxt8TJlx18riNIYJCEV+rISlUps8cKia1MjdjDRyf5Ktw3l89mIRn7k2eOZW
 rzbL/9WZC+8vmind4TsJm0qzMngQNP2zFxantPtD6H5jYEvH4tk+Mjz297kPJlVgAhxy
 3c/iIM9PWB3UwpnosvVnn/sWVuE2Nv9UPkpcWrIz0rvEugL6JopWCsIFjndESqt+5Zl/
 2P3QR1Tf9/eWYvPQwIpNRZOS2ou4K+yrC5hoXNrNO4FEKOtW2f0dOfk/6xB8foZwsKHS
 XPfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFJGe8BpouYiRESHNzFOQsDgW5+XoMXgtWMKz68CzS9rPKRsc1aKKWWDDKm/OcKiRi8pRVW1fncnJA@nongnu.org
X-Gm-Message-State: AOJu0Yy1Tg6vDucY5OI0htACvHWkAWr7XNR/sPc74WJc6thnP42+dCwt
 UJKiRU5H21tv6FJnlCdbEBD8OsGTmun6Lg+XOPDcqQuGsCwHwT/p3maXh/fQ8gZNkwWHhTu2784
 ZxeeAllwcNESuz3IdI6ZBEnrNNjDIK5SI3P1syjWQdWJ+pDJDd+vcxWhM
X-Gm-Gg: ATEYQzxDfOrBTD7+rvDpDya51yql7WoWG/ppqzGllPVLSiw7GqqfFdSyG49S8rgKY4d
 ZSNOsFhtIXBVY/SXCWuOy7DxVOzMehoLiRTGKm6xvx10FcDd7Ma5q21q8YXqM4KBPsz6DeUoATY
 ZIGCzi02O2mREQj8YeLPNM2YYvlOWMZP2n4Bk2z+aAhuHXwap/rai8kwoVIqHUvLVJS0Ic73FbR
 s+HayBOMq0cPJmN0Lg3PZdqXs9mrh4aU7P40Gz1VcVrA9ieetFMRflsuF0uZJoOwz+dUeW3Tdpn
 QKsnVMjDt2P0ekJ3UYWtgN8jaeztnA8ObnDuUgaKgcmEM2FUXrFt7RwNDbLeeN/5Eq0S/wo/kFj
 QxPT3wIDChqoZ4re3+1dmKgwntuU5Ww714p9I5vLTS9Ua7rMLF8M6SM0=
X-Received: by 2002:a17:90b:5783:b0:354:7be4:a250 with SMTP id
 98e67ed59e1d1-358ae800844mr11015524a91.12.1771991435195; 
 Tue, 24 Feb 2026 19:50:35 -0800 (PST)
X-Received: by 2002:a17:90b:5783:b0:354:7be4:a250 with SMTP id
 98e67ed59e1d1-358ae800844mr11015505a91.12.1771991434814; 
 Tue, 24 Feb 2026 19:50:34 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:50:34 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v6 08/35] accel/kvm: notify when KVM VM file fd is about to be
 changed
Date: Wed, 25 Feb 2026 09:19:13 +0530
Message-ID: <20260225035000.385950-9-anisinha@redhat.com>
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
---
 accel/kvm/kvm-all.c  | 9 +++++++++
 include/system/kvm.h | 6 ++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 3b57d2f976..d244156f6f 100644
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
diff --git a/include/system/kvm.h b/include/system/kvm.h
index f11729f432..fbe23608a1 100644
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
-- 
2.42.0


