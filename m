Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09716C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJa6-0003OK-Os; Mon, 01 Jul 2024 12:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZE-0000p7-4p
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:50 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZB-0005Tq-A6
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:47 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-425624255f3so19310585e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850062; x=1720454862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pJ0vzkmN5Hgmb8rgDSg5G2IpqWGpWILmCLfl1B7KYcA=;
 b=tv6cDWkygLPEXxBBrw9Vt1oUm4xIxeONQaQEG+N6fiQWqcmEgOSfE8l5iGc3yt18LB
 mLOIMofb/fA6Kj0U96nBh48IH4Zopaicg2kGsEMr/wFOHc34ZAM9X184Xy/PznmJgbKN
 z+YnfJe36Iq6sxWcBNx9/UONjvbqApmpSt2TYeqefZTgjhRztjzSO6GC0THofx/GcNGb
 9aAmKQ99BJF7/9z8H+V35p9IqMIEUBNLSInP2q6vawreWQgNs1V+hse1EkDNFOth+fdI
 /1RSe3vC0u+2K/h4LkjQwo7kh3bjG4TLhe67NgaYuBFwzcqsrwnm90NRzRohOQECTbAZ
 r1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850062; x=1720454862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJ0vzkmN5Hgmb8rgDSg5G2IpqWGpWILmCLfl1B7KYcA=;
 b=OXtcf2Xo+gp7rggg2btv0HCorcI0jVcBvYz0pmAPBM6/9mXj82+9bCj8nJf8/v4LQ1
 RKd80ohGhBDMCSJvBUIfVLgJhwsQXJoFTaMHrw+I3drE4YpCJ5SejUmLjUnewf+5aMWq
 gJdq5xh06kF+AxbKxQwk4bWSpzyTlarGTx8pm4UHh9xPS7lXfCXzvnZ5BXZVlTp9wiYt
 qvmhyX433YKk+9wplDZGeHEVP6q/PAyPrI5mQrFBuLjhBmGN9ravOE/KI6Xg/N/lfHT/
 s0du03X7WgF6nArni+m9e+ht1XkVf7I+TswYCdZAMh3Kw3pMcExO7N1MnVKVA6z6JOSR
 icYg==
X-Gm-Message-State: AOJu0YysWTX6qGcnV+pKu7UScIAJwdic1qtcDtZwysHD/FRt2UeX0J7u
 sab8GyGgiuDms9m/KiiiO5zDVYA7KbdFreHVsswHid/+FHf8GP+0dBlm4LbCNBVosUeGKJjznOg
 mKZs=
X-Google-Smtp-Source: AGHT+IEQ0Iky4Nmx04cl5wSxcnkRxKtgD8Q1N0Nj+oe2lvSCN/X0VdmtyoLASVvVSALQ05VuVidORw==
X-Received: by 2002:a05:600c:1c21:b0:424:8be4:f2c with SMTP id
 5b1f17b1804b1-4257984de8fmr53664175e9.2.1719850062128; 
 Mon, 01 Jul 2024 09:07:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/29] MAINTAINERS: Update my family name
Date: Mon,  1 Jul 2024 17:07:23 +0100
Message-Id: <20240701160729.1910763-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Patrick Leis <venture@google.com>

Signed-off-by: Patrick Leis <venture@google.com>
Message-id: 20240626211623.3510701-1-venture@google.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 19f67dc5d21..13255d4a3bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2496,7 +2496,7 @@ F: hw/net/tulip.c
 F: hw/net/tulip.h
 
 pca954x
-M: Patrick Venture <venture@google.com>
+M: Patrick Leis <venture@google.com>
 S: Maintained
 F: hw/i2c/i2c_mux_pca954x.c
 F: include/hw/i2c/i2c_mux_pca954x.h
-- 
2.34.1


