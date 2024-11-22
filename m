Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DED5D75E22
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 10:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEQza-00055W-5F; Fri, 22 Nov 2024 05:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEQzY-00053r-AY
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 05:34:24 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEQzW-0008TD-RH
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 05:34:24 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4319399a411so17765925e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 02:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732271661; x=1732876461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TbvDqEd1B3bnnTrloGtTMnweakIQQJasrSikw54dhrE=;
 b=nr9GkqLFB0Ixkja8swJREm8KUh2coWy/YcXYoSWC1n2RRysl+BZv1WxJiB9uvSePW9
 trk4ph5/rEt9Hnzx2e7hfUQiIawXtjW6aEDKFZZ/hPiTqsWfcg0+/cI2td8B4JcnQbMK
 V2Ku2rN0N+IGdhU2FszCAbgRV+XRERn266WrRRhouH+MRce46K1oWyzx+me6gOPzPbrw
 LT/ngt63AKdLh/5HPZBIvhCyNlFFgcgJhKPb7DvrpYGtJivrwziEPGB8bjO2X2cXw+yu
 tTzoXcDVi96xp1dd78HppIeAk5rtB3lsy/SoNHkxSI3+9jMgc/OYawmDc3OMVvcyinKy
 LFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732271661; x=1732876461;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TbvDqEd1B3bnnTrloGtTMnweakIQQJasrSikw54dhrE=;
 b=EqzBqmcO6cVNYDJlu75C1/UOikj7mHBIES5JzJh3FlI5BBS2eq91S4x2mPR01sdUh9
 Sy9aZd81IDNfwENIf7MUljCgbqgMDPTNWqjywQsFwWnWYcesBXQjhQvIDj1kJNKZ0UN3
 zFHVXnv54mS0WiYeQfsMz/RboX/LuUI9JF/Za9kRXdcBBYvYROKZJFXk+ilxVDnSr6Ts
 KD7+Y2JKIqu6kzcoImIct+QVI5cqxeM8rMp2yiyESx3jjT0IhkB5n9Zm6Ip2xd0Ziqac
 tvz8Kfyc0VZ899jYNjf/AxSA2uNKrLDhZ8u2sLyoP5Cgh1c8nPKuglp8t9awHIbmV4jJ
 TfCQ==
X-Gm-Message-State: AOJu0YywPUJpHaWIEiwjwJKzwOMOWHNeKhI0kQW14sTxuvVYOoqnNFFp
 dKCOKhfKKRKejJxDEemRX//5sitrmFtB2UK/SWHTgT5e0kamK0G7wLjs0ZGzGAHEHST9GSW7cvS
 Q
X-Gm-Gg: ASbGncv7mUJZ2W3JCWFsjYysv1A7tdfENdzSra+TRX71dr+DHUVMNDAbDOnGKPeBi1B
 uz0ITFabepaNWQzVA9CHLHLnFNlTUxPvk6X1zmrXEJF6HF+EHlMGTbPR/AluIFRVSKjju5yUHjw
 woRzXC89plXbOh96/x2lDGcuuieABMwXHvGH/rT7hz53ilRSQmsDgb6L6xN7vg9i36SE8P2hbeZ
 iauBSGZpvp/GGxReqRFtq4c1a6n4MXgKZXNyVfnMD7z0y/l7yq5fmCmzC+ZmbvB9d31ftipsWKq
X-Google-Smtp-Source: AGHT+IEYQUCgJpl2jjrFL9PpQUtlshsNvqo1STqrhzW/N43/MDulwIz9JY87STgJ/25l9x6ZUeyIGA==
X-Received: by 2002:a05:600c:19c9:b0:426:5269:1a50 with SMTP id
 5b1f17b1804b1-433ce41ce42mr17547785e9.11.1732271660756; 
 Fri, 22 Nov 2024 02:34:20 -0800 (PST)
Received: from localhost.localdomain ([176.187.211.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b0139b22sm89075545e9.0.2024.11.22.02.34.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 Nov 2024 02:34:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/pci: Remove unused pci_irq_pulse() method
Date: Fri, 22 Nov 2024 11:34:18 +0100
Message-ID: <20241122103418.539-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
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

Last use of pci_irq_pulse() was removed 7 years ago in commit
5e9aa92eb1 ("hw/block: Fix pin-based interrupt behaviour of NVMe").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci/pci.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 135695c551..c0717e3121 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -670,16 +670,6 @@ static inline void pci_irq_deassert(PCIDevice *pci_dev)
     pci_set_irq(pci_dev, 0);
 }
 
-/*
- * FIXME: PCI does not work this way.
- * All the callers to this method should be fixed.
- */
-static inline void pci_irq_pulse(PCIDevice *pci_dev)
-{
-    pci_irq_assert(pci_dev);
-    pci_irq_deassert(pci_dev);
-}
-
 MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
 void pci_set_power(PCIDevice *pci_dev, bool state);
 
-- 
2.45.2


