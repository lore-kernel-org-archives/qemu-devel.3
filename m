Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC7BC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reygW-0005Nr-7t; Tue, 27 Feb 2024 09:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reygQ-0005KZ-Pt
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:43:51 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reygF-0001xL-Ie
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:43:50 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33d6cc6d2fcso2747483f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 06:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709045016; x=1709649816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRiAaEWLbPdwH7MCuFZoee4IvGVtzFJe6l3ojpTWHyo=;
 b=SWNq0+p4xVne2WkB+gqFd2Vg+VPdsKv+uI+zEAVc5TOtUlTelkLc8y+o2ra6aj1Qqr
 /8exY9xAutr2r6LH4Rr9h0FMLqY8t99stNxiRX5N5f9rmVGjonD2PiSxfd/nkRKXo3ze
 FsuZi2M7ZQNrYS7l9QAREkjlMDhK5Tvp9FCMK1pD95tpFRGW5zpfLQyMi5g7vrWCYk3F
 034JQ+oUyIk/nkO2Hn4zjSfIGMhXwK8O0mb4dB0Vwkdl2zW203QdWOOUfGwurvQfYDri
 KotheSdfLy0Fly2EAxUqzecJD1FWT+4/qoOJ5lIfNJkKn4fn+eQ3y6W6XtT1OK7HlZEN
 Ex8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709045016; x=1709649816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CRiAaEWLbPdwH7MCuFZoee4IvGVtzFJe6l3ojpTWHyo=;
 b=Z3EimzWXTSunTFWaUeKjqVJ4STyYMgytZEKUSjaC6YQdk44JN+FEd0KQWSNUdGTGpK
 8olJbrKUB42XgiBy03cTclFZWYMIHBaED9NLh5aNPeAf18aUNoMG8hyP7uFgS0hXKNl0
 Acdpjc4baMS9L1Fb3R873VoXeazmWkkoXkw9i8FtzMKj4eB9r9oc/BqBR+IpOgAi2PPv
 cJ/kFa4qGYA96KG8TTCLHyPSgFkGZo7xjO+1xOEbVkfz1e1e5jtl5jSJt+e0pQ4pN1Zi
 mWYiLuV68w1cvUpbH2N8CXxITvsekiiFeU6mlk24WEfDlBXfU0o6lU0h5ThMh0F5J6ay
 Vnbg==
X-Gm-Message-State: AOJu0YzlbEj31Xx9uj8eL+S7KSXFPSCQ8G5lETux1y+Whj0W82nbJ61n
 MABcNxNY6cQWBeYfcYz4Zmjk6V2k3Z8t2cp88+eF4vgiHHUKCl9ib3UbCXV7eQw=
X-Google-Smtp-Source: AGHT+IHtxOUM6bJrKXQa2pXx+TpjrveJUAUmzCZuLVzZ8zVZGAt9Io79u7D4R36LKQfBwXDzcNVnuA==
X-Received: by 2002:a05:6000:dcf:b0:33d:f457:ab45 with SMTP id
 dw15-20020a0560000dcf00b0033df457ab45mr1051504wrb.43.1709045016596; 
 Tue, 27 Feb 2024 06:43:36 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bn23-20020a056000061700b0033d1f25b798sm11768370wrb.82.2024.02.27.06.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 06:43:36 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B09155F8F9;
 Tue, 27 Feb 2024 14:43:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 qemu-arm@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Rolnik <mrolnik@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-s390x@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Brad Smith <brad@comstyle.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <bcain@quicinc.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v4 03/29] tests/vm: avoid re-building the VM images all the
 time
Date: Tue, 27 Feb 2024 14:43:09 +0000
Message-Id: <20240227144335.1196131-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227144335.1196131-1-alex.bennee@linaro.org>
References: <20240227144335.1196131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


