Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80B0F9936C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrKm-00012a-6T; Thu, 23 Apr 2026 06:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrK6-0000lM-EC
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrK2-0005l9-9z
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+opM6B29NFnMnoIK3LpgwpjJGXql7WfZ6osp4sHpqPE=;
 b=JtuQ/jw4VQhLTwpX9TrDzPLLxQdoP8nRp0HjTG0qO2kf4AL8gyh4P8l0ZtenbxFHrXpPhb
 iFBFAWgwzqSIYfBB+Y5DqPK+esia2IwMn+qC0m0zIOmuWrSsy9oO+Q4KfclyBErwW3UDob
 63TKqr1TNqw+GcK9izznb45qzdemEmw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-B-XholsZPeqehq5eG_4Oww-1; Thu, 23 Apr 2026 06:30:12 -0400
X-MC-Unique: B-XholsZPeqehq5eG_4Oww-1
X-Mimecast-MFC-AGG-ID: B-XholsZPeqehq5eG_4Oww_1776940211
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43d7b7bacddso4602255f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940210; x=1777545010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+opM6B29NFnMnoIK3LpgwpjJGXql7WfZ6osp4sHpqPE=;
 b=DG0s/oUKMH2QU8cCQT90vRSIgKiH0GZbCl392q2rn4mvU6TSCqo54MhZSEOEV1kI11
 j3j5YycTALsj8qho2R/pDyYIKz4XhjsHRAaY2KUZil/iYf+pJbSjHWGm0TBYEoco7tMv
 5QQBbBn2Wg9UTK5yCu3ztyx6ODWCYEoYtfkdLbH+SxlWRH2R/dLKm8/KdJxnD96zPRTJ
 y764+9kiHJKx+hcV8lMXRfs+0AA+85QhqgTPQnpQ8X7XD5imNVS+b81I7EfEfe/HIPAt
 YqxttDyS4jnHlRbTph2HrpnyNscNFMGsiXsuKbdcM8+GiiS0QUbEVVICROYVgPXl4rbI
 cDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940210; x=1777545010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+opM6B29NFnMnoIK3LpgwpjJGXql7WfZ6osp4sHpqPE=;
 b=MqwPakOYmpmOW9Hdl4T5BhmbxSjvG3LZwc5BlvY3GzEHN0z/GCRiJk+dNc4M6lBVsy
 n1UNNSdLzq9X7GIg6n/Xl7vTsOAY06yifqjiqQLC9/ILGcGicTNkM6NvhoLOKtjk016G
 2H9SJn/sPYVHpHUnpk7A9Yk5Kxu80tutCAi8ACGlGrzy2ee6MXXzfMEDI1jRiZcphc2v
 moJJQrmbWz4DcuaDufNLLx3MvzaUeqCkjrTn99/SApmrWneXbV0Zmx3O2SfVfXE7vgeo
 aUU4nTE9fwkrKgTiHW31G5aIZqH1lWkl494gYWUgF1/PjoB57zsmZGQMLnhGJipMtxiN
 J0vg==
X-Gm-Message-State: AOJu0Yw97tfSwhtspo5uHS0MoKNwhRNJA4Y+j8XDPjvcZGU0g1ZZDqaQ
 yPxFakV7SR7talIDL9AE+6NMxRgDofmHfEpzsUwTD+iKJ+ijb2r7sr9zQOTgyJ0BZuMqN5TObzn
 gIYoba6ZcFp7j7AUi71XJkvgt5eWqsbhohWRVvMGPTY+3xcaIchGgfXyFuuSwOSfdpNq1w8+hWf
 ZshmWhQrOiLf1oGrrk3pWU9vM4ZmFMkJiQv1ucX3Nc
X-Gm-Gg: AeBDiesO+B4GPPZd0DOyz7Awz09Q5b97iiK+dLADjS2OiVoMV4UmwO0VQrZkUwGEA+D
 gvPkSiAQ7jbzAhvMGTPvaI4sEh3HagW0164ff1tnsJhcVek1GYAxUylPg1zizv3bH20g/SeLRK4
 CsDfmzINBlPe4XsdE0e3SGt/kcxBK4xX98gPtBwEGFAxTMS5riFaAtTyUYS86K56OCr74visfQC
 fx1FzgG5PhcdmZEzjdre2mq4egb5wp+zwdqcAjWExJAvR3Waquwdp9T6DylABFzHEEbX/5Ct4j4
 ta5DEWNwTF/bLGY+0F01/GvJGJ6tW29sak4f4u0s9hyH65QiYAm3QyZfiZeuDoue/WYzbRWiRHc
 M4EYUJD5eplE5m6Vr1WyiXtUjYoFIRbmcUJua3SW3/rFenBI3tpQbubCBrRtttxufl8pvmdA5DJ
 mJHssRebRrORzleUBVZMGc/uLkhe8zYZ/+/tc=
X-Received: by 2002:a05:6000:2087:b0:43d:6787:9933 with SMTP id
 ffacd0b85a97d-43fe3dcae81mr41832464f8f.13.1776940210254; 
 Thu, 23 Apr 2026 03:30:10 -0700 (PDT)
X-Received: by 2002:a05:6000:2087:b0:43d:6787:9933 with SMTP id
 ffacd0b85a97d-43fe3dcae81mr41832379f8f.13.1776940209573; 
 Thu, 23 Apr 2026 03:30:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb135asm56685330f8f.6.2026.04.23.03.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:30:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>
Subject: [PULL 16/25] storage-daemon: use same link arguments as other tools
Date: Thu, 23 Apr 2026 12:29:13 +0200
Message-ID: <20260423102922.443639-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20260327134401.270186-15-kkostiuk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                |  8 ++++----
 storage-daemon/meson.build | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/meson.build b/meson.build
index 457491c34e2..09cdd317699 100644
--- a/meson.build
+++ b/meson.build
@@ -4505,15 +4505,15 @@ if xkbcommon.found()
 endif
 
 if have_tools
-  link_args = enable_modules ? ['@block.syms'] : []
+  tools_link_args = enable_modules ? ['@block.syms'] : []
   qemu_img = executable('qemu-img', [files('qemu-img.c'), hxdep],
-             link_args: link_args, link_depends: block_syms,
+             link_args: tools_link_args, link_depends: block_syms,
              dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
   qemu_io = executable('qemu-io', files('qemu-io.c'),
-             link_args: link_args, link_depends: block_syms,
+             link_args: tools_link_args, link_depends: block_syms,
              dependencies: [block, qemuutil], install: true)
   qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
-               link_args: link_args, link_depends: block_syms,
+               link_args: tools_link_args, link_depends: block_syms,
                dependencies: [blockdev, qemuutil, selinux],
                install: true)
 
diff --git a/storage-daemon/meson.build b/storage-daemon/meson.build
index 5e61a9d1bdf..fc088cbea7f 100644
--- a/storage-daemon/meson.build
+++ b/storage-daemon/meson.build
@@ -1,14 +1,14 @@
+assert(have_tools)
+
 qsd_ss = ss.source_set()
 qsd_ss.add(files('qemu-storage-daemon.c'))
 qsd_ss.add(blockdev, chardev, qmp, qom, qemuutil)
 
 subdir('qapi')
 
-if have_tools
-  qsd_ss = qsd_ss.apply({})
-  qsd = executable('qemu-storage-daemon',
-                   qsd_ss.sources(),
-                   link_args: '@block.syms', link_depends: block_syms,
-                   dependencies: qsd_ss.dependencies(),
-                   install: true)
-endif
+qsd_ss = qsd_ss.apply({})
+qsd = executable('qemu-storage-daemon',
+                 qsd_ss.sources(),
+                 link_args: tools_link_args, link_depends: block_syms,
+                 dependencies: qsd_ss.dependencies(),
+                 install: true)
-- 
2.53.0


