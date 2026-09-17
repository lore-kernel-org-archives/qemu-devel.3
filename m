Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E412C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77JQ-0002hf-Ls; Thu, 17 Sep 2026 04:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77JC-0002ey-LO
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:33 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77JA-0001uG-15
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:29 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396ccafb752so471244a91.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789633047; x=1790237847; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=42p5g49dRk+EkYz4pl8aJmHouDsiqSWhtuPLrU6jsHQ=;
 b=sAkFpJ4d32Ldow+ZifVsXGkYoCfqp61arCyzO9JvX2PLBUBfTE099b1sQSjdZL419z
 mhvyw2WY4cTkpk2GHBmGB3140jQtBWzQn4Nw8hOSqp0L6G9uo9kMA+FeDjMP9k3a2A8d
 sCZmyuExucmj+Xe9VIFap710pz5CZlpo/DgJrTwE4M5cFzGqjrNt4O31IIxS+ouunQoy
 FiKJ9dCH8iy8HuhuJ8HModowumikUY+zYvIOzvsB6z1X+z/3uKdXHyTIcRjyyvjF9lPg
 uffufwwCqXONozM5HG3G7eAv3RBUVdJbzcNMljmdOaCsMd74PDZ4y9au9I6/wubmw1Xp
 waBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789633047; x=1790237847;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=42p5g49dRk+EkYz4pl8aJmHouDsiqSWhtuPLrU6jsHQ=;
 b=EkUWFeXsijGm6ZEcKNBqH4LBuAwlwxOTJPVltGfo/3F7JlEas7inAOoWSPbHdOYWjs
 GU+q0EycSA/B59zZMpueoF4sl29LfPH8qAubOjFggAyjY/UdCE0FlJcHwaql4NfoxbOa
 jcac5+tviPx0wp3aTHcvAe5RTYRoKDHxWIL5oTawKy5PSX9akTaGQ33DlrsoiDGdpcn1
 8HB3m7xUJ/B4/24DIcQ9NTpxp15UZlmXuSGkwuW6XPftt1tjsGh78ixdTZLJyV0ba6US
 aa5sRSkgmPqa5vPiVBmupzaf+HshzFvpSp1bx+Xd84hKwj+L4tL0UZK5OVNqHB/72Ffx
 2/TA==
X-Gm-Message-State: AFuF++k1Ss0oe7gC5NvIaTrai87Xn5jXdV99pAbC+5VSnqHPmuNHpxyu
 vxBxP4e5M0H3CbxTiz+SD2FojfmUN6RyyCw3U3Fpt4h/hu0tgAYuI+ZcH3HDkELjeKqxRnr2WiT
 YJRWGrBM=
X-Gm-Gg: AYBFou2w6X+j6rI3k8f8LHSDn+1Z9CIQmQwbw6ChcV062PvIgw+oBvLkhmwMk5gHlaM
 tiPVnyKXH5MRJUKRuduFDRaZfgFlzovfgYgAdqxeRRLWbIZ+1TdGwxAUHrxNhD7/dP3hg1dFsHe
 Qc7cW6pgADlGwqccCOJMKd3lwe8DXJy6QguuCPC3D1lcJ/RghLxcPWf9JOZ6jA3c88PhLiW6OpB
 QVNp3enMPNu77rEfF2y1/+vtkPZ+lT95YjZAeuRzXjxRl245GWSRos0fu06S8iqB/nxxreITEB2
 K6Ue7TTtsBQmMU6jZHN2YQLKpxju/fGU6zyI6XN+MzqlkGAbred6x+qBWirtQCYSh0SyEWbm89m
 p4/o5otheoe78DoW4hNZNAeliSnOFx1xtY5IJq+tdABWv9so1iAZS51KEzDn8TySLyuZ6Zh2imn
 YR0EY6jEe6WrZICd36cohfEJBXJ5pMeaTE+VTwZ00aO+sfJ+7TSQnn1nTNSYrYvcdm4unJF1tm3
 blJfzU=
X-Received: by 2002:a17:90b:4b84:b0:39e:4547:8f3c with SMTP id
 98e67ed59e1d1-39e45479761mr835131a91.13.1789633046544; 
 Thu, 17 Sep 2026 01:17:26 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c1943f4bcsm127638eec.21.2026.09.17.01.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:17:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 07/16] target/riscv: Use tcg_gen_lea_tl for SH*ADD
Date: Wed, 16 Sep 2026 22:17:07 -1000
Message-ID: <20260917081716.946668-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917081716.946668-1-richard.henderson@linaro.org>
References: <20260917081716.946668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/insn_trans/trans_rvb.c.inc | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/riscv/tcg/insn_trans/trans_rvb.c.inc b/target/riscv/tcg/insn_trans/trans_rvb.c.inc
index 3e74be223b0..82e715c7b73 100644
--- a/target/riscv/tcg/insn_trans/trans_rvb.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvb.c.inc
@@ -336,10 +336,7 @@ static bool trans_orc_b(DisasContext *ctx, arg_orc_b *a)
 #define GEN_SHADD(SHAMT)                                       \
 static void gen_sh##SHAMT##add(TCGv ret, TCGv arg1, TCGv arg2) \
 {                                                              \
-    TCGv t = tcg_temp_new();                                   \
-                                                               \
-    tcg_gen_shli_tl(t, arg1, SHAMT);                           \
-    tcg_gen_add_tl(ret, t, arg2);                              \
+    tcg_gen_lea_tl(ret, arg2, arg1, SHAMT, 0);                 \
 }
 
 GEN_SHADD(1)
-- 
2.53.0


