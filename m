Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87779C5B547
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJULt-0002aH-De; Mon, 26 May 2025 05:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uJULr-0002Za-SU; Mon, 26 May 2025 05:42:35 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uJULp-000654-Pa; Mon, 26 May 2025 05:42:35 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id D58DD44489;
 Mon, 26 May 2025 11:42:24 +0200 (CEST)
Message-ID: <6eff882f-0a71-456d-b3ff-16d82ec9b8ff@proxmox.com>
Date: Mon, 26 May 2025 11:42:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] iotests: Filter out ZFS in several tests
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
References: <20250523163041.2548675-5-eblake@redhat.com>
 <20250523163041.2548675-8-eblake@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20250523163041.2548675-8-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 23.05.25 um 18:27 schrieb Eric Blake:
> Fiona reported that ZFS makes sparse file testing awkward, since:
> - it has asynchronous allocation (not even 'fsync $file' makes du see
>   the desired size; it takes the slower 'fsync -f $file' which is not
>   appropriate for the tests)
> - for tests of fully allocated files, ZFS with compression enabled
>   still reports smaller disk usage
> 
> Add a new _require_sparse_file that quickly probes whether an attempt

It's called _require_disk_usage in the implementation.

> to create a sparse 5M file shows as less than 1M usage, while the same
> file with -o preallocation=full shows as more than 4M usage without
> sync, which should filter out ZFS behavior.  Then use it in various
> affected tests.
> 
> This does not add the new filter on all tests that Fiona is seeing ZFS
> failures on, but only those where I could quickly spot that there is
> at least one place where the test depends on the output of 'du -b' or
> 'stat -c %b'.
> 
> Reported-by: Fiona Ebner <f.ebner@proxmox.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>


