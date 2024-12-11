Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC84E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPdq-0007dm-Nh; Wed, 11 Dec 2024 11:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPdB-0005BX-UW
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:15 -0500
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPdA-0001NA-AC
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:09 -0500
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-46779ae3139so18041761cf.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934727; x=1734539527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HK0z0ExtviTrlbAmakVCcZYDfHeC3cJ07okGdevabg=;
 b=LrF9tZDpw7guhD60X1oV+xuTFafZD+NH85ZOqKPfYj0mydxVq73U/UOvww5d305pK5
 9g3/cTLElwNE7GXODt70Nn/l6lf0HJZ1dTm4yMfk0tcCKA63vBAwi7/tfGRTidxbhc3e
 XgSEloFYik1X+NyQ1Seti2IXp1TpX+l0M8vI5Bghlsvyg4JrFlTSiCHJ8tBJZJQ3lbmi
 PC6jyFdVHW2E9w4HFKtrnVxho85UJh4JdokXbpaxZvsxJdOzDMOHO84URE0tvZnSlnc2
 pnZ0hUArtuxvmhj+uzmHXB8hllKNiUP4HJcFlCYDfDp37ts8bhzK9qy9knA1F1bqNxET
 Q3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934727; x=1734539527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3HK0z0ExtviTrlbAmakVCcZYDfHeC3cJ07okGdevabg=;
 b=AtQqSpguDAcuqx0Elld8tOqQW+bMBUxIvh9jho4XlqUzjsi75MKFYel7l/hpuYYr8z
 Rp6zX5vzCKValTupI3jq3nnI+6L482DfxTDEAZGFrFuyuWGz5V1Hnp3j5jPDV/IGlsyB
 rygrwvhAJFa/zP0Pt3PZLTR3r7vEwMP7FLUHa00Hv1hy1ol+0lkNSCqNn6sMGB03iBeV
 wR5rX7YD8NYNcNnxaupGjvH9DMVxT1O1mNeqE2ZVh0JvLrUPadmOhENQJo6pJJcpXyD3
 JtpczP1xGw78dOrhjg6xnuCD5NRbC4KuAnxucEd+jFt1OrW2ezgbEoP1EjxUeagA0P/s
 vVgg==
X-Gm-Message-State: AOJu0YyOMPwcLqbWtRd8ey33enqfDe4qp/Q0DVSeuTePkfoR2ND3EsUS
 w2wlVxRSfKBtgFx9bf7Ye+KZs24sZkJl6pVhzQYog7HCs/Vk4ZmAO8SCYLewIapLGoB7kPHEdIY
 ycr2WgZ6X
X-Gm-Gg: ASbGnctysWdrLRkgS1xPHvFy6Or9qtvP57eSc5f1NYY/bpr462Kalb7FqLAYYrZjrbs
 p9tLY0P4e0P97vpp1zVHrTadc34tK2ifcAybLd2j4wieK8hS7SMj/0p9goDI2eClVCF76GTH56m
 4ORAS8u9Qj/kNEjlArMwgswxFF5ShPrJobflXwvJ3FWMWEuu3/QfU8yGc9kiasU8V3dTeJAfkQd
 240trCt6xk9RIcU4Ex4u4r9ZwnN+xUny5mQLSx/IguFFwMpKJ1nsk4IRNaWJw==
X-Google-Smtp-Source: AGHT+IE3Zzvn7HpObxRSj28Dc2ya3jmvmUHZR+vcPW2ROgH0tzeLJnOYjSD8NI3MUY1Godxm2KQDmQ==
X-Received: by 2002:a05:622a:353:b0:466:a6e4:4c1a with SMTP id
 d75a77b69052e-4678936d081mr55205631cf.31.1733934727069; 
 Wed, 11 Dec 2024 08:32:07 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:32:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 23/69] target/arm: Fix decode of fp16 vector fabs, fneg,
 fsqrt
Date: Wed, 11 Dec 2024 10:29:50 -0600
Message-ID: <20241211163036.2297116-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x836.google.com
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

These opcodes are only supported as vector operations,
not as advsimd scalar.  Set only_in_vector, and remove
the unreachable implementation of scalar fneg.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a99f3d0d13..3c1784593a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10816,10 +10816,13 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
         break;
     case 0x2f: /* FABS */
     case 0x6f: /* FNEG */
+        only_in_vector = true;
         need_fpst = false;
         break;
     case 0x7d: /* FRSQRTE */
+        break;
     case 0x7f: /* FSQRT (vector) */
+        only_in_vector = true;
         break;
     default:
         unallocated_encoding(s);
@@ -10877,9 +10880,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
         case 0x7b: /* FCVTZU */
             gen_helper_advsimd_f16touinth(tcg_res, tcg_op, tcg_fpstatus);
             break;
-        case 0x6f: /* FNEG */
-            tcg_gen_xori_i32(tcg_res, tcg_op, 0x8000);
-            break;
         case 0x7d: /* FRSQRTE */
             gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
             break;
-- 
2.43.0


