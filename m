Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D301E7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWF0F-0001es-SZ; Fri, 10 Jan 2025 08:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEzB-0008RI-1s
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:38 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEz9-0005f8-B8
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:36 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28a4fccso2733735a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515414; x=1737120214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q/Yfg6c1cFjbQko7qYu/Ov/hB4K0kh3ZZP8RgyoDAoc=;
 b=siMBMLN3B1yKdD/fwvhAgg3nLA+c5SKtfESDoNl4OxsWXrfZfZhlTlj/OtTPwxNPz4
 /uqsu6g2bnqPvpbtvD0G7MGBl21jqa03abnwBPSZ67lQPrDnG1j1FgAHC3HUl7Ll84HV
 Zpums+Jb3RRDyQcKt+4pOgTYeP/Dl9o4S4ByUrU40PyyM6KakIS+2IMnWFQ8qsbdeCGJ
 KZRULq/ZTcpyxJIEOybIkTPATwB+QhiN1vA7SAM6Z2ZEngNXxhgsdM/4vaJk/slvp3fi
 /Z+V2TXGunfNF9RVuFgfgV7haFmKP7xyBPw5RekK9NguF5YgCu1Z4Stg0EagOSO3mNmB
 MU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515414; x=1737120214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q/Yfg6c1cFjbQko7qYu/Ov/hB4K0kh3ZZP8RgyoDAoc=;
 b=I9hRMmjZpQEHTXTD7PdsoTLQbsgSdJ2CB5CrCHUr2fq3YtWWGYQYMKo+fBFif0W5Pp
 ixIMxfYJWFYmblk6HU3tMFrGeNbyDzuQxXtzrRTjA/XwReQovovv6LxLBPRsqFsK1NiG
 fOzxNSOrfky2f8kYLK+30lc74bHdFf2AcVdMLN7XI/KE34J+dFRCwFxxiZ8Fk4JK3zSK
 umi1nWmYj9Nl1m601uj3wbpFKvDhOosqjH4sb6lZSPvl7OeNIahLczApQeitFgIGxXU1
 jMEELXfCt1PGudZvbecOcmP8890aK5H4Bnh1PctV/Ju2GbJZtdOyV2vY5VkG3mrSw6B5
 RKYw==
X-Gm-Message-State: AOJu0YyQZryG2OTFCPY01ASSDiNdowAjfxv3aSBUZSzB5jb5kuSakrCb
 cOPpG4czVtpw+ttrMe34A2SEja6+Jcml2V49D/NhBl/xI4qqoD+cbB6xcN/l4di1P47VNeHcuPA
 l8ro=
X-Gm-Gg: ASbGncvbk8/tlkqnkXXfJ1EsdZydN+zs9R0+6uaqyjE5EF409OPzFkrEkajOBSqf5ga
 T7/R8Edkun2mttnvvkZOwWI3xSH1I5hLCl/iVwY2Xn2w4qJXoQGpMZnJkujpdDtRLkBN2QhzVwW
 ooCaEcnOmLgRBPPL9lRABmXRGOrGIgbnYkuvHzlkN5LTQvlSwqMlNgau0iRmBb3mzcxIa9lOjs2
 kYp8GGpvkTfKQLIWSJ7SBHjzyNCo0aLpBjhhVVIW9XtaTzhNNE3VRU=
X-Google-Smtp-Source: AGHT+IHUUn6Fn7h8GC6DCitSd77jt09AAQ8QpQOIUtZ0yfBdFA6UjA//BNBv+E7vmU3WEG1gHmhhZA==
X-Received: by 2002:a05:6402:3483:b0:5d0:bde9:2992 with SMTP id
 4fb4d7f45d1cf-5d972e4e6f4mr9809247a12.26.1736515413658; 
 Fri, 10 Jan 2025 05:23:33 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9900c8ca8sm1679381a12.33.2025.01.10.05.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:23:31 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AE61E61853;
 Fri, 10 Jan 2025 13:17:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/32] tests/vm: allow interactive login as root
Date: Fri, 10 Jan 2025 13:17:51 +0000
Message-Id: <20250110131754.2769814-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

This is useful when debugging and you want to add packages to an
image.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-30-alex.bennee@linaro.org>

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index d80ca79a28..14188bba1c 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -66,6 +66,7 @@ endif
 	@echo "Special variables:"
 	@echo "    BUILD_TARGET=foo              - Override the build target"
 	@echo "    DEBUG=1                       - Enable verbose output on host and interactive debugging"
+	@echo "    ROOT_USER=1                   - Login as root user for interactive shell"
 	@echo '    EXTRA_CONFIGURE_OPTS="..."    - Pass to configure step'
 	@echo "    J=[0..9]*                     - Override the -jN parameter for make commands"
 	@echo "    LOG_CONSOLE=1                 - Log console to file in: ~/.cache/qemu-vm "
@@ -141,6 +142,6 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img $(VM_VENV)
 		$(if $(EFI_AARCH64),--efi-aarch64 $(EFI_AARCH64)) \
 		$(if $(LOG_CONSOLE),--log-console) \
 		--image "$<" \
-		--interactive \
+		$(if $(ROOT_USER),--interactive-root,-interactive) \
 		false, \
 		"  VM-BOOT-SSH $*") || true
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 6f3f2e76df..6d41ac7574 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -612,8 +612,11 @@ def get_default_jobs():
     parser.add_argument("--source-path", default=None,
                         help="Path of source directory, "\
                         "for finding additional files. ")
-    parser.add_argument("--interactive", "-I", action="store_true",
-                        help="Interactively run command")
+    int_ops = parser.add_mutually_exclusive_group()
+    int_ops.add_argument("--interactive", "-I", action="store_true",
+                         help="Interactively run command")
+    int_ops.add_argument("--interactive-root", action="store_true",
+                         help="Interactively run command as root")
     parser.add_argument("--snapshot", "-s", action="store_true",
                         help="run tests with a snapshot")
     parser.add_argument("--genisoimage", default="genisoimage",
@@ -675,6 +678,8 @@ def main(vmcls, config=None):
         exitcode = 3
     if args.interactive:
         vm.ssh()
+    elif args.interactive_root:
+        vm.ssh_root()
 
     if not args.snapshot:
         vm.graceful_shutdown()
-- 
2.39.5


