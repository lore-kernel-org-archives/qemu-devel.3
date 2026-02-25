Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23FAFD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOBL-0007i2-UQ; Wed, 25 Feb 2026 18:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOBL-0007hi-0W
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:20:39 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOBJ-0004B4-Ed
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:20:38 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-483a233819aso2867875e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061635; x=1772666435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ff9I3GrkxCkld69uvBI9OtuF0RjJQ635EGlKJt6w3dc=;
 b=aymUelaLwZkWtk1RBKz+XWdEHXR1EJ7hvV9trnoVYpIvJxBZEePrMftjGAUAQ4Ou8c
 CKUtOg7LZ0RLFKiOygF8BBbqtOtmwEk5lSS0O/LE06wKc1mF2s5Fz1p1BjyfdNAmIAXD
 eOvwjMyXJhcME7Gv/EweKmzKFY/zNlKybrdLOjjV9WL6bLDkqXXJyGgBEepwfdsc364x
 zHbSjn/kP2Gr7Wexn0kT78N/e45+Kpmufg8uC72/4AL2lZzWpdzJskgi+NOOY7Uxamps
 3X+VGSWfxMLBRraUU5UDBgRUZ3wqSErWUihRMPYTkmmsampy5TRrgVuJD/kxfakkUtHZ
 RHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061635; x=1772666435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ff9I3GrkxCkld69uvBI9OtuF0RjJQ635EGlKJt6w3dc=;
 b=FiyJssnrCvwqJO4bHWyiTW1m40J+krwgJDH9dv/qltfTwE8Lu1PEL+pjXPkh4cJUqH
 sxYd7jL0Vn7I2ki6DD1vj9Fi3g/DBjHDg7ZZ9sdMrp+D0CQCbRz8IiFhSbnM6QxU2A/Q
 87RE0/5i3LDYPLRE/hexLVmkd5B4VEUsXw4kHljzrzxeNI1vA9VAJjM6FaNKbPYiBDBj
 dqdebf+D/AfwFZO2aOtETgXCgIAXHrUY80xJAjZhn6Js0rDyKv7asmOLLtaOUsKAXKHT
 SxVvzRpmilxzteS5R/m5Gseur6ykCWZ5Bcohr0x5H30Cq62J99d9JKABmW2+yhCJoeVT
 QB0Q==
X-Gm-Message-State: AOJu0Yz4u/Otoe4/0pX5sJwNzDZz5d6ccRTNz7HOke3kD+luLFiYbqU7
 L8ys4uYCa6VbFwNbVMBdCXceD7GJ5oWVsW/tH+r0cLheTS04xE2rLjjEfKQUzQqEBh36mwCKChe
 HkZ5c3HI=
X-Gm-Gg: ATEYQzwaMl2Is+K+CsSd9IiJVLJQZ3t8AcTUcSLPXPPTlUGBlY4PRCxQ5FrwoeRvpAN
 zs2LmWU9L0TQC+eqDnBDPU1EhpEArKO4SeDJ8i/v2/mFon4//uyOEkLwd5twpkCKbj7X1+xZGQw
 WwYkNOqQyjNIYQF9KqzTRfxzeYEDfR1M21Tl/coFZr3b28Rdzi26IAe6JSq6HrJntYQ09830gyQ
 71O9LzbseUyRlJXQzgjNVtHkpWPWaMfJK2hlEYAWJTEWkxzKbBY+G3T3cTMc7kdhID5jK1+1ZMq
 aJ0iDZ+QGJL5BqNp9rvl4YbMWPjdZfYSqadyI/P15jgPU7Um74V/52ibY5ozOOM0Sm3Hk1SDr/l
 cCcYsvE1zMbglnPVW60uTvNlInyeR1rbTSEYbQrCOiFPibohDh0lXuKXhozMV91QRBLbIHH9ioq
 Xho4CWvVyhf1JzfCJpofibVHel0bOdlBRoQmMyG8ih8Af6hLhC85C0+0WwFC281wP4PJ7ZuScn
X-Received: by 2002:a05:600c:3b14:b0:483:c35d:3662 with SMTP id
 5b1f17b1804b1-483c3dd6fc6mr1499055e9.18.1772061635422; 
 Wed, 25 Feb 2026 15:20:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f3124sm100631855e9.1.2026.02.25.15.20.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:20:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 56/70] target/s390x: Build 'gdbstub.c' once for system single
 binary
Date: Thu, 26 Feb 2026 00:13:56 +0100
Message-ID: <20260225231411.96482-57-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

There is a single qemu-system-s390x binary, but by moving
'gdbstub.c' in the target_common_system_arch[] source set
the resulting object can be linked into a single qemu-sytem
binary.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-49-philmd@linaro.org>
---
 target/s390x/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/s390x/meson.build b/target/s390x/meson.build
index 096b7dcc42e..6f98ce34d73 100644
--- a/target/s390x/meson.build
+++ b/target/s390x/meson.build
@@ -3,7 +3,6 @@ s390x_ss.add(files(
   'cpu.c',
   'cpu_features.c',
   'cpu_models.c',
-  'gdbstub.c',
   'interrupt.c',
   'cpu-dump.c',
 ))
@@ -34,11 +33,13 @@ s390x_common_system_ss.add(files(
   'sigp.c',
   'cpu-system.c',
   'cpu_models_system.c',
+  'gdbstub.c',
 ))
 
 s390x_user_ss = ss.source_set()
 s390x_user_ss.add(files(
   'cpu_models_user.c',
+  'gdbstub.c',
 ))
 
 subdir('tcg')
-- 
2.52.0


