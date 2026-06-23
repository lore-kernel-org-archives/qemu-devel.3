Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FECECDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 15:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc3JY-00020x-44; Tue, 23 Jun 2026 11:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc3JQ-0001xn-Hq
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:45:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc3JL-00015x-Rg
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782229514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5a/T4Vqnm4D5FklI48JkOMRyoCfPv+sa5L5OLPTryY=;
 b=E7AFpzwsHuTgIvBhwcWINCso0HY7S9pp9RqKafJ2ch6FX0eYwYerDTIfhYwd3JEMSdbGR5
 +Sn0e62+ysg2AXu09PoSFSMVaJa1UTH/vN8q7IkD10q2vWUJMtEN6O+br14XPeb/GpvBzS
 3n4W8rOySXuZFSr7mTVEDpfXywfLYJQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-KGYOQ8lKPnqQAjPqRqJvHQ-1; Tue, 23 Jun 2026 11:45:12 -0400
X-MC-Unique: KGYOQ8lKPnqQAjPqRqJvHQ-1
X-Mimecast-MFC-AGG-ID: KGYOQ8lKPnqQAjPqRqJvHQ_1782229512
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51956be1f44so19728661cf.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782229512; x=1782834312; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I5a/T4Vqnm4D5FklI48JkOMRyoCfPv+sa5L5OLPTryY=;
 b=l2p8Okc0mUEjSKylgEgbsCaLzDox6YJOR4wvWRAXUDneuh1eMvEXrT+APFRskeZgct
 VKBsWfUv8Ac8N+GbOB46P+VWd5kqt982aaK++HSELhJU/lZuUdYGoaijh3ZOBYIWD036
 Xn2zTSoOqUzokkvFYmUBChZtAgSiOKyp5XAV+2Nu0mvjRxAO/QKR+kIb9tEAzTx1/r34
 dtWexPFvlhPjviEI6E2jv3YZxPSoL2vDhv9skt9dcPaqUqbf0yW8KFd3pEvaxQLQMzB/
 zecxXpCP+dK8ZyPfFCkTDY7CasnargxOK5DL4dA7uQxW8qrgEAaBMhUsdjwK3X0kVyAI
 YiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782229512; x=1782834312;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I5a/T4Vqnm4D5FklI48JkOMRyoCfPv+sa5L5OLPTryY=;
 b=rRYBNS5oAxLZMJXS2utzFFTjdESH7pRbK0+Ezsti1b20WYoHK/tKWNbxGl2ztGAyWm
 yJ57199m3StbeAxkT3sDxoVBH5DpLqx1X4EdhbPvQXJE6YAKpKtRz/LIaeP0BrHmDTnK
 bv32ESvf2l1tF9IkAtgzeOn69srEdtTNVvyUirxifONi02KMwgRWcJWdX52KJYvrYz4r
 qjTZSZg5w4ZjBsBB7+jxZHJHcRrrFQY4dQVkKDzJ4nPUXMY9HxsuwES3fvnH3eor4X7L
 P3WYDQQfdYsDvVbAFjoqeLPE8r49KMtvmnIAtZaiCEL/WGur8GxjwZzsx0ATKG1UhgJ2
 JXWQ==
X-Gm-Message-State: AOJu0YxTMjmn1j42qhP7NOTttrdGxGKHqIie+GYcDXH9+auz6iJRjtKa
 8K/3MCMldrFVj3LLRwKZZTEr2KCVpXuOjklVFNKFwVPDnsAhhkDvXVxN1XRl5APB3RcfiN/6TDQ
 m2k4PeuL3gXX3GscDl1EP90/jSyMK/EC7IpbgQcrPyvlP6EdqI95k9h8v
X-Gm-Gg: AfdE7cmdClAkRxP+baEh0TDp94LfLeQ7PdbSx6aE+F3zrcYpVCCaQR52xARwiNaEhkd
 jXBcIpdzP9CDpad5UheNMc4orrzPMhY3DuJg7wB3ABz5FWwpoDWFP5T2zcP/Y9qWYNht1w6PKU7
 5hAIQSSlPfMFlTaYPcmDdXiC2XMaSUMYXfHjC1b+RYzpHqQaIagj3J9DDjn9dSZfz4BiEkHf5hY
 pKLBnNMoxD/tzYttZJuFIr6exm0PlzDFWqwkTUtHEZW5Y4bz0aMrkR8TvkrthgZqNUEZ2widCzN
 BAeRWVvJEPenyPJxWDBwje59RLuDrZNTT3PH72ajfA+q+XVurb1z0UH2rRXejjSFCaPvJHK6vXW
 npx4DEfWXPsBcgRsBvGtnxzKsGLqnqo5kgiLMRKQ50nNEJ6UEKEaoMf3oBjFBKGMIk6+IpHKh
X-Received: by 2002:ac8:5fc3:0:b0:517:6fc2:4760 with SMTP id
 d75a77b69052e-51a51788b89mr60584041cf.9.1782229511556; 
 Tue, 23 Jun 2026 08:45:11 -0700 (PDT)
X-Received: by 2002:ac8:5fc3:0:b0:517:6fc2:4760 with SMTP id
 d75a77b69052e-51a51788b89mr60582621cf.9.1782229510620; 
 Tue, 23 Jun 2026 08:45:10 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-157.dsl.bell.ca. [174.91.117.157])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51ae9505sm28287431cf.26.2026.06.23.08.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 08:45:09 -0700 (PDT)
Date: Tue, 23 Jun 2026 11:45:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 qemu-block@nongnu.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Subject: Re: [PATCH 0/3] migration/ram: Abort on unsupported migratable RAM
 changes
Message-ID: <ajqqBBA3Ynxqgu_S@x1.local>
References: <20260611-ram-v1-0-a2dacf699718@rsg.ci.i.u-tokyo.ac.jp>
 <ajmZrT1d0QXCWTNq@x1.local>
 <b8154a3d-5538-42e1-995b-2aeb05daa4ab@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8154a3d-5538-42e1-995b-2aeb05daa4ab@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 23, 2026 at 09:05:22PM +0900, Akihiko Odaki wrote:
> On 2026/06/23 5:23, Peter Xu wrote:
> > On Thu, Jun 11, 2026 at 03:35:47PM +0900, Akihiko Odaki wrote:
> > > Supersedes: <20260604-migration-v1-1-cef4a5b1bbdd@rsg.ci.i.u-tokyo.ac.jp>
> > > ("[PATCH] system/physmem: Assert migration invariants")
> > > 
> > > ram_mig_ram_block_resized() already aborts migration when migratable RAM
> > > is resized. Extend the same handling to other unsupported changes to the
> > > migratable RAMBlock set, such as removing a migratable RAMBlock or
> > > changing a RAMBlock's migratable state.
> > > 
> > > Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > > ---
> > > Akihiko Odaki (3):
> > >        system/physmem: Pass RAMBlock to RAMBlockNotifier callbacks
> > >        system/physmem: Notify RAMBlock migratable and idstr changes
> > >        migration/ram: Abort on unsupported migratable RAM changes
> > 
> > Thanks for looking at this, Akihiko.
> > 
> > I understand this is a protection to the system to trap error use cases.
> > The question I have is do we have any possible way to trigger these.
> > 
> > I worry we add a bunch of code and notifiers, and then there's zero way to
> > trigger, essentially add dead code.
> > 
> > Logically we could already add assert() on things we don't expect to
> > happen.  This case might be slightly risky, but still I think we can also
> > consider things like error_report_once() instead of introducing slightly
> > complex notifiers just to cover what we think shouldn't happen.
> > 
> > Or do you have way to trigger any of these notifiers?
> 
> I simply followed what's already done for resize(), expecting resize() does
> the correct thing and following it won't introduce a regression.
> 
> > 
> > PS: today I went back and I wanted to try how the existing resize()
> > notifier would trigger, I can't even reproduce it with David's example
> > here:
> > 
> > https://lore.kernel.org/qemu-devel/20210429112708.12291-1-david@redhat.com/#t
> > 
> > I can trap a qemu_ram_resize(), but that's invoked with newsize==rb->size,
> > so it didn't really notify a thing.  I don't really know how to trigger
> > ram_block_notify_resize().  If you know, please share.
> I made an LLM amend the reproducer. Below is its output.
> 
> Regards,
> Akihiko Odaki
> 
> LLM output:
> 
> A synthetic but effective variant is to add custom ACPI filler tables so the
> initial `etc/acpi/tables` blob is just under the 128 KiB alignment bucket,
> then let the normal boot-time fw_cfg ACPI rebuild push it over.
> 
> I tested this shape:
> 
> ```sh
> truncate -s 65000 /tmp/fill1
> truncate -s 50600 /tmp/fill2
> ```
> 
> Then add to the original-ish command:
> 
> ```sh
> -device pcie-root-port,id=rp0,chassis=1,slot=1 \
> -acpitable sig=FI1A,data=/tmp/fill1 \
> -acpitable sig=FI2A,data=/tmp/fill2
> ```

These lines should inject some sections into ACPI, but I don't see why the
acpi table would change: that should be appended right at QEMU boots, so I
expect the ACPI table to grow indeed comparing to when without these lines,
but not resize during VM running.  I wonder if below is hallucinations from
the AI.

> 
> Observed via `info ramblock`:
> 
> ```text
> before cont:
> /rom@etc/acpi/tables   Used 0x0000000000020000
> 
> after cont:
> /rom@etc/acpi/tables   Used 0x0000000000040000
> ```
> 
> So this does produce a real RAMBlock used-size growth during boot in the
> current tree. With migration started before `cont` using a stalled `exec:`
> target, `info migrate` moved to `cancelling`, which is consistent with the
> current resize-during-precopy abort path.
> 
> The key is not the root port itself; the key is making the ACPI table
> rebuild cross `ACPI_BUILD_TABLE_SIZE` alignment. The filler is a bit
> artificial, but it is a good stress variant for the exact class of bug.

I did have a closer look on this whole "MR size can change" thing.

We have two users: ACPI (rom_add_blob()) and other firmwares (most of them
rom_add_file() users, very little used rom_add_blob()).

AFAIU, the real resize should only happen at the 2nd user, not ACPI.

ACPI seems to be able to change ROM size (PS: this is tricky to call it ROM
in the first place: I believe it's only a data blob in fw_cfg) when e.g. it
scans the pci bus and things changed, only happen during reboot, but it
can't happen during migration because qdev_add is forbidden.

Device ROMs can really change size if dest host has newer firmware packages
than source, but that's another use case and I _think_ we support fine,
except that firmwares can only grow not shrink, guarded by
qemu_ram_resize() check on max_length.

That's a pretty niche use case and nothing I can think of that on change of
flipping migratable and so on.  So IMHO we will need to understand the
problem better before having more notifiers.

PS: I wished ACPI three use cases of ROM can be part of device states
already, then it is out of question on MR resize complexity: the max size
is 128K as far as I know; it doesn't need iterability... we migrate devices
sometimes much larger than 128KB on device states.  It can be a VMSD field.

Thanks,

-- 
Peter Xu


