Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEAEC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 11:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDLnn-0001Po-FQ; Fri, 09 May 2025 07:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1uDLnk-0001Pe-Ne
 for qemu-devel@nongnu.org; Fri, 09 May 2025 07:22:00 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hz1624917200@gmail.com>)
 id 1uDLni-0002cc-E5
 for qemu-devel@nongnu.org; Fri, 09 May 2025 07:22:00 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736a72220edso2199622b3a.3
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 04:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746789714; x=1747394514; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:from:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=oPL7WF8qFSav0T09BHsLzf8I28URn1/xgO0zb+PQucc=;
 b=ZN6lHuzhGUKU0QnkNE831DagPpBWOhiump0oL68SjQv865rLW2zA5Ql3cby6bRau8a
 RHCuGhTnDZgpR+HNJipepN0iHRcaOUIfksnyItcdhK/48hGkDgJ56AKAY0ZKZJ70Esch
 HJzKzvWjM/zwlxhSU7aHOwPydEXsMbYn0mP4/EDpYYQSPyR/qerOsY40XpFaa7xGizym
 czdXDTgd4159OosGEXlJgsd1V56vFZday88mReAIpY0InbVxnh6QqnYV0U7XppZQEjjz
 8bfsKunqVX/ozN3nfCSTwR1o8ZMJW9Pyd4Om7bcMO+5UrxrURBDiacwCcpr0om8ltClg
 VQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746789714; x=1747394514;
 h=content-transfer-encoding:to:subject:from:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oPL7WF8qFSav0T09BHsLzf8I28URn1/xgO0zb+PQucc=;
 b=KhZnlNqlmKz+TqNJBnE+eMj3+02l8+eyYOZ1X2cMnMmFzPJj28P/kiG9VLGWrcU+S0
 GiiisNTVmpdI8WWyHAhdYTIsRDCz/vY423baLQ7Zo6FrBcqXd3HQ/2uIuNYx9D/eL0T1
 LxEvr4ark5WMPlbByNEHCZtI5CzlQGYahi+hpDUZ5HDbIQ5S/xMlAZvVGVJWGFnWf9W5
 sBguxgZirQUOXeF3MxGlubFePCpoU9I/6kyoAIfJBUcAdT3sy1tzT0euC14T4vQ2Jspq
 Vb3QcN3AT20eHbB/l+Rsmi7i0NxM71iMpekhwNX/41JIgVqSVWRqwXYPPJKz+5qs0NRE
 9JEA==
X-Gm-Message-State: AOJu0Yyod+fdLbULxFIa3ZGfEZAp2ijy8jLOqMVvUKa/HOgp0qlvyWtY
 rXENIy6QS8M1vKYqlOf+ch4Cb3q6QJkfqCGc7LA6wnYzEw2WVQPuYaCSTQ==
X-Gm-Gg: ASbGnctuGKAkBZrYC998j51mT3BlUlwsTjzFWmeCOcG7BIZ1k/PZXoIPcVmICURtP2S
 TlVcSmeNMcg2hO6EnRO+OlLgUa6m+7tsqEORaLmMCfwSRwOA+V1yWIY/dLhZ5ZpgD95Srz6S4iS
 Jbwb9/yUc/s8wdC/9/OWsykw30Ch69PInPSk48aDbwHz7LCFSJeoBPFB7QhOQsXsvmBppES9y2z
 /WBlm5OytoWL3KFwgN417uI23yYdtxfzN+ZXYSTKmHV5Z8kRUeKxyl1n6TZctCBf18F6t8B8Duv
 AFjLjjfNOzgHYKaXunxYg4nMovhjJW+iHoYyOT94auI0bFHeLH1a4T8OdAykIvY3S0RWc5kfD+j
 Rwt76/Ml5a8zCCcNSkmg4Veml5v3nxz7Bi54jUxB3/0iq5j8=
X-Google-Smtp-Source: AGHT+IFCKuU1ZPzeYmZnED2sZXjcE8a51DG9xAmH5JRoJ4xynEpk3KML5N97o1k/l9puvlrhF4JWEg==
X-Received: by 2002:a05:6a20:9c88:b0:1f5:a98d:3d8a with SMTP id
 adf61e73a8af0-215abc7a781mr4653233637.40.1746789702564; 
 Fri, 09 May 2025 04:21:42 -0700 (PDT)
Received: from ?IPV6:240e:404:1920:fd75:c5dc:7302:8c3:8925?
 ([240e:404:1920:fd75:c5dc:7302:8c3:8925])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234af2c287sm1088606a12.41.2025.05.09.04.21.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 04:21:42 -0700 (PDT)
Message-ID: <6d228069-e38f-4c46-813f-edcccc5c47e4@gmail.com>
Date: Fri, 9 May 2025 19:21:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zheng Huang <hz1624917200@gmail.com>
Subject: [PATCH v2] hw/audio/cs4231a: fix assertion error in isa_bus_get_irq
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=hz1624917200@gmail.com; helo=mail-pf1-x42a.google.com
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
Patch v1 misused ISA_NUM_IRQS, pls ignore that.

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
+        error_setg(errp, "Invalid IRQ %d (max %d)", s->irq, ISA_NUM_IRQS - 1);
+        return;
+    }
     s->pic = isa_bus_get_irq(bus, s->irq);
     k = ISADMA_GET_CLASS(s->isa_dma);
     k->register_channel(s->isa_dma, s->dma, cs_dma_read, s);
-- 
2.34.1

