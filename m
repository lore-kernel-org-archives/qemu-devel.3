Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D968210F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYJM-0007x2-DV; Wed, 08 Apr 2026 15:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAYGn-0004S0-AD
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:08:57 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAESY-0005Xk-DK
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 17:59:47 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488c2690057so8708595e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 14:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775599184; x=1776203984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=agmdtPgbKNlH9bAAj1AAHRxJL/aBymX0MFrBnGbacuc=;
 b=NhZ+eN3SWHnww8pIvyqKKOzGUdO1TYrOLkztMddlTxJb87nZJqxhrOZ7T4BezsZRPy
 kKPXLg5x0U/fk3ClUL9BS15RqyzlEbY3fiSd2FpvV5wrdR/K/0CuUCQLjaWj8kgIGrjo
 D7zJN3QfK8ylg/mF0yXL47X4gZb4AzvXltoTfs15G/0sCel4y4+ewZSw/m6qMomV/t1P
 Y5QNecgHT8+3iThfMxTk14sSijkh9me50FgMH0lrYEc6xxA6UY3AaYyMKo24os4ZLZ8+
 2ZVL5gkrL/bxFXB/lLSUfPXmgx4EZNpSp3HHa7LHCLn77sh2eXMDD+Y0MHX8NlPOKbip
 vsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775599184; x=1776203984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=agmdtPgbKNlH9bAAj1AAHRxJL/aBymX0MFrBnGbacuc=;
 b=nWScz/LP31Je89HRGklS/9S+gMZhByQQ73cpnXP9AOc/WTmoqa2f19XG4ueVQ5SesU
 DwNyKBSsLdVFwH9gkg9zYeuu6/aGY5jODIJnHtd2MOA6fqT9ATQbToUVEU0JFIDWa+0O
 /SB+Rm9KWXsVpcDiL+B0uSmlLdNcFeAIYyX7OJl+woqnQRPH8+iGVMfRKBJIhgzP7B1D
 q6BvJQgyi5Yx1g3mpw5jpDprEIL2Y6TwIjIJRAc0F/FVTKqLTmeP4QYVrM8pGqF9CqUU
 nubpOrS1Li9M9HFikqNlDsdZJ4CHva40Xk5ssAKKUFXga9DWjmDoF0azYUAKxck0TgIy
 li6g==
X-Gm-Message-State: AOJu0Ywik995ut2tgWmc+Jj3gSExnRUo/cRexjqlsnlFGSsWMKu8a/rf
 v9JvecPUq5fTMA8KrA0+D4L7l5QpRWFsTeKZkKxKWtNbdZHI84fWDXC+hjyQwloeu/rwDsRD7HO
 yc4UdT/0=
X-Gm-Gg: AeBDiesirp9Zt+YWWslN/nd4OvryRJKB90e/pB3O+0aZYEVPgNG0HuXdo+LDuwFZnH9
 b2dYda/GUgqPrOvIHs8O1ibJ1jBEvvKTLGJOutFLEYM0IbV5Om1z/2aXA0LQ/byOvzU5EE8+hkP
 6VA2uECxbUMPEG/t8E9gFgxCT4tJd42Gb/VaAf8fu2zA8tJjQLF3A6H0vENGG8kCDcpzPQFg5O/
 XRhzToVnyXxKIYQPQUFcwNtT/0abyse+GFK2bywwzHsNKpaX61z+LTL3hisutH8aEq7s4NKf6L4
 P+ludPXIWWEckuMOA7KjSHQ9aEyTCIFi6ScmoTT+rOtPwNU6TPkS0X4P5liW4kRNKtUbaFILWwM
 ou4m9pEZvO1x3K7wj+T+leVl7NxpAmQhJa0Ncmy7hfyl5ayfVK7Ol3w62MiEDNxcySEB3JyJbtL
 dORPcS+9mBxhE86W5KV+vD20PXohjkovbS4Ix9wt7W40+J7fzc3zJfXxSaSMXTtRR19RoS8ygJ6
 A69gYjk5cc=
X-Received: by 2002:a05:600c:6286:b0:486:af22:4a2a with SMTP id
 5b1f17b1804b1-488996dfebamr259333495e9.7.1775599184543; 
 Tue, 07 Apr 2026 14:59:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488c1c5291esm91154425e9.15.2026.04.07.14.59.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Apr 2026 14:59:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH-for-11.0 6/6] ati-vga: Do not crash on 24 bits per pixel
Date: Tue,  7 Apr 2026 23:59:00 +0200
Message-ID: <20260407215900.63390-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407215900.63390-1-philmd@linaro.org>
References: <20260407215900.63390-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The stn_he_p function only supports power of two sizes so it will
assert if we call it with size 3 that happens with 24 bits per pixel.
It's not clear from the documentation if this should be supported or
not and drivers tested so far don't use it so refuse the parameters
that would crash QEMU for now.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
Message-ID: <20260406012031.335A0596A24@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_2d.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 9baf6ff37b0..f0f77cecc65 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -265,6 +265,10 @@ static bool ati_2d_do_blt(ATI2DCtx *ctx, uint8_t use_pixman)
     {
         uint32_t filler = 0;
 
+        if (ctx->bpp == 24) {
+            qemu_log_mask(LOG_UNIMP, "Fill blt unsupported in 24 bits\n");
+            return false;
+        }
         switch (ctx->rop3) {
         case ROP3_PATCOPY:
             filler = make_filler(ctx->bpp, ctx->frgd_clr);
@@ -362,6 +366,11 @@ bool ati_host_data_flush(ATIVGAState *s)
 
     setup_2d_blt_ctx(s, &ctx);
 
+    if (ctx.bpp == 24) {
+        qemu_log_mask(LOG_UNIMP,
+                      "host_data_blt: unsupported in 24 bits mode\n");
+        return false;
+    }
     if (!ctx.left_to_right || !ctx.top_to_bottom) {
         qemu_log_mask(LOG_UNIMP,
                       "host_data_blt: unsupported blit direction %c%c\n",
-- 
2.53.0


