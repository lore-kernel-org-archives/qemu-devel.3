Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B58C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYq9V-0004Hc-QB; Fri, 17 Jan 2025 12:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYq9T-0004H9-30
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:28:59 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYq9R-00079k-Jw
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:28:58 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2165cb60719so45291995ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 09:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737134936; x=1737739736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xGPgC9P3Ba0DssIQxEX94j+fNUvlB/TMC/uHifO9Zmk=;
 b=RnL4ZMR6eY88MgbRxtT30EzoLL1iPpUEfzuFuYsbPDpHu5GwSyZJcAuUGzkVnWF5W1
 TC9AQvxyGV+k5Kcut6V/VWiQ6vBhEZ1cydN+nyDWd4gekdSzXVgmxYfZ6uarB7fmIGan
 KA024j9I+pgoF6qj7/G8A7RVQBOZ0f6pCQ5VYROuyH2csMQHGElBiReg9Tksl3CL73D4
 NcWdT0OdjhwYYRV7XfQhp7Mi3YADIj2wOhnQuM5fgjIjlW1NF8ixh4Rl9A2BY7C+kQ4z
 7vPFkE7bbptAKvNJBK99K7B7QW1FLcUSS5bab1ykc23ywdM8lBBVCrNvsMh0GlRM2ZJh
 5vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737134936; x=1737739736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xGPgC9P3Ba0DssIQxEX94j+fNUvlB/TMC/uHifO9Zmk=;
 b=bGONtTlZJQ3e4F0yAV/JxhV7l02WXlh3HYFt4jSb7Im07EP1StEbx8uB+rvID48on9
 gdydKwuhZNP2OonzPimotGT8GHLzgDVIL0++QWcGkVEFn4deIdKhv9hBwCoYfQ+ZI1pd
 V+iGVaePEWZ1iGR5dSdyGWpOnvmck3ciEcSPc6HZFHJmxMismNJVXTtU+UVXjMnSsR1e
 hwY7tSbOaWj4OWV0N9hApCJAyQgF3YVTouBQTogKhKbhfg2x6nE4ya5gEezRGgBvzQ+D
 odh7wH7lrREDjhU4gjjjQZMHa2V0XPktVKSu+OqTPjFnFQRwCOwlaNjQc8dRVy2+9hr3
 ztQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWJkRWuo7MntCplFxdQhDfAJ2+d0U1IN0CejKoxkZw0EJdUZj0VT5RSEGjHlJQtr0ggHyRtU5iY/Yz@nongnu.org
X-Gm-Message-State: AOJu0YzB54Mwtb/BRF1HPBMLd8tCR4icWeNGXQFzXplUFQNntQcatiLH
 av4ejq1CS1z/5qAaWkxm3kVDRJM/OuqA54H6b+eltrP+KDBzvJXA
X-Gm-Gg: ASbGncvIS0JgdjOG5XP0B07rMXTu3/oZQMuAGnWPQqiWz4/+m12B6dF86mjXEUqnqcS
 p36Wzxpys17nQQJFUnpN3So2AqDTjjuiCSVHen3/XjEag++9gqjjQZhaKM96AM2jh8zRmmlaMjF
 JwLRmpoy7Iq8TYi7PaW2KLjrnCW6pPiXyzkZFUXwpT2N4T17Bp5HLNH0ULo7vFeMv/bGGgwofwY
 8y6rN4xjW+1Tw8eC0O1CQ1AOu3Rb8xxTmCLfHz4JdMno5hcLPYMsGswySluwpeKGRw2CUJZIYWy
 9UUdpqcxzscWrFU=
X-Google-Smtp-Source: AGHT+IGVM7W2A84Ek91MpCU2t86v8Jo49c+HsGJpSgbnJyrmnMFarREpebTwuBa3Oh/4LqVfpWQm+g==
X-Received: by 2002:a17:902:cf0b:b0:216:2dc5:233c with SMTP id
 d9443c01a7336-21c355c8f76mr60247225ad.41.1737134936173; 
 Fri, 17 Jan 2025 09:28:56 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3a8a2bsm18658805ad.142.2025.01.17.09.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 09:28:55 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/pci: Assert a bar is not registered multiple times
Date: Sat, 18 Jan 2025 03:28:41 +1000
Message-ID: <20250117172842.406338-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250117172842.406338-1-npiggin@gmail.com>
References: <20250117172842.406338-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

Nothing should be doing this, but it doesn't get caught by
pci_register_bar(). Add an assertion to prevent misuse.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/pci/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2afa423925c..b067a55c5bc 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1391,6 +1391,7 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
     assert(hdr_type != PCI_HEADER_TYPE_BRIDGE || region_num < 2);
 
     r = &pci_dev->io_regions[region_num];
+    assert(!r->size);
     r->addr = PCI_BAR_UNMAPPED;
     r->size = size;
     r->type = type;
-- 
2.45.2


