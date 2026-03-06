Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2C1FCB614
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWfv-0006Y0-8E; Fri, 06 Mar 2026 10:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfP-0004o0-8B
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:45 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfH-0002nY-QW
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:34 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso95658775e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809230; x=1773414030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VshKwVWpfXbn67UBtFqN1jPj4A57V6s0t05IuGZWGMw=;
 b=DlheQRZ3anWUQuqikx85Ok1wKr58wP6zZ1AHSe6H0bShVuupybCZ6RDqVquxDOItL/
 g9AdPGIqB0F6NlY8UrZBhJEZG/009nAGJtRTdIGGEFCGhTiM3JgtnqpbfPaRFkh/rujA
 sb9P+cBo7kcxeeYmSv+v3qysEIfA/zLZaCPSaDICNF6SiwuaxAEL3MDEXa9pGxBYL2oj
 DWRt6XhBY2uNrxVK8obIcf5Pl4UuciKd2CHDe+BsoZ3CZu4I/Jdq+BdnrMiTc9/I/lA1
 g8QjpYBDfkceq6b0x+lWFUIpwbvoVODlyMOI/Hxux1aKfYD5r7+RhoItCQTELdav1dXd
 KG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809230; x=1773414030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VshKwVWpfXbn67UBtFqN1jPj4A57V6s0t05IuGZWGMw=;
 b=xU5vKEVa8oACYNLBsSGS4j6b5UrWbbuamBJLXWZETx7i1zM5/ExPcxf4+MX9ODyvnp
 BYHtjOlbBB7PjTKeXwZ1zS+aPRDyECl3cmwRXOWKMDO60ZIaTWZmKe01fhfkeyv4WrTH
 Lo95ZFRRrIgyv8L7XXRUrk2Do/kk+PnYcoHP1nsoKaPb5klZ3Te5BWnNeGQzYtTKuBfO
 RZ8BoYHV2pRygsRuNhIbo7Imlwz531ga6MgV8IUSqc/5dTgnwmRaJWxWzFZG9Wc6v903
 Kv67qivzeZWJ2yKnr4rE39Obnl6gVqVPJsKsywxoy6Ec2xwWUSNoewGxZ8Bk5dE6mnRH
 vB1g==
X-Gm-Message-State: AOJu0Yxgd5spd3MYFdmRhXYWNwhkL3T2TVFktS4A2HXDwEuo12uuuPYc
 h1Yuqq9mPTPFPw6wWwHLZ9eRkTFSdNCMNERvfG87ooJl7iKQ/IbyWPxb560b2jrjU9fhmUz/Qzp
 ZwR73
X-Gm-Gg: ATEYQzyxxoybBwqaaigaKonsekDgRj9cC9dhWnwQlS6czE11mm4NlyIGwNwCoLdy9WR
 htAWhb2UME2OHOW0ZvFbIpsDIL5l3YBh2p8n7sQbiPDNo1h3PjM8tn9bWTWdA+dkDIIIhAaw2NO
 RXWZM2H5puzCUYN24GhOjk/pcR/spu9dBgxtA4hox8xy53iHGiYEJPPads/BupVsQdwJbvFQkqZ
 rYWeoJEqQVQdpdaEqSJU2CuEsOeWKWHNuuCoK2cG6gAxKo9pHA8FZ2LXFvPE1L6wMBXRRldwuny
 2mYTNep5sfmleCogjL646qsnsjskC3GT1a31XFdve0b+f+vdMqFbuVViBnMNg7kqZr4fYGL97g6
 5j/ryzetZg5b3IGmelv7XzUa4BE7KIyGGQdR8ZqQcr+y19o0xNYHZL5jdQjF9wpxfBaAHTQbNZp
 RfWYrS1xa4cUFSeyCWk5RG21vdOTZR1wbqrKc2N82DKSdTLeYes456WobotQMwThw/WU6d9WMLT
 INhVUSwqGVUYRBWhuNSHBJJTp3VNwY=
X-Received: by 2002:a05:600c:a4f:b0:47e:e981:78b4 with SMTP id
 5b1f17b1804b1-4852674e8damr40388355e9.12.1772809230004; 
 Fri, 06 Mar 2026 07:00:30 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/49] hvf: only call hvf_sync_vtimer() when running without
 the platform vGIC
Date: Fri,  6 Mar 2026 14:59:32 +0000
Message-ID: <20260306145939.2162189-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Mohamed Mediouni <mohamed@unpredictable.fr>

When running with the Apple vGIC, the EL1 vtimer is handled by the platform.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260306130107.35359-11-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 35b2de7b7a..8363e10eff 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2356,7 +2356,9 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
 
     switch (exit->reason) {
     case HV_EXIT_REASON_EXCEPTION:
-        hvf_sync_vtimer(cpu);
+        if (!hvf_irqchip_in_kernel()) {
+            hvf_sync_vtimer(cpu);
+        }
         ret = hvf_handle_exception(cpu, &exit->exception);
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
-- 
2.43.0


