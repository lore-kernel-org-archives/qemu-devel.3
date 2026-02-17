Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEB4E6815D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 10:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsHzK-0003b8-Cl; Tue, 17 Feb 2026 05:07:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vsHzJ-0003av-8w
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 05:07:25 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vsHzH-0003mX-4X
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 05:07:24 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fFb0b49QXzJ46ZY;
 Tue, 17 Feb 2026 18:07:11 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 7C54D40572;
 Tue, 17 Feb 2026 18:07:21 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Feb
 2026 10:07:20 +0000
Date: Tue, 17 Feb 2026 10:07:19 +0000
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <qemu-devel@nongnu.org>, <lizhijian@fujitsu.com>, <anisa.su887@gmail.com>, 
 <armbru@redhat.com>, <david@kernel.org>, <gourry@gourry.net>,
 <imammedo@redhat.com>, <linuxarm@huawei.com>, <mst@redhat.com>,
 <nifan.cxl@gmail.com>, <peterx@redhat.com>, <philmd@linaro.org>,
 <ppbonzini@redhat.com>, <venkataravis@micron.com>,
 <xiaoguangrong.eric@gmail.com>
Subject: Re: [PATCH v3 1/2] hw/cxl: Use HPA in cxl_cfmws_find_device()
 rather than offset in window.
Message-ID: <20260217100719.00004f4a@huawei.com>
In-Reply-To: <20260216145219.1959-2-alireza.sanaee@huawei.com>
References: <20260216145219.1959-1-alireza.sanaee@huawei.com>
 <20260216145219.1959-2-alireza.sanaee@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
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

On Mon, 16 Feb 2026 14:52:17 +0000
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> This function will shortly be used to help find if there is a route to a
> device, serving an HPA, under a particular fixed memory window. Rather
> than having that new use case subtract the base address in the caller,
> only to add it again in cxl_cfmws_find_device(), push the responsibility
> for calculating the HPA to the caller.
> 
> This also reduces the inconsistency in the meaning of the hwaddr
> addr parameter between this function and the calls made within it
> that access the HDM decoders that operating on HPA.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---
>  hw/cxl/cxl-host.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index f3479b1991..415a792380 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -157,7 +157,8 @@ static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
>      return found;
>  }
>  
> -static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
> +static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr,
> +                                        bool allow_interleave)

This is doing two things and only one is the mentioned change.
The allow_interleave parameter should be in patch 2.

It'll be a little churn heavy as we'll change a couple of lines twice,
but it won't add an unused parameter and leave us with a harder to
review pair of patches.

Fix that up and you can add
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Jonathan



>  {
>      CXLComponentState *hb_cstate, *usp_cstate;
>      PCIHostState *hb;
> @@ -168,8 +169,6 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
>      bool target_found;
>      PCIDevice *rp, *d;
>  
> -    /* Address is relative to memory region. Convert to HPA */
> -    addr += fw->base;
>  
>      rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
>      hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
> @@ -254,7 +253,7 @@ static MemTxResult cxl_read_cfmws(void *opaque, hwaddr addr, uint64_t *data,
>      CXLFixedWindow *fw = opaque;
>      PCIDevice *d;
>  
> -    d = cxl_cfmws_find_device(fw, addr);
> +    d = cxl_cfmws_find_device(fw, addr + fw->base, true);
>      if (d == NULL) {
>          *data = 0;
>          /* Reads to invalid address return poison */
> @@ -271,7 +270,7 @@ static MemTxResult cxl_write_cfmws(void *opaque, hwaddr addr,
>      CXLFixedWindow *fw = opaque;
>      PCIDevice *d;
>  
> -    d = cxl_cfmws_find_device(fw, addr);
> +    d = cxl_cfmws_find_device(fw, addr + fw->base, true);
>      if (d == NULL) {
>          /* Writes to invalid address are silent */
>          return MEMTX_OK;


