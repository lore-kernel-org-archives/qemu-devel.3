Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C629CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBreU-0000cC-2i; Wed, 30 Sep 2026 06:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBreS-0000bV-U8
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:35:04 -0400
Received: from mail-dy2-x0d.google.com ([2607:f8b0:4864:36::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBreR-0006KP-Fe
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:35:04 -0400
Received: by mail-dy2-x0d.google.com with SMTP id
 5a478bee46e88-347866278b6so1575648eec.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 03:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790764502; x=1791369302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=u4zerbzfr1cOkpcAc9FqDdt9nV4aUJjYRa6qrfobpGg=;
 b=d2doOu3GZJqDITTHh/HA7hbEb89+Xp3oLMTbarHdNSuWs6b98O0LRZCogNGO9Bj2kG
 7DPC4N50kHPf6goXdBMAVJSY/Lg+DGofDxOqaNJqGbpnlzSCc7bJ+YqNMwtFyB5QH7o6
 0yDXhu2EL6bsxqXXMDvyJKeZuHzjmM3jUpXyl+1VElF+IczQY+T3G4BZDUtg4W9qs6eZ
 CLny4ou5MwUNLkq0Suwq7SWm4GvsXqn6vrtxz2HKC6pBcM8vWNkobFq4amtiDnfpJ0O6
 c9Lh1jhtb5bGGEjxoA9heAr3E/Zjj1iumZdf+cRi3h/O3OR6S7IukebJjHyb1kz1Xc21
 NSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790764502; x=1791369302;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u4zerbzfr1cOkpcAc9FqDdt9nV4aUJjYRa6qrfobpGg=;
 b=vkIUcIw7DGLyDHLivxCIuCskU0ahQIPKhfz6Y38S4oAFO5eY076pVxS3YHzFSDqFOg
 BOEtM3lLt+2IZ57ZuTGotvgstRmiflT+RwxBz/6cTgCrLQKOtAzOkWzRfl9JFGaqaGDU
 SWhG0wiJPJ2TVNHdd2pbXBAWiWfJicaBnjHKcH3DEVk6baolhBrv1NTsxvX2P3AmPZEK
 jDSMwy3zSQbo5vW7UxfesEmpcmVbtxTElS2w4qsb46S81YbdlTrJToaIMrUHltw29Pcj
 C9nvMD65QkErsI7NDzAxPlQWd5jCG2cg+DFGjatyXyD1pSqgd/1F6We25wI84xFhewWl
 x96A==
X-Gm-Message-State: AFq9FYJhAvp8OsAUc9H1P1XJllwF0gZcd4y1F/sErrWn4mPvLAMTZQUO
 jbdrR3QJabAeGKluY4x9mwQ7DZLnUfq6TP2TFOEZP5ol16MYLSQJpHBVFgcWcVhI
X-Gm-Gg: AYBFou2d5sDuetDg7FbNKGulYtgVVD0oipKZ0+GRfvIW6EbtphRQZDCaapuBvkL6249
 X7JEbyyi3uzmbqi3ygtwPUqhhK1tROd5BbdCPzyrTFdjrjOA/8EdOzwy66HAo4NNCyIq74U26X5
 26E7k1qTOhuaWXq23vdRweltX5ZNAEW+le+OJ+ZNHFgvhxWs7dYNBEoxDMDpNuGzPVV289dUfMX
 +iT/o6C4GuCOmrbSwIBT6NNuqFR74Q6ckJQLsRQEkIREMxM2glMGowYai7fbmxhIdTl4JdeC3aG
 3AiO/jI569QrjmWGQ8lLFTxwBG4Cdx2pSp0RoeEb8GzdtioNUGWEAkJSqLPXZaRX2iJLFgaGHzt
 7bKDFi3uZxnZKIsC0ZRdtkYWsOmaIGPXIvA9rBOp7I8jQT78dsA3jriLyRI8Z/LyP3bUpIgzFOF
 tHnezDMOuDUtwLDtohApAwAITz8VBPO7889Y43VlC/yov5EzKx3dcXefqBTxDP9tnd5Mu9U1mjE
 ASMOaVIpqlZ4xKVn5lWaimqdT9a
X-Received: by 2002:a05:7300:5618:b0:34b:f456:25ce with SMTP id
 5a478bee46e88-34cd917d11emr1332485eec.3.1790764501828; 
 Wed, 30 Sep 2026 03:35:01 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34cf4a605c2sm2980790eec.7.2026.09.30.03.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 03:35:01 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daude <philmd@mailo.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] target/hexagon: use i32 for wait helper PC
Date: Wed, 30 Sep 2026 18:34:54 +0800
Message-ID: <20260930103454.647-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::d;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fixes: acd2b7a2f19 target/hexagon: Implement wait helper

Signed-off-by: Yonggang Luo <yonggang@gmail.com>
---
 target/hexagon/gen_tcg_sys.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
index af5032214c..faec55f502 100644
--- a/target/hexagon/gen_tcg_sys.h
+++ b/target/hexagon/gen_tcg_sys.h
@@ -80,7 +80,7 @@
 #define fGEN_TCG_Y2_wait(SHORTCODE) \
     do { \
         RsV = RsV; \
-        gen_helper_wait(tcg_env, tcg_constant_tl(ctx->pkt.pc)); \
+        gen_helper_wait(tcg_env, tcg_constant_i32(ctx->pkt.pc)); \
     } while (0)
 
 #define fGEN_TCG_Y2_resume(SHORTCODE) \
-- 
2.55.0.windows.3


