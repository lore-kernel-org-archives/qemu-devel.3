Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060A1CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 09:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umqJX-0003ey-Bq; Fri, 15 Aug 2025 05:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJQ-0003ZW-9s; Fri, 15 Aug 2025 05:01:24 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJO-0005h7-NO; Fri, 15 Aug 2025 05:01:24 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45a1b004a31so11459475e9.0; 
 Fri, 15 Aug 2025 02:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755248480; x=1755853280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jtpYVDYomfw3dnGGdJoGEMa8DBPeyARO/+gaVWAc1BE=;
 b=FukoOGcc+Gwbjobr3bKKq3OXfDndMDdtd135x1ieA3iT2UgzF22k++CLQETf/rY7uM
 SQuDp639NocIygpJE/IeSinjOJ4Yi5+TxlWaC1N5BuOkO+kiQ7GqciJ07CFUhLdP+BcW
 npacR946SuJHwzPOrMAstT8zfwU/C9zb/Hcj96pc4o8H3lBDiQ3At8yuo4yGefZBZyfX
 jLqztGzazZeWeFJZkRVoFa4y3q0FfqoSYJns7r1Ut96dEnqfg+KfXPTgxS3HCuA0pYZQ
 nX6B0tdBW9+aN6FyAu6KCTWHtn2HqEWtds5prJeBhSHBw29xBYzFsnyYkB8hQbFD7vR/
 V2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755248480; x=1755853280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jtpYVDYomfw3dnGGdJoGEMa8DBPeyARO/+gaVWAc1BE=;
 b=uPSWCVJgXNKeyzL79V5IKlt0J5mjT2Bn2bN/DMWM6lkvxj2RmEQiYZXRyb04vRJVBY
 YK+rN/triIeEO4S6Puf7XJx9gdfEDzfKZGfa7YZDnZV1am21q0Bz24RNs/q0qlr111y6
 XCCd6L1UqZFjUoirC45NESCK8Z5fMAoCLTZdo9EWFEOGLlASKvxNQ3ePgcXk/IZP5TIf
 8uKjc8JmSC/VoCiC57RxSYiSt2Vdi58d9N2oFCz9m025EXfo/otphSzx5yr469CkdNEw
 O8wOG9EbAO6sq1hq3ArnuUvrOOAuC8AHkzFnS1bOUxE6dFYZuwWWX8+NTpuOgjOrBs4H
 6log==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnJ3HGPaxwoxubWvj3Js68mQuzXWmYzttI6hST+Px9AHB+AmeNCQt5b8tVhQwB2NtIjOCYyYSl+ONt0g==@nongnu.org,
 AJvYcCVZKr0mjzyo7fexMuJCnuT4etQjEVZFZVTJRiPZCGm2lMS7y4elpegMsQO4ykuz7ICkToQwRdzfCg==@nongnu.org
X-Gm-Message-State: AOJu0YyD5Apsf+t5wfdKfTsukaD9xQbFbqvHSjeH6QloKT8mLUu0XILO
 K7ATZqnSfl7jR3+GdaDrSpphPn98+hGKrbm4iSvRoh2kV9p7LtmptauB7lg3ks87
X-Gm-Gg: ASbGncuuiCKmEELcayw7Hy1h+jw+r2xjkwvQkgP3v9QuGkvMm3fooONCwPOgvMzDEkY
 hLHH9WecDIiykOsqaNAlJ669x2hYsR0UXfj2HlMoE+b0NcdPniL5yet9qA6Bb40neqHAbmPaAn7
 LQyjWf5zfD94TggQ59Qwcmhmj+GcfzrQZ+tahF6aRy+npz+Uy3KpmO3yYDrNUWAHjuJifa/uVnL
 Rg+54nXowtrFMcOmnNTBKbDOTLSk0m5/tJ7yLkZgvxx6nJzWl46yxu3U6VEIEX71Ppp0bJ/dmTp
 DeUUnsfy3DySsjOe6Lttrp8EDR3u0AGdZUZD3ae4mNvgzYh2MY8qESmrmQab8M2BdUV15G8EniW
 1cI9g9xkv4b+9UU+25MVtSQIv+iGMWJJGcKMtDws6cABN2A==
X-Google-Smtp-Source: AGHT+IHg37ZTU1bIQKuC1ZNGfqPiGHwIWIZ7XHk104N7ANxeqdMht2r8FGG6C67rNbvHa1OFJGK8VA==
X-Received: by 2002:a05:600c:2e95:b0:45a:236a:23ba with SMTP id
 5b1f17b1804b1-45a236a2561mr3901325e9.22.1755248480256; 
 Fri, 15 Aug 2025 02:01:20 -0700 (PDT)
Received: from corvink-nb.beckhoff.com
 ([2001:9e8:dc31:6500:43b3:5eac:8d91:b512])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a22321a54sm10964045e9.18.2025.08.15.02.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 02:01:19 -0700 (PDT)
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
Subject: [PATCH v2 06/14] hw/dma/zynq-devcfg: Simulate dummy PL reset
Date: Fri, 15 Aug 2025 11:01:04 +0200
Message-ID: <20250815090113.141641-7-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815090113.141641-1-corvin.koehne@gmail.com>
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x32a.google.com
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

Setting PCFG_PROG_B should reset the PL. After a reset PCFG_INIT
should indicate that the reset is finished successfully.

In order to add a MMIO-Device as part of the PL in the Zynq, the
reset logic must succeed. The PCFG_INIT flag is now set when the
PL reset is triggered by PCFG_PROG_B. Indicating the reset was
successful.

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
---
 hw/dma/xlnx-zynq-devcfg.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 60ea351494..c699df6ad4 100644
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
2.50.1


