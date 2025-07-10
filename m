Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FDEC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 14:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZsWE-0004fb-2O; Thu, 10 Jul 2025 10:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZsWA-0004ZK-Qc
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:44:59 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZsW9-0007py-5v
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:44:58 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so769733f8f.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 07:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752158695; x=1752763495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BBgRy67LNVZpAgZr6ihGvfjSjZdnN3DUg/lDBl0cxq4=;
 b=dU+nTkcoUH+9d2HX7e0UFgWU1SqflhAWTsd14V+Ldwg/VwfPQmU5DkxxnbhEuZHzoJ
 UOPgkXF/npbMFyaQSKXMG98TW+2ZP/anVLXb1ShaZF4J4R6sJA4zEOxSokRFfMoUYCMG
 Ule4EUbdjY2IZoxmzhMF8HJgt7QSsAZV4lXn8oK3H5oFbwNeedkAl5tALjwpmvr9WPnF
 wligMR3C4dc37AvnQWOgaguI8oKJ4qWXKvFnseMqagXuDTVhzJGuLtIDKmIKnaVG7Afg
 /fdsDV01E5pSQeyM/x7mhOlocvGQ5MUNcoqra514m2CL1ox/jM8sg5rb8FZQdtGuVmtl
 Z4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752158695; x=1752763495;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BBgRy67LNVZpAgZr6ihGvfjSjZdnN3DUg/lDBl0cxq4=;
 b=E80Ell/Owo4mrT706tVB9mh2rLhK0WkqlP41mqaInuPtAPp4IddM+Zc5e2zaxP4I+K
 +AwdyrRNK1EGBn04nqrvhjNeF67bxhzvn8CwRuvChUy4yOnYWpsNPbfBQgCxhQqi+huc
 s6lCUjVZ9PCy1B/h4XA/b0C4da0U/e4TIq7NhmNrZ3PdiHSeLHcs53NIZTDfAPHwoORS
 gODN/IdWG1EVDBOfDKskFaICp0MRg1fsrdN201VrTmQnApPVB0Nm3JD7/xd+QQlQ0ZDT
 kEHt0jjsqdBUQhpFSKOgmGEJt2eZMTipJibS5ZL5Y811O/JnRW5HSB6dMYH1jorDWZYj
 A9Pw==
X-Gm-Message-State: AOJu0Yycvjvf+CblcBF6BXgTZKk7cK5mLmCbNWm/+zmuuBmsjcFRmcjK
 A1sCQO0C/uGnG0Ffm/8nL2OIRaGmJfvvSATZYTgvUjp682LFGCMz7qcOfb5oWzt+PoTGBILlLXd
 J9xEb
X-Gm-Gg: ASbGncvm+UhyZO+G/AvgNY9DSr+P8KrZ8URi67QTLNUXq78xjTgdRPji2g9BjBZkd+c
 EPFDSofW8tu4fvIPDfQIr19Ds9y80qVhoQDXaTdFc/AjaAbuaNYdZfmR6mP9equXthanPhgNoyH
 cL9ND01d+CblLiRkG4NKvObi3eWZPOS2NHhVAE9uJuckoJ5iYHfvJTIEyLuDwR97Ov6bAzb8ZuK
 OEUtmtSf+BLvh9MS0rmR2uKlpH8/w2Anjz7NTweqElLrzlMgknzF4kOWv0AoZLSnGJw9892B5lo
 Q4eA7KpJ2byOlA+bkkvOk0rwCPiFxyoeBF/jW0+7mpVecwBWdfCcbPSBKuPz8IJAdTD5
X-Google-Smtp-Source: AGHT+IH6C5UAOVoSO13J2fPrj2b2TNp7kNdfk6yf1po+mOekUh8EcxSz1JNyWOte8JxzPsDExgXKzQ==
X-Received: by 2002:adf:c784:0:b0:3a5:39d7:3f17 with SMTP id
 ffacd0b85a97d-3b5e78d2031mr2894787f8f.47.1752158695387; 
 Thu, 10 Jul 2025 07:44:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d727sm2077390f8f.51.2025.07.10.07.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 07:44:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH] hw/net/rocker: Don't overflow in of_dpa_mask2prefix()
Date: Thu, 10 Jul 2025 15:44:53 +0100
Message-ID: <20250710144453.1187576-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

In of_dpa_mask2prefix() we do "(2 << i)" for a loop
where i can go up to 31. At i == 31 we shift off the
top end of an integer.

Use 2ULL to avoid this overflow.

Fixes: dc488f888060a ("rocker: add new rocker switch device")
Coverity: CID 1547602
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/rocker/rocker_of_dpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index 4aed1787566..9c0fc728eee 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -202,7 +202,7 @@ static int of_dpa_mask2prefix(uint32_t mask)
     int count = 32;
 
     for (i = 0; i < 32; i++) {
-        if (!(ntohl(mask) & ((2 << i) - 1))) {
+        if (!(ntohl(mask) & ((2ULL << i) - 1))) {
             count--;
         }
     }
-- 
2.43.0


