Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEB9C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 20:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKNSE-0001nb-Ao; Wed, 28 May 2025 16:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uKNRw-0001k9-DQ
 for qemu-devel@nongnu.org; Wed, 28 May 2025 16:32:39 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uKNRm-0001tm-BF
 for qemu-devel@nongnu.org; Wed, 28 May 2025 16:32:30 -0400
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6fa956f0f16so3287926d6.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 13:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1748464340; x=1749069140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1YismayB4SIJR2QTxoRpMlz0MW7faH8SO3fEZ+tMWWY=;
 b=KlB2SPvfRxa7UXfCTRFAw/yUaZaVpDRzpM/M2l87RWfyUtqESLcO6SfkG4zhlcjrVk
 2ZflOZLx87L5gzqEcCd6YS2401S5iTACnTc0Ga187kuAHMpbD9CszTNn96PItkSdZr+4
 4StGSnYg4CkNbx2GlLocvHvJzBdgh/FwSwU/F20QkYOwFPmm1tALvAs+UCeAITz9WuIo
 z8eWLj5Jzt2oB6N4VVCPLqR23QQF2WlDRWOy2Iga1zE9UrEXiN1K4VubEy5UXveuCA99
 pn0xumOvPIYYEELnJ2JJHngpNnQw1xLKVU5imFAY9R9OWFf6GQY8NadBrYrXTwiAquKg
 8gCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748464340; x=1749069140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1YismayB4SIJR2QTxoRpMlz0MW7faH8SO3fEZ+tMWWY=;
 b=kUmPSpaSt0xg3BKHlCVKC8z9hwxJs56HH+RYFxK0ZhXekbRMMLYBgc7jG01cMQCTuC
 YjN1jNve5hC1F9Fohri4hT/d12lyNHNgKY6gpgGkBAuf5QLZBLbaalONisLum/BFB4TP
 Axx4g7X7Ngkj8t7+SC/OaVhAl5Q5jBngCaS7FJTUGbHPfwuJeYh8xOPioCGyLG/mx7lm
 U5tNR7WYrk8DgUdSCw16MXfMZyBLUEJVw9aEuDGYs+DWjWz97U9sCxZT9gkapiTAwypt
 E69Xa2OkKEHG4/W4donf/M7eBDTSUrXdJR/nXp+Ibyj9XyyepZBVfvS7zW7UuSxHE6bC
 xswA==
X-Gm-Message-State: AOJu0YwDf2C4GHYDK3UN8i63IJ8sMJFhWBzp/692yH77z2GgBFbv3NAD
 lECV38mXcnNoXtcj9MHrESu5Ju7288lwSWsU+KrlyTN17HpU++NFqxkD/H8tUbNDeZQdFN6oz4w
 0mlXN
X-Gm-Gg: ASbGncuVneNfNyezYj8Q3AUGqn03v1gbWFpGLbYBBWV5xm7TQ7UK2k10eoQlrx47qTk
 UJkMm2PTPWRdcctP1TSD0m7BdglI84HZZpYt41F4YHlODDwI5l/OuvBESUduiOjv+MXuex4SgpC
 BdxlVqaWOsPgOwxaOPLbJXKFOH6c5aeR7LXt7hV1ECPOMP/+RDh7Cm1v2ybnILi1trZTq3b0j7j
 lIczi48mbGZ3cm3o4NM/le1oISG20i0hQM8RVlPOEh2d7tOOTeWUojUme4Oq/kfFfzNizOJhW2G
 MgqIKJYA1+35usMvIxhp/yCO99HXWuFTdvw0eXLm+p7WAHwgDCaIqo9bURNYudead8pUtQTojqJ
 UO0U=
X-Google-Smtp-Source: AGHT+IEamB1HaY/n+6OTkUesbtkkbClAPzjOE5WGp30xeCumaYwhwWDMjhqeN7S0DtEZv5Rr1ffOxw==
X-Received: by 2002:a05:6102:2912:b0:4e5:a83a:3cee with SMTP id
 ada2fe7eead31-4e5a83a402dmr2679193137.14.1748462506598; 
 Wed, 28 May 2025 13:01:46 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([191.255.35.190])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4e59fc11a95sm1393736137.3.2025.05.28.13.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 13:01:46 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 1/4] target/riscv/cpu.c: remove 'bare' condition for
 .profile
Date: Wed, 28 May 2025 17:01:26 -0300
Message-ID: <20250528200129.1548259-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528200129.1548259-1-dbarboza@ventanamicro.com>
References: <20250528200129.1548259-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qv1-xf34.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We want to configure other CPU types to use profiles as an alternative
to adding every profile extension explicitly, i.e. a profile is nothing
more than an extension bundle.

This means that a vendor CPU can set .profile=rva23s64 while having the
same handling as any other vendor CPU. Same thing with all other CPU
types.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fe21e0fb44..4a30cf8444 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2713,7 +2713,6 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
         mcc->def->bare |= def->bare;
         if (def->profile) {
             assert(profile_extends(def->profile, mcc->def->profile));
-            assert(mcc->def->bare);
             mcc->def->profile = def->profile;
         }
         if (def->misa_mxl_max) {
-- 
2.49.0


