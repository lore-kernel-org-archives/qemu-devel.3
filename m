Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF013C19F4F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWZ-00024y-Nj; Thu, 25 Apr 2024 06:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWQ-0001zx-UP
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:11 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWP-0007BM-9K
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:10 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4196c62bb4eso6441395e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041608; x=1714646408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qTCnu62k+8U/GjNoTGBqIqRdrEXskM+ZoSSojfJIbBw=;
 b=YXp1e3M1Z9c+SSQa9H77H3X3JIQ5X6PgZtrXsUGIMv4SYX1qaH0cQ7nwDa2R9iEdGv
 zCiEAlMTkTW38+sKO1rTxDsdkhHXveY2LqF/F016nzlGHlYstwjYNXNwUn/M8b7iBGRy
 gSP9+2m5pq9+nm7K6CP0P6jwf44wKKDv8S1fXUhPp2mS6kPtDniC4PTz3hMS+ocXQdu8
 070VNCKmUrJYBHysa3lZLFeDK5/NV1bDYtV3JcVdPEFtFK1W+6UxfNMPkkvw4hCLCCgd
 BfxWhphZIBlaY2UGQa6oFY9yogCyNBlM+dyF5vpy2pUiN1fe3OOO5dyYZsNP3bXUZifO
 iOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041608; x=1714646408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qTCnu62k+8U/GjNoTGBqIqRdrEXskM+ZoSSojfJIbBw=;
 b=izPigaV2FjHSfz/R/iy93c5zUMEdtjHF5mpryqH1Zc5gGJ8U9AmJPuGlMhAlWksEku
 TieSpUFUoSKdxPWJ38doLVuRoMzagm6JZRhy18KuX7RFwHjj2BYa7Osdz/Fn7ITdv1io
 aOwn1SD54Xc3hxlmbt06OBICIuuxLvbOyxzLMWJhSk6qTlVCWUkgf+/NOhxFMc4OxbuQ
 gHqhYeNYscCS8X1Xr7/gJC8wBU2kKj8yNsSF8wgl7hvIe6s+QW8gCYOdhTtTA+3Xm/IX
 VyknU5MK0nRbXB/qgeQmfFdufHvAnASOjqf7LS9aw/uZQ1Nf3VQpIRs5jxv5KdrqT1o8
 CE0w==
X-Gm-Message-State: AOJu0YxZgm4VBb7HY1huiT3q09pP8W/htzYJamdwRF8dOwTQqx4zpprE
 bikzsef/DOI1QaIvO2/d20C30ufcLINtd3JGRPKdXPFjq1hjy7pZHXbusPOi/S7Hzq6jfqaM3Uj
 N
X-Google-Smtp-Source: AGHT+IFgvYz/LL7COI7sVcEFIk86rsMy7bHZdmbmd/IL5LKkjeAXw5WTY7QNHEBHgYe89p/qdxAbqA==
X-Received: by 2002:a05:600c:4fd1:b0:418:be2e:df9e with SMTP id
 o17-20020a05600c4fd100b00418be2edf9emr3499976wmq.41.1714041607855; 
 Thu, 25 Apr 2024 03:40:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/37] hw/intc/arm_gicv3_kvm: Not set has-nmi=true for the KVM
 GICv3
Date: Thu, 25 Apr 2024 11:39:35 +0100
Message-Id: <20240425103958.3237225-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

So far, there is no FEAT_GICv3_NMI support in the in-kernel GIC, so make it
an error to try to set has-nmi=true for the KVM GICv3.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Message-id: 20240407081733.3231820-15-ruanjinjie@huawei.com
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_kvm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 77eb37e1317..00a383079b9 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -805,6 +805,11 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (s->nmi_support) {
+        error_setg(errp, "NMI is not supported with the in-kernel GIC");
+        return;
+    }
+
     gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL);
 
     for (i = 0; i < s->num_cpu; i++) {
-- 
2.34.1


