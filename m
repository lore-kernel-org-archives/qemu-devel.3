Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7319DC369D9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 02:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAJc1-0006lv-5P; Wed, 30 Apr 2025 22:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1uAJby-0006kz-UH
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 22:25:18 -0400
Received: from out28-220.mail.aliyun.com ([115.124.28.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1uAJbv-0003hE-2N
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 22:25:18 -0400
Received: from localhost.localdomain(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.ccbGxD9_1746066304 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 01 May 2025 10:25:06 +0800
From: Chao Liu <lc00631@tecorigin.com>
To: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, armbru@redhat.com, balaton@eik.bme.hu
Cc: zhangtj@tecorigin.com, zqz00548@tecorigin.com, lc00631@tecorigin.com,
 qemu-devel@nongnu.org
Subject: [PATCH v6 0/1] Optimizing the print format of the QEMU monitor 'info
 mtree'
Date: Thu,  1 May 2025 10:24:39 +0800
Message-ID: <cover.1746065388.git.lc00631@tecorigin.com>
X-Mailer: git-send-email 2.48.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.220;
 envelope-from=lc00631@tecorigin.com; helo=out28-220.mail.aliyun.com
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

Thanks to BALATON, and David for their reviews.

In PATCH v6:
1. Replaced the bool type with enum mtree_node_type to improve code readability.
2. Modified the output to use only one horizontal dash instead of two, and
   aligned character printing for a cleaner look.

like this:

```
$ ./qemu-system-aarch64 -S -monitor stdio -M raspi4b
(qemu) info mtree
address-space: memory
`- 0000000000000000-ffffffffffffffff (prio 0, i/o): system
   |- 0000000000000000-000000007fffffff (prio 0, ram): ram
...
   |- 00000000fe000000-00000000ff7fffff (prio 1, i/o): bcm2835-peripherals
   |  |- 00000000fe900000-00000000fe907fff (prio -1000, i/o): bcm2835-dbus
   |  |- 00000000fe910000-00000000fe917fff (prio -1000, i/o): bcm2835-ave0
   |  |- 00000000fe980000-00000000fe990fff (prio 0, i/o): dwc2
   |  |  |- 00000000fe980000-00000000fe980fff (prio 0, i/o): dwc2-io
   |  |  `- 00000000fe981000-00000000fe990fff (prio 0, i/o): dwc2-fifo
   |  |- 00000000fec00000-00000000fec00fff (prio -1000, i/o): bcm2835-v3d
   |  |- 00000000fec11000-00000000fec110ff (prio -1000, i/o): bcm2835-clkisp
   |  |- 00000000fee00000-00000000fee000ff (prio -1000, i/o): bcm2835-sdramc
   |  `- 00000000fee05000-00000000fee050ff (prio 0, i/o): bcm2835-dma-chan15
   |- 00000000ff800000-00000000ff8000ff (prio 0, i/o): bcm2836-control
...
   |- 00000000ff845600-00000000ff8456ff (prio 0, i/o): gic_cpu
   `- 00000000ff846000-00000000ff847fff (prio 0, i/o): gic_vcpu
```


PATCH v5 changelog:
1. Fix one comment, level 0 no longer prints line characters.

PATCH v4 changelog:
1. When printing the child nodes of a single node, the line characters from the
   parent node's level are no longer printed, making the output more concise
   and clear overall;
2. Use more commonly used ASCII characters, such as '|--' instead of '├──',
   and '`--' instead of '└──';
3. Control the number of prefix characters to reduce unnecessary output;

PATCH v3 changelog:
1. Use more maintainable c functions instead of macros, as per review comments.

PATCH v2 changelog:
1. Enrich the commit message, add 'info mtree' print example.
2. Optimize the code implementation according to the review comments.


PATCH v5:
https://lore.kernel.org/qemu-devel/9859fa86-2fb7-2380-2320-8b268d900fe9@eik.bme.hu/

PATCH v4:
https://lore.kernel.org/qemu-devel/3dd1e9e3eeedc70e1f1878bd17cc779a79084e58.1746030617.git.lc00631@tecorigin.com/

PATCH v3:
https://lore.kernel.org/qemu-devel/15227d0a-c459-4bea-bec7-13dc88d22c3c@linaro.org/
https://lore.kernel.org/qemu-devel/f5f540a2-a6d6-47fd-9b7c-8fd4a4927684@redhat.com/

PATCH v2:
https://lore.kernel.org/qemu-devel/72b2d911-112e-48e3-9ba4-017a11758060@linaro.org/
https://lore.kernel.org/qemu-devel/7ec1e581-3919-fdf5-499a-279cba99d43d@eik.bme.hu/
https://lore.kernel.org/qemu-devel/874iy5d9v7.fsf@pond.sub.org/

PATCH v1:
https://lore.kernel.org/qemu-devel/210c69d9-803e-41a5-b40c-bc8372e582fa@redhat.com/

--
Regards,
Chao

Chao Liu (1):
  system: improve visual representation of node hierarchy in 'info
    mtree' output for qemu monitor

 system/memory.c | 132 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 121 insertions(+), 11 deletions(-)

-- 
2.48.1


