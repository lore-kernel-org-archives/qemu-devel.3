Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D9DC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1redWP-0006bf-KF; Mon, 26 Feb 2024 11:08:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1redWK-0006a2-1t; Mon, 26 Feb 2024 11:08:00 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1redW5-00060O-NV; Mon, 26 Feb 2024 11:07:59 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk5495DZWz6JBV0;
 Tue, 27 Feb 2024 00:02:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 3B896140C98;
 Tue, 27 Feb 2024 00:07:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 16:07:22 +0000
Date: Mon, 26 Feb 2024 16:07:21 +0000
To: Zhao Liu <zhao1.liu@linux.intel.com>
CC: Fan Ni <fan.ni@samsung.com>, Laurent Vivier <laurent@vivier.eu>, Alistair
 Francis <alistair@alistair23.me>, "Edgar E . Iglesias"
 <edgar.iglesias@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Markus Armbruster
 <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev
 <mjt@tls.msk.ru>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 <qemu-trivial@nongnu.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 3/7] hw/mem/cxl_type3: Fix missing ERRP_GUARD() in
 ct3_realize()
Message-ID: <20240226160721.000056ea@Huawei.com>
In-Reply-To: <20240223085653.1255438-4-zhao1.liu@linux.intel.com>
References: <20240223085653.1255438-1-zhao1.liu@linux.intel.com>
 <20240223085653.1255438-4-zhao1.liu@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 23 Feb 2024 16:56:49 +0800
Zhao Liu <zhao1.liu@linux.intel.com> wrote:

> From: Zhao Liu <zhao1.liu@intel.com>
> 
> As the comment in qapi/error, dereferencing @errp requires
> ERRP_GUARD():
> 
> * = Why, when and how to use ERRP_GUARD() =
> *
> * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> * - It must not be dereferenced, because it may be null.
> ...
> * ERRP_GUARD() lifts these restrictions.
> *
> * To use ERRP_GUARD(), add it right at the beginning of the function.
> * @errp can then be used without worrying about the argument being
> * NULL or &error_fatal.
> *
> * Using it when it's not needed is safe, but please avoid cluttering
> * the source with useless code.
> 
> But in ct3_realize(), @errp is dereferenced without ERRP_GUARD():
> 
> cxl_doe_cdat_init(cxl_cstate, errp);
> if (*errp) {
>     goto err_free_special_ops;
> }
> 
> Here we check *errp, because cxl_doe_cdat_init() returns void. And
> ct3_realize() - as a PCIDeviceClass.realize() method - doesn't get the
> NULL @errp parameter, it hasn't triggered the bug that dereferencing
> the NULL @errp.
> 
> To follow the requirement of @errp, add missing ERRP_GUARD() in
> ct3_realize().
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Suggested by credit:
>  Markus: Referred his explanation about ERRP_GUARD().
> ---
> v2:
>  * Add the @errp dereference code in commit message to make review
>    easier. (Markus)
> ---
>  hw/mem/cxl_type3.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index e8801805b90f..a3b0761f843b 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -645,6 +645,7 @@ static DOEProtocol doe_cdat_prot[] = {
>  
>  static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>  {
> +    ERRP_GUARD();
>      CXLType3Dev *ct3d = CXL_TYPE3(pci_dev);
>      CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
>      ComponentRegisters *regs = &cxl_cstate->crb;


