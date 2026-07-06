Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B14CC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 20:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgpWb-0007fT-0H; Mon, 06 Jul 2026 16:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wgpWZ-0007eF-8U
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:02:39 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wgpWX-0005hk-Kl
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:02:39 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 65098600C3;
 Mon,  6 Jul 2026 20:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15545C2BCB8;
 Mon,  6 Jul 2026 20:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1783368155;
 bh=EwaW3pLq+EWjGl8zIVn1ure7hbbIgZjUsSKbTMpSl9w=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=ZSvqNQF1tp1OZnH0/zXfkArS+ha/v87Pzwa6wyfI23s0/ygwhDIoupDoPB1Hr2on3
 rqDRQ1OzhZ5zO6wBM7phObGnpu7Q1/T0XFDfDxoX7TAofwOVRhZO4x7hWFbiAuiQmi
 z+R1G5uXU+amFkT49Pp6d5axOw4XXnkSb1aWuIvbKWsS1Ckzoq8CrdPHyJmuvbN/kE
 kj4PjZoJ3gy8XYdbVnkPZkjF4pcH4sCMHlVMBOmPmINHd5kgGbvNIdD/TE5nSB8BDl
 RRFv3B2nzRz5i0MPk/BfkJKCZ9Aoppv5B52NBFvTYWseoTCsXZqWqup5RWqMOvNoLD
 emVw0Q5IMREtw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E552EC43458;
 Mon,  6 Jul 2026 20:02:34 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Subject: [PATCH v2 0/6] target/loongarch: Fixes for endianness problems in
 vector instruction emulation
Date: Tue, 07 Jul 2026 04:02:00 +0800
Message-Id: <20260707-loong64-be-v2-0-8634f93c1dc9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALkJTGoC/23MQQ7CIBCF4as0s3YMEAHrynuYLpBO20na0oAhm
 oa7i127/F/yvh0SRaYEt2aHSJkTh7WGOjXgJ7eOhNzXBiWUEVZInENYR3PBJ6Hrh6uT2lg9SKi
 HLdLA7wN7dLUnTq8QP4ed5W/9y2SJAltve6NJCNPa+7g4ns8+LNCVUr5AqYrkpAAAAA==
X-Change-ID: 20260701-loong64-be-adf8a15675f1
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Miao Wang <shankerwangmiao@gmail.com>, b4-sent@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2330;
 i=shankerwangmiao@gmail.com; s=20250715; h=from:subject:message-id;
 bh=EwaW3pLq+EWjGl8zIVn1ure7hbbIgZjUsSKbTMpSl9w=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBqTAnOa/5OZrGymVeNI7kxHd8DfHOKVnvA8o9t/
 hxfVydtGj2JAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCakwJzgAKCRCwMePKe/7Z
 btlgD/0VfCXdMOds3aYqYTAjqrRwMfTh6eeh/DeUK2neQHDN6W8+iMvpz2c5VqkGlqRu9MGo9ME
 2H8mefJ5CdOVMhzhMVWxfOE7UajBqpgzqOWfRgm5gLughE+RrzAEja0BLcU/56B7Z4OiRUczKEF
 ez0RyxmvbLav25lFlGd/CFYwpYh+mLvNBtrMI+N9Pu5sIes7GiIEJrEQrDD63WM7bYF0QAvhQPn
 nVaz2d1ASkLlQAtmJg7ZkOQZ7LvQmn+8fVRO+HwDPmcTt7NEnC9GkMBNXKNj8l9x18L0YBCmsaJ
 gQWuWr8cTJm8PfolGsk1txNVIxEOj9+d3CJSD7/AKonJmiv6CXdhpBEm9+gmn21zgM7yJuI28V6
 LUHyo5cFm9Wu1N78ewggUGHbW/FW90AGrJMWlGAljg9jrm6QEJAsZvQVlyuvBod+UTCLNukPs5/
 T7MxHuBp2UdNaM6zAOJDgQr0ubpatX12euTV/sk+L289eaaGpMA9YVf0GHkkbdVI871gSfZlwud
 tqXjKRsxHK+hqEBsL2dEKDf2qVveGchaCWwKpEF9AfI1U7Q549RSm91Fl/Q6QKquijow8tbi4jT
 VkWjLRJrMmmFTEghSTR1nL+GOx90NWxKEQhI3+GfQif9yJuVSrhgOSGzpTYTtOiKt5pYrUhANBs
 JYWQNNmvMl4JY3Q==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/20250715
 with auth_id=462
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=devnull+shankerwangmiao.gmail.com@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FORGED_REPLYTO=2.095, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: shankerwangmiao@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The current implementation of vector instruction emulation in loongarch
target works illy on big endianness hosts. It can be reproduced using
the test cases from gcc [1]. One can cross-compile the target
loongarch64-linux-user for s390x and use qemu-s390x to run the compiled
qemu to test loongarch64 emulation on big endian hosts.

Possible reproduce steps are:

1. Install s390x cross toolchains and qemu-s390x
2. Compile qemu using ./configure --target-list=loongarch64-linux-user --cross-prefix=s390x-linux-gnu-
3. Install loongarch64 cross toolchains to compile the test cases. To
   get an accurate result, the test cases should be compiled using -O0.
   To make the error output of the test cases readable and meaningful,
   printf() should be replaced with a version without any vectorization
   optimizations, since the endianness problems will prevent printf()
   with lsx optimizations from working correctly
4. Use qemu-s390x ./qemu-loongarch64 /path/to/test_case.exe to test the
   cases on big endianness hosts.

With this patch series, all the tests in [1] can pass.

[1]: under gcc/testsuite/gcc.target/loongarch/vector in the gcc source

Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
Changes in v2:
- Use QEMU_ALIGNED(128) on the whole VReg struct according to Philippe's
  suggestion.
- Update Fixes: tag in the first patch.
- Link to v1: https://lore.kernel.org/qemu-devel/20260701-loong64-be-v1-0-9c7d65e00697@gmail.com

---
Miao Wang (6):
      target/loongarch: make VReg aligned to 16 bytes
      target/loongarch: Fix offset calculation in vector registers
      target/loongarch: gen_vreplve: Fix offset calculation
      target/loongarch: gen_xvreplve0: Fix elem0 offset calculation
      target/loongarch: do_vldrepl_vl: Fix endianness when reading from guest memory
      target/loongarch: vstelm: Fix reading from vector registers

 target/loongarch/cpu.h                          |  2 +-
 target/loongarch/tcg/insn_trans/trans_vec.c.inc | 39 +++++++++++++------------
 target/loongarch/tcg/translate.c                |  6 ++--
 3 files changed, 25 insertions(+), 22 deletions(-)
---
base-commit: 30e8a06b64aa58a3990ba39cb5d09531e7d265e0
change-id: 20260701-loong64-be-adf8a15675f1

Best regards,
-- 
Miao Wang <shankerwangmiao@gmail.com>



