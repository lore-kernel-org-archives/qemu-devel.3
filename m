Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4BBC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 16:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shAbV-0007q4-Ca; Thu, 22 Aug 2024 12:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1shAb2-0006Oe-A1
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:23:36 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1shAat-0007Vo-1S
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:23:28 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3718cd91185so516968f8f.2
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 09:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724343805; x=1724948605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FMrNBgMym3Cry5MvqInQrTVyM5jytLXZKjA6eD9Kdw0=;
 b=Q+p9Lwfi2OXES0ynzLt026Yy5WChhXdWwZDbcGeTtQOqyrvQ3Vlu3XQCclVXAIHJT4
 0oLU24dvGaHdqYX5v+kO8xhUUUmdCjLAIoUJL9ruftOQ/W+IyEpaWE+adsH9Psut7gAM
 i2coiDFAM3rhLtM5lQ1LwjUwiiAFVRC5FPB36k2A0HTkBuB8ecDgHLLe7sM/13B1Efcc
 6/GbfdXWsZHHtdLoMhi9J14YFXW55VKV4s+Pm4a0rr2y91S9kxBEyGoXX6vf/c25Hf2N
 aSp8Dg2htMTzoP6L0ys1gdZEIKEEQeu2Oey3ienkxBBugBo28okQFWwp0LHoM81Os1Ep
 W1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724343805; x=1724948605;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FMrNBgMym3Cry5MvqInQrTVyM5jytLXZKjA6eD9Kdw0=;
 b=jn6TWYSXIZficxwyVUYmA1gDTIS6923S39vaUwvYSFYADF9xDbFSKaZwTsCr85gaNX
 of0rt6w8rK96F8qrSFRAVq00mpy0XVZzXcjXiGi6angLuJRUsf3keKh+vCSwuwmxzqf3
 sJvmqWjFd0Cr9C6yawvazngMYxhc1XVGdxcXwqz+da0zURw8pyvRI1p/srXL+mqdCKFr
 NaVo2p55fwzhYuPUGyT5iNiaUK5VLAJMLWD8OULGcZlk975y0M5Rpxg13fHjMHKdQBBk
 mfpEEJ8QS1GkTHlN3llAdl2K5VlkssS1Lhq7B7ZnSVw2Xwz/JUzteDeT19OrST6f2Wo1
 p7kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyOVthqaGXpppJujJHrEQbQGu83JhkP2k+oNWQKYnsuF5OHk3D+bj0ll+TV6hK8K5RncSihElGemLy@nongnu.org
X-Gm-Message-State: AOJu0YwWxiVOpRGvkupYzrgJdEYddrfjxiwcjJXm0w7DWUJ9OIJ5Z9K5
 02ko9AcXAfGHJ+tVSF4/S4/pvEitpfEYqvRlLYvcMZT2DXdIrOkcwMJX+rHIu1s=
X-Google-Smtp-Source: AGHT+IE3qUzEi840HVSUgrcVOudEtwLsL5hrkoDEB8zjvbAnm4wBmfm/3RuJb4HtW1Kr0AHD6IVXYw==
X-Received: by 2002:adf:a382:0:b0:367:8e18:535c with SMTP id
 ffacd0b85a97d-372fd7240a6mr3668939f8f.43.1724343805146; 
 Thu, 22 Aug 2024 09:23:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37308157d1fsm2041117f8f.47.2024.08.22.09.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 09:23:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH for-9.2] hw/arm/sbsa-ref: Don't leak string in
 sbsa_fdt_add_gic_node()
Date: Thu, 22 Aug 2024 17:23:23 +0100
Message-Id: <20240822162323.706382-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

In sbsa_fdt_add_gic_node() we g_strdup_printf() two nodename
strings, but only free one.

Since the string is actually entirely constant and we don't
make any use of printf's format-string operations, we can
drop the g_strdup_printf() use entirely.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
A small once-only leak, so this is 9.2 material. Spotted
with clang leak-sanitizer.

 hw/arm/sbsa-ref.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index ae37a923015..5cd8cd705be 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -164,23 +164,20 @@ static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
 
 static void sbsa_fdt_add_gic_node(SBSAMachineState *sms)
 {
-    char *nodename;
+    const char *intc_nodename = "/intc";
+    const char *its_nodename = "/intc/its";
 
-    nodename = g_strdup_printf("/intc");
-    qemu_fdt_add_subnode(sms->fdt, nodename);
-    qemu_fdt_setprop_sized_cells(sms->fdt, nodename, "reg",
+    qemu_fdt_add_subnode(sms->fdt, intc_nodename);
+    qemu_fdt_setprop_sized_cells(sms->fdt, intc_nodename, "reg",
                                  2, sbsa_ref_memmap[SBSA_GIC_DIST].base,
                                  2, sbsa_ref_memmap[SBSA_GIC_DIST].size,
                                  2, sbsa_ref_memmap[SBSA_GIC_REDIST].base,
                                  2, sbsa_ref_memmap[SBSA_GIC_REDIST].size);
 
-    nodename = g_strdup_printf("/intc/its");
-    qemu_fdt_add_subnode(sms->fdt, nodename);
-    qemu_fdt_setprop_sized_cells(sms->fdt, nodename, "reg",
+    qemu_fdt_add_subnode(sms->fdt, its_nodename);
+    qemu_fdt_setprop_sized_cells(sms->fdt, its_nodename, "reg",
                                  2, sbsa_ref_memmap[SBSA_GIC_ITS].base,
                                  2, sbsa_ref_memmap[SBSA_GIC_ITS].size);
-
-    g_free(nodename);
 }
 
 /*
-- 
2.34.1


