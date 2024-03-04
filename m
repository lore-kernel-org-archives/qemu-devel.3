Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE65EC54E49
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 19:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhDkt-00038i-0N; Mon, 04 Mar 2024 14:13:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhDkr-00036h-Iq
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:13:41 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhDkq-0001ax-0B
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 14:13:41 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33e2268ed96so2781611f8f.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 11:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709579618; x=1710184418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pa44yMkxqpNsvSncvi7ekLjG5ubx8BtC53IgoytJ5A4=;
 b=s0FuxQtbhvpcHrrH7J0hi1jHaoo0D+IzAYFqHhI7UsncwwrGyySba9VtiyJzBbh6I9
 LR92LN5GfRd0ItAHXJq+ApNtmmZ/Yq3HqEmjK35tY16+1aN3vRX6zx0tBMbzFb1UJZJJ
 WhUileUo2pjr8HfBG3vAwxwhKDKFU1KpRkfPL0JtOj7/BlIsPNnlnOUZdiwz3K9+dgk4
 NOPU4js2ejLezU9b4IU0E2nmtMbBofHX8rHxKLU93iA9IVDG+wnPMPOhTLBIa8FtWPLR
 zx5Vnbz1+tOfsfqiNR7ylSPA4+zOkXU8v8i41aeXSVBp8ktC7jlNp23+p5oA71hps4W6
 qNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709579618; x=1710184418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pa44yMkxqpNsvSncvi7ekLjG5ubx8BtC53IgoytJ5A4=;
 b=KRdRa0GpdwKMVl/fO0FCwUBWxveyE2WO0wZW6St5lFJevYjxJY8Tw4NyzNGBV4QcwY
 LK2WRRKLHc5Jw1Pv5sMzosQtXRp3Cf8cc/mu1q90DITYSGkQUFCnMMTWQGS+3RMhsHgJ
 fUYJ7puWxLy7z+QWa4jmi8/5w/mUMoXnx9U2Q/dms9A6O8N8rvmOotWr33g+pBoimxCO
 b4BInQLOMqf9UHJkeC3+BaDzrvs7R0wJ4wSWy+h+rHikejIlJ9YtoR5/nJdGapwKakKY
 aupgYBEu24EBEmdpc2Kh3rC/X6+lPHOibsyv9GQeuTHg7W8Jmg+kO/3fhCr8ucWNfC1Q
 f9cQ==
X-Gm-Message-State: AOJu0YwDzb70/+zIp9bfhfpkuagM3n6WG6pBw/0rhGZr2WYfzUX585ww
 kcqHZ7rHQDEgN8zFcBPivsuAdaN72G3jORTzZylyBvMMh41obcHw0jITSTx5NOc=
X-Google-Smtp-Source: AGHT+IH5qLvyj5YPNh5svGC1WUH+wF54sm2uSzbfzbZ3d3/vOjONZDP+JD8yUni4QOrpnvO4DrAkaQ==
X-Received: by 2002:adf:9d83:0:b0:33d:eda5:bef7 with SMTP id
 p3-20020adf9d83000000b0033deda5bef7mr6977181wre.59.1709579618381; 
 Mon, 04 Mar 2024 11:13:38 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p3-20020a5d4583000000b0033b47ee01f1sm12866317wrq.49.2024.03.04.11.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 11:13:37 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5B6575F950;
 Mon,  4 Mar 2024 19:13:37 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 3/4] target/loongarch: honour no_raw_bytes when disassembling
Date: Mon,  4 Mar 2024 19:13:36 +0000
Message-Id: <20240304191337.3101411-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304191337.3101411-1-alex.bennee@linaro.org>
References: <20240304191337.3101411-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

This makes the output suitable when used for plugins.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/loongarch/disas.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 2040f3e44db..b9118878d97 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -120,10 +120,15 @@ static const char *get_csr_name(unsigned num)
            csr_names[num] : "Undefined CSR";
 }
 
-#define output(C, INSN, FMT, ...)                                   \
-{                                                                   \
-    (C)->info->fprintf_func((C)->info->stream, "%08x   %-9s\t" FMT, \
-                            (C)->insn, INSN, ##__VA_ARGS__);        \
+#define output(C, INSN, FMT, ...)                                      \
+ {                                                                     \
+    if ((C)->info->no_raw_bytes) {                                     \
+        (C)->info->fprintf_func((C)->info->stream, "%-9s\t" FMT,       \
+                            INSN, ##__VA_ARGS__);                      \
+    } else {                                                           \
+        (C)->info->fprintf_func((C)->info->stream, "%08x   %-9s\t" FMT,\
+                            (C)->insn, INSN, ##__VA_ARGS__);           \
+    }                                                                  \
 }
 
 #include "decode-insns.c.inc"
-- 
2.39.2


