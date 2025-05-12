Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0920C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJbW-0001yw-25; Sun, 11 May 2025 23:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJaZ-00084g-4m; Sun, 11 May 2025 23:12:25 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJaX-0006qD-IF; Sun, 11 May 2025 23:12:22 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7418e182864so2901401b3a.1; 
 Sun, 11 May 2025 20:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019539; x=1747624339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ssya0fsna9FXCZ4zE69LfIN+U5eg7bKfEGkGAdHL0+E=;
 b=aCNngKFk7dgIT2wsUKBR1CykMp9iR7W2pdq8seXwHy2jHStb9DcZmVyh2yu3tp/Je0
 sdfqEeaWoat9+ni2hIcV1qnmjrdDR15gfuwDlC12EmbXLze5ykXYbaUiMCEtcumytOys
 E+reDlvA32gP0C+v/C4gxPmiE7a+GdfbsOLyH0/2EUlcQSG+Ih9MsXrUxzhWwMn6rt0q
 cYyAmOKhUzeYK1Zsnccfvf4VAz76Ys/la0ihGAwROj5Ucpd+uw1I6xraGS/t37yp9FJw
 8mHr7NxSRkMafvuve6cNNzt0Xuk+vaL0zM5q/ghuh3UzN2ZA3PKL+z+EpIAgPygdzvbn
 0hLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019539; x=1747624339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ssya0fsna9FXCZ4zE69LfIN+U5eg7bKfEGkGAdHL0+E=;
 b=WvpU93li2w0VBJMv1fH5SHTn6LlEMRYt9G3L2W0rlO3h+ei6lpApqp72GPmU2B8dVF
 tP5oHWNSV8gfyfAiKHnFn/F7jHQa4NsAZiCGJtWdXXDfQwKFhn2D/4U5azyr2pog9DrS
 oVzH5lM0RHyaHvl3eVVHYiuq+7c2V0SGg3fRPHIvZdov7EkpazECd9X5WUHNyYnZfE2Y
 j7EkWIvQk3mQT3mixwzMYoFDb9CcYsRQ/MN4tpGuB7jEkoMpyeJ40ifFmTrJJac8+JBw
 PuErSOUU27sM7+BXj7o/HNuLiYBU0L6BH0HkY4y9k9Zy9UzcRE1357ZtJ/d1/Z2ATpwv
 BJ9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe87kb/p08jCFr2qtd4/w6g171tf5SzhdJrHhEyC/Y0xIcoC5AiG0rBkvhZiMzSWKR+bjZr+fk282x@nongnu.org
X-Gm-Message-State: AOJu0YzARA8iTbxiPO7Iubaci/HivgMVVFFxmHi1HEDv14ADl9f5fxpm
 9GT8B56JC/Xp5yAAXdqXNscrJkZ/6Zq/SFG5sSCuQqT7LlaJ/Iev0oa6+w==
X-Gm-Gg: ASbGnct81Xb8TiFNkzesJuQwxUHjKfAvtZdRcG7/AZdzZUQajjR9SQZdT81r7cXrBvg
 1fb5FVAYF0ED56rGLcCXAmlAT84dJT1atDjqNX/7EKM+Y61eYNOpHYiWpVYG2mm/CFh0aR3geew
 TxMNUwXGKHorNswdamKryrEkFBZZ8w2s+Nl/Lx0hQaw+WRp1N98cORmnpStje3XGaBO50yrlS+J
 TuI/GsyUN+kPZwR90BciRWbW1T6gj4e1fiFEJaAM7Q7ZIgBRYD/k/KTvqJAlsUpAOYqgvSneZ3s
 q+ERQLhEcYvogNAFXPViTxooGXviW6RX+8XroSRyWOIbY4wKuZo7/XRPcgHGQhCV4x+c
X-Google-Smtp-Source: AGHT+IHFv8qlhYXqM0qodChNmDsvBjP2+OKaCxMRcT1HZP2vk0XJ74tTw0yvIaVwfEzEAI1+tgiQeg==
X-Received: by 2002:a05:6a20:d48e:b0:1f5:769a:a4c2 with SMTP id
 adf61e73a8af0-215abb3a217mr16095566637.22.1747019539397; 
 Sun, 11 May 2025 20:12:19 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:12:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 19/50] pnv/xive2: VC_ENDC_WATCH_SPEC regs should read back
 WATCH_FULL
Date: Mon, 12 May 2025 13:10:28 +1000
Message-ID: <20250512031100.439842-20-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Firmware expects to read back the WATCH_FULL bit from the VC_ENDC_WATCH_SPEC
register, so don't clear it on read.

Don't bother clearing the reads-as-zero CONFLICT bit because it's masked
at write already.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/pnv_xive2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index fcf5b2e75c..3c26cd6b77 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1329,7 +1329,6 @@ static uint64_t pnv_xive2_ic_vc_read(void *opaque, hwaddr offset,
     case VC_ENDC_WATCH2_SPEC:
     case VC_ENDC_WATCH3_SPEC:
         watch_engine = (offset - VC_ENDC_WATCH0_SPEC) >> 6;
-        xive->vc_regs[reg] &= ~(VC_ENDC_WATCH_FULL | VC_ENDC_WATCH_CONFLICT);
         pnv_xive2_endc_cache_watch_release(xive, watch_engine);
         val = xive->vc_regs[reg];
         break;
-- 
2.47.1


