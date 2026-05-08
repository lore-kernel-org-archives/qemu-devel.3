Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A4DCD3447
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 11:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLJnj-0005Iz-Rh; Fri, 08 May 2026 07:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wLJne-0005IQ-FB; Fri, 08 May 2026 07:55:22 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wLJnc-0004eG-CM; Fri, 08 May 2026 07:55:22 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 2C0A941C08;
 Fri, 08 May 2026 13:55:09 +0200 (CEST)
Message-ID: <2493d422-d58a-4409-aee4-e932a4e0a73c@proxmox.com>
Date: Fri, 8 May 2026 13:55:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 17/28] fuse: Manually process requests (without libfuse)
To: qemu-block@nongnu.org, hreitz@redhat.com
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20260310162622.333137-1-kwolf@redhat.com>
 <20260310162622.333137-18-kwolf@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20260310162622.333137-18-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1778241199703
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Dear maintainers,

Am 10.03.26 um 6:37 PM schrieb Kevin Wolf:
> From: Hanna Czenczek <hreitz@redhat.com>
> 
> Manually read requests from the /dev/fuse FD and process them, without
> using libfuse.  This allows us to safely add parallel request processing
> in coroutines later, without having to worry about libfuse internals.
> (Technically, we already have exactly that problem with
> read_from_fuse_export()/read_from_fuse_fd() nesting.)
> 
> We will continue to use libfuse for mounting the filesystem; fusermount3
> is a effectively a helper program of libfuse, so it should know best how
> to interact with it.  (Doing it manually without libfuse, while doable,
> is a bit of a pain, and it is not clear to me how stable the "protocol"
> actually is.)
> 
> Take this opportunity of quite a major rewrite to update the Copyright
> line with corrected information that has surfaced in the meantime.

a colleague ran into another issue with a fuse export, this time in 
combination with virt-fw-vars and bisecting points to this patch. Before 
commit a94a1d7699 ("fuse: Manually process requests (without libfuse)") 
the reproducer [0] completes successfully, after that commit it hangs at 
[1]. The issue is still present with current master. I can dig into the 
details next week.

Best Regards,
Fiona

[0]:

> #!/bin/bash
> 
> rm /tmp/disk.raw
> rm /tmp/export.fuse
> cp /usr/share/pve-edk2-firmware/OVMF_VARS_4M.ms.fd /tmp/disk.raw
> touch /tmp/export.fuse
> 
> (
> ./storage-daemon/qemu-storage-daemon \
>     --blockdev raw,node-name=node0,file.driver=file,file.filename=/tmp/disk.raw \
>     --export fuse,id=exp0,mountpoint=/tmp/export.fuse,node-name=node0,writable=true \
>     --chardev socket,id=qmp,path=/run/qsd.qmp,server=on,wait=off \
>     --monitor chardev=qmp,mode=control
> ) &
> 
> sleep 1 # too lazy to do proper synchronization for the reproducer here
> virt-fw-vars --inplace /tmp/export.fuse --distro-keys windows
> echo '{"execute": "qmp_capabilities"}{"execute": "quit"}' | socat - /run/qsd.qmp

[1]:

> INFO: reading raw edk2 varstore from /tmp/export.fuse
> INFO: var store range: 0x64 -> 0x40000
> INFO: add db cert /usr/lib/python3/dist-packages/virt/firmware/certs/MicrosoftWindowsProductionPCA2011.pem
> INFO: certificate already present, skipping
> INFO: add db cert /usr/lib/python3/dist-packages/virt/firmware/certs/WindowsUEFICA2023.pem
> INFO: certificate already present, skipping
> INFO: writing raw edk2 varstore to /tmp/export.fuse



