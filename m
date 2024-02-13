Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EC9C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 16:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZvdH-00082b-Sc; Tue, 13 Feb 2024 11:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rZvdA-00082A-Bl
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:27:37 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rZvd7-0004LH-Mu
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:27:36 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZ67z2N7Zz67KQL;
 Wed, 14 Feb 2024 00:23:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 721B1140D1A;
 Wed, 14 Feb 2024 00:27:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 16:27:24 +0000
Date: Tue, 13 Feb 2024 16:27:23 +0000
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 1/2] hw/cxl/type3: add missing flag bit for GMER
Message-ID: <20240213162723.0000514f@Huawei.com>
In-Reply-To: <20240209115417.724638-2-ruansy.fnst@fujitsu.com>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
 <20240209115417.724638-2-ruansy.fnst@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

On Fri,  9 Feb 2024 19:54:11 +0800
Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> The "Volatile" should be set if current device is a volatile memory.
> Per CXL Spec r3.0 8.2.9.2.1.1, Table 8-43.

Whilst true, we haven't previously adjusted the injected record
to conform to the device.  I don't think there is anything preventing
you setting this bit in the dpa fields whilst injecting.

I'm not against filling this in automatically but we should be
masking the relevant bits out of what is injected and filling it in based
on the dpa that is provided and which memory that falls within.


> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  hw/mem/cxl_type3.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 52647b4ac7..d8fb63b1de 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1285,6 +1285,9 @@ static const QemuUUID memory_module_uuid = {
>                   0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),
>  };
>  
> +#define CXL_GMER_DPA_VOLATILE                           BIT(0)
> +#define CXL_GMER_DPA_NOT_REPAIRABLE                     BIT(1)
> +
>  #define CXL_GMER_VALID_CHANNEL                          BIT(0)
>  #define CXL_GMER_VALID_RANK                             BIT(1)
>  #define CXL_GMER_VALID_DEVICE                           BIT(2)
> @@ -1348,6 +1351,9 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
>      cxl_assign_event_header(hdr, &gen_media_uuid, flags, sizeof(gem),
>                              cxl_device_get_timestamp(&ct3d->cxl_dstate));
>  
> +    if (ct3d->hostvmem) {
> +        dpa |= CXL_GMER_DPA_VOLATILE;
> +    }

The presence of volatile memory isn't sufficient.  You may have a device
with both volatile and persistent memory. It will get even fiddlier with
Dynamic Capacity which will need checking as well once that support is
ready.



>      stq_le_p(&gem.phys_addr, dpa);
>      gem.descriptor = descriptor;
>      gem.type = type;


