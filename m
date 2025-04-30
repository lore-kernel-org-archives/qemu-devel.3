Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FA0C3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAANH-000283-Kp; Wed, 30 Apr 2025 12:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1uAANE-00026m-P1
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:33:28 -0400
Received: from out28-51.mail.aliyun.com ([115.124.28.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1uAANA-00088I-IQ
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:33:28 -0400
Received: from localhost.localdomain(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.ccFcKOi_1746030793 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 01 May 2025 00:33:15 +0800
From: Chao Liu <lc00631@tecorigin.com>
To: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, armbru@redhat.com, balaton@eik.bme.hu
Cc: zhangtj@tecorigin.com, zqz00548@tecorigin.com, lc00631@tecorigin.com,
 qemu-devel@nongnu.org
Subject: [PATCH v4 0/1] Optimizing the print format of the QEMU monitor 'info
 mtree'
Date: Thu,  1 May 2025 00:32:57 +0800
Message-ID: <cover.1746028446.git.lc00631@tecorigin.com>
X-Mailer: git-send-email 2.48.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.51; envelope-from=lc00631@tecorigin.com;
 helo=out28-51.mail.aliyun.com
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

Thanks to Markus, BALATON, and Philippe for their reviews

In PATCH v4, 
I have extensively incorporated everyone's suggestions and made the
following improvements:

1. When printing the child nodes of a single node, the line characters from the
parent node's level are no longer printed, making the output more concise
and clear overall;

2. Use more commonly used ASCII characters, such as '|--' instead of '├──',
and '`--' instead of '└──';

3. Control the number of prefix characters to reduce unnecessary output;

The result is as follows:

```
$ ./qemu-system-aarch64 -S -monitor stdio -M raspi4b
(qemu) info mtree
address-space: memory
`-- 0000000000000000-ffffffffffffffff (prio 0, i/o): system
    |-- 0000000000000000-000000007fffffff (prio 0, ram): ram
...
    |-- 00000000fe000000-00000000ff7fffff (prio 1, i/o): bcm2835-peripherals
    |   |-- 00000000fe900000-00000000fe907fff (prio -1000, i/o): bcm2835-dbus
    |   |-- 00000000fe910000-00000000fe917fff (prio -1000, i/o): bcm2835-ave0
    |   |-- 00000000fe980000-00000000fe990fff (prio 0, i/o): dwc2
    |   |   |-- 00000000fe980000-00000000fe980fff (prio 0, i/o): dwc2-io
    |   |   `-- 00000000fe981000-00000000fe990fff (prio 0, i/o): dwc2-fifo
    |   |-- 00000000fec00000-00000000fec00fff (prio -1000, i/o): bcm2835-v3d
    |   |-- 00000000fec11000-00000000fec110ff (prio -1000, i/o): bcm2835-clkisp
    |   |-- 00000000fee00000-00000000fee000ff (prio -1000, i/o): bcm2835-sdramc
    |   `-- 00000000fee05000-00000000fee050ff (prio 0, i/o): bcm2835-dma-chan15
    |-- 00000000ff800000-00000000ff8000ff (prio 0, i/o): bcm2836-control
...
    |-- 00000000ff845600-00000000ff8456ff (prio 0, i/o): gic_cpu
    `-- 00000000ff846000-00000000ff847fff (prio 0, i/o): gic_vcpu
```

PATCH v3 changelog:
1.Use more maintainable c functions instead of macros, as per review comments.

PATCH v2 changelog:
1. Enrich the commit message, add 'info mtree' print example.
2. Optimize the code implementation according to the review comments.

PATCH v3:
https://lore.kernel.org/qemu-devel/15227d0a-c459-4bea-bec7-13dc88d22c3c@linaro.org/

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

 system/memory.c | 122 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 111 insertions(+), 11 deletions(-)

-- 
2.48.1


