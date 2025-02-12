Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D75C021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiAsA-0006zI-6x; Wed, 12 Feb 2025 06:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiArj-0006bC-7G
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:25:18 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiArc-0004m9-0L
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:25:11 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38dc5764fc0so5168386f8f.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 03:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739359504; x=1739964304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zk8npvpvvWsz3fYv0R1o0ULJq8hATZnhrjaHmw2ltQw=;
 b=CNognFm6sFgAeRIj5QsEIEylGLc40lgtPRNoML62/UHsy7Va/awfHlki0SHl8Jo8xi
 iMYz6oPhlf5xILDicEnN8jSQK6ZpqxWnusPP3v71VV8sT43Ba/fb5wijThZsZli6H0Ey
 vG5Jp6Gat+HjyywFuh8W456ovYgZCa3Ml8my8ryBDYN/vqPO4wbspECFPBe+yk1b8zD5
 21qGrLCZTnw0zH2UQ0OK93NNAWEDP87H0/V4Gb0TsD+jOKXZs/IRyVM+TRW0DKif+zxi
 OANMb8eT4t2HlIHgBbKixMM326+VyxN3261ceEhlk0SgO8fhrS4NRT18XrQP+FeplGCB
 SV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739359504; x=1739964304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zk8npvpvvWsz3fYv0R1o0ULJq8hATZnhrjaHmw2ltQw=;
 b=ETbthgtVFImQh1UWyWMmtS2ndFKgmhch9HVfO4Pgwl8N/Wi1jmFPGdGgyq/jr4+UnH
 RYi/Cox2qbFDFdqEhAbk3Yz7zRNIsk0P9cJkerNAHkiNlSRyOD52vikb9JjsZF7sFczw
 RdTqLcQDTE4VSWzZhDxd30kZNWYnwn7dS5QZFQDQTBvCkGhLxYOlRdf8Q44VdS6+3D/D
 rnvOoufOiRb9ejtAlYpEQDdzZGaF0bMbo2sid3NnqnPmXRHI3695yHZI2kR81hrqWuoC
 5Y1zKPWrVAkgir6TqoMpzbWvh+O91Y6C342OyNCdVgCbvexUAT3e0z2fpHw5pXxKvWs2
 wTwA==
X-Gm-Message-State: AOJu0YzqqmrA69z6HI8rtiYk0z5oIIuPJcbKTjlbYfG1JxCzX3kOkv8n
 4545yhMRlFM2GExqrd4zlJpyl4GigmzqAJwwriIzXrVgO79T1Iu9XYf4XHt2Iul3ZsSZdYn5Ubl
 U8WE=
X-Gm-Gg: ASbGncu/1ptq9nhJt9XC1YhfD4lnAYpIPNq/2Ecky6KqNF/bx98nKGhyCokFJzsi4An
 1jy3bOj/pzpLcZ19MTXXCWtRsPdtcag4fyOD2/ph2gjfjWruqAP6QiYAbm/CT0OgqC3HP7VARDW
 E7rUj1luB25bDbj9ftt4UcJPg4JL+rdYvJmMvV3XUexstbpOqr6I/i3hkiICsEJoU+J5Tu9a1lw
 FImv3+c8VTspOJ8AxpsEYTe+nPArYTQMq3mgWe8qcQcvP+eT55r2J6jQZr/6KRP3ojb0VUy37oY
 g8PboUTuIlp/BDhSuKK8opau7j6zEtCUih+UjQIKo1mA6GYu9oZNnOTXtHpwQP2bjA==
X-Google-Smtp-Source: AGHT+IG3nBiLmWqXeM+wrtJORgmRECrxXkhFarvFnsabu9nZ7V113AU4vBSCj1hdhWO3SaQLIS6ReQ==
X-Received: by 2002:a5d:648b:0:b0:38d:c2ef:e291 with SMTP id
 ffacd0b85a97d-38dea2e93ffmr2618859f8f.39.1739359503780; 
 Wed, 12 Feb 2025 03:25:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f2103100csm483962f8f.2.2025.02.12.03.25.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 03:25:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 10/11] tests/functional: Remove sleep() kludges from
 microblaze tests
Date: Wed, 12 Feb 2025 12:24:12 +0100
Message-ID: <20250212112413.37553-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212112413.37553-1-philmd@linaro.org>
References: <20250212112413.37553-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
index 1f0812eec63..d50b98342d7 100755
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
 
@@ -32,9 +31,8 @@ def do_xmaton_le_test(self, machine):
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


