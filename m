Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52007CD1288
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 19:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsTBf-0003aH-PI; Thu, 04 Apr 2024 15:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsTBe-0003a8-9v
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:55:50 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsTBc-00029A-L5
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:55:50 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41627acfd03so9094605e9.3
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 12:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712260546; x=1712865346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s5hIihND0dsf9z9poWK5+DgIi8r9oQc5ysXPqjISFuw=;
 b=bllm8hjTUnqAECg6B8fjEGYv0DL9OEFOn/HlBSTYf4KUZXC21uvWrzh1Q7xg5uOnHA
 xINORvZo/6zUFTOR7LPxp+GD1alBCS8/l5gGConHQQiIyrcT2hvoPsqdAxcwSyCtfz9U
 ajl0iLCci5+rpgGbguApq410qjIfKt9eqJbkc5pVOkDb6Q/VJuHGAR1FXT2RiaWG+XjZ
 cBj9QJschFwImX8fAlzgQgkuMVO4cnK1d+7seQ6hAwZXF4gQiEGWUYTxnFo4xZ4TuymL
 DO0VPd0zkiQNdtvif3TAmlQJ/PISt4f202Vx20khXsudW1roZKcKsJ4tA8GVsCiOFd90
 ab7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712260546; x=1712865346;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s5hIihND0dsf9z9poWK5+DgIi8r9oQc5ysXPqjISFuw=;
 b=VTuxa9jmWttjtW+KzmPxI/Z3aljjVfX+6D2Jbq+5UCLFReE8slVHgM9M67iUsJFBh+
 DH1pSw/Gw5+LjWWYNvgNRfZ8DxzPptFdQq3wVDrXZuJdg876oerM4ENEyvT0YE+SKD2j
 6BJ0RagA/ctKwipkGFd/tHebwMzyO7TrKrJSFf6IwKFJeY6ts8k9WHtg2homDWE4bzEa
 AZf5nangYMSO2PTbks41xAQPX02Nn0V2LIj1GtzY7DhabgMo20H50j7UGTPq/rn3Jn0F
 8oHD5V29wrVNTslD6W1j4uevh/7azDPn2a4kIFmCVmpD8bhYsuhNvCywdQLlpDJlQVSe
 Ws6g==
X-Gm-Message-State: AOJu0YykS1q9hsB7E9mMxm3Re+oVN2IqVbpOaKewcvhJeSsHt7YLJjXc
 8Sw82sQpEA4nlV4Uxe9vt2tyd4adIrXNgHRxB0mc6yk2kHRrOJhnDqJdDgFVnc/f1PdGPo3pbp4
 6
X-Google-Smtp-Source: AGHT+IF/RmKNiYeV0DduMQPGbEHu3fvbRDreTJ24TbRRJCvir0Jy/Hg627XRVK9TdFZQIE5D2U0+BQ==
X-Received: by 2002:a05:600c:5812:b0:416:2c78:5ecc with SMTP id
 jz18-20020a05600c581200b004162c785eccmr1013557wmb.36.1712260546249; 
 Thu, 04 Apr 2024 12:55:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.216.111])
 by smtp.gmail.com with ESMTPSA id
 r10-20020a05600c35ca00b0041622c88852sm3794115wmq.16.2024.04.04.12.55.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Apr 2024 12:55:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1] qapi: Do not generate commands/events/introspect
 code for user emulation
Date: Thu,  4 Apr 2024 21:55:43 +0200
Message-ID: <20240404195543.9804-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

User emulation requires the QAPI types. Due to the command
line processing, some visitor code is also used. The rest
is irrelevant (no QMP socket).

Add an option to the qapi-gen script to allow generating
the minimum when only user emulation is being built.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: Quick PoC for Markus. It is useful for user-only builds.
---
 qapi/meson.build     |  6 +++++-
 scripts/qapi/main.py | 16 +++++++++++-----
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/qapi/meson.build b/qapi/meson.build
index 375d564277..5e02621145 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -115,10 +115,14 @@ foreach module : qapi_all_modules
   endif
 endforeach
 
+qapi_gen_cmd = [ qapi_gen, '-o', 'qapi', '-b', '@INPUT0@' ]
+if not (have_system or have_tools)
+  qapi_gen_cmd += [ '--types-only' ]
+endif
 qapi_files = custom_target('shared QAPI source files',
   output: qapi_util_outputs + qapi_specific_outputs + qapi_nonmodule_outputs,
   input: [ files('qapi-schema.json') ],
-  command: [ qapi_gen, '-o', 'qapi', '-b', '@INPUT0@' ],
+  command: qapi_gen_cmd,
   depend_files: [ qapi_inputs, qapi_gen_depends ])
 
 # Now go through all the outputs and add them to the right sourceset.
diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
index 316736b6a2..925af5841b 100644
--- a/scripts/qapi/main.py
+++ b/scripts/qapi/main.py
@@ -33,7 +33,8 @@ def generate(schema_file: str,
              prefix: str,
              unmask: bool = False,
              builtins: bool = False,
-             gen_tracing: bool = False) -> None:
+             gen_tracing: bool = False,
+             gen_types_only: bool = False) -> None:
     """
     Generate C code for the given schema into the target directory.
 
@@ -50,9 +51,10 @@ def generate(schema_file: str,
     schema = QAPISchema(schema_file)
     gen_types(schema, output_dir, prefix, builtins)
     gen_visit(schema, output_dir, prefix, builtins)
-    gen_commands(schema, output_dir, prefix, gen_tracing)
-    gen_events(schema, output_dir, prefix)
-    gen_introspect(schema, output_dir, prefix, unmask)
+    if not gen_types_only:
+        gen_commands(schema, output_dir, prefix, gen_tracing)
+        gen_events(schema, output_dir, prefix)
+        gen_introspect(schema, output_dir, prefix, unmask)
 
 
 def main() -> int:
@@ -75,6 +77,9 @@ def main() -> int:
     parser.add_argument('-u', '--unmask-non-abi-names', action='store_true',
                         dest='unmask',
                         help="expose non-ABI names in introspection")
+    parser.add_argument('-t', '--types-only', action='store_true',
+                        dest='gen_types_only',
+                        help="Only generate QAPI types")
 
     # Option --suppress-tracing exists so we can avoid solving build system
     # problems.  TODO Drop it when we no longer need it.
@@ -96,7 +101,8 @@ def main() -> int:
                  prefix=args.prefix,
                  unmask=args.unmask,
                  builtins=args.builtins,
-                 gen_tracing=not args.suppress_tracing)
+                 gen_tracing=not args.suppress_tracing,
+                 gen_types_only=args.gen_types_only)
     except QAPIError as err:
         print(err, file=sys.stderr)
         return 1
-- 
2.41.0


