Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC15FF885C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzpF-0006kN-Tu; Sun, 26 Apr 2026 09:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznx-0005tL-QD
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:55 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznv-0001Rl-D1
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:48 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-358e3cc5e7eso5381692a91.0
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211143; x=1777815943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=naCDYMEynTNqx6TFzJKNSAiBh0vvryTyWBIKKZOB+4U=;
 b=RSEwYdXw0E+K97rtUu3Ud9GFV8R/KkrKWm1oqQTWg5AIHbNAyB8YQ+VRpdsvHR34SA
 +DYE2UN3gVeM7uuhu7xA6FA4XyDKSEu1RgIW9yRCDTS7jnasqBOw8IdiKHDhLXXQ1Dsw
 O7/1zzAWXNTOT/8Dif47JgytWFRekjdIZo2H6TlnI6rA3mKTI850fJuY7MOzn1MBnszq
 tMCjywZSWiCF8R9PddCfIRtfIPs4lKmjc7PyFlL5HbmPD11E3TlL7Qct2QwL9haZNxVQ
 uJKQR072957jkk9cK4LbkAIMpiSosAeLKTn0P4P1yCTLYnyXdsf9AHJikgc0EW30IrRm
 MgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211143; x=1777815943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=naCDYMEynTNqx6TFzJKNSAiBh0vvryTyWBIKKZOB+4U=;
 b=kATe24VBwOldihsxFO/AQk2uSsb2Mw65hhx58qfTLXGhKVls0kn14/bKifqC5BKqgd
 ZT9DGI5gBx7K7PWmmSn0Rn2wd3TthMaKfyF135RKO5BUS2aSQhzGfcKSF1COIZQjRb2g
 M3gut5VZ0CwA2YeYULriDVY2YTMubVFotw1CmuwbKZHEzHnZhoVgdyb6LXzT+4ximAb0
 bbdHG3+eUgKdA6gYIVGkabwUrOpdyMkvSImhpt6PL/No/FwJ6imwqpb2spRg9TtR34HV
 wCR2LNcWoCa5liF93O3AcqZ+zqT8t6NcFqWEpg/1VRF2WfbpQo34WMCXsgbI8GvJq4Q6
 ixQQ==
X-Gm-Message-State: AOJu0YzM+HF1kFAq3Nfn3fI41Su2zxm9ZUB205YJ+QkweIV+6EwfwuJ4
 2BtdjfZy6uR8gPgzs2Nrrv8o8vhO2f0RFf8hzYNFm6h10rBlWm5yLzLnP2TjzPi9c7EAjYia3/u
 05yCMkuM=
X-Gm-Gg: AeBDietMC2UwkxOvVFCQgwhMX+2OK7502g/+flf4X/flU5rzOOEqA7JEtQPmTd8qU2a
 BrsJXnHZUT1iy/87ZBv6CQo8pqvEFrq9XheEpMJouagvpgjawqVuYEhYY6+4n155aL0RoyJXn9e
 UqGNxUPoq0K0fw8NkJoksRuNWFwT8HNzJ6Bl00TLZz4pBlGSgqAv2ZUfCY78AuQvL0xJsb8ATHl
 /wgKXEikuyXlb5nQiBn6Qv8nDe83iThorMXOLdgXyTe9iGVE6+3JoBzPSEbLmiKIV8gY/xLn1d5
 hGz4jODSGklFpFUaV7AjcmDK6h/THVRejoYwP96rM1QlG5nHQqcaerUjOP9rf2wGMQNDc57N/fU
 I5LjkK2NX/aLtkPnPgF1l9/WxwgipgXAnc+bZi2ooHJpuEX6PQlxigOv6iQ/HWfOu0oQdOlVcB6
 3eftBeM0XsNHUKROsqdGCRjOPq2TYkkzh6aXlk/DnI
X-Received: by 2002:a17:90b:4b49:b0:35d:9560:3f09 with SMTP id
 98e67ed59e1d1-361404b8efbmr39132299a91.24.1777211143094; 
 Sun, 26 Apr 2026 06:45:43 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:45:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 56/84] fpu: Mark pack_raw64 QEMU_ALWAYS_INLINE
Date: Sun, 26 Apr 2026 23:39:33 +1000
Message-ID: <20260426134002.865628-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

This is almost always used with a constant FloatFmt,
so inlining pulls the constants into the shifts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 63697ab3db..8c4263bfe6 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -662,7 +662,8 @@ static FloatParts128 float128_unpack_raw(float128 f)
 }
 
 /* Pack a float from parts, but do not canonicalize.  */
-static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
+static inline uint64_t QEMU_ALWAYS_INLINE
+pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
 {
     const int f_size = fmt->frac_size;
     const int e_size = fmt->exp_size;
-- 
2.43.0


