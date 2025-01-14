Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DD0E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 21:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXoFe-00031d-Jq; Tue, 14 Jan 2025 16:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tXoFZ-0002wJ-80
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 16:15:02 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tXoFX-0006qf-95
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 16:15:00 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d3dce16a3dso374600a12.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 13:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736889297; x=1737494097; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vinugn0Wqr7kU8uXGUN2RvepSFgd1H2BTfmjomBKRSQ=;
 b=ToEeDkf3aJ+sWmJ0Pw9xdRS3eN4744cmB9ZeOkNxwVvlW/elIKLZX7CxvVMzvD4kYR
 Zjm37tC47E+19XagZzaPMUuGMfifB3Zpfa6F3CgqYRxBFwUBrJtAkomIK0rCAv4QLCg7
 tO1RcC9Coj3UUZqxH9Uqj0WCeNXskKcA2oHwpQ1Q74eWfwrKn4FvMYcUNPJDtVO9UqBV
 w8aQYwNMxpFnDvKPQYxe+Tlnm09FF1AuNGMWaoavpWOSZW1H4Wf/s0M1fDcf71Q3zJDp
 5+Vnrfp+TFhI+HP2+30a/yLbRF+2c6rGUf5E2Y2Liv4VpiQgQSW7fTaeNsoA45BwnCPi
 IABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736889297; x=1737494097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vinugn0Wqr7kU8uXGUN2RvepSFgd1H2BTfmjomBKRSQ=;
 b=IFiTOPUyHgMXccUedZMDC9Lbx4rGpJ8BfZuB5uTLF5Hj99+vvMgjyra51vbLuVq+8R
 5rj0VBS7t//aS4iJDOgigrd3vSVeBKuk5fFsuPZBmxRQdTbp0T1pa4DxijWvXbtYeXg5
 3O5TGh447zOIHL+FxIdU2Zkm1xj4Hyb0Cl2ECuUkQdu6MQYVdF9ef2lHmcGkKA9DrptO
 iTdkGsXDBhUv6OsFB1B4eLKb5vj0u5v1riOtHzgwsSgBbEvYXQk6KQanqlvwfHy/5fIa
 WUOA3eV78F/FZcoQP/coqB19+uPUY/sTyaeB37vxniSOFZKv1WD+S6sfpHFv6WyQt8DM
 Hg/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcgT9CubV/DzeVqCdgT5kBijeArRzhX6G1VNeXa7Sk4Xhb+m9uMbk+bZb3YgdOd7649FW7mPZ5DZvx@nongnu.org
X-Gm-Message-State: AOJu0Yxl0MkuDDzkL7T1ZGTkPW+OoAbhbf1SIeqARULJf4aXio0tB5+B
 ZpfoIjKtNAPz470QzjuI/eLrvK7zybVsCTr2LMhkcOyn9WRWqox6uwPvvaLtwDvAYrKN2l46e3b
 30KMrr71qQYrYiMAEF4etYoImv80=
X-Gm-Gg: ASbGncscnRGMKZ6h8hXXCoRFszqcAB6ZueVoPo7APcM/Jq2Z6DrwL5kVO7hcAa/HeGe
 CtD/BPB/INuL1kcjuSYTRcAwh3Z5Mjp8WzjLF
X-Google-Smtp-Source: AGHT+IHTb+wnyL/1R12jMav6WLCh8ow2UINSS5TfOFpwEer/C7m/ZFs0esSWl341FAyRIuzZ5BG2zCNtyuCtwQosPNk=
X-Received: by 2002:a05:6402:358f:b0:5d0:f6ed:4cd1 with SMTP id
 4fb4d7f45d1cf-5da0c2efefemr434115a12.10.1736889296668; Tue, 14 Jan 2025
 13:14:56 -0800 (PST)
MIME-Version: 1.0
References: <20250113210833.1712-1-farosas@suse.de>
 <CAJSP0QWe+0_rjchH0hCszU-4r_PF+ZgZgWb+cgg6UZzZiYeTQA@mail.gmail.com>
 <8734hlh471.fsf@suse.de>
 <CAJSP0QUGfq0yPyzyjHy9D0=e2o_AVMvb1SaA69fm3oexYaH60g@mail.gmail.com>
 <Z4bF0FY_v8qKCGlb@x1n>
In-Reply-To: <Z4bF0FY_v8qKCGlb@x1n>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 14 Jan 2025 16:14:44 -0500
X-Gm-Features: AbW1kvYqYCCS3XxfAw-bMxSLqCY78NgUzErbL06BVCWBZY0VhyLVxIJ2gpAi730
Message-ID: <CAJSP0QXC+ZMECR0qkqns=ShWBBzabzf5B6eFUifM51eC9J6q8A@mail.gmail.com>
Subject: Re: [RFC PATCH] tests/qtest/migration: Add cpu hotplug test
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52d.google.com
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

On Tue, 14 Jan 2025 at 15:15, Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Jan 14, 2025 at 02:28:46PM -0500, Stefan Hajnoczi wrote:
> > On Tue, 14 Jan 2025 at 09:15, Fabiano Rosas <farosas@suse.de> wrote:
> > >
> > > Stefan Hajnoczi <stefanha@gmail.com> writes:
> > >
> > > > On Mon, 13 Jan 2025 at 16:09, Fabiano Rosas <farosas@suse.de> wrote:
> > > >>
> > > >> Bug #2594 is about a failure during migration after a cpu hotplug. Add
> > > >> a test that covers that scenario. Start the source with -smp 2 and
> > > >> destination with -smp 3, plug one extra cpu to match and migrate.
> > > >>
> > > >> The issue seems to be a mismatch in the number of virtqueues between
> > > >> the source and destination due to the hotplug not changing the
> > > >> num_queues:
> > > >>
> > > >>   get_pci_config_device: Bad config data: i=0x9a read: 4 device: 5
> > > >>   cmask: ff wmask: 0 w1cmask:0
> > > >>
> > > >> Usage:
> > > >> $ QTEST_QEMU_IMG=./qemu-img QTEST_QEMU_BINARY=./qemu-system-x86_64 \
> > > >>   ./tests/qtest/migration-test -p /x86_64/migration/hotplug/cpu
> > > >>
> > > >> References: https://gitlab.com/qemu-project/qemu/-/issues/2594
> > > >> References: https://issues.redhat.com/browse/RHEL-68302
> > > >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > > >> ---
> > > >> As you can see there's no fix attached to this. I haven't reached that
> > > >> part yet, suggestions welcome =). Posting the test case if anyone
> > > >> wants to play with this.
> > > >>
> > > >> (if someone at RH is already working on this, that's fine. I'm just
> > > >> trying to get some upstream bugs to move)
> > > >
> > > > The management tool should set num_queues on the destination to ensure
> > > > migration compatibility.
> > > >
> > >
> > > I'm not sure that's feasible. The default num-queues seem like an
> > > implementation detail that the management application would not have a
> > > way to query. Unless it starts the source with a fixed number that
> > > already accounts for all hotplug/unplug operations during the VM
> > > lifetime, which would be wasteful in terms of resources allocated
> > > upfront.
> > >
> > > That would also make the destination run with a suboptimal (< #vcpus)
> > > number of queues, although that's already the case in the source after
> > > the hotplug. Do we have any definition on what should happen durgin
> > > hotplug? If one plugs 100 vcpus, should num-queues remain as 2?
> >
> > QEMU defaults num_queues to the number of present CPUs. A management
> > tool that wants to ensure that all hotplugged CPUs will have their own
> > virtqueues must set num_queues to max_cpus instead. This wastes
> > resources upfront but in theory the guest can operate efficiently. I
> > haven't checked the Linux guest drivers to see if they actually handle
> > virtqueue allocation after hotplug. The Linux drivers vary in how they
> > allocate virtqueue interrupts, so be sure to check several device
> > types like virtio-net and virtio-blk as they may behave differently.
> >
> > Or the management tool can explicitly set num_queues to the number of
> > present CPUs and preserve that across live migration and CPU hotplug.
> > In that case num_queues can be updated across guest cold boot in order
> > to (eventually) achieve the optimal multi-queue configuration.
> >
> > Other approaches might be possible too. The management tool has a
> > choice of how to implement this and QEMU doesn't dictate a specific
> > approach.
>
> Thanks for the answer, Stefan.  I've left a comment in each of the issue
> reports so that reporter can verify this works properly.
>
> This also reminded me we could have specified a very large number of queues
> in many cases - I remember it used to be 1024 somehow (perhaps also the max
> vcpu number, but I'm not sure), which caused unwanted slowness on migration
> loading side (aka, downtime portion) due to MMIO regions of each queue -
> each of the queues may need a global address space update on the guest
> physical address space.  I didn't verify this issue, but if it can be
> reproduced and verified true, I wonder if the MMIO regions (or any relevant
> resources that would be enabled with num_queues even though some of them
> are not in use) can be plugged lazily, so that we can save quite some time
> on loadvm of migration.

Greg Kurz's commit 9cf4fd872d14 ("virtio: Clarify MR transaction
optimization") is about the scaling optimization where ioeventfd
changes are batched into a single transaction. This made a big
difference. Maybe something similar can be done in your case too?

Stefan

