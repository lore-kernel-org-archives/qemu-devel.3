Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BECD49797
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 09:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIP6o-0005ae-QJ; Tue, 03 Dec 2024 04:22:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIP6n-0005a0-4m
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:22:17 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIP6k-0002ff-Gy
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:22:16 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d0c8ba475bso3826688a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 01:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733217732; x=1733822532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C/6Bk/TIHmUcRxz6rQ6nK013EsFPgzobZnpt1ORjNTg=;
 b=cYaHDsbdPt5Aii7fBNAv+qewQZs6lj/bKjf9ZbvTCnjOvFFDIDWBMZ+iixq+eeXA9t
 MPt9jb9ewjWfcUrza/Dod4CWlPLl8geOPCn0vtOloqImT8LJHyJxLf41TYlU5RxPpuuH
 EWh3dW8dS0TqtWkIKw84b/ywc502ZOfImz4CB8DX9dQt3ZffGfkHUfLfHKWSGAk4UT2y
 5SoG4lUdoqDdqsbXkBtQWAuljz01MpGfLC8LZ3KyX4nZFQC6qD9o8jYbXxO4zvMaFazZ
 qHBbsB2mxPefq6+RbxJYongeKnW52AmZFK9SNHpZ3diC5MHEAaMJn9Yuv3AApJwuOhS1
 NAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733217732; x=1733822532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C/6Bk/TIHmUcRxz6rQ6nK013EsFPgzobZnpt1ORjNTg=;
 b=G2jDAjXJadQ3nSuPqZU9+iy7gk7Jw3YTottlI3/SAbq4u5qg8OfVG8uUhNZQTXS18+
 Q+HO144djj5gHlG1DeJ+WAOiEt2XbjGbx+tp9nwSb92vT/BQKkPdEbXDN8SJPBheGwef
 EsoOtWoWX54URR0qlMCix8CRegyW6+Hd0sZUnYfaWxUKJDdSd1XVpGnCaAm8E7FQoal7
 5wY3eIX/luyfNAI2VPxJGDDJ99/4BrybfemBSbftUsu/aeHQeRVCWUJWyy66PGv2r1JH
 EvSpyWpXf1ulMRfyUDl7IOXTG07TbMwJKH+c0XrWcjVUTqIUICsOs6EvvQ0v/06E7Nbd
 QAYQ==
X-Gm-Message-State: AOJu0Yyl5zpvgrH/KKKnO9hHlcz7dodDkbEt+bJiMDxRf7FOyGLAwdCV
 NoXYJHGgA3PLK98gBEetHsIElHZGH442WUdZ5DF4YMUj5KDtjICIlu+0w7YQjSjySPqLRmfYI8n
 Mt/c=
X-Gm-Gg: ASbGncvcNUR0C8UfbXdKR+hlL3tatWk4NjrPqfmZKKEj3xeDSsyROxxQSaSGxUKArdX
 +2je87Tw8L8pZaACwMc4P6RdhyvM6LKKnT4r0eF5P5UT1RwFl9yHvWMi27RpYHNR1temGS2AeXi
 yjPcqDB4qU5HZZWyzQJvuAhCiVRHMH2AUXjcLQtckEgyW4w9PvnkDBBXuaux5CKvzaqNklPzKt8
 rGl7g1ubYyTkf+w1nHqAzC+u3ZYDpBJ8mzz/0ezop1dIpXFoy7Dy3/baciWti63u6PwEtgJ
X-Google-Smtp-Source: AGHT+IHoObOZjdwlMr3aboz/4y2YVDb50eN7RHCCjr/fwpXa6yi9c/pFOSALP0ifpRtK2osZHvNbbA==
X-Received: by 2002:a17:906:30cb:b0:aa5:297a:ac65 with SMTP id
 a640c23a62f3a-aa5f7d4ec91mr122028566b.19.1733217732604; 
 Tue, 03 Dec 2024 01:22:12 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa599801591sm590543266b.91.2024.12.03.01.22.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 01:22:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/7] tests/qtest/fuzz: Remove legacy '-machine foo,accel=bar'
Date: Tue,  3 Dec 2024 10:21:49 +0100
Message-ID: <20241203092153.60590-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203092153.60590-1-philmd@linaro.org>
References: <20241203092153.60590-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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
fuzzer scripts and tests.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/fuzz/generic_fuzz.c                | 2 +-
 tests/qtest/fuzz/i440fx_fuzz.c                 | 2 +-
 tests/qtest/fuzz/qos_fuzz.c                    | 2 +-
 scripts/oss-fuzz/output_reproducer.py          | 2 --
 scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py | 6 +++---
 5 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index d107a496da6..a8737a4c463 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -919,7 +919,7 @@ static GString *generic_fuzz_cmdline(FuzzTarget *t)
         usage();
     }
     g_string_append_printf(cmd_line, " -display none \
-                                      -machine accel=qtest, \
+                                      -accel qtest \
                                       -m 512M %s ", getenv("QEMU_FUZZ_ARGS"));
     return cmd_line;
 }
diff --git a/tests/qtest/fuzz/i440fx_fuzz.c b/tests/qtest/fuzz/i440fx_fuzz.c
index 155fe018f80..b5487996625 100644
--- a/tests/qtest/fuzz/i440fx_fuzz.c
+++ b/tests/qtest/fuzz/i440fx_fuzz.c
@@ -145,7 +145,7 @@ static void i440fx_fuzz_qos(QTestState *s,
     pciconfig_fuzz_qos(s, bus, Data, Size);
 }
 
-static const char *i440fx_qtest_argv = TARGET_NAME " -machine accel=qtest"
+static const char *i440fx_qtest_argv = TARGET_NAME " -accel qtest"
                                        " -m 0 -display none";
 static GString *i440fx_argv(FuzzTarget *t)
 {
diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
index d3839bf9994..9267e63889d 100644
--- a/tests/qtest/fuzz/qos_fuzz.c
+++ b/tests/qtest/fuzz/qos_fuzz.c
@@ -84,7 +84,7 @@ static GString *qos_build_main_args(void)
     }
     /* Prepend the arguments that we need */
     g_string_prepend(cmd_line,
-            TARGET_NAME " -display none -machine accel=qtest -m 64 ");
+            TARGET_NAME " -display none -accel qtest -m 64 ");
     return cmd_line;
 }
 
diff --git a/scripts/oss-fuzz/output_reproducer.py b/scripts/oss-fuzz/output_reproducer.py
index e8ef76b3413..840da3b5a5b 100755
--- a/scripts/oss-fuzz/output_reproducer.py
+++ b/scripts/oss-fuzz/output_reproducer.py
@@ -64,8 +64,6 @@ def c_reproducer(name, args, trace):
 
     # libqtest will add its own qtest args, so get rid of them
     args = args.replace("-accel qtest","")
-    args = args.replace(",accel=qtest","")
-    args = args.replace("-machine accel=qtest","")
     args = args.replace("-qtest stdio","")
     result.append("""QTestState *s = qtest_init("{}");""".format(args))
     for l in trace.splitlines():
diff --git a/scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py b/scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
index b154a25508f..f3813944d3b 100755
--- a/scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
+++ b/scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
@@ -5,15 +5,15 @@
 Use this to convert qtest log info from a generic fuzzer input into a qtest
 trace that you can feed into a standard qemu-system process. Example usage:
 
-QEMU_FUZZ_ARGS="-machine q35,accel=qtest" QEMU_FUZZ_OBJECTS="*" \
+QEMU_FUZZ_ARGS="-machine q35 -accel qtest" QEMU_FUZZ_OBJECTS="*" \
         ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=generic-pci-fuzz
 # .. Finds some crash
 QTEST_LOG=1 FUZZ_SERIALIZE_QTEST=1 \
-QEMU_FUZZ_ARGS="-machine q35,accel=qtest" QEMU_FUZZ_OBJECTS="*" \
+QEMU_FUZZ_ARGS="-machine q35 -accel qtest" QEMU_FUZZ_OBJECTS="*" \
         ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=generic-pci-fuzz
         /path/to/crash 2> qtest_log_output
 scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py qtest_log_output > qtest_trace
-./i386-softmmu/qemu-fuzz-i386 -machine q35,accel=qtest \
+./i386-softmmu/qemu-fuzz-i386 -machine q35 -accel qtest \
         -qtest stdio < qtest_trace
 
 ### Details ###
-- 
2.45.2


