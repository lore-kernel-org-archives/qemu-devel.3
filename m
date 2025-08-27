Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE22CA0FF6
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4dn-0000AG-Fq; Tue, 26 Aug 2025 21:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4cn-00056n-UH
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:06:56 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4cT-0007M4-Cz
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:06:53 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-77201f3d389so997241b3a.2
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256767; x=1756861567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MNK4RwSNEHIMPmqrD7172d7GDCHMVFkY8KsTfaRpDOY=;
 b=BgQ2IwHwYVxDlQxMJuTje087F4wF2m50loT7a3NNMMANhiM4D6miSeqKF+gWoL0l40
 5Y/CiuitWE3I4z+8VE6Px38gf/QO6Ze5AwfBxTNSz98ii7Q9DupLSCsNqgeJujF0qwK0
 xLQl7S6I/eqy3Vxz9WZDTqleaV1QrxF/FDUEB9F79aXkuuB2auSJq8UQHneatdGub3x9
 xlc00+7cam2ACYlVXQ9K080Bys8Ui29k+LmrkCJ7MTIP3Sr7JKK2M3aXIB+IwshD/A4L
 ofX1md3NDvjbwdGpRJW3rJfeF1iPF8+691/vKFeVlR8pbdpGpuQIVgQwch2quqQeTa4E
 jXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256767; x=1756861567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MNK4RwSNEHIMPmqrD7172d7GDCHMVFkY8KsTfaRpDOY=;
 b=UPUkAW/IQgg/Ix6oijsd848W7Fa3fT/7sRCvq0+h38mucqMy1mNhXe6mqGtKwvs6M/
 BOg8MDhQWJYwREkboxHjOn7fwWM3TgDGYQ7uOTohe8jjvaV2Ch8KFE+gcrfunWambWle
 a7b+pOpjLsXNfCPsYXhAf4h6GDEJRWRiePhUepJ4TA2LSBPgAAit+q9kiIOEEsMNrqY2
 OYzbQxvdgA8K5DxbSL5LuMdCJPNEe4F2z088AuSzYTm7ZPCRqu8MtIrewNwIzbc0+yP5
 mOiAL9zN+akaWZiRDcDJBTlRKZUW+2JbLyPjZCY1w2lJO5zRm2gq7J+GDRwNuMjOP0yY
 TKiQ==
X-Gm-Message-State: AOJu0YwBYEl5N8z+cN54rxs/9TPO6qOW9H2BXxGy3UiuHsRFRsGSUly6
 rymH5u6dn8kSXDSGZdAfpztHmQNrvBp38gkpQXpAY7z/azhCaP4wVS1kC9ygHTgQNmXmw9BuDKb
 vcMU0MVs=
X-Gm-Gg: ASbGncvJjAjs/O3WZnSB5p/MKtyFhm4iAfQWGjvO6kdDL5u0x9kJOXKTlwE3k7XduKA
 y2cVc83TcTvb+vwsS+3IT+26dQd2eGLGvrILYL3LbvSn5tpJ3zvcvIIAnxgn5i2O7FbMFUawM/8
 3gzU8yG+s0HDHR5WhgPLxjV0qIGjj/6/Z1+GhlNGChAm3G5lcXNwwmYESAV+GFntux8RK11x37/
 VTmGMJnNga7ZekMY0KVoVizpNNRd7N6V6DF6RgVn9nZ7x8NAxu00cGDgcsPyP5qUwGt9lz4MNbj
 9j62V8+FTb4NkG9zmy1daGYpOb7uSeSmK0cjzbzbL2E7bkUPMZ6YEo7CwSbK7SekdI/pqX32sSW
 ddKl1nIMZK2PwfeOjxqBEayE19tJGYvTGshgV
X-Google-Smtp-Source: AGHT+IFLUsyh29Y1qWYTaS6y/mX+P7docc8VUfhYLI2Redz8MulE8ZzdVpvAM2bW5WKOWkud/xJWIw==
X-Received: by 2002:a05:6a00:138c:b0:770:2c2f:6435 with SMTP id
 d2e1a72fcca58-7702faafbcemr21147179b3a.20.1756256764783; 
 Tue, 26 Aug 2025 18:06:04 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:06:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 10/61] target/arm: Use raw_write in cp_reg_reset
Date: Wed, 27 Aug 2025 11:04:01 +1000
Message-ID: <20250827010453.4059782-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reduce the places that know about field types by 1.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e2b2337399..ed40e102fc 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -192,14 +192,8 @@ static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque)
      * This is basically only used for fields in non-core coprocessors
      * (like the pxa2xx ones).
      */
-    if (!ri->fieldoffset) {
-        return;
-    }
-
-    if (cpreg_field_is_64bit(ri)) {
-        CPREG_FIELD64(&cpu->env, ri) = ri->resetvalue;
-    } else {
-        CPREG_FIELD32(&cpu->env, ri) = ri->resetvalue;
+    if (ri->fieldoffset) {
+        raw_write(&cpu->env, ri, ri->resetvalue);
     }
 }
 
-- 
2.43.0


