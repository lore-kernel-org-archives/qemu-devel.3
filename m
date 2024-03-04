Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65445C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 15:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh9uH-00050a-OK; Mon, 04 Mar 2024 10:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rh9uD-0004zy-VR; Mon, 04 Mar 2024 10:07:06 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rh9uB-0001us-4r; Mon, 04 Mar 2024 10:07:05 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TpMPt5dqYz6K9SH;
 Mon,  4 Mar 2024 23:02:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id D383A140A36;
 Mon,  4 Mar 2024 23:06:52 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 4 Mar
 2024 15:06:52 +0000
Date: Mon, 4 Mar 2024 15:06:51 +0000
To: Thomas Huth <thuth@redhat.com>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 <qemu-trivial@nongnu.org>
Subject: Re: [PATCH 2/3] hw/pci-bridge/cxl_upstream: Fix problem with
 g_steal_pointer()
Message-ID: <20240304150651.00006dd1@Huawei.com>
In-Reply-To: <20240304104406.59855-3-thuth@redhat.com>
References: <20240304104406.59855-1-thuth@redhat.com>
 <20240304104406.59855-3-thuth@redhat.com>
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

On Mon,  4 Mar 2024 11:44:05 +0100
Thomas Huth <thuth@redhat.com> wrote:

> When setting GLIB_VERSION_MAX_ALLOWED to GLIB_VERSION_2_58 or higher,
> glib adds type safety checks to the g_steal_pointer() macro. This
> triggers errors in the build_cdat_table() function which uses the
> g_steal_pointer() for type-casting from one pointer type to the other
> (which also looks quite weird since the local pointers have all been
> declared with g_autofree though they are never freed here).

Left over of an earlier cleanup where I failed to notice there were no
longer any error return paths. Great to clean this out.

> Let's fix
> it by using a proper typecast instead. For making this possible, we
> have to remove the QEMU_PACKED attribute from some structs since GCC
> otherwise complains that the source and destination pointer might
> have different alignment restrictions. Removing the QEMU_PACKED should
> be fine here since the structs are already naturally aligned. Anyway,
> add some QEMU_BUILD_BUG_ON() statements to make sure that we've got
> the right sizes (without padding in the structs).

Ok. In these cases indeed seem to be fine unpacked. That's
not in general true of the CXL spec structures.
Maybe alternative if we run into problems with future versions
of these structures will be to define struct CDATSubHeader as packed.

Still we can cross that bridge when we come to it.

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  include/hw/cxl/cxl_cdat.h    | 8 +++++---
>  hw/pci-bridge/cxl_upstream.c | 8 ++++----
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_cdat.h b/include/hw/cxl/cxl_cdat.h
> index 8e3d094608..b44cefaad6 100644
> --- a/include/hw/cxl/cxl_cdat.h
> +++ b/include/hw/cxl/cxl_cdat.h
> @@ -130,7 +130,8 @@ typedef struct CDATSslbisHeader {
>      uint8_t data_type;
>      uint8_t reserved[3];
>      uint64_t entry_base_unit;
> -} QEMU_PACKED CDATSslbisHeader;
> +} CDATSslbisHeader;
> +QEMU_BUILD_BUG_ON(sizeof(CDATSslbisHeader) != 16);
>  
>  #define CDAT_PORT_ID_USP 0x100
>  /* Switch Scoped Latency and Bandwidth Entry - CDAT Table 10 */
> @@ -139,12 +140,13 @@ typedef struct CDATSslbe {
>      uint16_t port_y_id;
>      uint16_t latency_bandwidth;
>      uint16_t reserved;
> -} QEMU_PACKED CDATSslbe;
> +} CDATSslbe;
> +QEMU_BUILD_BUG_ON(sizeof(CDATSslbe) != 8);
>  
>  typedef struct CDATSslbis {
>      CDATSslbisHeader sslbis_header;
>      CDATSslbe sslbe[];
> -} QEMU_PACKED CDATSslbis;
> +} CDATSslbis;
>  
>  typedef struct CDATEntry {
>      void *base;
> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> index e87eb40177..537f9affb8 100644
> --- a/hw/pci-bridge/cxl_upstream.c
> +++ b/hw/pci-bridge/cxl_upstream.c
> @@ -192,8 +192,8 @@ enum {
>  
>  static int build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>  {
> -    g_autofree CDATSslbis *sslbis_latency = NULL;
> -    g_autofree CDATSslbis *sslbis_bandwidth = NULL;
> +    CDATSslbis *sslbis_latency;
> +    CDATSslbis *sslbis_bandwidth;
>      CXLUpstreamPort *us = CXL_USP(priv);
>      PCIBus *bus = &PCI_BRIDGE(us)->sec_bus;
>      int devfn, sslbis_size, i;
> @@ -270,8 +270,8 @@ static int build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>      *cdat_table = g_new0(CDATSubHeader *, CXL_USP_CDAT_NUM_ENTRIES);
>  
>      /* Header always at start of structure */
> -    (*cdat_table)[CXL_USP_CDAT_SSLBIS_LAT] = g_steal_pointer(&sslbis_latency);
> -    (*cdat_table)[CXL_USP_CDAT_SSLBIS_BW] = g_steal_pointer(&sslbis_bandwidth);
> +    (*cdat_table)[CXL_USP_CDAT_SSLBIS_LAT] = (CDATSubHeader *)sslbis_latency;
> +    (*cdat_table)[CXL_USP_CDAT_SSLBIS_BW] = (CDATSubHeader *)sslbis_bandwidth;
>  
>      return CXL_USP_CDAT_NUM_ENTRIES;
>  }


