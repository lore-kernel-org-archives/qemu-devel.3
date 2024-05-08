Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657D4C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 16:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4jx0-0000nZ-EV; Wed, 08 May 2024 12:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1s4jww-0000nE-Jn
 for qemu-devel@nongnu.org; Wed, 08 May 2024 12:15:23 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1s4jwt-0004Br-QX
 for qemu-devel@nongnu.org; Wed, 08 May 2024 12:15:22 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VZKwk4k31z6DB9d;
 Thu,  9 May 2024 00:14:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 278E9140AB8;
 Thu,  9 May 2024 00:15:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 8 May
 2024 17:15:15 +0100
Date: Wed, 8 May 2024 17:15:14 +0100
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC: Ira Weiny <ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <dan.j.williams@intel.com>, <dave@stgolabs.net>,
 <alison.schofield@intel.com>, <shiju.jose@huawei.com>
Subject: Re: [PATCH v3 2/2] cxl/core: add poison creation event handler
Message-ID: <20240508171514.000031dd@Huawei.com>
In-Reply-To: <0d0b087f-9aa4-45d3-9412-0b1a6a005c52@fujitsu.com>
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>
 <6627f68be4ff5_cd8e0294c3@iweiny-mobl.notmuch>
 <0d0b087f-9aa4-45d3-9412-0b1a6a005c52@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 3 May 2024 18:42:31 +0800
Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> =E5=9C=A8 2024/4/24 1:57, Ira Weiny =E5=86=99=E9=81=93:
> > Shiyang Ruan wrote: =20
> >> Currently driver only traces cxl events, poison creation (for both vmem
> >> and pmem type) on cxl memdev is silent.  OS needs to be notified then =
it
> >> could handle poison pages in time.  Per CXL spec, the device error eve=
nt
> >> could be signaled through FW-First and OS-First methods.
> >>
> >> So, add poison creation event handler in OS-First method:
> >>    - Qemu:
> >>      - CXL device reports POISON creation event to OS by MSI by sending
> >>        GMER/DER after injecting a poison record;
> >>    - CXL driver:
> >>      a. parse the POISON event from GMER/DER;
> >>      b. translate poisoned DPA to HPA (PFN);
> >>      c. enqueue poisoned PFN to memory_failure's work queue; =20
> >=20
> > I'm a bit confused by the need for this patch.  Perhaps a bit more deta=
il
> > here? =20
>=20
> Yes, I should have wrote more details.
>=20
> I want to check and make sure the HWPOISON on a CXL device (type3) is=20
> working properly.  For example, a FSDAX filesystem created on a=20
> type3-pmem device, then it gets a POISON bit, the OS should be able to=20
> handle this POISON event: find the relevant process
>=20
> Currently I'm using Qemu with several simulated CXL devices, and using=20
> poison injection API of Qemu to create POISON records, but OS isn't=20
> notified.  Only when we actively call list POISON records (cxl list -L)=20
> will the driver fetch them and log into trace events, then we see the=20
> POISON records.  Memory failure wasn't triggered too.
>=20

Indeed - QEMU emulation of this is not complete.  It should also be generat=
ing
the events. Ideally we'd even handle injecting silent poison (not yet detec=
ted
by the device) and have that generate the synchronous memory faults on an a=
ccess.

> That's why I said "poison creation on cxl memdev is silent".  Per spec,=20
> POISON creation should be notified to OS.  Since not familiar with=20
> firmware part, I'm try adding this notification for OS-First.
>=20
> >=20
> > More comments below.
> >  =20
> >>
> >> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> >> ---
> >>   drivers/cxl/core/mbox.c   | 119 +++++++++++++++++++++++++++++++++---=
--
> >>   drivers/cxl/cxlmem.h      |   8 +--
> >>   include/linux/cxl-event.h |  18 +++++-
> >>   3 files changed, 125 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> >> index f0f54aeccc87..76af0d73859d 100644
> >> --- a/drivers/cxl/core/mbox.c
> >> +++ b/drivers/cxl/core/mbox.c
> >> @@ -837,25 +837,116 @@ int cxl_enumerate_cmds(struct cxl_memdev_state =
*mds)
> >>   }
> >>   EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
> >>  =20
> >> -void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> >> -			    enum cxl_event_log_type type,
> >> -			    enum cxl_event_type event_type,
> >> -			    const uuid_t *uuid, union cxl_event *evt)
> >> +static void cxl_report_poison(struct cxl_memdev *cxlmd, struct cxl_re=
gion *cxlr,
> >> +			      u64 dpa)
> >>   {
> >> -	if (event_type =3D=3D CXL_CPER_EVENT_GEN_MEDIA)
> >> +	u64 hpa =3D cxl_trace_hpa(cxlr, cxlmd, dpa);
> >> +	unsigned long pfn =3D PHYS_PFN(hpa);
> >> +
> >> +	if (!IS_ENABLED(CONFIG_MEMORY_FAILURE))
> >> +		return;
> >> +
> >> +	memory_failure_queue(pfn, MF_ACTION_REQUIRED); =20
> >=20
> > I thought that ras daemon was supposed to take care of this when the tr=
ace
> > event occurred.  Alison is working on the HPA data for that path. =20
>=20
> It seems to save CXL trace events/memory-failures to DB and report to=20
> others, but cannot let OS call memory failure.

Interesting question of whose problem this is.  For corrected
errors it's policy stuff that belongs in userspace, but for known
memory failure, it might want to be in kernel.

Shiju (+Cc) pointed me a the existing rasdaemon handling for corrected
errors (statistics get too bad, so memory offlined)=20
https://github.com/mchehab/rasdaemon/commit/9ae6b70effb8adc9572debc800b8e16=
173f74bb8

Poison detection via scrub though is reported via CPER Memory Error Section=
 with
"Scrub uncorrected error" set. That triggers apei handling. On
x86 looks to be apei_mce_report_mem_error(). Also triggers
the ghes_do_memory_failure_path() and ultimately memory_failure().

Conveniently there was a patch fixing the sync path last year
that includes info on what happens in async case.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Da70297d2213253853e95f5b49651f924990c6d3b

"In addition, for aysnchronous errors, kernel will notify the
process who owns the poisoned page by sending SIGBUS with BUS_MCERRR_A0
in early kill mode."

So I think the kernel should probably do the same for CXL poison
error records when it gets them.

Jonathan


