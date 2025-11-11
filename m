Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BFCCD1297
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 10:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIlck-0008SY-H0; Tue, 11 Nov 2025 05:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vIlcM-0007h1-Ms
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:28:55 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vIlcH-0000Gx-C9
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:28:54 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b7272012d30so746258966b.2
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 02:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762856923; x=1763461723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vn+HM/T5waAloUyWIY3zPXKh0OS7bknHuu3vLzdKJcI=;
 b=K1kJQNWMhpfMGwR+9hJ02v5pLwXOyLvvCTpn5gqLAnmFimjGkr5Ey9YZGeCJRXAFOe
 YmDcIMeqhhG/0djVLNANvquYc8lL90SSktUhGKKRoPuRRRd3evmReWRpKi461Rv50SBK
 BXsXSUDERQ/o7Fm8lG2bEqNf7oyjPqSlJbCerpHCaIQ5iInsLs2VG1VT3KbgenpmWsKR
 pSICgDBUJ4R7kw1L0zc56mX7BnIujyr0wayvh97r1nUhCXBvh/jrkFgmFkdpwHWxNFdO
 ZCloCzIP3nVyWX2JB2KxX4js7PN49c2mUJMH8vUIY+D0LIli8AMiqPkUwj1lvNZYdclC
 rhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762856923; x=1763461723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vn+HM/T5waAloUyWIY3zPXKh0OS7bknHuu3vLzdKJcI=;
 b=CnZ5u9sXUGiHNFjIxSTTQkDVfLVnW5sBfvTnh9cQMWdSArEgnrLCNgyQnCczLzhEJy
 qzC5sf1X8CJ69bjVXP87H8y0MijEmz+5qXX0KA0yEgXjhkSKAx3Mh3AUQFz1wEjfQDQO
 MWqJxz18melB4YsmNUctnyJCMYT0pB7Q2zU451C85fopLGCXeH0SJ25XMk1D6ZsM5gWL
 GEWJLasA2lfbKxnVzHvVwXrSuJGm1tYDgHLTKf/lTeF3whr2NFQbcQWfo+Yr4jcO39Fz
 KROW/DK0z1Ir+VAwwYy1YQaf5dLjNixufra01qWruyVH1KxEtQQIqtPgKWtmbVhfJimZ
 kE0Q==
X-Gm-Message-State: AOJu0Yy7oFrPTf475ZEtEa6LAyr8934YFR6pNyydkjjXM+IAK+Gmc7EU
 bvLiPPWK4l3NeSihsSooLzheaPiwyIB/tgQA/o4B5+Cs2EflE/6Icdq0URPgHGZp
X-Gm-Gg: ASbGncvr08OltKJCM4BF64FTadYTKr78zB7JScySaQK3giacRP815bHtwU0jKE39Nyz
 3U+B/IqPKseh4gQEEQxgVOU9aU3C9LlQFhsvWXHT81wLS9OXCOWI5Rd5s1QqSMGC8J3wZEBjK6w
 c+NXRIoPN9VnPtLTRnOM//8ZkkL0L7IHdfTf1yqY8wgq2HV/TVhusrFzI/upuWawPPPEgTXwj0i
 Hr3YaJCE+zF9zR4qtUaiFXP51cUbF2ETh2fjxn9MZ/HtzjfW7JQzAYCcKhhXMBOg3AhJTCQciJQ
 82fr5pes3QRWm9uEkqNBbJNOVfVue3ibc4BXyc2FFHL8+5oGXspbr6lGz0elZC34k313onXP63P
 ZrlXi2CM7fT6xfO2Xs7lkCQEGXWd4gmC99iHI8ZhFkZPWnJ23hMU9iPOyUcjCjUVgbo0p97AR7C
 jdIWxZZrH7DcOvfrAcKZ44hA==
X-Google-Smtp-Source: AGHT+IFxHG/MHFo6h3glWgObSFsrQ9zWMGFtGlj6hfJknM7/mDH6j9O9b9AWQ0S0f2BXyf/qmZdrrg==
X-Received: by 2002:a17:907:3e12:b0:b3c:bd91:28a4 with SMTP id
 a640c23a62f3a-b72e031c6a7mr1223198466b.28.1762856923369; 
 Tue, 11 Nov 2025 02:28:43 -0800 (PST)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc12:ce00:ae91:a1ff:fe8b:15a7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bdbd1ecfsm1290619366b.10.2025.11.11.02.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 02:28:43 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Kevin Wolf <kwolf@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 YannickV <Y.Vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v4 06/15] hw/dma/zynq-devcfg: Simulate dummy PL reset
Date: Tue, 11 Nov 2025 11:28:27 +0100
Message-ID: <20251111102836.212535-7-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111102836.212535-1-corvin.koehne@gmail.com>
References: <20251111102836.212535-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
index 28b3cd2902..53bcf49140 100644
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


