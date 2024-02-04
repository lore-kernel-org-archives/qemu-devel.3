Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2F1C48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkFg-0003rv-LJ; Sun, 04 Feb 2024 16:42:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFc-0003Mg-Jf
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:08 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFa-0003c8-TC
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:08 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d51ba18e1bso35016875ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082925; x=1707687725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l6wrsnSxRLOGGrrUU+5wUcOLIX0LsFSMqYGfjSPgVvg=;
 b=T7trv3q4VThoYjamj095ZkBsvmbVtTpuq9Cxv/TrAz8uOeBbN/E1bxixc+HvYfsArN
 AtctJrYFTYoy+ytlxqcr1416mvplLZoeYsAtCrxNH8/LavIhUeCroMZPp/lcNrS5uCBK
 mXLg74ExfL317bQj2OEflw9drz8byzpDW6AifjxiRFYES2Cyw7opsFuQLseQJXu5+5Kt
 COSSGbAtlM7bqkwCBlrsNcTQfPg94Ro6NyXiuEOtBxSXP1aB2d6pDKPTE1vtYVZ1lDLR
 jZqAHWY0L0Zkfiz+4p9GjRHth3CZ9xH4cZenjyW1xjsXTi4376woVPLMOJoptUpj8iUM
 GsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082925; x=1707687725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l6wrsnSxRLOGGrrUU+5wUcOLIX0LsFSMqYGfjSPgVvg=;
 b=wclF0gU2TPbzyBfL8A5dI87JItCrIh4zLECjv9gSzw5MXTIwnlSHpx/shqQDDSGpPa
 MDIp4gG1/Sr5fR0+TtxRmZTpIMWjvmgNTCxt1kO1rQ3XapWtPbO+ClLXlkMId05GiRsR
 ueFCnIzJDNZ5IUxsPPIOarA6PJs8adV8mZr+MXZGWfY3qozZf9D0KNgdkCQAJNtGLx3d
 la/z1xOIiJ4lraeg49lAwgEe1A35U8aQl3GkCTLQXS237B7eaW6lB1F2ObYNW8N9G9Yt
 KrWl4fQQsME3iLoo6Ied/HMYcTM86asCAvrB+n6Oy3lRf2NYTaasgr1RRdw06FeruWSu
 Mrpg==
X-Gm-Message-State: AOJu0YxSDgPUKcAk0KoRqIjli9dgDTlU1D3ASrFKRxqpU/PwlVd+ziAh
 HQGidCAx75440Cw/wMbY5tZd8HdbUqvJwzNbFsLzBInsvkUwEsnKyUw1C3leXSKiDa1aQnp2zhG
 LNow=
X-Google-Smtp-Source: AGHT+IGUYIL0Hlirhib6KHFh0fUiIvOIF1+H2nev0FWjoufRVvme5NjLIJOpjLx1JOMKLSXRrH+gvQ==
X-Received: by 2002:a17:902:b190:b0:1d8:da2c:1014 with SMTP id
 s16-20020a170902b19000b001d8da2c1014mr8687954plr.9.1707082925513; 
 Sun, 04 Feb 2024 13:42:05 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:42:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 33/39] tcg/ppc: Tidy up tcg_target_const_match
Date: Mon,  5 Feb 2024 07:40:46 +1000
Message-Id: <20240204214052.5639-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index b9323baa86..26e0bc31d7 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -282,31 +282,36 @@ static bool reloc_pc34(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 }
 
 /* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, int ct,
+static bool tcg_target_const_match(int64_t sval, int ct,
                                    TCGType type, TCGCond cond, int vece)
 {
+    uint64_t uval = sval;
+
     if (ct & TCG_CT_CONST) {
         return 1;
     }
 
-    /* The only 32-bit constraint we use aside from
-       TCG_CT_CONST is TCG_CT_CONST_S16.  */
     if (type == TCG_TYPE_I32) {
-        val = (int32_t)val;
+        uval = (uint32_t)sval;
+        sval = (int32_t)sval;
     }
 
-    if ((ct & TCG_CT_CONST_S16) && val == (int16_t)val) {
+    if ((ct & TCG_CT_CONST_S16) && sval == (int16_t)sval) {
         return 1;
-    } else if ((ct & TCG_CT_CONST_S32) && val == (int32_t)val) {
+    }
+    if ((ct & TCG_CT_CONST_S32) && sval == (int32_t)sval) {
         return 1;
-    } else if ((ct & TCG_CT_CONST_U32) && val == (uint32_t)val) {
+    }
+    if ((ct & TCG_CT_CONST_U32) && uval == (uint32_t)uval) {
         return 1;
-    } else if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
+    }
+    if ((ct & TCG_CT_CONST_ZERO) && sval == 0) {
         return 1;
-    } else if ((ct & TCG_CT_CONST_MONE) && val == -1) {
+    }
+    if ((ct & TCG_CT_CONST_MONE) && sval == -1) {
         return 1;
-    } else if ((ct & TCG_CT_CONST_WSZ)
-               && val == (type == TCG_TYPE_I32 ? 32 : 64)) {
+    }
+    if ((ct & TCG_CT_CONST_WSZ) && sval == (type == TCG_TYPE_I32 ? 32 : 64)) {
         return 1;
     }
     return 0;
-- 
2.34.1


