Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB1FE77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB3I-0005Lp-2N; Fri, 13 Dec 2024 14:10:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB2W-0003mf-Vh
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:09:30 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB2R-0006go-6e
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:09:25 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-71e181fb288so940814a34.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734116962; x=1734721762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2QX322DCnm5cE0pXBGmrME5GjV/mM7P7qq+mljbXHQc=;
 b=FYbPsRuLN27DAsU+h5Gq1SIxYwAgHil+XRVB7v44rSfzJWKMCBmU4llcF9VQqWs2LH
 u4ShZjGNFYwHEhbjj0b7y9+oJzH4jpsfzhVjFR9dS3RMv1Uhry0AaoyyNvz6Pw0GXEbD
 /AKY17CxHS0ALGDISIWTBqNTVsyZNI9z7DchhMlemCZp67s747PjABjwt2mNYtJrJ9ml
 2TVXlBe02fc/OnQoFjq4J1hpds+4Gyhu1OxfDXLugDTGcef/flBdwFKqD/SOuAJ3Lt1w
 wTNVZrLEck+zoEpD066C7KTo32V48oUmrMJgFjq/sLC3nRUcALmp5K8/TC9U72lWXhSP
 8fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734116962; x=1734721762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2QX322DCnm5cE0pXBGmrME5GjV/mM7P7qq+mljbXHQc=;
 b=Sg+bX8g1GrvCjVTKnCxN/+mhlZ6+lNq15Ji191lWUQg7QiUqxfajigni20XBhKyMGK
 hnxmxUdz6mtYiYRxN5Z2JHzN3eInhilxVGM8HwTtc0x6XdgVScJSnXpY1hZEzpAYY0vl
 qkQDHJy3hL0Y9O940TZEPf8S4TlkZGYEnBQdC0WkBXIHWleEOt7n5gMqA7KNMZ6wvbrX
 i/OcO7AT9ZSpdv7qKxwGpcn5EnH3Z4J+/E6o8LTwPLJyEm+M4BZHNW6Qfc/H7Rk9logt
 09zVneLQKwtaC5LMHZsTxSmBbmJobdxnmw7D6AmuWV13wH39PtxuHBayzaJJaTFMYrmW
 Pz9g==
X-Gm-Message-State: AOJu0YwmIyWzsRoqoFRfBhkPw6Wns5oSi/S/D5M9W9SDuApmi2UcrVZR
 UKthjOowTU/MwXg554+ojuYIT/5RnwM26cHgkHf5Q5k9TZuhvOg8odkTjVP5tTEpEUZADzeOrGn
 ekzECw6ce
X-Gm-Gg: ASbGncskEkQ3LSH1DuUlSfKxsAeG8oS+x5knfVu1np4WUq9eCjCJM9fr5d+ToHzmRiO
 +q7yVPVZKzKZem3Wm2gxHmyUZIttNDpR0nBhkZiTH9OWnpqYFRNfPiq9SfUy3JfApd6g8/fWiYP
 juvW/QMcxRikOCuZVDs7OW3qFYkn5y8gLbZ7/uUvFJlT2xJy2pNg7r6GF9dDByxC75w6MStHfd3
 an7wEWztKbUiCHiYdWuTj70i+d1dWSkdhZKzCoEK0NSndjRaD8wWklOxUeg9clJ
X-Google-Smtp-Source: AGHT+IFDPHpOX/QqcYPt+gU+gLigqJo/Sg/1M3YfPDWbyWLwbfc/o2zOYWTDMoHIzO5ifLqMAWyefg==
X-Received: by 2002:a05:6830:2b2b:b0:71d:548d:6f76 with SMTP id
 46e09a7af769-71e3ba4f66dmr1971252a34.26.1734116961994; 
 Fri, 13 Dec 2024 11:09:21 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:09:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 qemu-ppc@nongnu.org (open list:PReP),
 qemu-arm@nongnu.org (open list:ARM PrimeCell and...)
Subject: [PATCH 25/71] hw/dma: Constify all Property
Date: Fri, 13 Dec 2024 13:06:59 -0600
Message-ID: <20241213190750.2513964-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/dma/i82374.c        | 2 +-
 hw/dma/i8257.c         | 2 +-
 hw/dma/pl080.c         | 2 +-
 hw/dma/pl330.c         | 2 +-
 hw/dma/xilinx_axidma.c | 2 +-
 hw/dma/xlnx-zdma.c     | 2 +-
 hw/dma/xlnx_csu_dma.c  | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
index e72aa2e1ce..032afedde2 100644
--- a/hw/dma/i82374.c
+++ b/hw/dma/i82374.c
@@ -139,7 +139,7 @@ static void i82374_realize(DeviceState *dev, Error **errp)
     memset(s->commands, 0, sizeof(s->commands));
 }
 
-static Property i82374_properties[] = {
+static const Property i82374_properties[] = {
     DEFINE_PROP_UINT32("iobase", I82374State, iobase, 0x400),
     DEFINE_PROP_END_OF_LIST()
 };
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 3e6700e53b..8b04177393 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -585,7 +585,7 @@ static void i8257_realize(DeviceState *dev, Error **errp)
     d->dma_bh = qemu_bh_new(i8257_dma_run, d);
 }
 
-static Property i8257_properties[] = {
+static const Property i8257_properties[] = {
     DEFINE_PROP_INT32("base", I8257State, base, 0x00),
     DEFINE_PROP_INT32("page-base", I8257State, page_base, 0x80),
     DEFINE_PROP_INT32("pageh-base", I8257State, pageh_base, 0x480),
diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 8e76f88a69..3f392822ed 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -408,7 +408,7 @@ static void pl081_init(Object *obj)
     s->nchannels = 2;
 }
 
-static Property pl080_properties[] = {
+static const Property pl080_properties[] = {
     DEFINE_PROP_LINK("downstream", PL080State, downstream,
                      TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index 0668caed7c..d5a0a1caa2 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -1646,7 +1646,7 @@ static void pl330_realize(DeviceState *dev, Error **errp)
     pl330_fifo_init(&s->fifo, s->data_width / 4 * s->data_buffer_dep);
 }
 
-static Property pl330_properties[] = {
+static const Property pl330_properties[] = {
     /* CR0 */
     DEFINE_PROP_UINT32("num_chnls", PL330State, num_chnls, 8),
     DEFINE_PROP_UINT8("num_periph_req", PL330State, num_periph_req, 4),
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 73a480bfbf..f09452d0b5 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -611,7 +611,7 @@ static void xilinx_axidma_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-static Property axidma_properties[] = {
+static const Property axidma_properties[] = {
     DEFINE_PROP_UINT32("freqhz", XilinxAXIDMA, freqhz, 50000000),
     DEFINE_PROP_LINK("axistream-connected", XilinxAXIDMA,
                      tx_data_dev, TYPE_STREAM_SINK, StreamSink *),
diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 46f50631ff..1a63d5f3b2 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -810,7 +810,7 @@ static const VMStateDescription vmstate_zdma = {
     }
 };
 
-static Property zdma_props[] = {
+static const Property zdma_props[] = {
     DEFINE_PROP_UINT32("bus-width", XlnxZDMA, cfg.bus_width, 64),
     DEFINE_PROP_LINK("dma", XlnxZDMA, dma_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
index 43738c4350..d78dc6444b 100644
--- a/hw/dma/xlnx_csu_dma.c
+++ b/hw/dma/xlnx_csu_dma.c
@@ -691,7 +691,7 @@ static const VMStateDescription vmstate_xlnx_csu_dma = {
     }
 };
 
-static Property xlnx_csu_dma_properties[] = {
+static const Property xlnx_csu_dma_properties[] = {
     /*
      * Ref PG021, Stream Data Width:
      * Data width in bits of the AXI S2MM AXI4-Stream Data bus.
-- 
2.43.0


