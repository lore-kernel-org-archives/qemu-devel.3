Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D83E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSR-0000iS-41; Wed, 11 Dec 2024 11:21:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSP-0000bK-0h
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:01 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSN-0007nq-MB
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:00 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434f80457a4so5276995e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934058; x=1734538858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yKsdVA6fFVWyT5C4g+dHlzCsxIZ5/YpoZTGllaXzw58=;
 b=RnNtyQ1KYdFWvoTPB1fp71ZgEDmuhkgaEWtYtpcU0Npjx4LzphBh9jNvE+2djRcUMe
 ///GK6IMf2/VcmHIDGz9wW6i2w46aS9bgTaZY8lfHPxX4WVnXBe9IijPHOW09iiMjOrW
 4fRq9ZxJpqM5KFgzRLGDYusk9iIlcMWBsSIQKVUqXUp7sB+uAp73AoV9dm/CRK57a//M
 9Q8IVahlNINovWyueOILa399yDkJ2FO+4FpRav8hkS2C7ZvDMDjqMtkv4e6s6B5ftj+1
 puU64JCbxr9xJ0oo1CunYBwclwY0oQcdGHoFIfwtTSGURnFspcLARSju3NGC/mqTdOhc
 qvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934058; x=1734538858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yKsdVA6fFVWyT5C4g+dHlzCsxIZ5/YpoZTGllaXzw58=;
 b=hMyRRLsOIeqN8hBPxoQC4WJkd8kXk/Q9ln2kFg0Uou9fM3zkVP/quGuXaYCoultMrB
 VJiyhYz7CvJFWiTuNCoWILj8WSJPCltEjgYXmhwDgSkwA069ephgQEuOqC8zofvAS8KV
 T0hjQvxokkZKualZJqkyVQfa+yPkLiyZYmzq1fZcE3bg+M2dUtqRsZbh6hV4GsJf8PtO
 iz7/FAE2P+r/RMh8AvK7kNYgZEN8p6YyAeAdVd9RAC5XN9fpXnxuZyucn3/rNhtdyeP9
 CX33KBjiTuwadmcB9zG/y74K2+6kGcPlkDjuEUD8LAhUDwL961uUXGO7sVbFdcE+Fare
 N2BQ==
X-Gm-Message-State: AOJu0Yw89BgXg/TDCkdIO6DUKthvtpLS9xLF6RdFDyJ7aosboLYcGYVZ
 4avLkVgnKdtVxlRNsIn2KCBTMPk2XPbknX2yag0ED7wi1g12FWiZ++pLcsrx3sf1Ybopaj6Ap20
 L
X-Gm-Gg: ASbGnct4n6yxwB7kZxnC20Xcl8rGVZ7I0KcKD45GxpO3czM8iy7XsCwAhgXUD54HEiz
 We6+ZGgUTr50dvdpnN3wLqY1wJI9F2im78OwD1qkUPNOS/2mf3c8v5oWNynRKTkJ7vsYLmjRBkf
 tIcdNzalh0DWJxEVABIM3DK8f88g2a5Enfu8AHwMKMs+T4SG9k9cgRVZ4F1QFxz1jPKLgkcJSzs
 xn7lxgYrNh2Voa1igthSOecfnzqPP44JMn57/IkAT6qWxpMObvFjl4KGsaP
X-Google-Smtp-Source: AGHT+IGY5PnuMiQwL4T7BYPB/CzCoU0Dr8jpBgzgX+zTvZx0wyTWXDHw5lbm8V1wlJY3nBxfYc0OTg==
X-Received: by 2002:a7b:cd15:0:b0:434:ea1a:e30c with SMTP id
 5b1f17b1804b1-4361c80b03fmr27112725e9.13.1733934058372; 
 Wed, 11 Dec 2024 08:20:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/72] target/alpha: Set default NaN pattern explicitly
Date: Wed, 11 Dec 2024 16:19:37 +0000
Message-Id: <20241211162004.2795499-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Set the default NaN pattern explicitly for the alpha target.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-40-peter.maydell@linaro.org
---
 target/alpha/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 5d75c941f7a..70f67e6fd4e 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -199,6 +199,8 @@ static void alpha_cpu_initfn(Object *obj)
      * operand in Fa. That is float_2nan_prop_ba.
      */
     set_float_2nan_prop_rule(float_2nan_prop_x87, &env->fp_status);
+    /* Default NaN: sign bit clear, msb frac bit set */
+    set_float_default_nan_pattern(0b01000000, &env->fp_status);
 #if defined(CONFIG_USER_ONLY)
     env->flags = ENV_FLAG_PS_USER | ENV_FLAG_FEN;
     cpu_alpha_store_fpcr(env, (uint64_t)(FPCR_INVD | FPCR_DZED | FPCR_OVFD
-- 
2.34.1


