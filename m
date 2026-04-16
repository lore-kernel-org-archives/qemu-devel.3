Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87760F8A145
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIrv-00079Q-Ev; Thu, 16 Apr 2026 05:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqe-0005HJ-Oq
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:21 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqd-0007pN-87
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:20 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488aa77a06eso126798455e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331038; x=1776935838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gy6SvnnNxcAyYApni9wjJpLBWPu4eq2cYDkXqWaL+rI=;
 b=Bde/vZ6YEabGvPZhG1nb4bRU7X7jl4NYvyj12rQrgSsjlZlcs0Wz5X8WtWGUQTyJPQ
 +WIzEoJ7FceIohFFRAXMZiUp87Cz/yj7FhsK3l3eQHUMf7sp3tIepz1x6rSTXPSNUSFl
 rtOc2lxj+ww81XUVZoOoJVoTddHlhAeWTCWVINCMhqtK85hGst36v8zsuxFKRRRAuSH3
 sJnebVbxAnbx8YP9OA117ZiNItY5yxBjVRxLYaP2G67nvSNO3YYeLiReS5CiRtE4EOyJ
 3IVKC5wy9Cc921BV2O6dDu7th2g+cH1RvO3v5NsEAeiCyilApC3o6m6xLKWysQaIx1cO
 eVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331038; x=1776935838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gy6SvnnNxcAyYApni9wjJpLBWPu4eq2cYDkXqWaL+rI=;
 b=kpUE4z+B9ZYNwIYznxfwvRm8zOzn7jMb2Un/OSwt1lJjVbU5ZclwiOg/1yOjE7ZoJm
 PUu+2WVcO3bZvLYHBaifru78c2MlYqM3H+cYCneOg3y4qXOU9ZlIQKHnCW0SQcCLdu3B
 omfSpTq3Nzb18YgeJCGAJiq0qzyP+5rA96YSyBQr3kEFe1vEhfmkddrxZtn8mPU8WOv2
 OnMeA937N0v4IfAFHLas/OLTBCkHuvz36B9s0O0SEEk81S9K1bfO/mqN3YcFAi9UY/aU
 j4G4kDt8CvLZjVv3Y8HsH/Ixv5EmHE5Br7GqAI51X1IQ4XCOHylEiH5e3r05TD1h5DJd
 Jgmw==
X-Gm-Message-State: AOJu0YwOqaW5HRuTBRytKvBu/ShxQqLXgkj8E+YweMyYM0ua5hYIwjCJ
 pixIzlGindJsPAdODQbNedT6n7llP2gsIdOdZBLPE7stkj8u21SI7dw+TzbfbXyacUhmIEBGFvQ
 iCOAjK5k=
X-Gm-Gg: AeBDies12kB4N1EUr+gsQJbCoUUcev6IzpTzwfvENIVZRwEXWeG0OHj+8Uvb6r0ugJC
 S3d+kAoWKyRLFXkxHyi2suyfTiQFZHL89IxVWf3S+Z80fCzPwqZAdtMC2W1H9LjSILEZtpfsq/i
 vtKeT4DiSc/3ln6fnwwWLg3f/0jCWhHs83QUkt67TydPFhZKhUh7mbTE5izELAkFw4k2I8NOLRH
 Q7eKeSIsy+reCcNGNPqxLjr4RopY0wrD4jgknBEcUml1cnKRVIxeD73m5f6MJvMVmADch8eyuqb
 FOH2hdpl/Lx2w8rQNb3Xj+XY0NRAqu+r1Ix44lBse+SojrrNvhDfPVgVe2ERc/ybUzx2IwJaXSN
 b84dLbH9oqkes9TluyUEr/kvYN+bujlANc2WDgRJew+f4g0K4VyqmBIOjT7rs4cWbDN7bQ0Jcjn
 TV104ZDTFhx17jPST8bqHwl/PSS2k2Ocnc+dARsAV11lNFlstkB2QhhTbLOFV68216fjdGfvmb/
 XeNb8jYcqExQ0eXdX6NK7LDgxe3iVp++WAdIRs4Wg==
X-Received: by 2002:a05:600c:c0cc:b0:488:8840:e5ae with SMTP id
 5b1f17b1804b1-488d686dab1mr242760875e9.24.1776331037689; 
 Thu, 16 Apr 2026 02:17:17 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/28] MAINTAINERS: Remove Ryo ONODERA
Date: Thu, 16 Apr 2026 10:16:47 +0100
Message-ID: <20260416091654.316158-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
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

Ryo ONODERA has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7fac11b3f7..48dd571fd7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -670,7 +670,6 @@ F: include/qemu/*posix*.h
 
 NETBSD
 M: Reinoud Zandijk <reinoud@netbsd.org>
-M: Ryo ONODERA <ryoon@netbsd.org>
 S: Maintained
 K: ^Subject:.*(?i)NetBSD
 
-- 
2.43.0


