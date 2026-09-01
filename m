Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB7EC624D2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1NWz-000641-Ux; Tue, 01 Sep 2026 08:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1x1NWy-00063i-0S; Tue, 01 Sep 2026 08:24:00 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1x1NWv-0003ag-Sn; Tue, 01 Sep 2026 08:23:59 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id A4D0CC2EB7;
 Tue, 01 Sep 2026 14:23:25 +0200 (CEST)
Message-ID: <05df98ca-e5d7-4cb2-99d2-74a1a276f58a@proxmox.com>
Date: Tue, 1 Sep 2026 14:23:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix bdrv_next() skipping monitor-owned nodes
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-stable@nongnu.org
References: <20260828222005.2888213-1-den@openvz.org>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20260828222005.2888213-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1788265402026
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Denis,

Am 29.08.26 um 12:20 AM schrieb Denis V. Lunev:
> From: Denis V. Lunev <den@openvz.org>
> 
> it->bs is the cursor into monitor_bdrv_states for the second phase of
> bdrv_next(), so it has to be NULL when that phase starts. Commit
> f6d38c9f6d made the first phase store the node it returns there, to
> unreference the right one when the graph changes underneath. The cursor
> is now left pointing at the last BlockBackend root, so the second phase
> resumes from there instead of from the head of the list and never
> returns a node added before it.
> 
> A skipped node drops out of the vm_stop and migration handover paths:
> not flushed, not inactivated, not snapshotted. bdrv_inactivate_all()
> still reports success, so the node keeps its image lock and the
> migration target cannot open the image. Only detached nodes are hit in
> practice, as these callers also recurse into children.
> 
> Reset the cursor when the second phase starts. old_bs is taken at the
> top of the function, so f6d38c9f6d keeps working.
> 
> Fixes: f6d38c9f6d ("block-backend: fix edge case in bdrv_next() where BDS associated to BB changes")
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Fiona Ebner <f.ebner@proxmox.com>
> Cc: Kevin Wolf <kwolf@redhat.com>

thank you for the fix!

Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>

Should also go into stable I suppose?

> ---
> 
> Notes:
>     The iterator was correct from its introduction in 2016 until 2024:
>     it->bs was written only by the second phase, and the node to unreference
>     came from the BlockBackend instead.
> 
>     f6d38c9f6d's own reproducer does not fire for me, 240 runs across 8
>     timings, even with its fix reverted. Tried hard.

The reproducer has a very short time window. I'm still able to trigger
an assertion failure with commit f6d38c9f6d reverted, by putting in some
'query-version' commands in between the 'block-stream' and 'quit'
commands, and running the script in a loop, e.g.:

[I] root@pve9a1 ~# cat ~/block-stream.sh
#!/bin/bash
rm -f /tmp/backing.qcow2
rm -f /tmp/top.qcow2
./qemu-img create /tmp/backing.qcow2 -f qcow2 64M
./qemu-io -c "write -P42 0x0 0x1" /tmp/backing.qcow2
./qemu-img create /tmp/top.qcow2 -f qcow2 64M -b /tmp/backing.qcow2 -F qcow2
./qemu-system-x86_64 --qmp stdio \
--blockdev
qcow2,node-name=node0,file.driver=file,file.filename=/tmp/top.qcow2 \
<<EOF
{"execute": "qmp_capabilities"}
{"execute": "block-stream", "arguments": { "job-id": "stream0",
"device": "node0" } }
{"execute": "query-version"}
{"execute": "query-version"}
{"execute": "query-version"}
{"execute": "query-version"}
{"execute": "query-version"}
{"execute": "query-version"}
{"execute": "query-version"}
{"execute": "query-version"}
{"execute": "query-version"}
{"execute": "quit"}
EOF

Best Regards,
Fiona


