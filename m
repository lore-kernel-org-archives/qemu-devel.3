Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC495E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9aJ-0000Ix-PL; Fri, 13 Dec 2024 12:36:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Y4-0008Ht-C6
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:57 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Y2-0001kW-GX
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:56 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso12763325e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111231; x=1734716031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1pl3yiGui8waosH6gArdPVMZTP/hR95Dt5JKzQYZcYE=;
 b=tTkuFmcVwJ2LLri3J6dV7HjH6FN/dSrXWxLrxCmUIy7Bazam5L4i/57ldKFfShNxuX
 /SzFCAmIxcoeJa3HTJaHoeEvnKFKQCt88HdbYmMuCmDNQC4cnYbOc7Pr2SqScLAOO8ze
 kvOooRtnxvp/MEzQ5pNUxjdibEnqDlHDseYP6PJjG4Chp1lpL6R6P4vq8emClKUCUh+5
 rYpkMNc+BQBecIi5DXhztPpSF5qYHiQj7WqwyxhLTNFspxOV8YrE4Q+wWPDGdezTDSfh
 kQOLG5GyvUntaRDUyaV3/8Y4WiUdYrQIuZuw1A5mLBHT+qLNKWPDxg7/rBAKIGZwqUMp
 MXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111231; x=1734716031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1pl3yiGui8waosH6gArdPVMZTP/hR95Dt5JKzQYZcYE=;
 b=iTG7md1QK2jUCdwH1bBbNOUN5jLIzxTN2iasHtdh+3G0eplNEY5Z+Xw7CbMEgQV/r+
 V34f+0HVkV1Wmcd1HLThDXQGZoxbdeaz0cusg1eakfc7VPLNEz4rp6RS3br+JRtuMKh+
 fKIwTQ4g6SiOtKNLOCJOYydN896Cr1kfRTwxEoJ37r6XTFkRqnZ1qjkZ3qTTzoKYDYV2
 DlFUr2PBbeBs52ubfKW5bJAEthP28xtRPfnMo8FEyenxatup5sVGy9N28TjCUXxr1xpe
 KzzVdZab3dbiLuTovB4YY7FegsxPrZPHccEW1djaDkSmnVFkI4Zg41eB6mwQz2pMOPqd
 22Qg==
X-Gm-Message-State: AOJu0YwL/c0xUr1fGNpLcxgSO0rP5zIo7kv5qTRDkyBK2x14IWkYHi44
 mswWtvYVbqn6PsIBjb8x2/M1UHM+F/e9Tm2gcrqXIsD19D5nYBMeXk03goCpMV0eZCCmb6bPcJQ
 /
X-Gm-Gg: ASbGnctZF/YM1qkR+zXsaZtNREN6OL7Q9iF+Uw31voyJQFq4E2hg8hc8SiHsEvnnKnD
 8yKWR+zXnFo8KrhXhOWc3OG/R0lukMZm0+kj53L6XyL1QWtWzMN2Xqlw/fkPt7Oj/SV8a+ynzxr
 oxkWONw5u0LhR0VL8eBiODH7OcR10o39WlCHAKKdz6CqLFTcBCd5HytUAqD83aa4Uy/PlJc4YbA
 b7QNY5FHFRe3+CiioLBgiUPC7OCxizwKueNKy/nzuPSPlC+eU+xEegcq6zn5g==
X-Google-Smtp-Source: AGHT+IH84UfD0L7BxoEChBWL/3/L9p2LTxNZHh9Y2k82JCOfA/WUNauFD/AQbKkPh1Yri4Wjt2vX/A==
X-Received: by 2002:a05:600c:1da6:b0:434:fa73:a906 with SMTP id
 5b1f17b1804b1-4362b10e8a7mr25002765e9.4.1734111231069; 
 Fri, 13 Dec 2024 09:33:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 75/85] MAINTAINERS: correct my email address
Date: Fri, 13 Dec 2024 17:32:19 +0000
Message-Id: <20241213173229.3308926-76-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

Mea culpa, I don't know how I got this wrong in 2dfe93699c.  Still
getting used to the new address, I suppose.  Somehow I got it right in the
mailmap, though.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Message-id: 20241209181242.1434231-1-brian.cain@oss.qualcomm.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c1ab51b2d1..822f34344b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -226,7 +226,7 @@ F: target/avr/
 F: tests/functional/test_avr_mega2560.py
 
 Hexagon TCG CPUs
-M: Brian Cain <bcain@oss.qualcomm.com>
+M: Brian Cain <brian.cain@oss.qualcomm.com>
 S: Supported
 F: target/hexagon/
 X: target/hexagon/idef-parser/
-- 
2.34.1


