Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C693EEE2091
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 12:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voKzD-00047q-Eg; Fri, 06 Feb 2026 07:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1voKzB-00046u-0c
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:30:57 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1voKz9-00053G-De
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:30:56 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6thS4ZblzJ46Cf;
 Fri,  6 Feb 2026 20:30:00 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id E633240584;
 Fri,  6 Feb 2026 20:30:52 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Feb
 2026 12:30:51 +0000
Date: Fri, 6 Feb 2026 12:30:50 +0000
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <qemu-devel@nongnu.org>, <linuxarm@huawei.com>, <eblake@redhat.com>,
 <armbru@redhat.com>, <berrange@redhat.com>, <pbonzini@redhat.com>,
 <mst@redhat.com>, <lizhijian@fujitsu.com>, <anisa.su@samsung.com>,
 <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 3/7] hw/cxl: Change Extent add/remove APIs for lazy
 memory backend.
Message-ID: <20260206123050.00000ddb@huawei.com>
In-Reply-To: <20251127225526.700-4-alireza.sanaee@huawei.com>
References: <20251127225526.700-1-alireza.sanaee@huawei.com>
 <20251127225526.700-4-alireza.sanaee@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 27 Nov 2025 22:55:21 +0000
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Add extra information in each extent about fix memory window and

fixed

> memory backend, because extent might be backed by different memory
because each extent might be backed by a different memory backend

(under new scheme they are one to one)

> backends, thus such information must be stored in the extent object.
> Consequently, APIs should be changes to support extra members.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  hw/cxl/cxl-host.c           |  2 ++
>  hw/cxl/cxl-mailbox-utils.c  | 42 ++++++++++++++++++++++++-------------
>  hw/mem/cxl_type3.c          | 23 +++++++++++++++-----
>  include/hw/cxl/cxl_device.h | 17 ++++++++++++---
>  4 files changed, 61 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index 3a563af3bc..7c8fde4646 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -365,6 +365,8 @@ static int cxl_fmws_direct_passthrough(Object *obj, void *opaque)
>          return 0;
>      }
>  
> +    ct3d->dc.fw = fw;
> +
>      if (state->commit) {
>          MemoryRegion *mr = NULL;
>          uint64_t vmr_size = 0, pmr_size = 0;
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 68c7cc9891..ae723c03ec 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -2840,10 +2840,13 @@ CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len)
>  }
>  
>  void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
> +                                             HostMemoryBackend *host_mem,
> +                                             struct CXLFixedWindow *fw,
>                                               uint64_t dpa,
>                                               uint64_t len,
>                                               uint8_t *tag,
> -                                             uint16_t shared_seq)
> +                                             uint16_t shared_seq,
> +                                             int rid)

I'm not sure what rid is...  Maybe there is a better name?
The dynamic capacity region index?




