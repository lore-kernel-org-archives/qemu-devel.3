Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0762EE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWF08-0001Vi-Ja; Fri, 10 Jan 2025 08:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEz4-0008LJ-GQ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:32 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEyz-0005bh-VY
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:28 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d90a5581fcso3307480a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515404; x=1737120204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MQMfzeOke49tgnke0WL/59AB7TOR8shSu4i3d9zIcBQ=;
 b=ILQUHo8yBn6k1ct5M6SZ00RWnTyz3GQkL5eJ/1KTIW0DjcvJzc2fyS6+LYbR9PGgze
 KY0NE+ia6kTnrZajMw6t2wu0K9QeWUDoCUjQTWStj2U6W1HUgQx9m7ak6OMhMogxy7vj
 w/XNhJ4gYP6pfsy/hCeH2kqaXBKqSx1gZfjzddNFWAZVoshCzvzi2DgHRrItK1q6B5tX
 8iNvFZTkIotmpoM8eGduDZzn8BdaAgRt6WlU8yPfbeHx2D4Y3xvy+1gLa0Ot9muPlVVH
 l2BED52onxylwHho4uZUNQzJ0uvlQ+zLFb195Zuy5LJODrYWl7CJtPhIlBVJiB2+LLaz
 l59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515404; x=1737120204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MQMfzeOke49tgnke0WL/59AB7TOR8shSu4i3d9zIcBQ=;
 b=fdD7GEYP9mJY8nyDjI0A+S3oDO1rKzjZFVHliTHLk3iULPlwxKbdws9BNBX16XNKA4
 mV4i3SAOxWfnxQkg8a2H/AMTEJmO3vEPXrbPoWqKprT7rce+x3MZTCCWpDnxYjUMgMHJ
 IrqTRXk96C47yk6dAygvg7vcQuroIC7v9EnOtjH54tmKQKiL1iNPAy6Ef7yDXaDI9WxL
 9YPEw0eaXyeokOTU+PYK/pfKMsORI0QF+r86Ggx3FSN5zPMdNtEKWvnuP+AEUpHBWkmc
 gojHS4Y3ddeEs385EEKjereJ5xtNILSGExDq3UAZ/upXIQJw54KFoBE5WFQJXvjXAD7o
 p9hQ==
X-Gm-Message-State: AOJu0YyyTQv2s8+mblNJ8f5bJO0dPfZewaHXJvHzjRyad+oYNbafelE9
 pTGOzG+oNiSj8HcyhK60W8GuSgBzdby1VoW1zc6UuV9cAqQZnEWl0PLkXIzRemw=
X-Gm-Gg: ASbGncvF5hEbJqgyb9hGx6f4zN1cea45FBYrGlwvG2mnmNEHnAZEtgqMIwKjm5pAoYO
 XpbbvkxiNWdWZWbHw5tWGtGg1B6G3DqZVFsQK8RbnnFt+WwG7Ie42W0nu7tXeftAT8UQGR0N85g
 enlchfi6yvkO7vr1y+0Idv1dJ0Uu2UeJrJ8akAc7BdYgWKtmY3ZiO7kxuaiLre92Q7hlLbqmlAJ
 gPAIPfb3XlzX59wwChOMB18LAVe2D0yUtewKDKV3O6hIUmUbsR1uTU=
X-Google-Smtp-Source: AGHT+IE8oLCJW9UYC5riQZLzzq+k0fL00y0xIVo3iYTK0jeOCXB45UnwapMA7VMwcaK8oEJ5irfF7Q==
X-Received: by 2002:a17:906:c143:b0:aa6:79fa:b480 with SMTP id
 a640c23a62f3a-ab2ab670756mr985624366b.10.1736515404207; 
 Fri, 10 Jan 2025 05:23:24 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9564865sm167763066b.108.2025.01.10.05.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:23:22 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 954635F9D7;
 Fri, 10 Jan 2025 13:17:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/32] tests/vm: partially un-tabify help output
Date: Fri, 10 Jan 2025 13:17:50 +0000
Message-Id: <20250110131754.2769814-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-29-alex.bennee@linaro.org>

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


