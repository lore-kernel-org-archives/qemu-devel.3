Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F492CA101C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 15:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuCBX-0004pa-6Q; Thu, 04 Sep 2025 11:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uuCBE-0004k9-Aj
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 11:47:22 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uuCB6-0008IP-B8
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 11:47:18 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-544af5b745cso788538e0c.0
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757000827; x=1757605627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJUU2u1tzC1eXmbzNgouEyqDdukQnt6LnrP8qMtdLmo=;
 b=Dy1lhViLudkXBhvcAKfRz/usZITdTfbfODnoOoDSSBhZhoCS7JisgdrfW+T20py/2t
 9ScTvgM+e6l2uP1g7RipTYwCWdLnOPyITgwwwP/QuPZYntxayMD8HHujHMebneFwfJIS
 kc3MWXSd4j73aj0SjBOw0RyiteluWcfKf7fj44ReSsAKgfjoTcDHF2/8qfpnFCmh0J/h
 P1LVm7O4+ar08Mo1IdxF7Izi/YrgISJ2OW9ojGosNLnbU3DBJGxWrypxOW3CQfm4vc09
 0EmvRwee2ZWnuDgL5RJmhrQieETAfCBz+uI41I4K3mCuoYziiaHuQ2b/JyUxBbZYPbqR
 TssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757000827; x=1757605627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hJUU2u1tzC1eXmbzNgouEyqDdukQnt6LnrP8qMtdLmo=;
 b=fQ/J/Fz8NUFxIhEK7KbiM9gsq4qdLVb7qF+kG4uir/gqyhoU2d0SPx1iVWKniOnqto
 XIRbpFz9dzPmuS3LGcTAPVpCOTd7hzVJXErklK0fbAzeRyKky1iVrrQHpWRq/yovF6pg
 M2RJAuDPOFNN+/Rf2F6R4Ta6/MPyGAGPdxKkkj3M3ULsEQc7KUtvqvnvxhtTIj5RtFSj
 64ilbjOl44TX5LWj0u8w1EajkKzN34d6XstZqFRO21EKzmaX+yqHEd2gYHp6h0+ey+Mn
 GbYdCbsR89K2D15kj2CQUy/K0Y0gKrX3jYg+QONNuejlyA4GSx9JP+MboLr2QpF9m0X9
 vmvw==
X-Gm-Message-State: AOJu0Yz32CQzsOVLImtE8EdK5zdxOnh8MvpNGJFwKyWcS6Qdg91EC+L1
 yy7t58c9ooroi3FrCFpds/1A0qdX//iPKq04kx9X0laZem3tgzF5alFo8Tb1BGta0AZJUj3jkYA
 eKaClsO60Ig==
X-Gm-Gg: ASbGncvtNdF+2/E+qUwQ15wnXD7btdnCTUKdhZba0aXetX8S0VTJyD+PQaKsXxMoBqd
 zu3WxRvn3RSQUBBQbeXIVI8W+2GoJNcIkCNmXx9A7VxTsMKa0W6zgYxWQKGVqzeL3anco9X84NR
 Pij7tb6MwaR6K9Q1CoN6EhS0j36IKOwWCIMXdcbkF3OBeSYHvNQ/BW6czzeL9oCTce4xNU8f4nn
 kb07vQ0Dp4OlVodVEfn0u3i8LEPvM5bHia8Ftmbppv22JQaRjAIenigffCwbu0DYmaDXIizYeHd
 GmKD5C125OynurOVfHfYN4j6IdhCQjh96aNW+Iwza8uDQPZh6uHI0qw3lgZIUta9oW9fw97iV2H
 0c/SZD1PFUOPQhNR3VoxTEFSkQ5opVVi4xzsOLOQ=
X-Google-Smtp-Source: AGHT+IESD09FhaRWqFv/jDR5+zmzGS0I7CeSClFxHhefAuOcy70hbViiiCCMNb2+oYX6IZDbKF01/g==
X-Received: by 2002:a05:6122:3d08:b0:545:eca2:1c7e with SMTP id
 71dfb90a1353d-545eca22169mr688729e0c.0.1757000826773; 
 Thu, 04 Sep 2025 08:47:06 -0700 (PDT)
Received: from gromero0.. ([186.215.58.133]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-544a666da0csm6497022e0c.28.2025.09.04.08.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 08:47:06 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org,
	1844144@gmail.com,
	gustavo.romero@linaro.org
Subject: [PATCH v2 2/5] tests/guest-debug: Format comments
Date: Thu,  4 Sep 2025 15:46:37 +0000
Message-Id: <20250904154640.52687-3-gustavo.romero@linaro.org>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Capitalize and add periods to comments.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/guest-debug/run-test.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index d21a5dda77..e051e8947c 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -54,7 +54,7 @@ def log(output, msg):
 if __name__ == '__main__':
     args = get_args()
 
-    # Search for a gdb we can use
+    # Search for a gdb we can use.
     if not args.gdb:
         args.gdb = shutil.which("gdb-multiarch")
     if not args.gdb:
@@ -94,22 +94,22 @@ def log(output, msg):
         log(output, "QEMU CMD: %s" % (cmd))
         inferior = subprocess.Popen(shlex.split(cmd))
 
-    # Now launch gdb with our test and collect the result
+    # Now launch gdb with our test and collect the result.
     gdb_cmd = args.gdb
     if args.binary:
         gdb_cmd += " %s" % (args.binary)
     if args.gdb_args:
         gdb_cmd += " %s" % (args.gdb_args)
-    # run quietly and ignore .gdbinit
+    # Run quietly and ignore .gdbinit.
     gdb_cmd += " -q -n -batch"
-    # disable pagination
+    # Disable pagination.
     gdb_cmd += " -ex 'set pagination off'"
-    # disable prompts in case of crash
+    # Disable prompts in case of crash.
     gdb_cmd += " -ex 'set confirm off'"
-    # connect to remote
+    # Connect automatically to remote only if QEMU is launched.
     if args.qemu:
         gdb_cmd += " -ex 'target remote %s'" % (socket_name)
-    # finally the test script itself
+    # Finally the test script itself.
     if args.test:
         argv = [args.test] + args.test_args
         gdb_cmd += f" -ex \"py sys.argv={argv}\""
-- 
2.34.1


