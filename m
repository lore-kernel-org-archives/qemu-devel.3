Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D31FC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYRbv-0003wZ-Qj; Mon, 29 Jul 2024 10:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRbu-0003rp-JC
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:26 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRbp-0008Nk-9f
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:26 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5a10835480bso5361298a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722264260; x=1722869060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TdNyQjx9vy1t8eoHD/QTCnhZHijRSE/LPFIBD5gVquQ=;
 b=lpFmL4de2DiDohtCspV95InlqOV/tmh0lKc85jYntv+dVHAZLP4ewt7gNmKMh2Gnq5
 +kD3IJFYqbZugQrwZBTmTcwZrTBYo88eMGjABqsr65/tntJKY3oxj7jxQmwaJqTRihlP
 dZjrmOvRcyOmVPJry5PC61Z3eli9dL3mMPYo04dYPnHWW5l/LzdjJx+E2eNETZ05A3pt
 cM0UPHUXduCVmpZtDow6EWD35an35Mo1/Okp931pTCg9+gIXz8yobrShPEEtHyZ/lhG6
 0k0/UeU7QQ5cCuJ5XwgKCtuDrhls87JJSd6qgq/9CuPMMjzofGwc8XoXFtDOWiuOdVrT
 QM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722264260; x=1722869060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TdNyQjx9vy1t8eoHD/QTCnhZHijRSE/LPFIBD5gVquQ=;
 b=UAYFM3SQtVdSz74dhm663WzE90PVY1L86Ek1wxCHdhvBUNd8HMdPBjBLx0h59ysbk0
 V7mujyMw7ROkzw5c60XZJQ5h72v+MV/H8J9gRZBY4rv8o+MQpGuG84cSH2OXNKBjuOJ4
 lOGdYHiT/XRqyzC5GfBsy+tOs7h3T0e/y9P/wvgWnKXzaO2IB6J8qiEh9+OKMzw8vI3H
 gZBPgdnw9xfLxP+Z2ETF25FRc+nwaR1i05H1AUGbsQzeqwYHZaDPEbHVMWjj6Z1oqkq4
 axWxGI5y5oyeeGHsZ+GsSK9aO/edEBkfyRoOvE9bRTMAPKZbILIvG8k8SDEl6R5Qum/o
 TDzw==
X-Gm-Message-State: AOJu0Yx+x+c7Qmkm7GiUxpVzm+vM9tPs0O2EAJNXGhsmMPlEiFEgtMHF
 seM2CEMANbtlV9H6KCmN4BcSiD0po7HjcJvVu3N0Thv0MUgwGLLIgdILX//IxUw=
X-Google-Smtp-Source: AGHT+IHHhSkKmpbbjVHqoyAkSBJA735SFd4BmTgn67DBvO4GcXVK7szvrETNIxZkj23mIXlWB4PcGQ==
X-Received: by 2002:a05:6402:2681:b0:5af:758a:6929 with SMTP id
 4fb4d7f45d1cf-5b022003a1cmr6077793a12.23.1722264259275; 
 Mon, 29 Jul 2024 07:44:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac6377e06fsm5901911a12.28.2024.07.29.07.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 07:44:17 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9DEE25F9F3;
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
Subject: [PATCH 06/14] docs/devel: update the testing introduction
Date: Mon, 29 Jul 2024 15:44:06 +0100
Message-Id: <20240729144414.830369-7-alex.bennee@linaro.org>
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

Move the mention of "check-help" up to the intro text and also mention
the meson test integration.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/testing.rst | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 23d3f44f52..b984c5dd26 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -3,13 +3,28 @@
 Testing in QEMU
 ===============
 
-This document describes the testing infrastructure in QEMU.
+QEMU's testing infrastructure is fairly complex as it covers
+everything from unit testing and exercising specific sub-systems all
+the way to full blown acceptance tests. To get an overview of the
+tests you can run ``make check-help`` from either the source or build
+tree.
+
+Most (but not all) tests are also integrated into the meson build
+system so can be run directly from the build tree, for example:
+
+.. code::
+
+  [./pyvenv/bin/]meson test --suite qemu:softfloat
+
+will run just the softfloat tests.
+
+The rest of this document will cover the details for specific test
+groups.
 
 Testing with "make check"
 -------------------------
 
-The "make check" testing family includes most of the C based tests in QEMU. For
-a quick help, run ``make check-help`` from the source tree.
+The "make check" testing family includes most of the C based tests in QEMU.
 
 The usual way to run these tests is:
 
-- 
2.39.2


