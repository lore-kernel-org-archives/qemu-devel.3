Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558C6E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26A-0004HA-Rf; Tue, 10 Dec 2024 10:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL266-0004Gf-JD
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:26 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL265-0008Ka-62
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:26 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3ea36b05654so2929649b6e.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844264; x=1734449064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xf9OSLHuvBYP8zHVPPI3O86G2u6X8TGqiPN+TqMxWGU=;
 b=G/mgGN65uJiC9D38dd332p2nHL4IPNVEo3Ujdj85fCiAM2S7LZJkJUs4FmXdRzfZbL
 HH85VFifcRvtbU5zEgW/+FUDa55BFSoWNiqNeIRNl+AyYX4aAKyz8GEiIRAoTJGvpaNx
 r04uueTDtt9Zy3UcVmogIIWtXWQ3FzHnSB0X/0UT8UbTrIlBSktJM5jzFWgRBC5YSQKs
 UQqe8vHsZRqSbDxjASKP2CchcUsjw6uCm6ikiVMIpTKnlTTpwqJxgjt5UsrAxDIaiF8S
 O0jeIMzS/ek8PQzRr+eSfZPEymYDthaxs6bzc12Oe5Z12JOktT8034waKkzp/9bvVWEX
 u/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844264; x=1734449064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xf9OSLHuvBYP8zHVPPI3O86G2u6X8TGqiPN+TqMxWGU=;
 b=PU5VSpUrvy/CpnM5VLaY0pTgEv+LRZ+w6GdG9ca/WSh7glfTF9SQuyNjuLuZjYmL4P
 0kh7gOAM/LqViJVnl4M33BuF83Ygrn4WgH1yMpikKT0lbDXXPL074iczARNFOIjcr5GY
 OjNKXEEMebEw/vBSn3UQoRjtu6IAjT4i95ByGdsxlVN3aP1Lk/TB6nE8Rzd4/IYjeKhF
 t/BE6FhvrBkv08lrJjGUQEg28Fr07ePTRn3CFVLEQUDChHcz0QYxvSNwuaGFZHe54f/x
 JIjNHrIIXh8uQjzEw64BKvRqUjmHgt7lzz6I2n1qTVQI5MxkHgFJzYNFAmSZjrnIzybT
 iemw==
X-Gm-Message-State: AOJu0YxtbDjAgtLZGgaOqxsKgREewugghHFJlI+xJEa0MpJJ62Nv9FdI
 OjEtTuF0xmy7lIisF8uQX/LFko/vb3XQh1HqbQr93YfAMdpUz0P/SAB36V1zxTlxB0+MrBQAh/Z
 TotTyEjJq
X-Gm-Gg: ASbGncsDkTTuoZ44OqowNZu+sC8zXWk87dHHkqrg4VEwxOSNOvLUtyBDLLic6hNA0Pu
 OlcUpkUpD9PC2XKJUG8a/fGNtzBzSQYO0RvZtrKjr4MHDgLQ6rIr26Y6zkmZ1GWrnlkm0Z5oVHN
 l8LB0dUWU1GPMXD4CuG3o1JnjV1unWc4tNb1vwT0TDbx3wZLvfQsLiukGywzta2pkmW8MsKjUAD
 bhJIrRMyQyxRNS4iogoMa9iOGuDm5LkxeOjJjSdF2f59CgK65r8feDyredVvw==
X-Google-Smtp-Source: AGHT+IErlXkUxxm8jwEPl/a9XHR9jEuh5uyYv2JL5h/5U4YMlcHVp+CDhBGBTT7jE2Ys1yXukc9MWA==
X-Received: by 2002:a05:6808:e85:b0:3ea:4cab:3a13 with SMTP id
 5614622812f47-3eb19df7588mr10656545b6e.29.1733844263772; 
 Tue, 10 Dec 2024 07:24:23 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/46] tcg/optimize: Use finish_folding in fold_divide
Date: Tue, 10 Dec 2024 09:23:27 -0600
Message-ID: <20241210152401.1823648-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 4d5fa04199..59f510b49a 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1671,7 +1671,7 @@ static bool fold_divide(OptContext *ctx, TCGOp *op)
         fold_xi_to_x(ctx, op, 1)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_dup(OptContext *ctx, TCGOp *op)
-- 
2.43.0


