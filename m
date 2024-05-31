Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA22C27C50
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 20:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD8rR-0002qt-VD; Fri, 31 May 2024 16:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sD8rQ-0002qb-Q2
 for qemu-devel@nongnu.org; Fri, 31 May 2024 16:28:24 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sD8rP-0000o6-7R
 for qemu-devel@nongnu.org; Fri, 31 May 2024 16:28:24 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7024f09bc92so578281b3a.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 13:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1717187301; x=1717792101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0bdJR0XZ5/24do9SQiq86W34Uey5skxXwaEjBErRH+E=;
 b=ZPkBnqrSgK1Qz9uEyN36e/Q1eMn/TBZFwFhnehtxiXhINlIoODoj5BIJNli5sEaOLV
 f90+AG4YT7MdOwkqlSSaNNLTivRvAeeK1TPOLH0FNGqHn8BAhtdNYJVVj8oMUa8cizMM
 yAHrAEUCMBPQtdINQqLFeOW9+80RDbn5H/yuNpFWW9Kjoq682R7ZTs0fGmZ3Li5rEzi4
 rdrd0DZdPyymf+3gk48w6VvxLYMu7erOvDjk3USNAnj/1ISz3BIDkHewe2yG61csJToS
 t1r9u+lmJ5H+dPT0UaAPC5pXlqio29Inp894uXBwV2jJ4C0esbhI3Eg96AvzDIDLzPij
 DbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717187301; x=1717792101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0bdJR0XZ5/24do9SQiq86W34Uey5skxXwaEjBErRH+E=;
 b=f8qwLFvkC81/XXELGvpZP9pj9wa1ZwATQvb/m5ZxAHP6wUa8tzuy0acVmMlCMxn5Br
 C/l3+wkHxbtsKwqrdbumiZ5b++htT+qDc8qJcNjXCcaE0/b5CsjsZ749yPRKcsTr+W79
 2i1uMeh+eJ2YTwK3lhKGNyGAj0Ia9EHvg4XldhpO+IKrXxZ37fZeTmQ6FxSCycNRCzcL
 +J77f3MqjRFWzz8l/xd2ur9ZtPP+kfl+j9rCNm4j41T1S0DIkZ2p0G5pZUQ9KUFAxFBd
 7Fq2B4ZMoGjn2dKplLzuTRRXL1MMvvmb27fIKLXE2bzaCGQ/vkRFlsy25HECN/v58kNF
 iZjA==
X-Gm-Message-State: AOJu0YxdcTYiqXxh+OuJFNf8/y3k9f2F81/d/FMOvGNpyB6ODGvulSZM
 Ctf1LdcTDf9w/Iiz+C5yu7Of9qpcuhexXY36h94Iz4xiC39ibSiay8oqy2KsVBijaOU5AiVdJb1
 s
X-Google-Smtp-Source: AGHT+IF2T/GZ3JkT8S1HTxAYTAgaqXTDX3NnqWRvJOC99F1H7XWhK8BKeGrTCEJq+ZzzPsZRFWIkDg==
X-Received: by 2002:a05:6a20:729a:b0:1af:597f:4970 with SMTP id
 adf61e73a8af0-1b26f1179c7mr3831730637.24.1717187301094; 
 Fri, 31 May 2024 13:28:21 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (189-69-160-78.dial-up.telesp.net.br. [189.69.160.78])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b09133sm1819691b3a.178.2024.05.31.13.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 13:28:20 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 apatel@ventanamicro.com, ajones@ventanamicro.com, conor@kernel.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 3/8] hw/riscv/virt.c: rename aplic nodename to
 'interrupt-controller'
Date: Fri, 31 May 2024 17:27:54 -0300
Message-ID: <20240531202759.911601-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531202759.911601-1-dbarboza@ventanamicro.com>
References: <20240531202759.911601-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The correct name of the aplic controller node, as per Linux kernel DT
docs [1], is 'interrupt-controller@addr'.

[1] Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml

Reported-by: Conor Dooley <conor@kernel.org>
Fixes: e6faee65855b ("hw/riscv: virt: Add optional AIA APLIC support to virt machine")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 07a07f5ce1..5505047945 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -591,7 +591,7 @@ static void create_fdt_imsic(RISCVVirtState *s, const MemMapEntry *memmap,
 /* Caller must free string after use */
 static char *fdt_get_aplic_nodename(unsigned long aplic_addr)
 {
-    return g_strdup_printf("/soc/aplic@%lx", aplic_addr);
+    return g_strdup_printf("/soc/interrupt-controller@%lx", aplic_addr);
 }
 
 static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
-- 
2.45.1


