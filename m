Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BCACCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mwn-0002w1-RL; Thu, 16 Oct 2025 08:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mwl-0002o4-3Q
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:19:07 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mwe-0008UA-3U
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:19:06 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42701b29a7eso254893f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617134; x=1761221934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m544tGn0dYogJR4H8a2XceOr9j14Kw7cbkaAlw5Myz4=;
 b=fElK/645+Q77VxT4QYhSDBQdeZTe/ImIbcjcnxofIJZSjVGJSvQxZkcsNTJXGycbyU
 Y9J0AaMMrRCZpidRCHbJcyZyRuRENTDas3Da+3B7i11Dwu1yhbRydjAMgrWhevWzKcUX
 YvYSwS4rWntGCQyZ1JbSAwZ3TleOuDml6wYJ+Ol+3R9XyZvgAmm4YcoCn1TBKtCm2ITN
 sz9JP2odu81ct5hUQGncjreVExNRuLApbO60c7yHG1dHB6lyMpNHJY2epOi3vzhW8QWh
 7N7b+1lORhSvDpwa8HLm11Ub0m/gXiXyqNsXSgBV0AuUYHMhiPr2wNVtxQZtbM9bCsh9
 VnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617134; x=1761221934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m544tGn0dYogJR4H8a2XceOr9j14Kw7cbkaAlw5Myz4=;
 b=nq072QskaNNjCjLlEZxemriqkKDTAKQnZ1qK7IfHOxVRcjXmaidO6G7cAUhbI0jx7p
 34TKoJR3rutv1kUgtoLippf9KKNcDvL+9g2XHlFPYwJBCaPvHFHYOpAcFwDLKFS2yKx4
 NvR9Iu89am64mp476BQX7lRPlgVSko34gOTK9Z5aShpe0x7FdWg9KD7g08ErZmOVwQRh
 ILV6SONDdc/G0AuAi3truGuwyMMs4uymnLZdkDbqCZXAdZ/W5iSKD9+u9r8PUY7dQ360
 tbkly+2HxJuY/BtbZNU+ElsH4cSW107C6b9BOUB4B/Zrhn+mTYClJ6VHgyUz5Cwpq/20
 RZ7Q==
X-Gm-Message-State: AOJu0YyqjEuRNL4hDhRvELbUPNwnVDrB9pUvX3litVVt8aLpgtp1uisb
 qqxlT9v0fkC8EyXi2pKdZ3XbcDSDeNrV8/pwGmQ7/tCSGqdKukl4yx7txjH2GOfiTwzSwQkzkRz
 Fx49a1EI=
X-Gm-Gg: ASbGncte2Rzxa1rLFi8mmALW+M8Nm2Kf4G3tw5CIshuBv738PGDMWhrwyvowP8D0ChE
 kooHzx1VxKsZcnsR48ptABrSz7XL2w8EaEaJQ+EJC7NVNLlt1W0aWqUjsuUfChe470p9KkJcazN
 g6/i+ZeFr+ZI1J/P/qwvK4uvBvj5i1bTovTw0DuDPYDIPgdIz5EccaoSVVtIyk3IcNs3pkstBt4
 knAamgJ0qAD14DkzH2/Ax0qTMGE98XGHQOTSBrKXtQTaoxWA2Ly+h4S4JL0Oee456d295py4li7
 VTN2LOy6Jsgb10Dfq79TnfGjlyv1DZ6L1ljYzWoK1eEHc+XBN/7REOubqT/2oMHXsxODAEjlR1j
 QYGH45F1NDFwS1q0+w4w3hr76PViF1qeHDA1t8qNn7M2hhsMru1b5hKzGDWiN2wvzjg3lEuBmAQ
 nsNYbOokPYv0G7yGE8QN6u5gE3F7V2FVFtFxmik4tRC0nLSu3l+wPA8X+7Y91vlqRh5eD5l3l47
 oQ=
X-Google-Smtp-Source: AGHT+IHCzlftcfsllIOBdqbltmlPawJ2ugf2ZX437s6NkEFPIgBGXVTKB6OVbrw5B4KYDe7obEXIDg==
X-Received: by 2002:a05:6000:250d:b0:426:fb63:c01f with SMTP id
 ffacd0b85a97d-426fb7b5d7emr2647536f8f.29.1760617133829; 
 Thu, 16 Oct 2025 05:18:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cf71dsm32913069f8f.29.2025.10.16.05.18.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:18:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/75] target/rx: Use MemOp type in gen_ld[u]() and gen_st()
Date: Thu, 16 Oct 2025 14:14:59 +0200
Message-ID: <20251016121532.14042-44-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The @size argument is of MemOp type. All callers respect that.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251009151607.26278-3-philmd@linaro.org>
---
 target/rx/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index 1c911cd9a67..744edd56afc 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -161,19 +161,19 @@ static void gen_goto_tb(DisasContext *dc, unsigned tb_slot_idx, vaddr dest)
 }
 
 /* generic load wrapper */
-static inline void rx_gen_ld(unsigned int size, TCGv reg, TCGv mem)
+static inline void rx_gen_ld(MemOp size, TCGv reg, TCGv mem)
 {
     tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_SIGN | MO_TE);
 }
 
 /* unsigned load wrapper */
-static inline void rx_gen_ldu(unsigned int size, TCGv reg, TCGv mem)
+static inline void rx_gen_ldu(MemOp size, TCGv reg, TCGv mem)
 {
     tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_TE);
 }
 
 /* generic store wrapper */
-static inline void rx_gen_st(unsigned int size, TCGv reg, TCGv mem)
+static inline void rx_gen_st(MemOp size, TCGv reg, TCGv mem)
 {
     tcg_gen_qemu_st_i32(reg, mem, 0, size | MO_TE);
 }
-- 
2.51.0


