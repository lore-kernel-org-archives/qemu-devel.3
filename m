Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071C2CFC534
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 10:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0I40-0004wY-LT; Mon, 14 Oct 2024 06:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t0I3s-0004uB-Ci
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:12:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t0I3p-0002Cv-GB
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:12:24 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRtFy5V36z6L74Q;
 Mon, 14 Oct 2024 18:07:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id BC5C81400D9;
 Mon, 14 Oct 2024 18:12:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 12:12:17 +0200
Date: Mon, 14 Oct 2024 11:12:16 +0100
To: <ajay.opensrc@micron.com>
CC: <mst@redhat.com>, <john@jagalactic.com>, <emirakhur@micron.com>,
 <ajayjoshi@micron.com>, <sthanneeru@micron.com>, <Ravis.OpenSrc@micron.com>,
 <arramesh@micron.com>, <dave@stgolabs.net>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v1] hw/cxl: Fix background completion percentage
 calculation
Message-ID: <20241014111216.000014c2@Huawei.com>
In-Reply-To: <20240914112021.2730383-1-ajay.opensrc@micron.com>
References: <20240914112021.2730383-1-ajay.opensrc@micron.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, 14 Sep 2024 16:50:21 +0530
<ajay.opensrc@micron.com> wrote:

> From: Ajay Joshi <ajayjoshi@micron.com>
> 
> The current completion percentage calculation
> does not account for the relative time since
> the start of the background activity, this leads
> to showing incorrect start percentage vs what has
> actually been completed.
> 
> This patch calculates the percentage based on the actual
> elapsed time since the start of the operation.
> 
> Fixes: 221d2cfbdb ("hw/cxl/mbox: Add support for background operations")
> 
I'll include this is a fixes series I send to Michael + list later
today.  However for future reference, no line break between tags in
the tags block as it breaks some scripting.  I'll tidy that up.
Note I think you missed Michael's point about this on the first version.
+ as a second version, even without changes, this should have been v2.


Thanks

Jonathan

> Signed-off-by: Ajay Joshi <ajay.opensrc@micron.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index c2ed251bb3..873d60c069 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -2708,7 +2708,8 @@ static void bg_timercb(void *opaque)
>          }
>      } else {
>          /* estimate only */
> -        cci->bg.complete_pct = 100 * now / total_time;
> +        cci->bg.complete_pct =
> +            100 * (now - cci->bg.starttime) / cci->bg.runtime;
>          timer_mod(cci->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
>      }
>  


