Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A94CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 21:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wblsL-0000sH-M0; Mon, 22 Jun 2026 17:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wblsJ-0000rC-Rv
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:08:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wblsF-0002l2-Vf
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782162486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZylaYIaJyH64ZUN0GPn4U0LhKcnXEBaFTWhwpPLc03o=;
 b=EYq33x9MQVC66Kdhow8/sJC5XHLeNzuGDmK2ZkIY7PfMQnpqhQvF2VCBSVjsGBMebku7tJ
 8kTmH+jCmUMI/yAybhT8MIHv7J5ybGWhMshXhyQnL78LWiu/YkhyZEv2ZSu4JRh+EOdxi5
 SzxWTSkJ6DoKVYuUpVnlIk96lnCF6kA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-yrMA6yBhP-m5w-T6Rv-3xQ-1; Mon, 22 Jun 2026 17:08:04 -0400
X-MC-Unique: yrMA6yBhP-m5w-T6Rv-3xQ-1
X-Mimecast-MFC-AGG-ID: yrMA6yBhP-m5w-T6Rv-3xQ_1782162484
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9205e6b0bcaso601316185a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 14:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782162484; x=1782767284; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZylaYIaJyH64ZUN0GPn4U0LhKcnXEBaFTWhwpPLc03o=;
 b=b1DF54EDa/JTjPVBAF8C4mCePhotV5ASkg4Whgq81yUEVH+TbboJh4P4Yv3NJAl19Q
 +5b3kUq5MUCY5iXd7uHc8/BXj6SfiZEOTblyGDlu+3r9oDIukyICuCNZBtmSsPqNsyO0
 WVnGB+qzyajA/vw/bXLvTInVIn50uFbJzHhKYlRSY3ZDkOyvMefRXimFYIPbgUoZ8MRT
 aINxp/8fkSOlqKkmkbWDOGF3BPUCAgoGpTRQxDu/2k2laAc0DVROKK/2+iIE8k8EDN5S
 1tacRoYFkz/kNWHb2vy7vwfC6+h6TiOaefyLdfBIZGMbtyNdDVv/esvRphZhlb+Y0d7R
 WIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782162484; x=1782767284;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZylaYIaJyH64ZUN0GPn4U0LhKcnXEBaFTWhwpPLc03o=;
 b=MMZoUceM+jiQG9FXqMIEsyyAuDCDT6Eu0wlvtra35SQ/CqVEpyIHcnJGK+U34SYfv0
 CjzsJ4Ly9ue6XQNOvIXQYsfg63kSxvqgAzMz6bCoz7pmp/Ji5UKC1VIX0OU/Lu+/zunP
 H0YMDBoRAYFRm2j/kR0NE6e3esZeaKvBeLTqVQz0ZVXbnCIHq0CKnQS2nLg/Hy2dmLFL
 1JE54uyLYEdjSh7MlXR0v5LiowaZF9X+8FH+gZ/tPQLT0fa0X9adXtfo7vUsFlocPb7M
 UDdTxy8k5JTJusrCKqpNb+O4o8u/4486ujFqwb2yZPgwwQkVEFUa7EG/NUAdJBFA0i5x
 ro0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1AlHRA+KWHmbdA/jJpSqY611mTbMOD4LhlqtOmW6GiXrDjfqoycIFgNhyB98akZEpBYHqMKLXQ9ax@nongnu.org
X-Gm-Message-State: AOJu0YyPZLM+dyouNg+K/9Zp4sJwIuJQQUEVo9cckCfZgqqn6SWUjRkC
 5ZgON7Kik/PlM+8RBcXg4fpsnE4X4hbl8pRFZvxOFyCqN1pO5/sJZzhPWmNAIfZRoFd0788BjPQ
 H52CBMyu1lKQFZwvElb0tVc9Ew5y5JcV1sO5jkbPRRoxA/0t6FIhmDler
X-Gm-Gg: AfdE7clkjMl5xe4/HcC71bT0nswb5OwWveXiS8sfCnlmQhI7Fli4/NPgzhN/qxkkwVb
 MjyPeks4EiRq4gWfU6qY9Hf/MtfxFk4L8wsbj8xIvznPBM06OcwVIxwRFOHZbW9DxFZ0TOhTqu1
 g2POaiVfEi6DmZX0dYTWMEUPirtnsTOp/K1u7Mqy/d3jFBmLdR2KG+NDJZCm/gTElDLzvmZnEFY
 zEfuxta+K+r0MQRMqUHYmk/LOduS72L6b9PDw/aqqSHpsa8riIGL67PtrKNOHAMLGVWRbj9r38d
 /GKyAf8a4iQ1Gu0Nb2Kko/Ahy+ABKcq25qVwD2TmOmdtGOFjpaJJcVmbnXprk8WYYEi9gHJQ12M
 ByHyv14GTDW2paf4GBAy898jLPevRJxODl5Wz00syneE/cEOjks/doga6IiMriAIq9u8gE5Lq
X-Received: by 2002:a05:620a:6492:b0:913:dcd2:f132 with SMTP id
 af79cd13be357-92090db22b3mr2623430485a.40.1782162483853; 
 Mon, 22 Jun 2026 14:08:03 -0700 (PDT)
X-Received: by 2002:a05:620a:6492:b0:913:dcd2:f132 with SMTP id
 af79cd13be357-92090db22b3mr2623419985a.40.1782162483170; 
 Mon, 22 Jun 2026 14:08:03 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-157.dsl.bell.ca. [174.91.117.157])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-925fd39188csm82036985a.6.2026.06.22.14.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 14:08:01 -0700 (PDT)
Date: Mon, 22 Jun 2026 17:07:58 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-rust@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH v5 00/12] Make RamDiscardManager work with multiple
 sources & virtio-mem
Message-ID: <ajmkLgAqc_bz-m3A@x1.local>
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
 <CAJ+F1CKRvSWDOvKC98e_7uyjgJMuXfhOHP83H0s7a=+ZrYxA1g@mail.gmail.com>
 <ajVco512NDPKDPTr@x1.local>
 <CAMxuvazRnZw4PEsdKCEBD8X1ua5LMj5K-k+-oh-J_uvXm5vT1w@mail.gmail.com>
 <ajmMzMAXay65Sl7U@x1.local>
 <CAMxuvawvb-oueGsgXQsPzAtB8_ArAM+SOtpacrvOGq=4d1F2Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvawvb-oueGsgXQsPzAtB8_ArAM+SOtpacrvOGq=4d1F2Bg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 23, 2026 at 12:00:04AM +0400, Marc-André Lureau wrote:
> Hi Peter
> 
> On Mon, Jun 22, 2026 at 11:28 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Mon, Jun 22, 2026 at 03:53:33PM +0400, Marc-André Lureau wrote:
> > > Hi Peter
> > >
> > > On Fri, Jun 19, 2026 at 7:13 PM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Fri, Jun 19, 2026 at 12:11:48AM +0400, Marc-André Lureau wrote:
> > > > > Hi
> > > > >
> > > > > On Thu, Jun 4, 2026 at 5:46 PM Marc-André Lureau
> > > > > <marcandre.lureau@redhat.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > This is an attempt to fix the incompatibility of virtio-mem with confidential
> > > > > > VMs. The solution implements what was discussed earlier with D. Hildenbrand:
> > > > > > https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074939.18657-5-chenyi.qiang@intel.com/#3502238
> > > > > >
> > > > > > The first patches are misc cleanups. Then some code refactoring to have split a
> > > > > > manager/source. And finally, the manager learns to deal with multiple sources.
> > > > > >
> > > > > > This has been tested together with the Linux kernel series from
> > > > > > Zhenzhong Duan [1] for TDX guests.
> > > > > >
> > > > > > (help fix https://issues.redhat.com/browse/RHEL-131968)
> > > > >
> > > > > Can the patch 1-11 be queued or are we missing something?
> > > > > (RFC patch 12 can be dropped for now)
> > > >
> > > > Likely yes.. one thing to double check with you before I do: We don't need
> > > > the kernel series, do we?  Since when unplug, I expect with the truncation
> > > > approach that this series proposed, KVM will emit TDH.MEM.PAGE.REMOVE then
> > > > unaccept is done (?).
> > >
> > > > Say, what happens if we run QEMU with this series applied, but without the
> > > > kernel series?
> > >
> > > The kernel series is needed at least for PAGE.ACCEPT. Without it, QEMU
> > > will have KVM_RUN return EIO, and finish into assert (while tearing
> > > down ioeventfd).
> >
> > Could you elaborate a bit more on why ACCEPT would fail?
> >
> > I used to ask the event flow here:
> >
> > https://lore.kernel.org/qemu-devel/agTjb3M8ElUAlfp1@x1.local/
> >
> > If AUG existed, then why ACCEPT would fail?
> >
> > PS: I didn't read a lot of what a Linux guest would do; I know there're
> > some lazy accept approach, but IIUC it's only a matter of time to ACCEPT,
> > not correctness.  My understanding is if we properly notify these new slots
> > with AUG, then it should be able to ACCEPT?
> 
> Yes, it will, but it needs the kernel patches to do it (or virtio-mem
> will let the guest access un-accepted pages and qemu will crash). I
> submitted a few proposals before Zhenzhong Duan proposed the last
> iteration.

OK, I think I misunderstood both the crash and also what Zhenzhong's series
is trying to do.  After a closer look, it seems to be a proposal for any
plug/unplug to work.  I'm surprised (if I get it right this time..) that TD
didn't seem to support DIMM hotplugs besides virtio-mem.

> 
> > >
> > > > What confused me a bit is the dependency of this series v.s. the kernel
> > > > one.  It seems to use different approaches, but then I don't understand why
> > > > this series was tested with the kernel change.
> > >
> > > My understanding is that the kernel may perform TDG.MEM.PAGE.RELEASE.
> > > That depends on TDX config TDCS_CONFIG_PAGE_RELEASE which qemu/kvm
> > > doesnt currently control. I don't know whether this is then
> > > redundant/needless with qemu doing discard on the guest_memfd..
> >
> > The problem is if this series depends on the kernel series, should we then
> > wait for the kernel solution be accepted first in case it'll change?
> 
> I don't think qemu needs to wait for the kernel to be fixed.
> Furthermore, this series is not tdx/sev/etc specific

AFAIU it is coco specific, otherwise we only always have 1 source, hence no
need for this series to provide this function.

Said that, I agree with you.. Looks like there's no major plan to add
anything specific to QEMU.

Patch 1-10 are all reviewed patches and correctly resolve the known >1 ram
sources and it's a design problem, I don't see how we can bypass that.

Patch 11 is very reasonable on its own, then I assume the guest ACCEPT
problem will need to evolve on its own.  Looks like the direction is
correct, and only some corner cases to think about (acpi coverage, lazy
accept, etc.) that I saw in the discussion.

> 
> >
> > But obviously I still don't yet fully understand how this whole thing
> > works.. :(
> 
> I am also slow, because I don't focus on this most of the time.
> Someone with more experience and dedication would handle it better.

I queued patch 1-11, will send a pull this week.  Thanks for all the
explanations.

-- 
Peter Xu


