Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3285CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsV6-0000yH-Rt; Mon, 18 May 2026 03:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUN-0000g2-DO
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:17 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUL-0000FL-BT
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:10 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so10760745e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779089647; x=1779694447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O2EpYJqPevmVbNmKK1CIfcbHlQchiIQzYHZXdo1sFgo=;
 b=oAAOLxejS8BA6/4NYAHc73thPok5pxYUtgLlyGktW9uXWGDn8kD53Fu/ZQEH9Rcnly
 PUjhTFlRwOmG9OCpZXWhRF2kEmdzx5vhvuek/kyuS9KPY5wc0Qwnh3RlaoSH9W5QRC5p
 B1tPOU7OTSzpmLiVpf1Trm9IhwJNFOfdc5F4Zm1nEf/Aby1nnWSagJ0+iykWbOT5bcdk
 xJlHXgmj9tZpH2f3Sn7FwJj+uZoL9ssjUlx+9usN3fFNSPnAjSDkDCjXQb6opKhQwniS
 rjbrYXUSKrfUiyFN7JZOIuTwyzSAtpsk7+4Dml9ah8/37ty7JqZG4TaX55zshg8Z39y/
 Oy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779089647; x=1779694447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O2EpYJqPevmVbNmKK1CIfcbHlQchiIQzYHZXdo1sFgo=;
 b=hOfiH8V7rDBKSDJH/WYE9EdAEV6LdU4XclM+DS8tsG6Nq09baco/mVfBUiM6jkk0zJ
 fC/NuaRYVFhjuINQkhFPBzrmgAuWFdwjdhVnHP8qb/VtTePva0bIliwmyPkP7RFEnfc3
 FUMb44YtQD7EvLXXaUDaBxdoPpKM4a0I6FDloB5lYKlvqnxs1n9HvQHJ5xP7mjPilVxU
 Pghr9nez/TA9fZ1d6yhETWEbSemBXc6g0M3xSx/RSki01quBUWH592DqGFxnQRmlkJjB
 3UP3OHujOcVjZ6GgKW86Cxl/YrlBnuVj/MUehaOywkv4tzTUAlwOaasAuk7h0BsdoVVi
 /jjg==
X-Gm-Message-State: AOJu0YxgnzY5VSm6eZ9V/aOADlpPM8bIBd0kDKNdtfTtCtd4fY1wZgN0
 9lAessS2fDbzHIXX7QsNdcOM/REI4SL54aa6ptEbbPzviXYT5vNJKNEiSJjiZUfN
X-Gm-Gg: Acq92OHINtT0DApRosHExzMQ4fgLxf1qHoya40Gny4AAazxXBdlrl9Qk191bJoVOuDI
 szBC1UWgSinEtJeQmzlYHnlC6sweWecCnwdtGpY96UlcT9VOdxhp90cMK0pwycnt+VVAhe9/Lrl
 sy6+xvb4hfOoircblHlAX4f9egT876n6Se/bCcunwlMJNtA9MRuQiGmzTsbWpXjhN7b0jRm+e6f
 91uBNnkoYSn9QSRx8t3MaRczYnLIguRe9/9+xBJlXizxQpJdXzMlaUJD+kQxsNkAgRT05BdXDCQ
 OmBCWlXUfBfqSwtajIfo5WAdapuIx7M78X7mqCJQHRlE7Ap2wC1FIkeIHijbTD0iZROIVCtvyhu
 i6WRfdLjWDJQaRLVNZ+eXOEHvjaC2fvgw6BNNX8jVq7b6jSxSmT79q5g7fYqDzxxGb2LuatOsdn
 G/dEQ36gjaZpdfic6fPQBLY3M1CopGQ65CL/NtFhLuDukk3+lVt5+o2NqW
X-Received: by 2002:a05:600c:a309:b0:48e:8741:fd53 with SMTP id
 5b1f17b1804b1-48fe61f1e37mr165642415e9.15.1779089647327; 
 Mon, 18 May 2026 00:34:07 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc08:b284:85e6:f7f4:1a4a:4dfe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3b18fsm32590222f8f.11.2026.05.18.00.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 00:34:06 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yannick Vossen <Y.Vossen@beckhoff.com>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Corvin Koehne <C.Koehne@beckhoff.com>, qemu-block@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v7 04/16] hw/dma/zynq-devcfg: Simulate dummy PL reset
Date: Mon, 18 May 2026 09:33:49 +0200
Message-ID: <20260518073401.11279-5-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518073401.11279-1-corvin.koehne@gmail.com>
References: <20260518073401.11279-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x32f.google.com
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

From: YannickV <Y.Vossen@beckhoff.com>

Setting PCFG_PROG_B should reset the PL. After a reset PCFG_INIT
should indicate that the reset is finished successfully.

In order to add a MMIO-Device as part of the PL in the Zynq, the
reset logic must succeed. The PCFG_INIT flag is now set when the
PL reset is triggered by PCFG_PROG_B. Indicating the reset was
successful.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/dma/xlnx-zynq-devcfg.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 7370ab941f..6b1d96ff80 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -49,6 +49,7 @@
 
 REG32(CTRL, 0x00)
     FIELD(CTRL,     FORCE_RST,          31,  1) /* Not supported, wr ignored */
+    FIELD(CTRL,     PCFG_PROG_B,        30,  1)
     FIELD(CTRL,     PCAP_PR,            27,  1) /* Forced to 0 on bad unlock */
     FIELD(CTRL,     PCAP_MODE,          26,  1)
     FIELD(CTRL,     MULTIBOOT_EN,       24,  1)
@@ -116,6 +117,7 @@ REG32(STATUS, 0x14)
     FIELD(STATUS,   PSS_GTS_USR_B,      11,  1)
     FIELD(STATUS,   PSS_FST_CFG_B,      10,  1)
     FIELD(STATUS,   PSS_CFG_RESET_B,     5,  1)
+    FIELD(STATUS,   PCFG_INIT,           4,  1)
 
 REG32(DMA_SRC_ADDR, 0x18)
 REG32(DMA_DST_ADDR, 0x1C)
@@ -204,6 +206,13 @@ static uint64_t r_ctrl_pre_write(RegisterInfo *reg, uint64_t val)
             val |= lock_ctrl_map[i] & s->regs[R_CTRL];
         }
     }
+
+    if (FIELD_EX32(val, CTRL, PCFG_PROG_B)) {
+        s->regs[R_STATUS] |= R_STATUS_PCFG_INIT_MASK;
+    } else {
+        s->regs[R_STATUS] &= ~R_STATUS_PCFG_INIT_MASK;
+    }
+
     return val;
 }
 
-- 
2.47.3


