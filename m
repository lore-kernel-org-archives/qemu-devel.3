Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99094C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TaP-0006cc-Gd; Fri, 04 Sep 2026 09:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZq-0006Nd-Qx
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZo-00034P-8O
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:30 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49557167508so11253725e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788527007; x=1789131807; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZV80QN3nIf03s825p734t5vAX2P3pOVwItQJeV7bCYU=;
 b=mqh+nsE0ubShomlmvc5sDd6KKqm2cJ85esm6p2bAuMBgt9+WrZerCKpMx0AwJAletR
 buKFG4IJQ/FgSpKMluBtXNn4qDkpQfuVBPuPBTa5fkXmCWI0+tJDE/titOTPVumAPYw9
 QIN9Yi/usLYUNFt875+6pu82Vjdx0XGUXy/ZPoB438bFSWcltYj57wk50GDQceHArvUf
 YFeftdruwKHeGDzGqhuFduJ9NlksS949LUnOwUnQ8lizSII60loz7reYxyrfM2Ohx/SJ
 dEPzC4c4fAZKQZn4oFgRn7GuQ7l3rmmDVyVX6PVU0omZIctMNm86Ccs/QyYuRzvfJ0Qu
 lE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527007; x=1789131807;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZV80QN3nIf03s825p734t5vAX2P3pOVwItQJeV7bCYU=;
 b=FHJxEtLqSm0A/phFJBemFwhvAs3hXc67nEUoGL42QHbCr6J45ycvDG+YH++Mfp0nU+
 g09BZD2CbqJ5czX2j5wmB7RKfUPaApGFOo36zcmLndRemlkDdTiGLB2EUTXWVScptQOZ
 sQsyIPjjEHLs5KTxP77sGL7L0Dkhkys31dWfm5rrRkBJrb1MsJ500THS4hAZq9i9Pvh4
 kdfTQn3Z6rpqaEW4L5+XVAqnQALagZ8isCsN/dPuuSHxBAppGgEES1mDd4CjXRh1rX2q
 MutcgsSsXea40UJ+/qOD0AsUZhW1k57XSlX2YfdHCKYQRCykGhHq6kcGkx7csX3x38BQ
 W96Q==
X-Gm-Message-State: AFuF++m4QXdqZHdYDmx5DUF0Fx2EpFAdDALFdpLAq1vqSdoUVXpFGh8q
 lvoNZ5IH0XZ94MoqClImJjm06SXEm8NFKRSD9sDJGfglXeMKxu9gsE10pi985N3b9NQ=
X-Gm-Gg: AYBFou2awzl4VLzsh+nSOag7hIpDV4Kr5AoWcJ/00jzAOnbN2x7Dj8K1qV2v1FMdUm4
 tiQe1VDsuNfbY5NYFp3ZoqXmTMp9bIjYrIDGGrvHntlfbahJ3qtuxX02z2p4W7JoRiAvAF/xXXy
 ZPAPImLTRR1tsQQcY+hCTcirXkaGtmyXqdbyb6Tkmz+rYCqSgjeRFEzY+9BOrSk6yitBH4J9Q3u
 QCsMPcLUqbhiVdr8E6f/PNfCtyYNpCAW233pq3/uMaBuBDcWjQLch8nA6/xH5Tju9z7zrjiUrwL
 a+BXlXzTCaAErClkXlZqIfU1vFs/bvDqCmN6thnYOLNzwagcSiE6ye5hT6vsxzsk/MIPwqBDUT5
 im9j5jqVt+jrB83OINBikkKPpnQLbCVPLHTk9jk50H7CDEqX3OqwbxjMt83ieCvXci9NIlQDODX
 KKIBLoicf3bwyWoHMIw5sjSrHM5tStHKPX9ehGkGgXeGhSUmgHgEAPFyaL0qVM
X-Received: by 2002:a05:600d:8490:20b0:49c:f89b:f82 with SMTP id
 5b1f17b1804b1-49cf89b1bc2mr78563625e9.12.1788527005595; 
 Fri, 04 Sep 2026 06:03:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce551bf7asm129287235e9.2.2026.09.04.06.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:03:23 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 832D661CFA;
 Fri, 04 Sep 2026 13:46:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PULL 067/105] tests/tcg/mips64el: user tests
Date: Fri,  4 Sep 2026 13:45:21 +0100
Message-ID: <20260904124604.2207440-68-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-68-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 0102e74e8a7..7aca685078f 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -147,6 +147,7 @@ subdir('loongarch64')
 subdir('m68k')
 subdir('mips')
 subdir('mips64')
+subdir('mips64el')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/mips64el/Makefile.target b/tests/tcg/mips64el/Makefile.target
deleted file mode 100644
index 78c722a583d..00000000000
--- a/tests/tcg/mips64el/Makefile.target
+++ /dev/null
@@ -1,8 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# SPDX-License-Identifier: GPL-2.0-or-later
-#
-# MIPS64 little-endian - included from tests/tcg/Makefile.target
-#
-
-#include $(SRC_PATH)/tests/tcg/mips64/Makefile.target
diff --git a/tests/tcg/mips64el/meson.build b/tests/tcg/mips64el/meson.build
new file mode 100644
index 00000000000..f6c0fae7981
--- /dev/null
+++ b/tests/tcg/mips64el/meson.build
@@ -0,0 +1,14 @@
+if 'qemu-mips64el' in emulators
+  tcg_tests += {
+    'mips64el-linux-user': {
+      'cc': 'mips64el-linux-gnuabi64-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'mips64el',
+      'gdb_arch': 'mips64el',
+      'qemu': emulators['qemu-mips64el'],
+      'tests': tcg_tests_mips64,
+    }
+  }
+endif
-- 
2.47.3


