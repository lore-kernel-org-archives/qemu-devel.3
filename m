Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B37C54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 11:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjH1M-0008G3-JH; Wed, 28 Aug 2024 07:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sjH1K-0008Ez-TJ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 07:39:26 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sjH1I-0004Mv-0b
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 07:39:26 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wv2RS1VTBz6J7p0;
 Wed, 28 Aug 2024 19:36:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 5FB7A14038F;
 Wed, 28 Aug 2024 19:39:20 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 12:39:19 +0100
Date: Wed, 28 Aug 2024 12:39:19 +0100
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
 <a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>, 
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH 2/2] hw/cxl/cxl_event: Fix interrupt triggering for
 dynamic capacity events grouped via More flag
Message-ID: <20240828123919.00005b5f@Huawei.com>
In-Reply-To: <20240827164304.88876-3-nifan.cxl@gmail.com>
References: <20240827164304.88876-1-nifan.cxl@gmail.com>
 <20240827164304.88876-3-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 27 Aug 2024 09:40:05 -0700
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> When inserting multiple dynamic capacity event records grouped via More flag,
> we should only trigger interrupt after the last record is inserted into the
> event log. Achieving the goal by letting cxl_event_insert return true only
> for the insertion of the last dynamic capacity event record in the sequence.

I'm not sure this one is accurate.  We might well have a slow
system provisioning capacity one extent at time (and interrupting).

The event buffer might also not be large enough to hold all records so
the device might 'wait' before figuring out the next extent for there
to be somewhere to put the record.

Overall I think we can interrupt on each one and it should 'work'
as should interrupt only once there are lots of them or
every (n).

Interrupt only fires on a 0 to >= 1 transition anyway, not
on repeats after that unless the log has been cleared.
It's up to OS to keep clearing records until it at least
momentarily hits 0 if it wants to get any more interrupts.

Jonathan


> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/cxl/cxl-events.c         | 8 ++++++++
>  include/hw/cxl/cxl_events.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> index 12dee2e467..90536c0e68 100644
> --- a/hw/cxl/cxl-events.c
> +++ b/hw/cxl/cxl-events.c
> @@ -135,6 +135,14 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
>      QSIMPLEQ_INSERT_TAIL(&log->events, entry, node);
>      cxl_event_set_status(cxlds, log_type, true);
>  
> +    /*
> +     * For dynamic capacity event records grouped via More flag,
> +     * Only raise interrupt after inserting the last record in the log.
> +     */
> +    if (log_type == CXL_EVENT_TYPE_DYNAMIC_CAP) {
> +        CXLEventDynamicCapacity *dCap = (CXLEventDynamicCapacity *)event;
> +        return (dCap->flags & MORE_FLAG) ? false : true;
> +    }
>      /* Count went from 0 to 1 */
>      return cxl_event_count(log) == 1;

If there are multiple this will fail I think as cxl_event_count(log) will go from 0
to X not 1.

>  }
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 38cadaa0f3..b0e5cc89c0 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -170,6 +170,7 @@ typedef struct CXLEventMemoryModule {
>   * CXL r3.1 section Table 8-50: Dynamic Capacity Event Record
>   * All fields little endian.
>   */
> +#define MORE_FLAG BIT_MASK(0)
>  typedef struct CXLEventDynamicCapacity {
>      CXLEventRecordHdr hdr;
>      uint8_t type;


