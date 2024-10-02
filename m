Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D23CF318A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 01:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svnmD-0006rc-BO; Tue, 01 Oct 2024 21:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1svnm5-0006oq-EX
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 21:03:31 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1svnm3-0002cn-UJ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 21:03:29 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20b90984971so28206775ad.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 18:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727831004; x=1728435804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wmgSaVL8dhq5nP6b5OzdsZKAt0sQ4+L9Gnx6E+G/OOg=;
 b=kuy4bQaOTyF7ajxxyWG/s9vXIDYJYrs99zBkemxpNM+kXGNl9/1tQsoKh8IXuCAAaT
 bEtmrozYEi8knF86lT+lh361HpZ5Wqelhq5hh4jAmMXbZJ2+BAxQ78lFGEKLzV/sGR7Z
 /auLPwpJdd8RAjaWSaE7/4hHaKg99BLpjxHvYtUpRkT+uGVl/YyOCLeATWZarAQv40id
 +hkZK7Qf2YYhy/rfjcqP2DXWX9nLPMTzZHtQ2cY0TSaW00iHskIRXPFc4VpzvyjiajVp
 QjlsUXNuunoN7ATun8JjSV+own3U86ocdq/B/XjDbU/l2S9ag9jiJrVbTXc5HHlXQYRU
 nqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727831004; x=1728435804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wmgSaVL8dhq5nP6b5OzdsZKAt0sQ4+L9Gnx6E+G/OOg=;
 b=Fi8FVTsj9YIah4K7NjCbemGEBEpcPGExOpD9dDStxFRW3sfRD5hbTOV30g3XHVlxVP
 EUkHw2a4pGVGbkyLRGSly7dxSEmCBK7fcq5NDkbWg/ran4K+wQizWnu6E/S1R7dcigYB
 eGJRLCY7jqyc1J39ne8RryIZ8iZ0Xe3lD3qNcSFxEweGnkmCjYERcIdH1RAJYvWv45cs
 x7LXLK8bGwl/5moSXRI301oXJh5HIH4hs9v9rmwMFJgw6qi0fnUGXsunVNrjrAERIKsu
 oQCnLRvCnwq+7Cn7Y60EpTqncBIUsXVt0K/W81maR+6TaSGkerf94nnTQDiDxndqxuc9
 xT0A==
X-Gm-Message-State: AOJu0YzHlSWlilNpcST6Bv1SaM2PzaS3n0MHbbENfFy47TPnsq5+rD7v
 SGhQiX+V3UBUj8YpwSGatLaIimyfM6wTAPplr0HFVwDvhYk0Nj+dRbB/m7vNGUY7pUEqtSe65TF
 U
X-Google-Smtp-Source: AGHT+IH6JuTJ5NboyDCO+EIPRQeTUc8JJYhB/Pse/bvHGVO2ayP+knEHQdoqII+cVOKaBEMjXHHteg==
X-Received: by 2002:a17:903:986:b0:205:968b:31ab with SMTP id
 d9443c01a7336-20bc5b0016amr22693675ad.58.1727831004546; 
 Tue, 01 Oct 2024 18:03:24 -0700 (PDT)
Received: from grind.. (200-206-229-93.dsl.telesp.net.br. [200.206.229.93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37d63971sm76061295ad.4.2024.10.01.18.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 18:03:24 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 peter.maydell@linaro.org, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Frank Chang <frank.chang@sifive.com>, Jason Chien <jason.chien@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 01/12] exec/memtxattr: add process identifier to the
 transaction attributes
Date: Tue,  1 Oct 2024 22:02:56 -0300
Message-ID: <20241002010314.1928515-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002010314.1928515-1-dbarboza@ventanamicro.com>
References: <20241002010314.1928515-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


