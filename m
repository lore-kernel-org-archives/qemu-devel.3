Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC42BF8D75D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 16:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDP7t-0004nZ-OP; Thu, 16 Apr 2026 11:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1wDP7s-0004nO-0f
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 11:59:32 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1wDP7q-0005C5-3M
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 11:59:31 -0400
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fxN3w3hkBzHnGjl;
 Thu, 16 Apr 2026 23:59:08 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id CED7D40571;
 Thu, 16 Apr 2026 23:59:26 +0800 (CST)
Received: from localhost (10.123.51.176) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 16 Apr
 2026 16:59:25 +0100
Date: Thu, 16 Apr 2026 16:59:24 +0100
To: Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <buzzy0257@gmail.com>,
 <jic23@kernel.org>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
 <berrange@redhat.com>
Subject: Re: [PATCH qemu] hw/cxl: Avoid out of bounds read when userspace
 requests data off end of CDAT.
Message-ID: <20260416165924.00002043@huawei.com>
In-Reply-To: <20260416155421.9876-1-Jonathan.Cameron@huawei.com>
References: <20260416155421.9876-1-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.123.51.176]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 16 Apr 2026 16:54:21 +0100
Jonathan Cameron via qemu development <qemu-devel@nongnu.org> wrote:

> The requested entry is controlled by the guest so must be checked against
> the number of entries that actually exist.
> 
> Reported as a security issue, but CXL emulation has since been declared
> to not be suitable (yet) for virtualization use cases and so the security
> handling policy does not apply.
> 
> Fixes: f5ee7413d592 ("hw/mem/cxl-type3: Add CXL CDAT Data Object Exchange")
> Fixes: 882877fc359d ("hw/pci-bridge/cxl-upstream: Add a CDAT table access DOE")
> Reported-by: Buzzy <buzzy0257@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: <jic23@kernel.org>

I have a very short memory it seems and forgot to add linux-cxl
despite adding it to the MAINTAINERS entry yesterday. 

> ---
>  hw/mem/cxl_type3.c           | 4 ++++
>  hw/pci-bridge/cxl_upstream.c | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 4739239da3c5..763b6a024403 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -278,6 +278,10 @@ static bool cxl_doe_cdat_rsp(DOECap *doe_cap)
>      }
>  
>      ent = req->entry_handle;
> +    if (ent >= cdat->entry_len) {
> +        return false;
> +    }
> +
>      base = cdat->entry[ent].base;
>      len = cdat->entry[ent].length;
>  
> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> index b6281cbd4cb0..fa53fa2777fd 100644
> --- a/hw/pci-bridge/cxl_upstream.c
> +++ b/hw/pci-bridge/cxl_upstream.c
> @@ -158,6 +158,10 @@ static bool cxl_doe_cdat_rsp(DOECap *doe_cap)
>      }
>  
>      ent = req->entry_handle;
> +    if (ent >= cdat->entry_len) {
> +        return false;
> +    }
> +
>      base = cdat->entry[ent].base;
>      len = cdat->entry[ent].length;
>  


