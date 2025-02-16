Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FC3C021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnuT-0004ap-EQ; Sun, 16 Feb 2025 18:18:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntK-0002rj-3H
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:38 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntH-000644-El
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:37 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-221050f3f00so23672265ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747854; x=1740352654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d+Cq5dbLnJd6hOWUgmUjB0Xm4SgGbIkaG92dvcfgQB8=;
 b=ePikz+Lh0LUJFce7k2YGjiUf6DxxmzlAj67jwfbzcFJfKwi0zTzkPZYK9SgWaACM2I
 in1RpvEGS4kr0J19pJlBcquX+MdatBZjKE5oTqeeZt17R5z77aQlIDLJplWno3UfYhfO
 xUsyyQYWKrH8BdOLzAVms8YKeANb4/Fg6TVIVs9zY2alKTA4yzNygqsDGmUM8pKA32nl
 wKikYcef5q0wbhHIrrILMuh6rElnyFTkFpwnCGiQhAw7Epmal84AMON8rVp2+8Yi7Gvg
 WtalMbZCazr38wdWYnnLAVRFSSNzqNrnCGCJPpvM6XN6Wwf9CGDXQT/sSapzZ+EkUCfq
 DPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747854; x=1740352654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+Cq5dbLnJd6hOWUgmUjB0Xm4SgGbIkaG92dvcfgQB8=;
 b=w5cOsk43/LIC96IK1Ta6A4AoUegyJmFsj+Z7wYYOeqLkdLx0HlDTKyRbPi0v07lPqB
 M5HhfX5RzYkDaZqMD33A1LII6MbD0eWHf1QlK2+YMKe+v7OEFXs2tzI01C/uWdtTXtq1
 /+nxjGbvjD3qr96lwlryfvS15IxXljXs2RslMbGrlZW+6qZCaCO6Jau4h4Evz9svD9bb
 fYGPmzxfad6P6qFT63TlsTRLU9vDOs/elEJFlfCsva+1VTQjwPJQ7zgvO+DvtakTf8IP
 zdryQUoKT9Aw7iCAERZvyJMMmgbeZSpFbUcwan+tU7nSZypzXTPRjIYjIOg2F0s1a8ew
 b3zA==
X-Gm-Message-State: AOJu0YzJhnnFi6Jhs70sF99bnTwg406InNLQBe8ePL0zH/kT+PYCvRC2
 vbMDCLt04Sb+yt24HizWxLk5ZCsHoRLLqLr3nkmoXhlyxK4mmVGDguYSNHrsjJFUxQ+hPQmSLjj
 1
X-Gm-Gg: ASbGncu+T7fszA96IfNyr4+I6nixZ0Ixr2oGMjKCVYuaq6wYZF962XT9W2mIACAAh3v
 hQ5EkJvs0Higkh+f8LLS9IxdeH+Xz3fjJ50BQVFuYHpASa+/TlxZa4M54IOKCoziwH8hRiYt9NN
 uKraheStDsoPZFmHVyaViS7i3tg1fmNb7ElTCUjfjTU+aUll5zuK6kMsY+7JGSPWAdJoc+AxYYb
 VYh/pr9LVSl25523IFcf+lcRgc397Fitm0iEL/YXQbZz7hGIceiuDwcGMz0oj4DmBg3fXKngZ91
 QQD3Bnj1VJB72iZYQ2FhDVV7rGkTAiVS/HPex7bkLvsx3Qk=
X-Google-Smtp-Source: AGHT+IGKYgB5FkFN32DcgVWkhwJ9XfA2E0RzZAMg0K3UBpyr+qQ/qnL7GcFar5b4EuS2kX/Jh9IbUw==
X-Received: by 2002:a17:902:dac5:b0:21f:140e:2929 with SMTP id
 d9443c01a7336-22103f16b04mr120807725ad.15.1739747853972; 
 Sun, 16 Feb 2025 15:17:33 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 106/162] tcg: Expand fallback sub2 with 32-bit operations
Date: Sun, 16 Feb 2025 15:09:15 -0800
Message-ID: <20250216231012.2808572-107-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

No need to expand to i64 to perform the subtract.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8b1356c526..127338b994 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1123,14 +1123,15 @@ void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
     if (TCG_TARGET_HAS_sub2_i32) {
         tcg_gen_op6_i32(INDEX_op_sub2_i32, rl, rh, al, ah, bl, bh);
     } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_concat_i32_i64(t0, al, ah);
-        tcg_gen_concat_i32_i64(t1, bl, bh);
-        tcg_gen_sub_i64(t0, t0, t1);
-        tcg_gen_extr_i64_i32(rl, rh, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
+        tcg_gen_sub_i32(t0, al, bl);
+        tcg_gen_setcond_i32(TCG_COND_LTU, t1, al, bl);
+        tcg_gen_sub_i32(rh, ah, bh);
+        tcg_gen_sub_i32(rh, rh, t1);
+        tcg_gen_mov_i32(rl, t0);
+        tcg_temp_free_i32(t0);
+        tcg_temp_free_i32(t1);
     }
 }
 
-- 
2.43.0


