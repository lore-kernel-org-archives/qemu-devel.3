Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB7DE77190
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDo-0000OB-UH; Tue, 24 Dec 2024 15:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDK-00060G-Pi
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:11 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDI-0002vr-QE
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:10 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2163dc5155fso55566205ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070947; x=1735675747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CAh6al20AnnURobHcMKk7qN1tHMzvpICfK2iYSPIwVw=;
 b=A6xGeMchkoYnkaP3ifdjKYDdSQJ1WLSWwdlKINO8iZS09ZWNwRLl5iT9gylIvLIkIc
 0mdpYPDsh+Et7IZFpfs2N8Gg7ZCbIg1QSV8u36Y4GoWhuJA9ELgJHVfds4AzzOGhQKKh
 qf84drDNDU8P3Qd/V9Mqb6FrqCUz3lWrZ591vvfE60cAWOUTP9CAHRpglug0+KLUYiaR
 meUSjBmmAdlzjCKK6QF5c+45wA/ZaSXOMbWgWE5pKgcl145v7TA+Wu4CPEnp+b2Sy8TR
 k+Rgls0z5D4YM7LfIoXLIlaT5AageuGkrlaLY+o+M8TNags5SY0KtqH32gLQVuWXQX9n
 YLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070947; x=1735675747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CAh6al20AnnURobHcMKk7qN1tHMzvpICfK2iYSPIwVw=;
 b=UCJ5TCNHWVyJ0UoCbRyppkWzSVT1avtRTtDWfSoJhQ9wYFu7KXZJO7uTqH6XPEI+cH
 eSgcqqO3Vocy2jez3gGs0fdTgJoU03w0TSQk5Q+PSi+UK4u2ux28O8gf8M8n2h/yPpaV
 qy/aMDBqzjJPfSqFvK8P8RiwhyA5XWrEImVdiKsUibRpmlWp9n7nWXLIoEUbf79rY9tq
 2pg1pQKg+2dHIV776zK2tW5MoKZ7lOHl5b1zoWh5g+Hp+dO+CFSA+9rK+xioroBOKQyC
 UBn5YzfsZyRWL1QOsqxtoVLniF5bBHlje2Qumoa6onJBRK99BZ7Zk9wNPysf+4kM5CQB
 UnfA==
X-Gm-Message-State: AOJu0YxDnsxn8A2gfVpa9e7u3x3rmLLmeutDNnolSIegajmoy2mX/PRC
 AtUZB+jSseYBChVSzh6wfoF6odBCmussb5XN88z4LSdTjY7Qb5oa8fylrMF24yqknXSrUIU8dL3
 m/R4=
X-Gm-Gg: ASbGncukR7g5T5+/W57iFPMpUt8jCmLl7SOj1Y1rjl59Rs2oY/2wsjFWMoMoACsbbm2
 gb9fsTyKlVYFOfnylDV83MgsvhUBVhjvCE2Odrx6Dgeu9n4OZ0PCN+AgWXv7xo4FCP2k5Ph1JbL
 6lHJ/BzUiqkUXBeVCArQvN9lTAWngpVrg0+1yq0oPL9pr6Npm8BPSEShIyxmhmGv1x1wAZ7PrRM
 SoVJl1Q7UeNjnXqD1JdM1TI8GBQASRJooUeySIbnEIE4rfEg3xpP9PDIYZeYRqKtmJBPDk/oiRR
 CbMHf/HjzO48cp40QeBXhMWW4Q==
X-Google-Smtp-Source: AGHT+IG0FSLM6zsx7xapweeTCHu+zY+LKUC6GbH/OZX6ZekNklICgvh8GtE8KbWaC2L3Rmuch93VNA==
X-Received: by 2002:a05:6a20:c705:b0:1e0:f495:1bd9 with SMTP id
 adf61e73a8af0-1e5e04503e8mr31192399637.8.1735070947527; 
 Tue, 24 Dec 2024 12:09:07 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 47/72] tcg/optimize: Use finish_folding in fold_tcg_ld_memcopy
Date: Tue, 24 Dec 2024 12:04:56 -0800
Message-ID: <20241224200521.310066-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 7141b18496..047cb5a1ee 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2685,7 +2685,7 @@ static bool fold_tcg_ld_memcopy(OptContext *ctx, TCGOp *op)
     TCGType type;
 
     if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
-        return false;
+        return finish_folding(ctx, op);
     }
 
     type = ctx->type;
-- 
2.43.0


