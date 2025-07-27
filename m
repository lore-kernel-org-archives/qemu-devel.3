Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC78C87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwR9-0007ug-30; Sun, 27 Jul 2025 04:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPh-0003Me-1p
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:21 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPf-0004qr-BB
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:20 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-235e1d710d8so45907395ad.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603638; x=1754208438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RB9M/NYV6NC+RrE1c3AzJNzEIqzbZfbB8TlpGuA3ub0=;
 b=vQPImJToE0n8d5rEcHPO8+C1TFG2JW1qGOUJnFlpMGiiqoc0ZadBEUALTpnLobC8SN
 7wXMKNkyiWKqiFuODrYC/rlnMwq9xeSt0ynqye5EBlkr5kdmxSvzGywB5XgDe/dwo7NR
 LR/j7O34hUzuYcQ1VgD19dO37EW5tFS555gOgFSs85qz8LYwFSf2kmH65EgOC181oIVB
 CSRUdU+v70onFEpAZBzZrFiQhU58IPZ0qLcSqn+SPhefdpEl8vLqjY/NWls6VLWx8zDf
 ws32DB3mu+hsXdf2CprVgPGxSM+tLS8rxNxddFoamkiEIi1hva50c1wideQLq3y9xvtl
 rDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603638; x=1754208438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RB9M/NYV6NC+RrE1c3AzJNzEIqzbZfbB8TlpGuA3ub0=;
 b=S9ud3XGGxe+6WCXwkogr5JwoL+8R0IP9YCQV7W0iObZ6izRVH96ebjHWRUGp078YD1
 8US0LP3Sjyar+hMsUupszsDawHrLJzrQNtqm+zIQfFlnwS3KOhhdVY2IZCcp381VAniW
 2bB1bAFjFqUibbf3BCoNBNLhJErFz+QhJJYUi4SNec5enCR4dZoh0umX+AIybiR1xp+y
 7LUwfuZZ4mNy4/bztCq03mTSub5gJTfE5FQZsXBXVw+TNo0GQ2kDnxdCgvHj6U4zyStw
 Bq0WFQIB2RhjlXyazZmcXqxOjVmtj6Ul1ZQ4PoOmARRPze+dHNLiERsxUhhB/y9vNO8Q
 VsAw==
X-Gm-Message-State: AOJu0YxAzjMCcIOU3m0BjqrG/AsLc1HcuBBTA9eZ/PQc1axRX/xdUGFf
 sQWRU4xWhU1i3xGxXHjgaMdf20yLnS0rjOCHMr1edNcZRQcS9UaH4GpYO9wYA19ViMxeA8kuTA3
 jxf64
X-Gm-Gg: ASbGncsINaz0Dc3dv+/+aDAOSUWc10v7SrJEm8PZAPor1hVrZj5oIMEe3cErkmP4qzx
 h+dzQLOo4dfDbjNulUsetkVewFKhzpB92lSUxw8SjbOJoP1IgwJIzN8XQZ8A+isvN/20Si6ftnr
 MKSXd20+NxPdFgLVoqyM216cUmAusMCR5EgDNZu5fVBzzMw5ts1InZlqjE8f48fPjXXPoe5bRtY
 IxbHB9gCntwZ6fXRWhMHbyj85KwUNaiIa3sNDbrjM0wGUYi0K07VHYaXbYm7L1Lff8iBebA7LFl
 nKJ/4lkrOAm3UggrejDionDtiSISFzQeP6yk0CLd+jG010RCS0cD2/t1vrAgzRgaQYApIJkn2aL
 7Pf+2Ct9kD0eYCWLKDzT7poADEWm7ID6Kkb0Ah9kl4Tm5Iio0lcvCX8YYz1jAZcZrnIGRGWX490
 SVe9L7vw46hw==
X-Google-Smtp-Source: AGHT+IH5ZWHbmImMIHnHrPTrcRkEHEAN0dapUsFJvYyxKo/AcbUmGg978OW/x/pgvhMlcn11rQahrQ==
X-Received: by 2002:a17:903:2b10:b0:234:f1ac:c036 with SMTP id
 d9443c01a7336-23fb31c4de1mr129390315ad.50.1753603638014; 
 Sun, 27 Jul 2025 01:07:18 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:07:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 67/82] target/arm: Load gcs record for RET with PAuth
Date: Sat, 26 Jul 2025 22:02:39 -1000
Message-ID: <20250727080254.83840-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 49e17548c1..23186850f8 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1890,7 +1890,12 @@ static bool trans_RETA(DisasContext *s, arg_reta *a)
     }
 
     dst = auth_branch_target(s, cpu_reg(s, 30), cpu_X[31], !a->m);
-    gen_a64_set_pc(s, dst);
+    if (s->gcs_en) {
+        GCSInstructionType it = a->m ? GCS_IT_RET_PauthB : GCS_IT_RET_PauthA;
+        gen_load_check_gcs_record(s, dst, it, 30);
+    } else {
+        gen_a64_set_pc(s, dst);
+    }
     s->base.is_jmp = DISAS_JUMP;
     return true;
 }
-- 
2.43.0


