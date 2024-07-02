Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D06BC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVe2-0007A1-OU; Tue, 02 Jul 2024 01:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVdy-00079D-Qv
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:01:31 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVdr-0005Zn-5i
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:01:27 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42565cdf99cso32996175e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 22:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719896481; x=1720501281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kNKO1Dq0uSgK+6l6HOZ90VqhRhaEia6DOkXUixOotHw=;
 b=q9F2yLHSaEcC39f1lcM0HdqRThvluXSqhPfK5yurwQa2snPb/Uxnd+MPWbeDlGvfiE
 T6W5EjGsZP29u20vRxRR9AfNdBdHYCVfbPAbEJ9K/UNnfwBBA5JTnYGt2bE41Upu+roR
 WwGRYxuxguiUVtzeoz5gOK3aPPHXVgEtDoy1gBR3zJbx0P5hPFtU6cGH0ajM9ydOeJPm
 uCNQlOgS8oSCm73J89n62jwilat9ntBZCwkDjfbeGflUH+OEsB95cYtz6zhmgrOEpNYY
 bTyp0QzqQkKDG+KlSZS2thHkJkyu2lXwopqIkgv7L3jbkk+Ey1yghqlnzgdH/Pk23hi6
 sExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719896481; x=1720501281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kNKO1Dq0uSgK+6l6HOZ90VqhRhaEia6DOkXUixOotHw=;
 b=VtX/zhEFonTJYy42+kODyjZuv+P2g9LBaRXGIv8Rk7qds7N2iFLnwmo3nDJyIDDtqG
 ZiynQIqhCwdrKiwj6eN5ne/u2sYpBGjZcy5vHb12kmslWd+VKbiFdqmjOjCM7BsMRR+j
 GOIcpajlwGV0I7zJn+oPI583qyVBmhV3uTHrQGQVZ/Uf+xwxeWkwDt1euoofdZnaC/Vv
 afecc2EO+FaRUbyVqY0CGqnV5FPRtrWUP2oeBbcoHiBFCtIuupgNLg1IltN39cm/MyOV
 BeaFc/0fSGWGjimydmVugvBGnfW6m9c3sqIMH0U4itOxUscWRuvunWrqvwIrBc/Wujio
 MqIg==
X-Gm-Message-State: AOJu0YwwOlv4eL+eSTS8/g15Zl9lb1MiVE1tPIH416+v3jlH4NQ6rIwl
 vW8XA40MCeasdw/ql3osoktwU0wa7ZZ45PI/K7R6JL8+r9tSEgp5ycefmpKzSe20jkpTiRrt2bh
 y
X-Google-Smtp-Source: AGHT+IHXZYUIBSkUYfzYgYwtdlhcmTWY6sSyS+VsbwYZE36K7c27W6pZkGQ0LJZxBdzmM93mnR4H3Q==
X-Received: by 2002:a05:600c:1ca9:b0:425:7a6b:4e88 with SMTP id
 5b1f17b1804b1-4257a6b5073mr51750135e9.30.1719896481266; 
 Mon, 01 Jul 2024 22:01:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5b626sm178454315e9.15.2024.07.01.22.01.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Jul 2024 22:01:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Oleg Sviridov <oleg.sviridov@red-soft.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/22] hw/net/spapr: prevent potential NULL dereference
Date: Tue,  2 Jul 2024 07:00:51 +0200
Message-ID: <20240702050112.35907-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702050112.35907-1-philmd@linaro.org>
References: <20240702050112.35907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Oleg Sviridov <oleg.sviridov@red-soft.ru>

Pointer, returned from function 'spapr_vio_find_by_reg',
may be NULL and is dereferenced immediately after.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Oleg Sviridov <oleg.sviridov@red-soft.ru>
Message-ID: <20240531073636.3779559-1-oleg.sviridov@red-soft.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/spapr_llan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index ecb30b7c76..8af33d91b6 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -770,6 +770,12 @@ static target_ulong h_change_logical_lan_mac(PowerPCCPU *cpu,
     SpaprVioVlan *dev = VIO_SPAPR_VLAN_DEVICE(sdev);
     int i;
 
+    if (!dev) {
+        hcall_dprintf("H_CHANGE_LOGICAL_LAN_MAC called when "
+                      "no NIC is present\n");
+        return H_PARAMETER;
+    }
+
     for (i = 0; i < ETH_ALEN; i++) {
         dev->nicconf.macaddr.a[ETH_ALEN - i - 1] = macaddr & 0xff;
         macaddr >>= 8;
-- 
2.41.0


