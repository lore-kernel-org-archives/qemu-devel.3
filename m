Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80880C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 15:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh9xn-0007Ys-Kt; Mon, 04 Mar 2024 10:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rh9xl-0007Y9-T4; Mon, 04 Mar 2024 10:10:45 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rh9xj-0002kY-UH; Mon, 04 Mar 2024 10:10:45 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TpMVD2GL1z6K9QK;
 Mon,  4 Mar 2024 23:06:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id D1C4F140516;
 Mon,  4 Mar 2024 23:10:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 4 Mar
 2024 15:10:38 +0000
Date: Mon, 4 Mar 2024 15:10:37 +0000
To: Thomas Huth <thuth@redhat.com>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 <qemu-trivial@nongnu.org>
Subject: Re: [PATCH 3/3] hw/mem/cxl_type3: Fix problem with g_steal_pointer()
Message-ID: <20240304151037.00000f6c@Huawei.com>
In-Reply-To: <20240304104406.59855-4-thuth@redhat.com>
References: <20240304104406.59855-1-thuth@redhat.com>
 <20240304104406.59855-4-thuth@redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

On Mon,  4 Mar 2024 11:44:06 +0100
Thomas Huth <thuth@redhat.com> wrote:

> When setting GLIB_VERSION_MAX_ALLOWED to GLIB_VERSION_2_58 or higher,
> glib adds type safety checks to the g_steal_pointer() macro. This
> triggers errors in the ct3_build_cdat_entries_for_mr() function which
> uses the g_steal_pointer() for type-casting from one pointer type to
> the other (which also looks quite weird since the local pointers have
> all been declared with g_autofree though they are never freed here).
> Fix it by using a proper typecast instead. For making this possible, we
> have to remove the QEMU_PACKED attribute from some structs since GCC
> otherwise complains that the source and destination pointer might
> have different alignment restrictions. Removing the QEMU_PACKED should
> be fine here since the structs are already naturally aligned. Anyway,
> add some QEMU_BUILD_BUG_ON() statements to make sure that we've got
> the right sizes (without padding in the structs).

I missed these as well when getting rid of the false handling
of failure of g_new0 calls.

Another alternative would be to point to the head structures rather
than the containing structure - would avoid need to cast.
That might be neater?  Should I think also remove the alignment
question?


> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/hw/cxl/cxl_cdat.h |  9 ++++++---
>  hw/mem/cxl_type3.c        | 24 ++++++++++++------------
>  2 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_cdat.h b/include/hw/cxl/cxl_cdat.h
> index b44cefaad6..17a09066dc 100644
> --- a/include/hw/cxl/cxl_cdat.h
> +++ b/include/hw/cxl/cxl_cdat.h
> @@ -82,7 +82,8 @@ typedef struct CDATDsmas {
>      uint16_t reserved;
>      uint64_t DPA_base;
>      uint64_t DPA_length;
> -} QEMU_PACKED CDATDsmas;
> +} CDATDsmas;
> +QEMU_BUILD_BUG_ON(sizeof(CDATDsmas) != 24);
>  
>  /* Device Scoped Latency and Bandwidth Information Structure - CDAT Table 5 */
>  typedef struct CDATDslbis {
> @@ -95,7 +96,8 @@ typedef struct CDATDslbis {
>      uint64_t entry_base_unit;
>      uint16_t entry[3];
>      uint16_t reserved2;
> -} QEMU_PACKED CDATDslbis;
> +} CDATDslbis;
> +QEMU_BUILD_BUG_ON(sizeof(CDATDslbis) != 24);
>  
>  /* Device Scoped Memory Side Cache Information Structure - CDAT Table 6 */
>  typedef struct CDATDsmscis {
> @@ -122,7 +124,8 @@ typedef struct CDATDsemts {
>      uint16_t reserved;
>      uint64_t DPA_offset;
>      uint64_t DPA_length;
> -} QEMU_PACKED CDATDsemts;
> +} CDATDsemts;
> +QEMU_BUILD_BUG_ON(sizeof(CDATDsemts) != 24);
>  
>  /* Switch Scoped Latency and Bandwidth Information Structure - CDAT Table 9 */
>  typedef struct CDATSslbisHeader {
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index e8801805b9..b679dfae1c 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -46,12 +46,12 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>                                            int dsmad_handle, MemoryRegion *mr,
>                                            bool is_pmem, uint64_t dpa_base)
>  {
> -    g_autofree CDATDsmas *dsmas = NULL;
> -    g_autofree CDATDslbis *dslbis0 = NULL;
> -    g_autofree CDATDslbis *dslbis1 = NULL;
> -    g_autofree CDATDslbis *dslbis2 = NULL;
> -    g_autofree CDATDslbis *dslbis3 = NULL;
> -    g_autofree CDATDsemts *dsemts = NULL;
> +    CDATDsmas *dsmas;
> +    CDATDslbis *dslbis0;
> +    CDATDslbis *dslbis1;
> +    CDATDslbis *dslbis2;
> +    CDATDslbis *dslbis3;
> +    CDATDsemts *dsemts;
>  
>      dsmas = g_malloc(sizeof(*dsmas));
>      *dsmas = (CDATDsmas) {
> @@ -135,12 +135,12 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>      };
>  
>      /* Header always at start of structure */
> -    cdat_table[CT3_CDAT_DSMAS] = g_steal_pointer(&dsmas);
> -    cdat_table[CT3_CDAT_DSLBIS0] = g_steal_pointer(&dslbis0);
> -    cdat_table[CT3_CDAT_DSLBIS1] = g_steal_pointer(&dslbis1);
> -    cdat_table[CT3_CDAT_DSLBIS2] = g_steal_pointer(&dslbis2);
> -    cdat_table[CT3_CDAT_DSLBIS3] = g_steal_pointer(&dslbis3);
> -    cdat_table[CT3_CDAT_DSEMTS] = g_steal_pointer(&dsemts);
> +    cdat_table[CT3_CDAT_DSMAS] = (CDATSubHeader *)dsmas;
Could do
    cdat_table[CT3_CDAT_DSMAS] = &dsmas->header;
etc
> +    cdat_table[CT3_CDAT_DSLBIS0] = (CDATSubHeader *)dslbis0;
> +    cdat_table[CT3_CDAT_DSLBIS1] = (CDATSubHeader *)dslbis1;
> +    cdat_table[CT3_CDAT_DSLBIS2] = (CDATSubHeader *)dslbis2;
> +    cdat_table[CT3_CDAT_DSLBIS3] = (CDATSubHeader *)dslbis3;
> +    cdat_table[CT3_CDAT_DSEMTS] = (CDATSubHeader *)dsemts;
>  }
>  
>  static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)


