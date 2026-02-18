Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90FBE9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfxm-0003GJ-0G; Wed, 18 Feb 2026 06:43:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxf-0003Cq-7r
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxZ-0007p9-U9
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771414990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JrYkaI8zWucrcUWEd6p2dGFw5Tm5nOCoxE1XNnZbb4k=;
 b=PM7iPAvq3DG/KQx595EK1neyb0OGwWUlz9Fl/ZFRLGfHrRALyo31jSHam+HvGi0xAcGoEx
 gSXTrFaznBsEOtFSbp/NG2S+/G7+NFMDz0WfLI6QnImBvSPp8HIOm9qcoZ5rI2HSCBGB3i
 +qUw/vzMUXsZTQCKwhdgilPGxfRzSk0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-3hdTVLgxPOCTqnk0q6VXlA-1; Wed, 18 Feb 2026 06:43:09 -0500
X-MC-Unique: 3hdTVLgxPOCTqnk0q6VXlA-1
X-Mimecast-MFC-AGG-ID: 3hdTVLgxPOCTqnk0q6VXlA_1771414988
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2a7a98ba326so11880665ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771414988; x=1772019788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JrYkaI8zWucrcUWEd6p2dGFw5Tm5nOCoxE1XNnZbb4k=;
 b=R7oR5AzFEwuX5lQwdzH5fAes3EDkzcrIOIok8U6uQGrIXvo+Yg/QfybJ06g5BKnKZP
 hskY/iQRAvfCiGUejcr6+D0V82s+OTDqZZKEuUH0x9Az5oetNrlVCOuG9TI9JBOIp0sP
 xZYRiWwwg7peKSAo1eKz+BjWP98uOEazyXv6FabxIoN+IwxNMrfezd5xQcL4uPokXh6g
 Tj4j0tz8RO8Qa5aEqa4J19wtuVkM2VaT3VIV/C4QEBtKZlTrW2eXKy9CrLh06+4ShI24
 B6yPQshp5r4VU4feSEJHTVTzDCkuBU1NG3sso6EHdNjP4pCb1lPfxEeXshP6H0lQykAY
 HO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771414988; x=1772019788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JrYkaI8zWucrcUWEd6p2dGFw5Tm5nOCoxE1XNnZbb4k=;
 b=IK8eEJupfbtpC6fOfa+V6fzKtXNprsvcEe+kHWpJeFQXrPfs8bbJzTLTeMqKyf2UGL
 UC8OTjJaGRprAZrsnSEHVd/ft4bw5LuKm/2cmyBv63yWKfs3D8+IwHu22VneoWhgy040
 s73TPebQFxD9z+Ondga1IYsaB4CT3bPYtGYPuCAbazmzkczIEWpz+02K9AvXONz9zK8v
 OMWh2/bq58XCfIvqSFuqcsjam1UD1+R3ZY/7jlip1vz/bw8X6oyl3fj49t51n5mnrVmG
 Q+FtqekNHPT5XJly/AlhMQFzJXnI0cT5Q+m26oONIvKtVcISCffs9mLqd3EhQljHISKb
 s77w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo0yEI5guzUaRfOXUPFpVMNCPoLimAxgaynFMfacRtSEjmUr3kKXT9bn6Y0GCMsifCr55Jl7e+ZRjF@nongnu.org
X-Gm-Message-State: AOJu0YyWOEXbDAR6kCj7u8EeYpnl3uA8SlqmgrgvvDsZMQLgS1KiLRdZ
 hCxnLLBi0wBQcPot7VfgSQln5tMG+u4AduxE44Ri370SrL0wZXq6UgJrSKy8WMX1Lvi+k4ervYy
 fSPtLUNVh5Vq1YZQaZHiv63tsdqI0Eu07KnUis2gygLkFmRnBJ47m4jec
X-Gm-Gg: AZuq6aJUpKbz76f30oP0r9ohPzDax2NBbVyJNErVfc+u8z3gVh+Bmkf/3FdlFOprV8V
 uCds9T4D1HMqGXu1Y8BNGdxWHVITkoqIDdtbs1D5Xqq7AJsIW/8/zGehmuqp+mRr8FnCSLhexxm
 dLjcXelSJ5iUEEKLV4q+iBa3vDnSjHpyYqIqDIs4jYoCQKFN4HJPY8GesX2gbJPsizFjQJ/aCG8
 EtZjV3r2/v0xNjaSUFLdl2NFHDLPQe7Sumx4VP38IcnKmvJUYFz+jrjbZEc/nymbWiD6NL9fwlP
 wY5l5WS4bXSaU6nr3yH7pjCDSjGlYD2MJtP3HwD3lgKH6DNGm+BObMZj2Qsqpa6w+4Mto3S2EP9
 lja2xfg3PL3NQRpprIzIX+Bjj/SeLzpOFOC/Prs9oeaDgBNv3G25t
X-Received: by 2002:a17:903:2f81:b0:2aa:d605:a314 with SMTP id
 d9443c01a7336-2ad50b5a413mr16656375ad.4.1771414987867; 
 Wed, 18 Feb 2026 03:43:07 -0800 (PST)
X-Received: by 2002:a17:903:2f81:b0:2aa:d605:a314 with SMTP id
 d9443c01a7336-2ad50b5a413mr16656135ad.4.1771414987404; 
 Wed, 18 Feb 2026 03:43:07 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:43:07 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 07/34] accel/kvm: notify when KVM VM file fd is about to be
 changed
Date: Wed, 18 Feb 2026 17:12:00 +0530
Message-ID: <20260218114233.266178-8-anisinha@redhat.com>
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
index b8a0685f7a..47589f92e2 100644
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
@@ -2692,6 +2699,8 @@ static int kvm_reset_vmfd(MachineState *ms)
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


