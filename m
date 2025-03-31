Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3F5C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 15:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzGwc-0007FJ-Im; Mon, 31 Mar 2025 11:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzGwX-0007DB-5o
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 11:20:54 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzGwU-0007Om-L0
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 11:20:52 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso29524475e9.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743434448; x=1744039248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tHDVcIHyei1/5z2v4ais2OKqYJbZicKYgClVfwcyY94=;
 b=t+wR9wa7ZiGNA5yHpWw3ooleDvDbDBaT90hVLmD1vfPmw3pFkhyVlo6jcSmFum3VEP
 Yg6NhlXLKUT4e3FlDQBUlQvwTTifg6lmEvtWDT5EKn/nDZLEJwh5v4vICcgdPAy2YXkM
 vnWag8i1lIuyAvgDeDyGhyU6fCYWncbB5PTnW2cmAIj83Wi4XI2NnqZuFgI4KfMnzESj
 i9I0/HlXaiykjV4WjhhrIWvT3msToD5KVuvlR8N0IJjI3wsYG/ogOLvyuFi6Z3YrgOfb
 PEK2xxJ99sIxlEH9k6r9dNSG6hvV+UKfTL7wNccpv1u1yr0Y9A9BiRpfIUWRhBxytR+d
 WlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743434448; x=1744039248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tHDVcIHyei1/5z2v4ais2OKqYJbZicKYgClVfwcyY94=;
 b=UuhoFN5oWhKqnHWmwbdJfS3qHQR9YcaqYb0j+fO/slbvhIlgPv3oS+zkdZUkCJSd8J
 f5N+YkZx6EVSojGawjGtiEn8tjzqSmZvuKpbmw+kN2hJtxdkL8NQ6iDg5s121OAn7I5b
 Y3xYk79zwI+LKeA71hfhLFD+TdekJjuKSuJBX+lnckg/P5Bm0nwbXoDJBXeN1bb4rOqH
 55xKefH/DLu7XoxT9JryHoyEVJaseF0M2wSUNMtlRjfBDBfpkp5DpcJlLeC5rs1Xy3wR
 0XolfnKPMEdNek8Y7qTMoAf4Cuwpxg8LskQzNW91Wxatxt7f8eDmy6/FJue2qrSFd9bn
 6m1w==
X-Gm-Message-State: AOJu0YzS2aE5rvkMRQoOvw5AcQMs512/6ZYQjglHNXmrlXSsUm4Dxv+8
 GTD2iB4VLJTcfHBxxzw0Tl105BEJYe+fm8pdgZUsKVTlA/tOxtY2LvhKcwOujKGYGlIjhqMr5nC
 H
X-Gm-Gg: ASbGncsX3b6cZ76MaWpS0Wh/FKuRs673XF7h0jBDHvlqgDfgltYRHkOIUzVCA1AqXOo
 rxOaiZKeRFC6874afB5y+jGc+OzTgm4AX1uSZYmNT+8hz0ctGzuHzbvorV9YHBNOTGoOjDUp4/d
 IzgYduhCv9pDAicqSve/TwnV4bWvPa8ui2pnL9wqFeL3eR0L4TUoOkt6t2lfTqfaRD2hBIHQpgV
 OeFajHg4IV/5IVgo5zf+OZhQjrbXXZDqR5ZK9L0ZJV7VFfR+nUXsuaLy5Hzyc+MAuOqR1Qb0gyo
 MDqBdi0pnZ6d6258G1yl6F5k3sPl2VjNA1RXcmsRrnNFwlyZBnJpyPZ5hn5P/gNfqXrZrghN4QV
 PBLcEbF44YneGHEBTcPg=
X-Google-Smtp-Source: AGHT+IFR8R4zvqHZ9xfh5Dx+rgNvydvh+UWi0MCgxYnxv1zzhiYEy517pjzzA0dky3IiTdIIDQBLcg==
X-Received: by 2002:a05:600c:34d0:b0:43c:f5e4:895e with SMTP id
 5b1f17b1804b1-43db61d7785mr73395325e9.1.1743434448530; 
 Mon, 31 Mar 2025 08:20:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d914f1561sm82919785e9.1.2025.03.31.08.20.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 08:20:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>, Joey <jeundery@gmail.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH-for-10.0 1/2] hw/pci-host/designware: Fix access to
 ATU_UPPER_TARGET register
Date: Mon, 31 Mar 2025 17:20:40 +0200
Message-ID: <20250331152041.74533-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331152041.74533-1-philmd@linaro.org>
References: <20250331152041.74533-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Fix copy/paste error writing to the ATU_UPPER_TARGET
register, we want to update the upper 32 bits.

Cc: qemu-stable@nongnu.org
Reported-by: Joey <jeundery@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2861
Fixes: d64e5eabc4c ("pci: Add support for Designware IP block")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index c07740bfaa4..5598d18f478 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -371,7 +371,7 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
 
     case DESIGNWARE_PCIE_ATU_UPPER_TARGET:
         viewport->target &= 0x00000000FFFFFFFFULL;
-        viewport->target |= val;
+        viewport->target |= (uint64_t)val << 32;
         break;
 
     case DESIGNWARE_PCIE_ATU_LIMIT:
-- 
2.47.1


