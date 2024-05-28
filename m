Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9986C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxUv-0001fL-Iy; Tue, 28 May 2024 10:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUt-0001dt-E5
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:15 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUh-00072s-4j
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:15 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-357f1c0b86fso644926f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905282; x=1717510082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MMlq9Auj6l45MaC9OkLzg6YYNbQpSqIPdMIwL/zQx0E=;
 b=IA6bRw0JA6ZrsWCaq7MPgvgmYEjgj5OAg8obfE9DzpzXm7HHkyOFBuo0YEL5b3r3/R
 y5wi7AEs53OeNGB2udEtdsN+w6i0w2lJqU2ZXY+s1v0ugYDeHxYpXsAx74LIozIpmnR4
 UuIAjIoOrxjhhguCdXWSz1GfzSWqC9T47i67bhAvxnxfc4bjrRWaDkr8BT9GUKaTrkJR
 WbnmDzN+AWPX++OXOQAnsSEJ0DV7Ryr624f627bCkW2UUngGtgbMbbRwgg7Q9tlL7PXw
 vHMPN1Kpsngyxmu1IqEM7SpRJjtaaTAs8pO9S+On8R8YtPIGtxfkRPXFqCpCbLMYJ08s
 wD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905282; x=1717510082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MMlq9Auj6l45MaC9OkLzg6YYNbQpSqIPdMIwL/zQx0E=;
 b=mQXEgZFwgdWHhmUTgQkFqcpOK05fdZcI/hUv0TxPoeAISE22HmyMcqkQ4cD825qdB5
 UF9QLVv2zbmKOlMzUj2K9yxxT9F1MHrK0IUP6tVYWQLAzFv8f9qwxJYK4hXCd1BnALzQ
 7suJG8GJe3NSArTEP9aT95TDv1gNGTc+poyG7GhITdfykc6zLlZIP+uZI515UKqIjTe9
 B3cHtXQZ5KjasdGvSkvsMIQZzgpEdQl3WyNm5B40QUg6xGYFL4ioVCAvK30Vb5zp6+zM
 +YZ9YhDwQTvQmYMGN9rV/y0s0t7WMlqAwUvu9D8XuL5q3OmTDYOdTobx25V+RFYNLdMD
 ts1w==
X-Gm-Message-State: AOJu0YyFsq7NSeTlhF9qngO8MbkK9UGkLYRUE3iOihru/DbBrBM0wyBK
 lw7/IYdJtVkmh07e8E/uhL+ViaQ98QMDete2oCfi+A+22e/tXOsDjIlxVvYzmpUT9eqNq3c8VMu
 7
X-Google-Smtp-Source: AGHT+IHofExPWsofs5fLgXkw4PjrIWmiVDEd6Oehi8UnH2/OUIRzXLYjQcaOF1hLJNQenuSSv33Ysg==
X-Received: by 2002:adf:f605:0:b0:351:d78e:875e with SMTP id
 ffacd0b85a97d-35526c271e2mr8205750f8f.14.1716905281814; 
 Tue, 28 May 2024 07:08:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564afc3577sm11361473f8f.102.2024.05.28.07.08.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:08:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/42] target/arm: Zero-extend writeback for fp16 FCVTZS
 (scalar, integer)
Date: Tue, 28 May 2024 15:07:21 +0100
Message-Id: <20240528140753.3620597-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528140753.3620597-1-peter.maydell@linaro.org>
References: <20240528140753.3620597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

Fixes RISU mismatch for "fcvtzs h31, h0, #14".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240524232121.284515-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 4126aaa27e6..d97acdbaf9a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8707,6 +8707,9 @@ static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
             read_vec_element_i32(s, tcg_op, rn, pass, size);
             fn(tcg_op, tcg_op, tcg_shift, tcg_fpstatus);
             if (is_scalar) {
+                if (size == MO_16 && !is_u) {
+                    tcg_gen_ext16u_i32(tcg_op, tcg_op);
+                }
                 write_fp_sreg(s, rd, tcg_op);
             } else {
                 write_vec_element_i32(s, tcg_op, rd, pass, size);
-- 
2.34.1


