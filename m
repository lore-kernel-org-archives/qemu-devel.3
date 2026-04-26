Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED575FF885C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzpc-00008X-Ny; Sun, 26 Apr 2026 09:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzon-0006PI-Pv
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:43 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzoj-0001nE-C5
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:39 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35d90833cacso5813232a91.2
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211195; x=1777815995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a0oqnYQ0u3G7vT144+M4wADIi602YyjTouglPnmTjXw=;
 b=nycIjDmFAL1kfqw6dgskcDpGv2/nzt3XarRLD37OXHZnqLtqddJeWvx0a3YjtdeSz3
 vsOWOqdv3vI5I6PbZ8Wrp0v/+m/VVwklHcgNcqMZ3Gu41P4hhVdI5CP7uy31U15ToXg/
 mXWhJALLkSwYFtp/3jMC/QfUaWPrTjK8DcanMAcjKfw596scIpPVAMjDFkjOjwOKFFqc
 YPOcQudOnPzP7cEofCcgXLqtiEZVBGuLWPD7JS6X/OAkCLaQRJMLhkmi9sV7/CMWXgn7
 TrNhcJExoZ6tXJ8pHleBYi+iBa8SH9Q8xQcnKh5L31OMhCG90AbLEhB3+SbCxo5Z4MU9
 WNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211195; x=1777815995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a0oqnYQ0u3G7vT144+M4wADIi602YyjTouglPnmTjXw=;
 b=AGHwlGq9yOmhsG8zcNPB88Ie1HgKye7CuYbv9x0+EcCmAG7sF/EiKUX9CnNB58N5tL
 8UrJpIvbFTam+fvCAIrbEJJ8RtdopTVAIhYA4o08CGriLAI9gJKXdymQ9BgshpewCQyv
 ltjeV8U6JTslw6V5M6Gg4UeKyzSVVjqlSZnAlDta5fe8sgisqxdTgssq0nguXjkY4rHM
 twqREHLIJtDE7Uy8NfwwRNX9YQHhhTnn44aYgGXLU81em3gq4icbhXakPcjWDm9NeB1g
 NPFXDK1oMXp3WL+PQa9yWTE9/gtClj4UaDMm0ZcpyHh2TlDaKp+OW07pENvRO2ovIU1/
 w+jw==
X-Gm-Message-State: AOJu0Yy8LVnmFZkLSDxB/jq/ZqoXteAlaEI/s0fsSQBf5VZVO0iSjVqp
 dBdKk96HzMnTNBoRaxHoW/Q0f7yX3GnlALGcmdxtpQ5srmMWb1blVCyFFvckRcLboJd9U3ct2y7
 RsaIoT9o=
X-Gm-Gg: AeBDiev2SCG5sULMTnZ7je900CFrujYZvEWwfIjqx8CYg2yzXyP9xG/+gBOCRlDIZ8T
 JDTlNhXfpGYoelTQjMHZFf4b6rRwhVTHPUTuDgCTs5X0+eodqbZf8QZGF1fSEokCywL2CXqdMlx
 wUKF++W1ME2Y5b3Jj45H5BQ0i4tL6AbQDrtXprEyQxDXNcCcSY+4Mrw1ZOlQ5sDliUYJmBUwjFe
 BSn/s6GR5IUOVe05BiPW9F+vsS2N9fH3D7OWVgFRfYnbZRp8o5J1QfwTOmWod31lFNBu+o0t2j1
 7rUkDNAPsYCSlXmDrI55kLDLVcfmHSBGqB3bz6RTh/Ncz045RK+IaP/jv75Ry7/Hnat5fS2XLJv
 OqIsFTz1Ex6vULUCqQhqBtxvUDDcfFH/2cHh5mesl4alwanAxHmMdWwAuVErWcOGgHCTQKpY1nD
 OW2Gc5rgeUaUJOsXB3vEjK6on7KJfT7CEChMMYLMxw
X-Received: by 2002:a17:903:98b:b0:2b0:7026:24bf with SMTP id
 d9443c01a7336-2b5f9eff280mr404285365ad.14.1777211195209; 
 Sun, 26 Apr 2026 06:46:35 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:46:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 76/84] fpu: Export parts{64,128}_compare
Date: Sun, 26 Apr 2026 23:39:53 +1000
Message-ID: <20260426134002.865628-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

At the same time, constify the inputs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h | 5 +++++
 fpu/softfloat-parts.c.inc     | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index 6416495eac..f8f96e2f68 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -184,6 +184,11 @@ FloatParts64 parts64_div(const FloatParts64 *a, const FloatParts64 *b,
 FloatParts128 parts128_div(const FloatParts128 *a, const FloatParts128 *b,
                            float_status *s);
 
+FloatRelation parts64_compare(const FloatParts64 *a, const FloatParts64 *b,
+                              float_status *s, bool quiet);
+FloatRelation parts128_compare(const FloatParts128 *a, const FloatParts128 *b,
+                               float_status *s, bool quiet);
+
 FloatParts64 parts64_muladd_scalbn(const FloatParts64 *a,
                                    const FloatParts64 *b,
                                    const FloatParts64 *c,
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index ab773ed241..fcb6b33f23 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1565,8 +1565,8 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
 /*
  * Floating point compare
  */
-static FloatRelation partsN(compare)(FloatPartsN *a, FloatPartsN *b,
-                                     float_status *s, bool is_quiet)
+FloatRelation partsN(compare)(const FloatPartsN *a, const FloatPartsN *b,
+                              float_status *s, bool is_quiet)
 {
     int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
 
-- 
2.43.0


