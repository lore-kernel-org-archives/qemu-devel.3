Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14698C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 11:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmAiA-00014F-87; Mon, 18 Mar 2024 06:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rmAi5-00013u-GW
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:59:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rmAi2-0006Wf-J0
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:59:16 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TysKR39Y6z6K6Pg;
 Mon, 18 Mar 2024 18:58:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id E181E14322E;
 Mon, 18 Mar 2024 18:59:00 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Mar
 2024 10:57:48 +0000
Date: Mon, 18 Mar 2024 10:57:48 +0000
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
 <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <chenbaozi@phytium.com.cn>
Subject: Re: [PATCH v2 1/1] cxl/mem: Fix for the index of Clear Event Record
 Handle
Message-ID: <20240318105748.000072c5@Huawei.com>
In-Reply-To: <20240318022928.509130-2-wangyuquan1236@phytium.com.cn>
References: <20240318022928.509130-1-wangyuquan1236@phytium.com.cn>
 <20240318022928.509130-2-wangyuquan1236@phytium.com.cn>
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
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On Mon, 18 Mar 2024 10:29:28 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> The dev_dbg info for Clear Event Records mailbox command would report
> the handle of the next record to clear not the current one.
> 
> This was because the index 'i' had incremented before printing the
> current handle value.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
>  drivers/cxl/core/mbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 9adda4795eb7..b810a6aa3010 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -915,7 +915,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  
>  		payload->handles[i++] = gen->hdr.handle;
>  		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
> -			le16_to_cpu(payload->handles[i]));
> +			le16_to_cpu(payload->handles[i-1]));
Trivial but needs spaces around the -. e.g.  [i - 1] 

Maybe Dan can fix up whilst applying.

Otherwise

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>  
>  		if (i == max_handles) {
>  			payload->nr_recs = i;


