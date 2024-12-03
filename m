Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEEBE6C61A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 09:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIP6j-0005ZH-Vi; Tue, 03 Dec 2024 04:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIP6h-0005YL-9c
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:22:11 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIP6e-0002ev-Q6
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:22:11 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d0bf77af4dso4365781a12.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 01:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733217727; x=1733822527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhfmnQV2U1yeLbQ0YN69JuJChLdIfKrfDAxolXgPuaM=;
 b=uRhwpA7ilvMbYlQdYPP3UH4zf3LyoyZavwMwXOKCx733SvjQ5oKsp0f4ft1R7kRJUh
 OzMKbxbK7IxOga66hne5FwGPk2/57EhqMa/FArcpdAl2nSMvIx0RO6HF50+TVUmFPt/L
 SjH+42QnHnIrAZmNzsUJryRd8z3uy6Wt2tjzgbRnHyDVWSxTji/Ab4x04RpkUbzQwi26
 y9CFkwidMQae0toyegW5X7x6RIcyuup9LGdEWAoZwfNhfWLyTX+8iDPsdK0qqQJSCxmT
 VZgGbI9brR78ZOx/JvckZaIgxYBzDj44uYCHOYwEO7uo8PAJNKJ5uoKrTKuFVbkhiDis
 k+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733217727; x=1733822527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhfmnQV2U1yeLbQ0YN69JuJChLdIfKrfDAxolXgPuaM=;
 b=BbDgDp7P5zVhg3rlGXDrpxXaPsayT1hYbm2YDbbYym8cEP3WSLUqq5sqxKhdqZ0fUX
 WJDb5Hz/eoxZY61ZigD3X8enpWW/KVnl+Z7u+l/Yu3yxngUgJugyDWdlFE0ZCjdU5n9a
 x50iJhkdAi0RQWTH6DOBo9IUnV6dguer9n1cT88ayTJY2NNW5SwVKn76p1Bfwy2JUA7O
 TclVfmFCuLudzHbf3e1+SxvMr1NFCFLtSOT0r6nQ5ivMkLHliFm8mORS4EMjGnuESJTw
 7kJ1diMeTmp0I6mmSOksBDAfxDzGpHKZpC/be/Slitpcucvdzghr4oFlNHTkj7TEGVBm
 3maA==
X-Gm-Message-State: AOJu0YwgHjIdqCJxHZ/9fUsagn30FG0hln4XgKt1eaqymCBYUE07xXGJ
 egjOTCLemNUjmdb8mablphc15TkuGcM2OFyzkRiO1H4aoL0BAEWOuK1tIHjm/u7IqMM+6UCJnjN
 5Ous=
X-Gm-Gg: ASbGnctlAoIRoF48uqVXa9T6FN4++TIeEuy9nWU/5Zq3yWqOJA/ZYafhPbBegp2SNMx
 Wjrz1l4Fivl1siYgU7+Z4EWhd+ZKjY5cvOvzbys5sFmoeQE9xcvVwpeUys6E0QWW/eDpw6bXCo5
 YbzK9G+KdBOqF+XZ3O4PXZAsUToCqnRSWL5I3x7mezWs8WSVi9mTySOePhiODRKccyPoFPAVemv
 SozBlmWphyMKqST6WfWaWP6a3JTEhXfAyXSHd+YzYDabkcOAvfCMSBVqr6tHX6YNghmqaZK
X-Google-Smtp-Source: AGHT+IExs5Yi7XHHfGv+VoO8nUw6diCtB41A7VJ/kLqxsUAKXSiS5Jv3sEFudcXPJVh9yDPwSljpgA==
X-Received: by 2002:a05:6402:518c:b0:5d0:abb8:799 with SMTP id
 4fb4d7f45d1cf-5d10cb4e1ccmr1719770a12.7.1733217727075; 
 Tue, 03 Dec 2024 01:22:07 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d0c8dc9b8asm3868557a12.17.2024.12.03.01.22.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 01:22:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/7] tests/functional/test_virtio_gpu: Remove legacy '-machine
 foo, accel=bar'
Date: Tue,  3 Dec 2024 10:21:48 +0100
Message-ID: <20241203092153.60590-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203092153.60590-1-philmd@linaro.org>
References: <20241203092153.60590-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

Since commit 6f6e1698a68 ("vl: configure accelerators from -accel
options") we prefer the '-accel bar' command line option.

Replace '-machine foo,accel=bar' -> '-machine foo -accel bar' in
functional tests.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/test_virtio_gpu.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/functional/test_virtio_gpu.py b/tests/functional/test_virtio_gpu.py
index d5027487ac4..cc0ec234861 100755
--- a/tests/functional/test_virtio_gpu.py
+++ b/tests/functional/test_virtio_gpu.py
@@ -61,7 +61,8 @@ def test_virtio_vga_virgl(self):
         self.vm.set_console()
         self.vm.add_args("-cpu", "host")
         self.vm.add_args("-m", "2G")
-        self.vm.add_args("-machine", "pc,accel=kvm")
+        self.vm.add_args('-accel', 'kvm')
+        self.vm.add_args("-machine", "pc")
         self.vm.add_args("-device", "virtio-vga-gl")
         self.vm.add_args("-display", "egl-headless")
         self.vm.add_args(
@@ -118,10 +119,11 @@ def test_vhost_user_vga_virgl(self):
         )
 
         self.vm.set_console()
+        self.vm.add_args('-accel', 'kvm')
         self.vm.add_args("-cpu", "host")
         self.vm.add_args("-m", "2G")
         self.vm.add_args("-object", "memory-backend-memfd,id=mem,size=2G")
-        self.vm.add_args("-machine", "pc,memory-backend=mem,accel=kvm")
+        self.vm.add_args("-machine", "pc,memory-backend=mem")
         self.vm.add_args("-chardev", "socket,id=vug,fd=%d" % qemu_sock.fileno())
         self.vm.add_args("-device", "vhost-user-vga,chardev=vug")
         self.vm.add_args("-display", "egl-headless")
-- 
2.45.2


