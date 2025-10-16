Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6635CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mzc-0006aN-Sf; Thu, 16 Oct 2025 08:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MyI-0004zD-D7
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:45 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9My4-0000ON-Ge
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so7693745e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617222; x=1761222022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NNfzgRKsIyRO5ljZBdVHsa2sinRCcg8Y2F9Jcp5B2+4=;
 b=Jugz7LhJAhePEdIenF54HNX+cqygygvg5DWH5TgmG486iX0pC2giE6rgGh9srJT4Pb
 wPXDYHtfKRd+t2fVtlHP97ESDCKIpRPrMwlipNWSHVOWP3MIGAF+ZzR2BIe5QYDmUUyF
 279c4obN59+Rm/jWEMVDjB0RFPBnWmCiiamrlKNnICzyNjjJ9F3SGZGcmtGqlNEfKPIj
 QAR8Ju45Wh1fJDme0ensYFgvYs4WL/+lrd2x+AOaRh/vJSgX3VeTx6zUa6lQhtwIzRop
 /IzSeDyh51r+MYyiD1xVctdcl57V8eS+aFAF7/gDrEK9pOlAjRDLFnR1OW9iHbhHHunY
 vE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617222; x=1761222022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NNfzgRKsIyRO5ljZBdVHsa2sinRCcg8Y2F9Jcp5B2+4=;
 b=JkC4sOuWEnl4mxovlEX5ZzCYjkPeoZtKm++AlHxJ0oseK59QzJKi0nA1x92QHe1SkK
 839YtvOeN1xpuD9HTmTjRYmigbIL5yFn6J1lITy5yC89w7yGRxKn2wXjCCh5ka/gTH/E
 +qrLMXD1rs7sOR5VE87KU0uYBe3d/eVA7/JWe8bjYU8NfqdfUa9A3mSSHIjJNOz/r8dX
 R2n8VgQPh8wqtg+YBXPtjBLuoPXs32dp5bmcmrRMDQ1jiXIGztWr6s+vKS/XoUVYb+uD
 h/eBMTJ8V5jBUPTxRsHOHawBCW8DHC//OPVaAc+EaG5uSRY+Zp70PikHwH6gHEg35Vqm
 CQxg==
X-Gm-Message-State: AOJu0YySxth/txjpH38nK4/7vmNDPifrt//3M+Q2028ZxEjjkCqpZLa6
 DNxxDJN+av2L7k3Jk64AGzQTnov8TxjTuBV/UiDUcZuqBVwx6ZVyEW9GVa1892LTUFnEYQwqQiL
 iS+O/FC4=
X-Gm-Gg: ASbGncvY/AtgoyAIdX6LerT5xLABBi6aGwK/dnYUuw7OZikk9kbz944HeDDKqWu/JlQ
 jtivyH2cr26u7vKy319myVVv1l/fg2PI1D2Leg1hwu14r/SvNp9fVgEcDHwnp/IWpb5zkw1nm6q
 MVn7hJFUDeYDzn349vtoFZF1mu/VhiJ5Smuqj8Qug+t/Bzb6ECFbryjsBxrQJHVCjbB+hYKOEPr
 Z0QuNaPUYC4BDmwFpjBRUxBG+pWnhas85JnxYmFk4vqY7wpnOABXlPszb8eKNn5usWTWpUxTskw
 lOQ3IiiZzgTY+If7hkAGWDRvHsikb+RMGRrx8tuDaZbFRJ9pLeT9DMGtoT62h74yH3fPD801pMc
 CjmbdUCsBuhNaogGGLbEaNrE3w/nsSa8o46DcLwLr3g1olUjOjRHUFx23k/dbZjEp4+/LWWk3L5
 syefkSHWJC7+iOCJggybwkacXYvxgkmtnkXzTIgMmrIVdTXOVdQ3sBO2f2W42vYTRz
X-Google-Smtp-Source: AGHT+IGO053AMWTCNvE8wluv70To6Zk5vM0fOkEdh3tL4MIZXKKox/uLx/Yz0LoHJkd4iIvzojCaDQ==
X-Received: by 2002:a05:600c:608b:b0:46d:b665:1d95 with SMTP id
 5b1f17b1804b1-46fa9b03b22mr282052965e9.32.1760617221772; 
 Thu, 16 Oct 2025 05:20:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426dac8691fsm25790546f8f.50.2025.10.16.05.20.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:20:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 62/75] target/tricore: Remove target_ulong use in gen_addi_d()
Date: Thu, 16 Oct 2025 14:15:18 +0200
Message-ID: <20251016121532.14042-63-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Callers pass either int32_t or int16_t.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010052141.42460-5-philmd@linaro.org>
---
 target/tricore/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 4b769b204ab..116f45135bb 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -1308,7 +1308,7 @@ gen_msubui64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     gen_msubu64_d(ret_low, ret_high, r1, r2_low, r2_high, temp);
 }
 
-static inline void gen_addi_d(TCGv ret, TCGv r1, target_ulong r2)
+static inline void gen_addi_d(TCGv ret, TCGv r1, int32_t r2)
 {
     TCGv temp = tcg_constant_i32(r2);
     gen_add_d(ret, r1, temp);
-- 
2.51.0


