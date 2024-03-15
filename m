Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272BAC54E69
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 10:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl5Cq-0001rl-PJ; Fri, 15 Mar 2024 06:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1rl5Cn-0001r1-7h
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 06:54:29 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1rl5Cj-0002la-MM
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 06:54:29 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwA3P7PaKPRlrIq1Bg--.28559S2;
 Fri, 15 Mar 2024 18:54:18 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
 by mail (Coremail) with SMTP id AQAAfwBHuUHUKPRlaIwAAA--.853S3;
 Fri, 15 Mar 2024 18:54:14 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: ira.weiny@intel.com, jonathan.cameron@huawei.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org, chenbaozi@phytium.com.cn,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH 0/1] cxl/mem: Fix for the index of Clear Event Record Handle
Date: Fri, 15 Mar 2024 18:53:35 +0800
Message-Id: <20240315105336.464156-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBHuUHUKPRlaIwAAA--.853S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAFAWXzUXsD5wAFsY
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Xr4kGF1rXrWxCF17JF4Dtwb_yoW8Jr17pr
 yfKwsIkFWDJasFgF15A3WxXFy5A3s5tF45Ga93Gw48J34UAF1UXr1Ik3WSvF15XryfXFW8
 A3Wjqr9xK34jyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is a simple fix for the index of 'Clear Event Record' Handle. The
print content of dev_dbg from Clear Event Records mailbox command would
report the handle of the next record to clear not the current one.
The problem was found when I was doing the debug of CXL Event Error on
Qemu. I injected an individual event through QMP 
'cxl-inject-general-media-event':
{ "execute": "cxl-inject-general-media-event",
    "arguments": {
        "path": "/machine/peripheral/cxl-mem0",
        "log": "informational",
        "flags": 1,
        "dpa": 1000,
        "descriptor": 3,
        "type": 3,
        "transaction-type": 192,
        "channel": 3,
        "device": 5,
        "component-id": "iras mem"
    }}

Then the kernel printed: 
[ 1639.106181] cxl_pci 0000:0d:00.0: Event log '0': Clearing 0

However, the line 36 in 'hw/cxl/cxl-events.c': log->next_handle = 1;
It will set the actual handle value of injected event to '1'.

With this fix, the kernel will print:
[  122.456750] cxl_pci 0000:0d:00.0: Event log '0': Clearing 1
which is in line with the simulated value in Qemu.

Yuquan Wang (1):
  cxl/mem: Fix for the index of Clear Event Record Handle

 drivers/cxl/core/mbox.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

-- 
2.34.1


