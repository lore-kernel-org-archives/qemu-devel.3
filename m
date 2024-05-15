Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D890AC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8G-0006H6-DV; Wed, 15 May 2024 05:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B80-0005kG-Tf
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:54 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B7y-0001cd-EE
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:52 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-34f7d8bfaa0so4554199f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766049; x=1716370849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LWUr8lq4r4FRgquzvOJs5lbd1cxSGRXEBJY5ElBtf/k=;
 b=zrXmdVJsViPKe6Dl3j2Q+j3CLskdOZma41R3ZWktWO3oxs3VTHntBN/TsDYkjL5Rvr
 Y11o5moFMeQ7kz4UfFBgPGLu7kdXOfSY5pntJdJfkGiqJEOC2Rf5Yg7ZN34TDqBNY6+o
 cunJ4Acu/uG3G94xCnQI+6Sn8Qr9BnMKb6AEdUq46yEH7paBMdOZrj20Dc2k9vlooNxH
 +rWWWWS6OACRgpOUty+i11zVBrWZRuoQPScRT05YamxglyRkunINxpn3upEgRza+TYCn
 rnvgJ9QoB6Ym2iPp3fy00eXO7eWT2rU835szQVS3kKaXmOj37iNNxZ0A8ataxEorDVHT
 tLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766049; x=1716370849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LWUr8lq4r4FRgquzvOJs5lbd1cxSGRXEBJY5ElBtf/k=;
 b=MJdCpSx0Wn5tnNK1BEILiRdWTsC7e41X7+z8AU3Q5Rs5LBJJiPerLOFe8YTHdke1z7
 HfY3ELNf49FEmZTq24hgK253UCzsKSBW4Vpi0O8oEQv/qcZI6yw+/hFd9SnS9h5mKWNK
 l7ZApLKl/Iucg/BGg7r8RWXL8lK1oTLTEjM0es9gAcyzl0L9HXWiEXF81dXcGwNU+JYH
 KOSkmn6PlwvYIE2eYl1f2+fNEY75YLHzdDvDATP7kROg1/bNGRYFSIJuj8w9mGMQulP2
 1M9aT6Xe31LQjNZ/OBBpaWYdJ8AGjeuRQPMbuOvDrIEgpWBAX4YhOJ1/RLfMUJ/R2RNp
 mpmQ==
X-Gm-Message-State: AOJu0YzooFVwZMXba8oM/w4jyPovisixAdQujMK/kDmJObCRlP2TM+/1
 JPB3t6uXLPnpem8VOkMa9mngRSMAYoOD3C9+MV3VmQp1Acml5Uajzaefporxu+HHNNSkK5tLHjh
 h4r0=
X-Google-Smtp-Source: AGHT+IGrl6hko+edEAyamhYDGpGWvmXUZ9GEFcyG7uaCYUjoyNO9CyAtWtq+MdGA2BZIGaB+GFSsmQ==
X-Received: by 2002:a5d:6190:0:b0:34c:9383:844f with SMTP id
 ffacd0b85a97d-3504aa63214mr10949073f8f.57.1715766049040; 
 Wed, 15 May 2024 02:40:49 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:40:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 06/43] target/hppa: Use CF_BP_PAGE instead of
 cpu_breakpoint_test
Date: Wed, 15 May 2024 11:40:06 +0200
Message-Id: <20240515094043.82850-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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

The generic tcg driver will have already checked for breakpoints.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 140dfb747a..d272be0e6e 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -674,8 +674,9 @@ static bool use_goto_tb(DisasContext *ctx, uint64_t bofs, uint64_t nofs)
    executing a TB that merely branches to the next TB.  */
 static bool use_nullify_skip(DisasContext *ctx)
 {
-    return (((ctx->iaoq_b ^ ctx->iaoq_f) & TARGET_PAGE_MASK) == 0
-            && !cpu_breakpoint_test(ctx->cs, ctx->iaoq_b, BP_ANY));
+    return (!(tb_cflags(ctx->base.tb) & CF_BP_PAGE)
+            && ctx->iaoq_b != -1
+            && is_same_page(&ctx->base, ctx->iaoq_b));
 }
 
 static void gen_goto_tb(DisasContext *ctx, int which,
-- 
2.34.1


