Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C68E7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQZn-0002Q4-QD; Wed, 24 Dec 2025 10:15:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQZF-0002Fx-R7
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:14:25 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQZD-0002zh-A2
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:14:25 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b734fcbf1e3so1199710966b.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589261; x=1767194061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PUlYIf5k+X4CyTKiZX3SNJm39SXnRKIc/98ptlkBn0w=;
 b=FnpR1hK3FFLjgyuU3N4vKKD2CY7hC/8oj+TNtarHlySSz6lY+mkGaY6u8u8tk9VKpz
 LCLPRfnD4SbU0RFD4gRYHRoAQcpw1pLNZDUxyJWdKce42hAb4T4IhJHUVflQTUm5nnXc
 BA1/4+Qt9Vs4KO28sIlt1CRrQKCLuivDTL9lbE/Yb2fnzlMrH9NpR79AEbNF8WE7ePTt
 RoNxgElAw1LXjuc2eyDs2bTt1hfl3IzKg7SNsqgtJSqx5f0uD8qnuKp8pLFAQ6cLlder
 htwy7wEGRU5liBKBkPuRv3BlZtEfyu/Jc/wu8lgTxMiZOYHAC/jAcOuH1VAJ7W9JSq96
 /T6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589261; x=1767194061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PUlYIf5k+X4CyTKiZX3SNJm39SXnRKIc/98ptlkBn0w=;
 b=iqD5alaux7/eY9ho0ngn+Z9sths++kbQzVCDWx5Xfbedb6QdEUYNrW8m6V7Fsy5LpP
 xGiF1xTJTuliIrZNBu7FQ9a55ihFE3iZOalssIl1ctjY4GDx7GQb8FmIWiLxVvMq1rmH
 6LLCUQkc2D87zXFGT6stZqd+LbHGkd1fKj78mTRGeXCCr3/v3/B1JqInu9Or3dBH9Rfp
 POAQChxzCIiDYpjYibzqzcfv15Vq3bZzxy3nTnz4bHp11ce956/oRAoMirANnh6VIpNX
 zKLwdextbmArDETNTiOrD/5+8yDC7idWpbF5c82qHo/ZK6y2hY1V/hLedZNDqA79JnFv
 3j+g==
X-Gm-Message-State: AOJu0Yz7wXdqH79uw6IwMLDiW31FEWOv22yX3cum5FeRPaOwOYxgoH7T
 4k+EBWgOrVvV+DUKg1k/rabtJAoqPnq1Im8YtXi5Lq1TersnvrupgGdWldL05pWUcWTGHUk90xM
 lzgySXZA=
X-Gm-Gg: AY/fxX63GAjJ5ETp5Mdxb2L2G8dsdAYEudOSNlQUXBmScdbcAOD0V5VcqR9a1dIGvGV
 yVje9jIjxZT+OjKvJnh2bGYkk23QzjYphHNc8VSY+xbQ6t5Od+6vBItoIXpdhM75whT3GJDA05S
 Y+8mJ35v5ieqG6qoZ2mviZACfaZHuAUh8Bi+tHa0EFqZJdLJZXCX2cjevcufJz+qYkVeL7vqu+v
 WIfCjJgt2NC+8pjAPH2WAch5krMLHrtBzZxDthsxr5Rv12yhPx9DZluG25g4VhQTU7p3OwqVCJH
 W/39jccURrJcHWeIkaMdxPW8BzlO+D5KPVfInUuSY9Ps0du/0lkxSro0MewnoY/mdbvHvK64A9s
 qtbOilX/40iBNJ/Epu54Glnl2D2wU8gkh63b0KVwoKDTUcMgRuve4YbbBtNuHVZaNA4wMT7uCXJ
 PVdnLzNlwwwRUpRCCAz5NxR9SEUgJsf7YiSS3VpydO69FMqyiyrziUb2g=
X-Google-Smtp-Source: AGHT+IFJmD60AxObGis4plUd9Q3nrU64xRwX5np768HyiWRbAhvEUFWXoneSECV77wSX9GJelPYf5Q==
X-Received: by 2002:a17:906:d553:b0:b83:1433:78de with SMTP id
 a640c23a62f3a-b8314337b09mr217048166b.12.1766589261418; 
 Wed, 24 Dec 2025 07:14:21 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a614acsm1801230466b.3.2025.12.24.07.14.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:14:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Weiwei Li <liwei1518@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 qemu-riscv@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Troy Lee <leetroy@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Zhao Liu <zhao1.liu@intel.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Alistair Francis <alistair.francis@wdc.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 2/9] target/sparc: Update MMU page table using stl_phys()
Date: Wed, 24 Dec 2025 16:13:43 +0100
Message-ID: <20251224151351.86733-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224151351.86733-1-philmd@linaro.org>
References: <20251224151351.86733-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

stl_phys_notdirty() is supposed to do an optimized CODE
path store. Here we update the page table via the DATA
path, so can use the normal stl_phys() helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/mmu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 217580a4d8c..46bf500ea83 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -189,7 +189,7 @@ static int get_physical_address(CPUSPARCState *env, CPUTLBEntryFull *full,
         if (is_dirty) {
             pde |= PG_MODIFIED_MASK;
         }
-        stl_phys_notdirty(cs->as, pde_ptr, pde);
+        stl_phys(cs->as, pde_ptr, pde);
     }
 
     /* the page can be put in the TLB */
-- 
2.52.0


