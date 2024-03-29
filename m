Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B131CD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKkz-0002XI-UT; Fri, 29 Mar 2024 18:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKkr-0002Va-8I
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:21 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKko-0003Ug-1J
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:21 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e00d1e13acso17037965ad.0
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711751476; x=1712356276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3kIU3JSkECGRrhdZz70XwC7c17Krm7Zw1Xd8qBgKizs=;
 b=hIedfRjeT+5TI3n4efkyBI4fnygGBLhxUxepwd/3tf4eqgigko1aStEgsu7LHZV1Xz
 kxaryZFGKatWFR+bGiBjBKHd0R9tCKNNmqeLlt+YFeFswEYS9db1bCSvVUgh4VYIldaX
 UiErhFXh/bseotkxcim4V7WhIQxsjaXyptgagcLxgevyrHUoKGKWuq2Yj8N2h4nONxVE
 /624cNa1GWs1pBf3JXZPtSNN5S/7OC3jI9QOlLtaeDwBhgOvPpckuqXfReX6U6SKz+SI
 n0BZz07mZkzoAUABP8ndj7C5rzdAc8gJM3yA64zKR0HK6XeQriY7pCYngdgUosYd4URb
 cyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711751476; x=1712356276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3kIU3JSkECGRrhdZz70XwC7c17Krm7Zw1Xd8qBgKizs=;
 b=V/UVuTBNntisEdTnIy8ujd6Nraio2inRLvPHfVq1A2fXU1VERMNvxKgvS4QgtDmBoa
 hb4xBU6pYLwm0XNfYX+5mss7PX2R2DNn8soPB48XI1+bAq3JNxG6Y/ttgatdAlcILxjl
 7+pWpYYvuU5bEj4IizqiHb3+oJhLCpJM2Nbe2Wtni5v17x8KBOMu6OevCYAUuo+8Eoyc
 A7vEYYQ77LynGLj2I42p2CU/iOEcLp2xyTp353887EFW5hLC9SzbasVd0FNKGhFr6BMM
 vAe0u5LbEOaCVVUObukoZQJZoAQe9lyIj0G1C69VQEAI06MiuEiUOH11AEqm5PrGGxmW
 m7qA==
X-Gm-Message-State: AOJu0YxldacCD6GjGpZM4+2inSZQL4g13XLknetsPHXAAoqvGhVHlNqT
 wPdAkcm2Ci9OJa7MttMzGOuWeyxpQ04q7XDamFWXYurXNdh3TCqI99KY6CMjpPOU6aYkFqh3mpe
 k
X-Google-Smtp-Source: AGHT+IEPSMBaFLftXti90DEYSinR1KWyC41wq9D8uOkg8MDpdgXWaiEy1RDUtFKQABa8QDbdR4oiCQ==
X-Received: by 2002:a17:903:444:b0:1e0:b04c:ec60 with SMTP id
 iw4-20020a170903044400b001e0b04cec60mr3514278plb.51.1711751476527; 
 Fri, 29 Mar 2024 15:31:16 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902684800b001e09b636cafsm4000955pln.287.2024.03.29.15.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:31:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 01/18] target/hppa: Fix BE,L set of sr0
Date: Fri, 29 Mar 2024 12:30:54 -1000
Message-Id: <20240329223111.1735826-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329223111.1735826-1-richard.henderson@linaro.org>
References: <20240329223111.1735826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

The return address comes from IA*Q_Next, and IASQ_Next
is always equal to IASQ_Back, not IASQ_Front.

Tested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 19594f917e..1766a63001 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3817,7 +3817,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
     load_spr(ctx, new_spc, a->sp);
     if (a->l) {
         copy_iaoq_entry(ctx, cpu_gr[31], ctx->iaoq_n, ctx->iaoq_n_var);
-        tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_f);
+        tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_b);
     }
     if (a->n && use_nullify_skip(ctx)) {
         copy_iaoq_entry(ctx, cpu_iaoq_f, -1, tmp);
-- 
2.34.1


