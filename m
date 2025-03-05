Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C081CC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdxa-0002ln-3Z; Tue, 04 Mar 2025 20:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxX-0002Xx-QM
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:07 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxW-0008SE-6n
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:07 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22349bb8605so121875925ad.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139644; x=1741744444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bz0aYhkElnl1uyIfpqfb71suJK5yTJiBtednXeeG7WE=;
 b=O/ylanJQDf8uODwTerrMMpQZvWIbNxj9YZUM95+v1/2tC9W+GHe1+KnOR45WvTkCyk
 GfuuJEqTr/V0ssHeiu+WFDa6OuHfy+fszhHW5pqWX7NinMBEyAsPKgVJHIhMNgvQt+MD
 DKjJMzf3HblnO7PZvAQj21svQasXBNWnARnLx/h8YnWgcVXEsrtylDiaZYjx6m7ZHFhZ
 7y/lPIRe98oCmgfVbiucbD9m7Xyi0BnD7ifGkmxZS6su1iLUDL4j2Fo2VivWocSWtZXs
 pAMD1nbWmVE2WfbjvI8BPckzI8tOb/mXOCy9uDypBOOauCimmNklXMUcu9X+6/UXSwuF
 lkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139644; x=1741744444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bz0aYhkElnl1uyIfpqfb71suJK5yTJiBtednXeeG7WE=;
 b=ggonKdO0uT0CMrhJiqRkJew1OClIR5K5++bfge29958E6+1maBe3zshAbXkXTJBu2D
 f7Cc0O/nZ/TW4Gu0xlR5MRoLDY1ERjUPA8392AtMHxNR+nzzqI+a/wyXQgKHcPPA+IlX
 COLjskRKN7wABcMBcUcCVEPSf7UvpgQPwyjo8aTbG1p+D6x5yl+vYHXbrH5hhUjiPClN
 Qi/pFvYxqwJCA6YTJ5gmmISJRJxbraFraKDtiiNkT7FmJjWc6oXuyH1mxRFUyryM+XN2
 7RliVI/BpX6DdBr8ulZOF8BMfqJop1wt+3Cpr/Iaz/jQ9O3ojA2cehAnbGbWgXXhFRJO
 1s/Q==
X-Gm-Message-State: AOJu0Yx7+iVp+Stq7Q1g5+zBabI0KEwS/BoOHKXHCbLoY2QIcoX0DyY5
 wXOWBONI1LGp+iT7lFaQ5BAhxdTTmxgJjG3xsSTT+/knG89btvayBnam7+tlsEA=
X-Gm-Gg: ASbGncvTngLwfaYNmx+rfc7fmS/Sb3Ih73mfeuhwTv51f7bVYVNOcId0jYnbqPnzkjk
 jWDWfcqAZwDoTh3daGiej05unkIg5Eov9DiNFkipK+h5zlzjhFQGg86RPXZoUsEf7OI6W34KA2P
 yRFUa1vw0bMPedxZE9xJTg2ZLOUM+tZHzTJzYLpq9cJmy5LGrzhlmRkNz0hlkGWhavL2r7MqMPA
 jBx7naLDEn2w58X3kWwTsvzUhbw0nGQdek4UWlhefjm2XKemgrvn8ZXtZFr94+1kVz1MbQPqY5B
 kfk3lFHgwVAhsMtItFVo/cgPAC4Ntawe9OwzbBdeCpuQoITWPgOFDc5vWR0tTk/EC+4ByEKV9vi
 8ZmYe6izzFcz7HziBacYOwEX/diDqasQlqMbQhfEig4UIDgCIGPo=
X-Google-Smtp-Source: AGHT+IFigdfrZ+C09MBnLd92RuKD9tNm3xmRm4MvlTkM2QyVXz+cgGsTjymUuLDUapH0ARJXNUgWvA==
X-Received: by 2002:a17:903:32c2:b0:223:66bc:f1e6 with SMTP id
 d9443c01a7336-223f1c6afa6mr25929945ad.5.1741139644586; 
 Tue, 04 Mar 2025 17:54:04 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:54:04 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jason Chien <jason.chien@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 17/59] hw/riscv/riscv-iommu: Remove redundant struct members
Date: Wed,  5 Mar 2025 11:52:25 +1000
Message-ID: <20250305015307.1463560-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Jason Chien <jason.chien@sifive.com>

Initially, the IOMMU would create a thread, but this thread was removed in
the merged version. The struct members for thread control should have been
removed as well, but they were not removed in commit 0c54acb8243
("hw/riscv: add RISC-V IOMMU base emulation").

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250115141730.30858-1-jason.chien@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 9424989df4..fa8a50fa24 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -58,11 +58,6 @@ struct RISCVIOMMUState {
     /* interrupt notifier */
     void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
 
-    /* IOMMU State Machine */
-    QemuThread core_proc; /* Background processing thread */
-    QemuCond core_cond;   /* Background processing wake up signal */
-    unsigned core_exec;   /* Processing thread execution actions */
-
     /* IOMMU target address space */
     AddressSpace *target_as;
     MemoryRegion *target_mr;
-- 
2.48.1


