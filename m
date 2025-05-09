Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683FDC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 11:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDLhd-0001BC-4p; Fri, 09 May 2025 07:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1uDLhb-00016M-DA
 for qemu-devel@nongnu.org; Fri, 09 May 2025 07:15:39 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1uDLhZ-0001rG-Dj
 for qemu-devel@nongnu.org; Fri, 09 May 2025 07:15:39 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22e730c05ddso19096735ad.2
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 04:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746789335; x=1747394135; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:from:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=w37uRQkbRh13fcoa9Ff9GIzvttVw9Z47RX6OOQkxQX0=;
 b=WoHEyEOmO8ZJArW1H+2zbqRfo8W+on/2RddWdhvrsGVN95PCOPxlycnvwS/N0J9Wnj
 fkHxSu72Xbm4S0L3RNFGIRe59oVEJQ1iLFZ/ex39BmL81iI6Ra4r1EhI7OxLdeJODJ8V
 Om3YEaNb68uVyF27TaMfq4Dwb7T3ur6HcutmkvlvDwMKoIabHpEe8/MQhPJLUlsuifrr
 WofR1spRAi1b3ckLjQy5ZmCuxYgk06y04wKqwoQkNv7Pt+GNuvasLLiQtmHKtx3DAta0
 3P0171NMI1JnnzRgEAFfkEcg9MDMIlrihuhF3rBPD/OQLbOIX6XFybXWdW1SEb+XSw/Q
 S/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746789335; x=1747394135;
 h=content-transfer-encoding:to:subject:from:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w37uRQkbRh13fcoa9Ff9GIzvttVw9Z47RX6OOQkxQX0=;
 b=sBJ/Llm9qUfo2vWeEq29ptD4O4vIm6/+Vx6o9H63dYCvKihZ12dgqFdD+8pYzEdVSa
 kEIDWT7ne7NnhMwnfS3lxDvX7a76BdpIpJ0lsQ/vTsxIP5ZsZXU4qQYrHcInStnWKa9J
 +u661K99EwWbl6sAQZUfPEddsW0pd5GpNvIj3p0rZmVQ3hwGEjIeCJy/v2ReeLHhgHLk
 8fONS60EAqJ673PNo1ojtw1yjM2sHKaoNZCGXrwbnRuoGTbTrSY5Cqk+V8Q1jkk/HKPQ
 sYsw8cB+O8PRuAFRUWxqsWZGTlzXseYOO6eytUHstqDRQhp69Y5aaE2mN2Wxi0Ko3YcM
 2NyQ==
X-Gm-Message-State: AOJu0Ywkvoc7VFTSBmGOg9UvZrq7H7E89/vv/l42i3ehyrf41O8uSAPL
 /dpazTLh5Gope42afediKlFRDUbDJWfwhoi0NSkJmqYHqBdWnUk5810s5w==
X-Gm-Gg: ASbGncvc3mmCs+xTn5uLgMQ1HL/ZirvyZqcIXEpq7Gi2g5TRhbEScEQ5NjapNSYMZXo
 ATvanKaC+erkHgFaWXkJ5oOnZHH/Fs2z5jhe7nz3OEiUuiqZPlL/DdkGX/sx3jszhfhfSsWtANS
 WqTbhbRItzdEQgC3WJ4dpN9FYN1mJqJE6i14LjxGCkiGEgwv5/amV/efRJS+4LE0Kky7Q7xfkZs
 BzuWASy8G0SZEtKcsyievjhr8jdyuUl3AvmoO8YK+mfm6hIqfpt4i2OlYXr8HnNBJsbfrbvH1ri
 lx4LSwkqPQUpCftk5vy1yU/8aCMyitgso7e9eurOxId80rQpaDIYWCYC18dUC5ErC9AqYbrjbfA
 58jkd/Dp1M92dD/rT5XrpRNwo8864Kizx+qMR
X-Google-Smtp-Source: AGHT+IFzqGwSzdZbn+FoypIYNvysK8RSTEx3Oq410cjx6Q5uXMo7573NgEeS7DHVspbqaj87a5s70w==
X-Received: by 2002:a17:903:946:b0:220:cb1a:da5 with SMTP id
 d9443c01a7336-22fc8d98a39mr42395795ad.40.1746789334819; 
 Fri, 09 May 2025 04:15:34 -0700 (PDT)
Received: from ?IPV6:240e:404:1920:fd75:c5dc:7302:8c3:8925?
 ([240e:404:1920:fd75:c5dc:7302:8c3:8925])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc8271bdasm14808865ad.122.2025.05.09.04.15.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 04:15:34 -0700 (PDT)
Message-ID: <b18184b6-aa78-4b81-b2af-96a5628f122b@gmail.com>
Date: Fri, 9 May 2025 19:15:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zheng Huang <hz1624917200@gmail.com>
Subject: [PATCH] hw/audio/cs4231a: fix assertion error in isa_bus_get_irq
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=hz1624917200@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch fixes an assertion error in isa_bus_get_irq() in
/hw/isa/isa-bus.c by adding a constraint to the irq property.

Signed-off-by: Zheng Huang <hz1624917200@gmail.com>
---
 hw/audio/cs4231a.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 5a9be80ba3..d390da4c37 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -682,6 +682,10 @@ static void cs4231a_realizefn (DeviceState *dev, Error **errp)
         return;
     }
 
+    if (s->irq >= ISA_NUM_IRQS) {
+        error_setg(errp, "Invalid IRQ %d (max %d)", s->irq, ISA_NUM_IRQS);
+        return;
+    }
     s->pic = isa_bus_get_irq(bus, s->irq);
     k = ISADMA_GET_CLASS(s->isa_dma);
     k->register_channel(s->isa_dma, s->dma, cs_dma_read, s);
-- 
2.34.1

