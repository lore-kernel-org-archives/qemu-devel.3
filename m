Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDBDD1A443
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 11:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0IpK-00026b-FR; Mon, 14 Oct 2024 07:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0IpH-00026B-GG
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:01:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0IpE-0007kF-WE
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728903680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=m9CyeO3qkuJqO/FP22B4AY0ImK8u2K1VZSSqjOde2/o=;
 b=GyTJtyZnzbAtE7seWjLWy2WgX3fTCF5IGos7VPuz+pxsc8IO8zjibgaUwJp82PVUBByAcB
 pDTrxM8KJKToZ6e3aV28m7bly61T6cSDGQpR8XYBkh5tzX7FsMvjJ+Pdaup3FQGs+K0FUM
 ktAGv4bnrXpZd3G70drAJrzyc5g0ow4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-OjRHkKUEMVGvesnJHRl7jg-1; Mon, 14 Oct 2024 07:01:19 -0400
X-MC-Unique: OjRHkKUEMVGvesnJHRl7jg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a9a1828916fso59199766b.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 04:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728903677; x=1729508477;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m9CyeO3qkuJqO/FP22B4AY0ImK8u2K1VZSSqjOde2/o=;
 b=AVlQIs//Yges4jEhjdIDHiMnlYMyUuXbexNI038IC9LWyndTRKTSljCLIs8S8jr6rc
 kZy5y99ygYv536LaDhsyNngtB7EDOM2B4Smkm7dPkQK+NsrOkRMH5clYm2UNUU1lJFkK
 WbH2XBKObtJLCVVQ5+9Ok77+FTyF3y3XKmM6UpGLqit8S0FuqKp1Ze/CtsnheQM+b2Be
 Gg2+DhUWAnN4KZIiq3SzCZzArxOsjwHexo0P31KrI2Dq/ah7U777w0scjbBmI+3NVNMS
 WMtwBG7H4JoxZA1aTrzGscurtYjWChIVnX7CkxbbUZFvufhsRkdt1GoJF5yAkgcqxWjf
 xAkA==
X-Gm-Message-State: AOJu0YzHUC3IJ8nh76oO2PTh44xzRO41qWRBJpF61e5Rm6Yg4ko25XhE
 Qf5EbvE3zoTp5FleTd7zH/ocOIfl4N/qfJEtGOijkjFhFDKt6JvqNO64j5SDp4Ektp5eJDbO2kc
 SXbIXdsJJN2J4Mle5Y036aJqdzcu4DDWUqwMmXPczzAh1MmR8Qm7AcRk4Cw/dE/yPJZK+Isb6Lb
 +9gMdn8v38zWTl+/ZIFS7U7A++zUmIrD6pA+/Ac24=
X-Received: by 2002:a17:907:7f93:b0:a9a:170d:67b2 with SMTP id
 a640c23a62f3a-a9a170d6871mr153102166b.29.1728903677217; 
 Mon, 14 Oct 2024 04:01:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSVVipBuQSp2OfADYWs6zDGfsv4Zjk1ZVm7jIpIkmenUaVRhnZzF07PAFC3+yVwN6yNybImw==
X-Received: by 2002:a17:907:7f93:b0:a9a:170d:67b2 with SMTP id
 a640c23a62f3a-a9a170d6871mr153097266b.29.1728903676625; 
 Mon, 14 Oct 2024 04:01:16 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a0d3e49a5sm150238866b.101.2024.10.14.04.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 04:01:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] configure,
 meson: synchronize defaults for configure and Meson Rust options
Date: Mon, 14 Oct 2024 13:01:13 +0200
Message-ID: <20241014110113.173946-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If the defaults for --enable-rust ($rust in configure) and Meson's rust
option are out of sync, incremental builds will pick Meson's default.

This happens because, on an incremental build, configure does not run
Meson, Make does instead.  Meson then gets the command line options
from either coredata.dat (which has everything cached in Python's pickle
format) or cmd_line.txt (slow path when Meson version is upgraded), but
neither knows about the rust option, and the meson_options.txt default
is used.

This will cause have_rust to be true if rustc is available; and the build
to fail because configure did not put a RUST_TARGET_TRIPLE in config-host.mak.

When in the Rust pull request I changed the $rust default from auto
to disabled, I should have made the same change to meson_options.txt;
do it now.

Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure         | 2 +-
 meson_options.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 3e38a91616a..8a9a4153310 100755
--- a/configure
+++ b/configure
@@ -1987,7 +1987,7 @@ if test "$skip_meson" = no; then
   fi
 
   # QEMU options
-  test "$rust" != "auto" && meson_option_add "-Drust=$rust"
+  test "$rust" != "disabled" && meson_option_add "-Drust=$rust"
   test "$cfi" != false && meson_option_add "-Dcfi=$cfi" "-Db_lto=$cfi"
   test "$docs" != auto && meson_option_add "-Ddocs=$docs"
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
diff --git a/meson_options.txt b/meson_options.txt
index 2211f291b2d..fc6d5526d58 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -372,5 +372,5 @@ option('hexagon_idef_parser', type : 'boolean', value : true,
 option('x86_version', type : 'combo', choices : ['0', '1', '2', '3', '4'], value: '1',
        description: 'tweak required x86_64 architecture version beyond compiler default')
 
-option('rust', type: 'feature', value: 'auto',
+option('rust', type: 'feature', value: 'disabled',
        description: 'Rust support')
-- 
2.46.2


