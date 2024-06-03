Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16748C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6Jx-0002gZ-Vv; Mon, 03 Jun 2024 07:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sE6Jv-0002cY-Ha
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:57:47 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sE6Js-0006x9-EO
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:57:47 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VtBtj4bcnz6K6jv;
 Mon,  3 Jun 2024 19:53:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 34A931400CD;
 Mon,  3 Jun 2024 19:57:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Jun
 2024 12:57:30 +0100
Date: Mon, 3 Jun 2024 12:57:29 +0100
To: Ira Weiny <ira.weiny@intel.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>, Fan Ni
 <fan.ni@samsung.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] hw/cxl: Fix read from bogus memory
Message-ID: <20240603125729.00005ef6@Huawei.com>
In-Reply-To: <20240531-fix-poison-set-cacheline-v1-1-e3bc7e8f1158@intel.com>
References: <20240531-fix-poison-set-cacheline-v1-1-e3bc7e8f1158@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 31 May 2024 11:22:05 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> Peter and coverity report:
> 
> 	We've passed '&data' to address_space_write(), which means "read
> 	from the address on the stack where the function argument 'data'
> 	lives", so instead of writing 64 bytes of data to the guest ,
> 	we'll write 64 bytes which start with a host pointer value and
> 	then continue with whatever happens to be on the host stack
> 	after that.
> 
> Indeed the intention was to write 64 bytes of data at the address given.
> 
> Fix the parameter to address_space_write().
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Link: https://lore.kernel.org/all/CAFEAcA-u4sytGwTKsb__Y+_+0O2-WwARntm3x8WNhvL1WfHOBg@mail.gmail.com/
> Fixes: 6bda41a69bdc ("hw/cxl: Add clear poison mailbox command support.")
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> Compile tested only.  Jonathan please double check me.

Looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  hw/mem/cxl_type3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 3e42490b6ce8..582412d9925f 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1025,7 +1025,7 @@ static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
>          as = &ct3d->hostpmem_as;
>      }
>  
> -    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
> +    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, data,
>                          CXL_CACHE_LINE_SIZE);
>      return true;
>  }
> 
> ---
> base-commit: 3b2fe44bb7f605f179e5e7feb2c13c2eb3abbb80
> change-id: 20240531-fix-poison-set-cacheline-e32bc1e74b27
> 
> Best regards,


