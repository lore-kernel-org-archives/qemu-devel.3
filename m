Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0ED1CFC286
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ewU-0006d7-7n; Tue, 15 Oct 2024 06:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewR-0006c9-RJ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:15 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewP-0005vd-Mi
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:15 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37d5aedd177so2585620f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 03:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728988692; x=1729593492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UyEnUeAM+pUK11zjhSfvBnjHBcNllMJBTEH4fBRhhwM=;
 b=EUv34Mnfyb7yogpcULZDy+KPMVVfV/ITsoQDYzPqZKLHfym0HdqnW5Fsw1GwVw+GoC
 5FZD22djo+nvVR8gm6yLY9B/GotvX70PNQx+dRSf7yhsuwGvvmXci9rqJ7uixFljRdHb
 9ZwTSthN1siXaZc7p8Alg9f7xRej6ZuHbD7jHmWeHW98DmV4Xr6pZlHmCe8C857FO58Q
 zqiw1i/fdZHcXHp+IqM8ynFs6EuApJr4TfbW5AJ3w8dJiRPkmPOz9D2yIlP4JqP8BAjX
 a2W5bGuVR2HLFHqErxXjL3CwhBHuTZ0asncUpJRFcN/snouOrjtAdLngFT1O8Np0VWZt
 IVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728988692; x=1729593492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UyEnUeAM+pUK11zjhSfvBnjHBcNllMJBTEH4fBRhhwM=;
 b=a1QHjfjGLILMlCyGSDdbVP6N7J79uwZj+Pyr//wK1WtHhP6tZNLUxyDbZKNOI3IPaO
 2u3ccnrnVCFBwnk53iGOSRxSo3gIFuU2JxJK9INcrH6o2LKidMcpv9oyJss0TCYfT0Fa
 pseEYkc3h9H8IIQHwM7Xrbfl8H5yRgiV/ZMyTmjCl37FW0ru10oA+Fprr+jZ9VocSS0e
 7tngKUQvd1OvOKanpptvVjj5le0rZNaEjuEpG6XAKW5FoxP8Rvk8DBQJ6roeTFx+gY2m
 uSXg839P/5yaeL0wsUAoQxnnCVZHHK0G4xwsSKkDlbxzSxTct8tNhxGcotN3+b2DNBrS
 JcHA==
X-Gm-Message-State: AOJu0YxLFONDQg6sDLkVaG/SicE1msSwfhHvFcdPXee1J9Od1DA8lDU0
 TeAF1OlBwzGdkjd1c+777ksk+0TL151ebLq79lJno3IVVG8SjBlkTWu8THt0HM/bR83eie5/w4G
 U
X-Google-Smtp-Source: AGHT+IH/554agvvG3mPPjVfMgordC5v9h1O8onvTnOKMHpj3lbJYmNLNUin5U+RkgeuPzzS/624/aQ==
X-Received: by 2002:adf:f805:0:b0:374:c911:7756 with SMTP id
 ffacd0b85a97d-37d5529ad42mr9550368f8f.38.1728988692128; 
 Tue, 15 Oct 2024 03:38:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a06dsm1241635f8f.5.2024.10.15.03.38.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:38:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/28] hw/intc/arm_gicv3: Add cast to match the documentation
Date: Tue, 15 Oct 2024 11:37:45 +0100
Message-Id: <20241015103808.133024-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015103808.133024-1-peter.maydell@linaro.org>
References: <20241015103808.133024-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Alexandra Diupina <adiupina@astralinux.ru>

The result of 1 << regbit with regbit==31 has a 1 in the 32nd bit.
When cast to uint64_t (for further bitwise OR), the 32 most
significant bits will be filled with 1s. However, the documentation
states that the upper 32 bits of ICC_AP[0/1]R<n>_EL2 are reserved.

Add an explicit cast to match the documentation.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: qemu-stable@nongnu.org
Fixes: 28cca59c46 ("hw/intc/arm_gicv3: Add NMI handling CPU interface registers")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_cpuif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index ebad7aaea18..89359db7004 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -1170,7 +1170,7 @@ static void icc_activate_irq(GICv3CPUState *cs, int irq)
     if (nmi) {
         cs->icc_apr[cs->hppi.grp][regno] |= ICC_AP1R_EL1_NMI;
     } else {
-        cs->icc_apr[cs->hppi.grp][regno] |= (1 << regbit);
+        cs->icc_apr[cs->hppi.grp][regno] |= (1U << regbit);
     }
 
     if (irq < GIC_INTERNAL) {
-- 
2.34.1


