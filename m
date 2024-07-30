Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FED0C49EA1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjLS-000464-Ce; Tue, 30 Jul 2024 05:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLP-0003vj-LE
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:35 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLO-0000df-3N
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:35 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4280bca3960so25368305e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722332433; x=1722937233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/p7od16yWan/HDEkGj2xKqznwD/3Uyvk/bZAOed461U=;
 b=aGWOjwOlSK8J+sC6ZJFJL5xn4uDPoP2r9y+PnjvTm4AiZrhZEdYkqUwA+Za0qNBgef
 WJ4bEqSlF8CEJlfaodpfX6k6MJj00QxMAt7q6NmXRAy/iBHts9Zh3EZ7kKvMQ1qNs4yy
 gfaNauvpvfljZcWLbWsSK4WhrJW1+TDVnX/RpYMw5qpYR++DHUjwC21EC63Nsv/jFr6l
 DjGrkxGYluRrJ/FJE5tabXp+pMvt9gJEv5REwdtgc3x/x2EzLVXftcksZVCm9UYBaTup
 G89y0viz8OOUgU75D0yU4PWhOND9MPEuYJ0gP0r6jsEFw5Nr1xoMB2uXsoz7ogdjuk4m
 n1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722332433; x=1722937233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/p7od16yWan/HDEkGj2xKqznwD/3Uyvk/bZAOed461U=;
 b=RJn3A0AtQqd96/3C3V8kCfv3cIFWTK2/wD3CaHLlyW8+clAlS550NFKy4OxwBm5x6C
 070JuaVaKbVV9eKkIKcqAzXkp6O17puNpqyZgr8Qw3thq9YzBVKKp7h9xuscrklpaCoq
 hZ/JWtuw3aQ7y/SkX56Bf8RmSbISfNjbEXk1QAbDHFBoBXBCg1uf345Bgxy88TpEajW9
 RudyEVbaIBYwerDg5NuWv52nWYomfDHUQjaTHWLGgJDNMmEriba8+brpqre52pPuOy7m
 XaC+rZeA6tlZh6wu5/mLaXKagsHY/eDWURxxoIMGhp8wQJpulOm3LVPp7klO0U2xwWcj
 V17g==
X-Gm-Message-State: AOJu0YyDzzjo/QlqYcV/viywDfQJz5mjikfL34D7V8XoS8LGNn0ZOXsB
 yC6p6SgI1Dtghd3F22FmaEM0oKpGDiRgDPpLq1J4LItteCnxYbu5oYGvAu8uuZ7L/Cw6csMssjc
 V
X-Google-Smtp-Source: AGHT+IF+pNRJ3pVHCBr6CxeZULr52V7dsxz+Q49euP97uyNx8prcWL+oyFJOo9gR81G+7Li8QtV/Mg==
X-Received: by 2002:a05:600c:6dce:b0:427:985b:178b with SMTP id
 5b1f17b1804b1-42811d871a4mr68531495e9.16.1722332432646; 
 Tue, 30 Jul 2024 02:40:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14194974f8f.106.2024.07.30.02.40.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:40:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/21] target/sh4: Avoid shift into sign bit in
 update_itlb_use()
Date: Tue, 30 Jul 2024 10:40:19 +0100
Message-Id: <20240730094020.2758637-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730094020.2758637-1-peter.maydell@linaro.org>
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

In update_itlb_use() the variables or_mask and and_mask are uint8_t,
which means that in expressions like "and_mask << 24" the usual C
arithmetic conversions will result in the shift being done as a
signed int type, and so we will shift into the sign bit. For QEMU
this isn't undefined behaviour because we use -fwrapv; but we can
avoid it anyway by using uint32_t types for or_mask and and_mask.

Resolves: Coverity CID 1547628
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-id: 20240723172431.1757296-1-peter.maydell@linaro.org
---
 target/sh4/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 67029106277..9659c695504 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -187,7 +187,7 @@ void superh_cpu_do_interrupt(CPUState *cs)
 
 static void update_itlb_use(CPUSH4State * env, int itlbnb)
 {
-    uint8_t or_mask = 0, and_mask = (uint8_t) - 1;
+    uint32_t or_mask = 0, and_mask = 0xff;
 
     switch (itlbnb) {
     case 0:
-- 
2.34.1


