Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07029C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 09:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF9P6-0005sw-1g; Thu, 06 Jun 2024 05:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sF9P3-0005sW-W7
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:27:26 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sF9P0-0005qe-UQ
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:27:25 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VvzQ84typz6JBbD;
 Thu,  6 Jun 2024 17:22:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 7F9C71420FF;
 Thu,  6 Jun 2024 17:27:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 10:27:02 +0100
Date: Thu, 6 Jun 2024 10:27:01 +0100
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>, <qemu-devel@nongnu.org>,
 <ankita@nvidia.com>, <philmd@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, "Huang
 Ying" <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <imammedo@redhat.com>, <linux-cxl@vger.kernel.org>,
 <linuxarm@huawei.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH qemu ] hw/acpi: Fix big endian host creation of Generic
 Port Affinity Structures
Message-ID: <20240606102701.000008de@Huawei.com>
In-Reply-To: <20240605193521-mutt-send-email-mst@kernel.org>
References: <20240605180455.18193-1-Jonathan.Cameron@huawei.com>
 <20240605193521-mutt-send-email-mst@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Wed, 5 Jun 2024 19:38:18 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jun 05, 2024 at 07:04:55PM +0100, Jonathan Cameron wrote:
> > Treating the HID as an integer caused it to get bit reversed
> > on big endian hosts running little endian guests.  Treat it
> > as a character array instead.
> > 
> > Fixes hw/acpi: Generic Port Affinity Structure Support
> > Tested-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > ---
> > Richard ran the version posted in the thread on an s390 instance.
> > Thanks for the help!
> > 
> > Difference from version in thread:
> > - Instantiate i in the for loop.
> > 
> > Sending out now so Michael can decide whether to fold this in, or
> > drop the GP series for now from his pull request (in which case
> > I'll do an updated version with this and Markus' docs feedback
> > folded in.)  
> 
> 
> Dropped for now.
> 
> 
> > ---
> >  include/hw/acpi/acpi_generic_initiator.h | 2 +-
> >  hw/acpi/acpi_generic_initiator.c         | 4 +++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
> > index 1a899af30f..5baefda33a 100644
> > --- a/include/hw/acpi/acpi_generic_initiator.h
> > +++ b/include/hw/acpi/acpi_generic_initiator.h
> > @@ -61,7 +61,7 @@ typedef struct PCIDeviceHandle {
> >              uint16_t bdf;
> >          };
> >          struct {
> > -            uint64_t hid;
> > +            char hid[8];
> >              uint32_t uid;
> >          };
> >      };  
> 
> I think there is another issue:
> 
> +        memcpy(&dev_handle.hid, hid, sizeof(dev_handle.hid));
> 
> not nice since there is no check that 8 will hold all of
> +        const char *hid = "ACPI0016";
> and won't access buffer out of range.
> 

I think, in theory, that won't ever happen unless someone is using
an invalid ACPI ID as they 'must' be 8 chars (or a uint64_t which
would also be fine).  A bit of defensive programming seems
sensible though as there are known buggy real firmware's
that have invalid IDs so maybe one day someone will add one
of those to QEMU when we aren't paying attention.

I'll add a sanity check and treat such a value as an error.
It'll also act as documentation of the requirement.

if (strlen(hid) != sizeof(dev_handle.hid)) {
    error_printf("ACPI ID for generic port is not the expected 8 characters");
    exit(-1);	
}



> 
> 
> 
> > diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> > index 78b80dcf08..f064753b67 100644
> > --- a/hw/acpi/acpi_generic_initiator.c
> > +++ b/hw/acpi/acpi_generic_initiator.c
> > @@ -151,7 +151,9 @@ build_srat_generic_node_affinity(GArray *table_data, int node,
> >          build_append_int_noprefix(table_data, 0, 12);
> >      } else {
> >          /* Device Handle - ACPI */
> > -        build_append_int_noprefix(table_data, handle->hid, 8);
> > +        for (int i = 0; i < sizeof(handle->hid); i++) {
> > +            build_append_int_noprefix(table_data, handle->hid[i], 1);
> > +        }
> >          build_append_int_noprefix(table_data, handle->uid, 4);
> >          build_append_int_noprefix(table_data, 0, 4);
> >      }
> > -- 
> > 2.39.2  
> 
> 


