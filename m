Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E707FF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLW5-0003M7-M0; Mon, 27 Apr 2026 08:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLVB-0002TS-TO
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:55:57 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLV9-0000GX-Ss
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:55:53 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-671d60ef9c6so13990343a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294550; x=1777899350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iKeG7yWNptnTHptfbzF+P6p/GjNxY6FOc39UsNXWGeQ=;
 b=eLSsXnH0GPffxS4WTzlXYQ8bntYdT7vUIXygP+gjrTDf07tYy5GGu3AuQnATtTt5UY
 aXsH0yuxd09bxc0L+OMwKYawJgS1pEEp4YI8yQ3RZPvrjXwAev3sOQ30R6rhfl7yjLY5
 PX6YA3YgRK5o7hv1t8YcUf/1RqBgdC7iJd09jUcUIDEmfSJLI3stHB8+koD/6BUiBJzo
 Xs+VSYf8K3+lmcyf7ISNFRKwM9KU+A1zmEsRzKqBrXIL+MP6gJu0gPLRGYUk26ivaNdq
 AnYiodlyW+ZB4BG8cRJUgX79G3M31oyUIY8z/mJuudGkYrLqAcrjYBm9h35IIQN9T8RQ
 T78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294550; x=1777899350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iKeG7yWNptnTHptfbzF+P6p/GjNxY6FOc39UsNXWGeQ=;
 b=o8CesFzcYtxJV36yaT+WAQwakrShoatiH02fDB0qtNBBBO48kYfO1+m8H8iT4a+LYY
 k31cshcNeLyC7GgB9dy9MK4c4daLvPmFWbGXP7e7WwYi7R4cjNCG3jejLIT021z4XPcw
 vEQ2LaIppoB809BjoyURYz0zl+w8aG3aiF3E9P95Q2KSU/9dTwxU+2nLmy1TBNJlByjf
 o0Z2l0oPTDN8PcepmHNRqRvJ+IEuIHes3LPFiU71V+IVUqE1IUzO8i24CMaTrw9xAVRM
 XG09KZ/Z7I+sXEJRcfCo22JoM2lv0P6tEXN6Yk3DjAGnQLPJbmikoiKOAqVIsnNHUmiV
 M6Jg==
X-Gm-Message-State: AOJu0YxsgYAKPiSWWJtl/ZFAkTzbUgyFjc4mna5AvVaye1loKhTezETw
 YpGtVjTYBdOgQ2MwPmzseXah5k5WUz/qXuigFnAd5W31iXJBY7MWS6faPlTedFLn9xkVmmZ6O00
 aaFJS
X-Gm-Gg: AeBDiethB+EylHpU5H4a9maQnQ8Gxps4+HopzJNXNwJpzgxELxvyzdjSVPyGyI8+2ei
 qTiypZZl8EsCQFStx3joCo1LJoLfvJ8gBXgHpqv4KpfeUGKl3OIp6Tt1d+sGI2lUhPh/XsZmL98
 BWvo1sF+5sI39c/5EMU0LSM5FAfahI0Bi/87xU0YkRgr5Px+mPsc+UcP4a3h1DZJcg6V1JDFfOl
 QDmmK5plW0SJSpsnQNo3wVrNjDn6OxHmkBiOhxJUn1oDeg3/j2Mmyabxz9OAS+GcRTxbQI2Wc+s
 0iUW3YfrzOairfNLSrVc/+d4haJx2bxqYsqCUl0B2BuFdXVWYdZFzri6l4mNdbvLXiVR/34RdQT
 bhxZc5Lqi9RT3WKTFkuCi67r8KagtSkl97D3IjbbBrrKWcoGWhCItowNrONvMNhsZACHmHdU7o3
 yWS5/YKgy1XVDdSGkX77Z+paazyYM8MwFBDsAihyrPb799c40dj3VA57fTLyqMso5PP5JlSmHf4
 dmHRUqQTfSgBjliQfmoUqxTIT1bkrq+1VW8Ne9uSA==
X-Received: by 2002:a05:600c:41d6:b0:487:2439:b7c8 with SMTP id
 5b1f17b1804b1-488fb745294mr370527985e9.1.1777294074280; 
 Mon, 27 Apr 2026 05:47:54 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.47.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:47:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/63] target/arm: Ignore endianness when setting MTE tags
Date: Mon, 27 Apr 2026 13:46:51 +0100
Message-ID: <20260427124738.966578-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

As mentioned by Richard in [*]:

  We don't actually need any specific endianness here, because
  every byte has the same value.  So we could simply drop MO_TE.
  That would produce a store in host-endianness, which will be
  fractionally more efficient on some hosts.

[*] https://lore.kernel.org/qemu-devel/d64d3576-9188-4e74-afdc-3492c9feb8e0@linaro.org/

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260414005348.4767-2-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index a7372aa6bb..dd1f9c6dc6 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -1019,7 +1019,7 @@ static uint64_t set_step_tags(CPUARMState *env, uint64_t toaddr,
          * the page dirty and will use the fast path.
          */
         uint64_t repldata = data * 0x0101010101010101ULL;
-        MemOpIdx oi16 = make_memop_idx(MO_TE | MO_128, memidx);
+        MemOpIdx oi16 = make_memop_idx(MO_128, memidx);
         cpu_st16_mmu(env, toaddr, int128_make128(repldata, repldata), oi16, ra);
         mte_mops_set_tags(env, toaddr, 16, *mtedesc);
         return 16;
-- 
2.43.0


