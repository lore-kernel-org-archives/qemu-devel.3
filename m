Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB76C3DA64
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 16:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sadyn-0003C6-SU; Sun, 04 Aug 2024 12:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sadyP-0002Tm-Cm
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 12:20:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sadyN-0004Hy-7x
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 12:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722788441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eiy6kWvax2A+oc6wVJfIobrpDp6zGGxbUiawM/vcVyw=;
 b=fquvxQcY/iR/H8ttkS8zZYiXwGUBF/vR5FM45vPRqWt5G1UyejQD+Z3bSLG+doBdqczfvO
 p6Bs2qB+Pap24uTl2TAoqZhZwHiqsgUPwhap4UMlg325uM1VfaiLipEDUP+YflC23NNL0n
 7Eu268NLr6gIOwkxzdlZLhxhLy2WsGE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-a-HazOLyN6O2apszr6gG7Q-1; Sun, 04 Aug 2024 12:20:37 -0400
X-MC-Unique: a-HazOLyN6O2apszr6gG7Q-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6bba0f9d3efso7500486d6.3
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 09:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722788436; x=1723393236;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eiy6kWvax2A+oc6wVJfIobrpDp6zGGxbUiawM/vcVyw=;
 b=Nctt4MyT15OpblP5Wdwxjvdi6ZY6WYIN/tZAGkxsDU5PXriB3vNWEmTERCU9mglpDd
 4mjE10Zc+wBfbOj9YkeBWwlHrKAPG2NPaakmX//PIk89p9drGrck5gK1QQWOw2w+h7TQ
 NdnTISVIRcYMOgCSkpSVVad3H3VAebSWUipZucUA/28XiooTQYjzKZgBvYxibXoDDesu
 NNj12EKUZzgjRYXT72FwK++sFF8qWh9VSGXSxXo+UYKgbwskjbNPPScGzuvpW+ycF8E5
 Ezw/VB3uywK2Yjxr2/2HOhDud42QfP2l8ct/rV4yFHo6k/8IA6sC5SPh1Xw6HGCjAcOe
 GASA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ3vKFGNJ3nDHE0vvFQqhRV2tA2/RbLOeNycgCt+X6HQ2ahfepErUuJ7Hwj3+Crbx84pnq+ErlniZk@nongnu.org
X-Gm-Message-State: AOJu0Yzs0caJPIQfS7MZA046Um2hn+7RqJsfc8Ioz0RSaBekO5mtJAJJ
 qcoTuu+zndBvR5hKsR9CKC5Okrhb+SNyrN8DybHWA6vGRGPeeJvaptm4uiWWvsr1Ig6AkykFtBE
 rkkIV2dLUgdBbpv0GsAsgRCGpqZm9p1MQoX3A+f9W3bvLl4KJXXtg
X-Received: by 2002:a05:6214:1301:b0:6b2:af02:28d6 with SMTP id
 6a1803df08f44-6bb98214c33mr74682996d6.0.1722788436321; 
 Sun, 04 Aug 2024 09:20:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcINw/JwkvJCZj6ldc0bhgjAdXP9DS/GALlays34vmuQBB9ZbWgEmGx9JeuNRosonOrNNb7A==
X-Received: by 2002:a05:6214:1301:b0:6b2:af02:28d6 with SMTP id
 6a1803df08f44-6bb98214c33mr74682846d6.0.1722788435944; 
 Sun, 04 Aug 2024 09:20:35 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bb9c7b8722sm27163926d6.65.2024.08.04.09.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 09:20:35 -0700 (PDT)
Date: Sun, 4 Aug 2024 12:20:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 01/11] machine: alloc-anon option
Message-ID: <Zq-qUcWhwycspMtX@x1n>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-2-git-send-email-steven.sistare@oracle.com>
 <20240716111955.01d1d2b9@imammedo.users.ipa.redhat.com>
 <ZpgaZPxKzwcVAYZn@x1n>
 <c6695695-5a2a-4522-8fed-79b33af62892@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6695695-5a2a-4522-8fed-79b33af62892@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Jul 20, 2024 at 04:35:58PM -0400, Steven Sistare wrote:
> On 7/17/2024 3:24 PM, Peter Xu wrote:
> > On Tue, Jul 16, 2024 at 11:19:55AM +0200, Igor Mammedov wrote:
> > > On Sun, 30 Jun 2024 12:40:24 -0700
> > > Steve Sistare <steven.sistare@oracle.com> wrote:
> > > 
> > > > Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
> > > > on the value of the anon-alloc machine property.  This affects
> > > > memory-backend-ram objects, guest RAM created with the global -m option
> > > > but without an associated memory-backend object and without the -mem-path
> > > > option
> > > nowadays, all machines were converted to use memory backend for VM RAM.
> > > so -m option implicitly creates memory-backend object,
> > > which will be either MEMORY_BACKEND_FILE if -mem-path present
> > > or MEMORY_BACKEND_RAM otherwise.
> > > 
> > > 
> > > > To access the same memory in the old and new QEMU processes, the memory
> > > > must be mapped shared.  Therefore, the implementation always sets
> > > 
> > > > RAM_SHARED if alloc-anon=memfd, except for memory-backend-ram, where the
> > > > user must explicitly specify the share option.  In lieu of defining a new
> > > so statement at the top that memory-backend-ram is affected is not
> > > really valid?
> > > 
> > > > RAM flag, at the lowest level the implementation uses RAM_SHARED with fd=-1
> > > > as the condition for calling memfd_create.
> > > 
> > > In general I do dislike adding yet another option that will affect
> > > guest RAM allocation (memory-backends  should be sufficient).
> > 
> > I shared the same concern when reviewing the previous version, and I keep
> > having so.
> > 
> > > 
> > > However I do see that you need memfd for device memory (vram, roms, ...).
> > > Can we just use memfd/shared unconditionally for those and
> > > avoid introducing a new confusing option?
> > 
> > ROMs should be fine IIUC, as they shouldn't be large, and they can be
> > migrated normally (because they're not DMA target from VFIO assigned
> > devices).  IOW, per my understanding what must be shared via memfd is
> > writable memories that can be DMAed from a VFIO device.
> > 
> > I raised such question on whether / why vram can be a DMA target, but I
> > didn't get a response.  So I would like to redo this comment: I think we
> > should figure out what is missing when we switch all backends to use
> > -object, rather than adding this flag easily.  When added, we should be
> > crystal clear on which RAM region will be applicable by this flag.
> 
> All RAM regions that are mapped by the guest are registered for vfio DMA by
> a memory listener and could potentially be DMA'd, either read or written.
> That is defined by the architecture.  We are not allowed to make value
> judgements and decide to not support the architecture for some segments
> such as ROM.

You're right.  However the problem is we have pretty good grasp of the
major DMA target here (guest mem), so what I feel like is some missing work
in this area, that we're not sure what this new parameter is applying to.

It's not the case where we know "OK we have a million use case of RAM, and
we're 100% sure we want to make them all fd-based, and we introduce this
flag simply because adding this to each 1-million will take years and
thousands LOC changes".

The new parameter is cheap to paper over the question being raised here,
but it definitely adds not only ambiguity (when it conflicts with -object)
and that we'll need to maintain its compatibility for all RAMs that we have
totally no idea what can be implied underneath for whatever QEMU cmdline
that can be specified.

IMHO that, OTOH, justifies that there may need some further study to
justify this parameter alone.  For example, if it's only the vRAM that is
missing, we may at least want to have a parameter nailing down to vRAM
behavior rather than affecting anything, so as to at least avoid collision
on -object parameters.

Thanks,

-- 
Peter Xu


