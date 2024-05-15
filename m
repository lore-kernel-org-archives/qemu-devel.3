Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C974AC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8O-0006vy-8b; Wed, 15 May 2024 05:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B87-0005pX-Hp
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:03 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B85-0001eF-TZ
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:59 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-34e040ed031so5113912f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766056; x=1716370856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z4GBMu+2JbKHMzkDTMBgGA9NT+eMucGJRk+rUVBr+sY=;
 b=Iu5/i9PKG5KPVfJLnTdE/7FZifky9dJc2vVxvxPqr/kWRzr3Xy1RCvLxMeqfTwCPs+
 UDOf3eYnpjomY2Ht2rb1qdDtQrCBWp9T6ScMshTVAM0RdyHbZw1NmaJaHfW7QQpPhg+j
 yz7Og3oYTVIvxyKlyUZb8gZmuQtuRTYsK3/pUiMELyUUid8IK3ViT4lhcGs7RLfujBL9
 gAXaPcsaOxZaMuHxi//hufOJu3L/o6yhFJi9gd5ZDVwZOgGPtV4BXkSBbXjy2Dw+REJD
 hxfsyqVd9TaL/u9PiV6FKXk/tq1kWPym4BgeWw75Xewhnlvd2XVhfP8cw4bVSdrhmzn/
 Tsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766056; x=1716370856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z4GBMu+2JbKHMzkDTMBgGA9NT+eMucGJRk+rUVBr+sY=;
 b=Fv6EIqGCbybGZjnCF+LB4lA/inv2llTD8xm1/tQNrZB245PIBKVPUKCFe1DweRh0Jj
 IrrpMYE885BWtDmX0oA/SUXNQYSvEV1I2SLJGcV/usmawrRoBSmwy9q9RrwGRcA7zPFU
 dNUa1+dCIC1mjIePdSSa3HXXEQ1JBbBBZdmuDZd5j1YohLXCwo0JHxajWZMW3i1rlvKy
 8Y3mqgQwoT+rl+Yf20whajrwhIuqsKS1qBRM0v6z0PrVaLkOxgQ5cNgSPIuZM+yG42te
 WaT4ZRGcObvF0zNQy13Llf344Uq6nA3CBTl+JAu8Bi7cshby2S+ugOqHoP9Y3u/XabCO
 wtqg==
X-Gm-Message-State: AOJu0YwQvW33McGY3Fr8O2CN+jkkqM2kzdtOs7MzrgN79mUT9boFFPEh
 gIOkAnMjTR8MpLnIvQgr3DKchQk7+YW5vEs6ysbGoVT3/uWj3aw9BwbugTStGc7gJqgYVnkKXJD
 j1+E=
X-Google-Smtp-Source: AGHT+IHOkeKVOnU5X8TjxmqoJ4TeEQYDqHUaTBjaa6A/OgNU4BC+mbSCnEuMw9aJbgBLnE34ZXNTDQ==
X-Received: by 2002:a5d:43cd:0:b0:343:4727:d11e with SMTP id
 ffacd0b85a97d-3504a96a310mr10718092f8f.47.1715766056314; 
 Wed, 15 May 2024 02:40:56 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:40:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/43] target/hppa: Use umax in do_ibranch_priv
Date: Wed, 15 May 2024 11:40:15 +0200
Message-Id: <20240515094043.82850-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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

Using umax is clearer than the same operation using movcond.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 1758c6e1d4..e9ba792065 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1982,7 +1982,7 @@ static TCGv_i64 do_ibranch_priv(DisasContext *ctx, TCGv_i64 offset)
         dest = tcg_temp_new_i64();
         tcg_gen_andi_i64(dest, offset, -4);
         tcg_gen_ori_i64(dest, dest, ctx->privilege);
-        tcg_gen_movcond_i64(TCG_COND_GTU, dest, dest, offset, dest, offset);
+        tcg_gen_umax_i64(dest, dest, offset);
         break;
     }
     return dest;
-- 
2.34.1


