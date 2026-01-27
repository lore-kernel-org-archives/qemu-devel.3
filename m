Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3B3D25932
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbRs-0006mU-QW; Tue, 27 Jan 2026 00:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbRq-0006ly-KD
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbRp-0008MJ-69
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdNlCVdePrLQZM93WRK6oLwv5KTpdxmb5b92LGcPxUQ=;
 b=TfVDmuFXdpOnjgCrlKEsw3fv7Cm5jBylQ1bKaJqcI5qNrbhZOSuzB1k5kds11bJdDjUJPR
 zJt5bXJHftOiaW+aakMLunEXmaenEZfJBS3+WVAGCvknBvqYl7JhyI5IbPATv6PM4diCOG
 4ZoiSeYX3KYzMfIKgAfQKhSkRMHI8OU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-NQkdlF_YOn-AEa653Y7BlQ-1; Tue, 27 Jan 2026 00:17:02 -0500
X-MC-Unique: NQkdlF_YOn-AEa653Y7BlQ-1
X-Mimecast-MFC-AGG-ID: NQkdlF_YOn-AEa653Y7BlQ_1769491021
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c503d6be76fso8484432a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491021; x=1770095821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gdNlCVdePrLQZM93WRK6oLwv5KTpdxmb5b92LGcPxUQ=;
 b=XsKQqycgm/Kp0NlvnExcWi0mcy+vSsratAIwkLBtXYjU78+woVioL29sb9Jb2Eq4Zz
 ey7MVY6tqSvQQej0hPiEYeJcfNEuudMmOzmbj/iAC62ax6xeSrhqR6oWhe4NmaS5786T
 AkZwIH7n92bdS2HhdMZDjN9Awm0e4ijNTTS82c9HmNsoMe3e/lVGt0svpES266LXk9Jg
 fTh4K1mutO00DKmpafpnyafuQ3I+Y4cvegXCs9DM45f7E8MgRGw7AaX0vY1sVOJpwisc
 YOLpIzAA7zmBdRU0SgzTmvlfh4Myw4W0is/wb6ihBc1Uq/xqkYoTnALLCK1i9cforHD0
 5bRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491021; x=1770095821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gdNlCVdePrLQZM93WRK6oLwv5KTpdxmb5b92LGcPxUQ=;
 b=Ss8to84QkCmsNtkOKs8xKdZceUBBVt6XF9nbtKgl0zM9VeTw9Fdo5UoZPEDrH+/Ba6
 YVxK05V5xO2Lz3ubsMX7LgANEsath0RhOgfy6mjFxhT0OQtYtSjcAcsAgVy+atspFfk+
 zgfxjljaJrOXcXRCnTla735rfKFbV4fk68H3lIcGw4uUzLtlmhG3EPakZezIWqBIn1fi
 Dh4cEkjdZuizp87h5WvTpjWK2lN7vC40pBq+LrOt4qbeNFu2XMNjQfj96E9arEIxN6/D
 E8QN661q5ELnnuPwadEROxOgzqK0VzoguuM7CuIsaVCkh/tAnfDVzEK4d+owSCmrmqYB
 yxVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbEJRsHlehjwgXsEXbLvIoBhapQk3jKZulmGHjeiDfPgMGpl+F0oFnIGwmch5nx+LelICcr16G1SlQ@nongnu.org
X-Gm-Message-State: AOJu0YzaeYgbUHwxCHbtYC7xPMOifgo78PAwfQqhk47p5yTYityWBFs5
 gZnxUwDe8MGTXUVljFmd3t/Co4m+Ale+1Ff1M7SUbyNwrlJx3UyeyH1GSXDvfWZhUNwCc0cskwc
 6aXOgzD7OK+JoY6+dqOfxNNseIlOZV1+ijnN9sLfjkCbl27MrO2308nZQ
X-Gm-Gg: AZuq6aImnXfZu4g4ThyQZ+lQKDU+gzTqavQY1clvMtnNi58qBmJrP2+gsMDGj+HOF/Z
 ftXBoK0l7VBfSVEWG20nEWmPmUekr1YsCHYa4Mn2RyIcAQV/GJ6DKtFVr9WxnihuPV97lZOEFCj
 kdaTImmhIpc9RGQtCII5WRIPls9FKmmX4el7KWgMFmwSqUDLnjc34Y/6bDTJMhDzRCsaTXeTpgd
 FiWSxVEwrCOUbkRPeawH23vTTOGUArHNzBUVVatmc8vGsS9aeNZnPe+ZwOypQNlf4V54M9aLsJ1
 hzqZ3TEfh8tNReMyv22n61c+aNLFnmSqOuf8oNXSj2+KIAiqRJGDDm3SZndlq80H86x4Dq66fC0
 Lxwrdyp9b+SQtDOXU+xyXliI025fCmSVGQl7STz2tnw==
X-Received: by 2002:a05:6a21:118:b0:38b:ebaa:c167 with SMTP id
 adf61e73a8af0-38ec629e677mr543685637.20.1769491021025; 
 Mon, 26 Jan 2026 21:17:01 -0800 (PST)
X-Received: by 2002:a05:6a21:118:b0:38b:ebaa:c167 with SMTP id
 adf61e73a8af0-38ec629e677mr543656637.20.1769491020586; 
 Mon, 26 Jan 2026 21:17:00 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:17:00 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 08/33] accel/kvm: notify when KVM VM file fd is about to be
 changed
Date: Tue, 27 Jan 2026 10:45:36 +0530
Message-ID: <20260127051612.219475-9-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
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
index 06d72111e2..538a4cc731 100644
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
index 6ab37fd440..a17cd368ca 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -570,12 +570,14 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);
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


