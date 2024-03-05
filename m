Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18930C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVF0-0002Hr-DS; Tue, 05 Mar 2024 08:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDx-0000x8-Qk
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:53:06 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDq-0005y6-HH
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:52:53 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33d90dfe73cso3056036f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646765; x=1710251565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fdVthnX6h3tPLZ/up3/0m51wR74fwYyRgEQm5STtv5M=;
 b=lsi9HgN5xeuAdoqgoLYZekjfyQPOfAz9142+IDLLrMfvpEackRNDvBneEI8UXCjyyf
 J8KeD9moVWgLS0Rov+oQgFKqvpBuevvzE3q37N3jpfl78YXvYH/WtbUfkA1Pg3vI4Wfn
 kX0piJ8J+CUp9UKOxGcP91KqJJq1kn18go1SuFIcIeAXTs1D33nQxDXmFRRbggu+CN/a
 tbzCAMOl+TkpKTN3w4/oejdieSMwkKLP1JmMhcnnwfxU5kUYzMo/FPvvLEoQP3VA4Dgx
 KKcZ1skRqlHQO6+gjObdrSkdOJfITv7Eazf1NzZI+jQrCIPliQ/kKDhjjAbOALyPfR0P
 rltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646765; x=1710251565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fdVthnX6h3tPLZ/up3/0m51wR74fwYyRgEQm5STtv5M=;
 b=hkL26FuDIgiYlWJQPDgNDS5Hq53Xb8dpl1fepptmnzF0Dqi1Es/5ej+ND0m+RHehAe
 dTRdnBDt8c/JK5s/5WlN8fPth4GxsNNglwrjtM6BnKTZoxpQleIuneubcHNBKSB+um0y
 hl+dJqF4LIBFrOPB1zagE3M2OFFfY1FXDGTQSUFe3Tx9VvRDxJWSvCuT6X/zsNqrKGrg
 4lNVUTrUY51Apc/oqEB4yfrkB20nKvOqDio75JqAXTwHonz9w4X7S1XJJSBPnupTiOaI
 4KlaYo/V8jak6nEXnIcUb2zK3O8LprnknWsYnhiCvs5dinvdfXVBpivCMGZzJ7l4g4wD
 4oEg==
X-Gm-Message-State: AOJu0YxysWMSYZKCBDpgVMWdPnz2jeoCvoMnm9uvOZihtNO6FPeomSgS
 eOZ1RAmopJtzmlFyzr5fE9T8o7ay8xfUJV2LExCZ4RPMG3inufxDZpsr1QOjOBdXPwrOxhX0tuK
 K
X-Google-Smtp-Source: AGHT+IF+TSwvseQswoO+IT09xQXNmdexvZAq3Ve8Q8uhYS9atC7/sfsEn87Z8xIEBtDuSDwqV5EfNA==
X-Received: by 2002:adf:b646:0:b0:33e:1f2b:8cc5 with SMTP id
 i6-20020adfb646000000b0033e1f2b8cc5mr3250857wre.0.1709646765138; 
 Tue, 05 Mar 2024 05:52:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a5d6503000000b0033e206a0a7asm11797532wru.26.2024.03.05.05.52.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:52:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/20] target/arm: Support 32-byte alignment in pow2_align
Date: Tue,  5 Mar 2024 13:52:30 +0000
Message-Id: <20240305135237.3111642-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305135237.3111642-1-peter.maydell@linaro.org>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Now that we have removed TARGET_PAGE_BITS_MIN-6 from
TLB_FLAGS_MASK, we can test for 32-byte alignment.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240301204110.656742-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index f947c62c6be..c8a24706750 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -900,13 +900,7 @@ static inline void store_reg_from_load(DisasContext *s, int reg, TCGv_i32 var)
 MemOp pow2_align(unsigned i)
 {
     static const MemOp mop_align[] = {
-        0, MO_ALIGN_2, MO_ALIGN_4, MO_ALIGN_8, MO_ALIGN_16,
-        /*
-         * FIXME: TARGET_PAGE_BITS_MIN affects TLB_FLAGS_MASK such
-         * that 256-bit alignment (MO_ALIGN_32) cannot be supported:
-         * see get_alignment_bits(). Enforce only 128-bit alignment for now.
-         */
-        MO_ALIGN_16
+        0, MO_ALIGN_2, MO_ALIGN_4, MO_ALIGN_8, MO_ALIGN_16, MO_ALIGN_32
     };
     g_assert(i < ARRAY_SIZE(mop_align));
     return mop_align[i];
-- 
2.34.1


