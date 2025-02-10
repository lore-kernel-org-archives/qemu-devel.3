Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2BDC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thaeB-00057h-ML; Mon, 10 Feb 2025 15:44:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thadz-0004Ku-FP
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:44:43 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thadw-00040R-OV
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:44:39 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38dc962f1b9so2058093f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220275; x=1739825075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=reXXm8X+zlZP2Y6yVzIRnVkTJgqUEMG013HELmRkQIw=;
 b=T1S1/77FghrAKsC8BCvTomB0tK6K5uOBNXgEYH4RzWmGbcbMoqt0xyyDh5G4DntPTM
 dxkt9Iysra8658ekdA08XqWez7/+dpQN9awXCGgKQWTsjmx+dkhzsaKiW+42KqPRRYP7
 hxAAfUFv3RL40dNeBdl/O6y1Z2bGrEjtZzgNiytM20Y1IgqZeWiCuZ9FmMfjOT/ZX7u2
 Vh8egJSaQY6blcSdfhmwXdZnfBWpcA6kuIh314ygU6ycLC/if0lJFUKCLpzxgKGeISUM
 uKS3rYlB8jgJ6ZbnX1M3/mjMKCRpreomlcfw+g9wmrnhP5TnKs0imjkyM9rkHhYseEq6
 P6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220275; x=1739825075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=reXXm8X+zlZP2Y6yVzIRnVkTJgqUEMG013HELmRkQIw=;
 b=Wg9DPefJ/gVBAWkwY5sjaxbd8m3KTJAdy2Qx+SmgrAtwCBydogg8S7IYwtRI6YjRpH
 12VBqr5oBEpFWMNBb6Mk/ZMD+xEwJjvf5RR13N7x2Q9chRs4NFcxHVzSsjA6zo2JAK3g
 iVf1B9L8ZLaZDosbmh8DfhMIalVXg4iubl9a4xiDKQVip8Qa2laj+oKZshYNfGxXRoH2
 vwU8Vd11QFAe1NWhdXjDdVuVYjxMVZt2U2aR1b7BCzVtW92d+Rz7hPbYuCrUuAy/kiMv
 yy/+eqybpkmNYO3vVQqK8rKSfJxgqoomVDMPuM6pqKnHw8M9nqhjGpHlxUPL05RXZpvN
 WvOQ==
X-Gm-Message-State: AOJu0YwwuiLOHSNzbQMtcYfc9Pn5CGxpftqVTZXL6X2+gW7bh5CzcgjR
 AGtVxEwDTks5K6piWmTcTFHhhExFdhtqE7k8mJSjzBpkTDbJQtIuZ4jNTDQoYASwrYJl/pg2Ldp
 6OXo=
X-Gm-Gg: ASbGncsc/U7+M7X+DhlDubsEXVh8FyZEJsDuCb95xBFTskP5LSZBCqzNuGetCZryzTm
 cYyW/zBshyfcRKNY1bh8NupihPWKyRe9URUy6ZGzjEv0OxvM0OjH2RW1KF9J81fWAHQjPOb9z4B
 y2Ab1sUDqFbBvbPYndAjCMBRyVgNaQTpjibvWfpj2W23O5oQMN1LMAlkYBDvTkcPzU9SvvZ//1u
 BQ23Otoz7InksDYL0GJeT2+Yay2UwlT25xyU/MSgU7vQOjsu+0/S3KJa8COLA8A21Tv56r+ET8K
 2uUNJ60F//qXZnGZQdOrTf6GFMqO6lUJlpgjnGS//LX+WFZgjf80SQy/Y+ts/N+rCA==
X-Google-Smtp-Source: AGHT+IGSGZq/RUekskEH6SG8uco5tI8eKnCgZOfUMjRl4hBRgtICSFnFmhYMY+uqPB9rGTn4T9JhzA==
X-Received: by 2002:a05:6000:1f89:b0:386:3e48:f732 with SMTP id
 ffacd0b85a97d-38dc8daf279mr14001726f8f.16.1739220274978; 
 Mon, 10 Feb 2025 12:44:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd4d826c6sm7641986f8f.69.2025.02.10.12.44.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:44:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 29/32] tests/functional: Remove sleep() kludges from microblaze
 tests
Date: Mon, 10 Feb 2025 21:42:01 +0100
Message-ID: <20250210204204.54407-30-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Commit f0ec14c78c4 ("tests/avocado: Fix console data loss") fixed
QEMUMachine's problem with console, we don't need to use the sleep()
kludges.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250206131052.30207-15-philmd@linaro.org>
---
 tests/functional/test_microblazeel_s3adsp1800.py | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index 715ef3f79ac..60aab4a45e8 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -7,8 +7,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
 
-import time
-from qemu_test import exec_command, exec_command_and_wait_for_pattern
+from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
 
@@ -31,9 +30,8 @@ def do_xmaton_le_test(self, machine):
         self.vm.add_args('-nic', f'user,tftp={tftproot}')
         self.vm.launch()
         wait_for_console_pattern(self, 'QEMU Advent Calendar 2023')
-        time.sleep(0.1)
-        exec_command(self, 'root')
-        time.sleep(0.1)
+        wait_for_console_pattern(self, 'buildroot login:')
+        exec_command_and_wait_for_pattern(self, 'root', '#')
         exec_command_and_wait_for_pattern(self,
                 'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
                 '821cd3cab8efd16ad6ee5acc3642a8ea')
-- 
2.47.1


