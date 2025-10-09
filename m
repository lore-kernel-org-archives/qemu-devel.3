Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98276CCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 10:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6ncA-0005ew-4d; Thu, 09 Oct 2025 06:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6nc3-0005cw-KX
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:11:07 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6nc0-0007Ai-5M
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:11:07 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4060b4b1200so850261f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 03:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760004661; x=1760609461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3PjqgFL7phsYi5vARyeAfuQl57p0VxPm57bIjMwLO7Q=;
 b=MMe5wK74bx73YQgWo52shlPBM2fi5HFXqJO33xi1LVc+BGpPYroCi+QQocp2UPX9Oi
 Vc/Ufv1duCgT6QQpF1GSRKiSvRvkTUeMRomaDNBhy5LW+Ga3jOvX5F/fG2fA4/HmsN4j
 zy31YQGPEW5i6bwhaOvXNVdLR95qM8mw8un5P9bKBFaCcnmxSdVkkYT+d3n9l2TlPgMB
 hddnMkOmXlxr5kbg1Wa/hg/w8x/jwxqMfLj6420wG9ln48VVAuEjN/HZlPLkcbspN1bi
 X/UKhVKj0xFjt89D7hTng0n/VaHIupJByISFYeAXg1PqfTt2nT+lPJHl6VNgfBQEXgN5
 ydmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760004661; x=1760609461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3PjqgFL7phsYi5vARyeAfuQl57p0VxPm57bIjMwLO7Q=;
 b=Raaq0gdPQkwxO7He27o4+0yhFXaWPSiOt5707AiAHv4i9r0Eb+0QSZnyYRLQI6XsqV
 OOL2SBGKBKLB0j9r0YQSqIgNtUaon9H0c7NN1SschUOBH/f39Ck6lML1hNURRPnxqbeE
 X8s8zm61hRvkl/mIjZ+lvSse+1Gcfl81CpI76rvSmKp/W7jllZv2Rs7b9aRRLE9oOH5X
 V1sljIJBt+nskyTqrDKtSTE41abBQQo1L67u7WEnrdPCXiE060ULUfLbj9Hm7xc/oo73
 UJex+z0cRveJmUdcx0e7Vz+8q/Hkp00srfiOR0rly0lURBsdiaFZj4HOYRa+Cy2EQXDG
 NAQQ==
X-Gm-Message-State: AOJu0YwO8JuIN4XjqLGKqmWK6+Uz/S8Vk47t0FBruKeYAqHqQbcdSA6l
 8kfARt9x3h+4+TLAOWtKlN/Q1SMmnTtV5ARvgAaq7LxZN/u9gMZLdmsyfbppbjMU1nuO3G/eYuZ
 Ji++XtNnJRA==
X-Gm-Gg: ASbGncuLpEv8GqBiaSnOILAic9gkrcZLiMfxRA9MDCdhMWd2ImgrlkDeJ3xfd8AvrK8
 P3v07Pv7b1olOYdfhHgxmOgvsdL1iauW8A2hekTRzvYKV+tzfF1fVNMme5JAtOpXc2/x79olXGg
 6h5DFbATwnvQRx2nPkBbjp7pUQAnWCpbPTLSdC2GPQZpQDR5Z2eDCPt/VaQ0QwzHgEc0VHe8yms
 z7FFDtdMIEilfsuIt92J9Wn04Xhi/aLUmou1y3+bFcf0ChSZ+yPegicSnhkiYn/7/fhi6te/uWc
 JACATJL0Awi7FFzF0CcE94uorJnTcOuAkE5eofUw7d99chQlkP9Jq9fe0Ign5Q4Texue/PF5zxQ
 BzEI+wU666JBVA/+3RpbigztYtW/QVUgvsjg/Txz1FoLBluPNsyRsAXX/VBpjdCDt9hqKOTD2dM
 3VOgVStztKesh5nZhF1xOSpO4+
X-Google-Smtp-Source: AGHT+IHfcPr6BX3yfu6+9QTWVJ0lRP154DsWq3w68/I6dQ7ieEVkdvs6KhDJXf17fqPHuVdZv4Nl1g==
X-Received: by 2002:a05:6000:4205:b0:3f7:b7ac:f3d2 with SMTP id
 ffacd0b85a97d-4266f752fb9mr4323674f8f.43.1760004660788; 
 Thu, 09 Oct 2025 03:11:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb1e0f019sm19954175e9.10.2025.10.09.03.10.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 03:11:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/9] target/hppa: Conceal MO_TE within do_load()
Date: Thu,  9 Oct 2025 12:10:34 +0200
Message-ID: <20251009101040.18378-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009101040.18378-1-philmd@linaro.org>
References: <20251009101040.18378-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 859c6cf5f9b..ee0c874342c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1676,7 +1676,7 @@ static bool do_load(DisasContext *ctx, unsigned rt, unsigned rb,
         /* Make sure if RT == RB, we see the result of the load.  */
         dest = tcg_temp_new_i64();
     }
-    do_load_64(ctx, dest, rb, rx, scale, disp, sp, modify, mop);
+    do_load_64(ctx, dest, rb, rx, scale, disp, sp, modify, MO_TE | mop);
     save_gpr(ctx, rt, dest);
 
     return nullify_end(ctx);
@@ -3302,7 +3302,7 @@ static bool trans_ld(DisasContext *ctx, arg_ldst *a)
         return gen_illegal(ctx);
     }
     return do_load(ctx, a->t, a->b, a->x, a->scale ? a->size : 0,
-                   a->disp, a->sp, a->m, a->size | MO_TE);
+                   a->disp, a->sp, a->m, a->size);
 }
 
 static bool trans_st(DisasContext *ctx, arg_ldst *a)
-- 
2.51.0


