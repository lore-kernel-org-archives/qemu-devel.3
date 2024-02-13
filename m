Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5226EC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 16:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZvhk-0001td-F0; Tue, 13 Feb 2024 11:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rZvhi-0001sw-D0
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:32:18 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rZvhg-0005GK-3D
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:32:18 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZ6G76J7pz67LyQ;
 Wed, 14 Feb 2024 00:28:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id D5C82140B63;
 Wed, 14 Feb 2024 00:32:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 16:32:12 +0000
Date: Tue, 13 Feb 2024 16:32:11 +0000
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 2/2] hw/cxl/type3: send a GMER while injecting poison
Message-ID: <20240213163211.000063d5@Huawei.com>
In-Reply-To: <20240209115417.724638-3-ruansy.fnst@fujitsu.com>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
 <20240209115417.724638-3-ruansy.fnst@fujitsu.com>
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

On Fri,  9 Feb 2024 19:54:12 +0800
Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> Send a signal to OS to let it able to handle the poison range.
> 
> TODO: This is an rough draft, will add more parameters for
> qmp_cxl_inject_poison() to set to GMER.

I wonder if that's the best plan or if we should think about
providing some default memory topology and perhaps a means
to override it.   Adding more parameters to the injection
commands works for qmp injection but not for mailbox based
injection from the host for example.

If we have a DPA to channel, rank, etc default mapping then
we should be able to fill them all in based on just the DPA
but allow them to be overridden from the existing GMER
injection (so other test cases can be poked).

One comment inline.

Jonathan

> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  hw/mem/cxl_type3.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index d8fb63b1de..813f7f2175 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1116,6 +1116,11 @@ void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
>  
>      QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
>      ct3d->poison_list_cnt++;
> +
> +    /* Emit an GMER event, let os handle it */
> +    qmp_cxl_inject_general_media_event(path, CXL_EVENT_LOG_FAILURE, 0, start,
> +                                       0, 0, 4, false, 0, false, 0,
> +                                       false, 0, NULL, errp);

This results in some slightly messy duplication of effort. I'd like to see the
parts we need factored out of the qmp_cxl_inject_general_media_event()
so that we don't end up looking up the device twice and similar.
Pull the code we need in both places out to
cxl_inject_general_media_event(CXLType3 *ct3d, ...

helper in a precursor patch and reuse that code here.

  }
>  
>  /* For uncorrectable errors include support for multiple header recording */


