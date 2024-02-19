Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C81C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6MF-0004Uc-Md; Mon, 19 Feb 2024 11:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rc6ME-0004UR-2T
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:19:06 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rc6Lx-0007TF-AN
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:19:05 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TdngZ2Khkz6K9DY;
 Tue, 20 Feb 2024 00:15:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id ADF801404FC;
 Tue, 20 Feb 2024 00:18:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 16:18:39 +0000
Date: Mon, 19 Feb 2024 16:18:38 +0000
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
 <a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>, 
 <nifan@outlook.com>, <jim.harris@samsung.com>
Subject: Re: [PATCH v3 0/9] Enabling DCD emulation support in Qemu
Message-ID: <20240219161838.0000592e@Huawei.com>
In-Reply-To: <ZcuyZ0Nwq31z8YIr@debian>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
 <ZcuyZ0Nwq31z8YIr@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Tue, 13 Feb 2024 10:18:15 -0800
fan <nifan.cxl@gmail.com> wrote:

> On Tue, Nov 07, 2023 at 10:07:04AM -0800, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <nifan.cxl@gmail.com>
> > 
> > 
> > The patch series are based on Jonathan's branch cxl-2023-09-26.
> > 
> > The main changes include,
> > 1. Update cxl_find_dc_region to detect the case the range of the extent cross
> >     multiple DC regions.
> > 2. Add comments to explain the checks performed in function
> >     cxl_detect_malformed_extent_list. (Jonathan)
> > 3. Minimize the checks in cmd_dcd_add_dyn_cap_rsp.(Jonathan)
> > 4. Update total_extent_count in add/release dynamic capacity response function.
> >     (Ira and Jorgen Hansen).
> > 5. Fix the logic issue in test_bits and renamed it to
> >     test_any_bits_set to clear its function.
> > 6. Add pending extent list for dc extent add event.
> > 7. When add extent response is received, use the pending-to-add list to
> >     verify the extents are valid.
> > 8. Add test_any_bits_set and cxl_insert_extent_to_extent_list declaration to
> >     cxl_device.h so it can be used in different files.
> > 9. Updated ct3d_qmp_cxl_event_log_enc to include dynamic capacity event
> >     log type.
> > 10. Extract the functionality to delete extent from extent list to a helper
> >     function.
> > 11. Move the update of the bitmap which reflects which blocks are backed with
> > dc extents from the moment when a dc extent is offered to the moment when it
> > is accepted from the host.
> > 12. Free dc_name after calling address_space_init to avoid memory leak when
> >     returning early. (Nathan)
> > 13. Add code to detect and reject QMP requests without any extents. (Jonathan)
> > 14. Add code to detect and reject QMP requests where the extent len is 0.
> > 15. Change the QMP interface and move the region-id out of extents and now
> >     each command only takes care of extent add/release request in a single
> >     region. (Jonathan)
> > 16. Change the region bitmap length from decode_len to len.
> > 17. Rename "dpa" to "offset" in the add/release dc extent qmp interface.
> >     (Jonathan)
> > 18. Block any dc extent release command if the exact extent is not already in
> >     the extent list of the device.
> > 
> > The code is tested together with Ira's kernel DCD support:
> > https://github.com/weiny2/linux-kernel/tree/dcd-v3-2023-10-30
> > 
> > Cover letter from v2 is here:
> > https://lore.kernel.org/linux-cxl/20230724162313.34196-1-fan.ni@samsung.com/T/#m63039621087023691c9749a0af1212deb5549ddf
> > 
> > Last version (v2) is here:
> > https://lore.kernel.org/linux-cxl/20230725183939.2741025-1-fan.ni@samsung.com/
> > 
> > More DCD related discussions are here:
> > https://lore.kernel.org/linux-cxl/650cc29ab3f64_50d07294e7@iweiny-mobl.notmuch/
> > 
> > 
> > 
> > Fan Ni (9):
> >   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
> >     payload of identify memory device command
> >   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
> >     and mailbox command support
> >   include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
> >     type3 memory devices
> >   hw/mem/cxl_type3: Add support to create DC regions to type3 memory
> >     devices
> >   hw/mem/cxl_type3: Add host backend and address space handling for DC
> >     regions
> >   hw/mem/cxl_type3: Add DC extent list representative and get DC extent
> >     list mailbox support
> >   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
> >     dynamic capacity response
> >   hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
> >     extents
> >   hw/mem/cxl_type3: Add dpa range validation for accesses to dc regions
> > 
> >  hw/cxl/cxl-mailbox-utils.c  | 469 +++++++++++++++++++++++++++++-
> >  hw/mem/cxl_type3.c          | 548 +++++++++++++++++++++++++++++++++---
> >  hw/mem/cxl_type3_stubs.c    |  14 +
> >  include/hw/cxl/cxl_device.h |  64 ++++-
> >  include/hw/cxl/cxl_events.h |  15 +
> >  qapi/cxl.json               |  60 +++-
> >  6 files changed, 1123 insertions(+), 47 deletions(-)
> > 
> > -- 
> > 2.42.0
> >   
> 
> Hi Jonathan,
> 
> I have updated the patch set based on your feedback and aligned the code
> to cxl spec r3.1.
> 
> Here is the new code:
> https://github.com/moking/qemu/tree/dcd-v4
> 
> I plan to send it out for review early next week to see if there is any kernel
> side update for dcd this week so I can test more.

Excellent!

> 
> If the plan needs to be adjusted to align with the merge window, please
> let me know.

I'm focused on the TCG and physmem fixes right now, but would like to do
a detailed review of your new version later this week.

We have a few more weeks - probably want a final version to be on list by
end of this month - so there is a bit of time before the soft feature freeze
on the 12th March https://wiki.qemu.org/Planning/9.0

> 
> v3[1]->v4: 
> 
> The code is rebased on mainstream QEMU with the following patch series:
> 
> [PATCH 00/12 qemu] CXL emulation fixes and minor cleanup.
> [PATCH 0/5 qemu] hw/cxl: Update CXL emulation to reflect and reference r3.1
Those 2 series our now upstream :)

> hw/cxl/mailbox: change CCI cmd set structure to be a member, not a reference
> hw/cxl/mailbox: interface to add CCI commands to an existing CCI
> 
> Main changes include:
> 
> 1. Updated the specification references to align with cxl spec r3.1.
> 2. Add extra elements to get dc region configuration output payload and
> procecced accordingly in mailbox command 4800h.
> 3. Removed the unwanted space.
> 4. Refactored ct3_build_cdat_entries_for_mr and extract it as a separate patch.
> 5. Updated cxl_create_dc_regions function to derive region len from host
> backend size.
> 6. Changed the logic for creating DC regions when host backend and address
> space processing is introduced, now cxl_create_dc_regions is called only
> when host backend exists.
> 7. Updated the name of the definitions related to DC extents for consistency.
> 7. Updated dynamic capacity event record definition to align with spec r3.1.
> 9. Changed the dynamic capacity request process logic, for release request,
> extra checks are done against the pending list to remove the extent yet added.
> 10. Changed the return value of cxl_create_dc_regions so the return can be used
> to remove the extent for the list if needed.
> 11. Offset and size in the qmp interface are changed to be byte-wise while the
> original is MiB-wise.
> 12. Fixed bugs in handling bitmap for dpa range existence.
> 13. NOTE: in previous version DC is set to non-volatile, while in this version
> we change it to volatile per Jonathan's suggestion.
> 14. Updated the doc in qapi/cxl.json.

All sound good. I'll not attempt to review in the git tree  - I've gotten far
too used to email flows for review but I should be able to get on it fairly
quickly once posted. 

> 
> Thank Jonathan for the detailed review of the last version[1].
> 
> The code is tested with Ira's last kernel DCD patch set [2] with some minor
> bug fixes[3]. Tested operations include:
> 1. create DC region;
> 2. Add/release DC extents;
> 3. convert DC capacity into system RAM;

I guess that will hit the TCG bugs/missing features if we end up with page tables
in it.  Should have same problems as for non DC regions.

Review feedback has been helpful on the TCG changes so they should be in 9.0 I think.
Will go via different paths to the CXL support however so no idea when they'll be
in relative to DC support.

Thanks,

Jonathan


> 
> 
> v3: 
> [1] https://lore.kernel.org/linux-cxl/20231107180907.553451-1-nifan.cxl@gmail.com/T/#t
> [2] https://github.com/weiny2/linux-kernel/tree/dcd-v3-2023-10-30
> [3] https://github.com/moking/linux-dcd/commit/9d24fa6e5d39f934623220953caecc080f93e964


