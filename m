Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F2BD16245
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 11:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0JAk-0006xf-6G; Mon, 14 Oct 2024 07:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t0JAh-0006wz-FV
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:23:31 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t0JAe-0002h6-V6
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:23:31 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRvwY1842z6J9hQ;
 Mon, 14 Oct 2024 19:22:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id A4CF3140C98;
 Mon, 14 Oct 2024 19:23:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 13:23:24 +0200
Date: Mon, 14 Oct 2024 12:23:22 +0100
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
 <a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>, 
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [QEMU RFC] hw/mem/cxl_type3: add guard to avoid event log
 overflow during a DC extent add/release request
Message-ID: <20241014122322.00001ad4@Huawei.com>
In-Reply-To: <20241011202929.11611-2-nifan.cxl@gmail.com>
References: <20241011202929.11611-2-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 11 Oct 2024 13:24:50 -0700
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> One DC extent add/release request can take multiple DC extents.
> For each extent in the request, one DC event record will be generated and
> isnerted into the event log. All the event records for the request will be
> grouped with the More flag (see CXL spec r3.1, Table 8-168 and 8-170).
> If an overflow happens during the process, the yet-to-insert records will
> get lost, leaving the device in a situation where it notifies the host
> only part of the extents involved, and the host never surfacing the
> extents received and waiting for the remaining extents.

Interesting corner.  For other 'events' an overflow is natural because
they can be out of the control of the device. This artificial limit
was to trigger the overflow handling in those cases. For this one I'd expect
the device to push back on the fabric management commands, or handle the
event log filling so overflow doesn't happen.

> 
> Add a check in qmp_cxl_process_dynamic_capacity_prescriptive and ensure
> the event log does not overflow during the process.
> 
> Currently we check the number of extents involved with the event
> overflow threshold, do we need to tight the check and compare with
> the remaining spot available in the event log?

Yes. I think we need to prevent other outstanding events causing us trouble.

Is it useful to support the case where we have more than one
group of extents outstanding?  If not we could simply fail the add whenever
that happens.  Maybe that is a reasonable stop gap until we have a reason
to care about that case. We probably care when we have FM-API hooked up
to this and want to test more advanced fabric management stuff, or poke
a corner of the kernel code perhaps?

I guess from a 'would it be right if a device did this' the answer may be
yes, but that doesn't mean Linux is going to support such a device
(at least not until we know they really exist).  Ira, what do you think
about this corner case?  Maybe detect and scream if we aren't already?

Jonathan

> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/cxl/cxl-events.c         | 2 --
>  hw/mem/cxl_type3.c          | 7 +++++++
>  include/hw/cxl/cxl_events.h | 3 +++
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> index 12dee2e467..05d8aae627 100644
> --- a/hw/cxl/cxl-events.c
> +++ b/hw/cxl/cxl-events.c
> @@ -16,8 +16,6 @@
>  #include "hw/cxl/cxl.h"
>  #include "hw/cxl/cxl_events.h"
>  
> -/* Artificial limit on the number of events a log can hold */
> -#define CXL_TEST_EVENT_OVERFLOW 8
>  
>  static void reset_overflow(CXLEventLog *log)
>  {
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 3d7289fa84..32668df365 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -2015,6 +2015,13 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
>          num_extents++;
>      }
>  
> +    if (num_extents > CXL_TEST_EVENT_OVERFLOW) {
> +        error_setg(errp,
> +                   "at most %d extents allowed in one add/release request",
> +                   CXL_TEST_EVENT_OVERFLOW);
> +       return;
> +    }
> +
>      /* Create extent list for event being passed to host */
>      i = 0;
>      list = records;
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 38cadaa0f3..2a6b57e3e6 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -12,6 +12,9 @@
>  
>  #include "qemu/uuid.h"
>  
> +/* Artificial limit on the number of events a log can hold */
> +#define CXL_TEST_EVENT_OVERFLOW 8
> +
>  /*
>   * CXL r3.1 section 8.2.9.2.2: Get Event Records (Opcode 0100h); Table 8-52
>   *


