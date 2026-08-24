Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC01C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNZT-0002JP-Jx; Mon, 24 Aug 2026 01:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYy-0001qC-Ul
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:42 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYx-00023m-C7
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:40 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-cbedda4c154so1805536a12.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550578; x=1788155378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xN0xQN5mdER04LVt6luBkNx814GvD/i+FtKZY4I0s/E=;
 b=EXdGEMuaGghiZjQ9+i2Wu9eTmYswbIm0yv/sxt8Ka51CPHBbN560VcAvm7CX5NYJ3f
 94wj/oa+eXjyuoJ8VBYiCqpkmjrBy7fUuiJQWFPLeWlujwqV7yXmEJzcnW6BjYO3Z+Tg
 IsHR2/2i5zTO1uB8G6Ws9c5jocJP2grYDF/dNsaaQSDVcZWsaKGkmJ9FP5EnEVwN4ZHR
 1eFQEUPayy431sqXk+KxwwMlwkxQ8yQKiUrzD/e/Hn/PmFoTLtrplTwLMw7qgMkf8d32
 eyL77RU0zMqXw0yXkdBhujeVdchxsSmdAfyb1pbmqvjxW8/NGnRHTw7Z9sgYpIPv80Hc
 Kseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550578; x=1788155378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xN0xQN5mdER04LVt6luBkNx814GvD/i+FtKZY4I0s/E=;
 b=rFBI8RxRIuNzbbLmGolJ775ROscRkrsANH/EkBXsj5SZyxgEpoqOkUNTvADO4Sc9lG
 mr5wCevOvlnNYdaWeYJSPOyImL0L2ADgqStaJw8tfjTTi9kZTAWNsO5O5f4Du+mGyteQ
 j7B71WBbKVnPwwAOABcHj7nFIuKymqBFD+F7eIZG5nKl/8o2v/ZdPRW97dmeBO+klAFW
 ZDqu83V9qHbhZUjLdcKVjjpAs0rU+8XyGmsYkG/ktDUzAV74ezI53A2Ib3jfUkSAbl8K
 ejnVKUNqPDKfmmHY4scFuCrZnjsMISqg3NMlGRYwP3qUMzIWiKhjKqwspiE5QfjnoSIV
 qOcQ==
X-Gm-Message-State: AFuF++mwNa8lTJqiPbCKGumuCBmwp26VkP51JBetbRUQ5UGuVckNZGyj
 MMOQuWYGAkUv/nH040pEOKxJxz3J+36vldoNYxCqtlz2bWcQ47g2+rWwDg0p2g==
X-Gm-Gg: AR+sD105g6LYD1IS8d3wQKL0G/HnFVDHjftqm4UpHuH4Bw1b9oRgQBp6U/D880JZIvQ
 nB7VC+FTDrKxrWFKedfiHzN8GNSzZRli6JJAaOEvSX+ctqKQXmE2qcdJTU8TowoAQB8gBpFLTak
 ApCz2+bKTze5Ur/OSsDgaS2t9hXFYqmum7i44/exhdDZ9Fj1+fHLkR53XWUJzaMzYGJheD7OU0Z
 B6tU8BCKj+tnjAIS+5RtDUj0jaVUR6YUVT9yXSZy6ItkwddVbl6FKIFyG2Dws0hH53chZw08z7D
 o31ANrGFVPmf/Gr5OHCmLvDFygccvF6m9zh8Txe+oxFEAuyxhWKb7PjlZpDTJNo0WhNYchWGURJ
 l8w9wV35mha2Nep2jLyr1Bxs9RjGomMFfyrMY6ZBexwF9QQY8Tq1gQaNaaAECmQXKHM3l8rnFha
 vuuWRED/qPaxbiS9SXJ8yZ4qwnDeIQHOPCkHZknzrI+tZ6gkI7W5kOCwJic0I0YkApwD8VBxhsy
 cUBZg==
X-Received: by 2002:a17:90b:5646:b0:381:28e0:6259 with SMTP id
 98e67ed59e1d1-395c36fb278mr45522695a91.9.1787550577873; 
 Sun, 23 Aug 2026 22:49:37 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:49:36 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Ivan Efremov <nendensu@ispras.ru>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 25/96] tests/qtest: Add seed CSR zero extension test
Date: Mon, 24 Aug 2026 15:46:55 +1000
Message-ID: <20260824054806.2790041-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Ivan Efremov <nendensu@ispras.ru>

Add a qtest that reads the seed CSR on RV64 machine with Zkr support
and verifies that the upper 32 bits are clear.

Signed-off-by: Ivan Efremov <nendensu@ispras.ru>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260802113130.7818-3-nendensu@ispras.ru>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/riscv-csr-test.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/qtest/riscv-csr-test.c b/tests/qtest/riscv-csr-test.c
index bb1b0ffed3..7479a5c5bc 100644
--- a/tests/qtest/riscv-csr-test.c
+++ b/tests/qtest/riscv-csr-test.c
@@ -20,6 +20,12 @@
 #define CSR_MVENDORID       0xf11
 #define CSR_MISELECT        0x350
 
+#define CSR_SEED           0x015
+
+#define SEED_OPST_MASK     (UINT64_C(0x3) << 30)
+#define SEED_OPST_ES16     (UINT64_C(0x2) << 30)
+#define SEED_OPST_DEAD     (UINT64_C(0x3) << 30)
+
 static void run_test_csr(void)
 {
     uint64_t res;
@@ -46,12 +52,32 @@ static void run_test_csr(void)
     qtest_quit(qts);
 }
 
+static void run_test_seed_csr(void)
+{
+    uint64_t val = 0;
+    uint64_t opst;
+    QTestState *qts;
+
+    qts = qtest_init("-machine virt -cpu tt-ascalon");
+
+    qtest_csr_call(qts, "get_csr", 0, CSR_SEED, &val);
+
+    opst = val & SEED_OPST_MASK;
+    g_assert_true(opst == SEED_OPST_ES16 ||
+                  opst == SEED_OPST_DEAD);
+
+    g_assert_cmphex(val >> 32, ==, 0);
+
+    qtest_quit(qts);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
     if (qtest_has_machine("virt")) {
         qtest_add_func("/cpu/csr", run_test_csr);
+        qtest_add_func("/cpu/csr/seed", run_test_seed_csr);
     }
 
     return g_test_run();
-- 
2.54.0


