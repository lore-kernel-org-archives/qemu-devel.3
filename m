Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D198BC982EB
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 22:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7KGP-0001oo-SS; Thu, 17 Sep 2026 18:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7KGM-0001oL-Ax
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:07:27 -0400
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7KGK-0006H2-PE
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:07:26 -0400
Received: by mail-pj2-x0e.google.com with SMTP id
 98e67ed59e1d1-39b350c69b4so112708a91.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 15:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789682843; x=1790287643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P7/TiDgWYks57A25lc75uXS1p0NFjUja6QcSsY8XHNQ=;
 b=OnSShqsirurCEEDLVPv/6+AzuGBgWRv1G1DzgpfJtmFu0jHM2dHrqvsv+iHxRaadQo
 YuXZCJpGDkeVj9AMm0EiUcdPiJaCz7M4VU28w0Tfx/uEDPicZExtx4xv3hX+4jZ2iEw2
 HXD+5kZX/QtQJcEGDL6SnOzNkZRYXiP5O4vT1jVS0rpdNm/n4/rmElkHzrOuQMdgbanD
 4yxKkgqM8d1LJ5ZhOKyiegUA8Z10aKhBs+S9AZmNx4Z5MRZltWTioYICj3wj0WcU922y
 42Uod4MlSeBGmRV0cjAvKPmDAjg+zJQyLLhc9osZeIdXx6d9+3hoyFgdYlZr++fb/6Wv
 H2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789682843; x=1790287643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=P7/TiDgWYks57A25lc75uXS1p0NFjUja6QcSsY8XHNQ=;
 b=EdQakFMFybBhXHs5/65Vtllosyn5PlJ2hTMWhctSIH94FBFnMwS7ZmZyVj9kIKQZLt
 MEvkkdzRiF6lhxE6Jl8h1B/6ZSDRhTIg+4+F9lViXy1FYrghFwXT7YlIZd+XJOM9Du/8
 4eavuF1SToHFJWJYd1DVIuC30saYjZPpO6TeCiywOe2CkIRiPN4Fztqt0bKtMX5mfIW9
 6Qjv1gRE+7WnnaUM1875JKCiQUoX27DMk1HJ5kd+XgvXuoFBGBk1w+gy8lAEmi2WRRUa
 r4AJB6JxA/gPQRsy3PlYVkKt7yr1WwJhf+scHuPHo2XfnXDt0A/MP9xAK4wB58ZrFYsH
 PYCQ==
X-Gm-Message-State: AFuF++m2Hztq5S0tiPUIKJoZkJ07NkL4IF2pRYzntCqbvrooecfiCcrC
 JQIbCaHjAF9myG+u7u+8DwS5cuREEG34zX/p8HlFDPV+zjw6IgZzAppMXs8U+yoVyD9B4VRyldN
 grtNK
X-Gm-Gg: AYBFou2dCKTipM+7cGoiPQWZRfWO4PAQJilc+9iUhYGWRdaNTCd4/QfjPLq7mUFFvMs
 /rv6D1ZkzZLVH45/FG+srtGRBq42dU6JZIpwrL7U3DviOBODVIq4AwwWKenBlnrf1xojgQmaL3/
 X0XZNapU+DqG41nUO3w3C4J9FBbtNUGzlM3S3tuCoYg4Dq70bOdFVV9nIaU7NtJrRfPqoTQQwKk
 pzK9JdVXXRRigi9CZNyY1qJEhyVdLcNDd9684lNO4ScT8Mx4p1A5kkbuPiVVdCtKCtU+aqzP0pd
 W80QvzpakBfHgxW68hU/JXFQUEAPwOtmAxIlSTkkOI+xRGrs/paPICXECRt61pecR7wWbNQde6h
 mKEE4m8ElpHuKUqwW6Z+VqrzRGCnJL9J/wWEbb7leAlx9NKdev/pp845BS0JOIUjp+2c4jeR+GL
 yNLCRB7kyigxPa8YK9Abp7WQYsbQBRCVlfXhKOzwXnPLiSjS9EKTzyaStIerYjWfJ5W7AxKWUzw
 VL/I4I=
X-Received: by 2002:a17:90b:2dc3:b0:39e:3ce1:d22f with SMTP id
 98e67ed59e1d1-39e54d3674bmr927647a91.16.1789682843213; 
 Thu, 17 Sep 2026 15:07:23 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d3a31asm14558131c88.9.2026.09.17.15.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 15:07:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v6 1/2] tests/guest-debug/run-test: Add --pargs
Date: Thu, 17 Sep 2026 12:07:17 -1000
Message-ID: <20260917220718.60899-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917220718.60899-1-richard.henderson@linaro.org>
References: <20260917220718.60899-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Add --pargs <string> to pass command-line arguments to
the user-mode program.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/guest-debug/run-test.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index 75e9c92e036..a592a69168b 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -24,6 +24,7 @@ def get_args():
     parser.add_argument("--qemu", help="Qemu binary for test",
                         required=True)
     parser.add_argument("--qargs", help="Qemu arguments for test")
+    parser.add_argument("--pargs", help="Program arguments for test")
     parser.add_argument("--binary", help="Binary to debug",
                         required=True)
     parser.add_argument("--test", help="GDB test script")
@@ -88,6 +89,8 @@ def log(output, msg):
             suspend = ''
         cmd = f'{args.qemu} {args.qargs} -g {socket_name}{suspend}' \
             f' {args.binary}'
+        if args.pargs:
+            cmd += f' {args.pargs}'
 
     log(output, "QEMU CMD: %s" % (cmd))
     inferior = subprocess.Popen(shlex.split(cmd))
-- 
2.53.0


