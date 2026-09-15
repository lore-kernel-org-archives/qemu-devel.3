Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC50C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WdT-0005SV-Uf; Tue, 15 Sep 2026 13:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdP-0005RT-9R
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:55 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdN-0003Wp-Nv
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:55 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912e64ccso435755e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789492072; x=1790096872; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ws19gc3+FltY1dGtK5GkfLj1XsaSZHbJrk4tzn5m1FU=;
 b=LFDbbeH6axBamel52BiKw6/xBsArIgbtOgvqlhId5wl0qx+8iRF4dWIIkB3/00n6UN
 7gPSGzRbk8nF/wvWMx3KlKVZzAnqi4omZGrfqdICkOJ+dd+rXGEMbPL7DQvOrjg7keFd
 wJ58D+vsaKFyFlqXSZG1h+TXQyI9ZTbtsR7OHAn52XmkrudltE7DO+pHepQg/AzhbEtp
 ppl2RIRME9iemT+4ulfLRdQZUbY5DRjpUuh8sJbJLlKMhrtuNiN0hjcE+VIZ1smX8Vjr
 G7RySHlHcTToCC8N4gt8ZvoLM/WgzG959KoB8SbhNUnhJJXUSUww35LgkCQ3xf5XY7KL
 KYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492072; x=1790096872;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ws19gc3+FltY1dGtK5GkfLj1XsaSZHbJrk4tzn5m1FU=;
 b=wq0WQcYbWTCA/DeEdcVy/i85cJmfS8OskgmDXQ6PX4RsFW7pVzTADouSG+UETW34Ib
 awoRYlVpTTvlsaSbDk95X2i8r513AVoHhi6sj/5LnurdPmUS4Z/s0TdrfkTdL2Q2xvDs
 nVKKPp5TUCZzgOlaflQ5VXmj5m0KJA6VYW3JOukWO2iaw++O5WkvRjb3vpHfg3KdNByh
 PNYF3/hBNcIAfzkjrCx0HatBi+DodWnMNCUZOEE47z5u+Hf2VMWPsmZuJsdhYL8ZQUGV
 JDxo27APZJ0bqIVJNWPI3xjZzbZPEhu4//YP3kIMRYckzz0XOG4h0wXcVyChW/AGBtfC
 iweg==
X-Gm-Message-State: AFuF++mtDbr/UZ+HM9KWGgs+x/wgy6xNqBN0WC0z3k139XEIc3N0MyhA
 ILDihmLwglM8I27Ry2P5i4cw7+9/s1eR9b7WsEw9qbN5gMs9Uzt08skWAP+th3fzoKByJ3IbRpb
 K8IA3bC0=
X-Gm-Gg: AYBFou1SD3/iUbQoz4BrrKRyqsmU4LbKwpeMI4zmIN44E76rL5i362LvR8B1/C4TMeB
 D4kPjcUedRPl0BGuzzV2ifJSam3eG0mAaBqtIgIPyXABrhYd+ypEAWHmPmSB1J6aYwVlEeEGVET
 yKCmGoCce6wC+/tZiaDPFNnwsxWXRGU2iXlvZu6nURJkK+EIcn+zVcjPoS7VAwIKDCvDWu8MEfn
 G8l4HK+dc2BoZrfvqZs308o3sGAsFmdqOCQ+5/eOX7UjOXqk0FNvhpi1mR+vkKINwBBYxI8IzSO
 WLvjcaXkCXUgKGjVFgHtfwU5bAY2urbZvF8JQifT41XQFk8lLd4M49FTnRvW9iPRysWwu7OrurE
 6HDtkFercyHP8yoS11uRNIo5jtUrO/5vzvOuxdk+/bTCfAWelOzoMU3DJzRGyj6L1MT9Kh8TC3M
 AbbUnQzBeIRSwyWPZe1UwzbhxjEoT5nYErjQs9NNdaT8CnScI0Y/Be/7o3kf+aQswVwL6Rv/Z0L
 eUnwRbuka3B08e8Y/80h8/Tcom1Gk/dYcvUNDMEUTKWnAxNH/uFyTY5erQC3SBohewl7r1mEHiA
 wgEM
X-Received: by 2002:a05:600c:8705:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-49e7a678629mr195478355e9.13.1789492072030; 
 Tue, 15 Sep 2026 10:07:52 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm431826f8f.23.2026.09.15.10.07.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:07:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/20] hw/char/stm32l4x5_usart: Accept character input upon RDR
 read
Date: Tue, 15 Sep 2026 18:07:27 +0100
Message-ID: <20260915170735.425445-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915170735.425445-1-peter.maydell@linaro.org>
References: <20260915170735.425445-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Alex Bennée <alex.bennee@linaro.org>

Looking through existing serial devices this seems to be a common
pattern so it makes sense to me this is the right fix and matches the
API description.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4389
Reported-by: Jan Brittenson (@bson)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260902165956.582901-1-alex.bennee@linaro.org
Suggested-by: Jan Brittenson (@bson)
AI-used-for: fetch issue, apply proposed patch, verify build and qtests
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/stm32l4x5_usart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index dd1b0991956..0b02dde1f8c 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -441,6 +441,7 @@ static uint64_t stm32l4x5_usart_base_read(void *opaque, hwaddr addr,
         /* Reset RXNE flag */
         s->isr &= ~R_ISR_RXNE_MASK;
         stm32l4x5_update_irq(s);
+        qemu_chr_fe_accept_input(&s->chr);
         break;
     case A_TDR:
         retvalue = FIELD_EX32(s->tdr, TDR, TDR);
-- 
2.43.0


