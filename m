Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6683D2447E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 18:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRDqq-0002kH-RI; Thu, 04 Dec 2025 13:14:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vRDqn-0002jr-FW
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:14:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vRDql-0008E5-K2
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764872082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jkqwtBez6ruMhapFvtBLLST/9OLLA0Ok8S5sc7t4FZ8=;
 b=DrtpN4EwMux1mTkZPn4N0K0Qg7waqScAIS6RZbQIMpqWGrcU9WbywAsz8bUPrXldh03vsv
 HKYWoCdIibk2LYvuKPo5PigJtGs9aqsrouR1D2BNVXw5q7I+kV+GB/t9jT00i1u+m58lj+
 86UsMtPVqJLOUZAdc41ZANKzBVBW3sA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-Babpu4krPa-qRdYRcgjhFQ-1; Thu, 04 Dec 2025 13:14:41 -0500
X-MC-Unique: Babpu4krPa-qRdYRcgjhFQ-1
X-Mimecast-MFC-AGG-ID: Babpu4krPa-qRdYRcgjhFQ_1764872080
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4776079ada3so15504665e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 10:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764872079; x=1765476879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=jkqwtBez6ruMhapFvtBLLST/9OLLA0Ok8S5sc7t4FZ8=;
 b=d6k5BZTyH8c18rP+337ukqIcRpVSPfXDhQ28y2o/gYYou8Z1QAD7ewS6hzkUZeIUvd
 vSCSL/LWwTsjyZY9JS06ZUPOQPzbG4hNCOxO+0Z35iR7eI7NcAaVg2hys7QzZQG5PYSb
 n+ok2sDYxo+rfvVM6VAt6RQavIcTigM5DrduMX87Mc4fv6ToxQK/52AeNWcwGsXbST+b
 oc3ASpAfOXyN2JNIxZ3rROzaykwAb9VOCgzVS9FFhbASFWRQKqr9ZXzpZNAZiQl4hwwz
 yu8t4s1Y1jt25E1jEFeg4vHUf0t9jLYbC8Rs9sJBqXMyJRmKtuiecagc9enz2ZHimLho
 Iqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764872079; x=1765476879;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jkqwtBez6ruMhapFvtBLLST/9OLLA0Ok8S5sc7t4FZ8=;
 b=jzIYmSigwhvspQEy2ekavqlLsp0pGKHw769yUN/D7xB6CoxHXtbT6YXEvumo7CgxrI
 nNzXVg6Z/f+NuaMfttoxvX6blgb2NkPiUajzz65WnyowCRwcTkPtOk8Jm66sI2k9RX1a
 aToTtFQ4NVm4wG1aZpDOVE81jryHiV8RCvI3dIXAH5CxRaJ/HC+3Pljp3FH3gJ6Sajsg
 6MMa5zWkINyd7F/xtRpDonknEZw2H7/JS4sXC2M1n2/fC5aQDD1zUnk5OfRxfdv0bCqg
 Orspfriu/GOr43k/HDHi+uzeEvW/1N16c+Mr9+L5E9KMkM2dFuac3FdjTGn8Xo1xZhyc
 G5eQ==
X-Gm-Message-State: AOJu0Yz+1GPkhsh/AmwGjm09CEA+uKsCokdOl03teW5sCU+hEn0xEsn0
 VSczdldZ/gapuRcQj+gGCu1zJupe0XpZ0mubstqlPFVenWa3HR0t7ZMOMFxeVBb7dtGsTcq2KZb
 bFA+luoyAah13p+7RyvzIHxCcLKRpEHKaugzX05XFImkTC8eSpYpsUp/3BtAcPsqNpX30WIzykm
 gNGHcBxGWcaEOKhOveuViO+r2FiLptz/Zq+W8F3lAH
X-Gm-Gg: ASbGnctC20jgn+LhTjjFlCEQcyj7T2lH8K2C80pjIYcnXeas9F3DPO4MNOggn7oZlYp
 HwYlmhMnW04NI3IXXMnTVHmpIrLhmqsFDb4RZTaFkIBuVqhMvKDfMpZnDz0U8WBCeKe8J7ZRrBd
 ttJHvUyMH6LreGckf5CrUm9X6gCvAvceBGj48p97TdQus5UEuh5JO4DNEshHOurShXZDKbRrd/2
 ZsKOWmo/6WGfUOJCm2hzVCIgaTDy9rmHRe1bG2+6SgDcBiehT7DzD/WRlscTK6rzcFeBfn431oy
 TVTZhnAl5ODEXnSPFS94wiz2xGBZG9D2WWtkfeM1gebuhCjqBVskhErO5DHdCa4lSTO7wikA51W
 ceoGRjUxw4DweB+Hfg2VIxqcePZPb2EqhGq34QldeU01TUwCQeG3ByAkKEEEfIRYFfufG67pbRG
 W//fMCbciJ0aA=
X-Received: by 2002:a05:600c:a07:b0:471:14b1:da13 with SMTP id
 5b1f17b1804b1-4792f25d292mr40248385e9.14.1764872079467; 
 Thu, 04 Dec 2025 10:14:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH41vzgno5NfWNaWUXTgMvtBwbxojmbXy1bkSrZym7IlwD8YRQ4GqupKfIbeVfqqQPV4JFBhg==
X-Received: by 2002:a05:600c:a07:b0:471:14b1:da13 with SMTP id
 5b1f17b1804b1-4792f25d292mr40247905e9.14.1764872078826; 
 Thu, 04 Dec 2025 10:14:38 -0800 (PST)
Received: from [192.168.1.84] ([93.56.161.42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792afd47b3sm42714625e9.0.2025.12.04.10.14.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 10:14:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] build: do not include @block.syms/@qemu.sys with modules
 disabled
Date: Thu,  4 Dec 2025 19:14:37 +0100
Message-ID: <20251204181437.40380-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
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

Including specific symbols used by modules is not necessary for
monolithic executables.  This avoids a failure where emcc does not
support @file syntax inside a response file---which in turn breaks
the WebAssembly build if the command line is long enough that meson
decides to use a response file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index e6a11cefdb7..02738c9765f 100644
--- a/meson.build
+++ b/meson.build
@@ -4270,7 +4270,7 @@ foreach target : target_dirs
 
     c_args += ['-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)]
     arch_srcs += config_devices_h[target]
-    link_args += ['@block.syms', '@qemu.syms']
+    link_args += enable_modules ? ['@block.syms', '@qemu.syms'] : []
   else
     abi = config_target['TARGET_ABI_DIR']
     target_type='user'
@@ -4499,14 +4499,15 @@ if xkbcommon.found()
 endif
 
 if have_tools
+  link_args = enable_modules ? ['@block.syms'] : []
   qemu_img = executable('qemu-img', [files('qemu-img.c'), hxdep],
-             link_args: '@block.syms', link_depends: block_syms,
+             link_args: link_args, link_depends: block_syms,
              dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
   qemu_io = executable('qemu-io', files('qemu-io.c'),
-             link_args: '@block.syms', link_depends: block_syms,
+             link_args: link_args, link_depends: block_syms,
              dependencies: [block, qemuutil], install: true)
   qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
-               link_args: '@block.syms', link_depends: block_syms,
+               link_args: link_args, link_depends: block_syms,
                dependencies: [blockdev, qemuutil, selinux],
                install: true)
 
-- 
2.52.0


