Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42E2C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 18:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weGc7-00005I-9n; Mon, 29 Jun 2026 14:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1weGc6-0008WS-9J
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 14:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1weGc4-0002lk-7g
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 14:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782757302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mqhrmw4306aEe95JPXSB7j+flpGUNhgGo9WXZ9ofnDQ=;
 b=ge+xQvLRNioCnGtBwSqoq8NTylyP8s3PA05bh0HJjbYCBNgrsSNSk2QGDprcFboAiImIdh
 h2IoskE+kxOw2ZVktQqWluergaMqDdhReFUGHtvPnpF5M6bfSPFK86JOea7sji4D1I0RQn
 4JBbS0yQ/XJPMj98fRHJHMDKEzvq+Z0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-4N5wq7hkMauQzk_tqfQ0LA-1; Mon, 29 Jun 2026 14:21:41 -0400
X-MC-Unique: 4N5wq7hkMauQzk_tqfQ0LA-1
X-Mimecast-MFC-AGG-ID: 4N5wq7hkMauQzk_tqfQ0LA_1782757300
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92d4b18b373so521970085a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 11:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782757300; x=1783362100; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mqhrmw4306aEe95JPXSB7j+flpGUNhgGo9WXZ9ofnDQ=;
 b=X3M40b4JTgGHVm/P29aJbdVd9ZIpG3M0kUyukmyIx6CsM0/v1fQNl44C72D/Ma15Nk
 P5Pu4skK8gcDIeneo3FROYBd2qqQgFBh9fVi0LRV6lLdQrQGKVSZJMpQhiDINi+a10Ry
 RW02EEZGZu33B9n0o1a2CL0a4onr4iV/zJA+fUXSzQssNROTXylMnbIJkHM/yi2x8JLm
 c9Lzyv/0moaymS95f8lvLTSBOj6iClyCk7rpgx/o/mbe/81HWlD7dzvOLNufuEf039BJ
 K1oy9vMC9IoHySCwnZomI9Ibyp3kmbzdoNR0KD+32TfjtuTwDJABazGFphXD/rQiqaEv
 XPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782757300; x=1783362100;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mqhrmw4306aEe95JPXSB7j+flpGUNhgGo9WXZ9ofnDQ=;
 b=IL7iq64trF1qFl+27ABEE1fa41+48ynH4G400fVHUREA1sIQRHg7i6l6YndOZiG8E5
 C2pyXbBmvh55Fj4E21LgwCeQgRvjwJK7bpJ6it+ncy5o2zcdfcmNLigR5Fb+xpiOz+vu
 DizrmpXRIuOeVjbjkLuhrXmuNWk+qRPTslW66LFZEDU6UTuk/HEK60TxyyutPJTG7gAd
 6buK/oHJEropRB6QNHdOFKv3+DZNYZ5PKUR+scgqFZLenTXuB+RLXSmrw4MOn8MgSnnS
 xnFemN8qD+19v17Pw/qG6zVI+ejfkSvFuD0davjczHiwFtLKpWMKDaS8gye890kvO8bx
 G4TA==
X-Gm-Message-State: AOJu0YxWRB39VBWe2LRfVMtl1Bzf+WccEfZY3ChIrW6i4XeZIdp7M9Ts
 wTNe6BNUE3f9yXzHV5IjCnTLz/bne0JQzlaxP0lHiCBY8Z7MkNDW+kK6zavdj4Z76d9oOPA60ai
 RC0QAWN7eDNr0hNqHszYnIauiYHmdvzc+ay2mgXuViqXPLKcdfsij4cLP
X-Gm-Gg: AfdE7cmaqw1zePSmfMUYsPV/aQQWK3ozaZxTT2zcP2knK8USEpypUP1nBJKJ6P/kdGf
 VrvwDHwnahDn89gWb4FS0zSevzCzESTAPBq0l4LuNbNMudllFDrgnA70ckyvYnx3VrxSUJq/Bpy
 oZZVexxwsrjBVtK/x15C/o/dwrDeeJyg54SFbsaTADbr9obnwi66Y0nZpj/Zky5F0uNy6cG2oNa
 jk9XxHFd0p8wwUJyNjm3MjOg3y0Sn2ngZCYb3aeC/6igDeaDi7pI2PrbGgv8h6dlryq57J2tW/R
 TZnws9UtDBy9wDqa5QJGD97XqYp/Qp+RjMYWJz5829xgub588yGZHb30GVZuYIH9rtsZGbLoC/2
 YAQA=
X-Received: by 2002:a05:620a:4045:b0:92e:44f5:d638 with SMTP id
 af79cd13be357-92e62816f4amr111572485a.67.1782757300266; 
 Mon, 29 Jun 2026 11:21:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4045:b0:92e:44f5:d638 with SMTP id
 af79cd13be357-92e62816f4amr111565285a.67.1782757299582; 
 Mon, 29 Jun 2026 11:21:39 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e623869e6sm40403985a.45.2026.06.29.11.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 11:21:38 -0700 (PDT)
Date: Mon, 29 Jun 2026 14:21:26 -0400
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
Message-ID: <akK3preOMO_rkZFF@x1.local>
References: <20260611-ram-v1-0-a2dacf699718@rsg.ci.i.u-tokyo.ac.jp>
 <ajmZrT1d0QXCWTNq@x1.local>
 <b8154a3d-5538-42e1-995b-2aeb05daa4ab@rsg.ci.i.u-tokyo.ac.jp>
 <ajqqBBA3Ynxqgu_S@x1.local>
 <377d55cb-b239-40d8-b6c2-79e25cdeab1d@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <377d55cb-b239-40d8-b6c2-79e25cdeab1d@rsg.ci.i.u-tokyo.ac.jp>
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

On Wed, Jun 24, 2026 at 01:38:32AM +0900, Akihiko Odaki wrote:
> On 2026/06/24 0:45, Peter Xu wrote:
> > On Tue, Jun 23, 2026 at 09:05:22PM +0900, Akihiko Odaki wrote:
> > > On 2026/06/23 5:23, Peter Xu wrote:
> > > > On Thu, Jun 11, 2026 at 03:35:47PM +0900, Akihiko Odaki wrote:
> > > > > Supersedes: <20260604-migration-v1-1-cef4a5b1bbdd@rsg.ci.i.u-tokyo.ac.jp>
> > > > > ("[PATCH] system/physmem: Assert migration invariants")
> > > > > 
> > > > > ram_mig_ram_block_resized() already aborts migration when migratable RAM
> > > > > is resized. Extend the same handling to other unsupported changes to the
> > > > > migratable RAMBlock set, such as removing a migratable RAMBlock or
> > > > > changing a RAMBlock's migratable state.
> > > > > 
> > > > > Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > > > > ---
> > > > > Akihiko Odaki (3):
> > > > >         system/physmem: Pass RAMBlock to RAMBlockNotifier callbacks
> > > > >         system/physmem: Notify RAMBlock migratable and idstr changes
> > > > >         migration/ram: Abort on unsupported migratable RAM changes
> > > > 
> > > > Thanks for looking at this, Akihiko.
> > > > 
> > > > I understand this is a protection to the system to trap error use cases.
> > > > The question I have is do we have any possible way to trigger these.
> > > > 
> > > > I worry we add a bunch of code and notifiers, and then there's zero way to
> > > > trigger, essentially add dead code.
> > > > 
> > > > Logically we could already add assert() on things we don't expect to
> > > > happen.  This case might be slightly risky, but still I think we can also
> > > > consider things like error_report_once() instead of introducing slightly
> > > > complex notifiers just to cover what we think shouldn't happen.
> > > > 
> > > > Or do you have way to trigger any of these notifiers?
> > > 
> > > I simply followed what's already done for resize(), expecting resize() does
> > > the correct thing and following it won't introduce a regression.
> > > 
> > > > 
> > > > PS: today I went back and I wanted to try how the existing resize()
> > > > notifier would trigger, I can't even reproduce it with David's example
> > > > here:
> > > > 
> > > > https://lore.kernel.org/qemu-devel/20210429112708.12291-1-david@redhat.com/#t
> > > > 
> > > > I can trap a qemu_ram_resize(), but that's invoked with newsize==rb->size,
> > > > so it didn't really notify a thing.  I don't really know how to trigger
> > > > ram_block_notify_resize().  If you know, please share.
> > > I made an LLM amend the reproducer. Below is its output.
> > > 
> > > Regards,
> > > Akihiko Odaki
> > > 
> > > LLM output:
> > > 
> > > A synthetic but effective variant is to add custom ACPI filler tables so the
> > > initial `etc/acpi/tables` blob is just under the 128 KiB alignment bucket,
> > > then let the normal boot-time fw_cfg ACPI rebuild push it over.
> > > 
> > > I tested this shape:
> > > 
> > > ```sh
> > > truncate -s 65000 /tmp/fill1
> > > truncate -s 50600 /tmp/fill2
> > > ```
> > > 
> > > Then add to the original-ish command:
> > > 
> > > ```sh
> > > -device pcie-root-port,id=rp0,chassis=1,slot=1 \
> > > -acpitable sig=FI1A,data=/tmp/fill1 \
> > > -acpitable sig=FI2A,data=/tmp/fill2
> > > ```
> > 
> > These lines should inject some sections into ACPI, but I don't see why the
> > acpi table would change: that should be appended right at QEMU boots, so I
> > expect the ACPI table to grow indeed comparing to when without these lines,
> > but not resize during VM running.  I wonder if below is hallucinations from
> > the AI.
> 
> The resize happens because the ACPI fw_cfg blobs are built lazily when the
> guest firmware selects them. acpi_add_rom_blob() registers
> acpi_build_update() as the fw_cfg select callback; after `cont`, firmware
> reads the fw_cfg ACPI entries, QEMU builds the tables, and
> acpi_ram_update() calls memory_region_ram_resize().
> 
> Below is the reprouction case (LLM-generated):
> 
> #!/bin/sh
> set -eu
> 
> QEMU=${QEMU:-build/qemu-system-x86_64}
> tmp=$(mktemp -d)
> trap 'rm -rf "$tmp"' EXIT
> 
> qmp_migrate()
> {
>     printf '%s%s%s\n' \
>         '{"execute":"migrate","arguments":{"channels":[{' \
>         '"channel-type":"main","addr":{"transport":"exec",' \
>         '"args":["/bin/sleep","1000"]}}]}}'
> }
> 
> truncate -s 65000 "$tmp/fill1"
> truncate -s 50600 "$tmp/fill2"
> truncate -s 256M "$tmp/nvdimm"
> 
> {
>     echo '{"execute":"qmp_capabilities"}'
>     echo '{"execute":"x-query-ramblock"}'
>     qmp_migrate
>     sleep 1
>     echo '{"execute":"query-migrate"}'
>     echo '{"execute":"cont"}'
>     sleep 3
>     echo '{"execute":"query-migrate"}'
>     echo '{"execute":"x-query-ramblock"}'
>     echo '{"execute":"quit"}'
> } | "$QEMU" \
>     -S \
>     -machine q35,nvdimm=on,accel=tcg \
>     -smp 1 \
>     -cpu max \
>     -m size=20G,slots=8,maxmem=22G \
>     -object \
>     memory-backend-file,id=mem0,mem-path="$tmp/nvdimm",size=256M \
>     -device nvdimm,label-size=131072,memdev=mem0,id=nvdimm0,slot=1 \
>     -nodefaults \
>     -qmp stdio \
>     -serial none \
>     -device vmgenid \
>     -device intel-iommu \
>     -acpitable sig=FI1A,data="$tmp/fill1" \
>     -acpitable sig=FI2A,data="$tmp/fill2" \
>     -display none
> 
> Expected markers in the output:
> 
> /rom@etc/acpi/tables ... Used 0x0000000000020000
> "status": "active"
> "status": "cancelling", "error-desc": "RAM block '/rom@etc/acpi/tables'
> resized during precopy."
> /rom@etc/acpi/tables ... Used 0x0000000000040000

Yes, this script did trigger this.

I didn't check why -acpitable is special, but still, it isn't a real-life
use case to me, and after "cont" it won't change.  It's just still too
special so far so less of a concern to me.

The other thing is, it also didn't further prove there's any possible
update of e.g. migratable flag or idstr that would justify the new
notifiers are not dead code..

On the ACPI code alone, I kept thinking we shouldn't use resize() callback
on its own; we already have vmstate_fw_cfg_acpi_mr, I think we could have
marked all three regions non-migratable then migrate them in the same
VMSD.. It saves all these complexities on thinking about what could happen.

But the same applies here, if there's no real-life issue with it, we don't
need to bother either..

Thanks,

-- 
Peter Xu


