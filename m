Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0DCC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Tan-0007H7-08; Fri, 04 Sep 2026 09:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TaF-0006YC-Rq
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:59 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2Ta3-0003BT-NQ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:52 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a61910369bso1030001a12.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788527021; x=1789131821; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YXlh9VlubhypZ6+F9JWHhIiwb633noMKaBRlG6n4g/E=;
 b=ihfJoRvx4Pp3Gx7905S5Sj8wgNARKBehyUIf2uErGxWn1TgjabLeNMXbPfMpG4dets
 6DV3PNzsOV9xUCMl2oWSkkNhv9fO4c18YPpCPpkzjctxaHSKRch3VOGy/w3hUL3cqpFe
 ear6RDQFctcbl3ucu6+BWfF7A729k5eNAgtwQUA6vO0FIyFfFL81i59ZKaEHLzLeplqw
 2E9wcy4TECpyE7wZVhXRvMUED7yG/isRX4r8dwy256hhsFx1cH2CbMsVPrfsX4MELLWR
 4LogHkS6E+Dtg80GuC5cexzgNX18OeRsueK+H0iLXM4mHjfMvpo5h58PMIlHaE8DM3Kt
 w5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527021; x=1789131821;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YXlh9VlubhypZ6+F9JWHhIiwb633noMKaBRlG6n4g/E=;
 b=cdghIxCwqKBxqm9mQh8typ15UHlHxLOua2SOZyPUClxVI9dqEX8Oa+pqi8fvYAlXYU
 qaT9UoClWs+kMWScC1Zah1H8gIfUC2ySCseJs6NoEHMlLQDqLOntyO+MCl3KAxMW6wMM
 Da+Nd30mRN5gnMoLmRfBFy+qixBfcbq/ZwQx5aKZ9L8rsHe8Z6Ofctp8TBDFNwPc8Bsy
 wfUBF7RY7DCqookChjhY+i7Yh0EQRtHZQNZYoz35FC3dr4IDM1HlEkLTrIeVaRbBZyWH
 JZBIDkr+D9YYJQx71Zl+EFWPgznhtmzIxCzJ+GAfJjvt5CW5D/2cv4pUDpsINQD8G+kd
 sdbg==
X-Gm-Message-State: AFuF++lMeyoc6hHvCZFMghLjESOsCYsEfKvRylW5iN/IzzeqOtnbZ2+f
 wzcbD8u84/xD7jEOfryFf35iakMAKx+HilltTSQjvZYIN7JiNlyMH7PzprCvR0kxZUo=
X-Gm-Gg: AYBFou3RX50hN5r1S+vU0DxzTAkE3nJGBeO2Awf6A8cR6UYmTj0+8ct1MkATyG4ip1l
 2RrkA+62bxUkrzuvOvOLs24IGk8+C7MB7DD0F/35BCmKhcyzQQeJynlbEVNr0ZL/ilxx8mDXQt2
 g3GdvO60ELZuJJFZNlL8ZYpWqssVOcCPDPNurkHjXm0UvVALXaMYvTTShVOZbeOUy7rbujWQM2K
 9aTAI/D5zS6Fie9HDyLMVOpo1pR1JVMBGu0Avb/9g1IbRbOV0E1/GLPs8Ny3+eBh+E5ys2+Uhzh
 Kmd+mG4DxpCElx+3rwXDABJ/z3Oma/T2VO57BfYpVrtHwDbAQ6AxqMewmrEV85fQPadjssbir9h
 FokwcHSZvLTW44pWc4eajGaIKMTaqexIYGI+jsqL+fsM/cPF5WbH5xrUIHB0kShZilGN/jsyuxV
 KapCXBV/IZ/Ch342phl+nJRrDoCDTs3raocu2fB4nbFKmbvdGYvKMcXvbVfqdP
X-Received: by 2002:a05:6402:d0d:b0:6a6:1c0b:72cd with SMTP id
 4fb4d7f45d1cf-6a7e8d8dcf0mr2584496a12.13.1788527019546; 
 Fri, 04 Sep 2026 06:03:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885b7bfasm6383482f8f.29.2026.09.04.06.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:03:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A6E8D61D53;
 Fri, 04 Sep 2026 13:46:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [PULL 078/105] tests/tcg/ppc64le: user tests
Date: Fri,  4 Sep 2026 13:45:32 +0100
Message-ID: <20260904124604.2207440-79-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-79-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 1d1986f5c1b..f13f0d84792 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -150,6 +150,7 @@ subdir('mips64')
 subdir('mips64el')
 subdir('or1k')
 subdir('ppc64')
+subdir('ppc64le')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/ppc64le/Makefile.target b/tests/tcg/ppc64le/Makefile.target
deleted file mode 100644
index 00a0cdba295..00000000000
--- a/tests/tcg/ppc64le/Makefile.target
+++ /dev/null
@@ -1,7 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# ppc64le specific tweaks
-
-#VPATH += $(SRC_PATH)/tests/tcg/ppc64le
-
-#include $(SRC_PATH)/tests/tcg/ppc64/Makefile.target
diff --git a/tests/tcg/ppc64le/meson.build b/tests/tcg/ppc64le/meson.build
new file mode 100644
index 00000000000..720aa167f23
--- /dev/null
+++ b/tests/tcg/ppc64le/meson.build
@@ -0,0 +1,14 @@
+if 'qemu-ppc64le' in emulators
+  tcg_tests += {
+    'ppc64le-linux-user': {
+      'cc': 'powerpc64le-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'ppc64le',
+      'gdb_arch': 'ppc64le',
+      'qemu': emulators['qemu-ppc64le'],
+      'tests': tcg_tests_ppc64,
+    }
+  }
+endif
-- 
2.47.3


