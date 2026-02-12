Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1DAEDF04A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQ9T-0007gW-J4; Thu, 12 Feb 2026 01:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9K-0007ae-Eu
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9J-0005Dl-1E
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+nJSPq641/KU7PW2uyxECihx9MetPiHgqWCX0M+BsoQ=;
 b=Z6OBh5NkH1u8KfS0XdznSciIGvUIGde1X0Io1I46G3mrUzZJxU2hH7lF7szIsXyLY2aAqZ
 9576eFYMs4ayTqnrG5IpzSlKOAFgmcdSKpEGZq9uliaMclclleExTtgOnYwAuFXNkVAQ3V
 lYH8P0vGZvKjreuDtAZDT2m6bgh/1W0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-PLXnubtUPxOf_Zz1lpyTpQ-1; Thu, 12 Feb 2026 01:25:58 -0500
X-MC-Unique: PLXnubtUPxOf_Zz1lpyTpQ-1
X-Mimecast-MFC-AGG-ID: PLXnubtUPxOf_Zz1lpyTpQ_1770877557
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c6dde310601so3630480a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877557; x=1771482357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+nJSPq641/KU7PW2uyxECihx9MetPiHgqWCX0M+BsoQ=;
 b=ppkmw8/sU/Ex71rOKqHkCups+Ll2QPadEmjbVWdX9tsWpajolH4jrgnC+24iZEt/FB
 RR/ixjAf/6yMJUI14fnrsvU+029rpd85uu+1gRZuHSAmHaXTbsFQitpmG0onP9BKnTNU
 R+Ep+sKXXz/iND6QL8/cmgMaBlEoS/fVSekhb2oJqRD3EGZ6IN3q1hhLh0HlxwbBF8mh
 LGRaVsm0bcnd/ZKTBAAa2Uw+NDu85GuCW43WaJ4OmWTRdu3qRsAVWVohQ/4wGqpzsFpc
 9RyIoTRvYyubx4wS8+SLm8W+ZKx/SXUXCNnJs4fPDyc2rYjHi/7pixQqDQ/vTcmAc3Q0
 S+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877557; x=1771482357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+nJSPq641/KU7PW2uyxECihx9MetPiHgqWCX0M+BsoQ=;
 b=SEZUuY9a50R3o2S/24VGVURLDYcchrsylTU//QXzT12ygTjxxk056cMqxGm6aqLkNJ
 iKwoORehpV6SlxUtVcWsakNXRc+E80GvnmODQgvDJLMhHj7Kcru1+Oce+pAlxCUBU0ab
 3SLQAfzUm6AoMw3742AiDsZjSdor7rnjYCqwYB8dA8y8YOneIq+5pyY/HR06o5N2LS3N
 7qY29C06xg5NXF0PfFhsqa6TqvYv1DaHQiZseTeoljX493Dww1mZl4PftBpIO7Rp+JRm
 GKcyaCNQy0hYYo2S//pUBjgfYmdjSHT96K6KkLSLOvxoU+CSyd9JkVrPwobg9G1fY1f9
 miBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmn3KVZO9/AE+PGI0swxI5kTBu1RenuIYvNN0AHUFSXYKsl2cbHX0HBbFz5DlmwExrCn28C2MWiH7S@nongnu.org
X-Gm-Message-State: AOJu0Yz152RIXDKbv35WlB2VuY0jzzNcU2E9mXy/gWF+i7QIdaiiH2Q2
 be6adxN2GF3yKgh049FY6s3sj3aVyEg5DFoUDr2QyxkfFrfTXZgAxFHkwOzjiTmgfSx2gpfJ8Ng
 uSD6vgdDecIal5tMYZ7I1TfJ0O4V42qhoUECyIOr7gy2ooDH3uLV+COBB
X-Gm-Gg: AZuq6aJDYhqgOmMT+6rtz28fvEcWCJWSLQ6Tb7MAhRskpsyYZqyIsyN88JKjrEwdPR4
 tZnHs56D4HbYVyKqqd0Gpk5TqrxgF2xAPq2fYhAo3WSEcMKFIcOdTwXMnrP7vpxhKOknMqpwGVq
 bl40t71MRIne2V8rVhikGgCMphuM52fwEwVsz/Th465uF8Rd3bjYpOlzQYNeMfo9Ob72lMAS12M
 6gABqAXXulXfcruMD6IJuLWKSk58fcWYTDyTXdMYza/IIDCVL+2MBpzqLCcybzXrEbfG4x/AuTe
 5A4AJEIl7nja/lbRxMkNDqTqJB7pEnmiuBcejV5mG4u9n53kR2WDbTA6X/om64Osr7zMyHs+vgH
 VUbn8kCsKkfcUVvIzfBnYlW4Cb9b6CEcgiLt8xcD4nGIBKoGreen5TDY=
X-Received: by 2002:a05:6a20:6a28:b0:393:7575:a8d6 with SMTP id
 adf61e73a8af0-39448bae9femr2036472637.71.1770877557395; 
 Wed, 11 Feb 2026 22:25:57 -0800 (PST)
X-Received: by 2002:a05:6a20:6a28:b0:393:7575:a8d6 with SMTP id
 adf61e73a8af0-39448bae9femr2036441637.71.1770877556999; 
 Wed, 11 Feb 2026 22:25:56 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:25:56 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 07/31] accel/kvm: notify when KVM VM file fd is about to be
 changed
Date: Thu, 12 Feb 2026 11:54:51 +0530
Message-ID: <20260212062522.99565-8-anisinha@redhat.com>
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
index 30d6295f53..a6ff16a037 100644
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


