Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F949C54E56
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIYk-0005ns-SY; Wed, 28 Feb 2024 06:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIYi-0005la-Qa
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:57:12 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIYc-0005hf-AL
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:57:12 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33dd2f0a0c4so2337621f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709121423; x=1709726223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ey89Hl01uX5rJaJ7gx3TbpJ+bjSISZiGwEb8QHXuSjE=;
 b=KhBFcJnsRzWa9jYEiZv+G5/UCNmvGJKrqa/bWBIRZPHOOavnshpBVafjJ6AuU4tzMf
 6Q6B2LmJfYPyFfjSKbtRZUyRzH/sOIl+uqgVr2bk/njvrkI5XBS3zWCU0I16uQ7+1lhz
 BU09XBvCPKxOczi+EH+eEogavDHeMlhHMeDWjk3qUmO02hemzNNjJ8G3Xb9Sv8UFSkoU
 TQ0vmPkYgLnfe6AzCm2Yr9gdGXn5O/cYsfakcNLFpheadQ6om3tE3FLNjUao/2+0TYo3
 DDYIPFQJdc0AFqPe8xBuAQpBDMeeL5Azv0wpKjE4JIduU7Jv04virA6z4LrTqWi1HkwZ
 r23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709121423; x=1709726223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ey89Hl01uX5rJaJ7gx3TbpJ+bjSISZiGwEb8QHXuSjE=;
 b=QF8lErB7b+c5g6DoGzdb0e8rAud87WZC+esyjvq4tCFAsKdBDX7pPFDlei4raRgKIj
 TplBPMtVUWm/tU2sx+GnnuVylBs/yZFM8/HCYzRPZ/Wr4LAG6+iNASkP60XDErYvO0qb
 BkW5qUbqsbTeegqLv0SMyF+11wwNKZmj6tsuy+jQR0yOuYIfZwlRMfQz7RNPvbhu6lvl
 tmG4lJygvkAKanVJkzZxi6Z+2jGUNwJ8OScbsK5SQiRYyRBCYufzv4IbcnmfnY1XNovd
 Z8ePwtFM2OuxX1C5VG3eIzwf09dlwKv73sRyFx6YhdP/ofhz2aGv+dNqmBr8skpXG62w
 /yrQ==
X-Gm-Message-State: AOJu0YyhDIz2YAnnb43KG4mnA0Xtt52r4OwVdcmRvpt7IhGmDnrPjhZR
 phVKMXiHL9bnwp7QWnQCfYT9J5N1AyjKD9F+H8CCvFOaD6ca5r+9KkgZtcEgYMg=
X-Google-Smtp-Source: AGHT+IEQaQCsTgg/o96ggrfHcGkvvEfs3QNm5CGPqVXHY3VJFkIgXBiqvklueJ8bszDvo6kECsD+ZA==
X-Received: by 2002:adf:f60f:0:b0:33d:77e:43ab with SMTP id
 t15-20020adff60f000000b0033d077e43abmr8397438wrp.34.1709121423170; 
 Wed, 28 Feb 2024 03:57:03 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g7-20020adfe407000000b0033d2ae84fafsm14265079wrm.52.2024.02.28.03.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:57:02 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2EF035F8F9;
 Wed, 28 Feb 2024 11:57:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 03/29] tests/vm: avoid re-building the VM images all the time
Date: Wed, 28 Feb 2024 11:56:35 +0000
Message-Id: <20240228115701.1416107-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228115701.1416107-1-alex.bennee@linaro.org>
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240227144335.1196131-4-alex.bennee@linaro.org>

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


