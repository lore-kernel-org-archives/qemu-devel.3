Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8866BE9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfyt-0004LQ-Vu; Wed, 18 Feb 2026 06:44:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyW-0003wP-Ex
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyL-0007vm-Hi
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZjupKNTcRQ4mvrXCw54dQwnzt6+1apWExSeFIvKWxA=;
 b=cJd3QDPI+z2LNGyGGg9SpHt1WQBUeKSqxkuqKLklrYnW2p4t/3I0lcjCM6XMIdANmF6e60
 hhuyf2iFoHJ/5NG9FUeHt9u5VfUU4R3+tjzNXzaQhod7lQ9RzkjQAzEXwqmC+3SOynQwMS
 v3zsip3fFj0CiTRV/Zk9DHw1AOETBrU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-8bIRKhbWONy_pQKH8W0pog-1; Wed, 18 Feb 2026 06:43:59 -0500
X-MC-Unique: 8bIRKhbWONy_pQKH8W0pog-1
X-Mimecast-MFC-AGG-ID: 8bIRKhbWONy_pQKH8W0pog_1771415037
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a75ed2f89dso62619615ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415037; x=1772019837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZjupKNTcRQ4mvrXCw54dQwnzt6+1apWExSeFIvKWxA=;
 b=VtclvY6ku6uV86kbsEpz5BPBcPpvQxvNgHMPVMjDZYp8d3Y1gOzNMxNeIx3BAhjbpe
 11rMVnwWEe5lFXbFDnzzDQxkjlDQ0UBVQ6Zanwx2UpaS+yiA+UfudbFyKCTZchABDPmt
 KEd3ufj516DmK7wl1Er1mkcqEw49K3I6mklvkFj25My11E2EuJX27WIXJN5Wx/yU5rsV
 PPLEY9Rrqlu4dAL+vg6bOlwqp4HJ2hGgrlrZs4tL889VXMGv4BAhIjHUJttZ3xMHA2M0
 n3dG3a81q49dcLZTGUfBFfi22Nii9ffzY56/9k7+bYdH4OBn1NBbcGPEqmczJIt+8JoW
 UqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415037; x=1772019837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UZjupKNTcRQ4mvrXCw54dQwnzt6+1apWExSeFIvKWxA=;
 b=L2fFifnqS/K9vUmAX1gfrTnloOXxOl9dLro1hSzVuDibry0DOAP/yD9ptpgpYDLBbG
 H2DEKBvCtQtaEX8ODA0SUd0voKbAiswnfR82zGnSqEZRtGTgmMLl2+YCACSQscdf1Izt
 7pj/RmIX5KNsnKZCaR3Tncg/tuixQXl6qt8kn+uirpv4APtNgJfIuSzZjonPaLE5V4KN
 zlQhnP/BQq1j+JHYwv0fSe6Ykf2gfDRyT6wVxA088kPg6ILHrWxTYNprPhXGHPyb2WYj
 d4hMPPZn1ecBQy7a3KErQaXcirwunDHuep+bzG8no8pYd/T43Yt6g4wIll+/AI/E3Z5t
 f9lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZFAKGzFL7E539x+5JEezvvG8/iIkf36tDYlTG/VYsINGvbCCnEqcGjI7Tm/FZ9EW31CbeL/Ot+83S@nongnu.org
X-Gm-Message-State: AOJu0YzjaEyw95SMAdyMxGGs3VGk+tjm5ffVYhZ22RLn4awWPxt2cd4r
 LjASVFg7Dt+4/W452fXjQuivHQPIz4awUwAq61fkHitYMrDe7YebEPp5v5pQOewpl0DJVkRPB0R
 vuLONG2UyayEijQvKwcyiLsQVEEuwMW230dfWJntGN2bZ1YrlvlwpFduBxX1Kl/0H
X-Gm-Gg: AZuq6aLBpygQN0XwFP3IieBw0cMjLijoXJZofvRenlYmkw4mkdyOe0JTrxoO4keZZZr
 S66wn1xTud5EreDVq234efqXc8q+uHE2ZaBdbsiVCNjPfNhwtf7zXHwhDVuBVgRe6g17G02VRtU
 bSUpgv8BpDJIYW4YY/HWjQ99viayKh4OJvQ/2cY4sImdpYTmPM1uf8XSVM3hgBzJRwZrCMFN+XD
 v5TcyQy4ftG1ocXgXQNTb+4coDscm6RUzjW4Qzq/VVNAW6oAqCjCdKgeSdFYD4PkQ3agzsvjBlX
 MRn7g5RGcoZ68btEa8hBXwPSTgrmCluaH6lNSDEwLGfkXMyLQsXKpr0TKeeW58qLF2ylCnrG5lJ
 AXQRKjPOa3NrDUkJrLZrVFVTRuwM75Ned1Gdx7u1rH/4wmkWtSUX/
X-Received: by 2002:a17:903:11d0:b0:2a9:4369:940c with SMTP id
 d9443c01a7336-2ad175366bfmr143509085ad.53.1771415037088; 
 Wed, 18 Feb 2026 03:43:57 -0800 (PST)
X-Received: by 2002:a17:903:11d0:b0:2a9:4369:940c with SMTP id
 d9443c01a7336-2ad175366bfmr143508945ad.53.1771415036685; 
 Wed, 18 Feb 2026 03:43:56 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:43:56 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 23/34] kvm/i8254: refactor pit initialization into a helper
Date: Wed, 18 Feb 2026 17:12:16 +0530
Message-ID: <20260218114233.266178-24-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The initialization code will be used again by VM file descriptor change
notifier callback in a subsequent change. So refactor common code into a new
helper function.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/kvm/i8254.c | 68 +++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 81e742f866..255047458a 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -60,6 +60,43 @@ struct KVMPITClass {
     DeviceRealize parent_realize;
 };
 
+static void do_pit_initialize(KVMPITState *s, Error **errp)
+{
+    struct kvm_pit_config config = {
+        .flags = 0,
+    };
+    int ret;
+
+    ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_PIT2, &config);
+    if (ret < 0) {
+        error_setg(errp, "Create kernel PIC irqchip failed: %s",
+                   strerror(-ret));
+        return;
+    }
+    switch (s->lost_tick_policy) {
+    case LOST_TICK_POLICY_DELAY:
+        break; /* enabled by default */
+    case LOST_TICK_POLICY_DISCARD:
+        if (kvm_check_extension(kvm_state, KVM_CAP_REINJECT_CONTROL)) {
+            struct kvm_reinject_control control = { .pit_reinject = 0 };
+
+            ret = kvm_vm_ioctl(kvm_state, KVM_REINJECT_CONTROL, &control);
+            if (ret < 0) {
+                error_setg(errp,
+                           "Can't disable in-kernel PIT reinjection: %s",
+                           strerror(-ret));
+                return;
+            }
+        }
+        break;
+    default:
+        error_setg(errp, "Lost tick policy not supported.");
+        return;
+    }
+
+    return;
+}
+
 static void kvm_pit_update_clock_offset(KVMPITState *s)
 {
     int64_t offset, clock_offset;
@@ -241,42 +278,13 @@ static void kvm_pit_realizefn(DeviceState *dev, Error **errp)
     PITCommonState *pit = PIT_COMMON(dev);
     KVMPITClass *kpc = KVM_PIT_GET_CLASS(dev);
     KVMPITState *s = KVM_PIT(pit);
-    struct kvm_pit_config config = {
-        .flags = 0,
-    };
-    int ret;
 
     if (!kvm_check_extension(kvm_state, KVM_CAP_PIT_STATE2) ||
         !kvm_check_extension(kvm_state, KVM_CAP_PIT2)) {
         error_setg(errp, "In-kernel PIT not available");
     }
 
-    ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_PIT2, &config);
-    if (ret < 0) {
-        error_setg(errp, "Create kernel PIC irqchip failed: %s",
-                   strerror(-ret));
-        return;
-    }
-    switch (s->lost_tick_policy) {
-    case LOST_TICK_POLICY_DELAY:
-        break; /* enabled by default */
-    case LOST_TICK_POLICY_DISCARD:
-        if (kvm_check_extension(kvm_state, KVM_CAP_REINJECT_CONTROL)) {
-            struct kvm_reinject_control control = { .pit_reinject = 0 };
-
-            ret = kvm_vm_ioctl(kvm_state, KVM_REINJECT_CONTROL, &control);
-            if (ret < 0) {
-                error_setg(errp,
-                           "Can't disable in-kernel PIT reinjection: %s",
-                           strerror(-ret));
-                return;
-            }
-        }
-        break;
-    default:
-        error_setg(errp, "Lost tick policy not supported.");
-        return;
-    }
+    do_pit_initialize(s, errp);
 
     memory_region_init_io(&pit->ioports, OBJECT(dev), NULL, NULL, "kvm-pit", 4);
 
-- 
2.42.0


