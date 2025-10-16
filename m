Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26227CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MwC-0001vC-3C; Thu, 16 Oct 2025 08:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mw9-0001ne-RO
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:30 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mw1-0008Qy-PR
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:28 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42421b1514fso392596f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617097; x=1761221897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Yo/E3uEAHXqN340EGGedJ1kT+6rcG10oKgsR/3sLzts=;
 b=q8Ph8eEBZoTRak7ICPwKOytXGEGWrhoKlYraA2r+LYu9GnlzjZr8rChoTOQrHCXjLs
 PggNUQJqrAXrKSG9CnuAHveakvX2oVll8X5s+Wv+KhF4XC6m7nK3N4feuH5RufObCD4b
 sGXuU9lXRpmKX7bMJ5pJwyHjAQFVniYnBaYnBtXiy1E9jZDZ3DiTcvHK3ql7dS7dfJgw
 TQkGe2oQvXOYIitdB8xlEnurR64Yo93NH0YBPuXPzm8AwEiyqemA23m6A76MUiuvE/hh
 depveVp6R88x3i++1+O+ZUV59rqVX8qkzPPlGk2IKH7L09G8THBEXltl5+kavxoL5Exf
 h8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617097; x=1761221897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yo/E3uEAHXqN340EGGedJ1kT+6rcG10oKgsR/3sLzts=;
 b=epacURHzmM/iaraYP4tSLZN9A44N1roeINhZY2AapPEcToZKQSlwsVjKFIt23H8mHU
 s+uYtlzBVQxI6EmrCdgyM48nK7bzejxF+VHgcocVpV9zpFP67HytSAcq6APzafd7RWc1
 e9jdVGD1/rt2q/6A48O36mUC5aYeX1daOroKRfOKNPU8LD8WjiWzsUCeMIg8XR1OwGd9
 9b3XGemYQRTFLa8Gv8GLC4J4Q4zRk6Mg0xT4oQpLWmn+LaWphWExI588ULzeo+w24YDR
 09JWjljJBxbsjC0d1vzagmwDa1fb9xxkjK+zzE83mtZ/Y3GxQtDet2WCIMm1OLJkobXi
 RFxw==
X-Gm-Message-State: AOJu0YwCksPkUdvbMQ1YPa1YYY2qY+ktupNLchu7/mun3yGNadG+iAWY
 iY4lhFRPjXh+c6EaZ3yh4cJebkih49hrUghtC1ouOO/sdzgPrPW847xy2tWcfJhmwZI8qBnxhLq
 AzyCfk0c=
X-Gm-Gg: ASbGnctjxR1cBHt/pa2y5kP09HFJbdRhoc5SCJmyDwZjcfNRIk16UgQYYek0QhSW+0E
 rdIPLvmUUmJG0bNIsfIFx6u0q2h60kw8d5ylD+IfcJx9d5TrFAyXZK4BRmr8S9QGCEzBRtWtVeD
 vNq7VHTwNFjkqxLp7Rr7YwHJvj4R3Kt3PzssT8njLgt7q+BqTpd9UkFYhJQsEFLYewUri+GBHRo
 Q9iZylZ7tNXiRz9H3ksIP/rPKldp/jdehIT8ft9bCQ6wqnefE779UdB0AwUBYtaz7awQOYBjuGS
 YctVBHeuQUkcj7dCtSCX2XetxOltmvUb7RBzRnLqYVAziDUxax4QKFjHt/Xn6yVwa4BkNGtDyw9
 QnEURIA4EOQJmKCnhlMvonc6RxS1pkRvMsVAtJJ2EvF034Hfkas25SAmqjfg34uLqEfFXJmljfh
 VumQzfP7EvFYV7QMgnDsV9Ir4RmKqLl5M6d0y+qVpQQjo+DPrzAyee+Phkt+65ZjNl
X-Google-Smtp-Source: AGHT+IF+BKXQOauF+5YF5gX1B+ibW48wTHusZpA99a+fVoWkYgopEXrtUO9+aDZ58aho7L63jAhUbg==
X-Received: by 2002:a05:6000:2506:b0:3e9:978e:48fd with SMTP id
 ffacd0b85a97d-42666ab88fbmr20235825f8f.23.1760617097176; 
 Thu, 16 Oct 2025 05:18:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471143663afsm24878745e9.0.2025.10.16.05.18.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:18:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/75] target/openrisc: Conceal MO_TE within do_store()
Date: Thu, 16 Oct 2025 14:14:51 +0200
Message-ID: <20251016121532.14042-36-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010070702.51484-10-philmd@linaro.org>
---
 target/openrisc/translate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index a6ba1747eca..623513bb15c 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -706,13 +706,16 @@ static bool trans_l_swa(DisasContext *dc, arg_store *a)
 static void do_store(DisasContext *dc, arg_store *a, MemOp mop)
 {
     TCGv t0 = tcg_temp_new();
+
+    mop |= MO_TE;
+
     tcg_gen_addi_tl(t0, cpu_R(dc, a->a), a->i);
     tcg_gen_qemu_st_tl(cpu_R(dc, a->b), t0, dc->mem_idx, mop);
 }
 
 static bool trans_l_sw(DisasContext *dc, arg_store *a)
 {
-    do_store(dc, a, MO_TE | MO_UL);
+    do_store(dc, a, MO_UL);
     return true;
 }
 
@@ -724,7 +727,7 @@ static bool trans_l_sb(DisasContext *dc, arg_store *a)
 
 static bool trans_l_sh(DisasContext *dc, arg_store *a)
 {
-    do_store(dc, a, MO_TE | MO_UW);
+    do_store(dc, a, MO_UW);
     return true;
 }
 
-- 
2.51.0


