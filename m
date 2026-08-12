Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C187C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7tH-0005Ia-Db; Wed, 12 Aug 2026 08:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7tE-00057M-O3
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:17:00 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7tC-00009D-GK
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:17:00 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so5677495e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786537017; x=1787141817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cdxBjmzv8M0DalZ8uTMP0FJBApNth+sIgrWTaLR2xuw=;
 b=smoSDYg3hX3iRn6wy3kLvEZslwQemOabu2CjtYlIar7lE/3+Y2E/hoDWXv3pv6Xh2o
 kvY/ngdesIrpwYofQvuZxj/xPh9iPEu5TcjWOvpZYLgjc9z6E/OICoPUH5JqJlM415d2
 fwXZFRrRjRxkhD6Jt2Ounho18tqZh7nlpli0MkQjJwiUlJp/KJlACgsi8iBUs7qms1/M
 D7GR2VWBYXh21et5DB+aKf64U94macW4+aJ/LARDEOlOTuGTtsMaunZKysqkmmvSn4HE
 1GY9ybQK2GypKH/OuuUSoiJZOZrx1YBcU2YDFo2Z9na8psCYzBiy3MNMpKuCejOK15qr
 6aZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537017; x=1787141817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cdxBjmzv8M0DalZ8uTMP0FJBApNth+sIgrWTaLR2xuw=;
 b=ik+cJ1cQ/DT9ifFdeodU3n0xvXBGsQa0fbDNr1S1X924TwzYcTiF6RbcatR7ju1a1r
 TZJUXiJVP16fWDtge+15a212N3QnVfxt4x24VPFWN+KCPzv4YJOV5FWx7z5XXAfGssbj
 M9Yjr1qRkeA6Tmh6/liS4lPFb8Y4dBwsSAxSAHO78LmlPpHTYmYagE7gJuroHvIpjNJO
 ngOXFIxb8MoJuXoiqItC4c5HeHIvR+6ZbqIQf7Lr+u1K+w/O/qskH+yNaGRgWV0IiKOf
 9gH69662Nczvch/MPW2y6eYdKxSDz1zvyS4lYe4SlVi1CP3cpJaya/tlKORIkL1N0Nhu
 SC9w==
X-Gm-Message-State: AOJu0YzOq+8gNhcGPFzbm16bKN18yy7NTE0psPtdyQOVaPtqkNQG2qHz
 cuU3o1B4cnhtX58WvUkqhn7of0ff4RFnsLbMPJ2HAC6gRdMh3gpH0jlg6hQjmWqujs89VC3I+S3
 2PdRS
X-Gm-Gg: AR+sD13HsBL2y3omG0cP1P7Bqlp0cD5QkweZ/TeMbmgM2Agekxn48yZE5w3RPhjlpLB
 3fDNB4CXK3JOjMaMqcyldppXB2F8gch7OrSJ4tlDOJP6m9LVguIuyiL0q5dn2KzbzTyqF5oJcxE
 pcQGCg9heLT4ErQpFEfK4QfUU2clg07rYcUSefQgt1Ek2RIS4H9MT4B5o2xO/ZIvopUCjBPFRIM
 x6CEdlUzwKqiR5tNjPR+6J8Keplb+R36Y55E51gLOPoM4Fg58HW7Eyza4NMp21FeHblBBr9kCln
 Qzl/PLFOOsGyFlO5InnsvTBQ10F4eufyGIdi02GpLRZqoBkCzdNLuCdLGHLc2qA3G8q+0FIgYcA
 sWsctXQooUQIwFLXAbd8dq3rfbNxKEAPtxoAVSG5Oe+qoZjXuDx/gKnWptLwvox8SRS3FX2wCXp
 0FfcDupXkhfEXSNowj1OCx5Czx+AsY+Cg8bzwwLZ4cDAVBrCSfQkRXbMYyFc/oDZS/rSkNbgTma
 nft8sEDPEQFjzafVwAcw+5VgpsW/HXa1nQYgYHZ6ZrWP0HkvA+XkGYcT4xLC8Up/vsDH2tnl2KG
 9HBa
X-Received: by 2002:a05:600c:8209:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-4997c13dd74mr66844645e9.12.1786537017136; 
 Wed, 12 Aug 2026 05:16:57 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.16.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:16:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/26] hw/arm/armsse.c: fix SSE-300 s32kwatchdog address
Date: Wed, 12 Aug 2026 13:16:15 +0100
Message-ID: <20260812121622.649730-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
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

From: Simon Xu <simonxhy0404@gmail.com>

The SSE-300 SLOWCLK Secure Watchdog Timer is only defined at address
0x5802e000 in the secure region.
Page 45 of the SSE-300 TRM specifies that "the watchdog is Secure
access only".

SSE-300 TRM: https://support.arm.com/documentation/101773/latest/

Fixes: 8901bb414a24 ("hw/arm/armsse: Add SSE-300 support")
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
Message-id: 20260805191257.11303-2-simonxhy0404@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/armsse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index ddb210c895..e99b491bd9 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -409,7 +409,7 @@ static const ARMSSEDeviceInfo sse300_devices[] = {
         .name = "s32kwatchdog",
         .type = TYPE_CMSDK_APB_WATCHDOG,
         .index = 0,
-        .addr = 0x4802e000,
+        .addr = 0x5802e000,
         .ppc = NO_PPC,
         .irq = NMI_0,
         .slowclk = true,
-- 
2.43.0


