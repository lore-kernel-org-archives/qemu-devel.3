Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09DCE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 17:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLn64-0006nE-5e; Thu, 12 Dec 2024 12:35:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLn5w-0006mv-Gx
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:35:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLn5u-0001bf-5C
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734024919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GkftfNceJzRB56OKn8zXuJ04WQtChDxCt9RtkoyrhRA=;
 b=FiaQcxW00CLOFcEYuqVTaS1ZSelN6tHU7ihbeUctQ+bJfrUo0YNHnXEUlHxZDM2ptba95u
 CJtVhhi7mQ144hRn491T+NhOBKzh4ec6gbW0ZEgl22oIZyhYtiWcLGxv7z6KdkqPQEvCHj
 IEcGmVzwqtGjmrui1jbX5g5t4H+JFcA=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-_W1aNJaTPYmFcdALzi6zzg-1; Thu, 12 Dec 2024 12:35:17 -0500
X-MC-Unique: _W1aNJaTPYmFcdALzi6zzg-1
X-Mimecast-MFC-AGG-ID: _W1aNJaTPYmFcdALzi6zzg
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-844cfac2578so124469439f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 09:35:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734024917; x=1734629717;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GkftfNceJzRB56OKn8zXuJ04WQtChDxCt9RtkoyrhRA=;
 b=nET3CR/LHioFBeKRhqU3CXDDLGu0uJOmi25wCqFxUQcowq96mvkrr6bPWOasWGzx4a
 MwssyZkYgRerjzyNApZwJ2Sr8PS/O+9B8UzGXLBwL+R6oShNjKOx+5Er91gPUKIrMRg4
 UGdsCMEinHiiPPU+ir/fhoR4UYroKSqn5QncsFjDiB+wlUEEIBTm/gNHuTXtDwNS5/ia
 65XbMSpBPu/prpurvtPTcHVYmJnZpYQZ2NNatFt6RGSylfF6jjjFHaTo9gPhRrCHwuK9
 6MQ2EURquS6CfvTZ/fPYTEjoKyYQ+vfD5qAc3rOifVltt8Cx1nmIInMxanC08ZGjCB89
 Nr4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv+6p5g2/tlfYLUMc50Hk2lglUh23fdljQkVsaXUlaD2XENlB8trLF5pD7k1szkzo27SI101BVEGkk@nongnu.org
X-Gm-Message-State: AOJu0YxmuJwC5WnYdKpRxSPq5CkMhVuoGKSp+70eZ2RvFMiLrUbjcHa1
 LQeRMjCRdoAy1z7L0oQb/Gaod393P2FViCTm6J9NLkB7v5rVS3r8XmotaVt0VuQfM3xO3+NF4Oc
 JXraNu0SzFPVSDZm/GJrU6Jn9nPh0+cVsJl8XRmbzn/k2//ADm0yJ
X-Gm-Gg: ASbGnctD7IAYoEgrx5BI8+eutGKOxgLsnI2oO+ykxLGpPI3CTrF3yxj127M5OvgslGg
 wRFHU6ZmmHEkBhZlNlYF5OQ+wEtVMFTZz9rF1swrp/HiqF8LTQESFnDq7o1Ea4Pr7+96L11emen
 qQ1Ebj3u9CA58Qe0nf+fUmXK+UbZ7Ovpt/xJ8BntRJSLmhRnnRrNnBOpAZbOttoMTWHyB7ovBzd
 TgQSeMpzXf7IgNkJptpSGkgbY0KCOoR/fmOvt9eccF7A4pLbC/qMgw3Gi79+qFBhO61ER9mZFXb
 IggQbTdN+VxWG0SGDQ==
X-Received: by 2002:a05:6602:3f95:b0:83a:db84:41a8 with SMTP id
 ca18e2360f4ac-844e56ac920mr143402539f.10.1734024916879; 
 Thu, 12 Dec 2024 09:35:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0dBH5G9wyGT1F4wIlxEixbfxJChD7Aq5R11TCARwH1Gw+qe1qSbm0SmKYM0BgyQS+6nIB1g==
X-Received: by 2002:a05:6602:3f95:b0:83a:db84:41a8 with SMTP id
 ca18e2360f4ac-844e56ac920mr143399239f.10.1734024916495; 
 Thu, 12 Dec 2024 09:35:16 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2ce6fd116sm1576078173.134.2024.12.12.09.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 09:35:15 -0800 (PST)
Date: Thu, 12 Dec 2024 12:35:13 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 00/24] =?utf-8?Q?Multifd_?= =?utf-8?B?8J+UgA==?=
 device state transfer support with VFIO consumer
Message-ID: <Z1se0X6eq1DRYLa0@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <Z1CpIA7_o7s-NzJ_@x1n>
 <23398782-6d92-48ae-99f3-855b405f366f@maciej.szmigiero.name>
 <Z1N4qYOsEcfsC-H5@x1n>
 <5c6a0bc3-ab9a-4514-8feb-f3c17978d3af@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c6a0bc3-ab9a-4514-8feb-f3c17978d3af@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Dec 11, 2024 at 12:06:04AM +0100, Maciej S. Szmigiero wrote:
> On 6.12.2024 23:20, Peter Xu wrote:
> > On Fri, Dec 06, 2024 at 07:03:36PM +0100, Maciej S. Szmigiero wrote:
> > > On 4.12.2024 20:10, Peter Xu wrote:
> > > > On Sun, Nov 17, 2024 at 08:19:55PM +0100, Maciej S. Szmigiero wrote:
> > > > > Important note:
> > > > > 4 VF benchmarks were done with commit 5504a8126115
> > > > > ("KVM: Dynamic sized kvm memslots array") and its revert-dependencies
> > > > > reverted since this seems to improve performance in this VM config if the
> > > > > multifd transfer is enabled: the downtime performance with this commit
> > > > > present is 1141 ms enabled / 1730 ms disabled.
> > > > > 
> > > > > Smaller VF counts actually do seem to benefit from this commit, so it's
> > > > > likely that in the future adding some kind of a memslot pre-allocation
> > > > > bit stream message might make sense to avoid this downtime regression for
> > > > > 4 VF configs (and likely higher VF count too).
> > > > 
> > > > I'm confused why revert 5504a8126115 could be faster, and it affects as
> > > > much as 600ms.  Also how that effect differs can relevant to num of VFs.
> > > > 
> > > > Could you share more on this regression?  Because if that's problematic we
> > > > need to fix it, or upstream QEMU (after this series merged) will still not
> > > > work.
> > > > 
> > > 
> > > The number of memslots that the VM uses seems to differ depending on its
> > > VF count, each VF using 2 memslots:
> > > 2 VFs, used slots: 13
> > > 4 VFs, used slots: 17
> > > 5 VFs, used slots: 19
> > 
> > It's still pretty less.
> > 
> > > 
> > > So I suspect this performance difference is due to these higher counts
> > > of memslots possibly benefiting from being preallocated on the previous
> > > QEMU code (before commit 5504a8126115).
> > > 
> > > I can see that with this commit:
> > > > #define  KVM_MEMSLOTS_NR_ALLOC_DEFAULT                      16
> > > 
> > > So it would explain why the difference is visible on 4 VFs only (and
> > > possibly higher VF counts, just I don't have an ability to test migrating
> > > it) since with 4 VF configs we exceed KVM_MEMSLOTS_NR_ALLOC_DEFAULT.
> > 
> > I suppose it means kvm_slots_grow() is called once, but I don't understand
> > why it caused 500ms downtime!
> 
> In this cover letter sentence:
> > "the downtime performance with this commit present is 1141 ms enabled / 1730 ms disabled"
> "enabled" and "disabled" refer to *multifd transfer* being enabled, not
> your patch being present (sorry for not being 100% clear there).
> 
> So the difference that the memslot patch makes is 1141 ms - 1095ms = 46 ms extra
> downtime, not 500 ms.
> 
> I can guess this is because of extra contention on BQL, with unfortunate timing.

Hmm, I wonder why the address space changed during switchover.  I was
expecting the whole address space is updated on qemu boots up, and should
keep as is during migration.  Especially why that matters with mulitifd at
all..  I could have overlooked something.

> 
> > Not to mention, that patchset should at least reduce downtime OTOH due to
> > the small num of slots, because some of the dirty sync / clear path would
> > need to walk the whole slot array (our lookup is pretty slow for now, but
> > probably no good reason to rework it yet if it's mostly 10-20).
> 
> With multifd transfer being disabled your memslot patch indeed improves the
> downtime by 1900 ms - 1730 ms = 170 ms.

That's probably the other side of the change when slots grow, comparing to
the pure win where the series definitely should speedup the dirty track
operations quite a bit.

> 
> > In general, I would still expect that dynamic memslot work to speedup
> > (instead of slowing down) VFIO migrations.
> > 
> > There's something off here, or something I overlooked.  I suggest we figure
> > it out..  Even if we need to revert the kvm series on master, but I so far
> > doubt it.
> > 
> > Otherwise we should at least report the number with things on the master
> > branch, and we evaluate merging this series with that real number, because
> > fundamentally that's the numbers people will get when start using this
> > feature on master later.
> 
> Sure, that's why in the cover letter I provided the numbers with your commit
> present, too.

It seems to me we're not far away from the truth.  Anyway, feel free to
update if you figure out the reason, or got some news on profiling.

Thanks,

-- 
Peter Xu


