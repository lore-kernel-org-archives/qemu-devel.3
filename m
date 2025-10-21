Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAAECCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJHM-0006mR-08; Tue, 21 Oct 2025 16:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJHJ-0006eM-Mg
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:21 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJHF-00019G-JS
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:21 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so3922469f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079694; x=1761684494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q+nGj84oA5Nf5HI4XwQsUpDQo9dIo/p1hzBMc/Uthic=;
 b=ghgZjyuvcFcF0/0LFBEMC3V3P5BXQIep9kX1rnXhty3WxiMKfOzk8JTcxVzkXD6n2l
 NRxztGreg6DMIhoL0ocbe5L61D+4c42D5vNOGPLSyBXzG9kNb3LIKApL+CKRm04Foe1I
 WheeOiOQnAgoJdmeVduuKag91ISrXzaS0Q/f2ECewaoOig3GuR5y8agQtqa3qQnjdfdw
 HurNQJrxhseOrycHUvzrkUjyxcOdq59SjnsyVqsxXfh+gZV4RbYpGgfD5HCYuuHqJGJh
 U+bYxcbDjbI2kRkrk+wIQGetVt0VCKPHE03pPsDJ+i03yNL9Re9qmoaXGn1yXYbRJnc7
 yLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079694; x=1761684494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q+nGj84oA5Nf5HI4XwQsUpDQo9dIo/p1hzBMc/Uthic=;
 b=Hm86biZQ/s9eNgcmpuTjrQWczgm2epUtgrCnHLjq0COHPcydQnjVUC/tRhv5aqScYG
 Hm5H1TAPfegv/Hw2VRpjmX5lz24SZuS9BKQQI70bXkDqK8WtOYpvq0c/TkoS+oqmGOmp
 EgE6UTa6VxOvUnOqzY30VaJcMKYPcdDiM96GY3FDxbnR3wkfnVR/QydZtF86mWZCHvNF
 j/rIx4LOT09XkTAp19zYp1q+PK5mSMLzKtc5pS7qDeZMi2gLOIzxRLlezQCtW6XtPlzl
 fzBX5ObTDugbpWhalfJQ0Uyx19SUHzkiTwh/j3RwWCZ4n6bCQA4Y9fJqAEbXI/bk5/b2
 Skww==
X-Gm-Message-State: AOJu0Yx7m3P5jkPf1R41fvdxjBI6/eAYKU2VI3YUxKSTVniB5iNFoOAz
 EZ3S6fvJ06tWE9UBH46B5lw2YYGXUG+2+poo4xQ+nnu7ZXCIFhbTV/T41zI8L8zbUIj7euRTZlG
 SCVaKIIw=
X-Gm-Gg: ASbGncsdOzdA2WIAKYxKtAD8IItfcyuEuipAowgCrlkYf/xvkxP8uFlkuZrr+rG6QJs
 1LdeLh2iGucLHSe7Vcma78ywzwhXbTpsIYMZQGRTMiiB+HNsM+kmNvokxLWpXON9LLbFLvsatp+
 a3rdhCUM9NVLV9Q8d0+HAxhPb6fjdnOPFU+aoaGAy4+fer7YPhWdUyFb19+B2yEO+H2g1AoSjV4
 Jn79bskE6UmtqFPKUF5TIkNGg06YttDnEWvsT++Bou0P/85i+3tprdlFWooDuAAWsnfdL/ygMBG
 H9TtaDugjj4UP9thT4yth+FuBwAOKxmacEZRUAkY4XshH0Hzic98BMZXkFXqjrI7vcdAeBSDVPB
 Daxr1wHOc0TAjqos8jUFxCb65RF1DFCCjAvDFR1arl2oqk3UShG4vFaF9cdP3yxRRyqBBFlTWvA
 YTusJPi+cjhdmMeFjyy1uij3BDspRpMoREKnaMoRacbXvyW1laOQ==
X-Google-Smtp-Source: AGHT+IHHbxFhLgwcCn6aezB1693narYiwd2irD1vYqde0u/HTlK17e1WmlBn706iGD4kVPiO0Wy+Yw==
X-Received: by 2002:a05:6000:1884:b0:3e5:394d:10bb with SMTP id
 ffacd0b85a97d-42704defebdmr12687402f8f.41.1761079694524; 
 Tue, 21 Oct 2025 13:48:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b9fa8sm22364672f8f.38.2025.10.21.13.48.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:48:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/45] hw/openrisc/openrisc_sim: Avoid buffer overflow build
 error
Date: Tue, 21 Oct 2025 22:46:29 +0200
Message-ID: <20251021204700.56072-16-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Resolves this build breakage (which is actually a false-positive)

../hw/openrisc/openrisc_sim.c: In function ‘openrisc_sim_init’:
../hw/openrisc/openrisc_sim.c:284:45: error: ‘__builtin___snprintf_chk’ output may be truncated before the last format character [-Werror=format-truncation=]
     snprintf(alias, sizeof(alias), "serial%d", uart_idx);
                                             ^
In file included from /usr/include/stdio.h:964:0,
                 from /data/qemu/include/qemu/osdep.h:114,
                 from ../hw/openrisc/openrisc_sim.c:21:
/usr/include/bits/stdio2.h:54:10: note: ‘__builtin___snprintf_chk’ output between 8 and 9 bytes into a destination of size 8
   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __glibc_objsize (__s), __fmt,
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __va_arg_pack ());
        ~~~~~~~~~~~~~~~~~

by using a modern, more robust allocation pattern.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <298bd904-1ee9-439e-8220-7a24e0952861@siemens.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/openrisc/openrisc_sim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 880c8ebbb8b..b7d9cdd9007 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -247,10 +247,10 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
                                      OpenRISCCPU *cpus[], int irq_pin,
                                      int uart_idx)
 {
+    g_autofree char *alias = g_strdup_printf("serial%d", uart_idx);
     void *fdt = state->fdt;
     char *nodename;
     qemu_irq serial_irq;
-    char alias[sizeof("serial0")];
     int i;
 
     if (num_cpus > 1) {
@@ -281,7 +281,6 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
         /* The /chosen node is created during fdt creation. */
         qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
     }
-    snprintf(alias, sizeof(alias), "serial%d", uart_idx);
     qemu_fdt_setprop_string(fdt, "/aliases", alias, nodename);
 
     g_free(nodename);
-- 
2.51.0


