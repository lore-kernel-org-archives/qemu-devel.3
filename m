Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E231C7EE30
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 16:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUpdl-0003at-T4; Thu, 26 Jun 2025 12:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uUpdj-0003af-Ji
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 12:39:55 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uUpdh-0001Ve-BU
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 12:39:55 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2349f096605so19793705ad.3
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750955991; x=1751560791; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+26Zun43B2AxqYcDJBZegTuekWT1lFhWkNgQQqBWE+8=;
 b=UWtxBYn3UxnGCjU5ptF/ngIF3qMGsYRKk38kBL/2Vgr2ng1CMbxufLbYrWdKcR/Wk9
 sQpKY60GIXlM/g3eTgbequWDsjWU7I/eeOZuHdEQFCENjD1ysOA2XhHXG/mgiSkq2htX
 nJry34JKXXSqur6eKOh696iPDlEifyvF2bkpOTUQdYxGU97MwD73mzAsCflteo/JbOyZ
 77wocB2vQgzvNqVzcraix+kSgyLD992SGbQdxbpfsscDhCWvU5VvckEgeCINoX7JARWF
 P0Kn873LExgwsiDDW2nowhugt+U9gsj2WpMx92pMtN9kTyOdoqLPN9H3dOeXw2Rx4uut
 xBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750955991; x=1751560791;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+26Zun43B2AxqYcDJBZegTuekWT1lFhWkNgQQqBWE+8=;
 b=CEsDBe0QBRwBL1FjrCIwdgYTbqyvePe1g5kHaPXj/QPSUIFgWAfcT8IPNcqGbsbDdw
 gwqjSrR4l5Kng4QsYmEPXfaoXaWFStFih0V5u6aL8r28s0sUx2wnElsdwV3p61pVBGIJ
 PQwVkIeLguzLDfejy5g73vxSc/Pes7q1UhDfSqpBsnJ+oLhZTXl7fUIv6J3TG5KU9T5R
 VpF1Qg9gjXNkIfKDxtfnt7RmCr2pYr4asM3Ph1X5kAOmtskenSFzTgNnmzqUOumIuxbt
 LmQdIHcLNUSoeKewRA8CrBgeN53ZNF2gfJqv5AewD1ynpNrMLs3bgRHhUvZg5aps8Onl
 slRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu6ICcsA/JRBKuJutjjBTYNE5dExATRP/BAvK7wzSuJbgVqiOvUAlXfzy9BQA0VC0xiaaPpzAUpLid@nongnu.org
X-Gm-Message-State: AOJu0Yw4WvZjZzpXs59I7OdqFo0wvRy9LLokfh2dcpw7jIWmPBrMr2TI
 ieO5s+6T///2cIAgX8voI/qBKYYH+52OdgUixaftg1wxV2+Rf7kDp7c6
X-Gm-Gg: ASbGncuYOGhULxCKjbpGkd4dOAMv6fgpSeoJZaWODlmmpvFT7i3BAejpkqwvbVQjA8T
 nj1O3jGJbp3l7ifZJo5d8tY7/mF81Nu5ZzLWf8W/NUJjBFg68/jIfhE2m++YI4fYrHp6Di8MAzU
 uBdBXg/TpWOW7gk91AFVUdJ0bIf6rfzjJS0wFUmrQvPz4VKbDdKBo9fDt9CI+0uKZ0UK40YsPt1
 cxegfuZ2pfnBsah8arAbC7zq7LAllvFHb3Mz5NTgwimJw3KQpUlNb2gKGA/XUOWTD1v7u3NpgwB
 2JIAPYWwTzRQZvOoEqK/yHE/pu15YxtBg0oLN4Pi+fNBHCoCT10B
X-Google-Smtp-Source: AGHT+IEKF3fyyiTSPb7iOizIGQFwdW7z6sbjGfxSdS3gbTfwefLsi7KudG4dU1vMafwPPEeQt8yyBg==
X-Received: by 2002:a17:902:da88:b0:234:a139:1216 with SMTP id
 d9443c01a7336-23824087149mr144328125ad.44.1750955990409; 
 Thu, 26 Jun 2025 09:39:50 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:9be8:283b:868f:19a1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23abe3dc5a4sm1891465ad.135.2025.06.26.09.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 09:39:49 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 26 Jun 2025 09:39:46 -0700
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org, gregory.price@memverge.com,
 ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, jim.harris@samsung.com,
 Jorgen.Hansen@wdc.com, wj28.lee@gmail.com, armbru@redhat.com,
 mst@redhat.com, anisa.su887@gmail.com
Subject: Re: [PATCH v8 00/14] Enabling DCD emulation support in Qemu
Message-ID: <aF130g16NVsHpx0E@lg>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
 <20250625152234.0000159e.alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625152234.0000159e.alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 25, 2025 at 03:22:34PM +0100, Alireza Sanaee wrote:
> On Thu, 23 May 2024 10:44:40 -0700
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <nifan.cxl@gmail.com>
> > 
> > A git tree of this series can be found here (with one extra commit on
> > top for printing out accepted/pending extent list for testing): 
> > https://github.com/moking/qemu/tree/dcd-v8-qapi
> > 
> > v7->v8:
> > 
> > This version carries over the following two patches from Gregory.
> > 1. hw/cxl/mailbox: change CCI cmd set structure to be a member, not a
> > reference https://gitlab.com/jic23/qemu/-/commit/f44ebc5a455ccdd6535879b0c5824e0d76b04da5
> > 2. hw/cxl/mailbox: interface to add CCI commands to an existing CCI
> > https://gitlab.com/jic23/qemu/-/commit/00a4dd8b388add03c588298f665ee918626296a5
> > 
> > Note, the above two patches are not directly related to DCD emulation.
> > 
> > All the following patches in this series are built on top of
> > mainstream QEMU and the above two patches.
> > 
> > The most significant changes of v8 is in Patch 11 (Patch 9 in v7).
> > Based on feedback from Markus and Jonathan, the QMP interfaces for
> > adding and releasing DC extents have been redesigned and now they
> > look like below,
> > 
> > # add a 128MB extent at offset 0 to region 0
> > 	{ "execute": "cxl-add-dynamic-capacity",
> > 	  "arguments": {
> > 		  "path": "/machine/peripheral/cxl-memdev0",
> >           "host-id":0,
> >           "selection-policy": 'prescriptive',
> > 		  "region": 0,
> >           "tag": "",
> > 		  "extents": [
> > 		  {
> > 			  "offset": 0,
> > 			  "len": 134217728
> > 		  }
> > 		  ]
> > 	  }
> > 	}
> > 
> > Note: tag is optional.
> > 
> > # Release a 128MB extent at offset 0 from region 0
> >  { "execute": "cxl-release-dynamic-capacity",
> > 	  "arguments": {
> > 		  "path": "/machine/peripheral/cxl-memdev0",
> >           "host-id":0,
> >           "removal-policy":"prescriptive",
> >           "forced-removal": false,
> >           "sanitize-on-release": false,
> >           "region": 0,
> >           "tag": "",
> > 		  "extents": [
> > 		  {
> > 			  "offset": 0,
> > 			  "len": 134217728
> > 		  }
> > 		  ]
> > 	  }
> > 	}
> >     
> > Note: removal-policy, sanitize-on-release and tag are optional.
> >     
> > Other changes include,
> > 1. Applied tags to patches. 
> > 2. Replaced error_setq with error_append_hint for
> > cxl_create_dc_region error case in Patch 6 (Patch 4 in v7); (Zhijian
> > Li) 3. Updated the error message to include region size information in
> >     cxl_create_dc_region.
> > 4. set range1_size_hi to 0 for DCD in build_dvsec. (Jonathan)
> > 5. Several minor format fixes.
> > 
> > Thanks Markus, Jonathan, Gregory, and Zhijian for reviewing v7 and
> > svetly Todorov for testing v7.
> > 
> > This series pass the same tests as v7 check the cover letter of v7 for
> > more details. Additionally, we tested the QAPI interface for
> > adding/releasing DC extents with optional input parameters.
> >   
> > 
> > v7: https://lore.kernel.org/linux-cxl/5856b7a4-4082-465f-9f61-b1ec6c35ef0f@fujitsu.com/T/#mec4c85022ce28c80b241aaf2d5431cadaa45f097
> > 
> > 
> > Fan Ni (12):
> >   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
> >     payload of identify memory device command
> >   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
> >     and mailbox command support
> >   include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
> >     type3 memory devices
> >   hw/mem/cxl_type3: Add support to create DC regions to type3 memory
> >     devices
> >   hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr
> >     size instead of mr as argument
> >   hw/mem/cxl_type3: Add host backend and address space handling for DC
> >     regions
> >   hw/mem/cxl_type3: Add DC extent list representative and get DC
> > extent list mailbox support
> >   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support
> > add/release dynamic capacity response
> >   hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
> >     extents
> >   hw/mem/cxl_type3: Add DPA range validation for accesses to DC
> > regions hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox
> > support hw/mem/cxl_type3: Allow to release extent superset in QMP
> > interface
> > 
> > Gregory Price (2):
> >   hw/cxl/mailbox: change CCI cmd set structure to be a member, not a
> >     reference
> >   hw/cxl/mailbox: interface to add CCI commands to an existing CCI
> > 
> >  hw/cxl/cxl-mailbox-utils.c  | 658
> > +++++++++++++++++++++++++++++++++++- hw/mem/cxl_type3.c          |
> > 634 ++++++++++++++++++++++++++++++++-- hw/mem/cxl_type3_stubs.c    |
> > 25 ++ include/hw/cxl/cxl_device.h |  85 ++++-
> >  include/hw/cxl/cxl_events.h |  18 +
> >  qapi/cxl.json               | 143 ++++++++
> >  6 files changed, 1511 insertions(+), 52 deletions(-)
> > 
> 
> Hi Nifan,
> 
> I am trying to test this patchset with Ira's set on DCD, and I am
> trying to work out everything by using sysfs rather than using tools
> instead. I am not sure where things are going of the rail.
> 
> I am using this patchset
> (https://lore.kernel.org/qemu-devel/20240523174651.1089554-2-nifan.cxl@gmail.com/) with Ira's v9 https://lore.kernel.org/all/20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com/
> 
> This my CXL config:
> return [
>     "-m",      "6G,maxmem=20G,slots=10",
>     "-object", "memory-backend-ram,id=vmem0,share=on,size=2G",
>     "-device", "pxb-cxl,bus_nr=23,bus=pcie.0,id=cxl.1",
>     "-device","cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2", 
>     "-device","cxl-type3,bus=root_port13,volatile-dc-memdev=vmem0,id=cxl-vmem0,num-dc-regions=2",
>     "-M", "cxl=on,cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G" 
> ]
> 
> 
> This is how I create a new CXL DC Region ready to work with.
> 
> # creating a region
> region=$(cat
> /sys/bus/cxl/devices/decoder0.0/create_dynamic_ram_a_region) 
> echo $region
> 
> echo $region >
> /sys/bus/cxl/devices/decoder0.0/create_dynamic_ram_a_region 
> echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity 
> echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> 
> echo "dynamic_ram_a" > /sys/bus/cxl/devices/decoder2.0/mode
> echo $((256 << 20)) > /sys/bus/cxl/devices/decoder2.0/dpa_size
> 
> echo $((256 << 20)) > /sys/bus/cxl/devices/$region/size
> echo "decoder2.0" > /sys/bus/cxl/devices/$region/target0
> echo 1 > /sys/bus/cxl/devices/$region/commit
> 
> echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> 
> After this I have two things created, region0 and dax_region0:
> 
> root@localhost:~# ls /sys/bus/cxl/devices/
> dax_region0/    decoder1.0/     decoder1.2/     decoder2.0/
> decoder2.2/     endpoint2/      nvdimm-bridge0/ region0/ decoder0.0/
>  decoder1.1/     decoder1.3/     decoder2.1/     decoder2.3/     mem0/
>          port1/          root0/
> 
> This is what I have in dax_region0:
> root@localhost:~# ls /sys/bus/cxl/devices/dax_region0/
> dax0.0  dax_region  devtype  driver  modalias  subsystem  uevent
> 
> Now I want to add an extent, and this is how I am doing it:
> 	
> 	{ "execute": "cxl-add-dynamic-capacity",
> 	  "arguments": {
> 		  "path": "/machine/peripheral/cxl-memdev0",
>           "host-id":0,
>           "selection-policy": 'prescriptive',
> 		  "region": 0,
>           "tag": "",
> 		  "extents": [
> 		  {
> 			  "offset": 0,
> 			  "len": 134217728
> 		  }
> 		  ]
> 	  }
> 	}
> 
> Now I see the extent added in my region device:
> root@localhost:~# ls /sys/bus/cxl/devices/dax_region0/
> dax0.0  dax_region  devtype  driver  extent0.0  modalias  subsystem
> uevent root@localhost:~# ls /sys/bus/cxl/devices/dax_region0/extent0.0/
> length  offset  uevent
> 
> This is where things will go off the rails, at this point I want to
> create a new dax device to use, but this part is unsuccessful. Here I
> first add some size to the dax region created before: 
> 
> root@localhost:~# echo 67108864 > /sys/bus/dax/devices/dax0.0/size 
> [264.539280] dax:alloc_dev_dax_range:1015: dax dax0.0: alloc range[0]:
> 0x0000000810000000:0x0000000813ffffff 
> 
> When I check the size everything looks OK: 
> root@localhost:~# cat /sys/bus/dax/devices/dax0.0/size 
> 67108864
> 
> But when I want to bind it then it does not work:
> root@localhost:~# echo "dax0.0" > /sys/bus/dax/drivers/device_dax/bind
> -bash: echo: write error: No such device
> 
> I believe I am missing something here. Would be good if you can help
> out here.
> 
> Thanks,
> Alireza

Hi Alireza,

My test with this series is always with Ira's ndtcl repos,
I have not tried to test by using sysfs directly.

To understand what it is going wrong, we need to see what is the
difference between the workflow of ndctl and that you use above.

After that, usually when I see an error as above, I will try to gdb the kernel.
Try to debug the step that fails and understand why.

For example, the last step fails, try to gdb "bind_store" function in 
drivers/base/bus.c.

Fan

> 

-- 
Fan Ni

