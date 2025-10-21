Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605B4CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 11:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBAb3-0002jq-Aq; Tue, 21 Oct 2025 07:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vBAaW-0002gX-DJ; Tue, 21 Oct 2025 07:31:37 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vBAaQ-0007om-B2; Tue, 21 Oct 2025 07:31:34 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6470FA721A;
 Tue, 21 Oct 2025 13:31:16 +0200 (CEST)
Message-ID: <f2f25f68-a660-4203-9cce-a4d137015991@proxmox.com>
Date: Tue, 21 Oct 2025 13:31:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] block: refresh filter parents when child was
 resized
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com
References: <20250917115509.401015-1-f.ebner@proxmox.com>
Content-Language: en-US
In-Reply-To: <20250917115509.401015-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1761046269117
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Ping

Am 17.09.25 um 3:50 PM schrieb Fiona Ebner:
> Changes in v2:
> * Check for BDRV_CHILD_FILTERED rather than bs->drv->is_filter which
>   is more generic and for example, also covers the case when the
>   child of a 'raw' node is resized.
> * Expand commit message for main patch, i.e. 3/5.
> * Add test for resizing the filtered 'file' node of a 'raw' node.
> 
> Resizing a node below a filter would result in the filter still
> reporting the old size. Implement a 'resize' callback for the
> child_of_bds class, that refreshes filter parents recursively.
> 
> Fiona Ebner (5):
>   include/block/block_int-common: document when resize callback is used
>   block: make bdrv_co_parent_cb_resize() a proper IO API function
>   block: implement 'resize' callback for child_of_bds class
>   iotests: add test for resizing a node below filters
>   iotests: add test for resizing a 'file' node below a 'raw' node
> 
>  block.c                                       | 12 +++
>  block/io.c                                    |  9 +--
>  include/block/block_int-common.h              |  5 +-
>  include/block/block_int-io.h                  |  6 ++
>  tests/qemu-iotests/tests/resize-below-filter  | 73 +++++++++++++++++++
>  .../tests/resize-below-filter.out             |  5 ++
>  tests/qemu-iotests/tests/resize-below-raw     | 53 ++++++++++++++
>  tests/qemu-iotests/tests/resize-below-raw.out |  5 ++
>  8 files changed, 161 insertions(+), 7 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/resize-below-filter
>  create mode 100644 tests/qemu-iotests/tests/resize-below-filter.out
>  create mode 100755 tests/qemu-iotests/tests/resize-below-raw
>  create mode 100644 tests/qemu-iotests/tests/resize-below-raw.out
> 



