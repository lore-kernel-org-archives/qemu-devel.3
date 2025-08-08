Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B9CC87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 15:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukPKG-0002QH-5f; Fri, 08 Aug 2025 11:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ukPKE-0002PB-9T
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 11:48:10 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ukPKB-0002mZ-1y
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 11:48:10 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bz7fk43Y3z6M4XV;
 Fri,  8 Aug 2025 23:46:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id C152F140279;
 Fri,  8 Aug 2025 23:47:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 8 Aug
 2025 17:47:56 +0200
Date: Fri, 8 Aug 2025 16:47:55 +0100
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <ira.weiny@intel.com>, <alucerop@amd.com>, <a.manzanares@samsung.com>,
 <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 3/4] hw/cxl: Allow BI by default in Window restrictions
Message-ID: <20250808164755.0000339c@huawei.com>
In-Reply-To: <20250806055708.196851-4-dave@stgolabs.net>
References: <20250806055708.196851-1-dave@stgolabs.net>
 <20250806055708.196851-4-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue,  5 Aug 2025 22:57:07 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Update the CFMW restrictions to also permit Back-Invalidate
> flows by default, which is aligned with the no-restrictions
> policy.
> 
> While at it, document the 'restrictions=' option.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

I sat on this the original restrictions patch without trying to
upstream it on the basis that it's a horrible interface. 
Time to clean my mess up I guess then I'll fix this up on top.
We probably want it to enable everything by default (other
than the fixed device config one and then provide boolean
properties to turn things off.  For now I can't see a reason
to have the fixed device config as a possibility.

Jonathan


> ---
>  hw/cxl/cxl-host.c | 2 +-
>  qapi/machine.json | 3 ++-
>  qemu-options.hx   | 4 +++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index def2cf75be61..0d17ea3e4c26 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -64,7 +64,7 @@ static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
>      if (object->has_restrictions) {
>          fw->restrictions = object->restrictions;
>      } else {
> -        fw->restrictions = 0xf; /* No restrictions */
> +        fw->restrictions = 0x2f; /* No restrictions */
>      }
>  
>      fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
> diff --git a/qapi/machine.json b/qapi/machine.json
> index ac258578e4ab..ea8ba71305b0 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -589,7 +589,8 @@
>  #     BIT(2) - Volatile
>  #     BIT(3) - Persistent
>  #     BIT(4) - Fixed Device Config
> -#     Default is 0xF
> +#     BIT(5) - BI
> +#     Default is 0x2F
>  #
>  # @targets: Target root bridge IDs from -device ...,id=<ID> for each
>  #     root bridge.
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 1f862b19a676..ef6072bd8b59 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -142,7 +142,7 @@ SRST
>              -machine memory-backend=pc.ram
>              -m 512M
>  
> -    ``cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]``
> +    ``cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity,restrictions=restrictions]``
>          Define a CXL Fixed Memory Window (CFMW).
>  
>          Described in the CXL 2.0 ECN: CEDT CFMWS & QTG _DSM.
> @@ -168,6 +168,8 @@ SRST
>          interleave. Default 256 (bytes). Only 256, 512, 1k, 2k,
>          4k, 8k and 16k granularities supported.
>  
> +	``restrictions=restrictions`` bitmask of restrictions of the CFMW.
> +
>          Example:
>  
>          ::


