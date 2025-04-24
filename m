Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C891C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 19:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u81vK-0007A3-7S; Thu, 24 Apr 2025 15:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u81vI-00079i-2x
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 15:07:48 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u81vF-0004Ce-Vm
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 15:07:47 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b170c99aa49so161409a12.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 12:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745521664; x=1746126464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HJ9sPyximszoDA396q//Z4bBOWFO0sGUqs8F8G0y3aw=;
 b=xkRDOu2x0jDE5UrDDMv5SFU31izN5nDQx7cJN51WmpP/r3gWs58TjfnHziU8shzIwO
 wuRuspHo74mN22OgNOV6zofKo/tavarBDK0b32fHcF2N76ZzpsRXL+vDTVJ/izJFiDzD
 rjXjXfpxI9MVHQrsHo/oa6UF3PVo0jUUtVQ9/rBrHuelP2a/oQy9GuOfEiwqyZEEYNTm
 hvD2eeYsObe+3+cEKntKnts9BEYEf2Wy5so5AmZfUk8nT7YpjxxH03KUn0eH78oPRUW9
 6T23cL0ApavThNu/ycXq9ZxIJwD5bsAXpFc+wCXERZzg3r7ppRUKHvDthFB6YCfSVY7W
 ggnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745521664; x=1746126464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HJ9sPyximszoDA396q//Z4bBOWFO0sGUqs8F8G0y3aw=;
 b=M9w1Ixez35tUrIhJfVFsAUjCCbdvu9EKNb1HRVjWuDJr6jsCAT2ifUT7xwiM4uLOiI
 XTNSNeDw2KJao9eH2EhYftTRGbQRS2gqMUq+NWBlUpIpEzu7y7XcwgVgkH90Vg3oS4K7
 9ByNK6eJD2HIlGR0g3pt2Ih/8uMRJ5Y7SzoIViDqeCKvbyFaNAfD3/B+NdeIH4pgf1CV
 b3n/zcayBF3dd2x8MxOc1+9y8Z8htsM0fGeNo0wuxaORwBG1xaegQB+/buL8mbrtQ/Bv
 fhLobUEDU7Ec+4yK2sYNpiYxZpzOyn2sMZNKGGEbUw0R4szmdVVZMZoFDUvPz0+XWhF7
 N4hg==
X-Gm-Message-State: AOJu0YzCAmhnX1yyMrnkAY1UQxgkBC9mvsJdoL81JIJqjlhPyI6Kt8qR
 OK602RehS07vuwX9gExBAtxTS+oDYmBp5nK21N8XDlfrmW/AnQXg5LCXHsQZpR+9NnR9XqEGK1+
 6
X-Gm-Gg: ASbGncvecO4tZg6rPP8KratbsFUNVYiOsFE/Q+PJRQaVPiUS3P4kmq+CRPpRpnrjK4k
 9o7saAzFSKVekJGRDi7wVJFWwHCQrJdCELUJOb5gyFyXigUOEy5NAYx9woaMdxrPiE1zCywyajw
 6z+e1dU2gQDGlFST6WV6nYXdXKQOoI4zF0HTqSYuCvyjreNYMthhNciXvKRj2aJxiJT7DFhAsNJ
 w4wiFn5EzBgFEO5XokQNAM6uIU6F4PNfISv4gNp9uSPmjcty96DePrgesproNDWTYMUL+L7M/1/
 lHvFMYdmMV19KgnWh64n1ulCA6iDPAdzD9wGCRMVcw+ZlTY0dtAJxF9FKcHovxgwooXnLVu5uNY
 oP7ipDzEXlg==
X-Google-Smtp-Source: AGHT+IF9WH/RsFX2Pgg77X3ZiWfECy4e7uQHDGBEdMwaI8VIKk+DA1ThqaISpUq2CL80JYhhbqimfg==
X-Received: by 2002:a05:6a21:3102:b0:1fe:90c5:7cfb with SMTP id
 adf61e73a8af0-20444f2e8c0mr5734733637.27.1745521663982; 
 Thu, 24 Apr 2025 12:07:43 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259134d5sm1846463b3a.19.2025.04.24.12.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 12:07:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name
Subject: [PATCH 1/2] tcg/loongarch64: Fix vec_val computation in
 tcg_target_const_match
Date: Thu, 24 Apr 2025 12:07:40 -0700
Message-ID: <20250424190741.738515-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424190741.738515-1-richard.henderson@linaro.org>
References: <20250424190741.738515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Only use vece for a vector constant.  This avoids an assertion
failure in sextract64 when vece contains garbage.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index cbd7642b58..740b7c264d 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -211,12 +211,14 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_WSZ) && val == (type == TCG_TYPE_I32 ? 32 : 64)) {
         return true;
     }
-    int64_t vec_val = sextract64(val, 0, 8 << vece);
-    if ((ct & TCG_CT_CONST_VCMP) && -0x10 <= vec_val && vec_val <= 0x1f) {
-        return true;
-    }
-    if ((ct & TCG_CT_CONST_VADD) && -0x1f <= vec_val && vec_val <= 0x1f) {
-        return true;
+    if (ct & (TCG_CT_CONST_VCMP | TCG_CT_CONST_VADD)) {
+        int64_t vec_val = sextract64(val, 0, 8 << vece);
+        if ((ct & TCG_CT_CONST_VCMP) && -0x10 <= vec_val && vec_val <= 0x1f) {
+            return true;
+        }
+        if ((ct & TCG_CT_CONST_VADD) && -0x1f <= vec_val && vec_val <= 0x1f) {
+            return true;
+        }
     }
     return false;
 }
-- 
2.43.0


