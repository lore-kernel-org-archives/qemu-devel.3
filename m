Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E396BE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfhq-0000VD-F3; Fri, 20 Dec 2024 11:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfh2-0007gh-ID
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:42 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfgy-00082E-Uj
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:35 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so22856135e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711450; x=1735316250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VtUy2p0Yr1y8g66umpd+7dvBQ8sKl+YDsMvxmxMTBX4=;
 b=bnHIFn6iwIMY9g9LGcmeBkr2ljs8NV3tnvQOkCge0317aQSyChiWZS9wOdYet2H5L9
 /caPbjYF2NWbBDe7gONCyF/PfLTionDSBnIsd4qrhBl59AqdYysVWTWMrM5mTSgoHFaH
 opZMdEyb9oNN+jD19XTJ+TCfEEINCHFUxL3Ct8kncV9s+7ITOjtZa4WDrMdilI9m34Oi
 Yo0Y4YOsU9JmloeV6BkUakUemkztLaVGZeGeyJ8IhBc9wEMiKzTQgvrEMf2rYTeoW6cP
 gecxa8Yklxsg7SILt2IRMf/UouR9XJlsv3Wt72d39WsFsdesRfPJZeWs1JbJoAARBl4F
 1FQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711450; x=1735316250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VtUy2p0Yr1y8g66umpd+7dvBQ8sKl+YDsMvxmxMTBX4=;
 b=Om8K9kEsdrCBSLT3o/APtXU34Nb6CyLR++W5zyPu5lB/oC5YddIbkRmvEOMoOWpjg5
 yq1iV/XFkKCTyn/YPl891dD4pOMmeEsPBRSbTX931tapDBL4+M3ieFp53+CvpoHn5MgE
 ydMjqDPdO27LO8cnk95KxaBf0Iy5rxaMbOeuBaF2t8YtXxqQk70NbM1idSJ/zYULbiT8
 hZzobrWNsUhUt2JslWFaQT61pAwCB5VUiOrAi1PbOPYfirxf2zdDRvzzYuPSUGjyInQP
 /Qljaihht03mOngOtT6HDg4n23MK0UF8Q0Gcle/TVcYBC3BCLV2W/RB2lWPmwUPSVMRH
 rHdQ==
X-Gm-Message-State: AOJu0Yx2FmkEQcCZ9b0Pq1F/5/xzoxUNXgnVij3QuUMLGPhFnYMwa07+
 MebLjgMt9kJsMBLV3dKGRDfcoaEKUiaYgu7O5K89BniE+/qp8+QsiZKzmIVu9fwcdTo/64Yvl2R
 O
X-Gm-Gg: ASbGncv6WWCFlnSJSTMtGEZgO3wM8xQOw5oM/44N1NCB/uJyvu3Tgl1zwTe3EYPjbn6
 GfTiNsqDkT2fqILrITPGy88XA6tkyGmaOrdCprUpFwIC28PbFhrFkVe80f5U7S4ziRrgkIBKa7Q
 r8LZ6G7bumbMOAnsVkKnyDgnF4PvtnEau1M1yiL+QJM4QrQAUnly/SrJg5+Al44doIw0ZyMIIAu
 R2cdj9/JmvDiSxk3jwWM9qDr0HN+3wpfO/kSBaXNi3XfA+1Ag7ZXyuYb/PvuAnQlAx2v+QBxtM=
X-Google-Smtp-Source: AGHT+IGW6XupRdw1fXoVn9qrRuNesRSwlFEtroe3y0G3HttrxKyxFPn4iSj7Zc7b9QuORehBPh9j8w==
X-Received: by 2002:a5d:5e09:0:b0:385:f909:eb2c with SMTP id
 ffacd0b85a97d-38a223f7548mr4018741f8f.38.1734711449962; 
 Fri, 20 Dec 2024 08:17:29 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e43dsm4461706f8f.70.2024.12.20.08.17.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:17:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 21/59] target/arm/cpu: Restrict cpu_untagged_addr() to user
 emulation
Date: Fri, 20 Dec 2024 17:15:12 +0100
Message-ID: <20241220161551.89317-22-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Move the #endif guard where it belongs to restrict
the cpu_untagged_addr() implementation to user
emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241114011310.3615-11-philmd@linaro.org>
---
 target/arm/cpu.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d86e641280d..12b84665427 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3355,8 +3355,8 @@ extern const uint64_t pred_esz_masks[5];
 #define TAG_GRANULE      (1 << LOG2_TAG_GRANULE)
 
 #ifdef CONFIG_USER_ONLY
+
 #define TARGET_PAGE_DATA_SIZE (TARGET_PAGE_SIZE >> (LOG2_TAG_GRANULE + 1))
-#endif
 
 #ifdef TARGET_TAGGED_ADDRESSES
 /**
@@ -3382,6 +3382,7 @@ static inline target_ulong cpu_untagged_addr(CPUState *cs, target_ulong x)
     }
     return x;
 }
-#endif
+#endif /* TARGET_TAGGED_ADDRESSES */
+#endif /* CONFIG_USER_ONLY */
 
 #endif
-- 
2.47.1


