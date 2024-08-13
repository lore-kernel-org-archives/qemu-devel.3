Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D87C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 16:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdulb-0004zR-Tj; Tue, 13 Aug 2024 12:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdula-0004sh-7b
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:53:02 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdulW-0001BY-JQ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:53:00 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-36bb2047bf4so3736062f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 09:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723567976; x=1724172776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lbre056sEPIRICp8dPk/YvoBv3UqLB0jF2TdtHhkVeA=;
 b=X3PYe7WZxZE70Pcu6AqNFo4Tkq3KbVAg4etg4rYJA7bctQqcz5wr6WpXmRMAn1BWQ0
 cpRYe+Pk0g3eayDT13VdmCy8XAdR3UCllvBmibkummyv/TxtxtUeabr2xbnyTmuctWyc
 H4PpII/7RQjhp51tdA8UtSp9kWIECXafRnhwYxaqy3wxUPJU2LVpukbaokeOGKX3lKkm
 mcROF8cDv5BqSkTk9W5FMx34DFpFx6wLcOpT3IJDG4wER7zo3RwR7S5Ra/z4Lq7Z3IuH
 X7mq+cpAPRItQ/P/Ydk6+t699OleWeewurVfyHILm2/Z0Jkwl1mhkN+WULq2kYesoANC
 nb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723567976; x=1724172776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lbre056sEPIRICp8dPk/YvoBv3UqLB0jF2TdtHhkVeA=;
 b=px/ccmYXHiGxPWB/RJrqzl2S0DF6HaV6Ol+teets9NOyGBM1LsKUHzwtYiqXBSSjzi
 pVlpG43cbWYq0vSVOyYYZIw9AMI0ruiiyuH2g95ISJG5pB/o5HHwkdDg6vq5ScaVOHSP
 DRut6Q2/6ueiUMCi/7vhzo00nzy0BHB+enSd9HPmTy8ibmNtchmyz7T+1VKf1WPhL1/x
 7GVudtDDDunfedAsfZRhahF9H8SmTb9bUs3DvSMTU9dNZekKZKsxPO83SEalXxc/rEsS
 cMwX1gwJnGHHSphL+/RkdDtPEAatuUI1aYfgKXKOjk6+nF+lKb9+c4H9nXTz7e94f8g9
 /GhA==
X-Gm-Message-State: AOJu0YyMKN9hSn/69LF07aPHekeKKfMl+yTqef+URbtsfL+XWszPWyvc
 /opsRokQaomPvKhb/OxxVbO5FKASxlwIQcuBU5sVBTehUVkt5+7Ow5wxixjuubml3SSY28ZTxq4
 1
X-Google-Smtp-Source: AGHT+IExnm9L/pJacatfxoLNPxAHKBZlG3V5vhRPdotgNdjhCIHckQIf3TvrnGnCYOKJq3LvSvymlw==
X-Received: by 2002:a05:6000:1549:b0:368:4def:921f with SMTP id
 ffacd0b85a97d-37177768ac8mr138305f8f.11.1723567975938; 
 Tue, 13 Aug 2024 09:52:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c77374a5sm147347015e9.30.2024.08.13.09.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 09:52:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH for-9.2 05/10] hw/dma/xilinx_axidma: Use semicolon at end of
 statement, not comma
Date: Tue, 13 Aug 2024 17:52:45 +0100
Message-Id: <20240813165250.2717650-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813165250.2717650-1-peter.maydell@linaro.org>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

In axidma_class_init() we accidentally used a comma at the end of
a statement rather than a semicolon. This has no ill effects, but
it's obviously not intended and it means that Coccinelle scripts
for instance will fail to match on the two statements. Use a
semicolon instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/xilinx_axidma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index c9cfc3169b8..7707634253a 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -626,7 +626,7 @@ static void axidma_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->realize = xilinx_axidma_realize,
+    dc->realize = xilinx_axidma_realize;
     dc->reset = xilinx_axidma_reset;
     device_class_set_props(dc, axidma_properties);
 }
-- 
2.34.1


