Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAEBE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEzo-000171-GH; Fri, 10 Jan 2025 08:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEz4-0008LK-IO
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:32 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEz1-0005cY-Fw
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:28 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa6a92f863cso399879266b.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515406; x=1737120206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e16Yd2WScbmV3uHGmC2pgLQVf+JJ5Kfaah7q42MvIao=;
 b=juChR5W11JFPRYMrzbjGcUyYjxP1kOl0Fe8Sf/nWPr4xAZ7Eo9Sbf7jtXDBUJKraLA
 3P3Rf+16TAFlE4XvzhzNT8jvwMvHPdRnoCGqRcFf8oMvUl0CSxGT7nS3ZNAb7NrmjCIM
 MIPdClkgUsVSDz54JuWBC68ZZpissb6gbNnDkaBimxw/6qpjeoZV3eZo3yxjBBM03SZX
 oal9b8vtOjJuU0SDS/SKhPhKG47eBqOQ8fntmpwYdt1aoUN9Nnx4sH9awICgUvbbF14F
 7fTYcOZr4b9729946JlkcoZMz/+4TcJM8APQ545GF/2/k0wO94XTsDz666SidrryKdKG
 f4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515406; x=1737120206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e16Yd2WScbmV3uHGmC2pgLQVf+JJ5Kfaah7q42MvIao=;
 b=p0qy1SIY8MkS4coN4KIRagerEGQWWDvZyJj7JMkldr5oWJcZGY1X+QHO7edOatnSQm
 lnWp5WQHH+vPpwzIhwkoectoap9TFAxQnT5WbW/k8svvqxMPssjR11dHYRCqieMH1/4o
 bQiBWh2KDcu3NKbR0IWTT+oRbNzHbfsJUBqM4Nqrew8Q+XxeTCIEIMA2ePXNx7iWIQbj
 tXIIRObDX9ZpNBlq52yu/1VVgTU+AmMMx3PGgnyNAGo1EyYQeBB3oMoMN7wfMZ9aL5i1
 fmp7NHOhBqzZs/W35PWS5R4ds9w3cY/78J22HRBfei+1+UZDSybGwd8I5aoMcat96Ene
 DhvQ==
X-Gm-Message-State: AOJu0Yz7xRF9LuHqd+Ba8N6/pQeABBU16ZdRpJtZhvtBi/vXoZlsfLcU
 2ztyHvkRzmzpWA/QAuv5sdbqmomaAU5V37OBAQkac1k8SbdbiFlX5rvLrqe2wy4=
X-Gm-Gg: ASbGncvcunDnQmLwLHbskGvFc3FknlBuEtpPIRCHfoCoXVcVMEna3iGqZs4I8eirt6n
 PcgALiufC/2AfS0vmkkEIcp21JqEyQJ6gqHTaC7ZC2sZ2j7uZMlyVQ350BxGlGU5YyXRYKXUnXl
 +u8anRpkQT8uuTdf/F8Sid85FhEW5xHpzb2vbcBgAG6l+cYGHUhQZq+O7yL+sjgCdc0bMJKXVMH
 vbepRlLLbjdh2FyDWTUQfJyQiesd6pk7UHrSmv4k22PYXavVEeLeUw=
X-Google-Smtp-Source: AGHT+IEarLYJ52/K/tMXiSptNAAN77vcXZ7ppx6Gd9dUmM/jCg/jqk6J1GE8Q2E7Ei5bl5oHfn5l5w==
X-Received: by 2002:a17:907:94cc:b0:aa6:7c8e:8087 with SMTP id
 a640c23a62f3a-ab2ab6a8ddemr834846566b.12.1736515405742; 
 Fri, 10 Jan 2025 05:23:25 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905f067sm168718566b.14.2025.01.10.05.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:23:22 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0F83C61546;
 Fri, 10 Jan 2025 13:17:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:Virt)
Subject: [PULL 22/32] tests/functional: bail aarch64_virt tests early if
 missing TCG
Date: Fri, 10 Jan 2025 13:17:44 +0000
Message-Id: <20250110131754.2769814-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

The set_machine and require_accelerator steps can bail early so move
those to the front of the test functions. While we are at it also
clean up some long lines when adding the vm arguments.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-23-alex.bennee@linaro.org>

diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
index b3d3b0ee51..201c5ed023 100755
--- a/tests/functional/test_aarch64_virt.py
+++ b/tests/functional/test_aarch64_virt.py
@@ -40,9 +40,9 @@ def test_alpine_virt_tcg_gic_max(self):
         iso_path = self.ASSET_ALPINE_ISO.fetch()
 
         self.set_machine('virt')
-        self.vm.set_console()
         self.require_accelerator("tcg")
 
+        self.vm.set_console()
         self.vm.add_args("-accel", "tcg")
         self.vm.add_args("-cpu", "max,pauth-impdef=on")
         self.vm.add_args("-machine",
@@ -71,15 +71,16 @@ def common_aarch64_virt(self, machine):
         Common code to launch basic virt machine with kernel+initrd
         and a scratch disk.
         """
+        self.set_machine('virt')
+        self.require_accelerator("tcg")
+
         logger = logging.getLogger('aarch64_virt')
 
         kernel_path = self.ASSET_KERNEL.fetch()
 
-        self.set_machine('virt')
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                'console=ttyAMA0')
-        self.require_accelerator("tcg")
         self.vm.add_args('-cpu', 'max,pauth-impdef=on',
                          '-machine', machine,
                          '-accel', 'tcg',
@@ -100,7 +101,9 @@ def common_aarch64_virt(self, machine):
 
         # Add the device
         self.vm.add_args('-blockdev',
-                         f"driver=qcow2,file.driver=file,file.filename={image_path},node-name=scratch")
+                         "driver=qcow2,"
+                         "file.driver=file,"
+                         f"file.filename={image_path},node-name=scratch")
         self.vm.add_args('-device',
                          'virtio-blk-device,drive=scratch')
 
-- 
2.39.5


