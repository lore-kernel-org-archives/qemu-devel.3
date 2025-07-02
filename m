Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDAEC83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWuwm-0006l0-7K; Wed, 02 Jul 2025 06:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWuwe-0006hT-EW
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:44:05 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWuwP-0001Jn-OH
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:44:04 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-607cf70b00aso13293619a12.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453026; x=1752057826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rk0FNmkluSOyigMHJWnPKlXjmy4Hc5fY1wkF0CxDkc8=;
 b=KOUa1+9EfLifTdVwR9DOq3kJ5VB73LqBhYVKjtYpKyw2Qb4AX6x57pa6Zb+5deV7hy
 GMlatIIvETd/zN+HKqdq3q0XdhyuYuvRniqhCnKtYv5VUfGRqhWiwZVxksbz5iDVIH69
 D4jNE2TgraUriucPW0bfAmeOcgnFPKrkAOxdDG8hGmmPNmIIqvtGb79gGMLYvR0+Ya4S
 2hwBpaMEPXbsBMv3wgZMVPb0SZz602esbWQL0UZF/4w+fUbQxSolLXLczL36S1WfkyIH
 0B0ZWFMxml3wdOV4Pn9QpGZkGIK5JCWkTZifNCZHjdRaz7pAPHAyBpCeHmf0e/aL5OGu
 /n4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453026; x=1752057826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rk0FNmkluSOyigMHJWnPKlXjmy4Hc5fY1wkF0CxDkc8=;
 b=KazBrOqmtFkS45pa/seoJYk0IdwpRIC6NkiIfRppt4pTNJY+b8pZyBNgwlMLN1jziY
 t9cKlz4uWmjumtXgb+JLAnrxGbvXsgDnWSAYny10W8f9BYqUhJX5jn0pgB45Sh909YzU
 WriLO4CQNrE/vYYYdjtX5+jq917Ez4ycHbrDoRa6FgGRcaXuH8muQwsCL4E5meWC0nwz
 R9wmTcY7tCVZbNqn/M37MczLVRjzPVjIEtj/4LIdgrpVaSRbeHqBA2E4528nmgm/7B2X
 vD+WlHGSaUHpQ2iUrDjyGJHE82R81IMJchWHHbmNF/QCryC5dl1druFiXfS5BRBLtBMv
 UHZQ==
X-Gm-Message-State: AOJu0YxDTsg0y7idtJWip/ZY/sTFcG3dT9IF3UfjQue/ouyxvlrvpUUl
 0yrDNsQ3orlToakNKEHGET4HZjLsqmfG9G0rdaLvKF5uJBGcSJZVLtl9B2Dt3/vUSaguf0apVbr
 N2K99DsA=
X-Gm-Gg: ASbGnctUhIV692n9G7AUfFcDaUz3G17nEk7V3s0lZMkI+pEzQP2FV86HQPpmTHm5wAZ
 /KGwoPaSLlGyjzFY4km6uQt81WZo6dKkrxBBDEO7LXjM4f0L/kJA+CAPpG0U+oTBMl8wlAPhtCd
 PKt7gBNHWARo7rCW2qsdMhN7uzgWrp/3fS/daQYOTxVMUajI9RsYxui9tybPykKnQT+z7lgJkLw
 PPp8auTCRCAAeMCs5SGTxS/v6cpaQlFNcCT475e8pOdDUoAUXpP2qickUru5NmPBVv4v/rHA4Jv
 x5c988qTob2PBAn+UgXm8L4v7ms7WQPcG+vNAGLRYqC8MgxZgJh+QG/0Qul8Xpw=
X-Google-Smtp-Source: AGHT+IEBSnP7CCBc6N0n/h1gX7eVxO0DVKM0IabxgxDAwfRHrPC9wL6IME90E8+n2l2Dyn4hZixfpA==
X-Received: by 2002:a17:907:2da5:b0:ae0:d38e:5852 with SMTP id
 a640c23a62f3a-ae3c2bd9b63mr226526766b.39.1751453026267; 
 Wed, 02 Jul 2025 03:43:46 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353c01636sm1058476266b.105.2025.07.02.03.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:43:42 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C95625F8F9;
 Wed, 02 Jul 2025 11:43:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Rowan Hart <rowanbhart@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 10/15] tests/tcg: Remove copy-pasted notes and from i386 and
 add x86_64 system tests to tests
Date: Wed,  2 Jul 2025 11:43:31 +0100
Message-ID: <20250702104336.3775206-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104336.3775206-1-alex.bennee@linaro.org>
References: <20250702104336.3775206-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Message-ID: <20250627112512.1880708-11-alex.bennee@linaro.org>

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


