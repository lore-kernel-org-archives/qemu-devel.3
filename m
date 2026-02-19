Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F450E9A05E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9e1-0001hd-4g; Thu, 19 Feb 2026 14:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9dS-0000BR-DU
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:24:27 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9dQ-0000FJ-3f
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:24:25 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso22520505e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771529062; x=1772133862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjVXShC1NZd4A4MSPAW7OCNU5rjrdaDfYPCeoCtFstk=;
 b=FlAdcjEA0vfUIpd/UL1/1VGWoAE46rcP0UvKkb2YhnXGL6znuadQsHhlYXh6vl3gS7
 5YX8O8xMlUz9Q3Q7Dtf29JIzy2hjbJdrFl36Xh8vrRcse9PBcNjFQ380uElXns3MZuJN
 CrIuxKiwSMqREcMbVxUV2hMscp2xwDzWMpkwEO3r6g2phm+r6mk5Xyn5S95A+SOwG3SL
 DQzLFU6XNJWvFk+WchVe0gdmMR4lb19Ryf8qrINGurvcTuqu1qztE8L5d5/vn0etU59x
 DFVu0SDI66OHprWyw+idTArA/+wmPrrtkcxpozTuBq3S5WwqdZmvpaAu4VF46VBfY16x
 wygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771529062; x=1772133862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OjVXShC1NZd4A4MSPAW7OCNU5rjrdaDfYPCeoCtFstk=;
 b=iDc2JJk8UbrIU8xeTCcQnuAYK24lKSUcFrR3PQXtFUqfrtcMgD9W7LcssWFcW/HqMH
 eiRkwlbYxJf5ql5n9x8XS3iaQAoi18A90x5OxI44t6kP8BVQn8rSpE9gDXboGKlYTh+3
 ywpHJ/foxn/CuzqlwAu27v9Bgin/wzMKYGNKZilfiNbG5CEKHksfklDHK64r2AtVK+HG
 zHA0bRL5XVN35CoXehljgqugupDd0aqf55tmqDc9QnKsWsb2KOQ0teZZN10Pp282bXgL
 9waktH53fXdf1VTLSA4U1XPLZajwz9raQHuscBxADUp0GtD42oaHEArMJgDc8t9KF4BZ
 rDEg==
X-Gm-Message-State: AOJu0YzBpb3wlDBS2oYVaBPUfsO0NYD5EsiU8+1maw/d/YsBHNEF7Se8
 tkOtsYQnvLZrqaLO4RTgYzVeQwxEEgmKqCA/HayIKxvoS+mPUYWYDICQv3W69XcCtdD+CjDkKup
 Vfv861GTYQQ==
X-Gm-Gg: AZuq6aIsWvFVEervSZP2f7BEJrdYvGbCYknbpO5iAileAXTGejCWcShIsy+Oi1SYoAY
 zlvSvNWeTsqHJKkohWJ83pjoZU9QCeZ8Myt6tFABZQu0r7yvZA6nXvBL5yX9u2c75q9kJ4egc0Q
 rxtiO71h1S8wZZBWLHQaXNSt26PqPKygFhRctZE2tKmSx3lBswPp/FJJ4mMPKqxVMMJ3O7b/o0h
 NQmEb9kPbStYWfDCrXu1xfxuNf9rfQ6HSoAb817sZKhB9rA+o9nF+CZJLE4/X6KCbtCS9dk7vby
 C1G9Q6y0jxIG9h5Rot3pIfAb0YSLfyhP7T+7qVRhDdLmbS1DexNiQjXrxQzF/FoEZuluhyTfBJe
 PL98JclAYwbRGVx9npXHKvvSJVk8W2JbcqEzaS40mrhQg2Lbf02R5i7jUe3lR7sB0Kn2R48wLKA
 4qXt19I8cob5GrwqKIEgG77bC+HxPwlsD5nnQYtJZE3dYsTTmzOrTzOMuobvheskxyzw9jUx2j
X-Received: by 2002:a05:600c:468d:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-4839fe96a50mr54337215e9.3.1771529062085; 
 Thu, 19 Feb 2026 11:24:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31bac27sm23936975e9.5.2026.02.19.11.24.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:24:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 37/50] gdbstub/helpers: Convert gdb_get_regl() macro to
 inlined helper
Date: Thu, 19 Feb 2026 20:19:39 +0100
Message-ID: <20260219191955.83815-38-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Rather than checking TARGET_LONG_BITS at build time,
check target_long_bits() at runtime.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/gdbstub/helpers.h | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index 402514716d7..b2f41d6d280 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -88,6 +88,20 @@ static inline int gdb_get_zeroes(GByteArray *array, size_t len)
     return len;
 }
 
+/**
+ * gdb_get_regl: append @val in @buf using 32 or 64-bit, depending on target
+ *
+ * This function is legacy and deprecated, thus should not be used in new code.
+ */
+static inline int gdb_get_regl(GByteArray *buf, uint64_t val)
+{
+    if (target_long_bits() == 64) {
+        return gdb_get_reg64(buf, val);
+    } else {
+        return gdb_get_reg32(buf, val);
+    }
+}
+
 /**
  * gdb_get_reg_ptr: get pointer to start of last element
  * @len: length of element
@@ -101,12 +115,4 @@ static inline uint8_t *gdb_get_reg_ptr(GByteArray *buf, int len)
     return buf->data + buf->len - len;
 }
 
-#ifdef COMPILING_PER_TARGET
-#if TARGET_LONG_BITS == 64
-#define gdb_get_regl(buf, val) gdb_get_reg64(buf, val)
-#else
-#define gdb_get_regl(buf, val) gdb_get_reg32(buf, val)
-#endif
-#endif /* COMPILING_PER_TARGET */
-
 #endif /* _GDBSTUB_HELPERS_H_ */
-- 
2.52.0


