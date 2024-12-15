Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F33BE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtxA-0002f4-RY; Sun, 15 Dec 2024 14:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwW-0001L2-Mh
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:16 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwT-00018v-Qd
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:16 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3ebadbb14dcso910973b6e.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289572; x=1734894372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ermVyfZ+KD5ml0lXaGRWdiJA/VpXEa7zOPDhDo5E/rU=;
 b=VepLBZkNCfdfnIE5NCWx+n6qBwzkoi1VPcr7BNoT9VCj0XrHrKHcyjpnnURsYX2yv9
 sj/5mMVrac4XHRlpv0FEWOdBcROO/CAAVT5lHEG18Dg2gpQVPXkbxQouq9rU3nXyz33T
 8iLlruknEj5K+Y27J48Z7TNu+M0GIb+OE1Vmi99Jdhbq3vW5pi/wZ6Upxt+VRxOMUjrv
 uDwFS0Ug4iVkU6WwgFICLiZQOv0UqqkZfRKUZKZBI9dwy3qaQzxn7hqyuYAu8e9l3l/l
 LFbX7NnttQobFv20JCXPBTNrKND4IQGBfUViS32u1+qtAiVbMlkbKg+BZeR+d43JFf3B
 20Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289572; x=1734894372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ermVyfZ+KD5ml0lXaGRWdiJA/VpXEa7zOPDhDo5E/rU=;
 b=VjJNYpPHocyBwgTOZCgLfQrXZbbcnQVmYHtPxl1F3+EN18hDolTls/bdDDx7gvvMsl
 4t5Aoq/7+CqgWhku5/NjOuPhoZJMBvIBl5rBU/4nNSRjxqYIVcCXj55ELoEXc3MTK5jg
 VYFX3NvGmmWBZK0RXQYqfEAo3wu7M9uj2dHtrOopEmEajUxPDOKubNWMYcSVZ+azO/pk
 1Dh7UynhrFoxSkOqa3rgypxLujI1j9r5cQYuFowjlxgdL5jlusJDhWwSO5vLpaCCU2aa
 O1IROcSowUoTy9sQv63lgoGY79zSe4Z67QP4XQYjYde8l2TbAwDfme1Bjf4AYN/ceEXc
 esdA==
X-Gm-Message-State: AOJu0YyPsxlW7N23+ro4blwjRm2dtW2WUO6OLOsT/P8LC9PyIn8VrtG/
 x/G73L5hsr/xnnMuijFBmsd0GsaeNTljPdEKr2UEgJYfT0nNXOK8GZHydvtDX24CFquiqXJzfL+
 DdVzmNU35
X-Gm-Gg: ASbGncs3sWS2HxTFIbMMLnjQdqPqGMChRUMfh95k5ELJTLRr3yVxbeonLri98qABJ1/
 RlTs8JXswyVXgaNP4N7rzK2XKpv+zAO4IypFjEN7cXIOfaR5pI0WzvCPldVSGe8aOHa1+zqrbeq
 gwG8stwBNUeKEpua26+ZF+jHpSol85a/jSJ7E1v4sHeCR0zuVnIQkZrYRFPbIR0cppEAEa/nzzw
 KMAwz71kI9ipkMhcf/asUvwuhSgIiXXuzorFtndGf+wPdKXnvBYGUnOiiF52dIyb8QL1/FAdcqY
 xPEf0MsCh21jSNFYkNS40yPAj1cEb2VYpOXfEbINZpk=
X-Google-Smtp-Source: AGHT+IEJz5nfx4mTwCqhfYwWhj3h+O6YqMhRsxq8cO0fgrXGJZ54mkTeK5tdFK17eNo2AiCndUiMXg==
X-Received: by 2002:a05:6870:6388:b0:297:241b:c48 with SMTP id
 586e51a60fabf-2a3ac8c10f2mr4638298fac.40.1734289572604; 
 Sun, 15 Dec 2024 11:06:12 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:06:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/67] hw/dma: Constify all Property
Date: Sun, 15 Dec 2024 13:04:50 -0600
Message-ID: <20241215190533.3222854-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


