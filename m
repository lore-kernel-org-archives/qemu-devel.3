Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156E7C3DA7E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVvZk-0004pU-Sm; Mon, 22 Jul 2024 12:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sVvZZ-0004hi-U4
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:07:38 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sVvZY-0007eH-07
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:07:37 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fd66cddd07so19100695ad.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 09:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721664453; x=1722269253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pcell0MRaFDFSI4iiBTc3IYNF1B/5BVQzfL7iLBoEns=;
 b=BfOmtheKYokTvSpqyisaCna6zq5wYW4zeZiwNcjz6VYBBST4pCyAF5LAbrbEQ615yi
 ddqGicJ82Rml3WETrK/2E7ZMKs4mj25IVGdOPx1Pc+ng31wIRJypJ90e9rbC7I6DA2By
 qIobCT4HCA24BSV5dq3r/Qzh9bajclPIOcWte/bbsB5wKZmftgnysJemJd+Nx4ZI53bY
 e5DK6565Fdhy8P0XBtuC/HTQFIetcEVOrkrSjz/o8XGzn0y2J6Q1iCx91ZHuorfaXG4y
 54pn38M8PyVvuJ2zvTX06L35dgGcJNXFlgqh7sZqH/u45IuhjG+0zYhg23cZEdybJt3q
 PXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721664453; x=1722269253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pcell0MRaFDFSI4iiBTc3IYNF1B/5BVQzfL7iLBoEns=;
 b=R5XgyuSxlKdpY1XZ7QRy9ra+hYJU7wwnS/ywDfxAR5ufxSAssM0sGCAyQzBG/82dqt
 plYkdPYqaX5SpJQCSZN8OzyqAOHcbS9JOACBTST6BfExfMnOdz1bSnsB4wGzzEa/nomI
 3DakXOHRrohOoEYLpycvg1vpXlGW4ilXhpagIIsfbjm5C98gS85iFTy4cupbdnCPtgGc
 hSPscdPsI4wtuhxFXP1TfGfTgVlc0bux49/MfOurYn4vjI2QQ/eE1e/MMGVpReZczqkd
 R4pHNqoFZX+ckkxHlZgdkmTJdbbBA+a/aDYFzctt4fa2lgyz3CSlS6I7dY5uOmJ+9wVn
 3wjA==
X-Gm-Message-State: AOJu0YwlH1LP4tKqPPYQ7J7CjyzT7YFiNLVoa5Y2xQ/3vverbaTDz8uZ
 llbAzmoKAgY45BVWEHceBz1xEIDcfmBJft8RbeUwPr532pPSQwWeusxofCepsPPEEMzQleDyr12
 X
X-Google-Smtp-Source: AGHT+IGvZpdQsZM3JQdLa9m0azY8LdW1CcylmlytsamuBEHh1TrAg1kEJEHiBZiEs6h9E/t7idVN8A==
X-Received: by 2002:a17:902:e84a:b0:1fc:6acd:1ecf with SMTP id
 d9443c01a7336-1fdb5fae0f2mr2001145ad.65.1721664453120; 
 Mon, 22 Jul 2024 09:07:33 -0700 (PDT)
Received: from amd.. ([2804:7f0:b402:9243:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f2ac8eesm56533165ad.118.2024.07.22.09.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 09:07:32 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH 3/4] tests/guest-debug: Support passing arguments to the GDB
 test script
Date: Mon, 22 Jul 2024 16:07:08 +0000
Message-Id: <20240722160709.1677430-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722160709.1677430-1-gustavo.romero@linaro.org>
References: <20240722160709.1677430-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62b.google.com
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

This commit adds a new option to run-test.py, --test-args, which can
be used to pass arguments to the GDB test script specified by the --test
option. The arguments passed are in the key=value form, and multiple
pairs can be passed, separated by a space. For example:

run-test.py [...] --test <GDB_TEST_SCRIPT> --test-args v0="string" v1=10

The 'v0' and 'v1' variables will then be available in the GDB test
script, like this:

print(v0)
print(v1)

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/guest-debug/run-test.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index 368ff8a890..63b55fb8bd 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -27,6 +27,7 @@ def get_args():
     parser.add_argument("--binary", help="Binary to debug",
                         required=True)
     parser.add_argument("--test", help="GDB test script")
+    parser.add_argument("--test-args", help="Arguments to GDB test script")
     parser.add_argument("--gdb", help="The gdb binary to use",
                         default=None)
     parser.add_argument("--gdb-args", help="Additional gdb arguments")
@@ -91,6 +92,9 @@ def log(output, msg):
     gdb_cmd += " -ex 'target remote %s'" % (socket_name)
     # finally the test script itself
     if args.test:
+        if args.test_args:
+            test_args = args.test_args.replace(" ",";")
+            gdb_cmd += f" -ex 'py {test_args}'"
         gdb_cmd += " -x %s" % (args.test)
 
 
-- 
2.34.1


