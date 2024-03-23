Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B57CC54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Mar 2024 17:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ro5C0-0002jF-4M; Sat, 23 Mar 2024 13:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ro5By-0002iq-Mu
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 13:30:02 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ro5Bx-0005sp-4B
 for qemu-devel@nongnu.org; Sat, 23 Mar 2024 13:30:02 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dca3951ad9so20794315ad.3
 for <qemu-devel@nongnu.org>; Sat, 23 Mar 2024 10:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711215000; x=1711819800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kQVqrnpEFNAMTGSDkWy/XEPY0f16YIjRf/pXZgn4ChY=;
 b=I2+ldY4Eje/9tSyLa30imHZtyycUsA5MqKMLjm3KPcmAf8uLSbvaLGAY/rORvQu7lY
 +0CkmvJsZW3W596vKkwWGFtS0o9ozI5HKw+BrNt5xG4k8Jem1mc94EZMJJ93PqLUWo6w
 6a+aopXovOjjiVcUVn2ltd6VDWSUHPlfQIYBVdySY1jfavcMii1AkAXiqRTuDjh8SnXX
 JqTBciJHiI1tX+rlWTpFmLIPga43g9Epolg7e90lZmN2wi2Us3Fv4AgQIu19I8uRWR7o
 JwakUK2nJu1s40BKdCFGNHua1BP9ist6oSCbGCIDcI26jh0fKocn0f/b6GKLcgX9y9dh
 fldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711215000; x=1711819800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kQVqrnpEFNAMTGSDkWy/XEPY0f16YIjRf/pXZgn4ChY=;
 b=vkuwFw35prCAcBD88DxuybU/hVroXnZVACcYZMc8qJAuWKdBlr1EZ472CZiU5OJcK5
 wpXoeqTAvdObqgDU+sFvR47hjJ3UdzcS7WHPtSl1ebopKLldicojYrAHthKupZMtby1e
 6trwzjINPm2mM1lgiNTGTBTl8iw4nfCku0qheyt3HPwTatBVI1o00Ep9znFpmqj27V9X
 QsSDgEzFHLG94u/d5y9rjc603vdPYEbSrtJzqoigzpGbOn84G/u/GKWbfFodvTuHSWBw
 sZG08KjtXd4fQmvQDWnYNNOf0uVJ/Hb7sFINReu+++Dm12ch6/jDVgrpS1bP8PolRpN7
 VrlQ==
X-Gm-Message-State: AOJu0YyZbB5mJppGY6LuS373Qnus7PLagJGCqAs2Ql7ApnYVHItocup1
 DuR5r0y3w/0TijaTOoG6cABoKANNR7NhnrNWe0dEc/fAIwm+T82scXIigTVaPcmRb4dV6iZIPLF
 Y
X-Google-Smtp-Source: AGHT+IFa4UXqa78gLeMkvX8GrNGZiTS7y9HCnoFhfi1LSa0/QZURkiuuANcruLwT2WmrvOPrIu7ing==
X-Received: by 2002:a17:903:247:b0:1dc:9118:515a with SMTP id
 j7-20020a170903024700b001dc9118515amr3897128plh.37.1711214999773; 
 Sat, 23 Mar 2024 10:29:59 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902d2cf00b001dcfaab3457sm1811758plc.104.2024.03.23.10.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Mar 2024 10:29:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: svens@stackframe.org,
	deller@gmx.de
Subject: [PATCH v2 1/7] target/hppa: Fix BE,L set of sr0
Date: Sat, 23 Mar 2024 07:29:48 -1000
Message-Id: <20240323172954.1041480-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240323172954.1041480-1-richard.henderson@linaro.org>
References: <20240323172954.1041480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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


