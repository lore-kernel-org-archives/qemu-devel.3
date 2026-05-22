Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2CFCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUb9-00058P-1Z; Fri, 22 May 2026 14:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUb5-0004wK-S9
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:47 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUb3-0005Rb-Ri
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:47 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ba0fc8b1f0so54828945ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474464; x=1780079264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W2TQZHGKVgc2bDrawkrfHaeofSO+VDdLDbwQhXEPuBw=;
 b=l6cx50e69pn8CVUOKszS7SFJwARrHJ5oe+2X+czOeKeuCRA6PJXKA6h35HHIHclSdY
 rrE/ePpwyidKxu06E5D8aImbWvrFYGFkY/9aj3VisoJ2d26JuA5iTZWJOIXHuv4xwN13
 +DLnczrWKcFdzAUcpRp+InrfkZy+ti15r64G/BgjWsEpKE/dChvHfhCpK0hJNx5a9W5M
 a6a7emB/GFBa0pQovLnOIHhWTsszCtmGChkQBGPZfcZ6ZkM4P8bZsvbZR93uwwuAHfFs
 JueIlXvHOrFNSeGnIsOjlVKMT9ok2ySA7cyideSB5zzFqEu2WZ+w8ijTVfjVhAuLAh3+
 sLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474464; x=1780079264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W2TQZHGKVgc2bDrawkrfHaeofSO+VDdLDbwQhXEPuBw=;
 b=PNNT86dYnNkg/BXe8by521x8KbIGK+Wc1SOBxhJTAcqzfEvN3myjJwdw0iY+P/9I4z
 mUeHH4HMxgFxyAXaEne6WldUwniMXwojwsTm79Gkhbv52OGd9lMc34HS7N/GWzgz6Sb7
 c7rC6Jox7EGyQaJpy0OpIaJ5mxj9N0IQsPp6iieoJzbqllVqzxl0v3NmKddkLp/Z8uq3
 eRgT7wsac9DJa3nzcMvUkWBuTPG3vZBkI1XXsQZw6J49q6TcU2TSbqgKur4q8COVdvfZ
 Yovjmyy7H2KDheGbRWsWbmJ+Tv7jzSUJSSIOwc7SSO+vk/a2RA2YN5Q8FP0BsbOZwO2v
 CODA==
X-Gm-Message-State: AOJu0YyTG1512skAP/XXPJRE++rTc99NMjI2rkEp7jy1415E/HgDOpAI
 oQsPyWqSuNZgDVijHDBsvSwSPGt8zCHfFJ8bgIw/A5Og+BGBifS5oHclDjzzZzTuJTkVOY4PAWn
 LxWyr
X-Gm-Gg: Acq92OHSUzP4d1PmMks3+UKpZ/6PekM/1RyqWxbl62WlSMVO6o6IKeX5UuFh/fjUa/A
 Pf2LN+/9Koj1HfDQHc90TzlOaaXrtUgqzYVpohdJfvlGhc8rnx8KtE2Sv/0fNT5HrauF/bFAF4C
 l53yJffS+IrtaWob1ymU0m6J0bO5j85YVtK1utpULoOWrS9m++CmbURXZ9vDqE9azmc+IpESLYB
 OHK2CP3NFF70EU5d1eHKNikZt5TJG3uIlTNw2rYY0DNmcC2T6pEvNSADDQrrE5TSIgS2AHuE0bm
 ZdfaqLUfc5A2znROwFCrOq3e7UVXXSOIxhILkylTkm11CJ31Si13C0efSoN67oqoK8+YJYGRi5K
 ArGtNGQbffVOm19UyMgBU9oft6Vh7lQhxwXwOksNJ8dHkrO/ho0iD4gqmME3va4bUKAexkTeuYh
 KgyJgA0MmSDQoApP96Y4hwlxVL8aXQ
X-Received: by 2002:a17:903:4b48:b0:2bd:ba75:81c4 with SMTP id
 d9443c01a7336-2beb05d9d4cmr54456415ad.13.1779474464072; 
 Fri, 22 May 2026 11:27:44 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/30] fpu: Use get_float_infzeronan_rule in
 partsN_pick_nan_muladd
Date: Fri, 22 May 2026 11:26:47 -0700
Message-ID: <20260522182658.184604-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Deduplicate the uses to a local variable.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 7781e16122..1e92251761 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -122,14 +122,14 @@ static FloatPartsN partsN(pick_nan_muladd)(const FloatPartsN *a,
 {
     bool infzero = (ab_mask == float_cmask_infzero);
     bool have_snan = (abc_mask & float_cmask_snan);
+    FloatInfZeroNaNRule izn_rule = get_float_infzeronan_rule(s);
     const FloatPartsN *ret;
 
     if (unlikely(have_snan)) {
         float_raise(float_flag_invalid | float_flag_invalid_snan, s);
     }
 
-    if (infzero &&
-        !(s->float_infzeronan_rule & float_infzeronan_suppress_invalid)) {
+    if (infzero && !(izn_rule & float_infzeronan_suppress_invalid)) {
         /* This is (0 * inf) + NaN or (inf * 0) + NaN */
         float_raise(float_flag_invalid | float_flag_invalid_imz, s);
     }
@@ -147,7 +147,7 @@ static FloatPartsN partsN(pick_nan_muladd)(const FloatPartsN *a,
          * Inf * 0 + NaN -- some implementations return the
          * default NaN here, and some return the input NaN.
          */
-        switch (s->float_infzeronan_rule & ~float_infzeronan_suppress_invalid) {
+        switch (izn_rule & ~float_infzeronan_suppress_invalid) {
         case float_infzeronan_dnan_never:
             break;
         case float_infzeronan_dnan_always:
-- 
2.43.0


