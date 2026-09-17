Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5E3C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Jo5-0002tw-Uo; Thu, 17 Sep 2026 17:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jo1-0002kt-QC
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:09 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jo0-0007lG-8k
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:09 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccd4f99cso151396a91.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789681087; x=1790285887; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Oc6cuIHlji7+n+x575hahb1FUhTJc0Cf36JajTQOk/Y=;
 b=kEKL2lXb+lDO7+0ve6Y8xC2/T6I3oDROzTPa/5n0eboUItrXx5u0P+r01/Pryk8VlR
 cxRtUEU9vOwgsU+Qbx4evz9PM/f7sACaf7PfUy5jRb/AdMlCpf39vC4SwOY8S59votKG
 LgwzkUZpz4tN6f5LXeDZxIcE+mN0JyKStumoPcVfLIjnQbLIpUxqfV7SgCtxKP8VI7f9
 LQRmt8ib9vtiLlKLBDoHtbi+VDPKODeJ12XhaYrM5XRSEnvZcMymKyc9J+6cgPmJhGW7
 gIYq7YFOc9XhyIcl2gApHbWQjwuzazKJstOxkQ9KAdsqHV4MN+WC/UBdYdcNCwzceXRa
 Pe5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789681087; x=1790285887;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Oc6cuIHlji7+n+x575hahb1FUhTJc0Cf36JajTQOk/Y=;
 b=WL6zSXf1/aGfNRgexYyQxGUJ2ut+TYPAazghy/oUc5oTLENgxQ0ZxsJNcHinhaOzkv
 xoNHfZrGp5QphE4cQzBn4+MLCRs6nqUYd3IPaZQ6CjRe0kJ1RlvP+deshgPTu62Wn6jK
 ok5VLstVB870oEWbtGjdSQoYowqWptq1mE+kQvg3n41DHJxYSRK59T7C1WIu3osxHMHy
 YXQqH10xwKmH+/6+KXc68XfOq1mBnmDazYBdyz308tKLrXmbiyGnW3IqpuhiL36wGZXP
 NQUmgwBPZhoDXTxexuI3BK9WOnDAHycD/B9sIgqWfShFCZEmwcsPESZAg1SuIZ9CFJL2
 Q5gw==
X-Gm-Message-State: AFuF++kuiwBlM57j3Qr68D+vQqy2v8oC6TpO619cKmkRP7kA2Eevo/4h
 c8xbOCM2tD5uFU8jcBhXIr+f4wbiefL1JT2N5c16qdTKB0m/Yh+soBfl9lRXUiXmHjMWGYxkK6F
 gGBeY
X-Gm-Gg: AYBFou2HqvAFMJ2Ul4M+K+40smIfM1Zdnc0OAPQRFRkTD8sgdM5OiKVa9gCWXosmec9
 Cxun2WfdPJcCMEp+qsfd9k0RiIY/xkF2QiVI1BCCdENc3zt8c9G8fcFmeeWfvwq33AJCppjG/Sz
 sSLEy2vnCYD/vLn1KzeL6Y+gcTLs8M6Ah7HQ2d/IreIquCdXN3rM3P0WAy0u1PUNydj+5cKud0n
 8r4Yt4C0nKIBJDqOuSKqg9/wdHOUrl3BU0+PBOMul86GLESTjXhsu79Zm3TEB910ux9d2i60iuY
 8rJcnybOyMYU4zcd+DUk10D8fHFNFW6LlqwHWijDWs3NMKS9Qp8GLrEpGcNPzehsj4cG25IL6nZ
 psXDxQ/RXfbjcj+QHe0nFlzMD0vknzosQxp9C8q+pVlvXheFlW9byHsqxLHLz2DF7hYyBLtlKoA
 U99PrWt9BJw44KQj80QYzfjtIiuy+NhWFiGHKH5bPZDJxp0mv4EigY2oB4kfnWcNU/xqmYXO4I6
 sa0aSc=
X-Received: by 2002:a17:90a:c88d:b0:39e:4c81:6c94 with SMTP id
 98e67ed59e1d1-39e54f24890mr895713a91.26.1789681086768; 
 Thu, 17 Sep 2026 14:38:06 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf56d7e5bsm18178395eec.0.2026.09.17.14.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:38:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 12/15] target/s390x/tcg: Use op_ld for LOAD REVERSED
Date: Thu, 17 Sep 2026 11:37:46 -1000
Message-ID: <20260917213749.36756-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917213749.36756-1-richard.henderson@linaro.org>
References: <20260917213749.36756-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

Use the MemOp parameter to op_ld to directly perform a
little-endian load, rather than a separate byte reverse
after the load.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260731185628.23161-13-richard.henderson@linaro.org>
---
 target/s390x/tcg/insn-data.h.inc | 6 +++---
 target/s390x/tcg/translate.c     | 7 -------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index c79867d4097..64711855f3d 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -590,9 +590,9 @@
 /* LOAD REVERSED */
     C(0xb91f, LRVR,    RRE,   Z,   0, r2_32u, new, r1_32, rev32, 0)
     C(0xb90f, LRVGR,   RRE,   Z,   0, r2_o, r1, 0, rev64, 0)
-    C(0xe31f, LRVH,    RXY_a, Z,   0, m2_16u, new, r1_16, rev16, 0)
-    C(0xe31e, LRV,     RXY_a, Z,   0, m2_32u, new, r1_32, rev32, 0)
-    C(0xe30f, LRVG,    RXY_a, Z,   0, m2_64, r1, 0, rev64, 0)
+    D(0xe31f, LRVH,    RXY_a, Z,   0, a2, new, r1_16, ld, 0, MO_LEUW)
+    D(0xe31e, LRV,     RXY_a, Z,   0, a2, new, r1_32, ld, 0, MO_LEUL)
+    D(0xe30f, LRVG,    RXY_a, Z,   0, a2, r1, 0, ld, 0, MO_LEUQ)
 /* LOAD ZERO */
     F(0xb374, LZER,    RRE,   Z,   0, 0, 0, e1, zero, 0, IF_AFP1)
     F(0xb375, LZDR,    RRE,   Z,   0, 0, 0, f1, zero, 0, IF_AFP1)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 206330000dd..1250b2dd7f4 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -5762,13 +5762,6 @@ static void in2_m2_16s(DisasContext *s, DisasOps *o)
 }
 #define SPEC_in2_m2_16s 0
 
-static void in2_m2_16u(DisasContext *s, DisasOps *o)
-{
-    in2_a2(s, o);
-    tcg_gen_qemu_ld_i64(o->in2, o->in2, get_mem_index(s), MO_BEUW);
-}
-#define SPEC_in2_m2_16u 0
-
 static void in2_m2_32s(DisasContext *s, DisasOps *o)
 {
     in2_a2(s, o);
-- 
2.53.0


