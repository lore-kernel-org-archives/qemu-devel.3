Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924D6C10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmY8-0008Nu-Bl; Wed, 24 Apr 2024 20:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXe-0008B0-4I
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:50 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXa-0006EI-5r
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:43 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e86d56b3bcso3745675ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003240; x=1714608040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+ulGPIrRlnm5P5YmYy3GI1c79AhdRcNeJa8JIKew5Cs=;
 b=qohjauPOR4WlkybgTwdCsnrC5R9CjjRhFLsVtf4yQNx1ZI5adH442Z5wHSxtibuGgV
 x05v+JAgPdvVWvPjrniJOxysUfCrcbwcf526k6RCF/lFgNglu4NT8nSRSjZfNpB4AlHT
 LCJ4bgoUPzAYn38IMGEK8RjPWBGCJCEEJLcfGCliatK2RKFCKdM9ZnYnsqYvu7mlJWM9
 Nf2pL90W5ueGp5vh5rhvVgWHZ4RkijiUY1hv4RG8IT14bqkogCAnB0gfiN2M3HYO7514
 78uPqduJfqfdhJG1u9DqQ7sRZYpBvs+FSS3KN/n7NSmPTGwjKEV6MbjOhzh6VzQPuttV
 wfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003240; x=1714608040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ulGPIrRlnm5P5YmYy3GI1c79AhdRcNeJa8JIKew5Cs=;
 b=osLtbo1MqzIns/PjKP4Z0SqdTZTcnKZR1gmPSc9SmWpl3zPIaKT9m2pocuu5ovmXtt
 vFAgUMpaDYP6J5D1+qKOmkp/i5vI7kPEV0cpQi2yoZfo/MO2yoVptArIYnVVgT//D7hA
 HeT+b6Lrnjb7t76RCcYC6SeV5HTcsRD5OfoubfGU/KM427QhJ2R3PKehuIDRgf0fy76+
 xOELFd8V5EHbe1PK3PRRziB7Jp1q7t2zPJv9yO6U/Xl/GRFTqccDzBJe1p/uC/c3/ua6
 a7lfOazAXz8EUr90fCP6ph7wQBDd4TjqobFCdPgTcCCUBMstB/H/2zhr1Frm4EUHBfhc
 MQ+A==
X-Gm-Message-State: AOJu0Yz5OOdcSHiW4+CuEZjIJc4J4N1OVAdwTvZnn4Xwu0ajWC0pHA0S
 XmGOeAb5bvisJkaossWSirB9eRYs1DLekITKd+3W0Ng1QhmQoX0b1D0NgvrlGEkP/Eh6EjTHQUf
 y
X-Google-Smtp-Source: AGHT+IHnxMwdZAWUN6FeGYKuieaZ009ls19uBu4eqp3/BCL6RntX9pZg5swDZqr52sTLzY3OEdv14w==
X-Received: by 2002:a17:903:32c1:b0:1e5:5041:b18a with SMTP id
 i1-20020a17090332c100b001e55041b18amr5704206plr.40.1714003240213; 
 Wed, 24 Apr 2024 17:00:40 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/45] target/hppa: Use umax in do_ibranch_priv
Date: Wed, 24 Apr 2024 16:59:53 -0700
Message-Id: <20240425000023.1002026-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 2ddaefde21..7e01c21141 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1980,7 +1980,7 @@ static TCGv_i64 do_ibranch_priv(DisasContext *ctx, TCGv_i64 offset)
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


