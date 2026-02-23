Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7EAEC113D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 20:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vucyz-0006dN-Fa; Mon, 23 Feb 2026 15:56:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vucyx-0006bx-1P
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:56:43 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vucyv-00082A-Ad
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:56:42 -0500
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7d4cb7e10efso4075774a34.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 12:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771880200; x=1772485000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xzuHO+IhwGVY3r5JmSu9L2/YehPKWyCJ1AMe2LJrtU8=;
 b=PWc1GjrgOZm6Hclrh/xmX4LyWGSPp2bEm8Fs62D4Rm3uEjFHa7Luli5SsFou/DZBKV
 dg8eh3lXvFYVQx/GeamJyFrVlZ84gKkdS63Qp4oahhc+R9X6X+nhI7f2KYqcefaYV/xd
 QudAJXnqlO/CEw507ZKV7eNxIZpFe4gq2Mz6Ei3s79k80YPIpyTlPdBRim8t+LdRfMpm
 5y37J1oqcud+vhm5naOK9YjxrJnt1ORXb73PPNg/SdNRl94o9DJFNYKAl3dI2CxS3jaj
 nNAcUy32emXo8efOtRE2e9Xgwjr9NiGOjnejFQIHaD3K/QNS9wMHPZn+Vp9eD07ypdPT
 nMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771880200; x=1772485000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xzuHO+IhwGVY3r5JmSu9L2/YehPKWyCJ1AMe2LJrtU8=;
 b=QltF04ZG+Mh3U4iyH6LqizoZ77kbtuYVXwj626Diy8c6JTrFEb0HiHaFfOPhA27pcx
 +f45I3GCigKOfVD6cLp7NGkjd1FaQP60QesXCtiwRS+G6QHKnKZnmP8g8CCUo7JpEQ50
 05DO6R34fAJ4s4iUH7mvML2oVCeJ3vTHqPw0KJrXL9AhcISAS/6h+f3NR7epuX7sfgf1
 FxdlY9XBRAxnxaj1/VFi5kUReOuhu6hrIMF3xDgaXfXtsWjG5Jg7nW6GSJRvvd286qck
 R8IB6y1AcpxX9pS57hUEV46DTjQfy94TW5CKdw7HMQXudZ98CvNH4hDm4rlOmdOsI3xL
 AP2Q==
X-Gm-Message-State: AOJu0Yyesk4oorXE90Rxzf4JV17YiOwpLKjXgajiSQv+rdG9YQw111BR
 43mmJ8K5fXfYriswRG26qhixBDJhcOVmQyrmMv+dBVS71EBNofPJ3T0TEZ57CDMN
X-Gm-Gg: AZuq6aJJyaG096odmfgwXytXHcoT36ZN0vwPcuhgEVPdhPHuwqJ+JDP5NqmLu7JmHrP
 UvY1ez4z5yb2MZEDewOGUQXOWOLnwF+s93aD8Oo51A2p33s17gAx2TaDBcA/tdpmEj+5FaUhQms
 MjfipU94II2hbwXMug2FQ/TBGQzqOIvYjDNnM54vmF6T4eTZJsIK8NssS7rwyy6R3y5aFyzTGlK
 6o7EpHf23UnOmCqM8HPM58wBoA4bBCeD5GqBX/4pB6Kh8gGPkMiW0RH8jfVCGCw2xHkkaEM0edQ
 21i0wkVrDDZ257/SRn4cCxGk+C2iNFy7civrJFtMGJPMR8nepdxbZBeM/ebMtRFBC5z2Q/E8KAo
 6aDS2Ci/2XgaLQ8UPJtfCZdS1HfDldaHQWYo4AD/535Ai2kwbfAYW2ToYBCtuJFsiRPyyw5xUY7
 r4ZadzMQuJIK/VswAUKl7tkAsQRMEx9LyEOANOEeswe5sU3zGi4EgpVALehAPp95CH8/Erkl1aG
 8T11CTdBHj6+SUgTT2AUEji78SCVeBYNbZ7bvIslBA1q6Qf
X-Received: by 2002:a05:6830:6aa3:b0:7d1:8ced:55f5 with SMTP id
 46e09a7af769-7d52bf93b2fmr5981462a34.34.1771880199821; 
 Mon, 23 Feb 2026 12:56:39 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-75-70-169-246.hsd1.co.comcast.net. [75.70.169.246])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d04dbf1sm8011996a34.22.2026.02.23.12.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 12:56:39 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 6/8] Hexagon (target/hexagon) Check for qreg multiwrite in
 analyze_packet
Date: Mon, 23 Feb 2026 13:56:30 -0700
Message-ID: <20260223205632.223714-7-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223205632.223714-1-ltaylorsimpson@gmail.com>
References: <20260223205632.223714-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/translate.h | 7 ++++++-
 target/hexagon/translate.c | 5 +++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index 4ef9357aad..ab53d8b4d2 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -66,6 +66,7 @@ typedef struct DisasContext {
     int qreg_log[NUM_QREGS];
     int qreg_log_idx;
     DECLARE_BITMAP(qregs_written, NUM_QREGS);
+    DECLARE_BITMAP(qregs_multi_write, NUM_QREGS);
     DECLARE_BITMAP(insn_qregs_written, NUM_QREGS);
     DECLARE_BITMAP(insn_qregs_read, NUM_QREGS);
     bool pre_commit;
@@ -264,7 +265,11 @@ static inline void ctx_log_qreg_write(DisasContext *ctx,
             ctx->has_hvx_overlap = true;
         }
     }
-    set_bit(rnum, ctx->qregs_written);
+    if (!test_bit(rnum, ctx->qregs_written)) {
+        set_bit(rnum, ctx->qregs_written);
+    } else {
+        set_bit(rnum, ctx->qregs_multi_write);
+    }
     ctx->qreg_log[ctx->qreg_log_idx] = rnum;
     ctx->qreg_log_idx++;
 }
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 9aea3e7ae4..32cb2e7fb4 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -433,6 +433,7 @@ static void clear_pkt_ctx(DisasContext *ctx)
     bitmap_zero(ctx->vregs_multi_write, NUM_VREGS);
     bitmap_zero(ctx->vregs_uncond, NUM_VREGS);
     bitmap_zero(ctx->qregs_written, NUM_QREGS);
+    bitmap_zero(ctx->qregs_multi_write, NUM_QREGS);
     ctx->qreg_log_idx = 0;
     for (i = 0; i < STORES_MAX; i++) {
         ctx->store_width[i] = 0;
@@ -464,6 +465,10 @@ static bool pkt_has_write_conflict(DisasContext *ctx)
         return true;
     }
 
+    if (!bitmap_empty(ctx->qregs_multi_write, NUM_QREGS)) {
+        return true;
+    }
+
     return false;
 }
 
-- 
2.43.0


