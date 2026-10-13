Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F00CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY34-0006po-2K; Tue, 13 Oct 2026 04:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY31-0006nk-Gn
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:39:47 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY2z-0007ZJ-OD
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:39:47 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a01933b584so23046635e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880784; x=1792485584; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dY5bJ6dJUERrSTEf33O+vZmh2Dy5obdCXPAP66j8BsQ=;
 b=N3GtelX+1jIP79XN9kYqU/WTQAESAPsHCaWTA0OcJKM0vTaiCYjQ116QbJ+U0GekQM
 zoTaA5LCKAEi9d25+ALAfZjd05FDHsIeWoLJb4XRHWol5iwpyXMHHjcq4IU/XwYILqAH
 vEjSJtaetWBDec64Ohzk4rdGNZotK+5bBxR8CdJxZUgj1eHUrA/Ro7QdhQBGVSlkBd24
 c6E2jE/fvxC0vR+iKPFU/IOKfPgUGljhOXEfEXcaYV6LS5eOpyZVreVUTfsMZ6wwZrW7
 ChXvAxx9NVe73XDSWpeGsckHLgDBwBhIbX/JcutjWsiRt3Q3b3gZT7FrTUgCWeuYPDlo
 nRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880784; x=1792485584;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dY5bJ6dJUERrSTEf33O+vZmh2Dy5obdCXPAP66j8BsQ=;
 b=KCIcAClBplqqJ5nq7DxMklZmaenHyw4I0xTPk5dHlYUX7ZEOydWcoD3qxgkx/1Lbeu
 QAX4t2H+O2dj2PoN3R6DmDf3xBQL0XWLWBNEBkmsj/9NOiZScwTl4H2P4n2VTHX1JI2b
 BScfeJNsjUSYgNcr5D0OTFuvLeBSxCM8V0ZiybMxKOuRIcqDx0S07FL3IqGyyVbwtK5i
 jYU9P8tHqKzttKOpFhnHMqVB5yd1BMQGVjjHDR/lJlBDAbS7lM4e9JPnJ3kQWE5NzTXw
 Q8e8J3m5fF0Vh+oq9MhvhzteNY7vERR9BmjezuVoEqj8g5CErnzk+BlCS+yI2rfrC3T7
 S6+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9ZubrvWS487wOnK+ZfKBZxwIyYgG2o5XuaFaXaYyw6qKVg0PqEwWahsP14O4jFbZZm6spQ1DWvFO6@nongnu.org
X-Gm-Message-State: AFq9FYLud/jbtgsMvidv6bvQzSv7zF7ejjMzbXfzIF6PoDdBbSnPPtA9
 KIseWAFqt/ezakZkPDrPYXRxYnHmVFhLgRly+EPr1Aj+ZPQYwG4ZQbOxp12zzKgZ5oY=
X-Gm-Gg: AYBFou2BqUCIudhEqSYkKAQa+BDs+EnvMSOdt3cMoxWugFWsqWsSSzlDBl0yCWZ/zat
 YVLgkxN4jhOhLA3Jkerg3/L0JiZ2QVIf+sQcSZlSxdCnwpRkK84kEkBlVJAscwp/fRGK3/LGeZW
 rLx+RfFAC1SBze85wjoj0doh/e/RO47RILTfRpY9zba1bc3oJwHkugF4Isq73ZYqOB7EQTcr28H
 6q8Ev8F5SLpxz515qhzbEPs44NDtjPh7obtQHX6S1TzLo7jfFB9FPL7MSP539l50ZTgJZveB49t
 1HOu1DHkotxVdZHyIL/T1FizljiXlSSNiqmP5h5rTFPz7oe4QyW65FgMSM60yiNIC7LjGA433B3
 fsxmhQ97h5xHC0OB+39myThaT9R0Wo9s0QryCcAtQtQYX1T3cynyBSqxohtgSThHfOnAEjqmQMc
 SNuRYCYKCPRYm6kyJlRgHKt8pclI67EU5yZq3bvFBuRWmjkCEikzUWr/QG22XZ3j0XwzGNr1l+C
 47C2Bo7pePAwORZbqo5kgDI9wYotBS+pcfmkgMN6/P6mc62i0rE0R4QUCN4GM/IXemYFkfOrzoi
 LkA=
X-Received: by 2002:a05:600c:1c1f:b0:4a1:a484:2c37 with SMTP id
 5b1f17b1804b1-4a1a4842caemr80018425e9.25.1791880783731; 
 Tue, 13 Oct 2026 01:39:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:39:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 04/86] hw/intc/arm_gicv5: Regularize spacing in config_readl()
 switch
Date: Tue, 13 Oct 2026 09:38:11 +0100
Message-ID: <20261013083933.1024405-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 2b08f8feec2..d354ac6b992 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1469,53 +1469,41 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
         }
         *data = v;
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
@@ -1523,11 +1511,9 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
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
@@ -1538,7 +1524,6 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
         v = FIELD_DP32(v, IRS_SPI_STATUSR, IDLE, 1);
         *data = v;
         return true;
-
     case A_IRS_SPI_CFGR:
     {
         GICv5SPIState *spi = spi_for_selr(cs, domain);
-- 
2.43.0


