Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E5EC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqYi-00047H-0M; Mon, 21 Jul 2025 09:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYE-0000B9-J5
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:42 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYB-0005I3-2l
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:29 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b611665b96so2361884f8f.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753104445; x=1753709245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CinAv+JmxDGnvNAXVZ6z1/DIxUoQ1w9KIVLUKTNoQi8=;
 b=JMOoYVhja5E/6Ht8XJhXqu5PZI4D8SZ8QPNpkMFN/tPJwNZHR3DmGFgXO6kjxdHvDn
 9KqIMHCNCVU/wjQQDQHJ5Cxs0D2F6cA0JRKVRYXyXnvu0w3cj8J8b0UPSbhaNw42iOjq
 c8R+n7u7SLN/GRnPWAm/WUSqwVq1+SwY05lB4tDvD7yS+hLML1uYS5kRkn931DWhrffm
 9dyxx/1Qr5V+Z8YpN4bh9usJf1V+IexyScUE/IQovcDuZId0dyV/LwDhDuxRka5rIQa5
 asGWDJuCKst3x+EKRUaMi2B+Td6Zfy9NxcDELHEMXKuPblK7A1mQFMAFd055NHVrbj3m
 XGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753104445; x=1753709245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CinAv+JmxDGnvNAXVZ6z1/DIxUoQ1w9KIVLUKTNoQi8=;
 b=aSC2+d7Veueeed8Hi2r6lZAqQI/8yrL1XDETg1qWgW+jKj6ZDYmS2zjh9Lwg2htnXJ
 bZ2cjhyY7X1jPbF/hLAow6+fPqm7WmI7jsPUDaqI9j0V1rq91soAut5sq2JI4/lJlU5N
 hhkZ8B7+mr1QVu8ZBdOvpT0qLxb7aZiv+gwtUgfZg7gDjYmS+MQDon7HOEaKhJ5XXQ1l
 GLyWSSkYOSiCpTx/1Xvjl33bAZcfNp/aawvBY+0QQbjJzFj/vlYgogQ48mlgDFWZCoks
 hgzLAzE+W8vKhzOtCHbp9WRniVsJBHnsCug/+cNuSX6Ux7GvStVy0vHUu8N7H7AaDryb
 sGLw==
X-Gm-Message-State: AOJu0YyPPmJRQg6j9Dy0gOll1rPUb6xy61HnR3nPoXLvDGSBOOKJtmQj
 /OdGpia8nD//Y6EXFifxIam8spbFOs7xjSkvCBbftjn9oK40uLH/Hv1/mS/0E7x6Hb1ynEqm6Kk
 2B8xz
X-Gm-Gg: ASbGncsKzbzre/iWvI9i/KKCHycNYin5WqUzm9aN91iPd7W2HDWoFxgqkN59nxCcE5a
 wrNYPI599elc4ikeNkhFRiileqQ/V3BZb8mQ+IKoEmdAW8XIwPlRP2aP9WHgqWmfzHvfVpoZGS2
 XMDL9RFlviy9PZsFdu/17LmAsaXTyCVFca42OI87fXIFU50Pcm4GBbhYtLAeLaMtCxaT3Kp4MOf
 plYDKlI1vyKe1Frz+0AIeD/muFE0g9c4fQ6o61c40Nuiu6216CNQXvEyLGM0W1iQOQaLk1C1tg3
 XpqH+jBpqVNbD5I95r424BwekZqESskb4CeqMpETRRPXuDIPSh0NWoM2g49j7T0mTDAcsGeRuth
 WYndQ2+GgauiCM2IWngZh95I5ehWA
X-Google-Smtp-Source: AGHT+IHxBPl3UMhXn/3+hE7jpCKZtycpyYitE1pMNT/Eu/C5rfSSkYFrEVXeInNgmZI4M1G47SHSiw==
X-Received: by 2002:a05:6000:2b04:b0:3a4:ead4:5ea4 with SMTP id
 ffacd0b85a97d-3b60e4d4da4mr11092479f8f.24.1753104444591; 
 Mon, 21 Jul 2025 06:27:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c754sm10487946f8f.59.2025.07.21.06.27.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 06:27:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/20] host-utils: Drop workaround for buggy Apple Clang
 __builtin_subcll()
Date: Mon, 21 Jul 2025 14:27:02 +0100
Message-ID: <20250721132718.2835729-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721132718.2835729-1-peter.maydell@linaro.org>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

In commit b0438861efe ("host-utils: Avoid using __builtin_subcll on
buggy versions of Apple Clang") we added a workaround for a bug in
Apple Clang 14 where its __builtin_subcll() implementation was wrong.
This bug was only present in Apple Clang 14, not in upstream clang,
and is not present in Apple Clang versions 15 and newer.

Since commit 4e035201 we have required at least Apple Clang 15, so we
no longer build with the buggy versions.  We can therefore drop the
workaround. This is effectively a revert of b0438861efe.

This should not be backported to stable branches, which may still
need to support Apple Clang 14.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3030
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250714145033.1908788-1-peter.maydell@linaro.org
---
 include/qemu/compiler.h   | 13 -------------
 include/qemu/host-utils.h |  2 +-
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 65b89958d36..1c2b673c058 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -182,19 +182,6 @@
 #define QEMU_DISABLE_CFI
 #endif
 
-/*
- * Apple clang version 14 has a bug in its __builtin_subcll(); define
- * BUILTIN_SUBCLL_BROKEN for the offending versions so we can avoid it.
- * When a version of Apple clang which has this bug fixed is released
- * we can add an upper bound to this check.
- * See https://gitlab.com/qemu-project/qemu/-/issues/1631
- * and https://gitlab.com/qemu-project/qemu/-/issues/1659 for details.
- * The bug never made it into any upstream LLVM releases, only Apple ones.
- */
-#if defined(__apple_build_version__) && __clang_major__ >= 14
-#define BUILTIN_SUBCLL_BROKEN
-#endif
-
 #if __has_attribute(annotate)
 #define QEMU_ANNOTATE(x) __attribute__((annotate(x)))
 #else
diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 4d28fa22cfa..dd558589cb5 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -677,7 +677,7 @@ static inline uint64_t uadd64_carry(uint64_t x, uint64_t y, bool *pcarry)
  */
 static inline uint64_t usub64_borrow(uint64_t x, uint64_t y, bool *pborrow)
 {
-#if __has_builtin(__builtin_subcll) && !defined(BUILTIN_SUBCLL_BROKEN)
+#if __has_builtin(__builtin_subcll)
     unsigned long long b = *pborrow;
     x = __builtin_subcll(x, y, b, &b);
     *pborrow = b & 1;
-- 
2.43.0


