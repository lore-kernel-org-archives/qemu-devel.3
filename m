Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CF0C369D9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JRC-0001X3-OF; Tue, 22 Apr 2025 15:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOv-0005AF-Rh
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:30 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOt-00073B-U4
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:25 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-227914acd20so1933745ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350522; x=1745955322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1UQyMwl8FkxNsbxCkJPrCVn5egihsCexcKX6axRuSQ=;
 b=w/Rd9550GuDf1Vy53JUa71n7Q29FlJ53TVw5cLaLt6l+5DvSbEltJaiAH1jjafVlHC
 IjHlzGqaccYCZ3TtNamHrw7izhR+fyvVFMkt8jfthkQ5DW/ZLyzMVIOZ07wzpegxbhEW
 +TMgK2lymKDlmR1sqGNMKywx3oLsoFMo5FS2d25f6NyERDMOPmVdS5r9cA55kD87M52t
 tH+Gb4p2vio/aQKE+Msbp3fJ01DEinbqhaC0UFwkippZ7xwcXGk0uzXKXrvm9QMg5P78
 u1ma02U3elZOnzon+j2WwpBK5ltSpXfeaA5Ye2D108Smp74HTVmuhfwh85g1XaQlYWC3
 By/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350522; x=1745955322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N1UQyMwl8FkxNsbxCkJPrCVn5egihsCexcKX6axRuSQ=;
 b=kcC8V33oix6p5yWui0dkjgGErtJqf7RMyJ+07nyZhlp92yzIffttHZkRVNQ7VMFQEQ
 qPx3IUkmVRRfhc2KYdUnYoBD5vOADlsuhgjn9uT0GC+VgaqAIf8thfMZ4Ak87Wmq4+hb
 AhnWVEMO5o1P6Tig1/OGnWevog3FG90uEi5WqojzHqwYau/kRJ9h1a3dMFriTBmDV6K7
 wlGzwBLrZeSgnVGohfqPrWT3BxjJLpJ9dplvjPi6j2RneP5Oq4PxKG2jiBk0vHn8x113
 74wJuI/3K1ul1mGroGSpVqFzncglHJee1gpvohX7G/bZa86J8K7er2C4VDHwdD7Pr/RV
 RsZg==
X-Gm-Message-State: AOJu0YxxQQeoloVrhoQYDVy6c3rC/UKXJfeuro8tktBM7Cq8o7pgqabf
 oLP+kuPcMChEIMlztXFSl0+6+pNVz/G+K+XjPMn7uGvKXtNocbWIsemIOuduTTZtlZwaajUvQcl
 O
X-Gm-Gg: ASbGncs4DsjTwyAESeVNdiq8AaLaJITfxV5FBa20uvt35mv1Lub4LRO3Jh/XrMEbQIe
 aIC6wkzGyPuiqBVw/Tee9iSmrqT9oklaph7yLPYW1epJc7+rpIg63bBwzE4SNDlttJ07ujfNkgG
 3AU9pytGAwbsXTQ+rG2pn80mkBk+4HeujvKGcyD4dqLn3ius56OxmYltLjz3ImYmsgR3FRDYKjP
 R7af2nhZvG3OU7d98xYGvyStCCZ4D/Bs22RDQmYr8jET7PpOH6DkmqszR2QLQSOt/7NPoERMUR0
 3zA0cvfuu6Hp6tS2MLtHZRpNdeh7A+bHVbh1iC4dTsAJvyTs0FfTfFd9EIVp8MJGJ2JO9IWdlL4
 =
X-Google-Smtp-Source: AGHT+IGGxPcWKl9L+xU5eTuU7M5qZ+c+b6ToAsTd10A/BiAnYeBINB5Bf/KWVhemRYJkTx4cAjs2HQ==
X-Received: by 2002:a17:902:dac7:b0:21f:98fc:8414 with SMTP id
 d9443c01a7336-22da3387b8dmr2623995ad.26.1745350522225; 
 Tue, 22 Apr 2025 12:35:22 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 094/147] target/hexagon: Implement TCGCPUOps.mmu_index
Date: Tue, 22 Apr 2025 12:27:23 -0700
Message-ID: <20250422192819.302784-95-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

This hook is about to become mandatory.  Since hexagon
is still user-only, the implementation is trivial.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 766b678651..ad1f303fbc 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -313,6 +313,11 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
     mcc->parent_realize(dev, errp);
 }
 
+static int hexagon_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return MMU_USER_IDX;
+}
+
 static void hexagon_cpu_init(Object *obj)
 {
 }
@@ -324,6 +329,7 @@ static const TCGCPUOps hexagon_tcg_ops = {
     .translate_code = hexagon_translate_code,
     .synchronize_from_tb = hexagon_cpu_synchronize_from_tb,
     .restore_state_to_opc = hexagon_restore_state_to_opc,
+    .mmu_index = hexagon_cpu_mmu_index,
 };
 
 static void hexagon_cpu_class_init(ObjectClass *c, void *data)
-- 
2.43.0


