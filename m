Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD7AC02182
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyiB-0007c3-64; Mon, 20 Jan 2025 15:49:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tZyi1-0007Ga-Lx
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 15:49:22 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tZyhz-0006Mm-SO
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 15:49:21 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21bc1512a63so91044135ad.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 12:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737406158; x=1738010958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w8Zk6h0bVmQwQ8Hz7dRn07keIxPfHL2v5GahEzPttlE=;
 b=fvfQUnA4n2NHeb5zAiFVO5nsX8boOrRT5Ef08mwSZRp0XP878vwAGIFZpJAftSF4/U
 qtuqoBGhVurPuHj/wYg8pAxSrq1ArcyrYTefQwF4KiZD1+j60Zw7Em1hY/fklNmhm+MT
 a7s5IPWliUtvZrso2wcpSTZgKRyNd04dApLzh+lyzgzmRmpxoRB9ZzuhYSTo5CcNL+Tm
 KyjM48Ttwg89Lv1ut9fVFpSXvcpJOjlDtGSmDzyT7t70TXdhSb1QJ8rDX2lMBc2PJefB
 Ak3KZ+lXs0qgeRP75JbQX930kK0w4+n4o2NBplCKTfw3CNqmc6FV6KMk323239O23RJH
 EjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737406158; x=1738010958;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w8Zk6h0bVmQwQ8Hz7dRn07keIxPfHL2v5GahEzPttlE=;
 b=ISiuJRRsUz9cMFi/G5OdYKVjrW7q3EzVHnqv64zKWxX+XZpsImOIgxtScjTSXkM+it
 nVumVFnk9duiK9DWnNri8Pvn5wCrUyx4aBVWTj+F54zGEJUhd+cxKDhxNAnKx/DixZkx
 Eo4kheLfoJixvZ+/SDW4h+nlK3ISpo/VleRSn7QA8sOELD/GLEYV5EQVflvnx0Wujq6n
 JOSOElaLPmDXjPRqcLsp8Fxn9O3SJw0/mB804vBV4pE37MVqoZKmYk9sQpDxY5j3me+C
 SMeAVwEGMWdEo3KU8vKHoP4SHzn6QxSMs4xTraDoTm+lWYwIFeYqtiVs3fboJoVGsMLO
 xunQ==
X-Gm-Message-State: AOJu0YzVgwpkQmR+CtuIgntQZVtztylYS34DS6FgCuQw+W0YAdFurUzT
 DYNKSjUS/sTSobp1Jmj1Gl28bSD3ReCHxZgDErIZm7HF5WWw7xGgK9fBouDVQeeLj70WEsQve0C
 x
X-Gm-Gg: ASbGncu6VnGQ1943IDlkFTTPlz5F6sNJ2UoPJ+kkd2EZbva3t9f9t4VSATEROqISnlc
 J4qFxwKJucydaw2RfjxjQjCqlIT1v2RrKT/0suemhvJ6QfI9lezbI7BJqQLdTGGZFCDkIwEI1Bz
 PBjZ/0YMdSFdZnTN7j33vunWxj7vBunKE4mXaM4HJKmDpcw8zISBmYd57/b2lIAFZ+s8ScQ8KaU
 Jq3q+TGAjlYHpA1/+Z5l6HIPF37lTpeWeB8jRa/vsIjil6qX3SLgWHwBnjzSBXBIAUneTz8OA==
X-Google-Smtp-Source: AGHT+IGRL/xtgKUFL2UvRPKXkznXNBImzsv/OFW2saAyuPU99lJDagf3DwQgzCtRgefwA9Gp0AIGTQ==
X-Received: by 2002:a17:903:22d0:b0:215:63a0:b58c with SMTP id
 d9443c01a7336-21c356780cfmr189555365ad.46.1737406158083; 
 Mon, 20 Jan 2025 12:49:18 -0800 (PST)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cea08e4sm64865025ad.7.2025.01.20.12.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:49:17 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 0/2] target/riscv: throw debug exception before page fault
Date: Mon, 20 Jan 2025 17:49:08 -0300
Message-ID: <20250120204910.1317013-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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

Hi,

This second version implements the change Richard suggested in v1, i.e.
do not search for wps twice.

To do that we need to make an assumption that a watchpoint for a 64 bit
address will have size 8, in particular when the user does not set a
watchpoint size. To be consistent we also need to consider that 32 bit
CPUs would use watchpoints of size 4, which is something we're not
considering.  Patch 1 was added to make things more consistent in this
regard.

Patches based on master.

Changes from v1:
- patch 1 (new):
  - add watchpoints of size 4 when dealing with 32 bit addresses
- patch 2:
  - instead of looking for watchpoints twice, call
    cpu_check_watchpoint() and rely on fall-through in case no
    watchpoints are found
- v1 link: https://mail.gnu.org/archive/html/qemu-devel/2025-01/msg03575.html

Daniel Henrique Barboza (2):
  target/riscv/debug.c: use wp size = 4 for 32-bit CPUs
  target/riscv: throw debug exception before page fault

 target/riscv/cpu_helper.c | 19 +++++++++++++++++++
 target/riscv/debug.c      |  6 ++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.47.1


