Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE016CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 09:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umqJU-0003by-DI; Fri, 15 Aug 2025 05:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJO-0003Xl-3G; Fri, 15 Aug 2025 05:01:22 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJM-0005ZS-9H; Fri, 15 Aug 2025 05:01:21 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3b9e4147690so1030022f8f.2; 
 Fri, 15 Aug 2025 02:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755248478; x=1755853278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oHXCGQU5OO8aBE2h0QkbdQ0ye/plLKhLf/VhqDOiQjI=;
 b=Uf7QLGobHN2Vp4Ii1xviWuLoF8UP4c8kYCix2iiNEzlrIk1OnwfILQEuRkYPHwjifT
 ktW4UPGBvytDHjNGxhCq7Wpgr9QUYTzmc7ABQ4Ad3rUA+2u/QTqN5Hi5DkvC/MRdA9IA
 T/1j6HaBbjr34dG4T2ntJXK8pQx5Wq749JKGb3F6C3qHBGnvXrbSoulmQahp1yGL7d/l
 GG9qJzUvK4Z48mK2r7REd8Gi0pPWwBL5U9UorLbnalkUXK+YqQh0jIqJ/uk+UfkM0Ql8
 3hbf9y8b1Uc4y3t0+ANdXkE0mwUj4Qm5IhM48lniM8SbKIKSRzQxNLIuPLbML9AQa/TQ
 uiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755248478; x=1755853278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oHXCGQU5OO8aBE2h0QkbdQ0ye/plLKhLf/VhqDOiQjI=;
 b=W3sVtNflKlVwXgFVaexqsi6lYJJh31pNNInGapHVnqS63A6MlKPKMdvZOt+nKF2ovb
 QaGQGhwPvNbCei+B4MeK3VA6gJsKW4pU/Vl712/vodZwF41gz7PFEZ8Bfc9YprfhEiSi
 OuNT1pFvwbnwI1EHkv2Z/ektjqCz0N9kTbWoQmWyprii04sHfzy/pL+9c45c7X3dGHp+
 /h65Y4X48T+DquqAq2IJevWSxUK1ahpDojsgud/53L0e6ZXfyMdskDL+CUCzEFNGgXst
 L1NKLQhlrKeDPZN7d4IVvEPGMi7m2GfqKqGBko24KfgSo0ocMa/KdcbHWzjKh+9QVK91
 xDCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5jhECCoJKEZ8FKDAxAzukd1aFynwikDsS23lUNvp6lEczSBQvwfSXCl+bymLUYHYrBSE4GMuGrg==@nongnu.org,
 AJvYcCVjef5OOuxXwU8qikk2IY3LyGk/88I4Em4W1gsShiBSxNa0hgZgcLSN7ItplDFkIFk9Whmy3mXZfWJQ6Q==@nongnu.org
X-Gm-Message-State: AOJu0YzKNl4diD0et4f6WjBliBGDEmzWNv6lL1uevk+cAVFTuQ3Y6ttg
 FKrH/7uKpJXEw2I6QiTtNGUQvtXjjweMMlDCNhcxUZE2mR/a8s8YFq8ec+SvRa2P
X-Gm-Gg: ASbGncuG3LQ7K/zP+TV2NumS33i131OQ3F+G6OAr0q0MNVk+bmMiS9RDXAsM22aN5DN
 CJnd3vDBKb9uMBDtzzUTyRZlDVX6qiDOND+J1ZomIMQZ0oZXlo0nfADinbVPOsKC781UVzvWOhR
 nrwx67PbNv2fxQhOxqjEPHZCD0PoSetIJWHqtj3l3zYp/KTuAJbAqzO5G8ROria0xHAJpH2LzdM
 w5ckTio54QfWWu97+HhygX+tx4A9kqyPh47a33YEgq8mRVtRrvF/t7KvhI+gdV92taaV3O5VGan
 L0EUJIk+Xk71N+wfubtcajTFICdfZDLCuljhmzNANUOIDsZevwJzld38zEUSt+WHZhYlOH1KKxB
 DnwfpeSg1GRHfTpJcSJEy3/uOw22qvThJo+N5l0bUHxZdzw36a8ahkzhG
X-Google-Smtp-Source: AGHT+IHoLAT1QdT56/FeoJ7FDYUPW53DA5mvX0R/ElVamyFxXFTQrWGrrUls7/gJK6ZTOELeSRMnaA==
X-Received: by 2002:a5d:5d0d:0:b0:391:3aaf:1d5f with SMTP id
 ffacd0b85a97d-3bb694ae1a4mr937724f8f.52.1755248477597; 
 Fri, 15 Aug 2025 02:01:17 -0700 (PDT)
Received: from corvink-nb.beckhoff.com
 ([2001:9e8:dc31:6500:43b3:5eac:8d91:b512])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a22321a54sm10964045e9.18.2025.08.15.02.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 02:01:17 -0700 (PDT)
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
 YannickV <Y.Vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v2 03/14] hw/dma/zynq-devcfg: Handle bitstream loading via DMA
 to 0xffffffff
Date: Fri, 15 Aug 2025 11:01:01 +0200
Message-ID: <20250815090113.141641-4-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815090113.141641-1-corvin.koehne@gmail.com>
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wr1-x42b.google.com
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

A DMA transfer to destination address `0xffffffff` should trigger a
bitstream load via the PCAP interface. Currently, this case is not
intercepted, causing loaders to enter an infinite loop when polling
the status register.

This commit adds a check for `0xffffffff` as the destination address.
If detected, the relevant status register bits (`DMA_DONE`,
`DMA_P_DONE`, and `PCFG_DONE`) are set to indicate a successful
bitstream load. If the address is different, the DMA transfer proceeds
as usual. A successful load is indicated but nothing is actually
done. Guests relying on FPGA functions are still known to fail.

This feature is required for the integration of the Beckhoff
CX7200 model.

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/dma/xlnx-zynq-devcfg.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 0fd0d23f57..b838c1c0d0 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -247,7 +247,14 @@ static uint64_t r_lock_pre_write(RegisterInfo *reg, uint64_t val)
 static void r_dma_dst_len_post_write(RegisterInfo *reg, uint64_t val)
 {
     XlnxZynqDevcfg *s = XLNX_ZYNQ_DEVCFG(reg->opaque);
-
+    if ((s->regs[R_DMA_DST_ADDR]) == 0xffffffff) {
+        DB_PRINT("bitstream loading detected\n");
+        s->regs[R_INT_STS] |= R_INT_STS_DMA_DONE_MASK |
+                                R_INT_STS_DMA_P_DONE_MASK |
+                                R_INT_STS_PCFG_DONE_MASK;
+        xlnx_zynq_devcfg_update_ixr(s);
+        return;
+    }
     s->dma_cmd_fifo[s->dma_cmd_fifo_num] = (XlnxZynqDevcfgDMACmd) {
             .src_addr = s->regs[R_DMA_SRC_ADDR] & ~0x3UL,
             .dest_addr = s->regs[R_DMA_DST_ADDR] & ~0x3UL,
-- 
2.50.1


