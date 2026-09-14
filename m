Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA9EC88E78
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x697N-0003iY-41; Mon, 14 Sep 2026 12:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x696b-00032h-OP
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:00:30 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x696Z-0004cq-O2
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:00:29 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485b1d2874aso1778060f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789401626; x=1790006426; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IdKJzGBUWRrrYUn+MEqvsitMdRE0ew6RnIW7SSHXtRs=;
 b=GsTnDn8/tbb0wLncvhYZjpzPwyyk8WgLVRVZncVovObAnNh+HZ9MgUlCV0v9nuOg5Z
 HFsXZxdJ/EfFyv9kwE3nypPeO8+oztY+TNeLWn922IohagS8XpxsrCiZJWBCsAD+1IsE
 llV3fHN1sFgQ07iOHnbBSsVb40lwlPt7BnYem8SvZjwkV9uKFCCKLZZotW5bku5mJQsv
 waJd4PHysquj7Os06JcI+YPNx/GRC4EtFRFTw+Ewm4YHGhFdQkqZGVlr4xTobGfxps7P
 IRCwF7GtFuR0jrUwFmfRBhghbE1jikUycc2Bigh+VVIoIT2V7rW5T2lWrsGF6DcHPjw2
 prCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789401626; x=1790006426;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IdKJzGBUWRrrYUn+MEqvsitMdRE0ew6RnIW7SSHXtRs=;
 b=CuIwG3L2zGj9fij0oEUrYqXXCcgN0ooeQerQTQ6u2muOBv8XKxr37uyYR1Qat5FI3H
 0ySNuFfU+f9PCA8aJBmIFVak356ojZBfNI2UuxiB7tVDrWnBVXD7Ni/4Xn1HGe9S3rPC
 4XIQWuGThEFRAnct2unTNI+AzNTgEnvcOO8F8nYaWHoiIMGrUA3uFC2gN25t+B7gpAzx
 6qi3oUpothLNnXO1V1umt3YHnouT7ppdzqqICO12mqpSPAz8XgCb1R56s31LjEM8hQNp
 bcBEN2mFy86GcnL/VlBgQGXVIz4wT45HstLjTNyuFsv0Nsfy/udVw5WdU/AvCSltblgA
 tz9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBz40qBukPKJFXtGG9hfFoNEdJmgw3aG7nHYT5P6t2BxL4Qf9iAqBGZCq0E+KJwA50oIqJGEhr5Nhhvt@nongnu.org
X-Gm-Message-State: AFuF++lK9O6y+CdNlLiXf6DAuC7oA2rS+UnfyiHg/d6jgvReort9O2tp
 GsXQvCozjFpGmGJZth8jkfaGfZ2k2wrb89ZXD8/4QNavHKXNpeF+CzftoXynw4K9UYMXYpuE0Pf
 +i5pxgGI=
X-Gm-Gg: AYBFou0SI5zu1QnGD+5U883TpoHYKpI6IoIDWqaJ6PrfmfNJdh5GyzqVwqqwoP96F/e
 jY+yQX5u8g2LqxJz7hmCsaPFrGYPE9mIFXydyyZvqIlwwspu23fzvXnwKq88BXk+fA9H4c5LlBw
 vN3LOZOumzBOkQ7izks+ux8sTsJKcagdT2+fJ7wqgEyP+rubPpqBN+LIvTusDHZc6FBZnpWYgBq
 l9p9VD2gHPdS3IJ+pAEWy6mOQ89QAtmbTyjX0vMNWrpNtaV0ZtuN5VNignjjnupurp5aPX+KqnO
 Sl0YzEyR7+5lNgplN0ko7mZpL+G9fXBJCe/p62trfYuZt4RpGl4hXdoW21U/TMbwNKHmDtQ65d2
 ZK9O22zY46F9b6N89ODZDvVoLyHg8wBctNYmR9ZD9K8e6U4sA0dyKpERWRHLNISocGOj1aMJI3V
 sgJ+L71xpVfi8BtIYs2Zm+bQM6DQpnWRk66KgS0zBqpKmM5E4/iRPe5DiL39w/yUMqxEIEeWWPV
 4uHilBzC6tYXgUv7sYEpXB6yqIH05xxgGvakWwQlyM9aoOPyk5YZjTdxnviT5l5dxMZNP50Onzj
 8Obu
X-Received: by 2002:a05:6000:470c:b0:486:f770:9e87 with SMTP id
 ffacd0b85a97d-48702aacef4mr8116371f8f.5.1789401625895; 
 Mon, 14 Sep 2026 09:00:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb350686sm30797695f8f.27.2026.09.14.09.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 09:00:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 3/9] hw/intc/arm_gicv5: Regularize spacing in
 config_readl() switch
Date: Mon, 14 Sep 2026 17:00:14 +0100
Message-ID: <20260914160020.327787-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914160020.327787-1-peter.maydell@linaro.org>
References: <20260914160020.327787-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
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

In this file we don't put blank lines between cases in switches,
except that for the switch in config_readl() we've written it half
with blank lines and half without.  Delete the blank lines to make it
consistent with itself and the rest of the file.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/intc/arm_gicv5.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 124816d864c..e477c805b43 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1468,53 +1468,41 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
             v &= ~R_IRS_IDR0_VIRT_ONE_N_MASK;
         }
         return true;
-
     case A_IRS_IDR1:
         *data = cs->irs_idr1;
         return true;
-
     case A_IRS_IDR2:
         *data = cs->irs_idr2;
         return true;
-
     case A_IRS_IDR3:
         /* In EL3 IDR0.VIRT is 0 so this is RES0 */
         *data = domain == GICV5_ID_EL3 ? 0 : cs->irs_idr3;
         return true;
-
     case A_IRS_IDR4:
         /* In EL3 IDR0.VIRT is 0 so this is RES0 */
         *data = domain == GICV5_ID_EL3 ? 0 : cs->irs_idr4;
         return true;
-
     case A_IRS_IDR5:
         *data = cs->irs_idr5;
         return true;
-
     case A_IRS_IDR6:
         *data = cs->irs_idr6;
         return true;
-
     case A_IRS_IDR7:
         *data = cs->irs_idr7;
         return true;
-
     case A_IRS_IIDR:
         *data = cs->irs_iidr;
         return true;
-
     case A_IRS_AIDR:
         *data = cs->irs_aidr;
         return true;
-
     case A_IRS_IST_BASER:
         *data = extract64(cs->irs_ist_baser[domain], 0, 32);
         return true;
-
     case A_IRS_IST_BASER + 4:
         *data = extract64(cs->irs_ist_baser[domain], 32, 32);
         return true;
-
     case A_IRS_IST_STATUSR:
         /*
          * For QEMU writes to IRS_IST_BASER and IRS_MAP_L2_ISTR take effect
@@ -1522,11 +1510,9 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
          */
         *data = R_IRS_IST_STATUSR_IDLE_MASK;
         return true;
-
     case A_IRS_IST_CFGR:
         *data = cs->irs_ist_cfgr[domain];
         return true;
-
     case A_IRS_SPI_STATUSR:
         /*
          * QEMU writes to IRS_SPI_{CFGR,DOMAINR,SELR,VMR} take effect
@@ -1537,7 +1523,6 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
         v = FIELD_DP32(v, IRS_SPI_STATUSR, IDLE, 1);
         *data = v;
         return true;
-
     case A_IRS_SPI_CFGR:
     {
         GICv5SPIState *spi = spi_for_selr(cs, domain);
-- 
2.43.0


