Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CD8CD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slr8r-0001UQ-Gi; Wed, 04 Sep 2024 10:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slr8n-00017y-Rq
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:37:50 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slr8k-0005Tz-KX
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:37:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42c79deb7c4so35730265e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 07:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725460665; x=1726065465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hzHE7+Kz0XFUhG4M1ahEfBwiabVYY0NtWOThvlOAVxo=;
 b=tmhTGLKX/gMvSyvT6pnBRFF0U+8YlpvY8WdamEEOlO5pCqbxMihuIab3Q2jVwF/RR+
 Vu1lcK1jXgQrpUO810mId6cBF38VQoCnf3lJ+M6Lrdm+bW9JL0JIVh+z1XRAKxCbd5oC
 eCQvIbfgZOLK/cSOmhT74GnevAELJT9v2OraG+w5TVREmY0ADzdxh3MlbQ1/N3WkxvPy
 tNRv+law6vIiwwMEOObv95MXjKIFuJOJIfvsnwQ5eEKWOG5AEWd84HXAUoudaoOqoaFe
 FYBAt/WsPXeNgbllNZzvtNFvT6u+2c6nTtZTHnV1f1oo6vHqKIAyuirwXuu7yOerEgLB
 1Wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725460665; x=1726065465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hzHE7+Kz0XFUhG4M1ahEfBwiabVYY0NtWOThvlOAVxo=;
 b=lezi7IeMokAsUbzuLCb+6O0B1jACJmZvRd1ag5oTLaqWwIzQs0mRYALpjGy+Fw1Gie
 POmqcsy5SOzQ7jybVXlofm9+hgRbbz8klqL79LTVHR6NywrKGAasT+N8UdrEMEfgTs91
 /Bpq5vekba6nrDeVqzF8/pRIAghap1SuqcXKVO4wdLZvDVihJRjGa57sdyGIm4RlFjMk
 gGYdM3lEMhdyRDnMJqz2v5wFzYRQnnmlnK/1cZItpNJfYiVhn6SC3m2BgPUxmNahmJQs
 NhSoTj6UsjT4EsERK1YkapcfZibV1AxYOW1YA0s+e/nzHiLYMslzq3k6gFES+zB0DaLY
 z+dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpMvKcp1wr5LgkrPKH/6dWueU0nEi+bACDDb0F7i5HubTN1vX5zei1V905G4ySEQa7SAGHnN2Ei45F@nongnu.org
X-Gm-Message-State: AOJu0YwewfIcJjrQdvNSH82XSyAe8YzqKn9bFmd16VYSyUdvcdRT8FTz
 qeqQUqvHne/t1dX1C4Oi3lcosnOQXlRiKj9D2BVo89Fs4q9nygKFpHMMpnbFAiA=
X-Google-Smtp-Source: AGHT+IGURet22YzG9BdyHuFn7LY5zl+lrLQpQEmLFGvqZvyDyFwHD9/l++yeFmB/mXH1p4IYBUgEBA==
X-Received: by 2002:adf:cd0c:0:b0:374:ba3f:d00c with SMTP id
 ffacd0b85a97d-374bf1e4d69mr10122000f8f.59.1725460664441; 
 Wed, 04 Sep 2024 07:37:44 -0700 (PDT)
Received: from localhost.localdomain (56.red-95-127-44.staticip.rima-tde.net.
 [95.127.44.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bba7f9f94sm113090725e9.0.2024.09.04.07.37.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Sep 2024 07:37:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/15] hw/dma: Remove ETRAX_FS DMA device
Date: Wed,  4 Sep 2024 16:35:58 +0200
Message-ID: <20240904143603.52934-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904143603.52934-1-philmd@linaro.org>
References: <20240904143603.52934-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We just removed the single machine calling etraxfs_dmac_init()
(the axis-dev88 machine).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                         |   1 -
 include/hw/cris/etraxfs_dma.h       |  36 --
 hw/dma/etraxfs_dma.c                | 781 ----------------------------
 hw/dma/meson.build                  |   1 -
 scripts/coverity-scan/COMPONENTS.md |   2 +-
 5 files changed, 1 insertion(+), 820 deletions(-)
 delete mode 100644 include/hw/cris/etraxfs_dma.h
 delete mode 100644 hw/dma/etraxfs_dma.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ff8a96137..7b2860e9a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -229,7 +229,6 @@ M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
 F: target/cris/
 F: hw/cris/
-F: include/hw/cris/
 F: disas/cris.c
 
 Hexagon TCG CPUs
diff --git a/include/hw/cris/etraxfs_dma.h b/include/hw/cris/etraxfs_dma.h
deleted file mode 100644
index 095d76b956..0000000000
--- a/include/hw/cris/etraxfs_dma.h
+++ /dev/null
@@ -1,36 +0,0 @@
-#ifndef HW_ETRAXFS_DMA_H
-#define HW_ETRAXFS_DMA_H
-
-#include "exec/hwaddr.h"
-
-struct dma_context_metadata {
-	/* data descriptor md */
-	uint16_t metadata;
-};
-
-struct etraxfs_dma_client
-{
-	/* DMA controller. */
-	int channel;
-	void *ctrl;
-
-	/* client.  */
-	struct {
-		int (*push)(void *opaque, unsigned char *buf,
-		            int len, bool eop);
-		void (*pull)(void *opaque);
-		void (*metadata_push)(void *opaque,
-		                      const struct dma_context_metadata *md);
-		void *opaque;
-	} client;
-};
-
-void *etraxfs_dmac_init(hwaddr base, int nr_channels);
-void etraxfs_dmac_connect(void *opaque, int channel, qemu_irq *line,
-			  int input);
-void etraxfs_dmac_connect_client(void *opaque, int c, 
-				 struct etraxfs_dma_client *cl);
-int etraxfs_dmac_input(struct etraxfs_dma_client *client, 
-		       void *buf, int len, int eop);
-
-#endif
diff --git a/hw/dma/etraxfs_dma.c b/hw/dma/etraxfs_dma.c
deleted file mode 100644
index 9c0003de51..0000000000
--- a/hw/dma/etraxfs_dma.c
+++ /dev/null
@@ -1,781 +0,0 @@
-/*
- * QEMU ETRAX DMA Controller.
- *
- * Copyright (c) 2008 Edgar E. Iglesias, Axis Communications AB.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "hw/hw.h"
-#include "hw/irq.h"
-#include "qemu/main-loop.h"
-#include "sysemu/runstate.h"
-#include "exec/address-spaces.h"
-#include "exec/memory.h"
-
-#include "hw/cris/etraxfs_dma.h"
-
-#define D(x)
-
-#define RW_DATA           (0x0 / 4)
-#define RW_SAVED_DATA     (0x58 / 4)
-#define RW_SAVED_DATA_BUF (0x5c / 4)
-#define RW_GROUP          (0x60 / 4)
-#define RW_GROUP_DOWN     (0x7c / 4)
-#define RW_CMD            (0x80 / 4)
-#define RW_CFG            (0x84 / 4)
-#define RW_STAT           (0x88 / 4)
-#define RW_INTR_MASK      (0x8c / 4)
-#define RW_ACK_INTR       (0x90 / 4)
-#define R_INTR            (0x94 / 4)
-#define R_MASKED_INTR     (0x98 / 4)
-#define RW_STREAM_CMD     (0x9c / 4)
-
-#define DMA_REG_MAX       (0x100 / 4)
-
-/* descriptors */
-
-// ------------------------------------------------------------ dma_descr_group
-typedef struct dma_descr_group {
-  uint32_t                      next;
-  unsigned                      eol        : 1;
-  unsigned                      tol        : 1;
-  unsigned                      bol        : 1;
-  unsigned                                 : 1;
-  unsigned                      intr       : 1;
-  unsigned                                 : 2;
-  unsigned                      en         : 1;
-  unsigned                                 : 7;
-  unsigned                      dis        : 1;
-  unsigned                      md         : 16;
-  struct dma_descr_group       *up;
-  union {
-    struct dma_descr_context   *context;
-    struct dma_descr_group     *group;
-  }                             down;
-} dma_descr_group;
-
-// ---------------------------------------------------------- dma_descr_context
-typedef struct dma_descr_context {
-  uint32_t                      next;
-  unsigned                      eol        : 1;
-  unsigned                                 : 3;
-  unsigned                      intr       : 1;
-  unsigned                                 : 1;
-  unsigned                      store_mode : 1;
-  unsigned                      en         : 1;
-  unsigned                                 : 7;
-  unsigned                      dis        : 1;
-  unsigned                      md0        : 16;
-  unsigned                      md1;
-  unsigned                      md2;
-  unsigned                      md3;
-  unsigned                      md4;
-  uint32_t                      saved_data;
-  uint32_t                      saved_data_buf;
-} dma_descr_context;
-
-// ------------------------------------------------------------- dma_descr_data
-typedef struct dma_descr_data {
-  uint32_t                      next;
-  uint32_t                      buf;
-  unsigned                      eol        : 1;
-  unsigned                                 : 2;
-  unsigned                      out_eop    : 1;
-  unsigned                      intr       : 1;
-  unsigned                      wait       : 1;
-  unsigned                                 : 2;
-  unsigned                                 : 3;
-  unsigned                      in_eop     : 1;
-  unsigned                                 : 4;
-  unsigned                      md         : 16;
-  uint32_t                      after;
-} dma_descr_data;
-
-/* Constants */
-enum {
-  regk_dma_ack_pkt                         = 0x00000100,
-  regk_dma_anytime                         = 0x00000001,
-  regk_dma_array                           = 0x00000008,
-  regk_dma_burst                           = 0x00000020,
-  regk_dma_client                          = 0x00000002,
-  regk_dma_copy_next                       = 0x00000010,
-  regk_dma_copy_up                         = 0x00000020,
-  regk_dma_data_at_eol                     = 0x00000001,
-  regk_dma_dis_c                           = 0x00000010,
-  regk_dma_dis_g                           = 0x00000020,
-  regk_dma_idle                            = 0x00000001,
-  regk_dma_intern                          = 0x00000004,
-  regk_dma_load_c                          = 0x00000200,
-  regk_dma_load_c_n                        = 0x00000280,
-  regk_dma_load_c_next                     = 0x00000240,
-  regk_dma_load_d                          = 0x00000140,
-  regk_dma_load_g                          = 0x00000300,
-  regk_dma_load_g_down                     = 0x000003c0,
-  regk_dma_load_g_next                     = 0x00000340,
-  regk_dma_load_g_up                       = 0x00000380,
-  regk_dma_next_en                         = 0x00000010,
-  regk_dma_next_pkt                        = 0x00000010,
-  regk_dma_no                              = 0x00000000,
-  regk_dma_only_at_wait                    = 0x00000000,
-  regk_dma_restore                         = 0x00000020,
-  regk_dma_rst                             = 0x00000001,
-  regk_dma_running                         = 0x00000004,
-  regk_dma_rw_cfg_default                  = 0x00000000,
-  regk_dma_rw_cmd_default                  = 0x00000000,
-  regk_dma_rw_intr_mask_default            = 0x00000000,
-  regk_dma_rw_stat_default                 = 0x00000101,
-  regk_dma_rw_stream_cmd_default           = 0x00000000,
-  regk_dma_save_down                       = 0x00000020,
-  regk_dma_save_up                         = 0x00000020,
-  regk_dma_set_reg                         = 0x00000050,
-  regk_dma_set_w_size1                     = 0x00000190,
-  regk_dma_set_w_size2                     = 0x000001a0,
-  regk_dma_set_w_size4                     = 0x000001c0,
-  regk_dma_stopped                         = 0x00000002,
-  regk_dma_store_c                         = 0x00000002,
-  regk_dma_store_descr                     = 0x00000000,
-  regk_dma_store_g                         = 0x00000004,
-  regk_dma_store_md                        = 0x00000001,
-  regk_dma_sw                              = 0x00000008,
-  regk_dma_update_down                     = 0x00000020,
-  regk_dma_yes                             = 0x00000001
-};
-
-enum dma_ch_state
-{
-    RST = 1,
-    STOPPED = 2,
-    RUNNING = 4
-};
-
-struct fs_dma_channel
-{
-    qemu_irq irq;
-    struct etraxfs_dma_client *client;
-
-    /* Internal status.  */
-    int stream_cmd_src;
-    enum dma_ch_state state;
-
-    unsigned int input : 1;
-    unsigned int eol : 1;
-
-    struct dma_descr_group current_g;
-    struct dma_descr_context current_c;
-    struct dma_descr_data current_d;
-
-    /* Control registers.  */
-    uint32_t regs[DMA_REG_MAX];
-};
-
-struct fs_dma_ctrl
-{
-    MemoryRegion mmio;
-    int nr_channels;
-    struct fs_dma_channel *channels;
-
-    QEMUBH *bh;
-};
-
-static void DMA_run(void *opaque);
-static int channel_out_run(struct fs_dma_ctrl *ctrl, int c);
-
-static inline uint32_t channel_reg(struct fs_dma_ctrl *ctrl, int c, int reg)
-{
-    return ctrl->channels[c].regs[reg];
-}
-
-static inline int channel_stopped(struct fs_dma_ctrl *ctrl, int c)
-{
-    return channel_reg(ctrl, c, RW_CFG) & 2;
-}
-
-static inline int channel_en(struct fs_dma_ctrl *ctrl, int c)
-{
-    return (channel_reg(ctrl, c, RW_CFG) & 1)
-            && ctrl->channels[c].client;
-}
-
-static inline int fs_channel(hwaddr addr)
-{
-    /* Every channel has a 0x2000 ctrl register map.  */
-    return addr >> 13;
-}
-
-#ifdef USE_THIS_DEAD_CODE
-static void channel_load_g(struct fs_dma_ctrl *ctrl, int c)
-{
-    hwaddr addr = channel_reg(ctrl, c, RW_GROUP);
-
-    /* Load and decode. FIXME: handle endianness.  */
-    cpu_physical_memory_read(addr, &ctrl->channels[c].current_g,
-                             sizeof(ctrl->channels[c].current_g));
-}
-
-static void dump_c(int ch, struct dma_descr_context *c)
-{
-    printf("%s ch=%d\n", __func__, ch);
-    printf("next=%x\n", c->next);
-    printf("saved_data=%x\n", c->saved_data);
-    printf("saved_data_buf=%x\n", c->saved_data_buf);
-    printf("eol=%x\n", (uint32_t) c->eol);
-}
-
-static void dump_d(int ch, struct dma_descr_data *d)
-{
-    printf("%s ch=%d\n", __func__, ch);
-    printf("next=%x\n", d->next);
-    printf("buf=%x\n", d->buf);
-    printf("after=%x\n", d->after);
-    printf("intr=%x\n", (uint32_t) d->intr);
-    printf("out_eop=%x\n", (uint32_t) d->out_eop);
-    printf("in_eop=%x\n", (uint32_t) d->in_eop);
-    printf("eol=%x\n", (uint32_t) d->eol);
-}
-#endif
-
-static void channel_load_c(struct fs_dma_ctrl *ctrl, int c)
-{
-    hwaddr addr = channel_reg(ctrl, c, RW_GROUP_DOWN);
-
-    /* Load and decode. FIXME: handle endianness.  */
-    cpu_physical_memory_read(addr, &ctrl->channels[c].current_c,
-                             sizeof(ctrl->channels[c].current_c));
-
-    D(dump_c(c, &ctrl->channels[c].current_c));
-    /* I guess this should update the current pos.  */
-    ctrl->channels[c].regs[RW_SAVED_DATA] =
-        (uint32_t)(unsigned long)ctrl->channels[c].current_c.saved_data;
-    ctrl->channels[c].regs[RW_SAVED_DATA_BUF] =
-        (uint32_t)(unsigned long)ctrl->channels[c].current_c.saved_data_buf;
-}
-
-static void channel_load_d(struct fs_dma_ctrl *ctrl, int c)
-{
-    hwaddr addr = channel_reg(ctrl, c, RW_SAVED_DATA);
-
-    /* Load and decode. FIXME: handle endianness.  */
-    D(printf("%s ch=%d addr=" HWADDR_FMT_plx "\n", __func__, c, addr));
-    cpu_physical_memory_read(addr, &ctrl->channels[c].current_d,
-                             sizeof(ctrl->channels[c].current_d));
-
-    D(dump_d(c, &ctrl->channels[c].current_d));
-    ctrl->channels[c].regs[RW_DATA] = addr;
-}
-
-static void channel_store_c(struct fs_dma_ctrl *ctrl, int c)
-{
-    hwaddr addr = channel_reg(ctrl, c, RW_GROUP_DOWN);
-
-    /* Encode and store. FIXME: handle endianness.  */
-    D(printf("%s ch=%d addr=" HWADDR_FMT_plx "\n", __func__, c, addr));
-    D(dump_d(c, &ctrl->channels[c].current_d));
-    cpu_physical_memory_write(addr, &ctrl->channels[c].current_c,
-                              sizeof(ctrl->channels[c].current_c));
-}
-
-static void channel_store_d(struct fs_dma_ctrl *ctrl, int c)
-{
-    hwaddr addr = channel_reg(ctrl, c, RW_SAVED_DATA);
-
-    /* Encode and store. FIXME: handle endianness.  */
-    D(printf("%s ch=%d addr=" HWADDR_FMT_plx "\n", __func__, c, addr));
-    cpu_physical_memory_write(addr, &ctrl->channels[c].current_d,
-                              sizeof(ctrl->channels[c].current_d));
-}
-
-static inline void channel_stop(struct fs_dma_ctrl *ctrl, int c)
-{
-    /* FIXME:  */
-}
-
-static inline void channel_start(struct fs_dma_ctrl *ctrl, int c)
-{
-    if (ctrl->channels[c].client)
-    {
-        ctrl->channels[c].eol = 0;
-        ctrl->channels[c].state = RUNNING;
-        if (!ctrl->channels[c].input)
-            channel_out_run(ctrl, c);
-    } else
-        printf("WARNING: starting DMA ch %d with no client\n", c);
-
-    qemu_bh_schedule_idle(ctrl->bh);
-}
-
-static void channel_continue(struct fs_dma_ctrl *ctrl, int c)
-{
-    if (!channel_en(ctrl, c)
-        || channel_stopped(ctrl, c)
-        || ctrl->channels[c].state != RUNNING
-        /* Only reload the current data descriptor if it has eol set.  */
-        || !ctrl->channels[c].current_d.eol) {
-        D(printf("continue failed ch=%d state=%d stopped=%d en=%d eol=%d\n",
-                 c, ctrl->channels[c].state,
-                 channel_stopped(ctrl, c),
-                 channel_en(ctrl,c),
-                 ctrl->channels[c].eol));
-        D(dump_d(c, &ctrl->channels[c].current_d));
-        return;
-    }
-
-    /* Reload the current descriptor.  */
-    channel_load_d(ctrl, c);
-
-    /* If the current descriptor cleared the eol flag and we had already
-       reached eol state, do the continue.  */
-    if (!ctrl->channels[c].current_d.eol && ctrl->channels[c].eol) {
-        D(printf("continue %d ok %x\n", c,
-                 ctrl->channels[c].current_d.next));
-        ctrl->channels[c].regs[RW_SAVED_DATA] =
-            (uint32_t)(unsigned long)ctrl->channels[c].current_d.next;
-        channel_load_d(ctrl, c);
-        ctrl->channels[c].regs[RW_SAVED_DATA_BUF] =
-            (uint32_t)(unsigned long)ctrl->channels[c].current_d.buf;
-
-        channel_start(ctrl, c);
-    }
-    ctrl->channels[c].regs[RW_SAVED_DATA_BUF] =
-        (uint32_t)(unsigned long)ctrl->channels[c].current_d.buf;
-}
-
-static void channel_stream_cmd(struct fs_dma_ctrl *ctrl, int c, uint32_t v)
-{
-    unsigned int cmd = v & ((1 << 10) - 1);
-
-    D(printf("%s ch=%d cmd=%x\n",
-             __func__, c, cmd));
-    if (cmd & regk_dma_load_d) {
-        channel_load_d(ctrl, c);
-        if (cmd & regk_dma_burst)
-            channel_start(ctrl, c);
-    }
-
-    if (cmd & regk_dma_load_c) {
-        channel_load_c(ctrl, c);
-    }
-}
-
-static void channel_update_irq(struct fs_dma_ctrl *ctrl, int c)
-{
-    D(printf("%s %d\n", __func__, c));
-    ctrl->channels[c].regs[R_INTR] &=
-        ~(ctrl->channels[c].regs[RW_ACK_INTR]);
-
-    ctrl->channels[c].regs[R_MASKED_INTR] =
-        ctrl->channels[c].regs[R_INTR]
-        & ctrl->channels[c].regs[RW_INTR_MASK];
-
-    D(printf("%s: chan=%d masked_intr=%x\n", __func__,
-             c,
-             ctrl->channels[c].regs[R_MASKED_INTR]));
-
-    qemu_set_irq(ctrl->channels[c].irq,
-                 !!ctrl->channels[c].regs[R_MASKED_INTR]);
-}
-
-static int channel_out_run(struct fs_dma_ctrl *ctrl, int c)
-{
-    uint32_t len;
-    uint32_t saved_data_buf;
-    unsigned char buf[2 * 1024];
-
-    struct dma_context_metadata meta;
-    bool send_context = true;
-
-    if (ctrl->channels[c].eol)
-        return 0;
-
-    do {
-        bool out_eop;
-        D(printf("ch=%d buf=%x after=%x\n",
-                 c,
-                 (uint32_t)ctrl->channels[c].current_d.buf,
-                 (uint32_t)ctrl->channels[c].current_d.after));
-
-        if (send_context) {
-            if (ctrl->channels[c].client->client.metadata_push) {
-                meta.metadata = ctrl->channels[c].current_d.md;
-                ctrl->channels[c].client->client.metadata_push(
-                    ctrl->channels[c].client->client.opaque,
-                    &meta);
-            }
-            send_context = false;
-        }
-
-        channel_load_d(ctrl, c);
-        saved_data_buf = channel_reg(ctrl, c, RW_SAVED_DATA_BUF);
-        len = (uint32_t)(unsigned long)
-            ctrl->channels[c].current_d.after;
-        len -= saved_data_buf;
-
-        if (len > sizeof buf)
-            len = sizeof buf;
-        cpu_physical_memory_read (saved_data_buf, buf, len);
-
-        out_eop = ((saved_data_buf + len) ==
-                   ctrl->channels[c].current_d.after) &&
-                   ctrl->channels[c].current_d.out_eop;
-
-        D(printf("channel %d pushes %x %u bytes eop=%u\n", c,
-                 saved_data_buf, len, out_eop));
-
-        if (ctrl->channels[c].client->client.push) {
-            if (len > 0) {
-                ctrl->channels[c].client->client.push(
-                    ctrl->channels[c].client->client.opaque,
-                    buf, len, out_eop);
-            }
-        } else {
-            printf("WARNING: DMA ch%d dataloss,"
-                   " no attached client.\n", c);
-        }
-
-        saved_data_buf += len;
-
-        if (saved_data_buf == (uint32_t)(unsigned long)
-                ctrl->channels[c].current_d.after) {
-            /* Done. Step to next.  */
-            if (ctrl->channels[c].current_d.out_eop) {
-                send_context = true;
-            }
-            if (ctrl->channels[c].current_d.intr) {
-                /* data intr.  */
-                D(printf("signal intr %d eol=%d\n",
-                         len, ctrl->channels[c].current_d.eol));
-                ctrl->channels[c].regs[R_INTR] |= (1 << 2);
-                channel_update_irq(ctrl, c);
-            }
-            channel_store_d(ctrl, c);
-            if (ctrl->channels[c].current_d.eol) {
-                D(printf("channel %d EOL\n", c));
-                ctrl->channels[c].eol = 1;
-
-                /* Mark the context as disabled.  */
-                ctrl->channels[c].current_c.dis = 1;
-                channel_store_c(ctrl, c);
-
-                channel_stop(ctrl, c);
-            } else {
-                ctrl->channels[c].regs[RW_SAVED_DATA] =
-                    (uint32_t)(unsigned long)ctrl->
-                        channels[c].current_d.next;
-                /* Load new descriptor.  */
-                channel_load_d(ctrl, c);
-                saved_data_buf = (uint32_t)(unsigned long)
-                    ctrl->channels[c].current_d.buf;
-            }
-
-            ctrl->channels[c].regs[RW_SAVED_DATA_BUF] =
-                            saved_data_buf;
-            D(dump_d(c, &ctrl->channels[c].current_d));
-        }
-        ctrl->channels[c].regs[RW_SAVED_DATA_BUF] = saved_data_buf;
-    } while (!ctrl->channels[c].eol);
-    return 1;
-}
-
-static int channel_in_process(struct fs_dma_ctrl *ctrl, int c, 
-                              unsigned char *buf, int buflen, int eop)
-{
-    uint32_t len;
-    uint32_t saved_data_buf;
-
-    if (ctrl->channels[c].eol == 1)
-        return 0;
-
-    channel_load_d(ctrl, c);
-    saved_data_buf = channel_reg(ctrl, c, RW_SAVED_DATA_BUF);
-    len = (uint32_t)(unsigned long)ctrl->channels[c].current_d.after;
-    len -= saved_data_buf;
-
-    if (len > buflen)
-        len = buflen;
-
-    cpu_physical_memory_write (saved_data_buf, buf, len);
-    saved_data_buf += len;
-
-    if (saved_data_buf ==
-        (uint32_t)(unsigned long)ctrl->channels[c].current_d.after
-        || eop) {
-        uint32_t r_intr = ctrl->channels[c].regs[R_INTR];
-
-        D(printf("in dscr end len=%d\n",
-                 ctrl->channels[c].current_d.after
-                 - ctrl->channels[c].current_d.buf));
-        ctrl->channels[c].current_d.after = saved_data_buf;
-
-        /* Done. Step to next.  */
-        if (ctrl->channels[c].current_d.intr) {
-            /* TODO: signal eop to the client.  */
-            /* data intr.  */
-            ctrl->channels[c].regs[R_INTR] |= 3;
-        }
-        if (eop) {
-            ctrl->channels[c].current_d.in_eop = 1;
-            ctrl->channels[c].regs[R_INTR] |= 8;
-        }
-        if (r_intr != ctrl->channels[c].regs[R_INTR])
-            channel_update_irq(ctrl, c);
-
-        channel_store_d(ctrl, c);
-        D(dump_d(c, &ctrl->channels[c].current_d));
-
-        if (ctrl->channels[c].current_d.eol) {
-            D(printf("channel %d EOL\n", c));
-            ctrl->channels[c].eol = 1;
-
-            /* Mark the context as disabled.  */
-            ctrl->channels[c].current_c.dis = 1;
-            channel_store_c(ctrl, c);
-
-            channel_stop(ctrl, c);
-        } else {
-            ctrl->channels[c].regs[RW_SAVED_DATA] =
-                (uint32_t)(unsigned long)ctrl->
-                    channels[c].current_d.next;
-            /* Load new descriptor.  */
-            channel_load_d(ctrl, c);
-            saved_data_buf = (uint32_t)(unsigned long)
-                ctrl->channels[c].current_d.buf;
-        }
-    }
-
-    ctrl->channels[c].regs[RW_SAVED_DATA_BUF] = saved_data_buf;
-    return len;
-}
-
-static inline int channel_in_run(struct fs_dma_ctrl *ctrl, int c)
-{
-    if (ctrl->channels[c].client->client.pull) {
-        ctrl->channels[c].client->client.pull(
-            ctrl->channels[c].client->client.opaque);
-        return 1;
-    } else
-        return 0;
-}
-
-static uint32_t dma_rinvalid (void *opaque, hwaddr addr)
-{
-    hw_error("Unsupported short raccess. reg=" HWADDR_FMT_plx "\n", addr);
-    return 0;
-}
-
-static uint64_t
-dma_read(void *opaque, hwaddr addr, unsigned int size)
-{
-    struct fs_dma_ctrl *ctrl = opaque;
-    int c;
-    uint32_t r = 0;
-
-    if (size != 4) {
-        dma_rinvalid(opaque, addr);
-    }
-
-    /* Make addr relative to this channel and bounded to nr regs.  */
-    c = fs_channel(addr);
-    addr &= 0xff;
-    addr >>= 2;
-    switch (addr)
-    {
-    case RW_STAT:
-        r = ctrl->channels[c].state & 7;
-        r |= ctrl->channels[c].eol << 5;
-        r |= ctrl->channels[c].stream_cmd_src << 8;
-        break;
-
-    default:
-        r = ctrl->channels[c].regs[addr];
-        D(printf("%s c=%d addr=" HWADDR_FMT_plx "\n",
-                 __func__, c, addr));
-        break;
-    }
-    return r;
-}
-
-static void
-dma_winvalid (void *opaque, hwaddr addr, uint32_t value)
-{
-    hw_error("Unsupported short waccess. reg=" HWADDR_FMT_plx "\n", addr);
-}
-
-static void
-dma_update_state(struct fs_dma_ctrl *ctrl, int c)
-{
-    if (ctrl->channels[c].regs[RW_CFG] & 2)
-        ctrl->channels[c].state = STOPPED;
-    if (!(ctrl->channels[c].regs[RW_CFG] & 1))
-        ctrl->channels[c].state = RST;
-}
-
-static void
-dma_write(void *opaque, hwaddr addr,
-          uint64_t val64, unsigned int size)
-{
-    struct fs_dma_ctrl *ctrl = opaque;
-    uint32_t value = val64;
-    int c;
-
-    if (size != 4) {
-        dma_winvalid(opaque, addr, value);
-    }
-
-        /* Make addr relative to this channel and bounded to nr regs.  */
-    c = fs_channel(addr);
-    addr &= 0xff;
-    addr >>= 2;
-    switch (addr)
-    {
-    case RW_DATA:
-        ctrl->channels[c].regs[addr] = value;
-        break;
-
-    case RW_CFG:
-        ctrl->channels[c].regs[addr] = value;
-        dma_update_state(ctrl, c);
-        break;
-    case RW_CMD:
-        /* continue.  */
-        if (value & ~1)
-            printf("Invalid store to ch=%d RW_CMD %x\n",
-                   c, value);
-        ctrl->channels[c].regs[addr] = value;
-        channel_continue(ctrl, c);
-        break;
-
-    case RW_SAVED_DATA:
-    case RW_SAVED_DATA_BUF:
-    case RW_GROUP:
-    case RW_GROUP_DOWN:
-        ctrl->channels[c].regs[addr] = value;
-        break;
-
-    case RW_ACK_INTR:
-    case RW_INTR_MASK:
-        ctrl->channels[c].regs[addr] = value;
-        channel_update_irq(ctrl, c);
-        if (addr == RW_ACK_INTR)
-            ctrl->channels[c].regs[RW_ACK_INTR] = 0;
-        break;
-
-    case RW_STREAM_CMD:
-        if (value & ~1023)
-            printf("Invalid store to ch=%d "
-                   "RW_STREAMCMD %x\n",
-                   c, value);
-        ctrl->channels[c].regs[addr] = value;
-        D(printf("stream_cmd ch=%d\n", c));
-        channel_stream_cmd(ctrl, c, value);
-        break;
-
-    default:
-        D(printf("%s c=%d " HWADDR_FMT_plx "\n",
-                 __func__, c, addr));
-        break;
-    }
-}
-
-static const MemoryRegionOps dma_ops = {
-    .read = dma_read,
-    .write = dma_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 4
-    }
-};
-
-static int etraxfs_dmac_run(void *opaque)
-{
-    struct fs_dma_ctrl *ctrl = opaque;
-    int i;
-    int p = 0;
-
-    for (i = 0;
-         i < ctrl->nr_channels;
-         i++)
-    {
-        if (ctrl->channels[i].state == RUNNING)
-        {
-            if (ctrl->channels[i].input) {
-                p += channel_in_run(ctrl, i);
-            } else {
-                p += channel_out_run(ctrl, i);
-            }
-        }
-    }
-    return p;
-}
-
-int etraxfs_dmac_input(struct etraxfs_dma_client *client, 
-                       void *buf, int len, int eop)
-{
-    return channel_in_process(client->ctrl, client->channel,
-                              buf, len, eop);
-}
-
-/* Connect an IRQ line with a channel.  */
-void etraxfs_dmac_connect(void *opaque, int c, qemu_irq *line, int input)
-{
-    struct fs_dma_ctrl *ctrl = opaque;
-    ctrl->channels[c].irq = *line;
-    ctrl->channels[c].input = input;
-}
-
-void etraxfs_dmac_connect_client(void *opaque, int c, 
-                                 struct etraxfs_dma_client *cl)
-{
-    struct fs_dma_ctrl *ctrl = opaque;
-    cl->ctrl = ctrl;
-    cl->channel = c;
-    ctrl->channels[c].client = cl;
-}
-
-
-static void DMA_run(void *opaque)
-{
-    struct fs_dma_ctrl *etraxfs_dmac = opaque;
-    int p = 1;
-
-    if (runstate_is_running())
-        p = etraxfs_dmac_run(etraxfs_dmac);
-
-    if (p)
-        qemu_bh_schedule_idle(etraxfs_dmac->bh);
-}
-
-void *etraxfs_dmac_init(hwaddr base, int nr_channels)
-{
-    struct fs_dma_ctrl *ctrl = NULL;
-
-    ctrl = g_malloc0(sizeof *ctrl);
-
-    ctrl->bh = qemu_bh_new(DMA_run, ctrl);
-
-    ctrl->nr_channels = nr_channels;
-    ctrl->channels = g_malloc0(sizeof ctrl->channels[0] * nr_channels);
-
-    memory_region_init_io(&ctrl->mmio, NULL, &dma_ops, ctrl, "etraxfs-dma",
-                          nr_channels * 0x2000);
-    memory_region_add_subregion(get_system_memory(), base, &ctrl->mmio);
-
-    return ctrl;
-}
diff --git a/hw/dma/meson.build b/hw/dma/meson.build
index a96c1be2c8..dd7781961e 100644
--- a/hw/dma/meson.build
+++ b/hw/dma/meson.build
@@ -5,7 +5,6 @@ system_ss.add(when: 'CONFIG_I82374', if_true: files('i82374.c'))
 system_ss.add(when: 'CONFIG_I8257', if_true: files('i8257.c'))
 system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('xilinx_axidma.c'))
 system_ss.add(when: 'CONFIG_ZYNQ_DEVCFG', if_true: files('xlnx-zynq-devcfg.c'))
-system_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_dma.c'))
 system_ss.add(when: 'CONFIG_STP2000', if_true: files('sparc32_dma.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx_dpdma.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZDMA', if_true: files('xlnx-zdma.c'))
diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-scan/COMPONENTS.md
index 858190be09..5851df5b56 100644
--- a/scripts/coverity-scan/COMPONENTS.md
+++ b/scripts/coverity-scan/COMPONENTS.md
@@ -10,7 +10,7 @@ avr
   ~ .*/qemu((/include)?/hw/avr/.*|/target/avr/.*)
 
 cris
-  ~ .*/qemu((/include)?/hw/cris/.*|/target/cris/.*)
+  ~ .*/qemu(/hw/cris/.*|/target/cris/.*)
 
 hexagon-gen (component should be ignored in analysis)
   ~ .*/qemu(/target/hexagon/.*generated.*)
-- 
2.45.2


