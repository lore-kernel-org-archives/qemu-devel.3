Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C4ACD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 05:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpxA-00022b-HY; Fri, 29 May 2026 01:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwZ-0001qY-Ey
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:41 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwX-00024c-Ln
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:39 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso91362875e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 22:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780033176; x=1780637976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRA9+wsZYNyXrpSi/wutg8agv+vYe+z7EAFvCTrftdc=;
 b=fC5wYY+L7e4lHZKFM6rh+n1I3eAut+N/E2s2/VWGp7IIsR9YprudaZsHhXAmuUFELt
 KWsdQqIjkiDLa3/eDt3LRi6LDbGizij3Ye72JzNITiu6LakNYoieXaP9eHNQWQ7rSsJ4
 nfr0sPZD8WpfxvLjmj8B9pdq7CG3iEM3Y63JflX54VieONusH2eSxWNQr0sSaNIQE448
 8Ya0pu8hG1OzXQ+nptE86QYWa1Q5VSEPtF+Er/AskX9/TJupEaw3iaJKSsCtHhsAQLgJ
 Wsq6meNA/sjX+NA9qXl85j3XYo7oqw8VHZWdIVaVede5TucTnoecC5BtXYzd6ISmootW
 Pj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780033176; x=1780637976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PRA9+wsZYNyXrpSi/wutg8agv+vYe+z7EAFvCTrftdc=;
 b=ZPVXxpjvRTVz2NdYDOqzg2OBE1tEKwfo7pVDqEvcKahAI5uQW8mRq1Zw+iiC2s727l
 UMklA/mjm7aHnqgu/CzbaiaNBaoLUexjQTqXUCJ6KlsFcggrT/rmrXnEbXyx/bZWplCW
 XZZQcpvuG0R0LdDzG4acCQGy1gwPP7T5B59FZeKY+Wijf51q36Fvr03yPwOJhB2TuXTt
 Dvo1LesNRGTncQ18PiZ552zJyO4D5hUUmzuVRBaf3Ce7xkuUMXWc6cSuar0XyFW2r4IM
 e4Pnv1oshyB3kRmcVtbWZb0vWcA20WqTd0iZGA0ASP+N/6SsQi3IgowbozTK9DDmefNV
 tvXQ==
X-Gm-Message-State: AOJu0YzWt4x9Qar05E28RwRkNIwUCybm1wLAw0ElKrDqh/paaYfw0KvX
 lv/SAnQFv4MFJJ4xfPCknl9DLzfJeatvDrmySqR8+x9ruxXGKdj9HtI9gEzJqlCWIFo=
X-Gm-Gg: Acq92OFeV9WTkAKe0U53IW38uksjl7uhQ9DvQasEMrtl9+IKQ4hadBQbPPfZ4+xs75l
 uXvltG43kbXyqpwKbgLZ4IMYdVHoaTeQTndaLsDYt8yRHaUues4+Tlyonx+nPAikFcRHSvvPuPj
 oiVqxdaHpTflNpQvo3I+AtFGoYAUvyuyoyMNzUhGF7BqEiaIE0btBUjvFaQ3jHJmvUF23YMxJby
 BxtJR9wPkgDRt3fBlLolaHvtbzUd+MYymVq8iFdn0QBtn/uZ6am7vowbrwpX6MI9NRddZwFVRGd
 nKWvdSxOvy7xrSPOr0n3fFDGVFTR9dxGa9BNAAM+YMGnWbHbGlYujut83IhIGLHDaIPuPgbza2k
 dFAr/eShyZsaIlGCV5vL/sUk5kcVkaqri8QOaRQzEAgXiNYqMicNCyUCpLa3KI7ZIXgvwKXQt7Y
 B7hhMaDTBClWINiSL66hNl7D8Lt3V6Yw9PJg==
X-Received: by 2002:a05:600c:a08c:b0:490:9d1b:2033 with SMTP id
 5b1f17b1804b1-4909d1b228fmr18859095e9.9.1780033176095; 
 Thu, 28 May 2026 22:39:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909cab0e79sm38207335e9.13.2026.05.28.22.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 22:39:33 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1F5515FA5C;
 Fri, 29 May 2026 06:39:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 02/13] tests/Makefile.include: fix typo in comment
Date: Fri, 29 May 2026 06:39:20 +0100
Message-ID: <20260529053931.283970-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529053931.283970-1-alex.bennee@linaro.org>
References: <20260529053931.283970-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260526110243.470002-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/Makefile.include b/tests/Makefile.include
index a063a1d60fe..3b1af78ca1e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -42,7 +42,7 @@ SPEED = quick
 
 
 # TCG_TESTS_WITH_COMPILERS represents the test targets we have cross compiler
-# support for, CONFIGURED_TEST_TARGETS it what meson has finally
+# support for, CONFIGURED_TCG_TARGETS it what meson has finally
 # configured having rejected stuff we can't build.
 CONFIGURED_TCG_TARGETS=$(patsubst %-config-target.h, %, $(wildcard *-config-target.h))
 
-- 
2.47.3


