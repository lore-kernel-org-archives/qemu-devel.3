Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722C7CD37A7
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8OL-0000Gv-8Q; Thu, 07 May 2026 19:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OI-0000DP-E0
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:26 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OG-00011C-W5
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:26 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dcd689829eso1261854a34.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197464; x=1778802264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M/2XYJtCmCnZVDd2+hLLU+HjlQwW8RLHBCgCwsIOvd8=;
 b=LZfwOry1NVSytGirbf8jj4UevvUfjDZ59JrGslsIr23zvIYb9qzGa8gbZJnUhdAyrp
 mbUrktqFl2qbPqosUigIiV2IAZKRdfQQwHqRDdGIrUwnjX522y9LCdcb4t69sjxjy3Iz
 WdiAPa1JRzw/WRy0Tf3z0UoK7VDx/ZDCRdzjDe3qpYSRTO1tnKH8HK4dFydommE+TDNu
 tEuxLu2QgeLx9lo01dxEXSkVMzR/cxx+ZZfNyxh4ulZ5g90TugArA2255hZRvKaukrdE
 3yv8G4GQq3NFvUMA9FsFFaHgENC1H4HsB54zCUZbllyQC+JrY7dNdIi2QyhCyHPuulHd
 lkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197464; x=1778802264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M/2XYJtCmCnZVDd2+hLLU+HjlQwW8RLHBCgCwsIOvd8=;
 b=Mxi1p7lIovkcEZWTXeDWrGq/gw1O4JLgAVC1B+YVaNuZpS++Oz6zabHmHbtsevEv/S
 oISHmMCkth9IQbNAFFPlbrIFPeTAK1LZjTbtUOWXF2ycyYTwySJ49DbS7FtcQRbChLsf
 RJPWBWY/K00+yiQ4w6FOTN58/AauLf9tnaDsqS2MXC/ycB52WGmZdBSuhv9yLIRYRbA5
 lkIkl91Q5PtZnPO57lcMBYxDhZwE/kQOcwahxDps2Ynvmsax4/X1o7FypAwgz773B8wl
 ms4fS9lTGL0jMgpjMqyK4ay1rIz+0v6LSSGlHQJjfofaUcfzFdcD8i0iPgsbzEMpyXfQ
 kCfA==
X-Gm-Message-State: AOJu0YzLEBUvqi/acCSnW4LliQ7YJDsKuXqHuVb0gLn/h4F86WXKbmYs
 FTXRuthIlTTeiZJJtWcpSKF5sePOYhMeOoGZXfViuNBOhtN0501lK5XS8XXtnEEwhzGfZgv8UgH
 7KWhu
X-Gm-Gg: AeBDieunpxOHj8x1iMpOo0EEycWAZMWhyI2KQzBM52cP2SUfZKNnfZFXnQelyT3Ezos
 PiZRQcaU9+D49sK8ijYsczIZvzo8G9h6IfCk9CTAkBmjqZuuUhkULFwz3aO4nc4a5TXFa/RbKTu
 w7Lgj6yvPyWsByQq/+6dEzuHa7UEDcnU5EyNc2+HvNwlP9v8tCBKPvxdxC+qHYIk7ar+Rop5CgT
 Dp57lFPbGXfzjegZ0Efqy38rq2To2rr8suEczJs1sGwG9saWjUpIkkiQDcphCDkrWAYPgCOFocs
 KyNkXN31VmO+IQeR7X3S1HZFd4WdWqa2ecw06h8fFDYO6hKnB+r98+NG7YAaArxb+T7nCJ/kDuR
 im8bov2JbLlwTWiD94tbyXXfBLDmYlyJG7odiB8uiX3tyvzVIJtN5MDIhhZXK18cztUwU1O6X3z
 Lx+5tOsMWu2GlRCTnyZPujk1j1p7dTV6rfMa+4dev5bi6rwg==
X-Received: by 2002:a05:6830:d07:b0:7de:442b:722 with SMTP id
 46e09a7af769-7e365ac7847mr490637a34.0.1778197463836; 
 Thu, 07 May 2026 16:44:23 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 09/60] target/arm: Update SCTLR bits for FEAT_FPMR
Date: Thu,  7 May 2026 18:43:22 -0500
Message-ID: <20260507234413.643512-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c6f1f1a688..8f2c13ca20 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1460,6 +1460,7 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_DSSBS_32 (1U << 31) /* v8.5, AArch32 only */
 #define SCTLR_CMOW    (1ULL << 32) /* FEAT_CMOW */
 #define SCTLR_MSCEN   (1ULL << 33) /* FEAT_MOPS */
+#define SCTLR_EnFPM   (1ULL << 34) /* FEAT_FPMR */
 #define SCTLR_BT0     (1ULL << 35) /* v8.5-BTI */
 #define SCTLR_BT1     (1ULL << 36) /* v8.5-BTI */
 #define SCTLR_ITFSB   (1ULL << 37) /* v8.5-MemTag */
-- 
2.43.0


