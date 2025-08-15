Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008FECA0EE8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 09:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umqJZ-0003fO-W4; Fri, 15 Aug 2025 05:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJS-0003aL-FX; Fri, 15 Aug 2025 05:01:26 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJP-0005j4-Hq; Fri, 15 Aug 2025 05:01:25 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45a1b0bd237so13435385e9.2; 
 Fri, 15 Aug 2025 02:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755248481; x=1755853281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zzk9hUnM76xaKXIPgu879Vp6/dyXg/0tOdRlxSSSDw4=;
 b=jurOJnILiSTy957c/Cyd7jILPentw2E8SQmmGUg23zFYy2NVU6MvA/jcRnE4KWqNCC
 oAuU5skY5VI/026udpAmNFIvcQPeDRphxGI/lJP7sJwhOK/gWDIr44+MCk39AOMO/v8T
 2UjlqaAxqssB8X+fuv/WYG7SOvOX/XuCCRKO8EkYp0anbJpE1Ea8945vONONhoKkRokb
 8hC7Xf1lZIiO+bBlOlY0lR0EdUVFCH6cOdz/bUcIS0qcsuxKGbrX0uDR9MhMSeg/33ej
 q8MtF9yupM6tZIrx85FLVv3TgY8oykB0/Icvr4FBH+tjQSHnrm5dsKKt8fe6wHfgykjm
 WAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755248481; x=1755853281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zzk9hUnM76xaKXIPgu879Vp6/dyXg/0tOdRlxSSSDw4=;
 b=CIbGJKdWJyNyMEiEtJ4VAG8/B3PshYaNLF+mdOTZkQV5KHtlcrTH13dAhuXNNAhYOS
 wv5Q6pBrkjxlbVxHuyZf7E1dmz5mbf/0rM3V5Y9mRkPiPAGuVjmFgs5WA5zBbQAzOunq
 RxGL8aPtAaUHz/GwIMzWEWCSFaKqGsarzOF9AXcvsLWGSJ6dcP2d5czkcgV3ZxhapIeH
 JYes2anqYC2ESchaYtAb8oGTzGRJt/s+O5NyrY20+Can+XNzadUHSJ37aUGvhEyaJNKf
 OWy37UE9rQC6HZFKGuLtEqPXuS/eyc+GQohXV3sjdtIvNRBScjsRekOCVsv4u1Em1BQl
 TV4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCC8y8pu4An7Gt8VSYfHg3dhcYbX6GsKVMK3W0zzD4fAzXbVoAnFpxDUKvjoo4ERYFsdpkRkg3NA==@nongnu.org,
 AJvYcCXjKtYK1fluAYphYPxa0jCHkyK5i9IfIpL7SJVcHf4JK20xFh86eUIenMY7VwSdldf9FCYqGeUuCTvUgg==@nongnu.org
X-Gm-Message-State: AOJu0YzwMs2pUXXTnw10NKFNo2xdhp2+fr6DJiDzJowZJNfkmgLIM4Q1
 25as66b9pHGu0R4InjrLML9o6+5WuN7DHvBdh9MWFZKZHuzG1TboV/8PX9NhGrAz
X-Gm-Gg: ASbGncuvQN2w8KfLlKmZL/B6onli1x+sqqtxRbWHAYx8I/++4iAgmk3/OqkVne8lWlp
 6eI61ahUkqx1mLrBfSBR4D/jQ5RAD9FSG6vrsAuKp0fB8nQZrqiezcyjfPIr43gtBAiWhenQh0n
 m/e1OQec83vxT5D7NKeOpZHRcI3lLvUHsXaspbrrFvPyJ4DiUNqfp0mrPkW9LW4HoXi2P90zpWW
 eztRKxIfqowGQ9wNQOHpk/ZpYGVKac6Pllc8G6zUTaYwdhoayFDy4cVg9WTc73WcP3/T3tXNKxJ
 OjmsMmRlKx9ONeXbHLLPoNnpcQEW9bmKT+PgoMBiddw6d1oC45xzzUwNqidoDRst12Y1ca8L+me
 XyXxuBGwBG31Cx6KNl/K5tNnVU2RDzWmKwGaF0hiWLAA6dg==
X-Google-Smtp-Source: AGHT+IHRFt/eEqzpH62Cv4CEZt0PVbEy0BmhY2zlolVMMqHPmUw4kBGrPbojfLummVuS8xIjtpqL/g==
X-Received: by 2002:a05:600c:468e:b0:458:caec:a741 with SMTP id
 5b1f17b1804b1-45a21e9f09bmr10715075e9.24.1755248481169; 
 Fri, 15 Aug 2025 02:01:21 -0700 (PDT)
Received: from corvink-nb.beckhoff.com
 ([2001:9e8:dc31:6500:43b3:5eac:8d91:b512])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a22321a54sm10964045e9.18.2025.08.15.02.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 02:01:20 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v2 07/14] hw/dma/zynq-devcfg: Indicate power-up status of PL
Date: Fri, 15 Aug 2025 11:01:05 +0200
Message-ID: <20250815090113.141641-8-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815090113.141641-1-corvin.koehne@gmail.com>
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x32e.google.com
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

From: YannickV <Y.Vossen@beckhoff.com>

It is assumed, that the programmable logic (PL) is always powered
during emulation. Therefor the PCFG_POR_B bit in the MCTRL register
is set.

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
---
 hw/dma/xlnx-zynq-devcfg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index c699df6ad4..064955a0f8 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -333,7 +333,8 @@ static const RegisterAccessInfo xlnx_zynq_devcfg_regs_info[] = {
        /* Silicon 3.0 for version field, the mysterious reserved bit 23
         * and QEMU platform identifier.
         */
-       .reset = 0x2 << R_MCTRL_PS_VERSION_SHIFT | 1 << 23 | R_MCTRL_QEMU_MASK,
+       .reset = 0x2 << R_MCTRL_PS_VERSION_SHIFT | 1 << 23 |
+                R_MCTRL_PCFG_POR_B_MASK | R_MCTRL_QEMU_MASK,
        .ro = ~R_MCTRL_INT_PCAP_LPBK_MASK,
        .rsvd = 0x00f00303,
     },
-- 
2.50.1


