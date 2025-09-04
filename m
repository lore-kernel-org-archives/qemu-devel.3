Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65878CA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 15:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuCBm-00050c-Q9; Thu, 04 Sep 2025 11:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uuCBQ-0004nO-CZ
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 11:47:35 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uuCBF-0008QZ-Gn
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 11:47:31 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-544a55b84d8so461445e0c.2
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 08:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757000831; x=1757605631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vYDFXmXqCAGa3H4P42CKPPrpxXB7rIYCvJObU3+Iajg=;
 b=r18vM5WKsi7cX9Tw91VlYUKwN37l5yqMGA9eAJQawp0yIPFoMwKY+ndzx2RBgpOY4N
 IRJcZDlamXiR+wo2RhE5BKFKLWUl9u55jRaXh6ZHoNEUKCw5Tjni1FCPMAJRv5UzoFHs
 WzsxmBywhHYPgSZtgqhvDTvgtTUK2COc6KmpvUlLtQpq6eNtIM+H9bAnIj6xfsKZAkV9
 UB9OROYp1nO1jcGIX0rJ/awMayYndxGzvg0me4qsZaSsdOV+7XyTcUWEfY6olt5VRLcu
 Ag7tVhxq8hQ/MoAGQ0Rap5IzFCh6LLBS9TOYZBQURFcQXEh37pA/6YOEB6H7Qm2oY0fk
 sdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757000831; x=1757605631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vYDFXmXqCAGa3H4P42CKPPrpxXB7rIYCvJObU3+Iajg=;
 b=YKkryFdKRN+13CGdLldEKobT7TOQrqqJlTWafE46CgOjLuRkd2XMRq3ELgfMp493sn
 ia19USripvNxQgcGspoILsYQ1rICKsVnxqtFKq62PUhithefeWmNHAZuFYgbVf4JCKd4
 37A2FjSZ+a221KcbWq4hMD1SLB8RdQlZUBhrjukQC7u+nhVNyoC6NUWoHuMv0HAosdof
 KHEBL3ewU1NTY3pNDi1rKcGT8F/zc78C3c90nNbmq8Q8oaeJCPd4QSHoZQhxDbfckLeH
 dSFbgqOCizJi31tSpTznvUzQ3TkOdq44sa4Nmu/uv9dsHHrGO1aVvOTLATROROY85BjD
 WMHg==
X-Gm-Message-State: AOJu0YwLxpHF/j1OSFceJFf1Ly9q9t4068gEEt8H+09TDaE7y3RIuQMi
 9ezYR5foJOLqtHPYlOTJPmu5fDztt8zgMQmnPP/UzWbFLaCwXnNyaMOLHURAU3+68zkIuuX5hB/
 VmUKwkO3AJg==
X-Gm-Gg: ASbGncv0lYuF3Qoqd23s6OL+wE2wiEkgt5je4biE8v5anbB+im8dB6Pl0AkP5wAEt5/
 Kc7SdYiPFotmZEwfub4EpWl8msk1q7Aydv49T3Q8IMS6Z1x2gNB933ssmA1FYt1y/D/k7aFWjRl
 eMJdWrVJQ3u6aPQlTuUyLbMV1gN/wUDRsMuPzBGLPhwGIZxPj4KXnmnYWvfenNNbiFKJuSYdS7X
 t1T6fQLwb2ViHv1Qk9rAaOcIpdpRbAK7UA/n3JZQJc9brDpEzBENMJhOR9iQp77Bub52Tf4u+Na
 FRuzJKcrNUai7wlmk0mcBSJZIlWbYdb0jYtYBX5GL6I9pY7ibMBb6kHpGc0sh8rZaGgx6CJyMnB
 SZxIYyiURR0nyglTuAaYz6FHtFV0x7oNH8DtK8LA=
X-Google-Smtp-Source: AGHT+IEfdF/8MTudAgTz1GKf4FI7P0iY9BfPuKxefZGnKr/uKjEuglZ8oN5EPxrYTIZ4IfY4cxLhSw==
X-Received: by 2002:a05:6122:1d8f:b0:531:2afc:4628 with SMTP id
 71dfb90a1353d-544a0190d7amr6131606e0c.2.1757000829781; 
 Thu, 04 Sep 2025 08:47:09 -0700 (PDT)
Received: from gromero0.. ([186.215.58.133]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-544a666da0csm6497022e0c.28.2025.09.04.08.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 08:47:09 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org,
	1844144@gmail.com,
	gustavo.romero@linaro.org
Subject: [PATCH v2 3/5] tests/guest-debug: Add quiet option to run-tests.py
Date: Thu,  4 Sep 2025 15:46:38 +0000
Message-Id: <20250904154640.52687-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904154640.52687-1-gustavo.romero@linaro.org>
References: <20250904154640.52687-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Add a --quiet option to run-tests.py so it can run without printing any
messages to the stdout.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/guest-debug/run-test.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index e051e8947c..cf8b37b8b8 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -39,15 +39,17 @@ def get_args():
     parser.add_argument("--stderr", help="A file to redirect stderr to")
     parser.add_argument("--no-suspend", action="store_true",
                         help="Ask the binary to not wait for GDB connection")
+    parser.add_argument("--quiet", action="store_true", default=False,
+                        help="Don't print any messages to stdout")
 
     return parser.parse_args()
 
 
-def log(output, msg):
+def log(output, msg, quiet):
     if output:
         output.write(msg + "\n")
         output.flush()
-    else:
+    elif not quiet:
         print(msg)
 
 
@@ -91,7 +93,7 @@ def log(output, msg):
             cmd = f'{args.qemu} {args.qargs} -g {socket_name}{suspend}' \
                 f' {args.binary}'
 
-        log(output, "QEMU CMD: %s" % (cmd))
+        log(output, "QEMU CMD: %s" % (cmd), args.quiet)
         inferior = subprocess.Popen(shlex.split(cmd))
 
     # Now launch gdb with our test and collect the result.
@@ -117,7 +119,7 @@ def log(output, msg):
 
 
     sleep(1)
-    log(output, "GDB CMD: %s" % (gdb_cmd))
+    log(output, "GDB CMD: %s" % (gdb_cmd), args.quiet)
 
     gdb_env = dict(os.environ)
     gdb_pythonpath = gdb_env.get("PYTHONPATH", "").split(os.pathsep)
-- 
2.34.1


