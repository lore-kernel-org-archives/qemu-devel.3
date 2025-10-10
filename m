Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783C3CCD18E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 05:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v75a3-0006eQ-1z; Fri, 10 Oct 2025 01:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v75a0-0006dy-8i
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:22:12 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v75Zo-0000SQ-QZ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:22:10 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-46e61ebddd6so16954295e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 22:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760073718; x=1760678518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hx65EYSapZh9hv+d82y4aKbXXFb9O6M9BnGMwB4aenM=;
 b=eR2gvAwf1VZFZNxHTrN2JEM1POpQZoRpdQIJrCInnCck//nc0nc21bT7sAu7M+xoQD
 D8tZmJAivIcQSCLEPZTznF49RRKg8rYBX88Se+G00jgmVWcuWDw1W/HOchyPj0IIfxxU
 C0KWcuOa86h3B7OrUxGGtRM2JOjaeIEcnE2nFaTaWs2T88vG77bF1lnm0N4Km1q883x7
 Y79gNRlaqQMBiTY8dcgKCWThHVE2KBEG1P4HuFiyDbkjyAT1bPQB0Qz/zE2UQDvHvYoO
 BTbLPkPJpVDokH6GrWmYNvnLucNMmqNLjBbmXkJdCgwoUSv6usk4K32dZMhHFiwm2c/h
 CFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760073718; x=1760678518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hx65EYSapZh9hv+d82y4aKbXXFb9O6M9BnGMwB4aenM=;
 b=P2qLsFnAIQo93gKe4gCi8dbGB4GHVTLk6T7um16Pr80nfZX4skwk2cO/R3wxa6UBGT
 1lwBoEJUj/+I1RtMnzbZFxsLOYkW0+fQPd2GS7z3JcyomfxwHYmN2i3eU3g0JLoB6peC
 yTKkkGtuwvVDsS2/+Ji8HsKxgmocUhfQmGZbL6gTB8oWeI03rIidMOfajz/MGh7tKXxU
 OhWHHd85YUGoHDZz+1P8YY/MMS1Lf3SepudhNoweA3TC9e+1sTXs9HX5eUDkdfAe2tNW
 3lGfnN2lAmXsQQ1uwMKVKn/mzc4fgFHasblTWOHzI+sMaZkoTta11Kw7S+pgKY6U0Heg
 dWQg==
X-Gm-Message-State: AOJu0YwCb0ImiVCQfVBKJzkyOdoS2kDEDC0iJL9TkG+UOLQvg7IySWzT
 dZF6HWt3618jjaA0F8WHaY/DMFsFCmdhZNWB6Tt+zHhPG5tynR32CzS0omA12qzBOlAaXqUuGm8
 /A3+BtkSC8LBH
X-Gm-Gg: ASbGncu2zIZGl7ROJv7K/EOIQ0hPSFYy3uTZX3d/RgnbUqMcYdgiMorYpl5TrcjRuwk
 u/EbbRcd7swiNSMIBxNbY64MGct/ay2t4W6valb93aun2LiT/vHmoemYX+7C5mpQa/6e3+xwVwt
 6aFCVfCrv5+EaB2nNFLmgkt/bJ36JeX4rsinpJtcZmUUEvC/mtCfFGv/SaFyZIGItVVppz1SYi4
 KaGf/yYeb67wuErkqdm3Bhhkv66DePnE9TdlYDqIfHIrZTCTjXSUDX6q5qQk+1akBI1AvuRNE3i
 eilFSoDCiuVbrMzgfBVTUuQlHdrK+M9qB6ijOl3g8S/RoQJJMVJ5ethgtgCVdXmYAvpt+y+UOGC
 csvU43ojP9GEH2vymnvi7iF8aCnscqIbcwsrs3vEA6xsJlar7QgpebPQNXFgr6j0uaShfr8Toha
 slK2/tsrda/P6xVKK2OUf2RHx37YS1jcB5tdk=
X-Google-Smtp-Source: AGHT+IEw+BeW6ym6b+rqkpxlq9bgVgp7sDl4dPKEiLEgYj9LIpR/AhhggZfT1Thq5baYXKEV9gxNMQ==
X-Received: by 2002:a05:600c:4fd1:b0:46e:4abd:6515 with SMTP id
 5b1f17b1804b1-46fa9af8ebcmr74941315e9.21.1760073718047; 
 Thu, 09 Oct 2025 22:21:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb482b9absm31380795e9.2.2025.10.09.22.21.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 22:21:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/12] target/tricore: Remove target_ulong use in
 translate_insn() handler
Date: Fri, 10 Oct 2025 07:21:31 +0200
Message-ID: <20251010052141.42460-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010052141.42460-1-philmd@linaro.org>
References: <20251010052141.42460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Since commit 85c19af63e7 ("include/exec: Use vaddr in DisasContextBase
for virtual addresses") the DisasContextBase::pc_first field is a
vaddr type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/tricore/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index dd09f0651f5..4b769b204ab 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8414,7 +8414,7 @@ static void tricore_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     ctx->base.pc_next = ctx->pc_succ_insn;
 
     if (ctx->base.is_jmp == DISAS_NEXT) {
-        target_ulong page_start;
+        vaddr page_start;
 
         page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
         if (ctx->base.pc_next - page_start >= TARGET_PAGE_SIZE
-- 
2.51.0


