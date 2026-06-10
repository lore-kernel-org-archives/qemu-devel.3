Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1F3CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXx-0008Tz-3D; Wed, 10 Jun 2026 12:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXc-0007xB-TU
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:33 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXb-0005Wl-7v
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490b613a17bso68569795e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107950; x=1781712750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LsRjLFUmJ1hcQBJiBCZFfEsHuHktB8bgTf+/mpgAy+o=;
 b=DWEpHSzuywQavbqmZHG7NcW26AADNp4LpYRlYsf3Qn7H2CioNrGQdwSj3YvDxkYWj9
 LTmf303cd//U/5rSLUgKTjAEmOAhkmNbEoNcn+agIjnMxrVoIH6ix+EcMEdU5rMR0HSV
 PIczCiPYAAS18KHPqeg3rfnhQoMOjSHHdrXDTqyhmv/CSN0ird8Br8AYs+dmcqO+bLHe
 GnM7GtU3qZAgbV+U5pC8MoaTQQJY9rkPHaOmd7G9HhaQNaiDoomnPuU2gs9CrL5gO6xc
 xT+taxQAm8fwWvJWpnKk1qEHt3kIJl5P0e4fLhly23FVkP7AKjRRxtm6PMzkDb9QmrMi
 17Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107950; x=1781712750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LsRjLFUmJ1hcQBJiBCZFfEsHuHktB8bgTf+/mpgAy+o=;
 b=tJ9rkMQSx3aKnguLvwQ8ysXpZif4aYMc7GsDWex+Pz0Iv9HcGAzkii5fIgNMYAcXFp
 xugqLbw8u5aCGxciD+gu0rBaadM+Pn22BTeAZswVHVHsSR+S7PF8YpGF/5SWf5hmGhrd
 3xznM7cfLw05ZEEow8K/hWz+B8Pr/0qh8YHeGXgu6nxVmuNRvb1dkadLmHoDg5qo5DKu
 AVBuuJ9RT06nWaj1lojHho6XIxdasqueyhRJ2Pi7oA8Se6sXM4d/4kCNNTEfZEVll9d0
 FJHhl7P4iQ2mwUFGvK0A/6ByKTq1fRpAnjmRKst9/1cmZzTO+j9EnvepVf5dFdico7gF
 ntXw==
X-Gm-Message-State: AOJu0YxZQqhVA7w3/MfDCAPRTLlSGs3+pSlWjSethY16aTxNw3z5uO3h
 Bg5XJADiiDezLc9vHU9y49lqDo0vuX4HIfZz4JxcyNWBnfGzRoJMltAZjdd1j3zXi8gPh+SVBL2
 5bXV/
X-Gm-Gg: Acq92OGmbZyivY/TPiDDgDx+q4xpNU8ygDnW0YMB0+W92fqAEO3+mn1aXRxBULflHCr
 naN03NbyVUXQGnIDbSfd61SDcNJavXAnhncn1OnQ2BRp0whyAqNvYiraukDwz2vRPGJ6OBDLRFd
 rE5UjO9WXTPIguvHvnOWU3cZsZk8xZ3/Nmo78EkZOM05rsFcnrWXZTewfblh/HPyJLtwykC5k8s
 g44UXE0LCyOfP+wxAPjpdKd8YOi50kJcwD5tCjfzGsULpslWSkXei+xQkbor+ZlQV+7YvBDJSdX
 sEyfX0B0L57MUcaw9m+NGp1xBXIk/Ih3tGZ/nVHikdCk7TUfQdvRvZGAVk3CzXL+tB7kenn39ve
 GDc1RgsESJRAXrKNqBX2oE9Ko/Cdc2sKesruUKfTdWAWBMSqxpN0dThe2CKnyFyTKSHWdrAeOGi
 Uchy8fennpvX+SHADStvdAUySB3lhfdBj54XWeEUDmc6QR2jfXf1IHe0ETKTPDwRAtvAzvttA1N
 PNRmoTF4ErFU4I5ZOL2b5Re7uSwMIQ/s+O8LZOjUz8=
X-Received: by 2002:a05:600c:190f:b0:490:53d3:47a9 with SMTP id
 5b1f17b1804b1-490d71ecc8bmr108641265e9.3.1781107949731; 
 Wed, 10 Jun 2026 09:12:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/71] target/arm: fix WFET typo in syndrome
Date: Wed, 10 Jun 2026 17:11:10 +0100
Message-ID: <20260610161202.2235298-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

A stray x slipped in and we didn't notice! Fortunately we haven't
implemented WFET yet so nothing is affected. But we are about to so
lets fix it.

Fixes: 4575da5ecb7 (target/arm: report register in WFIT syndromes)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260529082948.363931-2-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 4d1f1c529e..0eb54c15ce 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -674,7 +674,7 @@ typedef enum {
     WFI = 0b00,
     WFE = 0b01,
     WFIT = 0b10,
-    WFET = 0xb11
+    WFET = 0b11
 } wfx_ti;
 
 static inline uint32_t syn_wfx(int cv, int cond, int rn, bool rv, wfx_ti ti, bool is_16bit)
-- 
2.43.0


