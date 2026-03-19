Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46854109192F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Mki-0000mO-G1; Thu, 19 Mar 2026 19:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3Mkh-0000mE-Gz
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:07 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3Mkg-0007eB-2F
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:07 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35a09e0dd63so99795a91.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773962764; x=1774567564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZHI7TpU+QC4WTx8gqgxxH5tKvjATJUhEPGXQ538mrRM=;
 b=Kdf255Mw0zqF8XltjUz0NSEfbmT7x3zLKVVMcclqTEWm3/TKywCuZgXYMFonmy7b3E
 YWXNYgQvV6mtec1pgbPHcwnyDkcrpX3nyO0vfZGnFFUPopr9/IkREvgU4g4VtLMIEC4y
 52OvLiuB30zFpPvJeAacmRNlQidkDMWgr2WQiLQM77FerRKRnNpk6Qh9yBO4FGIcxkuH
 aDRssIzNJ4gvIR4JW1jWolhVZnJMmAM6FtkwoHfgfl5K7g9vpReDPKCRwiQeNC8KEyTz
 sfDJBbYGPKQiBlAaAtOtcvGi6lu87H1BN7Cr6cYMIfP75VAFOaTLlXBzJmblXUhSx2Jg
 jdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962764; x=1774567564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZHI7TpU+QC4WTx8gqgxxH5tKvjATJUhEPGXQ538mrRM=;
 b=XqczN3ieQENXzkscmsxMbdpfes7Q+DZfF5FCgJaw+hxGXH5lKCnAFGz7/U3/Z1vL70
 oIgNyWgA96K5qx9au46soOKt72GiuTxC22hT+3akA9rEB2u2MG5xy8cgRSjBbluM0w0N
 f91jLjIuJcNb26tZUS+Rt6ZJ/geiPi4Sp8Qei5l3hlGH4bCsINafy0DTgx5mlwMoKXJB
 C+7QCZBPuC8Tv17PjJ7COkYEGMTHryDfcO8LLBeMlz+lgtc0Fj5R4OgUCXWUPL8/vyBw
 Of8YuqueEsdQCVqrk13GTeEUtv7VX50n9P4qkRjAktgjGq86YmJst3jpYAUJ8d1+Bv6p
 EikQ==
X-Gm-Message-State: AOJu0Yxqmoz3mz327HJXUmoDgmXlhQudEmqxMZ6TdKCVRs0m4DbYXPnD
 kxR8qP41TAV3ZLLVOk/GSuA+2l77VbSdKWF5JX3bRkl/mI43aalVqOmes5WFug==
X-Gm-Gg: ATEYQzz8JCNCpo2BKTopRcpplA+U71j6ro9eEUeFDY2tjXn+FA8UR3jrjYlaknJrqzv
 gjHKSsksFvpzEKWFO4IYKlCBPzfOClhI6NOOHhmz5mdHm+eLXu+rpiaRDVDKS9fbvInSkAwdnLF
 B8Q3ikPdshZ4sMMVxJWAnOUHQ88mC7ZXC5KTITE4HoYeCWn7gBHPylC5FsWh6pA4lqCUR2cmpC6
 jlWJxkYrwfQe7rvY/dN9dQtg1oDogFSMVXSUEuWizg9CkNPiF415INcaEuHewuVpZAEz7z0wtP6
 iyDxEAGfvwlw8xEhIDeawi5bbg0GKQ2dD1yEryZxZ8ga2hHqNSrTsVqASj3Qodu1Z+vuxOrJoWv
 gvA3E/DNLr1oQegbEtYpYrypka3tsZyemBLMlSADikP8BbqH8ic0PCi8eCmp4p9j2uMPGm5O8sV
 oNHSM3C9MJAaxbuCqle0zIyNprPJhgAw2yfxiDm3uvrw==
X-Received: by 2002:a17:903:1a4c:b0:2b0:68d1:2557 with SMTP id
 d9443c01a7336-2b0827c9591mr6709445ad.45.1773962764130; 
 Thu, 19 Mar 2026 16:26:04 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516ae1sm2979165ad.13.2026.03.19.16.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:26:03 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/17] fpu: Fix unexpected exception flags when converting
 infinity to OCP E4M3
Date: Fri, 20 Mar 2026 09:25:13 +1000
Message-ID: <20260319232522.1867400-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319232522.1867400-1-alistair.francis@wdc.com>
References: <20260319232522.1867400-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102e.google.com
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

From: Max Chou <max.chou@sifive.com>

Infinity is a special case distinct from numeric overflow:
- Numeric overflow: finite value exceeds format's max normal
  -> overflow|inexact
- Infinity conversion: input is already infinite
  -> no flags

This commit fixes the unexpect exception flags by relocating the float
exception flag update flow to be outside the uncanon_e4m3_overflow.
And raising the overflow|inexact for numeric overflow in uncanon_normal.

Fixes: 27e989f99c ("fpu: Add conversion routines for OCP FP8 E4M3")
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20260226071817.1417875-3-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 fpu/softfloat-parts.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index a738758aee..3c323c0cec 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -277,7 +277,6 @@ static void partsN(uncanon_e4m3_overflow)(FloatPartsN *p, float_status *s,
                                           const FloatFmt *fmt, bool saturate)
 {
     assert(N == 64);
-    float_raise(float_flag_overflow | float_flag_inexact, s);
     if (saturate) {
         p->exp = fmt->exp_max;
         p->frac_hi = E4M3_NORMAL_FRAC_MAX;
@@ -388,6 +387,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
                 if (exp > exp_max || p->frac_hi > E4M3_NORMAL_FRAC_MAX) {
                     partsN(uncanon_e4m3_overflow)(p, s, fmt, overflow_norm);
                     exp = p->exp;
+                    flags |= (float_flag_overflow | float_flag_inexact);
                 }
                 break;
 
-- 
2.53.0


