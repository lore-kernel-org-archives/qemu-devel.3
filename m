Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA91C83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFk9-0002TZ-Uc; Thu, 03 Jul 2025 04:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFk7-0002Sg-Re; Thu, 03 Jul 2025 04:56:31 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFk5-0007z0-5N; Thu, 03 Jul 2025 04:56:31 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-748e378ba4fso10191797b3a.1; 
 Thu, 03 Jul 2025 01:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751532987; x=1752137787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kDVYKioaP//F/+wWF23qKuUDqxQg0Bmhy05BTrTCAN4=;
 b=ZO3MerR0UPcfV87CBDTDsAa50lCGF9Gvqo9soqO2JPQR0OBFGbvgvdcidPHchNYfdJ
 oosdR7iu2lIX2D3RuHl7CxpHN4KkxjQzxUhYtWo0lqnuZUawoMiT1W92jgmAHTqD7fh8
 L3Sxxsex7LqbVZ/CrVLRCj3dXY9GLNTXnTQuXeRJrk21DNU2F5j0ilOsMHTPJEBFaNGr
 ZecowvI98jm5uuqN7OK/7uLovviVGYO5eFRVzVNBlGd9ABRcH2Pt09EKbDDETmI6qAdV
 JgMan14zn7C0wB+MBgjBatFigvX5XhHFKk1b0J2FHvp9nmQCCx5A/gfnJfpl58a4uA+C
 RVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751532987; x=1752137787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kDVYKioaP//F/+wWF23qKuUDqxQg0Bmhy05BTrTCAN4=;
 b=wKRBQUS+JM5+4wb7rz4yWol+o9ZiyOuRYh94ZVB1cHb72iNVWj0NCGPoNc2xmRC1Hl
 1TATZ3g95u7+nYO/OvGnFC9alE4xsiwYJwOh+yd0f7J7y6OZxBDpDsqCSSuXQLg1IZM6
 cM3JJETZfBHEnRjFuJy1egzV8qtaJgLcy5u13KtLGTgX+D3d7TZ+dTEcj4tIDku6fqak
 QY3jynppez+N8faJ4weNPkfvr+tAb9UiiHFO3HGGRmgKIxirG50as1/zUq4R+l9oiDt3
 QgP++gQQ7hCllYPIZMy1fm/aZhpMCy890iFeKiGGsRCzeeF+0WQdRSz752QPlAHiYolz
 yMjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIMMVbrWmSg+mUQYf8hhP0NDWyszICF/Rdn3HYFkDA82bNK5MnnlC9xQlRp23F41z/bzhOdnvugg==@nongnu.org
X-Gm-Message-State: AOJu0YzeY4GXuN/1VZcVuk2q/U4JY5baM3FmVD5/yQyBoC8+eNuoBd5C
 xejsx2rW9yPLafvL4qFVZIk4SqVJwCZvWVi1mfaHNAfrCqCKmY2/F3TDbY0iKLNkka4=
X-Gm-Gg: ASbGncugSyqxzOV4PnAEW2ylbqBaF6scY7XPffRiAYNHFNlUuJYjyLG7TlkHc53JgK2
 i9TBU6lJ9y1Y+vd1Q5ADKZtG/8woDI+iQS3R4KJDlFbsbNhWczYy8Ysfi/Zt50a7bx49S++CAxn
 8wMT0zY99bsAQ0ezpA0bvPYesf0EOXBD5GQY/381n/eDcypXvePEm1cbf5Kupi3hGkkEg6CzzrP
 +BQJ73gEFcvT6vzyNIFgFqk3fdHrkK71Ja3rD2w2BKNxYAmNWkW8ssE/jpS4UFZiJ6MWfYDL1p0
 +56I//L7c4ry4Pxz2hLPG+vOPbqgA9/Ytm5kvQQdm2aA9mhx3W+Rbu7s6Xgte2fVIIZhkk/a54G
 PKoFrEOt0xr5cam/b9tDfelPfgqeGI//BR6/+fMhgeQE=
X-Google-Smtp-Source: AGHT+IFW5ANqC7dlMVkcOL1jv/LQfv1hy0MbG3/AhtzQ8LLvEAy/bmyqjfrWB9L6FS2Idl+yUBHD1g==
X-Received: by 2002:a05:6a00:22cf:b0:748:e585:3c42 with SMTP id
 d2e1a72fcca58-74b5104c95emr6297478b3a.15.1751532986888; 
 Thu, 03 Jul 2025 01:56:26 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-74af56d0cb1sm15870233b3a.134.2025.07.03.01.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 01:56:26 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v4 03/11] target/arm: Fix function_return helper load
 alignment checks
Date: Thu,  3 Jul 2025 18:25:56 +0930
Message-ID: <20250703085604.154449-4-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250703085604.154449-1-kosasihwilliam4@gmail.com>
References: <20250703085604.154449-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pf1-x42b.google.com
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

This patch adds alignment checks in the load operations (when unstacking the
return pc and psr) in the FunctionReturn pseudocode.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/m_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index f342d93489..28307b5615 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -1946,7 +1946,7 @@ static bool do_v7m_function_return(ARMCPU *cpu)
          * do them as secure, so work out what MMU index that is.
          */
         mmu_idx = arm_v7m_mmu_idx_for_secstate(env, true);
-        oi = make_memop_idx(MO_LEUL, arm_to_core_mmu_idx(mmu_idx));
+        oi = make_memop_idx(MO_LEUL | MO_ALIGN, arm_to_core_mmu_idx(mmu_idx));
         newpc = cpu_ldl_mmu(env, frameptr, oi, 0);
         newpsr = cpu_ldl_mmu(env, frameptr + 4, oi, 0);
 
-- 
2.48.1


