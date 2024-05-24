Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93968C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeIZ-00016M-Fi; Fri, 24 May 2024 19:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeHt-0007OX-SD
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:28 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeHh-0006tZ-Af
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:24 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6f8eaa14512so1307128b3a.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716593110; x=1717197910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KkrM6eUfNQC4/ZxOfw3RoQ+l/U6+/yIajWSBPEUqefU=;
 b=emsgS+iFjgBL5HsXZJJwTe2WGH+23g0HnCDQCoIzaD7bsYBi0+IJlQVA6NvGAIyAN0
 xoN4llMYhwVILwTY0fuxSPTr6kTJJDF+J3KB2Hl9f1UjJ+DnNEPqseSvhfXksCOIL1oC
 jef15ld2Wq8ZgqkdbGZPGXVnSbkBQ/rhfmDNhJdExwQvzd043qmUFfQA7m/1lTCJayr8
 YOnrrZx/uO1/w2rUBeuieR9ETNDEP3fb7RuelbVSixhAvesLOYambWDRYnHhg4D4ovdK
 xGNEZ2m95G7T6pG/GvAHqr/qjT0HLau4Y6J4d7OFG2J+pYuiw1muuaCT3ve5Z/XOO5vm
 9mUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716593110; x=1717197910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KkrM6eUfNQC4/ZxOfw3RoQ+l/U6+/yIajWSBPEUqefU=;
 b=Xi39AZjzz1tM/UsIbzgfTx6XiE6z+5UjoUlheJCBBBlVJdG3oxp8Rl5ZMfqaa4qCgy
 zxO43wcy6Xx58yK5GZ3DNtlvJ8R74+xaiVgu6otEHPCbBIkJmBuzsn+PPJR/mwha8roO
 7YCvwDKWps+Mh4E4LswhkLu5ITH3yUKs+eHRwNRT4qccmTzfv+mDglAtpudU6PaJbrnI
 nOvWl0G68U34WYpUEEw9Ll0jdo2FE5WRZIzp2FxvxSaQUeVxPsKYc6wgp5LJ7gabJsKg
 2V/JKtw53mTHnIikBmoPEboIGfNv/se9ct8eJuEorr+HPFBjbRAilpxYVSXWg9bSgHle
 woBw==
X-Gm-Message-State: AOJu0YyZqRgfnc+LnrvhC4OFcIWgfLeiMCSQ+oz/xAO9Eq1xd7dM+kSp
 OYhNRxVRC8anj/Jh+Tf2y7/YVZh+8McLShSbi9uffLrF5RM8pJz0HqDBRXJB7/gBoIoskAUwLGe
 Q
X-Google-Smtp-Source: AGHT+IH7FurCjsBAAZDits9Raqncawm0dy4V/L+dqXoZ6Kp8bOSTE9aa17L9zcQH98f2nVEdVugyHA==
X-Received: by 2002:a05:6a00:4405:b0:6f3:f062:c09b with SMTP id
 d2e1a72fcca58-6f8f2c6c7b4mr4166051b3a.6.1716593109917; 
 Fri, 24 May 2024 16:25:09 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbf2cfd1sm1591695b3a.3.2024.05.24.16.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:25:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 53/67] target/arm: Use TCG_COND_TSTNE in gen_cmtst_vec
Date: Fri, 24 May 2024 16:21:07 -0700
Message-Id: <20240524232121.284515-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
 target/arm/tcg/gengvec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 1d6bc6021d..1895c3b19f 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -943,9 +943,7 @@ void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 
 static void gen_cmtst_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
 {
-    tcg_gen_and_vec(vece, d, a, b);
-    tcg_gen_dupi_vec(vece, a, 0);
-    tcg_gen_cmp_vec(TCG_COND_NE, vece, d, d, a);
+    tcg_gen_cmp_vec(TCG_COND_TSTNE, vece, d, a, b);
 }
 
 void gen_gvec_cmtst(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
-- 
2.34.1


