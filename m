Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862CFCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 14:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8K12-0000r9-H0; Mon, 13 Oct 2025 10:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jelly.zhao.42@gmail.com>)
 id 1v8Ifx-0004Bs-BL
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:33:21 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jelly.zhao.42@gmail.com>)
 id 1v8Ifv-0005uy-EK
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:33:21 -0400
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-781010ff051so2965392b3a.0
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 06:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760362395; x=1760967195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+rmIkcesCZbV65wMzxLVesuiJwsScxdnuGmjreKaQZU=;
 b=gr4uFRfe74/lz+Ui4ev+DBOfEXpu5IOItzAo/i8cWetkxOyl6b39N6pMn6q2g6in+G
 7n7fqCguSAjORrLdvloxIYNnZkSJDfkLnl3RZrAfNTg0ciXqDlKjqVFtg05pEeRUBBL2
 6V8ZONW4SBX34f6r1SgNeoyDusj6TVrTJhDvcG5Zx5veFzkKbGbwIz9CYFeq/cJvdgqK
 JarVsTXCFFoKpqCdSVEXgGyry3sxd8W9C/mNIgXMLgVZPmJxINiLAcbjpNBoDJFI5QnV
 305VUwqzODv7q1L60NkUeZZa7EDPeRlriZutjyTRsC30PpgZeL+t3r/pwGP5AujdVI9/
 q/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760362395; x=1760967195;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+rmIkcesCZbV65wMzxLVesuiJwsScxdnuGmjreKaQZU=;
 b=sdSVg+ZM3hfQtwR9tPCV8HFK+ACvNfFaV9+e0MWC6rIhgRcz6/yeVBMSOWVwsWi60N
 Wk2fWE5+EZiVIsSxDBJWZaL6rJvM2M2eKHsSE3iopATIqE22/IgdkHWkAzEKOlYPVEms
 bewF9ExGQ7vCh2DOEg+3KhDy5Fy/aOzYKzjMak8//7yJuy7qq0TcWZSVoNW+Ng0mFw4p
 ew+1LSNR7yAaCwKOPi9sNdwjkTVMhZOWlu6eSvs6gjsBDcmYsILSUnwshMygnLDdQuLu
 xvxA+QtBInNQ7N1Rm8SbModU/LYXHIHr2T6ak3IS8WvRUfrJk5B17+yliW2K6hIGfFV0
 7OpA==
X-Gm-Message-State: AOJu0Yz2LHuj7BcqvXipSngnQQ6IRzic0hCx4X5UkLYs8hUxv9lx8Pqz
 XCHHQtvZBNlCUglF27V6DPKd6nZiXBqm24J2B7/gKApP4Z/Fj1eItZUoAUtqXqlfIts=
X-Gm-Gg: ASbGnctA5VskneJt+Swl+F8DUWTsfwyUBKAgm9u5Dl7Z9m8vpE1V2Snz6SuzHMWQbEc
 K6oE4JzcDUV8muu/rOCCPZ6zK5ny4D+xri9e0mAPhV9JQxKFvyE9wS1LHF0eqbfys0Y+Nmgkb6d
 dfCD4F17mlHueOpG8iEkVe9vWTL27ExnLmCN/NdmaC3YKfFQqbn2cdl6sdUkXrr8lG9fadpoEVo
 1IFf5AEAcO6hTne69o06smP7RFceOnAPy/wNqu0RHQlxna+g3GRpEVT/jWSc5guwBuSWABDmTpk
 Rn2Lxu/kVcQTUz4uirQiBR9qRj0dvGCwiRFnw1+bp47jLHkjbDdGBttlc7rCkUR6uKEUYjM3NqA
 shdQahPPjNUEOQlZJH5ImuG5J+sZJr048E5hif3GoB0VmLVCiAmv7qyfT4NP1G1kxER+Jzg==
X-Google-Smtp-Source: AGHT+IHM9ymlKRaFbub/4VZwVCvD8gcVK1uX2DZj1TUWcekU7FP3zjXZ6YlypHUfoDtjMPxr565qFQ==
X-Received: by 2002:a05:6a20:3ca7:b0:32b:6e08:e545 with SMTP id
 adf61e73a8af0-32da839f237mr30704588637.36.1760362394832; 
 Mon, 13 Oct 2025 06:33:14 -0700 (PDT)
Received: from localhost.localdomain ([103.116.72.131])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b678df233cfsm9300532a12.28.2025.10.13.06.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 06:33:14 -0700 (PDT)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Zejun Zhao <jelly.zhao.42@gmail.com>
Subject: [PATCH] hw/riscv: Correct mmu-type property of sifive_u harts in
 device tree
Date: Mon, 13 Oct 2025 21:32:42 +0800
Message-ID: <20251013133242.1945681-1-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=jelly.zhao.42@gmail.com; helo=mail-pf1-x442.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 13 Oct 2025 10:59:09 -0400
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

Correct mmu-type property of sifive_u harts from Sv48 to Sv39 in 64-bit
mode since it's the only supported SATP mode.

Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
---
 hw/riscv/sifive_u.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index d69f942cfb..3e1ed209ca 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -176,7 +176,7 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
             if (is_32_bit) {
                 qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv32");
             } else {
-                qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
+                qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv39");
             }
             riscv_isa_write_fdt(&s->soc.u_cpus.harts[cpu - 1], fdt, nodename);
         } else {
-- 
2.43.0


