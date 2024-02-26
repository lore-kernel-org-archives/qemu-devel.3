Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3F5C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 19:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1regzV-0007CV-TY; Mon, 26 Feb 2024 14:50:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1regzS-0007CK-Iw
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:50:18 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1regzO-0003bA-O9
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:50:17 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d24a727f78so49520631fa.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 11:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708977011; x=1709581811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CRiAaEWLbPdwH7MCuFZoee4IvGVtzFJe6l3ojpTWHyo=;
 b=gYJvQwa6EEL+XsIDWK4wCsrlobmNGsY/XgWy3uGz2H/seDMNOKThzyREuEW+i8/1dh
 vFKMSVeO2nVRW8kbE6lUh4lzGI13sYmD6R6Ksf9INidoSY2BNvxZEpHvbdZR5lOESkHB
 6ujxfXGV2hkiGVsc0Jio4hJ+wy4iwKnJj8DTsuYquDmnpapKZvDD4Eo5Ddp6OLB4HLNd
 ngwHfsGG1p9kdYaKlm0Nw3Bv9vNXWrRfoC/ielw/TfUG4Ia/htsTyIa76DIKU5qJI7Zb
 5G+1WjypZx7ouNF9fbnKhyL7HUaazwUaKxq377lHL3foFRoaGf/rurVthlmqS9Oz9len
 07/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708977011; x=1709581811;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CRiAaEWLbPdwH7MCuFZoee4IvGVtzFJe6l3ojpTWHyo=;
 b=iJG1YFBM3NU3Mz9z7yQ+maWCsbC4hNeMi/81rHY9ZBOS8ISe/YlVNbqwTCB5xGF6m2
 stcp5+l8+S6BeIMyPK6Yrfrbf1ZkVXjamGrH0Ow3IzKqOyEs5CP0v1ao/shajc78do1b
 g0rFlMYRCWxoXsBNeFdqte2qUApwTFhMvo/FepxZbMt4aSxf1ERQ1b1CDZmDdxge1AHD
 WBRBBgZqMWetX37ppjQ+EZt9pjZShVuLqNZjbIXePgmXzxXoQbwnSmu2g7qBHpdcEvpq
 fbw6u11Y1lyejQuLmI14eRpM4UKsvpgTv6dWov4+o65FaoJpuhZ+ERUhdH+7bEvn+rp7
 BT2g==
X-Gm-Message-State: AOJu0Yzl5AnPpU5hTMGrquQGFO335spFwhcJab6cazAYHn9AZfdmqSWu
 h/fejW2cvVsRgJihvY1bXDGY2QsKe2/UY+DxGQd3kQE+L3CHHpRFrsK+zeQe0bE=
X-Google-Smtp-Source: AGHT+IEmUBPm8ga71sUFG55VNzOIWH5o6FnggFlYmRcRAIX9PMnLvehV0zmW3CwpGFnTsiVcbhoFNg==
X-Received: by 2002:a05:651c:97:b0:2d2:438a:11ec with SMTP id
 23-20020a05651c009700b002d2438a11ecmr5057144ljq.2.1708977010864; 
 Mon, 26 Feb 2024 11:50:10 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d3-20020adffbc3000000b0033dd2c3131fsm5379966wrs.65.2024.02.26.11.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 11:50:10 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 157455F880;
 Mon, 26 Feb 2024 19:50:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [RFC PATCH v2] tests/vm: avoid re-building the VM images all the time
Date: Mon, 26 Feb 2024 19:50:03 +0000
Message-Id: <20240226195003.467135-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The main problem is that "check-venv" is a .PHONY target will always
evaluate and trigger a full re-build of the VM images. While its
tempting to drop it from the dependencies that does introduce a
breakage on freshly configured builds.

Fortunately we do have the otherwise redundant --force flag for the
script which up until now was always on. If we make the usage of
--force conditional on dependencies other than check-venv triggering
the update we can avoid the costly rebuild and still run cleanly on a
fresh checkout.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2118
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/Makefile.include | 2 +-
 tests/vm/basevm.py        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index bf12e0fa3c5..ac56824a87d 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -102,7 +102,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 		$(if $(LOG_CONSOLE),--log-console) \
 		--source-path $(SRC_PATH) \
 		--image "$@" \
-		--force \
+		$(if $(filter-out check-venv, $?), --force) \
 		--build-image $@, \
 		"  VM-IMAGE $*")
 
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index c0d62c08031..f8fd751eb14 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -646,9 +646,9 @@ def main(vmcls, config=None):
         vm = vmcls(args, config=config)
         if args.build_image:
             if os.path.exists(args.image) and not args.force:
-                sys.stderr.writelines(["Image file exists: %s\n" % args.image,
+                sys.stderr.writelines(["Image file exists, skipping build: %s\n" % args.image,
                                       "Use --force option to overwrite\n"])
-                return 1
+                return 0
             return vm.build_image(args.image)
         if args.build_qemu:
             vm.add_source_dir(args.build_qemu)
-- 
2.39.2


