Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F13FCD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPO0K-0000cb-Dw; Tue, 19 May 2026 13:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPO0I-0000bZ-RH
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:13:14 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPO0H-0007RV-8g
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:13:14 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so2339047f8f.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 10:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779210791; x=1779815591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WXgDhE7kozuJ/9LR8qnIVSwpmu8uvTaKscAokMnZ2aI=;
 b=M/z5y+RRVIPxzw5fdP0dRuUaNAEzkTFy8CG9VXGNx+CXpNANnL8rwgn+L3xv3189va
 tHIV4teOQbpb/PRb3MBvOhvbTj5ztlZEQTBxYnY9a/8/PhyCkhMvOupM2/w5cWjvHEH0
 9mp7NTVdEPMv0b7X9Bis8no42s5bSjDyjuxIfByl9Who0+mW5ekswTLtPxvM6+nf9wr4
 aiCz1FH3UosBJT1860PiGl75DK5UvkATtrNtkX+GgoX3KbWnuL89rb6b8rwt0XkaEZNO
 7WemQmiD7tUdO6yPKP9Hi8Mw/oV17ZI8wng4dyPViLY7HkSOpz1NHVLzifDJTvay3VNh
 ACOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779210791; x=1779815591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WXgDhE7kozuJ/9LR8qnIVSwpmu8uvTaKscAokMnZ2aI=;
 b=Z2LBdUTABo6Sz2vh20IUrp9lqCeMt9OWrQaqoABClTzA49ndvFeT5eGdQzilNyvdRc
 BygaIRKDizJDYf27iDWHib1X904FcJWNVYkWzgTkKuwf3hBkgeRrIFxVrmIsYGlQuoNK
 8oLitLKw2uaclfhfFfk4+jE22eiV0u2rdlcbRnK2lzuTXY6wofdwKN4EvncEeTGkAfiq
 Z29Do5f4fA6Xr1oZOsy41/v1YirdOR7ZXX1skOmbAFwu795xJFl66jpS21bW2UyemYPT
 Eb36rivA3klwcxlxm1hmpsGNyA78ZstctIYzac4POvkVNP5pCQimq0HjkNXK3z5AwOWt
 u6kg==
X-Gm-Message-State: AOJu0Yw2kVNwfkG/rTxBKCg0knD+yHWUR2o+jxe//I+dlBOdkdpHDsu/
 eFPA+MRgVBUaToykFd0Tq9yo1ln2hfTJ4RdVUFGCe8M1bThxPxdDG2s+6Ex0QQrFkesI2kSWUqg
 NWvopaBQ=
X-Gm-Gg: Acq92OEFCbYNUz+MOLrzllq9feSBa2VWBVB9lY1XXHzzWOy1H3ba0Amw4fsbUCf5ylc
 9W+rxdloacS6U7+46HYvaACFQLLPXe+GFrgoeetzmpDuzAPI0NCIF65snrsOzb/zNjuu0TAfM+K
 SzgJLk0tTEfFxQdEmxfHRHJ0gOhzDCtveNJ+zluOvrYf67R6MytgACQuVePnGjCm00xpOp4ew6d
 i5CWemsUuoTQU9E0jMOPpIwZNdWVXtg4Cymx4aeeg/mpUx6SKIyRIl4ePCPBceWQJHmnFmLRAGD
 cdV2uRrdtY3/3qel+pqNTTZPDkcwEHW58tkbwJE8woHkeQSUp4fcnvsLGfpSpHAk+3+cjxOGE2E
 qJgF330Ztkphyy+K2ytN5WBC+y+QyrRvpa3rQBaIy/Wmd01PkFyv00CVFT21ewiecSqIvPaoUiG
 LQ3/8zfjHHOqtiNZlgrcREs1Ke7CJjjQD2QhN5LQPPejZqF4tgxPufEzVnXSvuApgfKxV1vkC63
 ALzO1soJjM=
X-Received: by 2002:a05:600c:3e1b:b0:486:fd5c:2b35 with SMTP id
 5b1f17b1804b1-48fe60eccc3mr315897355e9.13.1779210791235; 
 Tue, 19 May 2026 10:13:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fead1c364sm110762695e9.8.2026.05.19.10.13.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 10:13:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org
Subject: [PATCH v2 4/4] tests/tcg: Explicitly check for 64-bit z/Architecture
Date: Tue, 19 May 2026 19:12:40 +0200
Message-ID: <20260519171240.97420-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519171240.97420-1-philmd@linaro.org>
References: <20260519171240.97420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

We do not support the 32-bit ESA/390 target, only the
64-bit z/Architecture.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/tcg/multiarch/nop_func.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/nop_func.h b/tests/tcg/multiarch/nop_func.h
index f714d210000..26d3a76eb62 100644
--- a/tests/tcg/multiarch/nop_func.h
+++ b/tests/tcg/multiarch/nop_func.h
@@ -15,7 +15,7 @@ static const char nop_func[] = {
     0x1e, 0xff, 0x2f, 0xe1,     /* bx lr */
 #elif defined(__riscv)
     0x67, 0x80, 0x00, 0x00,     /* ret */
-#elif defined(__s390__)
+#elif defined(__s390x__)
     0x07, 0xfe,                 /* br %r14 */
 #elif defined(__i386__) || defined(__x86_64__)
     0xc3,                       /* ret */
-- 
2.53.0


