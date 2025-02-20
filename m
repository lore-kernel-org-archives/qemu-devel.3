Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1839C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9JI-000770-Lo; Thu, 20 Feb 2025 11:22:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JG-00076H-LG
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:58 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JE-0008Ee-6U
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:58 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38f2f783e4dso1015675f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068514; x=1740673314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3YcYYepdVZAM4ELbnew2IIQe2TLsAeYlAjh/W6oMXKo=;
 b=CyXVwHJl3PwTAnXE5iI72AKvROAjbUPCGqiiUKBpdA4iAsnB0hpqrZoro4bclhGYCF
 kC7OcUb06QnLtpU2BvghrVhYhi6HjFXRN3EtgRcoS16MLS6wRJS+PH6fD1t49knPvP09
 YBanw3N7Kva4wIddujbP3ZIv030fCEC+REgvdK88xPWmUxfkGWVlrgHQ54Feqv34DSt1
 2zVI8T/CSNqyGNiHW9KQCWlBxgASaQ+hpHmwZmCgFGAdKBUzffb2hT5vOLA7Ev3L8GWN
 uyeMG5zNIHmTcoh0rB3sQI7gzZfLwhH6xN06ipQCfSedn3ixrtnhYHrLqf4jyHSuPp8p
 /xYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068514; x=1740673314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3YcYYepdVZAM4ELbnew2IIQe2TLsAeYlAjh/W6oMXKo=;
 b=d91Os/dP0dU2KBtOU5LYexUEAZnMahqQAyyuaq/uX5J4ZxtCdQMpFPsIMUzXa449hB
 sPdfT//zxDqpLuck40mMSmXWlaSLS9ZyuvV+TQAHssYpT+zVT01BYgGnuQBhVoNPmIrE
 Dqb67rzQ7b2zp+ZAhSYPyjDeL20QrI5pPE+8nor2612ueFb/sdPLT60j7z+ndrJlA68Y
 rAKbyZpEUHY+XfYqfCAvPmS2uXYhqgPgpzY9zdWjIs3UrYno7R5BuucijerkTwir/XQU
 UPXR2GTZtEJS+0oRyvAUvMHXccg3dIkY5c4MDE+AfdrFdTzXVSOiB71OFODfctzb8LUd
 Ma9w==
X-Gm-Message-State: AOJu0YzA1oQR1tnb5oqee25ee+zp0JAkaP08she4x6w+fxxxIWioK9cb
 3Jrm0BltZjtRZmNcg0JVgTV8ZGjXUselmSSHTlPm6z6xO61WgRNjSWICPQXkPZS3Lg2kL+Z7w9o
 5
X-Gm-Gg: ASbGncuZCLBFIXkak+xi8NnMUhI9UKlFd2L9ZrUURGJE1+DgLwqRgyG3sieWTGrdhQK
 RZqMDKd1wg/fmXIQEYV/nnozOooJNY0iTkpOd4reurpBym4AqBaHrAm/4W753+2MWYqpj3AaCTX
 6h6ym8KiE0IOhJVi0oCWWlW/TvGKCOKndVki88vYJ3XKVzfriYhuFi1hj+lysTufvmkba92DPiJ
 DqZk5nOF1ToC4HajoYmnc0ElHZAcpPaUm7vGkImGToEilbJkh7AtezDuhaXv519lY/lJ2kgjUdn
 KBK/V3Fhx93/qvtXgRHyng==
X-Google-Smtp-Source: AGHT+IEKo+axCqEKC2pyTUx+fbnxOk1wdgV5jjJitH6nUCHx6aa9anrIBLmzZ3xs2bRT8PmU0Is0Jg==
X-Received: by 2002:a5d:4002:0:b0:38f:31fe:6d4f with SMTP id
 ffacd0b85a97d-38f587ca5dfmr6060572f8f.34.1740068514504; 
 Thu, 20 Feb 2025 08:21:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/41] target/arm: Use uint32_t in t32_expandimm_imm()
Date: Thu, 20 Feb 2025 16:21:05 +0000
Message-ID: <20250220162123.626941-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Stephen Longfield <slongfield@google.com>

In t32_expandimm_imm(), we take an 8 bit value XY and construct a
32-bit value which might be of the form XY, 00XY00XY, XY00XY00, or
XYXYXYXY.  We do this with multiplications, and we use an 'int' type.
For the cases where we're setting the high byte of the 32-bit value
to XY, this means that we do an integer multiplication that might
overflow, and rely on the -fwrapv semantics to keep this from being
undefined behaviour.

It's clearer to use an unsigned type here, because we're really
doing operations on the value considered as a set of bits. The
result is the same.

The return value from the function remains 'int', because this
is a decodetree !function function, and follows the API for those
functions.

Signed-off-by: Stephen Longfield <slongfield@google.com>
Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
Message-id: 20250219165534.3387376-1-slongfield@google.com
[PMM: Rewrote the commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 68ac3934153..d8225b77c8c 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3510,7 +3510,7 @@ static int t32_expandimm_rot(DisasContext *s, int x)
 /* Return the unrotated immediate from T32ExpandImm.  */
 static int t32_expandimm_imm(DisasContext *s, int x)
 {
-    int imm = extract32(x, 0, 8);
+    uint32_t imm = extract32(x, 0, 8);
 
     switch (extract32(x, 8, 4)) {
     case 0: /* XY */
-- 
2.43.0


