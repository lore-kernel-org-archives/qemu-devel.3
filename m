Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57182C369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 04:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9yi4-0001BD-LI; Wed, 30 Apr 2025 00:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1u9yi0-00019A-D3
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 00:06:08 -0400
Received: from out28-122.mail.aliyun.com ([115.124.28.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1u9yhy-0005U6-7R
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 00:06:08 -0400
Received: from TC-DZ-03-0020.tc.local(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.cbi39JA_1745985952 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 30 Apr 2025 12:05:54 +0800
From: Chao Liu <lc00631@tecorigin.com>
To: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com, philmd@linaro.org
Cc: zhangtj@tecorigin.com, zqz00548@tecorigin.com, lc00631@tecorigin.com,
 qemu-devel@nongnu.org
Subject: [PATCH v1 0/1] Optimizing the print format of the QEMU monitor info
 mtree
Date: Wed, 30 Apr 2025 12:02:22 +0800
Message-ID: <cover.1745894489.git.lc00631@tecorigin.com>
X-Mailer: git-send-email 2.47.0.windows.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.122;
 envelope-from=lc00631@tecorigin.com; helo=out28-122.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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

Hi, all:

Currently info mtre prints the memory-region hierarchy using two spaces as
indentation, which is not very clear when there are too many nodes.

```
(qemu) info mtree

memory-region: system
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    0000000000001000-000000000000ffff (prio 0, rom): riscv_virt_board.mrom
    0000000003000000-000000000300ffff (prio 0, i/o): gpex_ioport_window
      0000000003000000-000000000300ffff (prio 0, i/o): gpex_ioport
...
    0000000040000000-000000007fffffff (prio 0, i/o): alias ...
    0000000080000000-0000000087ffffff (prio 0, ram): riscv_virt_board.ram
    0000000400000000-00000007ffffffff (prio 0, i/o): alias ...
```

Therefore, I optimized the print format of this command to be similar to the
tree command, so that it can better distinguish multi-level memory-region nodes.

```
(qemu) info mtree

memory-region: system
│  ├── 0000000000000000-ffffffffffffffff (prio 0, i/o): system
│  │   ├── 0000000000001000-000000000000ffff (prio 0, rom): riscv_virt_board.mrom
│  │   ├── 0000000003000000-000000000300ffff (prio 0, i/o): gpex_ioport_window
│  │   │   └── 0000000003000000-000000000300ffff (prio 0, i/o): gpex_ioport
...
│  │   ├── 0000000040000000-000000007fffffff (prio 0, i/o): alias ...
│  │   ├── 0000000080000000-0000000087ffffff (prio 0, ram): riscv_virt_board.ram
│  │   └── 0000000400000000-00000007ffffffff (prio 0, i/o): alias ...
```
--
Regards,
Chao

Chao Liu (1):
  system: optimizing info mtree printing for monitors

 system/memory.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

-- 
2.48.1


