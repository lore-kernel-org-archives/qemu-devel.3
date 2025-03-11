Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5C5C28B30
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzD0-0003L3-Eu; Tue, 11 Mar 2025 08:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCv-0002mS-K6; Tue, 11 Mar 2025 08:59:41 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCq-000800-OP; Tue, 11 Mar 2025 08:59:41 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ff187f027fso9043672a91.1; 
 Tue, 11 Mar 2025 05:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697973; x=1742302773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G3M6o0HCxEonBIrEgIZJkSZItGG16Roe3OW9YD7vpN8=;
 b=mcPIO5HWu1+gRkFBq7e0+6pUgR2AHD7TcKKMkT9aHlPdpqRgihTj+Fj9iy5pXxSC6c
 02Ioc/nytzelHle1AFRLOmIFX7iMbsTO9fMidqDTgAZlb1n3rQEigKo4bIVPw0GwCml6
 KCmIaugBGHlKKwMMU8lGpKPfQbhu0V0SfcaS7d3doEl0MljDTDA3zhS2YB97GnrjtzJa
 HrYisApPxowVb0Dh7kmuAKzJZOSkyG6czPrfLFMry88IQB5ES5kUEZdcxhUvcETPSOr9
 ot0llz34OyvnABsPnIvpb+jVIsfVXVPaxSPjuz+NTkTDHVwqxGSXkUKptRHEi3Z2a16m
 XQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697973; x=1742302773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G3M6o0HCxEonBIrEgIZJkSZItGG16Roe3OW9YD7vpN8=;
 b=vM5lYU71nG8XynKpfNd6ZGSb5TzuPmb+LO01bc/oDG5sEPmiMmBb1WusEUtKBxAcuL
 nLrYbcxs286e4E+wqFSSn6t1aQ4Tce7ZDGpoT4aEiBm82hAZgrG9S9PlGfCZjQ3fZa3X
 GKUDnYqzhk0CpL8r9izPVPamkCwWqsH9DKOCwMRxQ9HPHBXZazpz5Jb6oV3iSgjvGs6R
 EFNTVvLWZrIkj8m79CBVxyEQkA+Ly1v+XKDNEedX8T/9/ADU22Tn0pxeX42SE/878Ahn
 QUvAIZLp0LQVxdOquFSWRjNIrUIDPPjfPRe7wWfatgLFSrudduaQl73gysyb32K1SFwd
 Ob/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGEqRiMMBgpwycSYwDd7aqJ0O50+p408gqjhl9fpZ+e/hmuvE16hCUA2+E+EJr07dEDyk1VMba5A==@nongnu.org
X-Gm-Message-State: AOJu0YxUEK/4VUm0QS2obXZViKzgHFgzb+SDLytN8ObR68r96gmh/hEG
 rog5v6u7HLKmQFfAt8h1FFcUdGa9Qo4lDcigdBIHkzJwpf6l1Am5ToG9GQ==
X-Gm-Gg: ASbGnctq0jjEAXUXCT4Aq1GIQFXOtdfqpnWeFSwxw1wvjf/M6l9fv2emxHfIRTKAa4v
 zskoet/LE8KxvONmej2N+EO65/nqP9pPM9mn0k5SgZ1XAyFxDDUJdt7IyjGxhcgx5EJ687WM2kS
 0ES3qo76nM+3lKYXu+JkCkkZrTRjZNFptZrlXt8AMkpwPTM0DBnzki9b6J41RT3/lPAOkutmbRj
 Md1PbRC6f/WI70lk5mTQtX58fSRyuzP9FvQkr1+iyADZbXR22omWCG9SnIdkF9wNJ3nu/96unWZ
 iqUoJXvgQ/v0wG87wMtQ6ywbCS8Ncth5wbW2E7egvTX+0IvrzX8=
X-Google-Smtp-Source: AGHT+IGpJ3Abqlt0qCxF/qLDb513LeEuMoZaNufLaAoM4DtPXII8Mv+lZIYo9Iq2Puj/vACSovGHVw==
X-Received: by 2002:a17:90b:5403:b0:2fa:1e56:5d82 with SMTP id
 98e67ed59e1d1-301005782bbmr4506063a91.17.1741697973002; 
 Tue, 11 Mar 2025 05:59:33 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:59:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 21/72] ppc/pnv: Add a PNOR address and size sanity checks
Date: Tue, 11 Mar 2025 22:57:15 +1000
Message-ID: <20250311125815.903177-22-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
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

The BMC HIOMAP PNOR access protocol has certain limits on PNOR addresses
and sizes. Add some sanity checks for these so we don't get strange
behaviour.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_bmc.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index 0c1274df21..811ba3d7a4 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -251,10 +251,38 @@ static const IPMINetfn hiomap_netfn = {
 
 void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor)
 {
+    uint32_t pnor_size = pnor->size;
+    uint32_t pnor_addr = PNOR_SPI_OFFSET;
+
     if (!pnv_bmc_is_simulator(bmc)) {
         return;
     }
 
+    /*
+     * The HIOMAP protocol uses block units and 16-bit addressing.
+     * Prevent overflow or misalign.
+     */
+    if (pnor_addr >= 1U << (BLOCK_SHIFT + 16)) {
+        warn_report("PNOR address is larger than 2^%d, disabling PNOR",
+                    BLOCK_SHIFT + 16);
+        return;
+    }
+    if (pnor_addr & ((1U << BLOCK_SHIFT) - 1)) {
+        warn_report("PNOR address is not aligned to 2^%d, disabling PNOR",
+                    BLOCK_SHIFT);
+        return;
+    }
+    if (pnor_size > 1U << (BLOCK_SHIFT + 16)) {
+        warn_report("PNOR size is larger than 2^%d, disabling PNOR",
+                    BLOCK_SHIFT + 16);
+        return;
+    }
+    if (pnor_size & ((1U << BLOCK_SHIFT) - 1)) {
+        warn_report("PNOR size is not aligned to 2^%d, disabling PNOR",
+                    BLOCK_SHIFT);
+        return;
+    }
+
     object_ref(OBJECT(pnor));
     object_property_add_const_link(OBJECT(bmc), "pnor", OBJECT(pnor));
 
-- 
2.47.1


