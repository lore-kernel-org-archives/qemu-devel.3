Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF50C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnml-0005gB-Mw; Sun, 16 Feb 2025 18:10:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmU-0005Z7-Mg
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:35 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmT-0005G3-5G
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:34 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-220bfdfb3f4so78619845ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747432; x=1740352232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZz3zwe1jbLewTGTEgCXYdDo/Xsfe7IRGb0MUaOjH/o=;
 b=sH/EXYO/zfjVLryIVb7UiDuSRpE4pcNuIAh4fDjzFlKyK5T3gfFS+AE7wv6ABhXb9f
 UeIHpq+vibiFh7pcjrj89caAG+gOQihq5arcYFSCKFKsXxX9Z8v8UIxt9IriBZ9Hr3I+
 UqkKtDDkmuMJLp/BiO/6T1i0FTN9LrAkx7mENxdAu24VViuZiu8WLJDDfaYnLh9kHrEy
 iLaiIRDqqZ8MgWD9vD9fm1n9yLF+NEv59Hx74CiNF0f+cwjy6APqv0fto5iobIyAELd4
 edRCxZv+vq6Mkga40Fj0plh/N1Nr2gzmUVShPTD7/m8akWFmzHM5dsyp6wqmpH3FCnhX
 kBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747432; x=1740352232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NZz3zwe1jbLewTGTEgCXYdDo/Xsfe7IRGb0MUaOjH/o=;
 b=fVeOPZxYkE7eHHuTw9Zzv/EP5HCjpb5h179VuuOFbbsa/zQNlz2MqpxlNhjb4/7dm/
 JKOnjfxcD9HfvNYhfF8f3LbQZ0C9ZEmRgbXuEjjTAn+/IC5lcfIfb+3//MFh2sS125WE
 aVDm8bUOHJD7Tiz+/4nBYkANRX0SO+4bFDZyM1498fc2hfbcFfaK24rH6NDXUyxCNLKJ
 GcxkrGpRmjnkBkR82/tVNot+2a0RcygdXiB/1+5V4oT5aCL60RztXlhrSRxny+RWZhh2
 d+Rom61n3GBn6CuHYpIUs9BoqUHuLlqIUgnV8MTvOpgMTHZISJ2OxZFcpPvn9eFEUiJj
 6KdA==
X-Gm-Message-State: AOJu0YzBNZ+MgbrUfItbVuuzewX8g4opGypcmcR+hw9bxjwJ7ZBu05D2
 DXlblCficza36F0xecMdzzyneFipmZOWS8YKwjEBzhAStm5QDdzb7D4dUevfovk7+FvuQQvFsov
 5
X-Gm-Gg: ASbGncsp91NPIQh63pQSCuScR6Jfitoccl3EDQiqK6+OZXu1NAO2Q/Y+jKZnnrWKLb9
 a7SmyfBJMJ46Lh58ixyWZ9VCjjduMMyK7MyT4uypgmCg+ajGGnOtznIzXgydN8ZesiOEWBtQFjK
 SaPQig9Y69oIMBav2AOj6UyoCBJElVchCNodNmpTLkXUNIzI9CSH7OOcqp9ZvvjzdG9WR0Kr4rb
 8KeJp4/6c8C8mVywy9vFKXKiVbnWXuYrlg/+lG26vKtyA80ANoyzphak49clJvyALzuv19xVufv
 iU8LKoAOrAPf1vfzl5jIsTC86wZH/yIiJVH9bOZxXgDY9/A=
X-Google-Smtp-Source: AGHT+IHjrIZNo6AkdjLPGvX6j9wKMil5wGDO7ucpSiEiu/lxa/0+l1WNlFUgQh9fJbMHwrDaKEINpw==
X-Received: by 2002:a17:902:c948:b0:220:bd01:6507 with SMTP id
 d9443c01a7336-221040612afmr104845765ad.25.1739747431850; 
 Sun, 16 Feb 2025 15:10:31 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 024/162] tcg/loongarch64: Do not accept constant argument
 to nor
Date: Sun, 16 Feb 2025 15:07:53 -0800
Message-ID: <20250216231012.2808572-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

The instruction set does not implement nor with immediate.
There is no reason to pretend that we do.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index e061ba1654..72e068255c 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1413,12 +1413,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
-        if (c2) {
-            tcg_out_opc_ori(s, a0, a1, a2);
-            tcg_out_opc_nor(s, a0, a0, TCG_REG_ZERO);
-        } else {
-            tcg_out_opc_nor(s, a0, a1, a2);
-        }
+        tcg_out_opc_nor(s, a0, a1, a2);
         break;
 
     case INDEX_op_extract_i32:
@@ -2308,8 +2303,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
-        /* LoongArch reg-imm bitops have their imms ZERO-extended */
-        return C_O1_I2(r, r, rU);
+        return C_O1_I2(r, r, r);
 
     case INDEX_op_clz_i32:
     case INDEX_op_clz_i64:
-- 
2.43.0


