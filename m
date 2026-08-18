Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56F2C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCm-0007a9-VJ; Tue, 18 Aug 2026 13:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCl-0007VP-IM
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:27 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCj-0004of-Q0
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:27 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c9e7391839cso26918a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072544; x=1787677344; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1YQMkivKycB5cfvCchdQ+C8CnaC0uiNW1Azb4VvHQxA=;
 b=YyvhROTtjgkvOpCjAbXxEmwigpdse6PqkNEjX4BIs9bWei6vyhsIPUmE4NwVNbdBGq
 VfjrY1v1ton6KQW8SdGNMcs3uQnXMCJLrjLRnED1R0eQDO9LIko3Ojbke8RkVU0AJiSr
 PWMEl+Yy52wqK70viCLUifWENMyN7nJqfI5yW5TrT7pPXbJetp3QDJxrSWfQyQPmob40
 qC0ZkZNDKAKCRUgOpndSIyKbkeo6HbrfXpARfQOUe0jL/UsswQUnQ3BQTBHT6lPHITGE
 CTMntFXiPiVS+X9gNNrVfAYmc8am+K6/Z5SaVHeKh4Maeya3kiP30Yl0Hy46k012XY8O
 qc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072544; x=1787677344;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1YQMkivKycB5cfvCchdQ+C8CnaC0uiNW1Azb4VvHQxA=;
 b=g9s4JD4i8brraV5KqAGLvcNAKNpFtg2i/SEOF8plD+BIpxvd8hUyAAWJbRCMXICrNH
 IxehWz8A7YYkz9R+9etwiW+NcV6GNSscJ/mLsKAOdFlLOh0mzlVoAIi+hALXKLYikLDO
 bpTmTOiD6IPbmkd51H53SBncG0+MwvxGnaBpXj9SeRdxyWw/ew8L4vMmOGBTpez2fiFH
 ieK3556jJXXNUrNNy2/hk98KZZAHiTLg2lqXho1sw1HG2hUUJalOVmR65QP1ZL1g8jS8
 qY5PlO5ZWMK0hoXh/WV3crkZ6OqLl17baxZKCu2YvIBTrI1xBlZtz+1RKbquf+rnePkr
 08DA==
X-Gm-Message-State: AOJu0YxDnGqYhbbXEEfk1NQC0uAyjpOGdymQyNJPg/5T6NpLOVYqQGd/
 hYzspuGZifRoHeAVL9eZKxbcpfph4sqnljs2EC5gVIdZJf8TOBpqv8GhgUpgJWP0TFAjtgtheyt
 8/aAcCM0=
X-Gm-Gg: AR+sD12kammY8LHVIvKQ15RhacITO1NmEqyhhwsDWDmurSgT1bHIHoSpe329CMGN4Y9
 RAGvVAHEnLuBe7mg3xRvMU0NMtNcARA3mL/N9jPXfogtGXbsYGRU1rZBx+mbQyohMUTvJmpzI0H
 NfYUQCgKdOAneN+xISwGM6xtKyqtqru+B1wFnM7nTq4RO8+gsgAOBolZ6TJF62r5mTkyqyAEx2r
 cAucieMXVJdKIHxqyNNoAYZBYES0+oyk9MEYBba8Br26Velolou72Ge75qP2xBdQaDsXThQj6fh
 gXJyoiybVgdZPTFpL/4vg+sFMfsNwQlLhXvTyVh+Xby6HqSCcP9PHr8Ee5+SAK/ClglIKtjJJRe
 PaFAiMyEFoGINO4oMs0TD5fgKOM4zntAidQg2pjkBBi48EB+DmI3JJ77NjrLrm3ADzXej2HqhZZ
 5YHmCRrkWlkw85VlV1aJKGRy9q4DTTlVzwFiO4LDcb4WHAAe+WnvEM75SPob73hTjZutGsUva53
 08Gr4TUq2cVtKlhWko5fS05ZdMJwO7r3iun/neW/J4wfXs=
X-Received: by 2002:a05:6a00:2e99:b0:84e:7ec:aa42 with SMTP id
 d2e1a72fcca58-84fddfce17amr36449556b3a.10.1787072544374; 
 Tue, 18 Aug 2026 10:02:24 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 22/38] tests/tcg/loongarch64: Add bitrev smoke tests
Date: Tue, 18 Aug 2026 10:01:39 -0700
Message-ID: <20260818170155.1907006-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/loongarch64/test_bit.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/tcg/loongarch64/test_bit.c b/tests/tcg/loongarch64/test_bit.c
index 69b2eaac78..65cd6598c9 100644
--- a/tests/tcg/loongarch64/test_bit.c
+++ b/tests/tcg/loongarch64/test_bit.c
@@ -19,6 +19,10 @@ TEST(cto_w, "cto.w")
 TEST(cto_d, "cto.d")
 TEST(ctz_w, "ctz.w")
 TEST(ctz_d, "ctz.d")
+TEST(bitrev_4b, "bitrev.4b")
+TEST(bitrev_8b, "bitrev.8b")
+TEST(bitrev_w, "bitrev.w")
+TEST(bitrev_d, "bitrev.d")
 
 struct vector {
     uint64_t (*func)(uint64_t);
@@ -35,6 +39,10 @@ static struct vector vectors[] = {
     {test_cto_d, 0xabd28a64000000, 0},
     {test_ctz_w, 0xfaffff42392476ab, 0},
     {test_ctz_d, 0xabd28a64000000, 26},
+    {test_bitrev_4b, 0xdeadbeef11223344, 0xffffffff8844cc22},
+    {test_bitrev_8b, 0x1122334455667788, 0x8844cc22aa66ee11},
+    {test_bitrev_w,  0xdeadbeef89abcdef, 0xfffffffff7b3d591},
+    {test_bitrev_d,  0x0123456789abcdef, 0xf7b3d591e6a2c480},
 };
 
 int main()
-- 
2.43.0


