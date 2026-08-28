Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8CDC61DC6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 08:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzrrO-0006nl-T7; Fri, 28 Aug 2026 04:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wzrrN-0006nc-Se
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 04:22:49 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wzrrM-00055i-4L
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 04:22:49 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso11791985e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 01:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787905366; x=1788510166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fVfqtC47QEwi+QDe5wq0aCCg/+/S37/iVi1jhrKVS0I=;
 b=HJ7U1AbZgDeV5HL3oLHwNxLV/TZPpx6UQW/LHuMazt+C54uoAU10z7sCPgxCOd2kzi
 RCwwB05hBasq3emGswOH7ixJGkcLYZJGL2dwYsSuMBPNJGaS2hno537sMgPC35Y9l4Sf
 r5Y+PlhUkbjjhZTvVb54oaGO/aSVEJdtzHooAqpHe5lCz/fw/5N43u2H2seYlJwidGID
 ns3/4ALjZ7KPy5C4Kjzf8cBDu/NgGD6toEiwNCWu9DqfjvOH4wKCWFo8JzcwPmn5laxz
 i7dWFEoGcCMEFXnkkheAE0jVcjU0wfGSMqJ1LbDw1/HduluKnRzAExE1hKa2CsdCrixO
 9W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787905366; x=1788510166;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fVfqtC47QEwi+QDe5wq0aCCg/+/S37/iVi1jhrKVS0I=;
 b=CdNO0d5eK2wMm5FzPiOOrCHcwCs4V9Mplxp/Yc+BwavfxGGWUTzPRl3/ZH1RqxEd3z
 dOp+R1csMNXHCdMWHAfixdl9KPk9diabT8aD05RoDbO1ytrtN1dOH5vNfpGBYBksUh0Y
 +pfzHwEI9FmeBF8b1RUCPnbiVECLCEax2oXSPy2NjXM5GYUmS77u/ucmSfMC9izi4ARL
 VV2cyL3MDGMBJK9rXw5d9KPMhAm1r+THcAckgZ7NwWwqcq26NeusduCtpIXnV4Zu27rE
 yYPRDniYQJze1fwZAqe1hodux0YC7rnTPCDUGgJ7oRbr3MeMpzD/E7ZjMnXaZ10ePykG
 pIHw==
X-Gm-Message-State: AFuF++nrcrdmTCjKM3zqKiiq8GLgWNgF/k8D7wWhI8goVJ9OlRJ113wb
 Cz0LDyeBEjjDCKhvoL82xMd+1mcFWOE6RE3fC2kyozRNQjN5Wk+5y5zt37SqzKgXTj0=
X-Gm-Gg: AR+sD10LhYulPU4kpZ3f04m24UEaVqOz/SFOhnydUqUFRypaxUmNpzUJ700QTt8g6rr
 hKogTJy5ZChW7I85lj+Uy0LuswBznPQQUDoKDrTqP0Px5k3CwCp+vhixsjH/8SvwC7gezhLH5tw
 LTEB5sMAvdN7J6LxdS6GXcUi51x4tx/lon54NRRWNlzK442kAKRyG3bco/WEJlCoSLBJy5KJNjX
 giasY1IGV7rWkgmeLYo8uYPh+9X2/NlCt7ZtBTvIG1uU/6HaIlkRbOzswZHPOYBW6SgJLXvDWXw
 bLWx5uJu4jr4Upa60Nu3IijX/s2YLqHMOLoWa9Wm2r1yweDiUcgqXjAyk0oMkbCSxlfEmNrEhQ4
 0xFfOnQT7Jw1lmcNCxfbbCHxdalfeYI0MIhRX13YKTYLWshEm7OOgpp5okptM5ELq7JyzgfUyv+
 6t6vYaR84+fx9w+jytLDbMLodA0mKu4Q2Syzh23mu+sJbnP0rbj1PV+vIjg2VCGWsgUTxrjoyOR
 TrVYTnp402rRPnzECZ7SDA6HXAe3lUcE+xB9TQndCeNJ/wNNap3ALLBkJo6zaovaU8lB18Gk3Dm
 pWl7
X-Received: by 2002:a05:600c:474f:b0:49b:e22:4ee4 with SMTP id
 5b1f17b1804b1-49b91a58979mr58952825e9.4.1787905365456; 
 Fri, 28 Aug 2026 01:22:45 -0700 (PDT)
Received: from simon-macbookpro.fritz.box
 ([2a02:6180:203:ce01:3d32:6ada:3037:d148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b49cc6446sm100012255e9.7.2026.08.28.01.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 01:22:45 -0700 (PDT)
From: Simon Scherer <scherer.simon89@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 Simon Scherer <scherer.simon89@gmail.com>
Subject: [PATCH v2] target/i386: clear C1 for all x87 compare instructions
Date: Fri, 28 Aug 2026 10:22:35 +0200
Message-ID: <20260828082235.128360-1-scherer.simon89@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=scherer.simon89@gmail.com; helo=mail-wm1-x332.google.com
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

The SDM specifies that FCOM/FCOMP/FCOMPP/FUCOM/FUCOMP/FUCOMPP/FICOM/FICOMP/
FCOMI/FCOMIP/FUCOMI/FUCOMIP unconditionally clear C1 in the FPU status word,
regardless of the comparison result.

helper_fcom_ST0_FT0/helper_fucom_ST0_FT0 only cleared C3, C2, C0 (mask
0x4500) before OR-ing in the comparison result, leaving C1 (bit 9) at
whatever value it already had. FICOM/FICOMP dispatch through the same
helpers after converting their integer operand, so they inherited the
same bug.

helper_fcomi_ST0_FT0/helper_fucomi_ST0_FT0 never touched the FPU status
word at all, so C1 was left untouched by those too.

This patch clears C1 explicitly in all four helpers, adding the clear
into the existing fpus mask for fcom/fucom since fcom_ccval never sets
bit 9. For fcomi/fucomi add a new separate clear.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4378
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
---
v2: merge the C1 clear into the existing fpus mask for
    fcom_ST0_FT0/fucom_ST0_FT0 (Richard Henderson)

Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
---
 target/i386/tcg/fpu_helper.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index b812125efa..aa6527b0f5 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -531,7 +531,8 @@ void helper_fcom_ST0_FT0(CPUX86State *env)
     FloatRelation ret;
 
     ret = floatx80_compare(ST0, FT0, &env->fp_status);
-    env->fpus = (env->fpus & ~0x4500) | fcom_ccval[ret + 1];
+    /* C1 is unconditionally cleared to 0 */
+    env->fpus = (env->fpus & ~0x4700) | fcom_ccval[ret + 1];
     merge_exception_flags(env, old_flags);
 }
 
@@ -541,7 +542,8 @@ void helper_fucom_ST0_FT0(CPUX86State *env)
     FloatRelation ret;
 
     ret = floatx80_compare_quiet(ST0, FT0, &env->fp_status);
-    env->fpus = (env->fpus & ~0x4500) | fcom_ccval[ret + 1];
+    /* C1 is unconditionally cleared to 0 */
+    env->fpus = (env->fpus & ~0x4700) | fcom_ccval[ret + 1];
     merge_exception_flags(env, old_flags);
 }
 
@@ -556,6 +558,8 @@ void helper_fcomi_ST0_FT0(CPUX86State *env)
     /* OF, SF, and AF are unconditionally cleared to 0 */
     CC_SRC = fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
+    /* C1 is unconditionally cleared to 0 */
+    env->fpus &= ~0x0200;
     merge_exception_flags(env, old_flags);
 }
 
@@ -568,6 +572,8 @@ void helper_fucomi_ST0_FT0(CPUX86State *env)
     /* OF, SF, and AF are unconditionally cleared to 0 */
     CC_SRC = fcomi_ccval[ret + 1];
     CC_OP = CC_OP_EFLAGS;
+    /* C1 is unconditionally cleared to 0 */
+    env->fpus &= ~0x0200;
     merge_exception_flags(env, old_flags);
 }
 
-- 
2.53.0


