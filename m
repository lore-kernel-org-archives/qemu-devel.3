Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216E7C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 21:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R19-0007cD-5k; Fri, 25 Apr 2025 17:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0y-0007V2-1K
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:20 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0v-0000Yt-TU
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:19 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so3015239b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618116; x=1746222916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEIV3z193fHWnIG5VVbHuVsP5oGvNM/X99VgDXcMh7I=;
 b=OVIef16rNSHON0nqablbMa97K0r0vq+d1Vs9QQHRKnDkGd/KqAz0q2gompEgpbeA1w
 9pFI+3gypRXMTsJ5R1lrbBAQI1bwlbioikQa96/ND6McnCrZIsiY543Cyi3sCw/0q5v3
 zihaVVjHMwgUYyfnAypdJt3h5l9EnCcTd3qSYwgp5OB/ouuijUw4WY6NrLErY/NCGReM
 BNec6Oh+5bpVVKrmBO+E5fQvzXBpA2HUa5PTaUapAbZIPWhJpgdCv6PS1TmB5lggCjS/
 NLI1FzZTKijbJ7aJiRQSZGwzhObvC7+EwJiBX62hTlwyAu6P9gfKUHmziC64TKcSttFA
 irrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618116; x=1746222916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tEIV3z193fHWnIG5VVbHuVsP5oGvNM/X99VgDXcMh7I=;
 b=Q0BjoB0BHQtjEyegWiP6b/Uo8Sp0zf0/70N6IvG8Rxhnnv2fO+r3YS25t2rIgb8g47
 WvEFmzUXvcf7K+uqMuREoiHYpdp28LEQ/WOeajGv2PO453EaEae7nT875iXERHkJThmo
 nLg17e7huJurf8Z3ZrEciw/ULN2wQKW+ik+/Oo90+hHAdOirQjKpLYPpaSI5J68XHeqb
 1uHRY/PmKumyqaEVFNLx4c07pyCgSAgUEqULnQoD3suM+cU4sGqw3wce/Z+k3XdcXyjU
 8SgC9jIN7ZzHng8KmJQIqs0lJXylWDmlMMuUQbCs84L1zJ0P2Gosgw9DrJDU51ubg886
 au6w==
X-Gm-Message-State: AOJu0YzhCaBqwUHo9hfKqjcOFuPzajSBBZlKTnbwl5f00q+bP7NMv3Zh
 wC9SQgUXxHkaIxfGFtga4WvanC4eo7hrDXVhddmHdQu0sGDk9hnbXwYD2wzwVoqu2bl9DCN+YL9
 T
X-Gm-Gg: ASbGnctvx+ueoJUpuuFg8UoUUqTTMmhd+p5JJqmLDrUdnjRyZ6E5JYA3TPjM3CTyhsi
 eDClDJ/W/4LOhlyeQBOaTJ5vymTM0CI8ywfXrNdOEgfHIG7/J65gVYhZiob5n4/RLG5E5H97kzU
 KIeufJb/GzEMHfmF/gFFEAoFOMiHhwDAyzyD5uAXaJSs0PAT19b1+jbeLyxhEpmaIvYo7828llE
 ixI2C8HHU6AmNhnkh7RusIUCbJ3IRcA4MWPd/nIQy3mCVfQnHaHbMfWRI5ffmmbiINyDLJtqdAR
 h3sw2UFEv+KNrrYd0l9yzk1LG/GTj35xN83kvpdRRDFyJUr+QBs5mosDLuJe/Ta/hTvCp7MMlB8
 =
X-Google-Smtp-Source: AGHT+IEzuK/Zb0g/UoMSOdatFzyTTUSzwZ6L1ws+07quzUXHEZqHl2G5JloerC98lNr99CsF9EstpA==
X-Received: by 2002:a05:6a00:1398:b0:732:5164:3cc with SMTP id
 d2e1a72fcca58-73fd896a1admr5997547b3a.19.1745618116628; 
 Fri, 25 Apr 2025 14:55:16 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:55:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 029/159] tcg/loongarch64: Do not accept constant argument to nor
Date: Fri, 25 Apr 2025 14:52:43 -0700
Message-ID: <20250425215454.886111-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
index 814596608a..e74c7d8a87 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1425,12 +1425,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 
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
@@ -2314,8 +2309,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_nor_i32:
     case INDEX_op_nor_i64:
-        /* LoongArch reg-imm bitops have their imms ZERO-extended */
-        return C_O1_I2(r, r, rU);
+        return C_O1_I2(r, r, r);
 
     case INDEX_op_clz_i32:
     case INDEX_op_clz_i64:
-- 
2.43.0


