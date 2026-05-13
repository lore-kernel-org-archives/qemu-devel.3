Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EF3CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 10:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN7Gx-0003ka-6q; Wed, 13 May 2026 06:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wN7FZ-00038D-66
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:55:41 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wN7FS-0001Od-Hr
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:55:36 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so70483625e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 03:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778669727; x=1779274527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O2EpYJqPevmVbNmKK1CIfcbHlQchiIQzYHZXdo1sFgo=;
 b=jYSb5phDyVZv/Szw0Pal1B5osvqNpPEckHi5SV7C9GM3BLAthJabDizSxwLZDE8wEZ
 jUzO85NGn7bFHo4K/tqhWnpSRvsjyzmy24MZtP3u3h91wRMPTy3uQm1A2MyBVudwuaf/
 v+ohy5hRPIVXXjtkpVGNKP5nkJmycO6jpOljEtUNEiHILIpJnusjXXKhGgnIG/DW2BNX
 lPy5r7Qkjm8x567egNaewT//8senE8e9g5PZO0tijwDICNGr1ZqfXhHbxYxYNnY8o8nZ
 wf/BWaV/GjRZeWWCWIrCGKfsKOgcsgSvHDWLzMnteSuoRBkWQ9F2LNB7CH6LVz8mbkDd
 C+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778669727; x=1779274527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O2EpYJqPevmVbNmKK1CIfcbHlQchiIQzYHZXdo1sFgo=;
 b=oNTnp95vcHAvJl4vj/qKR1p/EnvIPtBv+NxNerJeaWlT8fVxaguvmWVWB5xEw+NZIf
 pIrrcJLK7C3t6aDLsNtc0oZoXdKZkg3IbH1kaysMFirv01WFipBi1c5gbOVVzSIbENU/
 KInku25Wi6jAyKwltVZ6kk6DGB8y6rvSdEG0YOaey+viHmRxFT9ylpm35sgaJx4laBHu
 cFtbsCHIY43v+aS6VgPltGoxHhz/XHlPkhztuwlBO4Z7/4Nfnsp+BJFWZJSi24AnyaK0
 jZxe4ywy1VoPT8Dw5Mrmbe28cety1KGe0F58YmWvHuc8WlCrEPPhTtOoBEs/NZXprvGZ
 DKnQ==
X-Gm-Message-State: AOJu0YzRHd0YLjGJZB08nQaxz3aXR4DB6n0fH2SWzunFPfTap+4Vm6sS
 a6EuaYeyUXDsnNIzjEUccXs26BE3m6iW4kNIMmqLhY9ngcq16SODhj4UXfNnMcvi
X-Gm-Gg: Acq92OFpDNM10mtRtR9epUep4NLEaBw2RwoQwwDP/njBDN1SOMiHD4vyCMeVYq2GzjR
 u+1WHfImM0eU5oumC/y598lkoxvdUq3/l6Gm0dciXRLh+7hldJfliWTZazVLddkAm8DWkb8nfWI
 cEadOUZW+KY7I0uQmBV9HW6WcqauFrnOCC12jvuKamXI76FerKQdlePxL5nb9o2meXQF0+2bxPZ
 l7fNpRys20cjzqVM1JTW8Z3KVimHM8yHq1gkZhrdMYJrrJrw6SFmUlt5Ow8EVshx5jvlmy0XNJl
 mK8IDmTlKIcOKdIAdWw1+X4wXnjcL3ec2sgCKphYaLVHSMlwmy+xeBl0GQZWf2+WL2CiZ0u9y1Q
 ZuBfKfXHCAk9LWrHJvli78kOZqXvljw6OZjeABUmO9K4WCfxENX3MfFMAKyfnxAbGJK8K0qqXcP
 CnqSM4cIWAzdFO7iSrPtYEGdX1hiUVZAIlZVnme96zh/Pe
X-Received: by 2002:a05:600c:8b12:b0:48e:978f:c45a with SMTP id
 5b1f17b1804b1-48fc9a3ba11mr43545795e9.19.1778669727341; 
 Wed, 13 May 2026 03:55:27 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.196])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f410d9fsm56062295e9.6.2026.05.13.03.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 03:55:26 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 YannickV <Y.Vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v6 06/15] hw/dma/zynq-devcfg: Simulate dummy PL reset
Date: Wed, 13 May 2026 12:55:08 +0200
Message-ID: <20260513105517.146706-7-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513105517.146706-1-corvin.koehne@gmail.com>
References: <20260513105517.146706-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x32a.google.com
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


