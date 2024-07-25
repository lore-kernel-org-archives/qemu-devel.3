Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FEDC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 16:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX1k0-0007Ok-GD; Thu, 25 Jul 2024 12:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sX1jz-0007Ni-8m; Thu, 25 Jul 2024 12:54:55 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sX1js-0003F9-1J; Thu, 25 Jul 2024 12:54:51 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVH3z6ysMz6K9GJ;
 Fri, 26 Jul 2024 00:52:15 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 3F206140A34;
 Fri, 26 Jul 2024 00:54:42 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 25 Jul
 2024 17:54:41 +0100
Date: Thu, 25 Jul 2024 17:54:40 +0100
To: Michael Tokarev <mjt@tls.msk.ru>
CC: <mst@redhat.com>, <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 <linuxarm@huawei.com>, Zhao Liu <zhao1.liu@linux.intel.com>, Xingtao Yao
 <yaoxt.fnst@fujitsu.com>, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v2 1/3] hw/cxl/cxl-host: Fix segmentation fault when
 getting cxl-fmw property
Message-ID: <20240725175440.00005ed4@Huawei.com>
In-Reply-To: <1c89931e-d800-452b-8dbd-5c433149f723@tls.msk.ru>
References: <20240705113956.941732-1-Jonathan.Cameron@huawei.com>
 <20240705113956.941732-2-Jonathan.Cameron@huawei.com>
 <1c89931e-d800-452b-8dbd-5c433149f723@tls.msk.ru>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 24 Jul 2024 07:53:48 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> 05.07.2024 14:39, Jonathan Cameron via wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > QEMU crashes (Segmentation fault) when getting cxl-fmw property via
> > qmp:
> > 
> > (QEMU) qom-get path=machine property=cxl-fmw
> > 
> > This issue is caused by accessing wrong callback (opaque) type in
> > machine_get_cfmw().
> > 
> > cxl_machine_init() sets the callback as `CXLState *` type but
> > machine_get_cfmw() treats the callback as
> > `CXLFixedMemoryWindowOptionsList **`.
> > 
> > Fix this error by casting opaque to `CXLState *` type in
> > machine_get_cfmw().
> > 
> > Fixes: 03b39fcf64bc ("hw/cxl: Make the CXL fixed memory window setup a machine parameter.")
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
> > Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
> > Link: https://lore.kernel.org/r/20240704093404.1848132-1-zhao1.liu@linux.intel.com
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Is this a stable@ material?

Yes please

Thanks,

Jonathan

> 
> Thanks,
> 
> /mjt
> 


