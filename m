Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17BAC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6EZf-0003u8-G4; Mon, 14 Sep 2026 17:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6EZd-0003tH-9O
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:50:49 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6EZb-00019r-Lv
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:50:49 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c6b4783778so933160b6e.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789422646; x=1790027446; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/ExVstuu4me8sCdySqO0piWRDOMZfcIV3gwZVKKf0ks=;
 b=mG/n2FGon8VRCZ6TZV93/3ele9kOOsKaG1tJXULS1NzegLSAF+MiULBOSwfdbLUCKx
 2YxDwrOxWxcn5juSpDF/+pbox59A3Fs76FsRGScEKdqGGZ/5XFJMXCnaz2xBcVHkaKr1
 EVLVWBngaVvx+n+PS8cA/txO4BO+p6r3UBstCYSn0SI8ldQPOAilOgnOgSfTHXJ5qAPO
 4XM0hNazP33G8Nh/W/cytXt358tWU74EFpb8XZToY/ocnOGY2p+v6SOJ8EMWS3+7XSg7
 DurCgRtVSzImjedVrGaBP1lD3JqigvuTlAngVrfOASoXKKHlCpu8wBXQWO3/OgYAikO5
 2ITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789422646; x=1790027446;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/ExVstuu4me8sCdySqO0piWRDOMZfcIV3gwZVKKf0ks=;
 b=1Oeza9g396XfDQFSrqQXlCRBlKq3OFcCyjRVhCwWCA9gH+fW76gFV6al2i7Bruf5kJ
 2x4Wck5IJXpj1JcCMc7JIahBXliMGeYPdo3rnyHVfMT/1nAmAILrG8kiSFF4Di3PRKhJ
 FXC+u17Zoz+YFtg8wdpyIQOQUwC4BVaHK4B3s10GbPeAVzsW0TfXXdLD9BEmLTv/9FxG
 bceE7VPLLHayeI5C/hATeH1WITfIpyfaivCNuoyNB+v/Mqoc6IGNlx8Pf5GGcxCeYhCN
 VVp20Xv5LJPALCdO3l56mqS9l8xgT7CyQ+SPTjuHVJRiDx6y68tlcRIuGw8XIKU+9f5A
 j4IQ==
X-Gm-Message-State: AFuF++lsQk/M0rP5/qNRmHAEP6BOreC2qcVuDF/d9W6lUTPzt/1Qmkgp
 +LQjIFMVQBMt7MT/76JM7ID1sXqHdpWM7SZ2vOziNJZBw2oy7BbE3UT1Fw/GsZMY
X-Gm-Gg: AYBFou00qdP96DY51Y63hYttFRPyMLmfMwuRIA9p+MV0ngzSNFrkgJXncEFXlhJkm2y
 jBQwrCFQ0SYk9ITfXXQ0HJpAxqfuB66JW/EAXGbKHZ+IsdtqMKeaq6m9PTH+BcBkJAB0MNuEvwV
 kNCXRUROBmPmf/VTMG1ixD/Lyy5tOJ7UH9ECHKGhs1zjIuf7KXZvTGwAYSjJ3INlQaCvI5jIDiq
 HUjWZv4IpMmiUT4k+BwIJrZ3FmIQ8NgFqsipYb9LJO0xZD5zw7oHvqkLWSu99cUzwuPQYeVxl4Y
 3iyX0G+6RkQoThJegQ9+4vtlveK2ibmECR5jmrkJOFdXAJVZWi1yUBQpHXNwgxYKRp15rjdIiv7
 ysjxhaqT+xxw/U6QvtnfzYiZYt65DyojKORgLXHCj6YIRmgTyz8iP/szpnXjLl/AkE02f1RlSy0
 hEyj9a7Iak7Dw3UQmPwMPPjfGNLh6nCz/9fZHrI/SGvfs4w64A/mWgWL7IRSIaUz+dQwCCScVcT
 x2KLwpVIKnI00bKMHQ+ucIOh/aCujYHSl6kqbSFFTwCjLj4zqCuvTtDuAyLW+kI
X-Received: by 2002:a05:6808:30aa:b0:4c3:ee9e:200d with SMTP id
 5614622812f47-4c7b3fd43b8mr5502431b6e.7.1789422646535; 
 Mon, 14 Sep 2026 14:50:46 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c4a2504bc4sm8937163b6e.17.2026.09.14.14.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 14:50:46 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v3 04/10] Hexagon (target/hexagon) Check for vreg multiwrite
 in analyze_packet
Date: Mon, 14 Sep 2026 15:50:30 -0600
Message-ID: <20260914215037.157879-5-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
References: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:32::11;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/translate.h | 12 +++++++++++-
 target/hexagon/translate.c |  9 +++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index 964e6ce0b7..9ee5f25365 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -70,6 +70,8 @@ typedef struct DisasContext {
     DECLARE_BITMAP(vregs_select, NUM_VREGS);
     DECLARE_BITMAP(predicated_future_vregs, NUM_VREGS);
     DECLARE_BITMAP(predicated_tmp_vregs, NUM_VREGS);
+    DECLARE_BITMAP(vregs_multi_write, NUM_VREGS);
+    DECLARE_BITMAP(vregs_uncond, NUM_VREGS);
     DECLARE_BITMAP(insn_vregs_read, NUM_VREGS);
     int qreg_log[NUM_QREGS];
     int qreg_log_idx;
@@ -218,7 +220,11 @@ static inline void ctx_log_vreg_write(DisasContext *ctx,
             ctx->has_hvx_overlap = true;
         }
     }
-    set_bit(rnum, ctx->vregs_written);
+    if (!test_bit(rnum, ctx->vregs_written)) {
+        set_bit(rnum, ctx->vregs_written);
+    } else {
+        set_bit(rnum, ctx->vregs_multi_write);
+    }
     if (type != EXT_TMP) {
         if (!test_bit(rnum, ctx->vregs_updated)) {
             ctx->vreg_log[ctx->vreg_log_idx] = rnum;
@@ -229,6 +235,8 @@ static inline void ctx_log_vreg_write(DisasContext *ctx,
         set_bit(rnum, ctx->vregs_updated);
         if (is_predicated) {
             set_bit(rnum, ctx->predicated_future_vregs);
+        } else {
+            set_bit(rnum, ctx->vregs_uncond);
         }
     }
     if (type == EXT_NEW) {
@@ -238,6 +246,8 @@ static inline void ctx_log_vreg_write(DisasContext *ctx,
         set_bit(rnum, ctx->vregs_updated_tmp);
         if (is_predicated) {
             set_bit(rnum, ctx->predicated_tmp_vregs);
+        } else {
+            set_bit(rnum, ctx->vregs_uncond);
         }
     }
 }
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 60441dc309..ca22bae28f 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -589,6 +589,8 @@ static void clear_pkt_ctx(DisasContext *ctx)
     bitmap_zero(ctx->vregs_updated, NUM_VREGS);
     bitmap_zero(ctx->vregs_select, NUM_VREGS);
     bitmap_zero(ctx->predicated_future_vregs, NUM_VREGS);
+    bitmap_zero(ctx->vregs_multi_write, NUM_VREGS);
+    bitmap_zero(ctx->vregs_uncond, NUM_VREGS);
     bitmap_zero(ctx->predicated_tmp_vregs, NUM_VREGS);
     bitmap_zero(ctx->qregs_written, NUM_QREGS);
     ctx->qreg_log_idx = 0;
@@ -608,6 +610,7 @@ static void clear_pkt_ctx(DisasContext *ctx)
 static bool pkt_has_write_conflict(DisasContext *ctx)
 {
     DECLARE_BITMAP(gpr_conflict, TOTAL_PER_THREAD_REGS);
+    DECLARE_BITMAP(vregs_conflict, NUM_VREGS);
 
     bitmap_and(gpr_conflict, ctx->gpr_multi_write, ctx->gpr_uncond,
                TOTAL_PER_THREAD_REGS);
@@ -615,6 +618,12 @@ static bool pkt_has_write_conflict(DisasContext *ctx)
         return true;
     }
 
+    bitmap_and(vregs_conflict, ctx->vregs_multi_write, ctx->vregs_uncond,
+               NUM_VREGS);
+    if (!bitmap_empty(vregs_conflict, NUM_VREGS)) {
+        return true;
+    }
+
     return false;
 }
 
-- 
2.43.0


