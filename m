Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D17CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxSc-0001Es-6a; Wed, 30 Sep 2026 12:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSU-0001CU-7a
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:08 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSS-00033r-0j
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:05 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd5462b69so31658265e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790786823; x=1791391623; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+Nvw+EG+DVEjQRcd31WCgslzUlyd+QzPJqnKEWKye5M=;
 b=aEwkRrA4u0LZRWA0V9GbF6L6xciKwZhH8myuqi9z9e6/G1DypAS4WkKQJ2JhPK9klU
 /HlbKb0JGAlmkZxvTdkvajLE9nKB6Q7gBOnSdrbkbh5z6rYg5Wri1Vdwg8JtNbL0FoDT
 VfP/clWX01VYHAqR2N2FZKOzD8akCbVBBexR3JMx1RODMs2V8oW3wXggs23RU8NRjWLi
 koswBAv/BiDFiJuW7WzUGNzReAzCNOCAlGFfTW21g9ULMRRwAxTLmHjkKxr6O7PfBlfD
 KMnN0puKsbG4baukL8O1rMuHvuauU21kVcv52WecMsvviI0ylRiyO97ZOPwep1dvjTsr
 SfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786823; x=1791391623;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+Nvw+EG+DVEjQRcd31WCgslzUlyd+QzPJqnKEWKye5M=;
 b=mdxbjfpjuUdIIUCdn3MQdlfFEAlKsYMSQZoPP6wUiQqvfcEbHjvcMczvNJRI9Nsb7V
 kszR/yDYI+6NGUiyZq5QO7ttCcL/aJWMbhsde6NCGSDVEJfZK+M0mI9OUT8pxOnoikGd
 7wEwWdPXsQEaQEefLGt0YeTtiVDkDgfAMyynzlm3dWrBjDFpIgFzLXDsT60CwYtoVmwJ
 QZzZp2E+pV9Hue446a65yFqtUKGdXBE/jvkXPgfOePzNXw8/KgTvRrzeYSQoV5DAT6oQ
 SjkVAZJwjGlJqJlMdM8WUzkOzLp/pJP5+wi698oWLbbFn7Woj3IUZXnookPV0GjX7ou7
 6h/w==
X-Gm-Message-State: AFuF++nZjcffaH0N5vLUxNzg9k9dAO59qQ8k2L1UuGyWuMVfwcILNpjB
 mu55dSwG736Z3o8WMc8FiFgzX2VT6qIzuYRBiMyQh8A6T+aZwrQDi+9MLkSFjO/kSe0=
X-Gm-Gg: AYBFou38gA6cvBPFuxF+WpeBGittYXU1coNa3hecKFqYr13IlP5fFg99YvkhoQ03eMP
 DF0ionKs11CDJhIBUaowKlucDQRTOh26/crHsCCYgtgMTdscYgLV44+UkDYt9PeEENNrotvk6YF
 2HgqI6TDDrrp6qEqVEjWzZrjYusUZB25r+x4pGUSfuF35yb9vJQNhWxKY/GtwX4JHcp82o34hpd
 4wcM/IRJ+MLBFUfk3jWVUBdOOxu8oHKfcHz9wLjF5FYf6+ul6aj9mqWRju/NVyLhEvF4/YtfMjz
 aEl3d9/mHhKaMKfkyfGqySjSdEaaUeyfEcFHBVwQp35CvnYIuwH48X9KI5Qo5gracB0mjhgLgGv
 meFktnM/6+jbXAJU/NZRnKL7rsASgg8uo09TdTZHT+B0BW8zN6POImNGjbn4twee1SNS7TDx97U
 ZJB47yNApuDs4/wmVOWMNmM15OYfYOZUTGoCnEcWc9N+mKiuQXuje0dWoDp1IKfCLWcyuGQA==
X-Received: by 2002:a05:600c:1c28:b0:4a0:1d1a:6067 with SMTP id
 5b1f17b1804b1-4a01d1a619amr17000115e9.34.1790786822568; 
 Wed, 30 Sep 2026 09:47:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eba0e06sm2829305e9.7.2026.09.30.09.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:46:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BA60E5FBCE;
 Wed, 30 Sep 2026 17:46:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Song Gao <gaosong@loongson.cn>,
 Ani Sinha <anisinha@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Klaus Jensen <its@irrelevant.dk>
Subject: [PATCH 10/13] tests/guest-debug: add --kargs option to run-test
Date: Wed, 30 Sep 2026 17:46:46 +0100
Message-ID: <20260930164649.433573-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930164649.433573-1-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

When passing kernel arguments to QEMU with --append we need to take
care that things are properly escaped. It's easier if we get the run
script to do it for us that constructed the nested escaped --qargs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/guest-debug/run-test.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index 838c1c26971..4aa24939b7d 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -25,6 +25,7 @@ def get_args():
                         required=True)
     parser.add_argument("--qargs", help="Qemu arguments for test")
     parser.add_argument("--pargs", help="Program arguments for test")
+    parser.add_argument("--kargs", help="Kernel args to --append")
     parser.add_argument("--binary", help="Binary to debug",
                         required=True)
     parser.add_argument("--test", help="GDB test script")
@@ -82,6 +83,8 @@ def log(output, msg):
             suspend = ' -S'
         cmd = f'{args.qemu} {args.qargs} {args.binary}' \
             f'{suspend} -gdb unix:path={socket_name},server=on'
+        if args.kargs:
+            cmd += f" --append '{args.kargs}'"
         # There is no guest program command-line in system mode.
         assert not args.pargs
     else:
@@ -93,6 +96,8 @@ def log(output, msg):
             f' {args.binary}'
         if args.pargs:
             cmd += f' {args.pargs}'
+        # There are no appended args in user-mode
+        assert not args.kargs
 
     log(output, "QEMU CMD: %s" % (cmd))
     inferior = subprocess.Popen(shlex.split(cmd))
-- 
2.47.3


