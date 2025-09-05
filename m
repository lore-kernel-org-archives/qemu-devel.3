Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85000CA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 07:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuRDx-0003GJ-2z; Fri, 05 Sep 2025 03:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuRDq-00039T-3l
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:51:02 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuRDm-0008S3-Se
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 03:51:01 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45dcff2f313so11069485e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 00:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757058654; x=1757663454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9Q0To23hpXEvW6Mrfa1LxQN66jwPz0EI7k2HbJO2kUs=;
 b=yijuOxtjS91ewlviKr/fchY5hLp/nEDMWiX9et5011wi5fTaKetQjNhqeWXdaOxN3Q
 qpMrr44VN6ECnsuRtGLR8jq/j2maV9WdV7VOLkSVkMAymeznq5wTv+uNPQPzXFoTjcBy
 TuAI7e7+Kt2QtO4OHFi+26SZMGJZPwv49K3tipwY3Q9Z1BogPXS4jv8eKmboB0HjuyW3
 L8nDRRC76omgGToyReG8bdxfpH1+vtc1DYzP5sCTA2JJnRwrXeyJEbALiDndYK/KRztR
 6ISenqDzU0H68Y20zLGbqPGbL/+cdEeg/g4A+0DGju3bazpIJUTG72SHpg4R/Tlpg1/1
 /UNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757058654; x=1757663454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Q0To23hpXEvW6Mrfa1LxQN66jwPz0EI7k2HbJO2kUs=;
 b=Za2WTaWmuWusnbp6MYOnIALlRrE6/ZLedUSnqC5KR9YHb3RHK8haLLQPte6Lc6NWof
 j+JJqx12+WlWXQnHm45H34sv0d82PqmFksBeyUMFRrD8Oxy02rP7zoKjdANUnA8M62Z9
 f1NC2KcJj2WKbD+rjSZ7zTOVLLi0FKXolrZEA7YtPW37bGGoe+LZrcOlS+6X3kb3KZBR
 eNmGGL0yhVMzAgdNoHQhmYeIK7YxL6dwCiQyVP5NOwOYyUBmyjJHc1DEA6xMhL59QgNU
 EgspmghHNcuU/MR0bzTFnNecKwlyI4bIci49ENVemIV1YoOtME+7h/eg3ialQ5Gp7Ejx
 Mj6w==
X-Gm-Message-State: AOJu0YyBzwqG5hdkbMO2Lt+hC38ZOXGEMKsm+iSQUGnKZ6LBUrSC+Vp3
 wM81qkYmBYbT1ffYzu+OQogH1jBE2tulP6h1HfHdcC+dbNHf3ev3pwcFyFRy09r8OLVbkKCOXFn
 0Q2/ttJ4=
X-Gm-Gg: ASbGnct6VkgHjvaeZlp+YnmAjXS+jAbnlDHN2DEhDZinwrdvtxsgQPYa8l+LHfajy5/
 DP7zsbhIjtrmO82oUOZbtlsk3HeB5E8NOZCxa39IAZhaAixbY6ojgf3J10vwgDbg/uAwS0Pt9MP
 9wiZohJiWE44R1d0wQiA4Wb63XxRyL65NGzYHJx7I7105QtadlfRUvsNMIM0OqzJIKAcRZnsCM8
 CQT/s9C/DCe+ZsSwBmugIyzoBdhERtN1Zp3+BbU7MVPCOTX7b3ulBbTYKGAXu2ORtyo3Nbic7El
 pgQ6G3q6VWkzMXrHACvvhPjAxX6hfyFTvCiSgTF2zSuZwXGLRsMzUfGvenlOoXRUx9W58P78ZxS
 PbEAMgkpiOw/nwDbUClAzPIytLskN2kBMuIDD5Yp3bkJdRNQgrye2HN+8
X-Google-Smtp-Source: AGHT+IFsgwyWvqjUelQSY6U60igL4Ht3e9Nk0uGdl7L5IfoHQWYH20TOp+x0W+AijRK6dijccAUccg==
X-Received: by 2002:a05:600c:4f8c:b0:45d:db2a:ce30 with SMTP id
 5b1f17b1804b1-45ddb2acf1bmr3281035e9.0.1757058654327; 
 Fri, 05 Sep 2025 00:50:54 -0700 (PDT)
Received: from stoup.dot1x.polimi.it ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b98e77231sm143760715e9.12.2025.09.05.00.50.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 00:50:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/sparc: Loosen decode of RDY for v7
Date: Fri,  5 Sep 2025 09:50:44 +0200
Message-ID: <20250905075048.100496-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905075048.100496-1-richard.henderson@linaro.org>
References: <20250905075048.100496-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

Bits [18:0] are not decoded with v7, and for v8 unused values
of rs1 simply produce undefined results.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c  | 24 +++++++++++++-----------
 target/sparc/insns.decode | 12 ++++++++++--
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c2ffd965d8..69d5883dec 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2865,22 +2865,24 @@ static bool do_rd_special(DisasContext *dc, bool priv, int rd,
     return advance_pc(dc);
 }
 
-static TCGv do_rdy(DisasContext *dc, TCGv dst)
+static TCGv do_rdy_1(DisasContext *dc, TCGv dst)
 {
     return cpu_y;
 }
 
-static bool trans_RDY(DisasContext *dc, arg_RDY *a)
+static bool do_rdy(DisasContext *dc, int rd)
 {
-    /*
-     * TODO: Need a feature bit for sparcv8.  In the meantime, treat all
-     * 32-bit cpus like sparcv7, which ignores the rs1 field.
-     * This matches after all other ASR, so Leon3 Asr17 is handled first.
-     */
-    if (avail_64(dc) && a->rs1 != 0) {
-        return false;
-    }
-    return do_rd_special(dc, true, a->rd, do_rdy);
+    return do_rd_special(dc, true, rd, do_rdy_1);
+}
+
+static bool trans_RDY_v7(DisasContext *dc, arg_RDY_v7 *a)
+{
+    return avail_32(dc) && do_rdy(dc, a->rd);
+}
+
+static bool trans_RDY_v9(DisasContext *dc, arg_RDY_v9 *a)
+{
+    return avail_64(dc) && do_rdy(dc, a->rd);
 }
 
 static TCGv do_rd_leon3_config(DisasContext *dc, TCGv dst)
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1b1b85e9c2..74848996ae 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -91,6 +91,7 @@ CALL    01 i:s30
     STBAR_v9        10 00000 101000 01111 0 0000000000000
     MEMBAR          10 00000 101000 01111 1 000000 cmask:3 mmask:4
 
+    RDY_v9          10 rd:5  101000 00000 0 0000000000000
     RDCCR           10 rd:5  101000 00010 0 0000000000000
     RDASI           10 rd:5  101000 00011 0 0000000000000
     RDTICK          10 rd:5  101000 00100 0 0000000000000
@@ -118,8 +119,15 @@ CALL    01 i:s30
   # This confirms that bit 13 is ignored, as 0x8143c000 is STBAR.
   STBAR_v8          10 ----- 101000 01111 - -------------
 
-  # Before v8, all rs1 accepted; otherwise rs1==0.
-  RDY               10 rd:5  101000 rs1:5 0 0000000000000
+  # For v7, bits [18:0] are ignored.
+  # For v8, bits [18:14], aka rs1, are repurposed and rs1 = 0 is RDY,
+  # and other values are RDASR.  However, the v8 manual explicitly
+  # says that rs1 in 1..14 yield undefined results and do not cause
+  # an illegal instruction trap, and rs1 in 16..31 are available for
+  # implementation specific usage.
+  # Implement not causing an illegal instruction trap for v8 by
+  # continuing to interpret unused values per v7, i.e. as RDY.
+  RDY_v7            10 rd:5  101000 ----- - -------------
 }
 
 {
-- 
2.43.0


