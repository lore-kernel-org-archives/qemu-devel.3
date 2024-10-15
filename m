Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DDBCFC27C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jjP-00005i-M0; Tue, 15 Oct 2024 11:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jjM-00005C-RW
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:45:05 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jjL-0000VD-9d
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:45:04 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20c70abba48so37332185ad.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007101; x=1729611901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rYfx3nszSCCIo154zwSkhn548PKsWfltylmZM2l6IU8=;
 b=z43i/pXn60a2tXQIizLFQ6uKCtMvWhw3hWFTFKRC9V7hdVB+3IJw9TL0p5k7Hy8+Iz
 QmzQxE+aDIKCXcS5tp1xwx8VQkmmfxXMULoSZ6vwHGm1Lq5erZUNt3k0JPq02+EGN/9U
 rY12pT62rVRlrGY0uKehyQvA0vmhKRlCAMAyV4H9TyBMvUlSrZTAr2cX7ZVLCE2XEw/S
 yc0gOzWxS80GpMP3SBZmoVfvh/KkTt8I2xu5FJ8dRR2TKVmVX5f+1dtfV/2Mn9Q5v/j+
 w93uDu5Inf6oYRpnI4xePVHDLVYxk4zjYe44uAs5cpBMWUHEdhmqtBmJUO7RoogQoZbD
 jeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007101; x=1729611901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rYfx3nszSCCIo154zwSkhn548PKsWfltylmZM2l6IU8=;
 b=LknlnCSkevgboPUAg3uTzgmNNBf9FqqyMA3uGRVYpvsbfiSM3bDS79e18BLpsmoXnu
 nFyvlkak2taitf34ZEkj46jXjUlvf3JX6f6JQWM5I25fAIPQBprJA+Bg2EXywJYSmlNu
 jNup9U4oKCPqQcORbXOJ6xzqY8yS+oCrwOT0XwHFvZ6/5vL/w6KQBVlHDojbjpfItjc4
 oC5DEvPxMy3Bqee6yJ8VoR6Un9eBNwc+I/+SPUeEzg2pMhnTWTv4wzoL1ZHGAE1k6Ma7
 jRYebGReSquzTJT3WSxgjBL1SE8yQGs2jNjrMI0cO98l1OmtMLPt1IhITc3qC2Zk2qVp
 ZVEQ==
X-Gm-Message-State: AOJu0Yx40zFIN1XTmSfdqPyhfjUB0sVx6QEkTYDI390ayK8BcSAjh+da
 vrVcMF3LEhqSWYcK0JNDT3AebwM0wFKb7qX/mT0XK+dDIMaIatlbSCA4/WYaK02OyZxyGugCjnl
 v
X-Google-Smtp-Source: AGHT+IGQfO59wdUy1L+JsGGdLxqtB27G80TOZycY5g2moZMJ+Qools8B9SzvO7sF+CScPDOhFaYOfg==
X-Received: by 2002:a17:90a:ff0e:b0:2e2:d3ab:2d77 with SMTP id
 98e67ed59e1d1-2e31538f3edmr14405032a91.39.1729007101493; 
 Tue, 15 Oct 2024 08:45:01 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e392f753b4sm1940460a91.49.2024.10.15.08.44.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:45:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/33] exec/tswap: Massage target_needs_bswap() definition
Date: Tue, 15 Oct 2024 12:44:11 -0300
Message-ID: <20241015154443.71763-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Invert target_needs_bswap() comparison to match the
COMPILING_PER_TARGET definition (2 lines upper).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241010175246.15779-2-philmd@linaro.org>
---
 include/exec/tswap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index b7a41913475..ecd4faef015 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -28,7 +28,7 @@ bool target_words_bigendian(void);
 #ifdef COMPILING_PER_TARGET
 #define target_needs_bswap()  (HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN)
 #else
-#define target_needs_bswap()  (target_words_bigendian() != HOST_BIG_ENDIAN)
+#define target_needs_bswap()  (HOST_BIG_ENDIAN != target_words_bigendian())
 #endif /* COMPILING_PER_TARGET */
 
 static inline uint16_t tswap16(uint16_t s)
-- 
2.45.2


