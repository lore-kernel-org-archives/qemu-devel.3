Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D66CDE006
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 01:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcZGI-0004vb-Gp; Wed, 24 Jun 2026 21:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcZGE-0004r6-3V
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:52:10 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcZGC-0008UX-JX
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:52:09 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c85b73ffb52so677830a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 18:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782352327; x=1782957127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXQBevF1dOv7VxOG8cDP5suXTbi/pSPJLgFi4iYWbMQ=;
 b=fJOVOCjsH76X4Zqk4ztHARRZVKJEHQoYTo5GOc0P88wT8Sxft8AotQk7SaDhYw9iQP
 vgN9IXcLA3UiTH06UstVV8ZmwNXC+TigG1MEjsQAVaORWtkAFvaR8oWgok+0PTgEP717
 m4H7c9zu0k706qG6x/uxAbDs4gKQitZM0LXauO3C/7x/fRBn1kwefAKq7CM5UCiUEPvi
 /2p22xkTd+BEqf0HVRC5/sqIGOOIAcKvBZSSgsArcQBUQ1bjsuhTu/A+d9PKGQId3bhS
 y2BKpFwFQcqlhJO3F+RjDmpKHDEJ3NbKANxcwRRRiSlObDsV4dx/9u3wHcg5ZGbBlJda
 ouBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782352327; x=1782957127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CXQBevF1dOv7VxOG8cDP5suXTbi/pSPJLgFi4iYWbMQ=;
 b=fMkyY9doDGn3CjWCgxcrT6rSD+wrrAAO90E7GGUdc9ca4/NZ+H3KODmiWuLVEhLVYA
 Q02WioeWIkVuErfZROvqTkKqNU7hBlgrIbuAK6rep3v2usV0CJt1dZ4pcf9ws4sYDjCK
 BRmBYpyolIp1sR2UizANtdvoGlqSTg31VQy76381gC0A0EnHzD8s/4W10YP8GhEAIZ5r
 GknPIFj1TCHbxLxC79fTPAAewhKdJ5+s46e4ab9s4hl+OSnGoNNeXb0of7gp1/rF+VRk
 Uob6SuIhavpzMtiAEXHGtBiZkyAmstIEOtbhtaKn8krdI53tGR5q/urAj2fFWV64hVxQ
 lREQ==
X-Gm-Message-State: AOJu0YzNgjaphnMfSLKf78fXQvLqGgFP6tldJWWKtaxYEzIsun6iUfQW
 +cGWPayxvnERumJyrM8u91qj2NTsJCl7R9pMo3yS07rjhQgYEyxHTFzIunpBIUZ0veFY4YwataQ
 obuJm
X-Gm-Gg: AfdE7cnbXoR/AQMjMmkDAjSigPGUPm3nK6djzp+0XxcOgg1ozlPwy1t4mS0DApebRzc
 puRsznStdgPZ7bq01mknC65VzXO8zhsUEO2DBPVaKOqUA8k2N3vvmap9H5ebGGGBhMZdQ7FtCIl
 im2/rZHAE6Ikx2KnPpYkdfLq1pI5/Xjs7/ae7Sx+9LHqb9hGw+5bmQ+TCizJAuqSof5/l7S9wc+
 D58DBD7NKJ2ZDSo7DrQvub4nhHKrr7uBIYz/F8VinD3whrdsIfA8494CFlbb8rkmzIRKNlprLvr
 9If33fa/BNc33wBuFe5DqEe2bY7Vdgf5+41w+luhzGPiyBtpsCMQBheiKOJ73v42Ye3BU3F2D2a
 reel7xpP7w4+tbIFtcB05iEsiuDUlcQAB0FuyV6dlr6geUDb51Zq04eSPcwg4kf5Muo5qGlFfqd
 FM5dYUZGVlSBhnxtkJdbTlcOCHY7RdWh09WCu+Mo1ybsAtmPRKoA==
X-Received: by 2002:a17:902:eccd:b0:2c7:9ba7:a39f with SMTP id
 d9443c01a7336-2c7fc70a33cmr6083765ad.17.1782352326949; 
 Wed, 24 Jun 2026 18:52:06 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f5ac8908sm9060635ad.8.2026.06.24.18.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 18:52:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 08/10] target/arm: Rename FVDOT pattern
Date: Wed, 24 Jun 2026 18:51:56 -0700
Message-ID: <20260625015159.719300-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625015159.719300-1-richard.henderson@linaro.org>
References: <20260625015159.719300-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Rename to FVDOT_sh so that we can introduce an insn
of the same name from FEAT_SME_F8F16.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 2 +-
 target/arm/tcg/sme.decode      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 7eeac28480..267a6b0d9b 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1260,7 +1260,7 @@ static bool do_vdot(DisasContext *s, arg_azx_n *a, gen_helper_gvec_4_ptr *fn)
     return true;
 }
 
-TRANS_FEAT(FVDOT, aa64_sme, do_vdot, a, gen_helper_sme2_fvdot_idx_h)
+TRANS_FEAT(FVDOT_sh, aa64_sme, do_vdot, a, gen_helper_sme2_fvdot_idx_h)
 TRANS_FEAT(BFVDOT, aa64_sme, do_vdot, a, gen_helper_sme2_bfvdot_idx)
 
 static bool do_fvdot_sb(DisasContext *s, arg_azx_n *a, bool top)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 755d5f00d0..160cf130d4 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -662,7 +662,7 @@ FDOT_nx         11000001 0101 .... 1 .. 1 .. ...00 01 ...   @azx_4x1_i2_o3
 BFDOT_nx        11000001 0101 .... 0 .. 1 .. ....0 11 ...   @azx_2x1_i2_o3
 BFDOT_nx        11000001 0101 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_i2_o3
 
-FVDOT           11000001 0101 .... 0 .. 0 .. ....0 01 ...   @azx_2x1_i2_o3
+FVDOT_sh        11000001 0101 .... 0 .. 0 .. ....0 01 ...   @azx_2x1_i2_o3
 BFVDOT          11000001 0101 .... 0 .. 0 .. ....0 11 ...   @azx_2x1_i2_o3
 
 SDOT_nx_2h      11000001 0101 .... 0 .. 1 .. ....0 00 ...   @azx_2x1_i2_o3
-- 
2.43.0


