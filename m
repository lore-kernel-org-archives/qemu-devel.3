Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C78C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 15:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA9ef-0003FP-V1; Wed, 30 Apr 2025 11:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uA9eP-0003Cu-LI
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 11:47:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uA9eN-0000rX-IK
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 11:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746028026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z0gzVCkuNwU96DtTEyqWD+gM1Okp7PNu/5ypTN1zJcM=;
 b=ETzdk3Sk+2d7uOrmsV/TAb6ZN/f8SUmyXGnrP7YOGI4YFeDElBCvZkt0nRhutpKj7TclZm
 BLsnC/EvRYuV8nJ/8wEjqMxvo3CDa7WOlzkjw5fwFLkdZFrTWjrAXHq+L2nAhcRF4oTHWr
 7FZIQnofP3RDOVOnq+JkIrN2hYC8j6k=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-pF7f15AtP4SSvRhpR0khgg-1; Wed, 30 Apr 2025 11:47:04 -0400
X-MC-Unique: pF7f15AtP4SSvRhpR0khgg-1
X-Mimecast-MFC-AGG-ID: pF7f15AtP4SSvRhpR0khgg_1746028024
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4766e03b92bso123591cf.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 08:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746028024; x=1746632824;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0gzVCkuNwU96DtTEyqWD+gM1Okp7PNu/5ypTN1zJcM=;
 b=CJkAxSeW6xsiNxbA3ovA+QMtPsHkL/739WOud6amv5PftAejioctflqiw77L0n3GIp
 5gRH5T1xmoH6fTz7ylk90781D/Lcb2sWGOdhg9ogpab/M7L1aLXLBmjRkVielxtiMTO7
 YmkUohJC70E80goql7sF+DRz0iultkQdbDo/aXO8wU0DQEV68PCjxauR8ldttbqlXDVN
 HCGPrTemUBAqknegCRgXGTMvCmWZeZxt4s/MxyFM+8dv3W1XKSkEdtmXALOGfGZDm7ZS
 EHohmBeYi7+GB/Tg656Hxody6n+LKVzZ0hQztv1jdVfnyIghXMhpvjTMid6mAJbiEOAl
 Hjxg==
X-Gm-Message-State: AOJu0YyD6KSjULoMkMdG+MiLDeX6nk9Xx92xfvqASWFzTI47EXzQ44Kk
 q8lHA+/5wO2EaVTiLhqxCrv1xJCj7MMoYzZMX/BI011nWUb/9T0soh129lQPIM5z6vIJOH8UNdj
 dD+a7d4bMI1n3q7/XsMvgvmlh2ZAd7Epp4gaMaSzcHw7f+CBNC8Ad
X-Gm-Gg: ASbGncuAgvhvJqEiNHeHACtwgiINxDHI6T7KFs+O6tn6QTrhKba9ISjtkCqhzBUxHZm
 pAmKZFEId9jyV9Hz+SV8pfnoS1bciRxHUVOOy8X3D3PKH11c3pWIqSV9kfW089MWJnBOwIjxxDi
 wMOJwAGXptWMfl3HMGqtcP+wJ0FaQkd9MePe/iU6j2KDhtonwgKW7OwOI2EmZN7dCFP1L98JMvE
 226SFh6jgZn/wA2Ap48cGD4edgW1WG6dwsDCHbztHL94ShTNoJcZqv6A2eariohe/QZZ7+CRUM4
 tPA=
X-Received: by 2002:a05:622a:4a05:b0:477:4224:9607 with SMTP id
 d75a77b69052e-489c38ae319mr49632671cf.12.1746028024006; 
 Wed, 30 Apr 2025 08:47:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQ+UHYIXiAZMc5uJobj5uckg1lwwhp70BFJ73wwDGYSmunkrbvRKsgQ8TPJtqv2UBwtTHMoQ==
X-Received: by 2002:a05:622a:4a05:b0:477:4224:9607 with SMTP id
 d75a77b69052e-489c38ae319mr49632311cf.12.1746028023575; 
 Wed, 30 Apr 2025 08:47:03 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47e9f7a7618sm95773501cf.43.2025.04.30.08.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 08:47:02 -0700 (PDT)
Date: Wed, 30 Apr 2025 11:46:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 3/4] tests/data/vmstate-static-checker: Add dump files
 from QEMU 7.2.17
Message-ID: <aBJF86EagPZgRuBe@x1.local>
References: <20250429152141.294380-1-thuth@redhat.com>
 <20250429152141.294380-4-thuth@redhat.com>
 <aBFTE8r3lyqUcAsT@x1.local>
 <d5585d6b-fc61-4127-9acb-6235271fc45a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5585d6b-fc61-4127-9acb-6235271fc45a@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 30, 2025 at 01:13:48PM +0200, Thomas Huth wrote:
> On 30/04/2025 00.30, Peter Xu wrote:
> > On Tue, Apr 29, 2025 at 05:21:40PM +0200, Thomas Huth wrote:
> > > From: Thomas Huth <thuth@redhat.com>
> > > 
> > > For automatic tests, we need reference files from older QEMU versions.
> > > QEMU 7.2 is a long term stable release, so it's a good candidate for
> > > checking whether the migration could still work correctly. Let's add the
> > > files from that version that have been taken with the "-dump-vmstate"
> > > parameter of QEMU (compiled with single machines and the configure switch
> > > "--without-default-devices" to keep the json files reasonable small).
> > > 
> > > Some devices also have been removed manually from the json files, e.g.
> > > the "pci-bridge" (which can be disabled in later QEMU versions via Kconfig),
> > > and some Linux-related devices like "scsi-block" and "scsi-generic" and
> > > KVM-related devices. Without removing them, we might get errors otherwise
> > > if these devices have not been compiled into the destination QEMU build.
> > > 
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   MAINTAINERS                                   |    1 +
> > >   .../aarch64/virt-7.2.json                     | 2571 +++++++++++++
> > >   .../vmstate-static-checker/m68k/virt-7.2.json | 2936 ++++++++++++++
> > >   .../ppc64/pseries-7.2.json                    | 1068 ++++++
> > >   .../s390x/s390-ccw-virtio-7.2.json            |  475 +++
> > >   .../x86_64/pc-q35-7.2.json                    | 3402 +++++++++++++++++
> > >   6 files changed, 10453 insertions(+)
> > >   create mode 100644 tests/data/vmstate-static-checker/aarch64/virt-7.2.json
> > >   create mode 100644 tests/data/vmstate-static-checker/m68k/virt-7.2.json
> > >   create mode 100644 tests/data/vmstate-static-checker/ppc64/pseries-7.2.json
> > >   create mode 100644 tests/data/vmstate-static-checker/s390x/s390-ccw-virtio-7.2.json
> > >   create mode 100644 tests/data/vmstate-static-checker/x86_64/pc-q35-7.2.json
> > 
> > This looks like an improvement indeed, it so far only covers machine type
> > 7.2, rather than all machine types.  I used to run these by hands before
> > each release.. and sometimes I forgot.  Before me, I am aware at least Dave
> > used to run also during softfreezes.
> 
> Since I had to strip down the dump files quite a bit (compiling QEMU with
> --without-default-devices etc.) to avoid errors when the current build is
> limited, it's maybe best if you continue checking manually at least once
> during the soft-freeze with a non-stripped json file.

Yep, will do (if I won't forget to..).

> 
> > One thing I am wondering is if we can do it the same way as the compat
> > migration test in CI, so that we always compare with a base (which is the
> > previous release binary), then move the base after each release.
> > 
> > After all, due to migration-compat-common CI job, we always build the base
> > version of QEMU already in build-previous-qemu, so we already have two
> > binaries at hand.  IIUC we only need one new job to generate the two JSON
> > blobs, and feed them to the checker on both directions.
> > 
> > If that is the case, it might have a benefit that we can cover all the
> > machines as long as listed on both binaries, then check all of them?
> > 
> > Meanwhile, if we keep the ball rolling for each release (by boosting the
> > base QEMU binary version), IIUC it guarantees all the new binaries will
> > make sure to provide compatible VMSDs all across since we start running the
> > job.
> > 
> > Would that work?
> 
> I can have a try, though we might need to teach the checker script some more
> things first, e.g. it's getting confused if we clean up old and unnecessary
> fields like in commit 445d3facffe82788b880107c0849dab9505b33d9 ...

Right, we definitely want to have such job allow_failure set.. And this is
also not the only way to fail it, e.g. I just ran it on the latest 10.0 for
q35-9.2 machine type, then I spot two more failures besides what you fixed
in this series.

x1:bin [migration-staging]$ ../scripts/vmstate-static-checker.py -s ./json.9.2 -d ./json.10.0 
Section "sysbus-ahci" does not exist in dest
Section "hpet", Description "hpet": expected field "num_timers", got "num_timers_save"; skipping rest

The first one is caused by a Kconfig change - CONFIG_AHCI used to be
selected via hw/ide on x86, now since there's the new ahci-sysbus.c since
1b26146e898086 in 10.0, vmstate_sysbus_ahci isn't available anymore on x86,
but only selected by hw/arm/Kconfig even if I built the binary using
exactly the same setup.

The 2nd one is a rename which is similarly benign.  I'll throw a patch soon
for that.

If one step further.. maybe we could also cache the checker's output for
each (arch, machine type) tuple, then we mark the job fail only if the
output changes.  That may help to warn maintainers that something changed
the VMSD so one can have a look.  But we could start from simple..

-- 
Peter Xu


