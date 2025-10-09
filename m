Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70054CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 15:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6sNc-00013V-MJ; Thu, 09 Oct 2025 11:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6sNa-00013M-Gh
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:16:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6sNS-00012p-Vu
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:16:30 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e29d65728so6717915e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 08:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760022979; x=1760627779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CR4uK/LFS4qCC5cLf+9cRuqkH8EtKE5g9jNBAjT6o58=;
 b=LivwlLH5kPXPEh46MatD6RWWwNFk2kpiw/yQYL9bBwyW6VcWpNUrEWZvTTcpsR0ats
 px5Qj7D6hd1rL0Xy70S899ZcDn0gmoEn6TsqXTFaVi0snhSMGiMjw5q8upOclHnq7NKn
 MvH5mcwukGu9MmX4h4oCG3cLdSOJWkWFV2mrqN3Kq9dkLKoP2TBhnNJDsSRdT69Lu9L4
 PUzehYntxt70o73S9S2qS18rHTFIWlXy8zC1qG4tqYk/lk+PLSOzA2rLAGD7MSMHsN5V
 yGEgMIeSYrQgvYxJvQfDDNwNmIfkzd+e4YREY1gBD2S0FaqwPiaE+0rLCMFwTsxWeZr1
 gwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760022979; x=1760627779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CR4uK/LFS4qCC5cLf+9cRuqkH8EtKE5g9jNBAjT6o58=;
 b=LhxISQXC1IJeNYikDou2rLH9PNw1GIRrXadcl7RGoO+Bg9KKVjpwh/j6mssKWZm5CG
 nEzkWMMtcru2qUNfu7ywcbt+/1Z/IvEbdL0in4kdTG0RCxYaTca58HWezZHFSWPpbGVX
 uk7BGj4hscyp9yqs1RGC849VQ0Eu0kpYc1tkGb/A5O+/j4/DMNNOhPDgBtso7qGeUPDD
 nGEGHoWcELe7hQkOiTFX9rtbhYPxAGZhNM0JchoWAuX7zVArRaSNGD+dPPYOxr16BdQr
 QqdOZk7uKM6okyx3J8Pp+6JqSu6ICPhpbpBkrjahsVgRtlWonk11zM7ttqnSUGIVenN+
 ZT2Q==
X-Gm-Message-State: AOJu0YwrWw39GQDEcBlzJAR+XgaZhPxOUwRHEe/V/iVUfwhEi4yS1KCf
 6hR76cqSYSJKFs63NDQK6sbh8arOJbfZAZ4HOy6tRSMUuhkL6s9zyreAK2obpdkujkWi61dEC0X
 5U8ZLck2f0A==
X-Gm-Gg: ASbGncufPdy29abgrJ+SXHShzUgFJQLiLsgK9Jfi7OAcpkN9RgjfC68P2aeOXP70wDt
 Mcdg1RTekQt7Hv0EOsEj2kLIebkpPK47WVoZ0puxnwLwWfiJA1msJKhBRpfM173sBLsRTWqmhdD
 dGo2KtevJ9ouGacrTNboEKTgmH5kgmPQ6cOQNGc2qUfEhyzHfzMsx0mPEdhHpx2PwQhPTy3dJOu
 vn5yytFYS7VCxSrfQBJFB62RG2WXL0T4vMn2smoPHuObS/NWglToxgbr+oOP1wXKRb356caAd+y
 pRJfTRmoV2Gh6lh+KbslI4hEEPlmaP0vVL0xii9EW8CesK8/9gfBvW9wF6FsuUxxmSq1RJfzxZJ
 khXGNgb5EIgZGmRnezxdrtlxBlIlT2gjClaIX3Cc31ExWvueZ78rC0N6jsCGOaDjOrRz5tN+/MG
 PQTydLGMV+kKz+rGLmIj2VKZbaRwLxmk4VUKw=
X-Google-Smtp-Source: AGHT+IG7vCQuIhyQaDky0M5H9X6sc33VleD42xqIhRPqibZH8CEXtswVfF5ZCMMT5lEHsAw7BVgWZg==
X-Received: by 2002:a05:600c:820a:b0:46e:4704:b01e with SMTP id
 5b1f17b1804b1-46fa9a8631fmr54661485e9.8.1760022979316; 
 Thu, 09 Oct 2025 08:16:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb48a6069sm1493255e9.20.2025.10.09.08.16.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 08:16:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/8] target/rx: Use MemOp type in gen_ld[u]() and gen_st()
Date: Thu,  9 Oct 2025 17:16:01 +0200
Message-ID: <20251009151607.26278-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009151607.26278-1-philmd@linaro.org>
References: <20251009151607.26278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The @size argument is of MemOp type. All callers respect that.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/rx/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index c22ca78a055..9a2be2107bd 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -161,19 +161,19 @@ static void gen_goto_tb(DisasContext *dc, int n, vaddr dest)
 }
 
 /* generic load wrapper */
-static inline void rx_gen_ld(unsigned int size, TCGv reg, TCGv mem)
+static inline void rx_gen_ld(MemOp size, TCGv reg, TCGv mem)
 {
     tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_SIGN | MO_TE);
 }
 
 /* unsigned load wrapper */
-static inline void rx_gen_ldu(unsigned int size, TCGv reg, TCGv mem)
+static inline void rx_gen_ldu(MemOp size, TCGv reg, TCGv mem)
 {
     tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_TE);
 }
 
 /* generic store wrapper */
-static inline void rx_gen_st(unsigned int size, TCGv reg, TCGv mem)
+static inline void rx_gen_st(MemOp size, TCGv reg, TCGv mem)
 {
     tcg_gen_qemu_st_i32(reg, mem, 0, size | MO_TE);
 }
-- 
2.51.0


