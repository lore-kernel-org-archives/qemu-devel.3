Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2100C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 14:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh9kq-0000oL-De; Mon, 04 Mar 2024 09:57:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rh9ko-0000o4-Ai; Mon, 04 Mar 2024 09:57:22 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rh9kl-0000Aw-GZ; Mon, 04 Mar 2024 09:57:22 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TpM9h6PVxz6K6Y0;
 Mon,  4 Mar 2024 22:52:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 675AC140B67;
 Mon,  4 Mar 2024 22:57:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 4 Mar
 2024 14:57:04 +0000
Date: Mon, 4 Mar 2024 14:57:04 +0000
To: Thomas Huth <thuth@redhat.com>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 <qemu-trivial@nongnu.org>
Subject: Re: [PATCH 1/3] hw/cxl/cxl-cdat: Fix type of buf in ct3_load_cdat()
Message-ID: <20240304145704.00001ea3@Huawei.com>
In-Reply-To: <20240304104406.59855-2-thuth@redhat.com>
References: <20240304104406.59855-1-thuth@redhat.com>
 <20240304104406.59855-2-thuth@redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Mon,  4 Mar 2024 11:44:04 +0100
Thomas Huth <thuth@redhat.com> wrote:

> When setting GLIB_VERSION_MAX_ALLOWED to GLIB_VERSION_2_58 or higher
> (which we'll certainly do in the not too distant future), glib adds
> type safety checks to the g_steal_pointer() macro. This trigger an
> error in the ct3_load_cdat() function: The local char *buf variable is
> assigned to uint8_t *buf in CDATObject, i.e. a pointer of a different
> type. Change the local variable to the same type as buf in CDATObject
> to avoid the error.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  hw/cxl/cxl-cdat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
> index 2fea975671..551545f782 100644
> --- a/hw/cxl/cxl-cdat.c
> +++ b/hw/cxl/cxl-cdat.c
> @@ -114,7 +114,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
>  static void ct3_load_cdat(CDATObject *cdat, Error **errp)
>  {
>      g_autofree CDATEntry *cdat_st = NULL;
> -    g_autofree char *buf = NULL;
> +    g_autofree uint8_t *buf = NULL;
>      uint8_t sum = 0;
>      int num_ent;
>      int i = 0, ent = 1;
> @@ -171,7 +171,7 @@ static void ct3_load_cdat(CDATObject *cdat, Error **errp)
>          cdat_st[ent].base = hdr;
>          cdat_st[ent].length = hdr->length;
>  
> -        while (buf + i < (char *)cdat_st[ent].base + cdat_st[ent].length) {
> +        while (buf + i < (uint8_t *)cdat_st[ent].base + cdat_st[ent].length) {
>              assert(i < file_size);
>              sum += buf[i++];
>          }


