Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E29E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQva-0006QZ-DJ; Sat, 27 Dec 2025 04:49:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvY-0006J9-Aa
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvW-00072F-Sj
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DPzOYGOdSS2nqdUVmE3Appt8FioAsNxMPjypO5wkIkE=;
 b=RMWhCKRh1Z6VUlrcLCZzO5fUV1AbdoU2yA+yx4y2UmUDoN8dXSL23SDgQzsho2UTg9Z5M8
 zSuUCAPBlAMJ9P9kparXYXDj3efJFDAocEUDEMNIki8w2/alPpmsYYBM6HHpHPhzaCKlAe
 S8d++STp5f9TgVIiKz/O+iJ+SCe1+Lw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-AwhGFw_dPq-GY6yKpSHJNg-1; Sat, 27 Dec 2025 04:49:32 -0500
X-MC-Unique: AwhGFw_dPq-GY6yKpSHJNg-1
X-Mimecast-MFC-AGG-ID: AwhGFw_dPq-GY6yKpSHJNg_1766828972
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430ffa9fccaso6154212f8f.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828971; x=1767433771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DPzOYGOdSS2nqdUVmE3Appt8FioAsNxMPjypO5wkIkE=;
 b=EcVa91GColmydsUuSbcx1YTKCOxY0/dSJfev55Qkqp1McYffhaIlSLHWOTWG8VevC/
 AnZ5dizacZN9RCgDlbGiYa646ILcoYdYqxTe6mMksXuxp3tj+vYEbasDD0TpwmChowXf
 yNBngusC0f71qOfRn6FicL13IM7Inl1kse1EdlZPTnH8IUFaL2lc2kRPWxKp3DAcKR9I
 xfcl7evtBgrBQpA+97gx+Gt+qnTMXBaLCmDPtMF8Dim+XfmWg4+w/sZ5N+ORmi24L/Ja
 JzyA2ELdB/9GH5k8QXmTAr1FKzcEYOJJp+jOu7U4nRTTWlXvxn1947tQfXpOX3dfiiQv
 snKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828971; x=1767433771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DPzOYGOdSS2nqdUVmE3Appt8FioAsNxMPjypO5wkIkE=;
 b=AXgRNbbbZ+qk6UrUG/eosJ3etTod8SxpNfkSEY4u2HkoGnQBBlYkwMHTxaUv4xE+z6
 nJe1Sb3Ptk2S5Pgjb/uXwJIxkk3Topvs5Vr6efaFTi6TC0hMn5T+frh0rC6Nu/jM6ALF
 aShI9hRizAOASHL4a5T+0n3ZrrRjadqvZbu4D41yfnjCybIF9IOVBcXPnKwyD0BhEkw3
 S2bUqNH2o3z1fHmW0p5065+7qqUUtQ9wykpAcP2XVzKjBhJ6yca6ZvVC08yvlFBUNXTN
 2RhSxbhKEePA4HHO8bdhT2r34ueGzoVJBRdmiavK/hllesnm4vQwAbJpwKKBroxU+MpS
 K+Vw==
X-Gm-Message-State: AOJu0YxHDUNQIJGbvEtPHpxvjwZSAn7yzRVNnx4Z1RBq9Or0c4UAd/ug
 8iEbOfR1JmwZMEJ++ARDKzxbYlqQQzhrcF6jdEgeWRnMrmNlJGLp9LPZl3cjpSqB3tJjBqor9Gf
 hV52cEmrVGQDwPPiyxBGWxytSO8Kp+aTfvnfbSJ5kfo75ugKO6+Ja9Kh5E5dSL0UThDid+86I5f
 ik7y7MQzqZn68tj1+FnodBUmQZcgQNJTvr4qsmiHZb
X-Gm-Gg: AY/fxX7UDhi9TG8d2jUpVN1VplSFsCO1QfrdlMGemjEfLpMAcsjyLTTGB5vhcV74vE1
 xMNXj356t9IcvS+xM1tWyD3oo5h39o9om9U8a9gZaOBu1kGNN9fsT/p3C2lj1IIbGZFlXsgVlPb
 3/uXH/9KOOLJfHE1JrZrg3+PAr+8szFtAwMMEYF0iTFZk0ry8WMkbcDs13PxpyeIJaxkCAIpYR1
 9+JJUkN1hURT168nBdmvO/z81i1Aipj50gFAu7oAYMYKTwx+5C2QJYidQggsZKidEslRp8FzjVG
 hb8++E0pAD5dgsk3w0HdeaWcSixU5dJfh0CTIwla0JBmutF+ua+KHDkKyPoSTypelA85HJ3S0x4
 OFckYrB689LVrCTpVpNkM7XhRNXvf03Ycb5mrcBW9p6oRshYmQWQ4nStblL4MR0iQLKpPyDpfqp
 rNV6dt+n+EV3nuO4k=
X-Received: by 2002:a05:6000:2907:b0:432:8504:f67a with SMTP id
 ffacd0b85a97d-4328504f681mr4683017f8f.20.1766828970638; 
 Sat, 27 Dec 2025 01:49:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjk40KXb1wQn8A1xo5TRacyxCwhjiCnpqo3VSKY01UcG7TIWj068rCu672UAkhOwcHtjAYvw==
X-Received: by 2002:a05:6000:2907:b0:432:8504:f67a with SMTP id
 ffacd0b85a97d-4328504f681mr4682990f8f.20.1766828970124; 
 Sat, 27 Dec 2025 01:49:30 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1aee5sm51014785f8f.4.2025.12.27.01.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:49:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 108/153] rust: only link the Rust part of the code into devices
Date: Sat, 27 Dec 2025 10:47:13 +0100
Message-ID: <20251227094759.35658-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Do not include libqemuutil in the device crates for the same
reason as in the previous commit.  Static libraries like qemuutil
are sensitive to their position on the command line and rustc does not
always get it right.

If rustc places the library too early on the command line, the stubs
are included in the final link product, which results in duplicate
symbols.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/meson.build | 18 ++++++++++--------
 rust/hw/timer/hpet/meson.build | 18 +++++++++---------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 33b91f21911..9c0e8290e9a 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -28,20 +28,22 @@ _libpl011_rs = static_library(
   ),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
+  link_with: [
+    _util_rs,
+    _migration_rs,
+    _bql_rs,
+    _qom_rs,
+    _chardev_rs,
+    _system_rs,
+    _hwcore_rs,
+    _trace_rs
+  ],
   dependencies: [
     bilge_rs,
     bilge_impl_rs,
     bits_rs,
     common_rs,
     glib_sys_rs,
-    util_rs,
-    migration_rs,
-    bql_rs,
-    qom_rs,
-    chardev_rs,
-    system_rs,
-    hwcore_rs,
-    trace_rs
   ],
 )
 
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index 9a3dd62caa3..3bb7ce2a6ca 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -3,16 +3,16 @@ _libhpet_rs = static_library(
   files('src/lib.rs'),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
-  dependencies: [
-    common_rs,
-    util_rs,
-    migration_rs,
-    bql_rs,
-    qom_rs,
-    system_rs,
-    hwcore_rs,
-    trace_rs,
+  link_with: [
+    _util_rs,
+    _migration_rs,
+    _bql_rs,
+    _qom_rs,
+    _system_rs,
+    _hwcore_rs,
+    _trace_rs,
   ],
+  dependencies: [common_rs],
 )
 
 rust_devices_ss.add(when: 'CONFIG_X_HPET_RUST', if_true: [declare_dependency(
-- 
2.52.0


