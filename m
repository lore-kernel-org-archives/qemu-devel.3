Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B83C83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGSE-0000ix-VZ; Mon, 30 Jun 2025 11:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRy-0000WM-19
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:47 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRj-0008GM-0E
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:40 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-73a9c5ccfcdso1264956a34.0
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297362; x=1751902162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PkpB8g1xUtpDEpvXKq6mCBd8Xvirz1+gexv6+2S738c=;
 b=IaqIqH6SGOGkU7OMbk+alG0ydLghS/mdIv00smyG4sbZCTADf5nHfHHBXPxnnb6OXU
 CP8/bEiWWor50ZTye/TLxqf4r67TKMWUO0syWuSkGuquGqMj7uQYYvWaa0b7uR4+kbVX
 XCOQ8Wdbc1e++sQ0t03q/64hkX7ImYSkg8GHhJyuVBmNJDl5F7JmaQsa6aO2QCf4mL6H
 8rYsByua68KHHb4/lQzGbpJKxQxBRgSjDWIBTnfaR51FkQPglpeFZ9pJYjoDcmLfXs3d
 ZT/21RaCZ4/ew6P9TosltH1IHxHS6T02TKqLVCoZAeCSR5HWJzXtgkmqJn8fA/UfR4GW
 WTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297362; x=1751902162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PkpB8g1xUtpDEpvXKq6mCBd8Xvirz1+gexv6+2S738c=;
 b=wokJdjpJq/bvchi+ffUn87PD4dfkcssdA/Wu6IZQ/+XeQ/gEjFHKIov09C+ea4Nc0e
 G/1RBcBBKprb0WAE4NBaaFujBAbYdqvEVD2LSd3QmpBUuyohndVeFUwU01DPCGFrzTgs
 9AL0m9aRfFte93Ya5g95x83mknfaxkks+6UwdGQxQf2avqE+1n0iUk47+gzNdnf3dvai
 QkmmpSuGvYBDjA3CA33KTxp+gBd/dcm1UcXLUuk9UFc0iyM3pKlShoeREN1TRfnZMvv/
 dgz3oG6XqGCQchJEmTwFIKQD8+q4wYK2btGuG9wH6J1Rs6SQLyv6iy7nKFeKBYfVjx6d
 ibAw==
X-Gm-Message-State: AOJu0YzxVguEn3FTpks8VHyaA6jxrRXXgHnnjo3WxrqGPaOVE1vjp/Ee
 R9zAut1yAXTPU6DBtj2tebQMQ6XTnCrdggOqQ/aA9OP4rjNuKbO1mfnmKWnUOucCzrvvlXtj+sT
 vaETu
X-Gm-Gg: ASbGncuf1DGGdrEqNlY8PCz2qdPJ+8CmZToEMULK+aKt+eDnaIVij30DIwGkAWOCOLN
 LRRT9T8MlVywOi6GTg5pO7e1k9p3Xu0dn4JYEe2CbBC463e36OM3ioHYhNMs1EEMVHNs6LyJK5b
 pokjnXXA9Ukm3Kx/SPzAD64EZYEyKx1eoP/F3zb4uK1Jeq/L6bhfJtnrEKGcBmwKZ8kDpnnWI+z
 odiQMqgs4jrrhbFmEQCbp+3PBcSxJk/QZe4q/7fD8S9/7JRBhEU68uLONpK4nFKO3m8u+dXwM/7
 mS+0mt86se083x6V3fdGmoUn0SwUa5ylrecR1Gl2CgZtyUPOd3/CV6MbMtk8bXXw/qwVg+K9vUo
 +zQwI
X-Google-Smtp-Source: AGHT+IFf992+JX6FvGus7lfydaB/KyCMPOPWsubM4mxQkl45aD0eKw89F7LCkYOmqPTmpknwrO6C4g==
X-Received: by 2002:a05:6830:8009:b0:735:b9db:5939 with SMTP id
 46e09a7af769-73afc3e703emr7373626a34.10.1751297362612; 
 Mon, 30 Jun 2025 08:29:22 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 27/29] tcg/optimize: Simplify fold_eqv constant checks
Date: Mon, 30 Jun 2025 09:28:53 -0600
Message-ID: <20250630152855.148018-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

Both cases are handled by fold_xor after conversion.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index a48ddd9171..62a128bc9b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1948,9 +1948,7 @@ static bool fold_eqv(OptContext *ctx, TCGOp *op)
     uint64_t z_mask, o_mask, s_mask;
     TempOptInfo *t1, *t2;
 
-    if (fold_const2_commutative(ctx, op) ||
-        fold_xi_to_x(ctx, op, -1) ||
-        fold_xi_to_not(ctx, op, 0)) {
+    if (fold_const2_commutative(ctx, op)) {
         return true;
     }
 
-- 
2.43.0


