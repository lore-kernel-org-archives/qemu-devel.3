Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9FDC77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 11:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7DH-0005JA-HU; Fri, 27 Jun 2025 07:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7DA-0005BW-B6
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:40 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7D3-0007B4-Rs
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:39 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-453749af004so11383345e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 04:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751023525; x=1751628325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BRCrBeKLrs8DsS30KgrrqkaRkYENH2zMrIYSsPDQKi0=;
 b=X50slnXsQtsAIsrq33EZcVAKQsWbujSp4B8VY4YcCcSa9564p4PTll+YLlJdJ2wbk0
 BsJSWi25hqncaKXXyRi9mC1Y1hgcLpTGQKFEA2UiTECQNdPhRGEpIsi+CJNBaAspn4iJ
 0+vPl/rfrqS+puJfujVwt2TgzNN0Uq+ntRnbivR48IxZi1j2dZ9B69LQazguCrCcxfrB
 h74uQkt+oSZJioXlqtyWc1GfJLrSgWlFNvMMzTXTfUJpjBFabys5j3gWOIwmJabModUW
 NhPDHCr5n8mP2xWuGLpqDC1w2yfnk0fO74FHid6B+b1ORMERSq0HTdsaT+stP2tYktVp
 DiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751023525; x=1751628325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BRCrBeKLrs8DsS30KgrrqkaRkYENH2zMrIYSsPDQKi0=;
 b=kj8iSpePVyGdUdGJIvpXuP0222A9dRAFQ6UZg0BFRcscDkGIyg80JMPC7j2V9zVMMw
 cauRhKWEAECAJBYy/qGXYSJFipgvSL1u75rzqUMxCKuEPK0WM6sopeeK/wfArMkQ5VY9
 5v7pXOnItyj/4vmfgmDjXPRJ6X6J5fYmwD+PeU69w5BSlPHXVDkfr3NpzOr0/DOwnwjF
 ipexFNNlNf9kvHiHb/bEyaq42qvLQ6hgSTq+NgMKbhjHVDZjI+1YpvcIIvj8KX1Hmfwx
 KMDRZdYwZZU38qVHdsIe4MIECF326Mf5GfeIO5HHuAeEA2nBdCIxBpc4k1CZHrH+Tpd5
 UaLw==
X-Gm-Message-State: AOJu0YxzvW/jBIqXawsZSgUpX9c54yAn80noIdeLNMra6Zvw/rbsNHmV
 FqWun4TfGgKM/kvLDuoVWhIw5WOKnPMU9bmQuKPaxWO1NU/I0Sw+LRByCKoHJnwy+DQ=
X-Gm-Gg: ASbGncumDVAVGLfZgfZ+6/nHL99RbjCXc/5cwYVWXRD8bi+3IkqvyEK5Ppcxn/2xJPe
 aSiMHuyJIg5qXbynGidNy9ScrLWbkXBWhK2LyG6/9ecYboeZQiguie6kLXH1kgH3/3ygBbmhECo
 UTYJrBpepM8YpJxwPkxfwxNeh1JsoJErUh6QWRNy1T46zBsnKFEgSGWVYng8BUl2AmUGyTMF1MF
 2xrdU8O/Pc8RW4lE+2zP1vNlxG5D9omcjOdZWISGDF3UFzPbI8SQ6/CQuB2WKM9r4BvGMJcQPt4
 Bnu5+s8PrUXSmsRudfqv+h+fEtwDbqIbmiinl69KtgeuAAH5Tc8xpOR3zgvCEVg=
X-Google-Smtp-Source: AGHT+IFsoDlXQ2vIPAeoXJy4Ak1cL8SMceB4RlWERijQA67NOup5sudUbHmzEHitJXLDFSz2PoMBgQ==
X-Received: by 2002:a05:600c:3ba2:b0:441:b00d:e9d1 with SMTP id
 5b1f17b1804b1-4538ee15a09mr36800335e9.2.1751023524809; 
 Fri, 27 Jun 2025 04:25:24 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538234be76sm77763245e9.15.2025.06.27.04.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 04:25:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2B7E25F913;
 Fri, 27 Jun 2025 12:25:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Iooss <erdnaxe@crans.org>, Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH 10/15] tests/tcg: Remove copy-pasted notes and from i386 and
 add x86_64 system tests to tests
Date: Fri, 27 Jun 2025 12:25:06 +0100
Message-ID: <20250627112512.1880708-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627112512.1880708-1-alex.bennee@linaro.org>
References: <20250627112512.1880708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Rowan Hart <rowanbhart@gmail.com>

The x86_64-softmmu Makefile seems to have been copy-pasted from the i386
Makefile at some point in the past. Cleaning up a vestigial unused
variable and removing some outdated comments.

Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
Message-ID: <20250624175351.440780-7-rowanbhart@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/x86_64/Makefile.softmmu-target | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tests/tcg/x86_64/Makefile.softmmu-target b/tests/tcg/x86_64/Makefile.softmmu-target
index ef6bcb4dc7..d3e09708a5 100644
--- a/tests/tcg/x86_64/Makefile.softmmu-target
+++ b/tests/tcg/x86_64/Makefile.softmmu-target
@@ -1,13 +1,11 @@
 #
-# x86 system tests
-#
-# This currently builds only for i386. The common C code is built
-# with standard compiler flags however so we can support both by
-# adding additional boot files for x86_64.
+# x86_64 system tests
 #
 
-I386_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/i386/system
 X64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
+X64_SYSTEM_TESTS=$(patsubst $(X64_SYSTEM_SRC)/%.c, %, $(wildcard $(X64_SYSTEM_SRC)/*.c))
+
+VPATH+=$(X64_SYSTEM_SRC)
 
 # These objects provide the basic boot code and helper functions for all tests
 CRT_OBJS=boot.o
@@ -18,7 +16,7 @@ LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_x86_64
 CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
 LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 
-TESTS+=$(MULTIARCH_TESTS)
+TESTS+=$(MULTIARCH_TESTS) $(X64_SYSTEM_TESTS)
 EXTRA_RUNS+=$(MULTIARCH_RUNS)
 
 # building head blobs
-- 
2.47.2


