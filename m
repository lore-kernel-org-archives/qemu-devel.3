Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8117C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2PZ-0002Dx-DG; Wed, 19 Jun 2024 17:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PX-0002DT-O4
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:07 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PW-0000Yh-0N
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:07 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f480624d0dso1642815ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 14:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830804; x=1719435604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r0UfmwlzZKdf3qRpICgNO4rdEb11HLtqXJQ3Mp0c5Cw=;
 b=WEiMmB8rbFLyRZcZCrJUuel3DIeQVWir2hLWPiiqhFyQ7tBqHvL5b2XiP7KaeQbQ/v
 Q6WXLzraMRRBZ6US/wYR6ywMNl1nrjRBDdse7HMPdscO6PqfGYvHi+0XW5++XPk5maa7
 Yuk4T1elWBF4im/09Xdr0TqRhPJIfseb9XdRhPwKNX5iQa8GyVFn2YZwZ8PFahhMKX9m
 WK+HX6EEwzCDsh6QmNYSeT4eFKNamI5v0OsQGpRPG9u7IsYgjRUdlQOU9iTWDvyDHabp
 KcmfmnArWyGwW63uzzoJfOOPVj6Z9UqOed/d+VIb/TdersQuowouEjsjLxTxmdUhBkM1
 m9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830804; x=1719435604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r0UfmwlzZKdf3qRpICgNO4rdEb11HLtqXJQ3Mp0c5Cw=;
 b=O8gfWZ2I1OvlP7aNrmF4JMoNPI+6EjJBVHJ29N5L9X7m11GGJmqKzEDdHyS+kaD8GY
 Wre9Gs1MDj+lTt7J7SEOcRhMUitz55aBRVjs63tOyIJseJSR47rl5/DUvGr730BaWY+2
 LJ6QYdBPG65DOnuEB8KbvF21AY5OlhnSljMy22LEJp6QbnhH3XFawg5McpxmgdGoe61v
 vVN20pP2uFAVzv/FwjhyFdwboDVnuoIV8td/gwhcmZKbuAjGxQWlHRzNNm7+v7NO6/1D
 Zq9YZEIgniNM+/sy5piJ4fAI5RQM61ZA3rkfzgfKR+TjdDxRt8iDG/V11OXIG3A7cr55
 1hjw==
X-Gm-Message-State: AOJu0YwdXdxKRGcMldk1zxbfuKIfXGFcm0kLSlMAyki4Or0M43KXxBV0
 I2UFSnLt8+rFc1yL1NQp994KiqMUPcJHFn7GB6qM/Ya2RRZs+T3twIKCK9uAsdgDxImT/u83/FO
 O
X-Google-Smtp-Source: AGHT+IEZeHU6fwkwernpMpRdXGpQuOTAVejIYHkr6QekagWezbS9vfLc9vdBOGZqy7kmLG2SSdnnTg==
X-Received: by 2002:a17:902:e748:b0:1f9:9a59:871e with SMTP id
 d9443c01a7336-1f9aa45eb2dmr42889535ad.52.1718830804225; 
 Wed, 19 Jun 2024 14:00:04 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.14.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:00:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 10/24] tcg/loongarch64: Support LASX in tcg_out_dupi_vec
Date: Wed, 19 Jun 2024 13:59:38 -0700
Message-Id: <20240619205952.235946-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 9a8f67cf3e..c7d0c7839b 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1743,7 +1743,12 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
     int64_t value = sextract64(v64, 0, 8 << vece);
     if (-0x200 <= value && value <= 0x1FF) {
         uint32_t imm = (vece << 10) | ((uint32_t)v64 & 0x3FF);
-        tcg_out_opc_vldi(s, rd, imm);
+
+        if (type == TCG_TYPE_V256) {
+            tcg_out_opc_xvldi(s, rd, imm);
+        } else {
+            tcg_out_opc_vldi(s, rd, imm);
+        }
         return;
     }
 
-- 
2.34.1


