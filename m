Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EFACD5BC0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC7C-00020a-Q7; Thu, 05 Sep 2024 09:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC70-0001GW-R1
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:22 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6w-0001mA-4H
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:22 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42bbe809b06so5778165e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541276; x=1726146076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QuDayuKh0MOoUDfgEF6uvM1JMAu44R2Rmq7U5Z8dKh8=;
 b=UGjMKH6bBI/VnZNuEESnhLizkCp06seHD6Vqwf77M+fnAd3yNcFmVxkdazepd7M9pN
 s/T/kBPx7+uN79dl0pcASv5ZrIh/5j6jdjKwjSBEweoKszhWfelPUqjfsyKiV1up/xmR
 V3p/JKCgqpHUv5SXFnk0ubpur1ASV+1yBHI9EJEn6lKTsTTxQRCMigrqf5oCVKoNUgUh
 Df28br5K7P6NG6H4fWjc4WRyoFBnRl0AbIJqQJJs2//tupozMQ6nZfKubxEKMCMoMHgu
 1vPq7SBqIJf7NrtGWgHzwsBLwqkMGU/KKQnh44V1MMoCPwk5yjJdzZs3zK6UJKMSgkte
 ZbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541276; x=1726146076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QuDayuKh0MOoUDfgEF6uvM1JMAu44R2Rmq7U5Z8dKh8=;
 b=NbplffVnVhF5c21xldzLTZUq0MmDNJjvXGizSQ1argaVDIcX5M23s7dOj/9T95uZz/
 X7xpGP1J2m7mGpv75Zfk8BQZPxsaX6SMe9zkyVPvFSYjrHlQrABErGkeb62zojbocNzp
 B65zXgBihlkNPlA9PGjWb25RXtsXjZ42OTOoca3FozH6/QEDsJZrgwzhA/HMbSf+q28+
 3iXnASoeIQRZKOSIfTfW/CRqlVdYpzDHTq7QdW9AFM6MTG+x1iPh6rtvKTSrMu8OThn3
 z1NUTjnUfB/0mzVLa31wpeesNg+FwMzgjzyc4mDDJvfGzkjnCEdh/BlkgXwByuWl17Ri
 wZJg==
X-Gm-Message-State: AOJu0Yxh7O74+ayfeNxN94334zC79SGj5W7HYnMrKK0jDQAd7XqjOfAT
 Kv3BAOcKEOLHUpm+GJ2eblTAFF2nmHzWmM7tvIMrL2e/w/791vxTkexgwBFF6lC15p4UAr+Jy48
 d
X-Google-Smtp-Source: AGHT+IHlOkNj7VZAH6DRm0CDK8Tp/cu6rW9ej8MIpqQIUYByhLl2haIgwI+Iw5psYyVxPPLU4LKv/w==
X-Received: by 2002:a05:600c:1c83:b0:428:ec2a:8c94 with SMTP id
 5b1f17b1804b1-42bb02ed81amr161924605e9.10.1725541275927; 
 Thu, 05 Sep 2024 06:01:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/25] hw/arm/sbsa-ref: Don't leak string in
 sbsa_fdt_add_gic_node()
Date: Thu,  5 Sep 2024 14:00:55 +0100
Message-Id: <20240905130100.298768-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-id: 20240822162323.706382-1-peter.maydell@linaro.org
---
 hw/arm/sbsa-ref.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 396abe9c1bd..e3195d54497 100644
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


