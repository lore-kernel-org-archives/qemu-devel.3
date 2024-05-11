Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D1FC25B5F
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 11:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5lIp-0000IK-IU; Sat, 11 May 2024 07:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIo-0000HM-67
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:10 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIm-0006xN-8a
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:09 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-34e0d8b737eso2208509f8f.1
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 04:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715428447; x=1716033247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3X3XgI50snZLtrZ7HC0OWfW96V7yOplWwRGvCG/f16A=;
 b=oy7HA8sTwvYL1PsdUzrbFRMI7a8Ha8FeajpE9YJSLELz4Td8NtGJu1ONBbLLGQ2InN
 zAkerhVN44JSrmBHF8YOfBavNphAT1l9KBF10xzRrifam07w7uhuWlR6OiHQI8o3WqVt
 wPxvmLxi0W4gFPuWclEzDcUIBHmihIxenzl5DOdu1t6lH1/OT/DZC6TI4DtsYa7P7Ezo
 pNV/NM65synx3Z25l+Ac42AHB9EC4lUnv2ooZyfYGg2L0C52ABhVudm4Bom1Kcuo0qpu
 Jo5/v8YD3awYVdlS1TaQpwdJE6RdutbPaRU+RidGhOhQoSHy3RgzOeQvobRSD9eC9EUJ
 hXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715428447; x=1716033247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3X3XgI50snZLtrZ7HC0OWfW96V7yOplWwRGvCG/f16A=;
 b=SsGj1Zf1e+dArXI46O3gUKxd01rq1OuVYvFR6F+UmP6Ct7Z4B7g1p+ZdK+o7wARCwI
 5E82rNyl5nIWemjiV1PfXWV0w0Ip6fVjsLUEbK3I25E/VBB7eMJLS/Nle6L3jQPM7Fss
 qTDGOPwhc6SiTEPJ/TJDeDpmH9jtf5t7y+NNB9WymgV/AMzxPuJY5nccFbaNdVpXGHYh
 h441ndNO+ygSauBYW0sVadZYnR5xxmDMWZeNyaydp4p/pubSSe/Yo34R1knr/F96rYkM
 smGfZND5SjQY6/MO3HhY6hMRYjjZDraNeQl6U0rzeUBePxV3UT4hme3rTW0B59qOCymV
 80kA==
X-Gm-Message-State: AOJu0Yw9xxsDAJZ/3Vw8yZIgDD54EkiQGaqP3ZDx3yIoFFpX6/mw/GOy
 5gm4G4si21pGIbHxSNpXa1BvchLxgCOOfcHn4l/ZcMyfxUQt2oXvv2SbDKw17MLiazzVyk1lFDc
 bbL0=
X-Google-Smtp-Source: AGHT+IHlPmGlJB4Ek5LziByD919uV0aCe4JyvBFsNrP2+MClxLY+3S8+I1TVmYuYxXjh90ZP8bpuLg==
X-Received: by 2002:a5d:6a42:0:b0:34d:d5e5:6816 with SMTP id
 ffacd0b85a97d-35018113161mr6982872f8f.8.1715428446910; 
 Sat, 11 May 2024 04:54:06 -0700 (PDT)
Received: from stoup.. ([195.76.196.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbf20sm6764797f8f.93.2024.05.11.04.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 04:54:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 04/17] Add --fulldump and --diffdup options
Date: Sat, 11 May 2024 13:53:47 +0200
Message-Id: <20240511115400.7587-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511115400.7587-1-richard.henderson@linaro.org>
References: <20240511115400.7587-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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

These allow the inspection of the trace files.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 102 insertions(+), 15 deletions(-)

diff --git a/risu.c b/risu.c
index 9c31b8c..c28b4a5 100644
--- a/risu.c
+++ b/risu.c
@@ -483,23 +483,101 @@ static int apprentice(void)
     }
 }
 
-static int ismaster;
+static int dump_trace(bool isfull)
+{
+    RisuResult res;
+    int tick = 0;
+
+    while (1) {
+        struct reginfo *this_ri;
+
+        this_ri = &ri[tick & 1];
+        res = recv_register_info(this_ri);
+
+        switch (res) {
+        case RES_OK:
+            switch (header.risu_op) {
+            case OP_COMPARE:
+            case OP_TESTEND:
+            case OP_SIGILL:
+                printf("%s: (pc %#lx)\n", op_name(header.risu_op),
+                       (unsigned long)header.pc);
+
+                if (isfull || tick == 0) {
+                    reginfo_dump(this_ri, stdout);
+                } else {
+                    struct reginfo *prev_ri = &ri[(tick - 1) & 1];
+
+                    if (reginfo_is_eq(prev_ri, this_ri)) {
+                        /*
+                         * ??? There should never be no change -- at minimum
+                         * PC should have advanced.  But for completeness...
+                         */
+                        printf("change detail: none\n");
+                    } else {
+                        printf("change detail (prev : next):\n");
+                        reginfo_dump_mismatch(prev_ri, this_ri, stdout);
+                    }
+                }
+                putchar('\n');
+                if (header.risu_op == OP_TESTEND) {
+                    return EXIT_SUCCESS;
+                }
+                tick++;
+                break;
+
+            case OP_COMPAREMEM:
+                /* TODO: Dump 8k of data? */
+                /* fall through */
+            default:
+                printf("%s\n", op_name(header.risu_op));
+                break;
+            }
+            break;
+
+        case RES_BAD_IO:
+            fprintf(stderr, "I/O error\n");
+            return EXIT_FAILURE;
+        case RES_BAD_MAGIC:
+            fprintf(stderr, "Unexpected magic number: %#08x\n", header.magic);
+            return EXIT_FAILURE;
+        case RES_BAD_SIZE:
+            fprintf(stderr, "Unexpected payload size: %u\n", header.size);
+            return EXIT_FAILURE;
+        case RES_BAD_OP:
+            fprintf(stderr, "Unexpected opcode: %d\n", header.risu_op);
+            return EXIT_FAILURE;
+        default:
+            fprintf(stderr, "Unexpected recv result %d\n", res);
+            return EXIT_FAILURE;
+        }
+    }
+}
+
+enum {
+    DO_APPRENTICE,
+    DO_MASTER,
+    DO_FULLDUMP,
+    DO_DIFFDUMP,
+};
+
+static int operation = DO_APPRENTICE;
 
 static void usage(void)
 {
     fprintf(stderr,
-            "Usage: risu [--master] [--host <ip>] [--port <port>] <image file>"
-            "\n\n");
-    fprintf(stderr,
-            "Run through the pattern file verifying each instruction\n");
-    fprintf(stderr, "between master and apprentice risu processes.\n\n");
-    fprintf(stderr, "Options:\n");
-    fprintf(stderr, "  --master          Be the master (server)\n");
-    fprintf(stderr, "  -t, --trace=FILE  Record/playback " TRACE_TYPE " trace file\n");
-    fprintf(stderr,
-            "  -h, --host=HOST   Specify master host machine (apprentice only)"
-            "\n");
-    fprintf(stderr,
+            "Usage: risu [--master|--fulldump|--diffdump]\n"
+            "            [--host <ip>] [--port <port>] <image file>\n"
+            "\n"
+            "Run through the pattern file verifying each instruction\n"
+            "between master and apprentice risu processes.\n"
+            "\n"
+            "Options:\n"
+            "  --master          Be the master (server)\n"
+            "  --fulldump        Dump each record\n"
+            "  --diffdump        Dump difference between each record\n"
+            "  -t, --trace=FILE  Record/playback " TRACE_TYPE " trace file\n"
+            "  -h, --host=HOST   Specify master host machine\n"
             "  -p, --port=PORT   Specify the port to connect to/listen on "
             "(default 9191)\n");
     if (arch_extra_help) {
@@ -511,7 +589,9 @@ static struct option * setup_options(char **short_opts)
 {
     static struct option default_longopts[] = {
         {"help", no_argument, 0, '?'},
-        {"master", no_argument, &ismaster, 1},
+        {"master", no_argument, &operation, DO_MASTER},
+        {"fulldump", no_argument, &operation, DO_FULLDUMP},
+        {"diffdump", no_argument, &operation, DO_DIFFDUMP},
         {"host", required_argument, 0, 'h'},
         {"port", required_argument, 0, 'p'},
         {"trace", required_argument, 0, 't'},
@@ -519,7 +599,7 @@ static struct option * setup_options(char **short_opts)
     };
     struct option *lopts = &default_longopts[0];
 
-    *short_opts = "h:p:t:";
+    *short_opts = "d:h:p:t:";
 
     if (arch_long_opts) {
         const size_t osize = sizeof(struct option);
@@ -551,6 +631,7 @@ int main(int argc, char **argv)
     struct option *longopts;
     char *shortopts;
     stack_t ss;
+    bool ismaster;
 
     longopts = setup_options(&shortopts);
 
@@ -586,6 +667,8 @@ int main(int argc, char **argv)
         }
     }
 
+    ismaster = operation == DO_MASTER;
+
     if (trace) {
         if (strcmp(trace_fn, "-") == 0) {
             comm_fd = ismaster ? STDOUT_FILENO : STDIN_FILENO;
@@ -609,6 +692,10 @@ int main(int argc, char **argv)
         }
     }
 
+    if (operation == DO_FULLDUMP || operation == DO_DIFFDUMP) {
+        return dump_trace(operation == DO_FULLDUMP);
+    }
+
     imgfile = argv[optind];
     if (!imgfile) {
         fprintf(stderr, "Error: must specify image file name\n\n");
-- 
2.34.1


