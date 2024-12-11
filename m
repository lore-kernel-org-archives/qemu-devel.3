Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAB6E77183
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSq-0001dC-C6; Wed, 11 Dec 2024 11:21:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSg-0001Ct-2N
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:19 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSc-0007sH-C3
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:16 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so546166f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934073; x=1734538873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4OON5JlufzoCu1sy77pgY3pdNBX7X9r7oCJJChK/oNw=;
 b=Trt0VcUcSV9yV2wBVqBGk/9v/bjUAPWj49ZWl/IwAeUw7U6pu3VUXYJYK0kUwJRXYV
 9Q0+lEUdlKZoanl0FNj9tzPILP62QnrAE4eGYDom2tPH0UieP9L+b3XdaRHwnZKW/cuJ
 7PROWSjMhtjp+zwgINFJQTZPYIdFs8Sguz7NHXAUVw7GFRkeiTaFYxSoDAfa8+RS7N5P
 RMoj7gH480B+MUHO/fBWAl1zpysWib0einNcV/Wi7VxNGWdcpLa31Nz7S0bGs9NXAwMG
 yczU+tPAfhCqG48xekYq6V7AcMTN8p0tVJBkAthEr/cVa/q0DGfJN8JFpVtUB5Tnf95p
 OaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934073; x=1734538873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4OON5JlufzoCu1sy77pgY3pdNBX7X9r7oCJJChK/oNw=;
 b=j52Vdq8uOdt4zMg1OKBl+AFYJjvtDGxrgLqOsjjTxSA/+aYaWr2AZHr9o7EuSIWFPB
 yNVjiCQEv+8TssGe3Rmv3OeMbzCKJeEuGi3LPXfgnbRhu3RdHcsP9EnGa1sNVzmjITbM
 kmeQXzZ51NgcXylvJ9/WCeiATIiIr7yd6GMrrmy7UqpNyxOdcJgVBhLv3NROxFUaCJ+z
 +cTRHNxNFEa/i142fpYiaBgf8RtVMQaLnBcAm7JXYDcK35YkSgK9oT2XGmUtkRJbNtBT
 MWbBfE6XNW9HvPZ/HqiKwn9c231WFAY7cE8Ek0oMn/R8mc482AkqCbG9qC/apTSu5dxY
 362w==
X-Gm-Message-State: AOJu0Yx9PQ0WR79fjdMAqdzrxrMPafXYHVnqiT/xDyQSFWBREI7DkR6j
 yXOrbx0Sc4gBIq5JYdzLivoop2Wut5j08H2rea8XSXeavK/wefl62Sw8Drqn/h6HIhCgN5pDUHU
 9
X-Gm-Gg: ASbGncsTXUeS8wNZr5osddaRXvgVan17hQo8r7ZLA+3Vgsr1mkS81OV0+BAH3NSj4M0
 IZoPVaxnC3zRnkm03DiIvQjo3/0TKx2wQQ3jBEdyN7SvCmc/jdxHD0FoEmtSJ6l4v+5avGVpYzc
 c5wMt21On33uXMHVgD1zHHrcm5mIIjbbLm8m+ygivBkGxppkG9FmkuytUSKLw6vaw4Lm0Qf/Bvx
 iQ809d4m1do2gMHK/phHk8CaeBNfGVw5evvrIZBRxNj9BA3liExvpE0WTct
X-Google-Smtp-Source: AGHT+IGM6edMzN05rMx1NeIsD6ihsZoc3a3RtUeUhMyKAwMBEZcEJ2GSwACjp71rhxKRJ5lctqIP6A==
X-Received: by 2002:a5d:5f4a:0:b0:386:37f8:451c with SMTP id
 ffacd0b85a97d-3864de8ef5dmr3025749f8f.1.1733934072972; 
 Wed, 11 Dec 2024 08:21:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 58/72] target/riscv: Set default NaN pattern explicitly
Date: Wed, 11 Dec 2024 16:19:50 +0000
Message-Id: <20241211162004.2795499-59-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Set the default NaN pattern explicitly for riscv.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-53-peter.maydell@linaro.org
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f219f0c3b52..80b09952e78 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1022,6 +1022,8 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     cs->exception_index = RISCV_EXCP_NONE;
     env->load_res = -1;
     set_default_nan_mode(1, &env->fp_status);
+    /* Default NaN value: sign bit clear, frac msb set */
+    set_float_default_nan_pattern(0b01000000, &env->fp_status);
     env->vill = true;
 
 #ifndef CONFIG_USER_ONLY
-- 
2.34.1


