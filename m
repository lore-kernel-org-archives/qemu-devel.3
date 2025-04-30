Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA26C3ABAA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 23:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAGVz-0001nJ-OH; Wed, 30 Apr 2025 19:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAGVi-0001hh-Pz
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 19:06:38 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAGVf-0007V9-Tq
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 19:06:38 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736bfa487c3so421470b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 16:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746054394; x=1746659194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AYLcw77q0drDQnqkv5fH2XhRnVGB7EFd56psZWVXXSQ=;
 b=UCcS70t45pR+lIozrmNqYyaJ+EwpwFM5FemJA2JgPZPXlcJeB8GH7ScUnQqavyHrqZ
 LKLUEtelbaGzN/6Ax/vwVwef5uKf3G91hEMxG6I5880vMFmDTBqkrBbOZNPB7iAHUbIh
 q1CXE/sKG0exHb+gg2CNEncyFg9kY4f99ol5pM9e4S72m1A17XpImGGSIZ3of6NrdIVl
 wvkm2QWBM6zgZUkEkjvjWMwwrj8GSzCpd8PqYiU6U/VFGHg7iRljiyFfwX55VqpIO14a
 tpgZ1Ratdsi7CPMYVIoMGhvJIApDMntZamFXxD1XurprD6JZYh/c5hZCm65jhDRxz7bs
 EkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746054394; x=1746659194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AYLcw77q0drDQnqkv5fH2XhRnVGB7EFd56psZWVXXSQ=;
 b=TtbC3CbPCIXVVYOu5Az/3NeMl6p5zvQwSsUURZVuhxtakJmDG3FjNKwzBPBgmCIDUq
 1NqmJIOc/aOuFplM8jvJE4UvwJxWHtAvvMfZ8bOGhVbkeCwRAaAAgh34dRCzmEyoMmP9
 vhirbILWMTt3t4+6Aw99sAFgkLK3LEX9cXrftMIJqf3DcdUp0Tv+bpcZjQkqt2QYngvE
 0Q4cIaE88QDYrLIidHNcLz8UJ1QfMxiHYG7FWeVRNzRo+pFRItEoIZYwWadinOY0nKfu
 2kKS1uTE0DADqHiheZ80amZdm8bsLHUJ9IP/5lYeLqu+f9XFOatOx9yGb/v3EznPjNhy
 WudQ==
X-Gm-Message-State: AOJu0Yzovl5kkEgR2IO/vfE+hUuLzmnisd3//fST3Qvmaknm9waK4FQD
 MMuU4crtY1PWKYd8iAT+vv2509m3un5hs25svsppAWrnuhaio6CrzDU1MXfgybOqyPRgEIcm9Aw
 X
X-Gm-Gg: ASbGncuHDQmkFFfF/TfqsKv2UeJqG+3qHQUA4AQEIItb/VioEwAPZF/y4MMADzzT4LL
 kxVnVu4lo/J20gCXXNwo1K8F2evzfx0WANgAjzWsuRjJ4W1prgsvhJm4stoGCHt6klS5Eii1fDB
 zDLYKrCe1IyLz3Bea2mp1NMUm7uXht28Jo5P3anLJeS/KOA4DwYArjcHL69W6QC3xGDl4dU4dUa
 jT8UkJq9u2p+bmvFFX4Gq5qyuevE7iwfamaq9kVndOs4sJLVU32WVsrG8nDGe6KgLx2gDrtuRjP
 xNewODYC1Vt7ybzIW9Z5EwwT3pX3V87Ev7aNNujX6PVpoe9unrKUof5YWC1A3GEFUvgCMcR6Tzo
 =
X-Google-Smtp-Source: AGHT+IFPfAcihB4qtMgBZ8eLfk/cjhfgx1AH4s9kGNRHa4zyr15xPVIeOxkQrDgmhUGuyPvHGi1AvA==
X-Received: by 2002:a05:6a00:1909:b0:736:62a8:e52d with SMTP id
 d2e1a72fcca58-7403a7a4c90mr6599466b3a.12.1746054394368; 
 Wed, 30 Apr 2025 16:06:34 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74039a30e2fsm2323287b3a.103.2025.04.30.16.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 16:06:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 2/6] accel/tcg: Don't use TARGET_LONG_BITS in decode_sleb128
Date: Wed, 30 Apr 2025 16:06:27 -0700
Message-ID: <20250430230631.2571291-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430230631.2571291-1-richard.henderson@linaro.org>
References: <20250430230631.2571291-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

When we changed decode_sleb128 from target_long to
int64_t, we failed to adjust the shift limit.

Cc: qemu-stable@nongnu.org
Fixes: c9ad8d27caa ("tcg: Widen gen_insn_data to uint64_t")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index fa4998b341..acf32e6c08 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -109,7 +109,7 @@ static int64_t decode_sleb128(const uint8_t **pp)
         val |= (int64_t)(byte & 0x7f) << shift;
         shift += 7;
     } while (byte & 0x80);
-    if (shift < TARGET_LONG_BITS && (byte & 0x40)) {
+    if (shift < 64 && (byte & 0x40)) {
         val |= -(int64_t)1 << shift;
     }
 
-- 
2.43.0


