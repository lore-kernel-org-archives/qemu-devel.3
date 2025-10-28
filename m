Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFB1CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeZh-000208-1Q; Tue, 28 Oct 2025 03:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeZd-0001r3-SL
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:56:57 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeZX-0008Bv-UI
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:56:57 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so42525015e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761638205; x=1762243005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aA3Jled4nIy1f54j9mS608CN8DTZojtQYyTk2220hvI=;
 b=iYBZIQ8+tSvK8aRre+etdX7RYqogMQ2/4GEuxzLagwhhAgxMqTl9xMLzKrT6HpGNhK
 OTc4aZ4p1gv/RjYsvkNI8GvqlYunxTgS8u0jwMaq1FhEPY2ctP/jcibnCOrj2+Uq16h1
 a1CVGrTuksFX2uaJxyA20AXcTTCRQi9b5AAcxuvzectYNrSLprkewzgGJSvittel7alW
 inX7QJr8Q66Xs1CTpbTfpUR4BAIQnzWydsnwzKd5Ekt7uSJJOOmeJiPig2LtQISUi777
 ARSwvPCwZn22i+11eylNrQuQNG+ZXol+YsgyywlP233Pkw1xxfX7FA9Cv7nusJ6HpIeE
 R+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761638205; x=1762243005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aA3Jled4nIy1f54j9mS608CN8DTZojtQYyTk2220hvI=;
 b=dXvMx5/n1wQCNKzc+JZdkuSao0kzMzW3zyrOrf0h8Eas+IAx2dsfcp5YrBlpiaI8Pc
 9q/P/W3ZYlD2AyjUPmJU3hLx7KVUg+Vu2RknU99p5134kjFHDBjoGjbuxleGsoMjFwKs
 /b5w1HWIzejATDpA4vmjD8uuyZ5kES8yErtqVc2xkUte4/QDHaGNLakFBjwYSBlWo9Vp
 VICsNiQjhvAjkG9E4ZW/YaSnVUZgQNPbxD5GecuNuy5nak58cpsuPrSWafOEeKWvF94x
 U5AeE0fPcvAZN/RA+q+3o+Y4PU6x/6jELBMwkHzBuZgl4xAq4WXZXxtI8fGOtzPF61cM
 TTtA==
X-Gm-Message-State: AOJu0Yx6Rbp0Julm8aPSWWZ43AZSgSFx04XXA629eUK8m7TGOUablUTj
 gnt2XpC6JQ20fxt2IM3Oko7+TY/M9+2R+7jVqTTY2nwGSl2ZNFLLB9mIgv2SI1Yoe/TSuxT5Aju
 SKv0vhsI=
X-Gm-Gg: ASbGncsCHc7g6uu1IwW+4GRLvb2F4Qm8aUSVK95ayHkIk1rWOM17aTme27JDimAkVH+
 cpHk0YbBL2q1AJTXZMUjFKcQkuV6kcF1NMCagSzyKdcwF06rrIOuLvaEIqZzljeYzXYYFyz3bVE
 j9Vv2tkEDPMxaZMn4d6xU021kS7DCQBNhh8Hw0xnYsvEe2KCzAIQ4jKAgRZ/DEC8GQYNZxpISgr
 L8Sky/bB+fLs+RMB8j5o33v8qWxIL/uu86lUyXc/m3LETbYY1njLXPC/HDnHKE+/Bxga75vt4Y4
 jLNQCjYgZuGrVFYTtIRQ1abAF9wcwEHutOe9VNndJzL9F8mQOrN9y0KdtE59G3O7OX5lobtkUUl
 Gcl1hku68MWdMv6Wlt3PRwJB1wTfWgLGc+BtGx7Yyr1f9T1MkLXPUeYlGEUT+pCJJt179jppRyj
 bcmd6bNlhMzfZiz09ziqI7Vw6pY5ailJrXDAGDdIJNPRoMurvnqTosIIY=
X-Google-Smtp-Source: AGHT+IE0ovErx6uBtDZxP3+beEeE9IANGM0pKlw/l3sNVsmr6vjlkHvtVYQyKN1AbZyoNQ4dGT45kg==
X-Received: by 2002:a05:600c:34c4:b0:46e:4246:c90d with SMTP id
 5b1f17b1804b1-47717dfa47bmr17961025e9.11.1761638204633; 
 Tue, 28 Oct 2025 00:56:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771904b26esm12773225e9.10.2025.10.28.00.56.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:56:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 21/23] hw/i386/intel_iommu: Remove an unused state field
Date: Tue, 28 Oct 2025 08:48:57 +0100
Message-ID: <20251028074901.22062-22-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
References: <20251028074901.22062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

dma_translation has been moved to x86-iommu and is no longer referenced.

Fixes: b6b49c2cd6c2 (intel-iommu: Move dma_translation to x86-iommu)
Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251027075232.95262-1-clement.mathieu--drif@eviden.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/intel_iommu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 47730ac3c76..b2f1ef9595d 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -307,7 +307,6 @@ struct IntelIOMMUState {
     bool buggy_eim;                 /* Force buggy EIM unless eim=off */
     uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
     bool dma_drain;                 /* Whether DMA r/w draining enabled */
-    bool dma_translation;           /* Whether DMA translation supported */
     bool pasid;                     /* Whether to support PASID */
     bool fs1gp;                     /* First Stage 1-GByte Page Support */
 
-- 
2.51.0


