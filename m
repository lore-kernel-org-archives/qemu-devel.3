Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1ECC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 14:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTho5-0007ww-Hf; Mon, 23 Jun 2025 10:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uTho2-0007wS-HI
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 10:05:54 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uThnz-0008Tj-Cm
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 10:05:54 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bQqYH2fM4z6HK2Z;
 Mon, 23 Jun 2025 22:03:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 91FE41404FE;
 Mon, 23 Jun 2025 22:05:42 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Jun
 2025 16:05:42 +0200
Date: Mon, 23 Jun 2025 15:05:40 +0100
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <fan.ni@samsung.com>, <ravis.opensrc@micron.com>,
 <ajay.opensrc@micron.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH -qemu] hw/cxl: Use runtime for bg cmd running semantics
Message-ID: <20250623150540.00005450@huawei.com>
In-Reply-To: <20250617214832.579960-1-dave@stgolabs.net>
References: <20250617214832.579960-1-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
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

On Tue, 17 Jun 2025 14:48:32 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> The current check incorrectly misses the 0% case, which semantically
> can either be not running or one that just started. The runtime
> is a better way to check for 0%, 100% or aborted. This is currently
> benign in the kernel equivalent without cancel support.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Looks good to me. I'll carry this on my local tree for now and combine
it with some other fixes to send to MST.

Probably push out a new cxl staging tree sometime in next few weeks.
> ---
> 
> Applies against 'cxl-2025-06-10' from jic23 tree.
> 
>  hw/cxl/cxl-device-utils.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index e150d7445762..add0ab615976 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -95,13 +95,10 @@ static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned size)
>          }
>          if (offset == A_CXL_DEV_MAILBOX_STS) {
>              uint64_t status_reg = cxl_dstate->mbox_reg_state64[offset / size];
> -            int bgop;
>  
>              qemu_mutex_lock(&cci->bg.lock);
> -            bgop = !(cci->bg.complete_pct == 100 || cci->bg.aborted);
> -
>              status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, BG_OP,
> -                                    bgop);
> +                                    !!cci->bg.runtime);
>              cxl_dstate->mbox_reg_state64[offset / size] = status_reg;
>              qemu_mutex_unlock(&cci->bg.lock);
>          }


