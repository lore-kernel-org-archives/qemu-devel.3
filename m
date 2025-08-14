Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4ECCA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXed-0004Jv-Ps; Thu, 14 Aug 2025 09:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdS-0002y2-4i
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:50 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdM-0005IA-3a
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:49 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-76e2e5c0d4fso772614b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176681; x=1755781481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aMm818X66sT18U4EvSX+LzaHZWMAavgmuMF/v8hEmOU=;
 b=ZEVmrCDaTJXldo14UZk/3FSyzRU8J+Bj41yq39lNlMd/6/MQYB9Ql4/W3VX3rm6Z/Q
 tyt7gi9eY7BoxEaKvVgL0c/WJEIbGsWi3t5UxtDjqgroe3Z5d7JMujdrhCNbb1YD8EYD
 kr70zAV1sUHX66EmIGusfzEVUVSnj6wwKXI9EI29I5fnu3cDcIh1NwRdYMYicdlRp5dp
 E1rm63+R4AnzmYqBGGk7GDvwIPWM54sVVZEJQJaMvFeYqxtd4+wHmk7a2wdcFWbOuU+L
 1OnC+6HzkUEJqjAjbo3l9qDowUlBUNNuisxLOVgrYv1mlVcgCmlruWnBlOT8Y4YWeVDi
 2JDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176681; x=1755781481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aMm818X66sT18U4EvSX+LzaHZWMAavgmuMF/v8hEmOU=;
 b=nyTlKLMph26I0U99QqYeaPFIcHlTRN9KPGZiIXU20fXVV4mQXzWkYl1fym1QSNuBc/
 vpuy/9AAtfDG6xWatbyYeHfBsLPp8y44+CEx0q6S91NxvODKFgXGbRGWuCbjF4DcYVbU
 ypFjoNKAVmD2SKgniMu0NFzyApWma7ys5mKxiZbHvRW9YEJT/8kY3iTLyOcA4USXDLmf
 wH1Twn6kU+7p1Uk6J836+qJ7achs5MK3+CFmKTLbx4sixZsIEzF2MVyJHd/Zj58SVeuc
 CAspb8WbnhAQ0SCvw+hq/p58f3Wk9tk9m4DCypGsqdg6AHppeRwWr38FrELS5R+2fHGK
 /F4w==
X-Gm-Message-State: AOJu0YyHEB81AzoWFUw8c+vcSFL3LSPDGlEwj1axrelHxLtGZNMlD0q9
 BH4J2gRw9SIQ4Q8QvVGxXvPpcUSK0yB5S+l3jXYwBVb9X7u7AheLbphj46nYkYA4J3DqiIKfA7P
 4JZO7k2w=
X-Gm-Gg: ASbGncvTkHOa4G8CizXuvcilRUlRIlRMaCaY5B+A2VE9hkQ9UvhKWcq2XyDqMSEiGgX
 KVDlI/1+ars4cHdC+IVJZhuM1MPkb5dQHv+mkXc+QvtVN8x+CpeVQ6CrDC9vswwX8gAk0DGfs+3
 NAf49ho1v6SkAG8GPsgB4CFYffXSun/YEGhzbwd614Yl89keh5n0RL4blIhfHlatblMddDU0pCd
 pATXJNEGywDnjPBgjMy5wrBHEWVHxGyuiFYDaqZ/w6V1FVpP0swg/LuqRfpbz8HzTrXTada8KEU
 orQlLfnThyf14wsmP0sB69ik76MDVjZWAL4VDecxmPuSlsDIeBLGXQMstOV3vitwoIs1Vwl3hm1
 VmqsIGmY+l/lSeoCMOMt4wwhvBJgBcVb8Fgadgs3Mh2f5xN4=
X-Google-Smtp-Source: AGHT+IFZ3tHNG6bgTRTtGlcYTNOF3O4qVjY5JDk8UZ+lVQ3VfXMg/b0K0CAo/DP/8Nq1lxwfI99GpQ==
X-Received: by 2002:a05:6a00:1304:b0:76b:f260:8614 with SMTP id
 d2e1a72fcca58-76e2fbe8455mr5228441b3a.3.1755176680536; 
 Thu, 14 Aug 2025 06:04:40 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:04:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 66/85] target/arm: Add gcs record for BL
Date: Thu, 14 Aug 2025 22:57:33 +1000
Message-ID: <20250814125752.164107-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 70dec7d505..957ec232a8 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1678,7 +1678,14 @@ static bool trans_B(DisasContext *s, arg_i *a)
 
 static bool trans_BL(DisasContext *s, arg_i *a)
 {
-    gen_pc_plus_diff(s, cpu_reg(s, 30), curr_insn_len(s));
+    TCGv_i64 link = tcg_temp_new_i64();
+
+    gen_pc_plus_diff(s, link, 4);
+    if (s->gcs_en) {
+        gen_add_gcs_record(s, link);
+    }
+    tcg_gen_mov_i64(cpu_reg(s, 30), link);
+
     reset_btype(s);
     gen_goto_tb(s, 0, a->imm);
     return true;
-- 
2.43.0


