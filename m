Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9900C3DA7E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYRc1-0004Nk-Jz; Mon, 29 Jul 2024 10:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRbx-00043s-9C
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:29 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRbq-0008Nd-5b
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:29 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5af6a1afa7bso3185376a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 07:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722264260; x=1722869060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jkd6LFuw9dfVXklEdc2dhr9bRuw+JJYLw6zlp56juC8=;
 b=Y8lHAcKOhkw2IR09ZLukGLyKJaq2zb+CMI6JUjfGI/8xREJ7VYCmHQ2AZgE0rKj2Sk
 1kckP0ySdEj4j/dTSg5Ijjg1OX0rX7G7rmn5oxsw2d2jwsgybDOdj4H81f27STp/By5s
 Muwsm6lxLuxxBrgG0xKofeCwIFGZzrqIJUXD6R8/0M0BaVvHewWtqwbskYFo0OBqELJn
 ymFFySVSgIAF4Zo7W/YRF5iYi4sahHSKpdQtLIbfYRPysHVOTQ5kqIrFnw4+82MiCWPI
 oZCPy7tFY5abZj/wVCTryxw6UHV1BBBlkuJvzxACkN1SwVPTbNPR1NeGCTzpOhA5H3X6
 tB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722264260; x=1722869060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jkd6LFuw9dfVXklEdc2dhr9bRuw+JJYLw6zlp56juC8=;
 b=LSNXaH4EQ+ZZMJL7n9KFKjcx10nn2ECJbDbMvS6wTbISpdc/ueeuA7o74wWmgifgZh
 uUf0SzUp2JPkm8sR73UNnE7fvEmCzPuWw99ZfEKrAlfCpokFt41hTsHHTnt44zIPICbU
 Bl1WXCngf/FppE3hywOrIaSXbs8OvLpHJ2uL/d3dbyX05wvFwwrYZfr1UpdhogOyxwP2
 VDmeBE5AK7Rl1jYUNFzskektmRxeAZPEon8C7lhhoGf4gomrl6G7EVhmGKtb+7PHgLUd
 pnzv2FZvpUsbROPnU7E0QU6popvuD9Pb91rLRzhBFxcsQ/0+Fh6GlY/9r6ANuVaKRIK2
 DVlg==
X-Gm-Message-State: AOJu0YyB4krRMcdYeDCUj6ecH8kT1wLroKm1I615Jq8UXuaAFGQ8JTmP
 qNtmZqGtoXSHN5Ezt6CC0qbqmCF+QqtwlxHFxAPAXURwiF8qva79DhvpAyyfeS4=
X-Google-Smtp-Source: AGHT+IH91duaUyTno3iK0GWmplPV/TkFQqJitVs82wUjLe0nxKZ20fAvbTHzOnq1qhFihMSZq89dkw==
X-Received: by 2002:a05:6402:1ece:b0:5a2:68a2:ae52 with SMTP id
 4fb4d7f45d1cf-5b01d37c1fdmr6001624a12.0.1722264259585; 
 Mon, 29 Jul 2024 07:44:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5af2f233be4sm4597887a12.41.2024.07.29.07.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 07:44:17 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 850715F9CC;
 Mon, 29 Jul 2024 15:44:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Song Gao <gaosong@loongson.cn>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 05/14] tests/tcg: update README
Date: Mon, 29 Jul 2024 15:44:05 +0100
Message-Id: <20240729144414.830369-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240729144414.830369-1-alex.bennee@linaro.org>
References: <20240729144414.830369-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

Update the document with details about the layout of tests. Remove the
out of date cris comments. Refer to the developer guide for details
about how to run the tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/README | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/tests/tcg/README b/tests/tcg/README
index 706bb185b4..6d08ca50dc 100644
--- a/tests/tcg/README
+++ b/tests/tcg/README
@@ -1,9 +1,14 @@
-This directory contains various interesting guest programs for
-regression testing. Tests are either multi-arch, meaning they can be
-built for all guest architectures that support linux-user executable,
-or they are architecture specific.
-
-CRIS
-====
-The testsuite for CRIS is in tests/tcg/cris.  You can run it
-with "make test-cris".
+This directory contains various interesting guest binaries for
+regression testing the Tiny Code Generator doing system and user-mode
+emulation.
+
+The multiarch directory contains shared code for tests that can be
+built for all guest architectures. Architecture specific code can be
+found in their respective directories.
+
+System mode tests will be under the "system" subdirectories.
+
+GDB scripts for exercising the gdbstub on specific tests will be found
+under the "gdbstb" subdirectories.
+
+See the developer guide for more instructions on "make check-tcg"
-- 
2.39.2


