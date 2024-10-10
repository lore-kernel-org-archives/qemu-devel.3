Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AABBCFC5E4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 16:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sywA1-0003jy-0b; Thu, 10 Oct 2024 12:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1syw9y-0003jk-KL
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:37:06 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1syw9w-0006Vn-5h
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:37:06 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPb4J5fhYz67Gvv;
 Fri, 11 Oct 2024 00:36:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id D43C0140AE5;
 Fri, 11 Oct 2024 00:36:53 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 18:36:53 +0200
Date: Thu, 10 Oct 2024 17:36:52 +0100
To: Akihiko Odaki <akihiko.odaki@daynix.com>
CC: Jason Wang <jasowang@redhat.com>, Dmitry Fleytman
 <dmitry.fleytman@gmail.com>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>, "Andrew
 Melnychenko" <andrew@daynix.com>, Yuri Benditovich
 <yuri.benditovich@daynix.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH] net: Check if nc is NULL in qemu_get_vnet_hdr_len()
Message-ID: <20241010173652.0000691f@huawei.com>
In-Reply-To: <20240817-net-v1-1-699b5591ad3b@daynix.com>
References: <20240817-net-v1-1-699b5591ad3b@daynix.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 17 Aug 2024 16:00:43 +0900
Akihiko Odaki <akihiko.odaki@daynix.com> wrote:

> A netdev may not have a peer specified, resulting in NULL. We should
> make it behave like /dev/null in such a case instead of letting it
> cause segmentatin fault.
> 
> Fixes: 4b52d63249a5 ("tap: Remove qemu_using_vnet_hdr()")
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

FWIW fixed my issue. I'd forgotten about but noticed that
it was still in my tree after a rebase.

Tested-by; Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  net/net.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/net.c b/net/net.c
> index 6938da05e077..4c21d91f9450 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -542,6 +542,10 @@ void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
>  
>  int qemu_get_vnet_hdr_len(NetClientState *nc)
>  {
> +    if (!nc) {
> +        return 0;
> +    }
> +
>      return nc->vnet_hdr_len;
>  }
>  
> 
> ---
> base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
> change-id: 20240817-net-dc461895a295
> 
> Best regards,


