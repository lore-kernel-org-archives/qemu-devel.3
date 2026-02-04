Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CC3E8307C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vndBg-0005nc-4b; Wed, 04 Feb 2026 08:44:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vndBe-0005nT-Sj
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:44:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vndBb-0000SJ-3X
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770212689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ETZDSh4kNCc49/SGNN184u7m6P5dd9RnLP3PDuzaA2A=;
 b=AJcGxVw62E5NQ2K9MggaxNSvJywpVxUjy80eWNEyEcG7XSszONDOA2sgD5CjJmE/ObPzat
 I6BzPHO/U5k3G/wMO6N5ZqLd7Sbol/lEEGc03GiDHTMP+/PHROSPD24MT0DhxArRTFv6D/
 RYWgRKXpzq+4mXQL+OlS26oAgq84oFg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-WIYH-9U9NaS75vErljdSeg-1; Wed, 04 Feb 2026 08:44:48 -0500
X-MC-Unique: WIYH-9U9NaS75vErljdSeg-1
X-Mimecast-MFC-AGG-ID: WIYH-9U9NaS75vErljdSeg_1770212688
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-894709fbae5so29071936d6.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 05:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770212688; x=1770817488; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ETZDSh4kNCc49/SGNN184u7m6P5dd9RnLP3PDuzaA2A=;
 b=UAz/HiO9uSGafAzu8rTYQd+MdtPXjA0CLNoGdjYqmyrm3hTi/6is0s3eu/yEaGiFVA
 D1Xn0lApXMXZNNiVmDiPBC6MgeDUzTUO8XFs1xnGQ/K38AdUzbeVrc+z0Swq5u2Tqpzm
 nSszywv4j1JL3uELzz9nHgo6JWCgOY4H0blDXarOJOd0fioW4/zX3WzuMq0rV8DppcYl
 Qu6GJWKWcOa0cvJTIUL2QFg1Vzjl7ZMMKPvKiyvbfjWvsYIQAjjak+zZojxdf/2Iinv0
 cniILUZ5Lj/ZS69vH4B1Zqj2EpKlMwwdQ8W6n2R9r8YFygFBd+4b9Xt6zd+ZGgwmVWD0
 wOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770212688; x=1770817488;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ETZDSh4kNCc49/SGNN184u7m6P5dd9RnLP3PDuzaA2A=;
 b=sEn4C9WTsa0eNxjhEXH6Y/saX/7xEW4XAYiF1sGNiWy1g9gkdE/ZcceRbz4ASyNxPD
 wIEmu4pv2KSP8AIH/m7vfSPANv/ZWnFHIyRSDEsUsnsjswR4Uw/x6LpLwxoYMfkzR/ET
 rIliOwJRI+YFORuEmMzTfRU6hmuNHwnRcYesWcWfsvYeC4RJOiu/zAvYoJUpmg/Iqm2m
 4wKJ6Mw9lDaQVNA1l7p6xU4LmRwWnDUoBE2DkNJbupFI92k9zBVY5nXBdteQFZJv+0Wn
 jB6jE7pebSkn+ihyeRGKbIlPVyycPuoAlKoh9WQPbPncVPAvok6ndHwqHEtjSCvvoR1i
 eqnw==
X-Gm-Message-State: AOJu0YytbBMq9uCagY9H/b7OA+sNwCPrK+9BsRLpEp3BRvLcQ6raEzsE
 l9F27nlJEebE0c9xLe+CVgVRz3bbUjiBl3SPtFpE2/cCHeDOgMiaIH8qhnAPbAZ0Bq38Pw4jb+3
 bXGMPk61dr3cLb8OtLJNoBGunWOgmXIw5irPad88/hw0/BzLSEmZAoZaY
X-Gm-Gg: AZuq6aJwKXqHXjTc97x7R3V8cdDBp/FtEKePl9SZQwj/vnYafDRpDn0TB0Y/uqxNhDc
 WliZzus9Uu7uQJmetSGzppcHWSTKu8/0VaIEEOO9hjZ8MKTUO7H0LDk52fxboOmCA54OM3oH/Ye
 msrIQfnoHXOagJ7AuOJVkWgXoSxc9CAHB8wYu/h6SNhDJAcLj6ph5IXAVNkWo/G+m2Se+3h8Hi0
 oo+l2gQ9KCNJhQjFRbU/mzPu/L0ML4J9CYSo3Jrpl/1B6Ojy7dGWJufVm+k4xunNm4BPSrH4wMz
 u4EjiS82MQekVbIaVYdg1F8XQBQLNXHKc+nwDqxK/tDR9TovGDn4982CwGeaomEfAhx8V5OBJjT
 7Qu9wnw4Jmi+cfkdyMbpG5BchIHaKFNGPAQ==
X-Received: by 2002:a05:6214:5092:b0:890:58b4:3e7c with SMTP id
 6a1803df08f44-89522189379mr39034186d6.33.1770212687353; 
 Wed, 04 Feb 2026 05:44:47 -0800 (PST)
X-Received: by 2002:a05:6214:5092:b0:890:58b4:3e7c with SMTP id
 6a1803df08f44-89522189379mr39033556d6.33.1770212686557; 
 Wed, 04 Feb 2026 05:44:46 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89521d255bfsm18897386d6.46.2026.02.04.05.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 05:44:45 -0800 (PST)
Date: Wed, 4 Feb 2026 08:44:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Davidlohr Bueso <dave@stgolabs.net>,
 linuxarm@huawei.com, linux-cxl@vger.kernel.org,
 Ravi Shankar <venkataravis@micron.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH qemu v6 6/7] hw/cxl: Support type3 HDM-DB
Message-ID: <20260204084432-mutt-send-email-mst@kernel.org>
References: <20260204121215.68897-1-Jonathan.Cameron@huawei.com>
 <20260204121215.68897-7-Jonathan.Cameron@huawei.com>
 <20260204082422-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204082422-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Feb 04, 2026 at 08:24:55AM -0500, Michael S. Tsirkin wrote:
> On Wed, Feb 04, 2026 at 12:12:14PM +0000, Jonathan Cameron wrote:
> > From: Davidlohr Bueso <dave@stgolabs.net>
> > 
> > Add basic plumbing for memory expander devices that support Back
> > Invalidation. This introduces a 'hdm-db=on|off' parameter and
> > exposes the relevant BI RT/Decoder component cachemem registers.
> > 
> > Some noteworthy properties:
> >  - Devices require enabling Flit mode across the CXL topology.
> >  - Explicit BI-ID commit is required.
> >  - HDM decoder support both host and dev coherency models.
> > 
> > Tested-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> more troubles:
> https://gitlab.com/mstredhat/qemu/-/jobs/12984846000


clang just as unhappy:

https://gitlab.com/mstredhat/qemu/-/jobs/12984846060

> 
> > ---
> > v6: Initialize type variable to avoid a false compiler warning
> >     from some versions of gcc. (Michael Tsirkin)
> > ---
> >  docs/system/devices/cxl.rst         |  23 +++++
> >  include/hw/cxl/cxl_component.h      |  54 ++++++++++-
> >  include/hw/cxl/cxl_device.h         |   3 +
> >  hw/cxl/cxl-component-utils.c        | 142 ++++++++++++++++++++++++++--
> >  hw/mem/cxl_type3.c                  |   9 +-
> >  hw/pci-bridge/cxl_downstream.c      |   2 +-
> >  hw/pci-bridge/cxl_root_port.c       |   3 +-
> >  hw/pci-bridge/cxl_upstream.c        |   2 +-
> >  hw/pci-bridge/pci_expander_bridge.c |   2 +-
> >  9 files changed, 225 insertions(+), 15 deletions(-)
> > 
> > diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> > index ca15a0da1c1d..9d0771cdfd73 100644
> > --- a/docs/system/devices/cxl.rst
> > +++ b/docs/system/devices/cxl.rst
> > @@ -384,6 +384,29 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
> >    -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,sn=0x4 \
> >    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
> >  
> > +An example of 4 type3 devices with volatile memory below a switch. Two of the devices
> > +use HDM-DB for coherence, which requires operating in Flit mode::
> > +
> > +  qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
> > +  ...
> > +  -object memory-backend-ram,id=cxl-mem0,share=on,size=256M \
> > +  -object memory-backend-ram,id=cxl-mem1,share=on,size=256M \
> > +  -object memory-backend-ram,id=cxl-mem2,share=on,size=256M \
> > +  -object memory-backend-ram,id=cxl-mem3,share=on,size=256M \
> > +  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> > +  -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
> > +  -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
> > +  -device cxl-upstream,bus=root_port0,id=us0,x-256b-flit=on \
> > +  -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
> > +  -device cxl-type3,bus=swport0,volatile-memdev=cxl-mem0,id=cxl-mem0,sn=0x1,x-256b-flit=on,hdm-db=on \
> > +  -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
> > +  -device cxl-type3,bus=swport1,volatile-memdev=cxl-mem1,id=cxl-mem1,sn=0x2,x-256b-flit=on,hdm-db=on \
> > +  -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
> > +  -device cxl-type3,bus=swport2,volatile-memdev=cxl-mem2,id=cxl-mem2,sn=0x3 \
> > +  -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
> > +  -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-mem3,sn=0x4 \
> > +  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
> > +
> >  A simple arm/virt example featuring a single direct connected CXL Type 3
> >  Volatile Memory device::
> >  
> > diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> > index 1f167d3ef79b..ffc82202206c 100644
> > --- a/include/hw/cxl/cxl_component.h
> > +++ b/include/hw/cxl/cxl_component.h
> > @@ -67,6 +67,8 @@ CXLx_CAPABILITY_HEADER(LINK, 2)
> >  CXLx_CAPABILITY_HEADER(HDM, 3)
> >  CXLx_CAPABILITY_HEADER(EXTSEC, 4)
> >  CXLx_CAPABILITY_HEADER(SNOOP, 5)
> > +CXLx_CAPABILITY_HEADER(BI_RT, 6)
> > +CXLx_CAPABILITY_HEADER(BI_DECODER, 7)
> >  
> >  /*
> >   * Capability structures contain the actual registers that the CXL component
> > @@ -211,10 +213,55 @@ HDM_DECODER_INIT(3);
> >      (CXL_IDE_REGISTERS_OFFSET + CXL_IDE_REGISTERS_SIZE)
> >  #define CXL_SNOOP_REGISTERS_SIZE   0x8
> >  
> > -QEMU_BUILD_BUG_MSG((CXL_SNOOP_REGISTERS_OFFSET +
> > -                    CXL_SNOOP_REGISTERS_SIZE) >= 0x1000,
> > +#define CXL_BI_RT_CAP_VERSION 1
> > +#define CXL_BI_RT_REGISTERS_OFFSET \
> > +    (CXL_SNOOP_REGISTERS_OFFSET + CXL_SNOOP_REGISTERS_SIZE)
> > +#define CXL_BI_RT_REGISTERS_SIZE   0xC
> > +
> > +REG32(CXL_BI_RT_CAPABILITY, CXL_BI_RT_REGISTERS_OFFSET)
> > +    FIELD(CXL_BI_RT_CAPABILITY, EXPLICIT_COMMIT, 0, 1)
> > +REG32(CXL_BI_RT_CTRL, CXL_BI_RT_REGISTERS_OFFSET + 0x4)
> > +    FIELD(CXL_BI_RT_CTRL, COMMIT, 0, 1)
> > +REG32(CXL_BI_RT_STATUS, CXL_BI_RT_REGISTERS_OFFSET + 0x8)
> > +    FIELD(CXL_BI_RT_STATUS, COMMITTED, 0, 1)
> > +    FIELD(CXL_BI_RT_STATUS, ERR_NOT_COMMITTED, 1, 1)
> > +    FIELD(CXL_BI_RT_STATUS, COMMIT_TMO_SCALE, 8, 4)
> > +    FIELD(CXL_BI_RT_STATUS, COMMIT_TMO_BASE, 12, 4)
> > +
> > +/* CXL r3.2 8.2.4.27 - CXL BI Decoder Capability Structure */
> > +#define CXL_BI_DECODER_CAP_VERSION 1
> > +#define CXL_BI_DECODER_REGISTERS_OFFSET \
> > +    (CXL_BI_RT_REGISTERS_OFFSET + CXL_BI_RT_REGISTERS_SIZE)
> > +#define CXL_BI_DECODER_REGISTERS_SIZE   0xC
> > +
> > +REG32(CXL_BI_DECODER_CAPABILITY, CXL_BI_DECODER_REGISTERS_OFFSET)
> > +    FIELD(CXL_BI_DECODER_CAPABILITY, HDM_D, 0, 1)
> > +    FIELD(CXL_BI_DECODER_CAPABILITY, EXPLICIT_COMMIT, 1, 1)
> > +REG32(CXL_BI_DECODER_CTRL, CXL_BI_DECODER_REGISTERS_OFFSET + 0x4)
> > +    FIELD(CXL_BI_DECODER_CTRL, BI_FW, 0, 1)
> > +    FIELD(CXL_BI_DECODER_CTRL, BI_ENABLE, 1, 1)
> > +    FIELD(CXL_BI_DECODER_CTRL, COMMIT, 2, 1)
> > +REG32(CXL_BI_DECODER_STATUS, CXL_BI_DECODER_REGISTERS_OFFSET + 0x8)
> > +    FIELD(CXL_BI_DECODER_STATUS, COMMITTED, 0, 1)
> > +    FIELD(CXL_BI_DECODER_STATUS, ERR_NOT_COMMITTED, 1, 1)
> > +    FIELD(CXL_BI_DECODER_STATUS, COMMIT_TMO_SCALE, 8, 4)
> > +    FIELD(CXL_BI_DECODER_STATUS, COMMIT_TMO_BASE, 12, 4)
> > +
> > +QEMU_BUILD_BUG_MSG((CXL_BI_DECODER_REGISTERS_OFFSET +
> > +                    CXL_BI_DECODER_REGISTERS_SIZE) >= 0x1000,
> >                     "No space for registers");
> >  
> > +/* track BI explicit commit handling for route table and decoder */
> > +enum {
> > +    CXL_BISTATE_RT = 0,
> > +    CXL_BISTATE_DECODER,
> > +    CXL_BISTATE_MAX
> > +};
> > +
> > +typedef struct bi_state {
> > +    uint64_t last_commit;  /* last 0->1 transition */
> > +} BIState;
> > +
> >  typedef struct component_registers {
> >      /*
> >       * Main memory region to be registered with QEMU core.
> > @@ -259,6 +306,7 @@ typedef struct cxl_component {
> >      };
> >  
> >      CDATObject cdat;
> > +    BIState bi_state[CXL_BISTATE_MAX];
> >  } CXLComponentState;
> >  
> >  void cxl_component_register_block_init(Object *obj,
> > @@ -266,7 +314,7 @@ void cxl_component_register_block_init(Object *obj,
> >                                         const char *type);
> >  void cxl_component_register_init_common(uint32_t *reg_state,
> >                                          uint32_t *write_msk,
> > -                                        enum reg_type type);
> > +                                        enum reg_type type, bool bi);
> >  
> >  void cxl_component_create_dvsec(CXLComponentState *cxl_cstate,
> >                                  enum reg_type cxl_dev_type, uint16_t length,
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 7d9236db8c85..393f3122173b 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -770,6 +770,9 @@ struct CXLType3Dev {
> >      CXLMemSparingReadAttrs rank_sparing_attrs;
> >      CXLMemSparingWriteAttrs rank_sparing_wr_attrs;
> >  
> > +    /* BI flows */
> > +    bool hdmdb;
> > +
> >      struct dynamic_capacity {
> >          HostMemoryBackend *host_dc;
> >          AddressSpace host_dc_as;
> > diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> > index 91770f103a85..a7d36e1128c2 100644
> > --- a/hw/cxl/cxl-component-utils.c
> > +++ b/hw/cxl/cxl-component-utils.c
> > @@ -71,10 +71,40 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
> >      case 4:
> >          if (cregs->special_ops && cregs->special_ops->read) {
> >              return cregs->special_ops->read(cxl_cstate, offset, 4);
> > -        } else {
> > -            QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
> > -            return cregs->cache_mem_registers[offset / 4];
> >          }
> > +
> > +        QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
> > +
> > +        if (offset == A_CXL_BI_RT_STATUS ||
> > +            offset == A_CXL_BI_DECODER_STATUS) {
> > +            int type;
> > +            uint64_t started;
> > +
> > +            type = (offset == A_CXL_BI_RT_STATUS) ?
> > +                    CXL_BISTATE_RT : CXL_BISTATE_DECODER;
> > +            started = cxl_cstate->bi_state[type].last_commit;
> > +
> > +            if (started) {
> > +                uint32_t *cache_mem = cregs->cache_mem_registers;
> > +                uint32_t val = cache_mem[offset / 4];
> > +                uint64_t now;
> > +                int set;
> > +
> > +                now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> > +                /* arbitrary 100 ms to do the commit */
> > +                set = !!(now >= started + 100);
> > +
> > +                if (offset == A_CXL_BI_RT_STATUS) {
> > +                    val = FIELD_DP32(val, CXL_BI_RT_STATUS, COMMITTED, set);
> > +                } else {
> > +                    val = FIELD_DP32(val, CXL_BI_DECODER_STATUS, COMMITTED,
> > +                                     set);
> > +                }
> > +                stl_le_p((uint8_t *)cache_mem + offset, val);
> > +            }
> > +        }
> > +
> > +        return cregs->cache_mem_registers[offset / 4];
> >      case 8:
> >          qemu_log_mask(LOG_UNIMP,
> >                        "CXL 8 byte cache mem registers not implemented\n");
> > @@ -118,6 +148,47 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cstate, hwaddr offset,
> >      stl_le_p((uint8_t *)cache_mem + offset, value);
> >  }
> >  
> > +static void bi_handler(CXLComponentState *cxl_cstate, hwaddr offset,
> > +                            uint32_t value)
> > +{
> > +    ComponentRegisters *cregs = &cxl_cstate->crb;
> > +    uint32_t sts, *cache_mem = cregs->cache_mem_registers;
> > +    bool to_commit = false;
> > +    int type = 0; /* Unused value - work around for compiler warning */
> > +
> > +    switch (offset) {
> > +    case A_CXL_BI_RT_CTRL:
> > +        to_commit = FIELD_EX32(value, CXL_BI_RT_CTRL, COMMIT);
> > +        if (to_commit) {
> > +            sts = cxl_cache_mem_read_reg(cxl_cstate,
> > +                                         R_CXL_BI_RT_STATUS, 4);
> > +            sts = FIELD_DP32(sts, CXL_BI_RT_STATUS, COMMITTED, 0);
> > +            stl_le_p((uint8_t *)cache_mem + R_CXL_BI_RT_STATUS, sts);
> > +            type = CXL_BISTATE_RT;
> > +        }
> > +        break;
> > +    case A_CXL_BI_DECODER_CTRL:
> > +        to_commit = FIELD_EX32(value, CXL_BI_DECODER_CTRL, COMMIT);
> > +        if (to_commit) {
> > +            sts = cxl_cache_mem_read_reg(cxl_cstate,
> > +                                         R_CXL_BI_DECODER_STATUS, 4);
> > +            sts = FIELD_DP32(sts, CXL_BI_DECODER_STATUS, COMMITTED, 0);
> > +            stl_le_p((uint8_t *)cache_mem + R_CXL_BI_DECODER_STATUS, sts);
> > +            type = CXL_BISTATE_DECODER;
> > +        }
> > +        break;
> > +    default:
> > +        break;
> > +    }
> > +
> > +    if (to_commit) {
> > +        cxl_cstate->bi_state[type].last_commit =
> > +                qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> > +    }
> > +
> > +    stl_le_p((uint8_t *)cache_mem + offset, value);
> > +}
> > +
> >  static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
> >                                      unsigned size)
> >  {
> > @@ -141,6 +212,9 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
> >          if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
> >              offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
> >              dumb_hdm_handler(cxl_cstate, offset, value);
> > +        } else if (offset == A_CXL_BI_RT_CTRL ||
> > +                   offset == A_CXL_BI_DECODER_CTRL) {
> > +            bi_handler(cxl_cstate, offset, value);
> >          } else {
> >              cregs->cache_mem_registers[offset / 4] = value;
> >          }
> > @@ -230,7 +304,7 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
> >  }
> >  
> >  static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
> > -                            enum reg_type type)
> > +                            enum reg_type type, bool bi)
> >  {
> >      int decoder_count = CXL_HDM_DECODER_COUNT;
> >      int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
> > @@ -255,7 +329,9 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
> >                       UIO_DECODER_COUNT, 0);
> >      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, MEMDATA_NXM_CAP, 0);
> >      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > -                     SUPPORTED_COHERENCY_MODEL, 0); /* Unknown */
> > +                     SUPPORTED_COHERENCY_MODEL,
> > +                     /* host+dev or Unknown */
> > +                     type == CXL2_TYPE3_DEVICE && bi ? 3 : 0);
> >      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_GLOBAL_CONTROL,
> >                       HDM_DECODER_ENABLE, 0);
> >      write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0x3;
> > @@ -278,9 +354,43 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
> >      }
> >  }
> >  
> > +static void bi_rt_init_common(uint32_t *reg_state, uint32_t *write_msk)
> > +{
> > +    /* switch usp must commit the new BI-ID, timeout of 2secs */
> > +    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_CAPABILITY, EXPLICIT_COMMIT, 1);
> > +
> > +    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_CTRL, COMMIT, 0);
> > +    write_msk[R_CXL_BI_RT_CTRL] = 0x1;
> > +
> > +    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_STATUS, COMMITTED, 0);
> > +    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_STATUS, ERR_NOT_COMMITTED, 0);
> > +    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_STATUS, COMMIT_TMO_SCALE, 0x6);
> > +    ARRAY_FIELD_DP32(reg_state, CXL_BI_RT_STATUS, COMMIT_TMO_BASE, 0x2);
> > +}
> > +
> > +static void bi_decoder_init_common(uint32_t *reg_state, uint32_t *write_msk,
> > +                                   enum reg_type type)
> > +{
> > +    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_CAPABILITY, HDM_D, 0);
> > +    /* switch dsp must commit the new BI-ID, timeout of 2secs */
> > +    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_CAPABILITY, EXPLICIT_COMMIT,
> > +                     (type != CXL2_ROOT_PORT && type != CXL2_TYPE3_DEVICE));
> > +
> > +    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_CTRL, BI_FW, 0);
> > +    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_CTRL, BI_ENABLE, 0);
> > +    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_CTRL, COMMIT, 0);
> > +    write_msk[R_CXL_BI_DECODER_CTRL] = 0x7;
> > +
> > +    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_STATUS, COMMITTED, 0);
> > +    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_STATUS, ERR_NOT_COMMITTED, 0);
> > +    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_STATUS, COMMIT_TMO_SCALE, 0x6);
> > +    ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_STATUS, COMMIT_TMO_BASE, 0x2);
> > +}
> > +
> >  void cxl_component_register_init_common(uint32_t *reg_state,
> >                                          uint32_t *write_msk,
> > -                                        enum reg_type type)
> > +                                        enum reg_type type,
> > +                                        bool bi)
> >  {
> >      int caps = 0;
> >  
> > @@ -320,7 +430,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
> >      case CXL2_LOGICAL_DEVICE:
> >          /* + HDM */
> >          init_cap_reg(HDM, 5, 1);
> > -        hdm_init_common(reg_state, write_msk, type);
> > +        hdm_init_common(reg_state, write_msk, type, bi);
> >          /* fallthrough */
> >      case CXL2_DOWNSTREAM_PORT:
> >      case CXL2_DEVICE:
> > @@ -335,6 +445,24 @@ void cxl_component_register_init_common(uint32_t *reg_state,
> >          abort();
> >      }
> >  
> > +    /* back invalidate */
> > +    if (bi) {
> > +        switch (type) {
> > +        case CXL2_UPSTREAM_PORT:
> > +            init_cap_reg(BI_RT, 11, CXL_BI_RT_CAP_VERSION);
> > +            bi_rt_init_common(reg_state, write_msk);
> > +            break;
> > +        case CXL2_ROOT_PORT:
> > +        case CXL2_DOWNSTREAM_PORT:
> > +        case CXL2_TYPE3_DEVICE:
> > +            init_cap_reg(BI_DECODER, 12, CXL_BI_DECODER_CAP_VERSION);
> > +            bi_decoder_init_common(reg_state, write_msk, type);
> > +            break;
> > +        default:
> > +            break;
> > +        }
> > +    }
> > +
> >      ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ARRAY_SIZE, caps);
> >  #undef init_cap_reg
> >  }
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 3c7ecd8c48bc..3f09c589ae58 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -748,6 +748,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> >          return false;
> >      }
> >  
> > +    if (!ct3d->flitmode && ct3d->hdmdb) {
> > +        error_setg(errp, "hdm-db requires operating in 256b flit");
> > +        return false;
> > +    }
> > +
> >      if (ct3d->hostvmem) {
> >          MemoryRegion *vmr;
> >          char *v_name;
> > @@ -1317,7 +1322,8 @@ static void ct3d_reset(DeviceState *dev)
> >  
> >      pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed,
> >                                ct3d->flitmode);
> > -    cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
> > +    cxl_component_register_init_common(reg_state, write_msk,
> > +                                       CXL2_TYPE3_DEVICE, ct3d->hdmdb);
> >      cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
> >  
> >      /*
> > @@ -1356,6 +1362,7 @@ static const Property ct3_props[] = {
> >      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLType3Dev,
> >                                  width, PCIE_LINK_WIDTH_16),
> >      DEFINE_PROP_BOOL("x-256b-flit", CXLType3Dev, flitmode, false),
> > +    DEFINE_PROP_BOOL("hdm-db", CXLType3Dev, hdmdb, false),
> >  };
> >  
> >  static uint64_t get_lsa_size(CXLType3Dev *ct3d)
> > diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
> > index 64086d8ec2f2..320818a8f1ce 100644
> > --- a/hw/pci-bridge/cxl_downstream.c
> > +++ b/hw/pci-bridge/cxl_downstream.c
> > @@ -39,7 +39,7 @@ static void latch_registers(CXLDownstreamPort *dsp)
> >      uint32_t *write_msk = dsp->cxl_cstate.crb.cache_mem_regs_write_mask;
> >  
> >      cxl_component_register_init_common(reg_state, write_msk,
> > -                                       CXL2_DOWNSTREAM_PORT);
> > +                                       CXL2_DOWNSTREAM_PORT, true);
> >  }
> >  
> >  /* TODO: Look at sharing this code across all CXL port types */
> > diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
> > index 5641048084a4..e2093ac39ee6 100644
> > --- a/hw/pci-bridge/cxl_root_port.c
> > +++ b/hw/pci-bridge/cxl_root_port.c
> > @@ -101,7 +101,8 @@ static void latch_registers(CXLRootPort *crp)
> >      uint32_t *reg_state = crp->cxl_cstate.crb.cache_mem_registers;
> >      uint32_t *write_msk = crp->cxl_cstate.crb.cache_mem_regs_write_mask;
> >  
> > -    cxl_component_register_init_common(reg_state, write_msk, CXL2_ROOT_PORT);
> > +    cxl_component_register_init_common(reg_state, write_msk, CXL2_ROOT_PORT,
> > +                                       true);
> >  }
> >  
> >  static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
> > diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> > index c352d11dc7b7..fb8d19539c9f 100644
> > --- a/hw/pci-bridge/cxl_upstream.c
> > +++ b/hw/pci-bridge/cxl_upstream.c
> > @@ -90,7 +90,7 @@ static void latch_registers(CXLUpstreamPort *usp)
> >      uint32_t *write_msk = usp->cxl_cstate.crb.cache_mem_regs_write_mask;
> >  
> >      cxl_component_register_init_common(reg_state, write_msk,
> > -                                       CXL2_UPSTREAM_PORT);
> > +                                       CXL2_UPSTREAM_PORT, usp->flitmode);
> >      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT, 8);
> >  }
> >  
> > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> > index b6e2eb796951..11623a5666f6 100644
> > --- a/hw/pci-bridge/pci_expander_bridge.c
> > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > @@ -300,7 +300,7 @@ static void pxb_cxl_dev_reset(DeviceState *dev)
> >      uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
> >      int dsp_count = 0;
> >  
> > -    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC);
> > +    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC, false);
> >      /*
> >       * The CXL specification allows for host bridges with no HDM decoders
> >       * if they only have a single root port.
> > -- 
> > 2.51.0


