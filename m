Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE92CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8OM-0000Ih-KA; Thu, 07 May 2026 19:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OK-0000FE-7S
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:28 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OI-00011p-JP
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:27 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7de4e6c5a30so1478227a34.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197465; x=1778802265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1WOBWWcejd4Njf8YCai59IybtK3LPcoz1EYaWphZqM=;
 b=fo+kYL2MGND/xbQhOAL6qmH/6L6XyNCMoIO2LDZ7zxsvI3h1JcMrzANv0mghaVq7d+
 NJlRknb5vZHF/clmNVS2NMRWhmBp25uWqOnEnd0gtKD0dXbCt0/XYj/SgVSDaBHEJ0yG
 fu0uy6WIqto+zDW6LBNr+aUkvOQI9tnJSPi95XWdmFqkXPkeiaUgtz0wnOU+dN6Yps/5
 i5w3qycqS3fIQqi6RXSzb8HIvw5qeGN1QFLmZEflzM1Ls+8MZUbs8TlCVZJfK122vYfi
 sKpX62NEfSKhDIvo9ifyFK2FHWgq8wt20GqdqYliD60NYnEiCbJSFXpOtFoqxI+X6Lw8
 z8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197465; x=1778802265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l1WOBWWcejd4Njf8YCai59IybtK3LPcoz1EYaWphZqM=;
 b=X3vunpbZnQ6wQzM45TicvbCyWn4Osb7ZJBtl2gdv2izc8qxvsMA5n/Nn0p4sVekn8R
 iaBDfj27O6LzZzsw/yk/bGm86byXsdwF5Hfr8cEmqX0ipMqWq/ssWnmaC2TrgxzluNlo
 LgvIRU1iUvEMhQyDdIRQdg1sKPfI+Kg09THJAMaILeWZG7soYoT+zvY2+7mrXd2p2idu
 H2qdalAToV8HMcDcBwqp52cf8VzIxI+XdcB9nG8Ypbyv/avpv7hfUVGuWUJp14X2yAIp
 oRQA2bjM3WtazVDS5ivdQrBJOo5k56f/38pOv6Bw1oSBrTNQcEyzu3J4EIyG7iWQcztY
 z85g==
X-Gm-Message-State: AOJu0YxL2T49Jx/zNvKmRRum0KuutsDY6RgPfLrP/KiFHS8fmlHNxxYE
 ebTmzpniLVPThAQMwB2B5YPJR/x83LLtke/tRxe6E26u6cDQKHR0awDWPUiBSqIbNgTwRwJdnrh
 gpWOW
X-Gm-Gg: AeBDiesZ0nQKKcZsGQfzYQd/ysqe9QWFhPUQdT98hUYjf0nBtMMckMtI78/b1Q99MLj
 rJbvtNZ2WVMT95ltEYhSlbGcijBKsmpljU8X6qB0fDnz5XqJpR3AYJSBNGbP2H8MxQyDfVVJU2h
 1navTb6I5F5U5rbaszGDnEsyd/yyw/krxJW8p1CNsT/2qMnwTRiSXStuOD03jHXbCiryRKGVFIi
 rbFZvoahTqb7u2oR/ga34EVYOVRqSFuCDbfhywYXIHtQLpjWNm8tB4EkVxOqWtY/vOftFrZDr/y
 mAsj31x0o91DDlt/BJgMo2qkUVS9FSLcui6QjSEEXmaLhe1JAvM23tlInRuH5GTyHYklUzGLE+K
 GQItsdYMBRjq8/TlgLdFXE4J2VfFARKbLkOXKKMr7EpuEk9qq0bm1/uaINE0/okceDC3OJ4ecxP
 3zmgctSItGA3uSSHBZ45Sd8gq8XoP431hp+uOWSWdBa4LHeA==
X-Received: by 2002:a05:6830:2401:b0:7dc:d601:a69 with SMTP id
 46e09a7af769-7e1df0b9632mr6391677a34.20.1778197465298; 
 Thu, 07 May 2026 16:44:25 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 11/60] target/arm: Clear FPMR on ResetSVEState
Date: Thu,  7 May 2026 18:43:24 -0500
Message-ID: <20260507234413.643512-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

FPMR is cleared when entering or exiting Streaming Mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7a17fd39e5..6263a3cb3b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4836,6 +4836,7 @@ static void arm_reset_sve_state(CPUARMState *env)
     /* Recall that FFR is stored as pregs[16]. */
     memset(env->vfp.pregs, 0, sizeof(env->vfp.pregs));
     vfp_set_fpsr(env, 0x0800009f);
+    env->vfp.fpmr = 0;
 }
 
 void aarch64_set_svcr(CPUARMState *env, uint64_t new, uint64_t mask)
-- 
2.43.0


