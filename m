Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EB6E7719A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 12:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVV56-00009m-Qo; Wed, 08 Jan 2025 07:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVV0v-00021A-ST
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:18:24 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVV0i-0002Sv-GO
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:18:18 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso173478505e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 04:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736338687; x=1736943487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwAIsSbR5veQrsYYHH6aBtjqtWXUUTPWi9UM3AxwMO8=;
 b=DLJ2Ovn1hpUXXRE7H3BQJj35Ohx5XKmB5yTrz6Sx6oGJqf/xTgXzvdjF57GUoVo+8z
 py5kL8RBe/cU82e6jtHeHyIYxHnI9LCy941Yld37n/IYTYotQPfm1ByiWgJKIhpZaTBS
 NhH4QQfV4qGihyCT6/C50ZoCMyWrv4jE0JH6ON4XCFFl7SKrsD4/Kl30VKWrfClgPLmy
 FUdq436UbiaDt4PPHJwbuVgf0vgee/H2LA5D8VYuC+ahZXmMYPFpdeAGLWGeeUG2cl2H
 Dhl8Xvq2Pk1sEMXuIw6omj8vLzvHC1/ij6QPe2lmaA7SRLKdiDTW9PyG+1fBWyspLd5/
 A9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736338687; x=1736943487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kwAIsSbR5veQrsYYHH6aBtjqtWXUUTPWi9UM3AxwMO8=;
 b=cmDQSPVXnG0nqYQKeon3ZRt2fJt+0ZD5BQ1xJReExkw5J5bC6BvnYIXuRxmc85yvXM
 swT1tm+5Wsvbpg0jMTb4XtiM7/Y7ly51yjv0UCyPXPtmQh176eyzZdJiqMRiaf+leUNS
 bSjmTvrSofd4kB/rQIqi61tVVRD0/xKEpuVxEJjLX1t7NNs4OsZD7NwrMQmPxiyIjPey
 G5nY3cLSyaK61Po992W+UsSLf52+5uzmrbPWgE+kOlj2uPa9JRFotrLxWH6ZTG0yGQxB
 4Xs52l/UrgsYSefZX7Vd3Awv+laddqoN4c+5rxtSv5Vnn5AhKs6ak46QZixDY1uZn7J9
 8eIw==
X-Gm-Message-State: AOJu0YyNlynbIWIbrkzkpp7EjkAPx40gXQgYo1VbVejabs9LGIcYw9dT
 JPWNfaTth2fgA2C82BOcRIDe04jYCT494HNVRgJca+yOjQp7KDM66/E0W9gpAiM=
X-Gm-Gg: ASbGnctQDJnKgu93Jy4xEHsjAerUOlEhH5xtT38lS+SPv1FaunXy38FZNrBkgu+FP2g
 UAGkbkNuOeK+UcT5AJwiwsaYq5hevYOeKuUGv+/Tp7WPqL4xLcDWKIl/228ZExeEF2DeDG3Dy7o
 7vlZQchZ7iCyxMYVDcVTQ3F/DVar9YZqfVoQyyMZxM9fGVT2rMXZD16cLDMtOj4jdQP17ff9DHE
 nxK//EVivSPzc/J0M9bC1vrCllstyH/lnOHdRDKnncTjJJVpb1WCSU=
X-Google-Smtp-Source: AGHT+IH8Ni23hrVUX4aLu3hTyE3YKc9XqttGBSjOWQrLoCaNldVpph4k9ANs9zasvHbKbiIIKsyxEQ==
X-Received: by 2002:a05:600c:1c1a:b0:434:f753:600f with SMTP id
 5b1f17b1804b1-436e26ba95dmr21447855e9.19.1736338686693; 
 Wed, 08 Jan 2025 04:18:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e22c6dsm18890045e9.41.2025.01.08.04.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 04:18:05 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6CC5060030;
 Wed,  8 Jan 2025 12:10:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-riscv@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>
Subject: [PATCH v4 29/32] tests/vm: allow interactive login as root
Date: Wed,  8 Jan 2025 12:10:51 +0000
Message-Id: <20250108121054.1126164-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250108121054.1126164-1-alex.bennee@linaro.org>
References: <20250108121054.1126164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is useful when debugging and you want to add packages to an
image.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/Makefile.include | 3 ++-
 tests/vm/basevm.py        | 9 +++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index d80ca79a28..14188bba1c 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -66,6 +66,7 @@ endif
 	@echo "Special variables:"
 	@echo "    BUILD_TARGET=foo              - Override the build target"
 	@echo "    DEBUG=1                       - Enable verbose output on host and interactive debugging"
+	@echo "    ROOT_USER=1                   - Login as root user for interactive shell"
 	@echo '    EXTRA_CONFIGURE_OPTS="..."    - Pass to configure step'
 	@echo "    J=[0..9]*                     - Override the -jN parameter for make commands"
 	@echo "    LOG_CONSOLE=1                 - Log console to file in: ~/.cache/qemu-vm "
@@ -141,6 +142,6 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img $(VM_VENV)
 		$(if $(EFI_AARCH64),--efi-aarch64 $(EFI_AARCH64)) \
 		$(if $(LOG_CONSOLE),--log-console) \
 		--image "$<" \
-		--interactive \
+		$(if $(ROOT_USER),--interactive-root,-interactive) \
 		false, \
 		"  VM-BOOT-SSH $*") || true
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 6f3f2e76df..6d41ac7574 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -612,8 +612,11 @@ def get_default_jobs():
     parser.add_argument("--source-path", default=None,
                         help="Path of source directory, "\
                         "for finding additional files. ")
-    parser.add_argument("--interactive", "-I", action="store_true",
-                        help="Interactively run command")
+    int_ops = parser.add_mutually_exclusive_group()
+    int_ops.add_argument("--interactive", "-I", action="store_true",
+                         help="Interactively run command")
+    int_ops.add_argument("--interactive-root", action="store_true",
+                         help="Interactively run command as root")
     parser.add_argument("--snapshot", "-s", action="store_true",
                         help="run tests with a snapshot")
     parser.add_argument("--genisoimage", default="genisoimage",
@@ -675,6 +678,8 @@ def main(vmcls, config=None):
         exitcode = 3
     if args.interactive:
         vm.ssh()
+    elif args.interactive_root:
+        vm.ssh_root()
 
     if not args.snapshot:
         vm.graceful_shutdown()
-- 
2.39.5


