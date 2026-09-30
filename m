Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F710CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxSe-0001L2-60; Wed, 30 Sep 2026 12:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSV-0001Co-NN
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:10 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSU-00034G-0K
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:07 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d3920so42019805e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790786824; x=1791391624; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ua5U/mVS7GualGNLbAl+n/5rm6lr0GLfnfB1P74/KSM=;
 b=pnw0ZErqIvhlqX9uUSzeVFvKkzn9WdabMp9roTiWHGcdmKrBef8wsZf8m6jfYBCM/J
 RzDflE5aWpWuQOopIeng5NveE40uH5AicXXG6MpzKDOqOMKl/Wi0ng509bejF2IT/b+1
 Fqo1H0ycw4UwiC66tQReIxZ+qjqambVDqK550PwvSDH6tz26bGNmfRumOWJvibceLNMa
 xwSCTbtSqYI8NQmj/G7jVUga6eFrx0GzR1F8cDqeJBzxo/X6Mz7y4xOSNm1Qz3vXl+/1
 QaFxCUK0R08/6WI5y8a/bswxVyZGlD2YLsO5Yca8WsYwrT/wnWWXh8Q/mbQPSXcjstlh
 Hsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786824; x=1791391624;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ua5U/mVS7GualGNLbAl+n/5rm6lr0GLfnfB1P74/KSM=;
 b=EPeGVm2AmlAuqUgkzStkWVlmbkjTHiatUwB/jSLrVynaMGGbjNZI9pUiSoI41hd1E+
 TI4t1+QAGzWowUhEYU5sXQ5nvBHnPKkzM9d4qTyWrNMn77SfBhxp32GvMiSoLJUE/zAp
 PlLFjkRWrBHYPSSfuYPGOkqj6a2uCUu4a4xfNKDQuZ+s2UT8WoIy/Ecxli3OnVDVw1dj
 H6T/DSgfiAaN4Pluwi6mpOgtqeoNL2oow99mycNRcv5CqQAzWtQnvUbJjYxcmPddPssl
 gJXRv45HJrzR6QxdF61keU7D5JBZrD0BAJd6GDkEGMQnYoJ68bPc/my/rGz9xuYXB5KZ
 iyrA==
X-Gm-Message-State: AFuF++ne5+krNB2MI2oikiDXifeE6N8NqETSBeqoSzdV4UfWtTSL06//
 CABY1d2nNK2S19I3cHu/VNMcKLQwogkrgwPByxlJ4kv4sFYYsClqAMKY4hpOZZlE1wM=
X-Gm-Gg: AYBFou0DTD3QwCHK53Ms11woV6mraT2XPOcpMMwL8VVRR8F+46yfaw1QEeQCoWDqSRn
 zEr8q7iHJIAXUb4cQT7anDuZp0TOKd8O8pRkP4TyGhh6w0AzLbPFJKg5aIra1TvsKhS1WXPnup4
 AqIZvpPQYYeZ0hnGOCmoi9U469ddQC0xiBE9tDaWY6NPqNGKojsSWR9sDGjtIy3y6d22HmTIV5f
 3PnkStR/fSsVNUXAxJCxXW6rqW9+1640Dnb1AX5F5uSLSPOzpLAlPQCJnXiVrE3A0euzZT1y1+9
 KBn0su2EgOz0vKv5ll3yZ9Ijze/k0lXhKzNDsSJiH+LU/6fDwBxeUXuO4W4Lg+wly4gabA1RE0p
 6vuY45DPoQepqEgwLU+AuQywBnyyMJbl/tzszhToh8B9lUkLF8fq50BLD27NWlrjtkEeS94IZUc
 p+ZgLCTpnH0YmB2S6Q4jOb2r6Zrt/exZOgsFgnK/bd3DjPCDgJtm8+LVh1qNxGx7P4uITBPw==
X-Received: by 2002:a05:600c:4e8f:b0:4a0:1eb0:1ab9 with SMTP id
 5b1f17b1804b1-4a01eb01b1bmr4235515e9.16.1790786824083; 
 Wed, 30 Sep 2026 09:47:04 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b068bc9b1sm332261f8f.4.2026.09.30.09.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:46:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D024A616E3;
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
Subject: [PATCH 11/13] tests/guest-debug: add --symbols option to run-test
Date: Wed, 30 Sep 2026 17:46:47 +0100
Message-ID: <20260930164649.433573-12-alex.bennee@linaro.org>
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

Sometimes the debug symbols are not in the kernel binary image but in
a separate elf blob. Provide --symbols to facilitate using them.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/guest-debug/run-test.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index 4aa24939b7d..0c7cbd137ef 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -28,6 +28,7 @@ def get_args():
     parser.add_argument("--kargs", help="Kernel args to --append")
     parser.add_argument("--binary", help="Binary to debug",
                         required=True)
+    parser.add_argument("--symbols", help="Symbol file for binary to debug")
     parser.add_argument("--test", help="GDB test script")
     parser.add_argument('test_args', nargs='*',
                         help="Additional args for GDB test script. "
@@ -114,6 +115,10 @@ def log(output, msg):
     gdb_cmd += " -ex 'set confirm off'"
     # connect to remote
     gdb_cmd += " -ex 'target remote %s'" % (socket_name)
+
+    if args.symbols:
+        gdb_cmd += " -ex 'symbol-file %s'" % args.symbols
+
     # finally the test script itself
     if args.test:
         if args.test_args:
-- 
2.47.3


