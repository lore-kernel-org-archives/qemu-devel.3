Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8749C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 15:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s01FG-0003qz-TR; Thu, 25 Apr 2024 11:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s01FF-0003qm-JG
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:42:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s01FD-00043b-Jk
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714059762;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLE5T0vgo9vkmP4JcxclNycXtXLx+qUYHKpWXt0TKEc=;
 b=i9BUBADCwwjTrwFJhq/wjAFfFXqcyRpCHgKWeBNgsMIbHqQYBNCbz2TUQzBjIOp9UJd35g
 YborUxqr04aSI0SI48HQfD6cmPps6MfieUkO4pphHxqkkNAuvCLhZutIh92qxMsYQ0uN24
 33r3LAI+JJdYYJHi2yfA3ftApwdjbaU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-TyUp8rp8OSizvFmnsSoGmA-1; Thu,
 25 Apr 2024 11:42:40 -0400
X-MC-Unique: TyUp8rp8OSizvFmnsSoGmA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48DC73806706
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 15:42:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73DB42166B31;
 Thu, 25 Apr 2024 15:42:39 +0000 (UTC)
Date: Thu, 25 Apr 2024 16:42:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 vchundur@redhat.com, rjarry@redhat.com
Subject: Re: [PATCH v5 3/3] Add support for RAPL MSRs in KVM/Qemu
Message-ID: <Zip57XYKiIVgf2qz@redhat.com>
References: <20240411121434.253353-1-aharivel@redhat.com>
 <20240411121434.253353-4-aharivel@redhat.com>
 <ZiFNcLYyha3_teDT@redhat.com> <D0TBB4DMA8RL.6KN35N5NVAU@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D0TBB4DMA8RL.6KN35N5NVAU@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 25, 2024 at 05:34:52PM +0200, Anthony Harivel wrote:
> Hi Daniel,
> 
> Daniel P. Berrangé, Apr 18, 2024 at 18:42:
> 
> > > +    if (kvm_is_rapl_feat_enable(cs)) {
> > > +        if (!IS_INTEL_CPU(env)) {
> > > +            error_setg(errp, "RAPL feature can only be\
> > > +                              enabled with Intel CPU models");
> > > +                return false;
> > > +        }
> > > +    }
> >
> > I see a crash in kvm_is_rapl_feat_enable() from this caller,
> > when I run with this kind of command line:
> >
> >  $ qemu-system-x86_64 \
> >       -kernel /lib/modules/6.6.9-100.fc38.x86_64/vmlinuz \
> >       -initrd tiny-initrd.img  -m 2000 -serial stdio -nodefaults \
> >       -display none -accel kvm -append "console=ttyS0 quiet"
> >
> >
> > #0  0x0000555555bc14b7 in kvm_is_rapl_feat_enable (cs=cs@entry=0x555557b83470) at ../target/i386/kvm/kvm.c:2531
> > #1  0x0000555555bc7534 in kvm_cpu_realizefn (cs=0x555557b83470, errp=0x7fffffffd2a0) at ../target/i386/kvm/kvm-cpu.c:54
> > #2  0x0000555555d2432a in accel_cpu_common_realize (cpu=0x555557b83470, errp=0x7fffffffd2a0) at ../accel/accel-target.c:130
> > #3  0x0000555555cdd955 in cpu_exec_realizefn (cpu=cpu@entry=0x555557b83470, errp=errp@entry=0x7fffffffd2a0) at ../cpu-target.c:137
> > #4  0x0000555555c14b89 in x86_cpu_realizefn (dev=0x555557b83470, errp=0x7fffffffd310) at ../target/i386/cpu.c:7320
> > #5  0x0000555555d58f4b in device_set_realized (obj=<optimized out>, value=<optimized out>, errp=0x7fffffffd390) at ../hw/core/qdev.c:510
> > #6  0x0000555555d5d78d in property_set_bool (obj=0x555557b83470, v=<optimized out>, name=<optimized out>, opaque=0x5555578558e0, errp=0x7fffffffd390)
> >     at ../qom/object.c:2358
> > #7  0x0000555555d60b0b in object_property_set (obj=obj@entry=0x555557b83470, name=name@entry=0x55555607c799 "realized", v=v@entry=0x555557b8ccb0, errp=0x7fffffffd390, 
> >     errp@entry=0x555556e210d8 <error_fatal>) at ../qom/object.c:1472
> > #8  0x0000555555d6444f in object_property_set_qobject
> >     (obj=obj@entry=0x555557b83470, name=name@entry=0x55555607c799 "realized", value=value@entry=0x555557854800, errp=errp@entry=0x555556e210d8 <error_fatal>)
> >     at ../qom/qom-qobject.c:28
> > #9  0x0000555555d61174 in object_property_set_bool
> >     (obj=0x555557b83470, name=name@entry=0x55555607c799 "realized", value=value@entry=true, errp=errp@entry=0x555556e210d8 <error_fatal>) at ../qom/object.c:1541
> > #10 0x0000555555d59a3c in qdev_realize (dev=<optimized out>, bus=bus@entry=0x0, errp=errp@entry=0x555556e210d8 <error_fatal>) at ../hw/core/qdev.c:292
> > #11 0x0000555555bd51e0 in x86_cpu_new (x86ms=<optimized out>, apic_id=0, errp=0x555556e210d8 <error_fatal>) at ../hw/i386/x86.c:105
> > #12 0x0000555555bd52ce in x86_cpus_init (x86ms=x86ms@entry=0x555557aaed30, default_cpu_version=<optimized out>) at ../hw/i386/x86.c:156
> > #13 0x0000555555bdc1a7 in pc_init1 (machine=0x555557aaed30, pci_type=0x55555604aa61 "i440FX") at ../hw/i386/pc_piix.c:185
> > #14 0x0000555555947a11 in machine_run_board_init (machine=0x555557aaed30, mem_path=<optimized out>, errp=<optimized out>, errp@entry=0x555556e210d8 <error_fatal>)
> >     at ../hw/core/machine.c:1547
> > #15 0x0000555555b020ed in qemu_init_board () at ../system/vl.c:2613
> > #16 qmp_x_exit_preconfig (errp=0x555556e210d8 <error_fatal>) at ../system/vl.c:2705
> > #17 0x0000555555b0611e in qemu_init (argc=<optimized out>, argv=<optimized out>) at ../system/vl.c:3739
> > #18 0x0000555555897ca9 in main (argc=<optimized out>, argv=<optimized out>) at ../system/main.c:47
> >
> > The problem is that 'cs->kvm_state' is NULL here
> >
> 
> After some investigation it seems that kvm_state is not yet committed 
> at this point. Shame, because GDB showed me that we have already pass 
> the kvm_accel_instance_init() in accel/kvm/kvm-all.c that sets the 
> value "msr_energy.enable" in kvm_state...
> 
> So should I dig more to still do the sanity check in kvm_cpu_realizefn() 
> or should I already move the RAPL feature  from -kvm to -cpu 
> like suggested by Zhao from Intel and then access it from the CPUState ?

I'm not so sure about that question. I think Paolo is best placed
to suggest which is better, as the KVM maintainer.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


