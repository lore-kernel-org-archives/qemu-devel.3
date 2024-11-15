Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFCAD68BD7
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 21:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC3PS-0007er-56; Fri, 15 Nov 2024 15:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3PH-0007ZF-N9
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:59:09 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC3PG-0004PU-2c
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:59:07 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e2ed59a35eso1932844a91.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 12:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731704345; x=1732309145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fxcTZxhZywFRMG+M6n8lJ4VJTYPwmNxtcqO1U7kqV2E=;
 b=JZGPjQh/WxijMVtLaruEKpgbScUY/bHDVcuXezm6FowYobv3jJUEms2w3vf/S2CYNX
 +XZcj6ts05VeLZ002VboFKFlAvIJJSVqdWGPc/Y3ceVnrfGTiXyyimZRVPZCjQ51niAI
 B8LQwvBrcLjlpbFjnLTBnwKRAXlTViWQaEeuiwpuDkVYAFB8q2gDCEXwQ8JOKIXXE0fi
 IFX4T8uLf89WyWj22jfPSUBCRmAeIjVKaAXOXnkaYF6w2w48J/uYlEHu0lrwlRYmABdl
 BRUXaBClRoOfBYu762vJff7rUzBjskZq+CFChLc4agnY11gDcXB4H5ov3gBhCn2tzZfE
 GYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731704345; x=1732309145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fxcTZxhZywFRMG+M6n8lJ4VJTYPwmNxtcqO1U7kqV2E=;
 b=hGWnhlr5Vv/QkGM1El3DYxKoiXtRbgXM6QgU4QQ0UllRvyHdsbMQgnsfjyTq7brf5W
 FM5HnjevcGI1fN4E8flHArmJOmFtarVdOkIwnB/0a1nozPMsHv/jMJefNWoudm2R0fUv
 /ZHDoTBV6phz3/x74UB+scUvXptpoIQH/dpItw65PA5TJ//zAtdRBTG1CDeFrcuqOJGO
 oCtqDYuu/i/0KNJV4/wbPwclHkM4NQ38pNkY6L6O8aEqUsMMN2zjOZzKxjtZxzX/bREV
 1NtWp1/zJyjHBsRYsGNbkOQQsxerXbeJopscRjdafV7Q9iwPMmjohaLysBzk89qKx1d9
 DyTA==
X-Gm-Message-State: AOJu0Yx5ZCJqKVwHHzqvs6F+n3mC2gvoCzVzuyV1dmKeO5E0+vfRLWGC
 GZ2CfE06xjbmGYM1iMmX7EjS8CzMbtGTBJs8oYqxe3+ovJc22lb8fEzu2/9LfZAnMErNlH+fzLU
 m
X-Google-Smtp-Source: AGHT+IEMTuErARUNFvtmp+mC38i0MXj/5/Id0ZHviPLYtBQtltHN+HgepnshBHpHcW6R8IvKswL6qw==
X-Received: by 2002:a17:90b:17c2:b0:2e2:d74f:65b6 with SMTP id
 98e67ed59e1d1-2ea154f3f7amr5092146a91.10.1731704344668; 
 Fri, 15 Nov 2024 12:59:04 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024a49a8sm3362274a91.23.2024.11.15.12.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 12:59:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-stable@nongnu.org
Subject: [PULL 14/14] tcg: Allow top bit of SIMD_DATA_BITS to be set in
 simd_desc()
Date: Fri, 15 Nov 2024 12:58:49 -0800
Message-ID: <20241115205849.266094-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115205849.266094-1-richard.henderson@linaro.org>
References: <20241115205849.266094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In simd_desc() we create a SIMD descriptor from various pieces
including an arbitrary data value from the caller.  We try to
sanitize these to make sure everything will fit: the 'data' value
needs to fit in the SIMD_DATA_BITS (== 22) sized field.  However we
do that sanitizing with:
   tcg_debug_assert(data == sextract32(data, 0, SIMD_DATA_BITS));

This works for the case where the data is supposed to be considered
as a signed integer (which can then be returned via simd_data()).
However, some callers want to treat the data value as unsigned.

Specifically, for the Arm SVE operations, make_svemte_desc()
assembles a data value as a collection of fields, and it needs to use
all 22 bits.  Currently if MTE is enabled then its MTEDESC SIZEM1
field may have the most significant bit set, and then it will trip
this assertion.

Loosen the assertion so that we only check that the data value will
fit into the field in some way, either as a signed or as an unsigned
value.  This means we will fail to detect some kinds of bug in the
callers, but we won't spuriously assert for intentional use of the
data field as unsigned.

Cc: qemu-stable@nongnu.org
Fixes: db432672dc50e ("tcg: Add generic vector expanders")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2601
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20241115172515.1229393-1-peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 78ee1ced80..97e4df221a 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -88,7 +88,20 @@ uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data)
     uint32_t desc = 0;
 
     check_size_align(oprsz, maxsz, 0);
-    tcg_debug_assert(data == sextract32(data, 0, SIMD_DATA_BITS));
+
+    /*
+     * We want to check that 'data' will fit into SIMD_DATA_BITS.
+     * However, some callers want to treat the data as a signed
+     * value (which they can later get back with simd_data())
+     * and some want to treat it as an unsigned value.
+     * So here we assert only that the data will fit into the
+     * field in at least one way. This means that some invalid
+     * values from the caller will not be detected, e.g. if the
+     * caller wants to handle the value as a signed integer but
+     * incorrectly passes us 1 << (SIMD_DATA_BITS - 1).
+     */
+    tcg_debug_assert(data == sextract32(data, 0, SIMD_DATA_BITS) ||
+                     data == extract32(data, 0, SIMD_DATA_BITS));
 
     oprsz = (oprsz / 8) - 1;
     maxsz = (maxsz / 8) - 1;
-- 
2.43.0


