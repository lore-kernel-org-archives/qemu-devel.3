Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7DBC35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 09:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqUVV-0006ND-QR; Tue, 17 Sep 2024 05:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sqUVU-0006M3-AF
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 05:28:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sqUVQ-0005O3-Ow
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 05:28:23 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X7GZP00qGz6D9DZ;
 Tue, 17 Sep 2024 17:24:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id F41EE140C98;
 Tue, 17 Sep 2024 17:28:14 +0800 (CST)
Received: from localhost (10.48.145.97) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 17 Sep
 2024 11:28:14 +0200
Date: Tue, 17 Sep 2024 10:28:12 +0100
To: Dmitry Frolov <frolov@swemel.ru>
CC: <sdl.qemu@linuxtesting.org>, <qemu-devel@nongnu.org>, <fan.ni@samsung.com>
Subject: Re: [PATCH] hw/cxl: fix uint32 overflow cxl-mailbox-utils.c
Message-ID: <20240917102812.000006ad@Huawei.com>
In-Reply-To: <20240917080925.270597-2-frolov@swemel.ru>
References: <20240917080925.270597-2-frolov@swemel.ru>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.145.97]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-1.048, SPF_HELO_NONE=0.001,
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

On Tue, 17 Sep 2024 11:09:16 +0300
Dmitry Frolov <frolov@swemel.ru> wrote:

> The sum offset + length may overflow uint32. Since this sum is
> compared with uint64_t return value of get_lsa_size(), it makes
> sense to choose uint64_t type for offset and length.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
That would take a crazy LSA configuration but indeed looks possible.
Does it matter?

If this happens we'll falsely pass the check, then the values will
get passed into get_lsa() which does have sanity checks, but they
are asserts.

So indeed good to fix this and the suggested fix is fine.

I've queued it up but will be at travelling this week so
might be a while before I send out a fixes series with this in.

Thanks,

Jonathan


> 
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 9258e48f95..9f794e4655 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1445,7 +1445,7 @@ static CXLRetCode cmd_ccls_get_lsa(const struct cxl_cmd *cmd,
>      } QEMU_PACKED *get_lsa;
>      CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>      CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
> -    uint32_t offset, length;
> +    uint64_t offset, length;
>  
>      get_lsa = (void *)payload_in;
>      offset = get_lsa->offset;


