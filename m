Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F26CCD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUbD-0005Lw-C7; Fri, 22 May 2026 14:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUbB-0005GY-Ks
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:53 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUb9-0005Z1-Na
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:53 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3664df32e91so8570877a91.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474470; x=1780079270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Y9B6zT/mx2Mvzh7dN19S7ANCk8vGCeBaMnJS1JCxZ8=;
 b=m+vMJOJT2Asc6SoSMKkHPpuJC03Xy0REv0oxYpuxppvP7sNbJclwaAmSGz/Cw2tHpf
 3RIxKGNTHQoqP3Edi8d+ZAgtf6negmOwN5k8S97/EeHvcU4UEE3v26for08RbukKrOwp
 t/yQqpyIkxxo5Bxim7N2HpBj1KTjNL/8/aokXWdfUex672XZj0skVOz8zRjBJSlf5mt7
 pAPe0Xa/M2dAv/DUkV+NwtL1HkzTL2g/Z0+BocfDbf0vl2YaMuNDTvUDb/pUmmlM7Ksl
 xCYiapOr2miS7Oy091+n3yi6SO3Z08r6PHNXLCprRdnbjyqUJzTVSqBnmu1HLVDLa/HK
 Huqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474470; x=1780079270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2Y9B6zT/mx2Mvzh7dN19S7ANCk8vGCeBaMnJS1JCxZ8=;
 b=SS1P+oozTF2UQgD4gdfSgJHz2PWaU/aM/S/2KL+ccmp/rdqDHMB3gPMMSz/qhxZP1p
 qTpmiuc+xU6PpTLky9nU0kUhxfzz54RzMHBjh6+vyV7jt7AHgOxFpwsGoM0GpOvg2KOc
 0ObGpgjZ+wYMaiS1NFoCcPeE7uOjebmbccbm8rtJPGSKa7qfI7PZP9wGIIt5Ni2ogxqh
 hZdsBynPUOm1lzlLJ0LsNm8R6SHCsm0tB4qOetu7fSeNJPZHU1dc1ZYM5/JMcqxy8pI7
 SySo1et2AAgz4Z+0vvPsIj5wcJUkH0as21fTiHzknmmnrktugw9psftanb5mFapcLYj1
 EOOg==
X-Gm-Message-State: AOJu0YzRAtBh0JVFALgudzRmemD9AXHKqeAFMrGcDpKGF9vl5+c7hoKP
 GpGfJ7QQchTW6XywUi8gUjNMbCbE//UHgVYrBtsBpRDEBfWjNJ+Q9kdm0Ky3r2Z9zn1yi11eD6h
 cqjc5
X-Gm-Gg: Acq92OETNh9cfEcuyVdI2OAJlG5swB5ryVC6QBb8nvrFmQnSkI8YzPJUdVsPSsJRGOa
 +xeRFkwwPddzw7Bt4ZUtWivcXGCPGGXnEffFgCu8S0bD2RYibRweTs+pQWrfQeN+Wjr9MzYEEBA
 goWiwwJAVHQY1AVLyJZCTewvkFnBMHf4sph+dEiqVL+X04uUiIKhA4U54kUydw5JVYq0mzXCROd
 q+fPDdLJQiMLmkL+VjeOEIdP8D9UvsOWfADWV0Y/h4c7kx2u55Iz5pM+0xRGfphXi4FKxIWAzQw
 YzCZfDPL01lYTe5kel3KsLpPmL/RbPJ2OySwOCu9mv02bZ5yOeqV8M/06sDgXFReYkXz5a7Vb/D
 EVOGKZL+sy1uMJEuoETP5yoTohsYiPbpPFg6q89CSxRkIBNiPKezcbPnVkMhp6+cDDaCEHG1bd8
 2hpuyJQZGLWdfW9LksoChZBqzdB1Ki
X-Received: by 2002:a17:903:2f06:b0:2bd:8dbb:293e with SMTP id
 d9443c01a7336-2beb0687bf1mr56368345ad.14.1779474470113; 
 Fri, 22 May 2026 11:27:50 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/30] fpu: Use get_float_default_nan_pattern in
 partsN_default_nan
Date: Fri, 22 May 2026 11:26:53 -0700
Message-ID: <20260522182658.184604-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Move get_float_default_nan_pattern to softfloat-specialize.c.inc,
since there are no external users.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-helpers.h | 5 -----
 fpu/softfloat-specialize.c.inc  | 7 ++++++-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index d36e3a24b1..49e04ffee9 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -172,11 +172,6 @@ get_float_infzeronan_rule(const float_status *status)
     return status->float_infzeronan_rule;
 }
 
-static inline uint8_t get_float_default_nan_pattern(const float_status *status)
-{
-    return status->default_nan_pattern;
-}
-
 static inline bool get_flush_to_zero(const float_status *status)
 {
     return status->flush_to_zero;
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index bd6984282f..c1ed661f5e 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -89,6 +89,11 @@ static inline bool get_ftz_before_rounding(const float_status *status)
     return status->ftz_before_rounding;
 }
 
+static inline uint8_t get_float_default_nan_pattern(const float_status *status)
+{
+    return status->default_nan_pattern;
+}
+
 /*----------------------------------------------------------------------------
 | For the deconstructed floating-point with fraction FRAC, return true
 | if the fraction represents a signalling NaN; otherwise false.
@@ -121,7 +126,7 @@ FloatParts64 parts64_default_nan(float_status *status)
 {
     bool sign = 0;
     uint64_t frac;
-    uint8_t dnan_pattern = status->default_nan_pattern;
+    uint8_t dnan_pattern = get_float_default_nan_pattern(status);
 
     assert(dnan_pattern != 0);
 
-- 
2.43.0


