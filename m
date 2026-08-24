Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6609C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbI-00054K-DB; Mon, 24 Aug 2026 01:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNaq-0004VO-9s
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:36 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNae-0002eH-11
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:30 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso1804838a12.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550678; x=1788155478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1iq/zZquDTsNMfYQjuptbKKoh31S0HQU5QbrfhrMH/8=;
 b=eT3IFxVsCBTIpKDQF8jU7cAZMeyIyL++0fBDYeylh9pVZBKpoOcdtf8axRWpJFl6+M
 PsEICl77pvSrti45Ww3YiNoRXOEeCJ6V68v4dhIscY3FF3dOhemTMEGzrS40OEObZ17A
 Gq5QU0aGHXiuv5GnUGbpm7UhqgTjihSMn54z5tbnIeDodilSj8DkCU5MfIW4RnbZK27u
 Imdy03/oSSwA+8ABB2eIobKfhJ5BfOXY5nr7OEkpk+0EHbpjMw8WIGI0MURnLg7II7fD
 lxJSHqKBXzTlBOOf2V+ovV2HG38TInlhSw6dkCc+o7tSXKaONl3jz6wRBv2tgYvo3LcJ
 a1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550678; x=1788155478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1iq/zZquDTsNMfYQjuptbKKoh31S0HQU5QbrfhrMH/8=;
 b=lq9NbBc0kg/q0++sGwK5cbF5X9aMQ8lVLYxC+/t1dUc6IGXOZZOlkd+yDcrsZJPY/5
 SUcBoJwUVqasc1YUQXOjdlaWHdGExkf6IoCwMVXBlGNeimWTo4EZywM820FUYhaI2jrl
 r94+3OFrAyBvO1c0yVr4DMBenlgjCVmz9sQHvCMWDcC6D8rpdcwMcl55yJmhx1JZz1AH
 BSdwt63GXAcni+cNz8dlEOYuST3pO17f/ObxGkxovs52B80BV6CbBqOND6tb6QNkEpjF
 ot2oS/shb4kSjMHrfkEga371DVab5srHzATFF3fmyN0Iz7CGsFKr4Bq5rtaP6LgKgmFt
 3GzQ==
X-Gm-Message-State: AFuF++nnA6CDFB0odAIZF5zC6dk34J1PEpy5/6ejBhARqq3wVVU5f7YN
 QB1LrcmzqTZbqAPPv3mx8tIb/60fg+6CqPw2ztPFNBqqgbnvtsQXb7wHqUOsfg==
X-Gm-Gg: AR+sD10zjIY4aU68sX3eGHR4d/ZKsQ8PoHaWxeojXYCrXbECoiH1CQ8fXAAH99O+KSX
 Yq9xk1DKsNoBZyICePCjdt6ePUbFVuDnsdAPOJsbEMKobZTSzQfi+OZ+qnzxXNrr6CHJrR/dF5K
 zJRsyCy97BMN0G9MKGFUBKFnclCdVQRbLw1HizNMYUeBk1K9SAVvtZsS59KMS6261rL18Rw2rfD
 mqbYGdAdor0jQ481rYGAH1Q9AIK31bhXegts7+b7U+6NdlAe+5UmJtobjWjizH0veWMGNYMxL/Y
 GgJ2PfDPzDfcyGAre9JUJA+nXcw0NNlApypUso+fVQim68jgaHrqe1GuplfpN2KJdYmsEgabBfl
 THFP9YGVADZXwGl7HR60MX0U/bZXFYBH36kVuduvnMQlhj6+Zddr6NoKyiFqjy9M0W2qqaaSCIa
 Zwbx+pA31IpMESv2D3OiJk4h8HhT2eedqnZUqgjTaQDAVYkoBJonCyklEIBbORThU39ibmdyQ2e
 iXarg==
X-Received: by 2002:a17:90b:2c87:b0:392:7f74:58c9 with SMTP id
 98e67ed59e1d1-395c3a43766mr48571826a91.15.1787550678356; 
 Sun, 23 Aug 2026 22:51:18 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:51:17 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 59/96] disas/riscv: Allow decode_inst_lift_pseudo to loop
Date: Mon, 24 Aug 2026 15:47:29 +1000
Message-ID: <20260824054806.2790041-60-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Allow pseudo expansion to proceed in multiple steps.
Assert that we don't have simple loops.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-27-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index fe503b6cae..b8e5b124a5 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5259,9 +5259,9 @@ static const rv_opcode_data *decode_inst_lift_pseudo(rv_decode *dec,
     if (comp_data) {
         while (comp_data->constraints) {
             if (check_constraints(dec, comp_data->constraints)) {
-                dec->op = comp_data->op;
-                op = &dec->opcode_data[dec->op];
-                break;
+                const rv_opcode_data *new_op = &dec->opcode_data[comp_data->op];
+                assert(new_op != op);
+                return decode_inst_lift_pseudo(dec, new_op);
             }
             comp_data++;
         }
-- 
2.54.0


