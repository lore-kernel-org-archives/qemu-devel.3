Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C6FD75E5C
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 17:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEttA-0007bU-Nx; Sat, 23 Nov 2024 12:25:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>) id 1tEtt7-0007au-9s
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 12:25:41 -0500
Received: from mail-m16.yeah.net ([220.197.32.19])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chao.liu@yeah.net>) id 1tEtt3-0004w8-MS
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 12:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version:
 Content-Type; bh=E3sijzoWZReTHUH3OjmWWLOvn6tgRh/DvyVq3jhJP2o=;
 b=l4aAQVp6tuZE/LUC0a736gB5UyqnM3sh2yt0rhjAbzp+rEODTKar/g61GGLqsi
 wghHJYRgyyt0LCkJL8F9XU1X6ZACR0UMd2vkITIiLkriDM8nI79HnErVEgjDqWED
 L7YSsSqX0BOIkYnB2fiIFopWVHxK4hh1jSgPkhA4Ym01w=
Received: from ulan.. (unknown [])
 by gzsmtp2 (Coremail) with SMTP id Ms8vCgDX3zD8D0JnTuE_Aw--.3002S2;
 Sun, 24 Nov 2024 01:25:17 +0800 (CST)
From: Chao Liu <chao.liu@yeah.net>
To: qemu-devel@nongnu.org
Cc: bmeng.cn@gmail.com, liwei1518@gmail.com, peter.maydell@linaro.org,
 palmer@dabbelt.com, alistair.francis@wdc.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Chao Liu <chao.liu@yeah.net>
Subject: [RFC PATCH v1 0/1] Add helper_print functions for printing
 intermediate results of complex instructions in RISC-V target
Date: Sun, 24 Nov 2024 01:23:37 +0800
Message-ID: <cover.1732376265.git.chao.liu@yeah.net>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ms8vCgDX3zD8D0JnTuE_Aw--.3002S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF4UtF18JF4xAryxXr1rXrb_yoW8AFW7pF
 45uayYyF4DAFZ7Aw1fJw4xtw1fCFWrJw4UXwn7Jw12ywn8Gas2vF4vka4Y9w1UArW8ur12
 va12qr1UuFyUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jp-eOUUUUU=
X-Originating-IP: [39.144.154.56]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiEQ+gKGdB+IgyegAAsI
Received-SPF: pass client-ip=220.197.32.19; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Hi all,

Recently, I have been working on functional simulation and verification of
an extended complex instruction set for an AI chip based on the RISC-V
architecture using QEMU.

Given the complexity of some instructions, I attempted to introduce a set of
helper functions that can print certain intermediate results of IR
corresponding to a single instruction, such as those from sparse matrix operations.

My implementation approach is as follows:

    1. Encapsulate printf within helper functions (to avoid issues where the printf
    address might exceed the ±2GB address space when called directly). Since helpers
    do not support variadic arguments, I defined multiple helper_print functions with
    a maximum of 7 parameters.

    2. Designed a syntactic sugar using C macros and the concatenation operator ##
    to encapsulate the aforementioned helper_print functions, which can support up
    to 7 parameters.

However, I encountered some issues, such as having to set < #pragma GCC diagnostic
ignored "-Wformat-security"> for this piece of code, but I think there might be
some security risks involved.

Currently, these macros are temporarily added under target/risc-v, but I believe
they could be designed more generally to support more architectures.

During testing, I found that these interfaces work particularly well for debugging
simulations of complex instructions.

Therefore, I am sharing this patch with the mailing list in hopes that we can discuss
and come up with a friendlier and more universal solution. :)

Regards,
Chao

Chao Liu (1):
  riscv: Add gen_helper_print() to debug IR

 target/riscv/helper.h    | 13 ++++++++++++
 target/riscv/op_helper.c | 46 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

-- 
2.40.1


