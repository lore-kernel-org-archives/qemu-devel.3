Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32399E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwon-0000oN-K9; Wed, 18 Dec 2024 11:22:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwo5-00087X-4X
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:53 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNwnk-0006th-O6
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:21:52 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa696d3901bso1276845866b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734538880; x=1735143680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9bkcZ+UQ0l/G8BdjL46Ekgb6aiXVq9O7cYmGEkCbVeY=;
 b=WLIAeKFRnr++H5USIvBm85uaXGIL0AXbkXfGNKxVv+7O6UE9ETyrbj+NKITbJpHiPb
 6UZdV/pbGPV7aNPXk8YOhV+d8CyhGPGxrdxKc53RRQkV3efrzwVSOpskEIOUAp+JKMGB
 upiT4wu4Hmyegk3rdlx2ODnjw5UGpxaPCnWSSWk/I+lcWQ/ABC+xifqZ/HzmGiG8n6Wt
 tfDAfdiYTSflGXu0Uuq+9FGattbGjrIk9051t570xBMoSZVjJf9Z9LORmopi6VKVDf0u
 McpmegNIAg/JnvUhuVs97aYDi/olykf52BuKtT9ZC9cZ7rbYRFPRfPKNljfDdwyUnRxR
 EJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734538880; x=1735143680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9bkcZ+UQ0l/G8BdjL46Ekgb6aiXVq9O7cYmGEkCbVeY=;
 b=AVpclMslHL1hDBtNgLZdyVqQHbhS+ifUx3QroKYxx5XWwvDE3psWlTwQCATZqHP116
 lz4ySJVrtcMjXgtLfOOyxr8+d3i++IEFDyGHZPrRvmjo6R+tbqqbGThdgX1ZH4BWvRr0
 YRKh/p/rFIhsnyon+mxo+11Ac0Pxnj+57l69v8ZsLzCsu5je3F8jTID8XhdPv2AyIrVx
 fzxHZQlsAN5U2rKU7xTUKpXrblT2teevAPSVVZXatZ//yNUwIa+VD5q0jM53KPf9ibLB
 clHo6AoXKWpMvvSig1q7zGt93l+BYvEWuzwF3SJkndMnDhCVkb7ymTp584JUNz9bB43h
 73TA==
X-Gm-Message-State: AOJu0YwfSPUdRz+YE2Qu7ujxU7HTpVOmC87Wtd5JJZhTbP431VqnVBQL
 fACt680rl1GFKzShOFzSD5BF8XSqw498DxFYLheZP0+YxhkTRpLIXaOaI8NJ8fI=
X-Gm-Gg: ASbGncvCxJdTpcGS0Lm+8iaQ46Vi6oHE6JD1to2nsi+97dqi/uqkA5xMxub6VqmqJ9t
 1V7IjHBbreHPNRCld1F4sSe2bIh1BAEE4bcgSMdy3p8RdTt3aTIV52so9toSy/PF5Fju+TNUbgX
 rq/nI+JdNOKAqDIlxf6eS1IHG2CWqnRbeITH5lbQgY5Tyc+Ek9yN/7ETzOH59lKltAIGi9lrPAl
 dI9j49jDBuNJw+yMU2xuAIIajJQDXc6Z3tIe1mg1IfAaEXgjKAqAO0=
X-Google-Smtp-Source: AGHT+IEgo38+JTFTQe2QWD2SzXBn5GgMF3Ncp7VExom07hK+kgRY5m2GSWEr6D3P47raWVJ4deeNiA==
X-Received: by 2002:a17:906:32d6:b0:aa6:75e1:1864 with SMTP id
 a640c23a62f3a-aabf46ff260mr292000366b.4.1734538880368; 
 Wed, 18 Dec 2024 08:21:20 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d652f2599fsm5463542a12.68.2024.12.18.08.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 08:21:17 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 911F260BBC;
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
Subject: [PATCH v2 25/27] tests/vm: partially un-tabify help output
Date: Wed, 18 Dec 2024 16:21:01 +0000
Message-Id: <20241218162104.3493551-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241218162104.3493551-1-alex.bennee@linaro.org>
References: <20241218162104.3493551-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

While the make syntax itself uses tabs having a mixture of tabs and
spaces in the vm-help output make no sense and confuses things lining
up between terminal and editor. Fix that.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/Makefile.include | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 13ed80f72d..d80ca79a28 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -64,23 +64,23 @@ endif
 	@echo "  vm-boot-ssh-<guest>             - Boot guest and login via ssh"
 	@echo
 	@echo "Special variables:"
-	@echo "    BUILD_TARGET=foo		 - Override the build target"
-	@echo "    DEBUG=1              	 - Enable verbose output on host and interactive debugging"
-	@echo '    EXTRA_CONFIGURE_OPTS="..."   - Pass to configure step'
-	@echo "    J=[0..9]*            	 - Override the -jN parameter for make commands"
-	@echo "    LOG_CONSOLE=1        	 - Log console to file in: ~/.cache/qemu-vm "
-	@echo "    USE_TCG=1        	         - Use TCG for cross-arch images"
-	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
+	@echo "    BUILD_TARGET=foo              - Override the build target"
+	@echo "    DEBUG=1                       - Enable verbose output on host and interactive debugging"
+	@echo '    EXTRA_CONFIGURE_OPTS="..."    - Pass to configure step'
+	@echo "    J=[0..9]*                     - Override the -jN parameter for make commands"
+	@echo "    LOG_CONSOLE=1                 - Log console to file in: ~/.cache/qemu-vm "
+	@echo "    USE_TCG=1                     - Use TCG for cross-arch images"
+	@echo "    QEMU=/path/to/qemu            - Change path to QEMU binary"
 ifeq ($(HAVE_PYTHON_YAML),yes)
-	@echo "    QEMU_CONFIG=/path/conf.yml   - Change path to VM configuration .yml file."
+	@echo "    QEMU_CONFIG=/path/conf.yml    - Change path to VM configuration .yml file."
 else
 	@echo "    (install python3-yaml to enable support for yaml file to configure a VM.)"
 endif
-	@echo "                                   See conf_example_*.yml for file format details."
-	@echo "    QEMU_IMG=/path/to/qemu-img	 - Change path to qemu-img tool"
-	@echo "    QEMU_LOCAL=1                 - Use QEMU binary local to this build."
-	@echo "    TARGET_LIST=a,b,c    	 - Override target list in builds"
-	@echo "    V=1				 - Enable verbose output on host and guest commands"
+	@echo "                                    See conf_example_*.yml for file format details."
+	@echo "    QEMU_IMG=/path/to/qemu-img    - Change path to qemu-img tool"
+	@echo "    QEMU_LOCAL=1                  - Use QEMU binary local to this build."
+	@echo "    TARGET_LIST=a,b,c             - Override target list in builds"
+	@echo "    V=1                           - Enable verbose output on host and guest commands"
 
 vm-build-all: $(addprefix vm-build-, $(IMAGES))
 
-- 
2.39.5


