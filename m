Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F69CC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCS-0007OC-SL; Tue, 18 Aug 2026 13:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCR-0007NK-1P
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:07 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCP-0004eU-BF
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:06 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cbb8b54fcf8so21848a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072524; x=1787677324; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HF2JgYSJpxkYVVHW/A3tvsecVR7wZcA0ZMW7syqYu74=;
 b=FbF0bo6oAhjV9KYxyS81/MSevat7pzzIf3gv0ALyP5PbjTzOEnRa9pSFDuDkA/TdF6
 XAmMG6hZsVBdhJ8fqpaO6dT09jCQ2HXxYDRzcFBLbGrslJxp0aMzkJp5e/VDqI1cDsAo
 HVxtHtm7PYbO5T/Bub/0wkH+xpS8ObCGK+y9bY+mysDbDrSBUYyiesWChKIx25VCpfD4
 q2vJFij487ZmEG89tNbw9FCxKqAvlh+Y5S1H4voz9Phn2FUPt+zFrxzr14o8gUjSnK0E
 z7CmmIqRNq4Ls9eMqJjlOtWZlbqLb1SFjRq/cyZxjfyPvNBkpFRAHSUkB1xQoRsLhMLj
 30cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072524; x=1787677324;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HF2JgYSJpxkYVVHW/A3tvsecVR7wZcA0ZMW7syqYu74=;
 b=pAFknlhmDhw9cnFlnjpD/oTHHkhshg41NXWDmTYyWJPp8FFOI1seIhYkb16CZpoXUv
 2u3w+GIdGkV01R6WQxMv1UQzXsW3Td7/uiTvJnwwsf6+JwpmY78IkwK2RkZJLpAfXbe5
 LVxtQAIfhYkbmStvnQnU1cvCNGKVGyx7i/XKpl3W/5DwPMGpNrHVfRQyofVE55dIpeBi
 Gx3Rx3obY+GDCfmdtsKQdj1P/vTw/FFS0NlmrRTVkMayxf97v9rGB9fp9ZAHY7Kuv1NW
 1tfEjB7m88uQ0rmqoL6IYhU4EgSbY7WcVLM2bqBcUtWYMZ1789hZHA6H+TDImraEsNlA
 wnug==
X-Gm-Message-State: AOJu0Yx4E/WEVGIhJzSKTL/7NnTMlzGoPoweywdBG/y0o9n4fM5t3wq1
 3Ng/HiRaFoaefhyFufdmf6ZpuqNNmZLU9T/tFBd6bHMvMlZUchSwmVak3wIo8+Z6DvG2atl7sXf
 ue3oWRg4=
X-Gm-Gg: AR+sD13udNnYpmnM2smpP4eqeXGyjjDYrAsh2ValVO1zasRkqIxo6nhzzEbH+j7beGU
 RAC8+dDQ/+QbyRNfpkyDL5yR+ocj8LTg1diTbnUz3r+LyLf2EHtlxxUL8Ydr4k9bhn+45KgYUy+
 ubAAJA4kupyKhmLnQdS6UHEw2vucnHA0rr9oJR6iUwBUGIfdkQF6WJlpD2t4Yp4i2bKAJ0f78Yu
 zdvKVdVmJFvmKLKKuzfdwpy6xtMsH9RthkVJZIzaOrVN8fD9rEE9ex4H3AxOZ1LcMpncYXWT1MK
 sw9VoqPQKn67fkeZ0rN5YRqwrG4yvaQBt2Jbwk+ewjHIh8pvKBP544zVMDw6YMszXQUA5otTASa
 3ahqG2pWUqmp2NNMwWlIgrg4WiO9U7MBVO61pKCeC+rhSHoTg+OcemI0nad+KqlNb6vTfY+S/++
 /F+M9virVwStj/BCa98OX5A627iZtV6V0Hs/0z0f92cpcdkaYixVM4rK9mmM7r2meNtXcQC5Z+O
 7gMifb4nfSVWY4IDngvyexCSFL8RqcoWJ0=
X-Received: by 2002:a05:6a00:338d:b0:848:6c1c:17c0 with SMTP id
 d2e1a72fcca58-851b88c8425mr14729415b3a.19.1787072523830; 
 Tue, 18 Aug 2026 10:02:03 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 04/38] tcg: Return success from tcg_region_alloc__locked
Date: Tue, 18 Aug 2026 10:01:21 -0700
Message-ID: <20260818170155.1907006-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Invert the sense of the boolean result from 'error' to 'success'.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/region.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tcg/region.c b/tcg/region.c
index 5d4be1453b..2161d961d9 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -360,11 +360,11 @@ static void tcg_region_assign(TCGContext *s, size_t curr_region)
 static bool tcg_region_alloc__locked(TCGContext *s)
 {
     if (region.current == region.n) {
-        return true;
+        return false;
     }
     tcg_region_assign(s, region.current);
     region.current++;
-    return false;
+    return true;
 }
 
 /*
@@ -373,17 +373,17 @@ static bool tcg_region_alloc__locked(TCGContext *s)
  */
 bool tcg_region_alloc(TCGContext *s)
 {
-    bool err;
+    bool ok;
     /* read the region size now; alloc__locked will overwrite it on success */
     size_t size_full = s->code_gen_buffer_size;
 
     qemu_mutex_lock(&region.lock);
-    err = tcg_region_alloc__locked(s);
-    if (!err) {
+    ok = tcg_region_alloc__locked(s);
+    if (ok) {
         region.agg_size_full += size_full - TCG_HIGHWATER;
     }
     qemu_mutex_unlock(&region.lock);
-    return err;
+    return !ok;
 }
 
 /*
@@ -392,8 +392,8 @@ bool tcg_region_alloc(TCGContext *s)
  */
 static void tcg_region_initial_alloc__locked(TCGContext *s)
 {
-    bool err = tcg_region_alloc__locked(s);
-    g_assert(!err);
+    bool ok = tcg_region_alloc__locked(s);
+    g_assert(ok);
 }
 
 void tcg_region_initial_alloc(TCGContext *s)
-- 
2.43.0


