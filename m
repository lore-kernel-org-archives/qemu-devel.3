Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43244C55AB9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 12:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtQ63-0007uz-Li; Fri, 20 Feb 2026 07:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtQ61-0007uq-Nd
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 07:59:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtQ5y-0007Wd-T9
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 07:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771592336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vkSNI3uLN6KRJsGjKA6J4qpWg+yqDGZlKCoW+0IJCbs=;
 b=gJbnoraO+oOwkxer4CrDcs2qHR+qwyAq9jvYYsox8GAYjY/eucSLaeqaXXmTS5Ny3h5TWv
 LXxBk9E9vLpwzG/+3kpy6opi1UBkOQSu+ok+sexXe1Rv2bI5Pmab27ieeH6Pvz38IxHb/6
 zmkH3xkvy73KA68wHCr18+0kKpV/EYw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-ZONSmFKWNhGDoGz1jYn_rA-1; Fri, 20 Feb 2026 07:58:54 -0500
X-MC-Unique: ZONSmFKWNhGDoGz1jYn_rA-1
X-Mimecast-MFC-AGG-ID: ZONSmFKWNhGDoGz1jYn_rA_1771592333
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836cc0b38eso21858015e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 04:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771592333; x=1772197133; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vkSNI3uLN6KRJsGjKA6J4qpWg+yqDGZlKCoW+0IJCbs=;
 b=nCqTUry2tM0Gl1rJN3oleuanMtQJ6liqbXLFbn/lb1T6oBv+DpnvIk0fzduXcX9jBj
 MtQ5PQM5FQ8KxKdIDqKx5wK1j16FZAQbnYVD6LOwKM4WPbOFR1rmGBlNcbeET2MQTw8N
 riXLi7xcK36iIGFe9yKPTt8U+uWfFF/q8yeB5PGL4sxq39FKWjWCSTceMWb+ULHRTvdn
 MWMM2yP5pTlaDRO95jdOzL5BFUnKVlaCJXR5vYMRTgMAdCtPByKaYfGieZhly3DkMzw4
 NFso1WCkefdg36vYw1BOEuIXXWF3jcS1iF2ZH/jzV3ChpeqaYzcw8XJEorq2x67FNudr
 HtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771592333; x=1772197133;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vkSNI3uLN6KRJsGjKA6J4qpWg+yqDGZlKCoW+0IJCbs=;
 b=GRjJuNccmWJbdh5IP/W0SXzANzRyrJ1SQS5TKbE1jeZ7Q9Mj+qvSIU65ITPBmig/LI
 35HMTQ+TUCn+Ag6pEsbKrwrAAfe4acbQexCTvDu/3YekMvBeJWvQDuXneY3KvOhciXOh
 HBqsiI56lXSQyP53hyg2kPVLfIbOy5StoRgr3AZDVQfIeWyonUCCE7BMG704DqhIGeso
 kh5tZgtLRhe62LMoCIhUXhh+JyDOEQrHvc7mXUpCaZWtyeTxscanOA/3Z0SZDMsnL8WA
 vi5zBom9EfMc0YmYxj5fDBdONsE78BTkkuPj1JQPOJEWr6k0jctg8i7C+LzK0e5J9tPu
 risg==
X-Gm-Message-State: AOJu0Yyv7QX6O1qgRwQmPgXPjjpR8EewydJWYW32AemrdtoUXOSa+hnL
 vUfLuWTkbqI1Z6o1U2F3any/FPzxHYJlld0wq6A0vaHxd9T3tHhlp2Ma9kcWgJcgFPwAoIyAxmy
 2Mc0neVKB6nihFuO/4VTp/U0eArcH1Sw7n66Z12bEmjvawxjszIb6Mo9A
X-Gm-Gg: AZuq6aJZea41Z6MLOJyHL5+sB5mYNMprHzmhGGBBdgKWPloVg2Qp3dzZTnZL1zKagYO
 vnt2v+ElSELpHNFernTqX3OO/SjEHZvYN2unS0tIQA9RV2q8w9l59ASTOgic1GTwdhvoB1zU7lO
 G20lQVZabivMw6NUdvryyqGC6ehq7bdA9pawl2S+UPQwgdaBJvC81yPxTxVbQiJcBaBxEoKLYsG
 yjl50mp+L/YfR0DE6fpuvThK6TBX93SyuwdDrxI3jQwbs2YI9CN/gmtl8fwoD18qe1tO5sKJACL
 RiAT5PR/HfNVNLpIvHWyPtcNXXosHsLuoLpracboHnIENaZGc+m4aiClkeiUXAEOOFc9Hpb4B3n
 LmjomgikSjG/1/UjCS3X33yAghAsEPnRXbSuhRoD7Bo+gdQ==
X-Received: by 2002:a05:600c:608a:b0:480:1e9e:f9b with SMTP id
 5b1f17b1804b1-48398a58488mr187082635e9.16.1771592333251; 
 Fri, 20 Feb 2026 04:58:53 -0800 (PST)
X-Received: by 2002:a05:600c:608a:b0:480:1e9e:f9b with SMTP id
 5b1f17b1804b1-48398a58488mr187082105e9.16.1771592332720; 
 Fri, 20 Feb 2026 04:58:52 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac7d91sm58035586f8f.26.2026.02.20.04.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 04:58:52 -0800 (PST)
Date: Fri, 20 Feb 2026 07:58:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Arpit Kumar <arpit1.kumar@samsung.com>,
 linuxarm@huawei.com, linux-cxl@vger.kernel.org,
 Ravi Shankar <venkataravis@micron.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH qemu v5 0/3] hw/cxl: FM-API Physical Switch Command Set
 Support.
Message-ID: <20260220075818-mutt-send-email-mst@kernel.org>
References: <20260204173223.44122-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204173223.44122-1-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 04, 2026 at 05:32:20PM +0000, Jonathan Cameron wrote:
> Changes since v4:
> https://lore.kernel.org/qemu-devel/20250916080736.1266083-1-arpit1.kumar@samsung.com/
> - Dropped initial refactor. Reason being that it is not static enough
>   for caching at boot to be appropriate.  Kept the spec update part
>   of this.
> - Added a patch to make sure the new flip mode stuff is reported in
>   the Get Physical Port State command.
> - Rebased Arpit's Physical Control Control FMAPI Command given drop
>   of the major refactor from v4 patch 1.
> 
> I had taken this into my cxl staging tree thinking it only needed a few
> minor tweaks.  Then whilst testing I realized it didn't work with hotplug
> and that made me consider if Arpit's original approach made sense.
> 
> So this is my proposal on how to take this forwards. Note that this is
> not ready for merge (probably) just yet as I'd like Arpit to take a
> look at the changes.

I'd appreciate it if you add rfc in the subject in such cases.
Thanks!

>  I went through a version that had major refactors
> to push the logic of building the records to the ports themselves, but
> in the end don't think that brings enough benefits for the complexity.
> 
> Based on:
> https://lore.kernel.org/qemu-devel/20260204170936.43959-1-Jonathan.Cameron@huawei.com/T/#t
> (with all it's precursors, though hopefully they will all be in Michael's
> next pull request)
> 
> I'll note this is an enormous foot gun as it lets you effectively trigger
> surprise device resets.  However, it's only accessible if you are using
> a configuration with the fabric management parts of the CXL emulation.
> For now that is a switch-cci (MCTP over USB support is near the top
> of my list of things to get ready for upstram.  I tested this with a
> custom driver and if nothing else it exposed some gaps in Linux's
> ability to rescan PCI buses after a perst event (even with drivers
> unbound etc to make it safe).
> 
> Original cover letter:
> 
> This patch series refactor existing support for Identify Switch Device
> and Get Physical Port State by utilizing physical ports (USP & DSP)
> information stored during enumeration.
> 
> Additionally, it introduces new support for Physical Port Control
> of Physical Switch Command Set as per CXL spec r3.2 Section 7.6.7.1.3.
> It primarily constitutes two logic:
>     -Assert-Deassert PERST: Assert PERST involves physical port to be in
>      hold reset phase for minimum 100ms. No other physical port control
>      request are entertained until Deassert PERST command for the given
>      port is issued.
>     -Reset PPB: cold reset of physical port (completing enter->hold->exit
>      phases).
> 
> Tested using libcxl-mi interface[1]:
> All active ports and all opcodes per active port is tested. Also, tested
> against possible edge cases manually since the interface currently dosen't
> support run time input.
> 
> Typical Qemu topology
> (1 USP + 3 DSP's in a switch with 2 CXLType3 devices connected to the 2 DSP's):
> FM="-object memory-backend-file,id=cxl-mem1,mem-path=$TMP_DIR/t3_cxl1.raw,size=256M \
>     -object memory-backend-file,id=cxl-lsa1,mem-path=$TMP_DIR/t3_lsa1.raw,size=1M \
>     -object memory-backend-file,id=cxl-mem2,mem-path=$TMP_DIR/t3_cxl2.raw,size=512M \
>     -object memory-backend-file,id=cxl-lsa2,mem-path=$TMP_DIR/t3_lsa2.raw,size=512M \
>     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
>     -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
>     -device cxl-upstream,port=2,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
>     -device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
>     -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
>     -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
>     -device cxl-downstream,port=3,bus=us0,id=swport2,chassis=0,slot=6 \
>     -device cxl-type3,bus=swport0,memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3 \
>     -device cxl-type3,bus=swport2,memdev=cxl-mem2,id=cxl-pmem2,lsa=cxl-lsa2,sn=4 \
>     -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
>     -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
>     -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=5,target=cxl-pmem1 \
>     -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=cxl-pmem2 \
>     -device virtio-rng-pci,bus=swport1"
> 
> Tested multiple Qemu topologies:
>         -without any devices connected to downstream ports.
>         -with virtio-rng-pci devices connected to downstream ports.
>         -with CXLType3 devices connected to downstream ports.
>         -with different unique values of ports (both upstream and downstream).
> 
> Changes from v3 (https://lore.kernel.org/qemu-devel/20250909160316.00000190@huawei.com/T/):
>         -Namespaced the defines with cleaner prefix for Get Physical Port State 
>          Port Information Block members.
>         -switch CCI implementation instead of switch FM interface as per
>          Jonathan's review comments, hence moved perst members initializations
>          from: cxl_initialize_usp_mctpcci() -> cxl_initialize_mailbox_swcci().
> 
> [1] https://github.com/computexpresslink/libcxlmi/commit/35fe68bd9a31469f832a87694d7b18d2d50be5b8
> 
> 
> Arpit Kumar (2):
>   hw/cxl: Physical Port Info FMAPI - update to current spec and add
>     defines.
>   hw/cxl: Add Physical Port Control FMAPI Command (Opcode 5102h)
> 
> Jonathan Cameron (1):
>   hw/cxl: Get Physical Port State - update for PCIe flit mode
> 
>  include/hw/cxl/cxl_port.h                   |  73 ++++++++
>  include/hw/pci-bridge/cxl_downstream_port.h |  12 ++
>  include/hw/pci-bridge/cxl_upstream_port.h   |   2 +
>  hw/cxl/cxl-mailbox-utils.c                  | 183 ++++++++++++++++++--
>  hw/pci-bridge/cxl_downstream.c              |   9 +
>  hw/pci-bridge/cxl_upstream.c                |   1 +
>  6 files changed, 268 insertions(+), 12 deletions(-)
>  create mode 100644 include/hw/cxl/cxl_port.h
>  create mode 100644 include/hw/pci-bridge/cxl_downstream_port.h
> 
> -- 
> 2.51.0


