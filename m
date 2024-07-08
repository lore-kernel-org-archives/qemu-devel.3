Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28602C3DA41
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 17:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQsGm-0005Qd-Du; Mon, 08 Jul 2024 13:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sQsGk-0005O7-FX
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 13:35:18 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sQsGg-0007wS-6D
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 13:35:15 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-652fd0bb5e6so2829238a12.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 10:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1720460112; x=1721064912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wmgSaVL8dhq5nP6b5OzdsZKAt0sQ4+L9Gnx6E+G/OOg=;
 b=HqepzWbSg9tmDDdM7wOhY0Pmo5s4oIVl2LepvHaP3d8ntDpD8lhavCGvRm3dUXLzFS
 YKSj9I9EFKL3MO6UblujYF09AM29PAIUbqrrsbHjxJmGPiwueei8q/ftDGSi/DPFfJdj
 eR2kuQ2cEBTANvCpbtRD4cp9IizNBBGwg5civjx7vkLB0nPZm8T5GIBzrrIBhZ3zLEO2
 8r8lsMFdwgp+17NDqI6PAI1+teQKNrwqpeOwX9RXkRmw5/pWXGIzht7o1LKCizVpt6nx
 kXcYe7skUUITyjpwBvdyl0q7Nj6ScCfwW7cg2InD7wHup657qbmgQpb8+e3ch9dfPLZT
 +0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720460112; x=1721064912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wmgSaVL8dhq5nP6b5OzdsZKAt0sQ4+L9Gnx6E+G/OOg=;
 b=wsX6OOBs9pF3r4XjZZryoILUesbHhVU1JcMp74vmV8OwdDXqDe1jiTMav7KXKreOos
 yo3QCA+Ilo8BWSJgqD4W5hOyyDV7f3P/6H0Pj2LB+uKYmRYOFUYSBq4icBTo940af1pJ
 V2lLo81H9S0lO+sPhwZuJCAriOzdCnW8k2UYMRfL1VWw96BYfwGrcVGlKLHAoVLbs8BH
 y5+3uVYj61ODwbn4U4SM9XBQyPsnIK/vodaMgyVcCWFeRS/SqssNmg7BwIlDsAOVMrvD
 0Ipn7jrjIIqrFQFZJFMSDobyRo+yXhMjFP4sOTk1TkBB/iYe+nisLaEYspANUPP+IrQW
 qAQQ==
X-Gm-Message-State: AOJu0YzwN/9LqQ/F2MW5YL0iU11LycQ401BSIvPbr5G0srexnvZk5JLf
 QkYilnzys0qwHdtcm329mCSzFItWL1b261SaiirMC9Qltus7wwWWxpaditWoynGX9cez2zw0+eU
 V
X-Google-Smtp-Source: AGHT+IEF4S/Ug02FP2cHw8eSHYhGADMaSO1eafez+93+NAlCfqxMbOGmSbiF+jQZGn/Qi2fSxQJW5A==
X-Received: by 2002:a05:6a21:186:b0:1c2:8d2f:65f5 with SMTP id
 adf61e73a8af0-1c29820b88amr114752637.15.1720460112072; 
 Mon, 08 Jul 2024 10:35:12 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6ad3829sm1153765ad.299.2024.07.08.10.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 10:35:11 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 frank.chang@sifive.com, tjeznach@rivosinc.com, jason.chien@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v5 01/13] exec/memtxattr: add process identifier to the
 transaction attributes
Date: Mon,  8 Jul 2024 14:34:48 -0300
Message-ID: <20240708173501.426225-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708173501.426225-1-dbarboza@ventanamicro.com>
References: <20240708173501.426225-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x533.google.com
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Extend memory transaction attributes with process identifier to allow
per-request address translation logic to use requester_id / process_id
to identify memory mapping (e.g. enabling IOMMU w/ PASID translations).

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 include/exec/memattrs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index 14cdd8d582..e27c18f3dc 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -52,6 +52,11 @@ typedef struct MemTxAttrs {
     unsigned int memory:1;
     /* Requester ID (for MSI for example) */
     unsigned int requester_id:16;
+
+    /*
+     * PID (PCI PASID) support: Limited to 8 bits process identifier.
+     */
+    unsigned int pid:8;
 } MemTxAttrs;
 
 /* Bus masters which don't specify any attributes will get this,
-- 
2.45.2


