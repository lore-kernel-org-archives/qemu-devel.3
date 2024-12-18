Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85638E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwsb-00037L-Af; Wed, 18 Dec 2024 11:26:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwsY-0002wT-VV
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:26:31 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwsT-0007qN-O5
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:26:30 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aabbb507998so671163066b.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734539183; x=1735143983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwAIsSbR5veQrsYYHH6aBtjqtWXUUTPWi9UM3AxwMO8=;
 b=uNBk5n711lLEFpEg/zrkTVXePrVkP6VFMVI0xl0f9lT4IJS5nsIbLMW4qlS6bKwRlW
 ESKodf34qJYzqzj300OcIBuC6Ys+gf83z3SbmY/pv4luDkNTzmsYfPtWrOd3R4e0oHXM
 UhCLYUFgJsd9uFrfthg6e4O38JmLKj8hzyZGQzw2Lf3qDqlqq7Pfz6+4iFy3iXEM4Bie
 Bhsbv0v3j6TomCsZR44ia47m6VpWaer7B8D12FYz7yO4bUAGBNfJzxz9qGfGf4b2Rvh1
 7Em09fgoTHiPrpTq3DeSkVRIQcm2Qt9YFDg3ZcjNBV9IdU2vvkniIjawjguPbh/1m/qi
 eTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734539183; x=1735143983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kwAIsSbR5veQrsYYHH6aBtjqtWXUUTPWi9UM3AxwMO8=;
 b=EUy40IVcb5/pCZEBv90yWbcXmDVH164oJGxR+6sByFwWECH1EmixyE344sVeLIxkBb
 /UfGUxS6ll4Ykbz8/DUxvYEeYbmsX4RpCDefl6fUBpQ9HVDgvuPNK15457Sv8TJGhsfz
 5xJqyHhAnY2c9hA0LKWFIOOiTQ5FXBlyVvsASqB8fO1BeQ7mPfKcQ6MAgJmn5ZPQ+Xyd
 vwAaRn6JcnX54up/m/QdO+Tmd0zr/P2p9jn8IrURMS8n7QxLzYWV3yZuVLLQb8NmH0Ef
 AQ1O8VOD0pdGkgVpI5KM2pjQYCgAltrAMd28/S1My0BliFc2AYBL/ujempsLTd78s+0W
 BEiQ==
X-Gm-Message-State: AOJu0Yy3LXv1g42Qda/ELwVD0mDgn97jiZZEV8/BzwiDKnyuzd0ikCe+
 jhhqohVIf/nurH5BwQlA/4Oq4xy5FRruKZyxXMkl8V+4kSexmGhBqoNjw2vyhd4=
X-Gm-Gg: ASbGncsbA9aoi1IJCqXYeHzFoHMZeE2QQd8SMAyDiwCWIAMi6oMLPb1Vk+eL1uzEshn
 CxgVrJ2aQ9deoFjkxdW1Tkw4gCTtK9V/yDlZvakSGlGwDDuqHElrxIq3dzwyOlgsN92QbxqJYi+
 nstInGe2dOvD4euQ0deGOxHKat9Par1W0737Uo6/jKDPO3xH4CpdHckVmTxFUP1kfF+LrTK4mnK
 3GlEN7M0tlPoyMS4R7lZZnqFLidqWfIbtMQj6OARqNCiIY2RLZ/Umc=
X-Google-Smtp-Source: AGHT+IHg1F86CcF7hn20hdzHgrr0FKN41xOvPAKkaI+8wWX+OFZ0zj4mIVBO5co2NaZSSUoj4lOVng==
X-Received: by 2002:a17:906:318c:b0:aa6:82e8:e89b with SMTP id
 a640c23a62f3a-aabf479ec52mr303668666b.28.1734539182982; 
 Wed, 18 Dec 2024 08:26:22 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab96006133sm581741166b.25.2024.12.18.08.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 08:26:22 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A79F860BD3;
 Wed, 18 Dec 2024 16:21:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Beraldo Leal <bleal@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Weiwei Li <liwei1518@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-arm@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 26/27] tests/vm: allow interactive login as root
Date: Wed, 18 Dec 2024 16:21:02 +0000
Message-Id: <20241218162104.3493551-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241218162104.3493551-1-alex.bennee@linaro.org>
References: <20241218162104.3493551-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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


