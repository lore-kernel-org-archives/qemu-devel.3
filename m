Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39FAC98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Tgh-0008GG-MG; Wed, 23 Sep 2026 16:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tg2-00089O-Ui
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:53 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tg1-0004zU-8f
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:50 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 d2e1a72fcca58-86efece610cso754333b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790195687; x=1790800487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bt4kpkESK+vp3J4Ch1F5d1RcFGSfxhQzGfObV4jbjgQ=;
 b=mxL2VWByFM2u+mL8SJMsWit3hWhzrxyy3WO6iMsSinMgRAuitm52DrL/23EWeEGd1e
 IkBWkNICxfgloYV5OgB8Bs+fvg1nDMSftGPZzMcNeK6CNVmapGpboJGd4LqlbLuaasqu
 3jUEHCldrGipGQXqf2vUaaJgAdq5VjwETq9Eoah2tQ2LhTTKouzoA10RQzJj/orYcfdh
 NEJzY9ALBwMFoT3OJFSuouGSSeKEzgV2l+zjAp4ncMeeqRobGyvhb8FxZi1tqwNPCUK1
 jg0dyNfSyQ+66fWnpXF4pALJaFuvj7M0FhQzUYlKgTdX118Wcfy+u4/sysjOL4ZybZMv
 b+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790195687; x=1790800487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bt4kpkESK+vp3J4Ch1F5d1RcFGSfxhQzGfObV4jbjgQ=;
 b=MowlP3+/wIzDebAyUKLP+xS4ePIjQDO511dnb3MblNDXXoaBBHavubZmkZ9IozViGR
 8R1WXljsmhl4MmYpS1/EgOK9QfwxJiUuTH6QVF2p+dUFqDIHW7QOKEeJmdCf5GJYKdCv
 kEeHyzT3b5OHKR4Ptsi/e2J0FhRAxacXkpgfhUte5qZO8oWMCkGV4UXqdTk7WLgWC4YS
 ut+O58xTTn4RHDgWK3H9Rx2Q4kRIyiqzR5Zq6m5dVtSv3FUEAWFOyxpx3T2yVrLhnFk+
 SY/qYywjfgKQ+1a55HB623rCSJcnNmIZWGuJzhanpIiq+wsZnfkoOaljHyT01UAIh21j
 Z6Qw==
X-Gm-Message-State: AFuF++nXHP12ffzU57X5pNRcg0Zp0qg/UgYSHCi/DOgeNEEtWqAaPA9p
 jm4W4/apza8G4uKiJ5XVonn2wO6wKpETkpnngIrl+nnM3JaeTASgDfHe5iZxfkbPPwTM1XqaRg7
 pC+hP
X-Gm-Gg: AYBFou1d4Bq3zsc32fC8JOq1aA7FBBWhuJw4AKyIJvapqJmhrkVSHmzILV5a59wo0Al
 ehOynup07/fQidUZsHLwQYFEF+GC4OuaY1bHO4+VeNmU4EllubALlwkiowVJnmlAtK9nh7tJnoD
 e2OJOxrT0RPuEXcYeAvnacZ5kr6meS67tJRDa2FJVX5hn0QXdw9W7GYqzT8gMEQy+7T117U6QSL
 x8CHsIk/OB3NqAhzEYqcOC7fiX68BPHeXQyNA99ESjXwNv+l1MRUZB7j6ZXZ4PAmD0EcSTnw8G+
 4wCmaqe5VPJYmfXhN6heYg1+nab9hwmvGNn5hzP3EFqns8KM3M05+Qp+UklXWzOjqY/exrtK3ds
 Je4JWSz+juEKLpyOggT+3EK7JlSY/bR30fgKsFKpo5Vu6l0iWhfe6fyi5JBUDWCE5hxMt7euE2P
 wsEmGFDJhbzoqizIjMRphmJSG0s7hLJ/kpA6sBD/Lb5xEszr+llih7rrSIxGeQgxO3m5VpkzGP6
 r2tS9dHKcaPER1h7neI//ML+AYb9Q==
X-Received: by 2002:a05:6a00:a583:b0:86a:9be:6bf3 with SMTP id
 d2e1a72fcca58-87e9b7995eemr230718b3a.23.1790195687050; 
 Wed, 23 Sep 2026 13:34:47 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d3894211asm1678638b3a.36.2026.09.23.13.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:34:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 04/16] tests/guest-debug/run-test: Add --pargs
Date: Wed, 23 Sep 2026 13:34:29 -0700
Message-ID: <20260923203441.31276-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923203441.31276-1-richard.henderson@linaro.org>
References: <20260923203441.31276-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
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

Add --pargs=<string> to pass command-line arguments to the user-mode
program.  Assert when using --pargs with a system mode program.

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/guest-debug/run-test.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index 75e9c92e036..838c1c26971 100755
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
@@ -81,6 +82,8 @@ def log(output, msg):
             suspend = ' -S'
         cmd = f'{args.qemu} {args.qargs} {args.binary}' \
             f'{suspend} -gdb unix:path={socket_name},server=on'
+        # There is no guest program command-line in system mode.
+        assert not args.pargs
     else:
         if args.no_suspend:
             suspend = ',suspend=n'
@@ -88,6 +91,8 @@ def log(output, msg):
             suspend = ''
         cmd = f'{args.qemu} {args.qargs} -g {socket_name}{suspend}' \
             f' {args.binary}'
+        if args.pargs:
+            cmd += f' {args.pargs}'
 
     log(output, "QEMU CMD: %s" % (cmd))
     inferior = subprocess.Popen(shlex.split(cmd))
-- 
2.53.0


