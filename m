Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB86BCA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 11:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwIow-00066G-Ag; Wed, 10 Sep 2025 07:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uwIof-00064Z-9r
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 07:16:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uwIoc-0004S6-Ba
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 07:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757502998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+RQ5XzHHcQuwp4aEgjLkGM+ABNJeg1C1geu9oakglMU=;
 b=TryWQqaNowXI//VKaMwO4MXkxRdU1p4G3F27PBe6z2evP1mAhpEKCnkZZS7cODgPeP23uN
 gdVtvkMWdXXJVoLWeB16TA/2MknRHr+fRmnaEEq7Tx9mpQJCnwq641JbXZmI8isMSDqxyp
 5lDD45Oa1MPp1me+Uf2yYCXA7Q5NlBM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-uM7TiwoCMhyoEnwoSxcNdQ-1; Wed, 10 Sep 2025 07:16:37 -0400
X-MC-Unique: uM7TiwoCMhyoEnwoSxcNdQ-1
X-Mimecast-MFC-AGG-ID: uM7TiwoCMhyoEnwoSxcNdQ_1757502996
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3df2f4aedd1so4789199f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 04:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757502996; x=1758107796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+RQ5XzHHcQuwp4aEgjLkGM+ABNJeg1C1geu9oakglMU=;
 b=sYOzJ38UqVdSIjTAGg9cdUGKxtu6htuPTJG/W6zk3uC2CnrzXN4R7rE6W+Umm8XEwk
 eD8t1cbOUY/OJlhhA6CH+3rcan3t7dY6PuC+Uzx6js9e9xliduUMXurC6bJvPuzbXjqQ
 pe/ZNkahKjmiyOocP/6Kwk8AsMZizgN4xHNgjr0sN6uaTr4GSMU7VNQERSNLblc6bHOX
 fC+0P24cDMpkkX4dPNffV4coDhHOsmHdVG89Cv6BxLMejbhi7dBjw+nTUnKnJ/QuN77H
 PQegHYzRNzmFu0qR5WU4icOYiQ+PmxL+2KZNhMNj5NOQgdBBzeTr8MK/WDNelPzIuaer
 gFVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPDuDpkbKjvP0IZ3Jb1NryjU+Ozf5wH7Yy8XUJUGET/9okdXDVMMO5TTdCQe5s6639IG7I7W4Zzr1o@nongnu.org
X-Gm-Message-State: AOJu0YyrxQ91BjITgHfFpi+RoNVnIUANEWIrZO7z4jOqtOny7ovGtrDP
 vldlhUzZRW5AInuNPhHNjtXNFW0Tvgshtx0BShYmb+1QIqgCMyQS+LI3WW1rQQd79Wh4m0//PUh
 gh1jXRxb1mTF1oU7KI4PmZ4XrL6HnTHOSlGFHmaNGVYTGgzpaZ4jIIAj3
X-Gm-Gg: ASbGncsNr+BNZQZRIrbusIt4sZ6htgwtITzdP/ljSYCc7cHXUk6Wf1yJ4yU7KZ3udQB
 6Cic+RF4bayjGKEtLQRJupqsTm7dy0uo12WrZE92Q7NDSZo5tHv4c7QBMhKKFGM//3t5FlJ6tQv
 B4rfooiGswduUrxzMQmt955VLZ3MQGYDOvR/jFCF9nEXo1k/sib0ifpi1P2LiMSLKmRZezXx7b1
 daeF+n0Wkk+Hvy520PJNqgZrPeJGbAoidXDXzhRobHw1lLepwpLJiUFdP8/PCX+6l//48ljVkrw
 6iMktqZw++w1AczTCk1bCfQcdd6qzw==
X-Received: by 2002:a05:6000:2203:b0:3d2:208c:45aa with SMTP id
 ffacd0b85a97d-3e64b82d62bmr11932733f8f.29.1757502995659; 
 Wed, 10 Sep 2025 04:16:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTZrWuWj25a7xVx+57CnuJMMNNCoRtLpPdqfii3mpTbwzqKnzbFLU5+JzxkMCIcW6F3dzK8w==
X-Received: by 2002:a05:6000:2203:b0:3d2:208c:45aa with SMTP id
 ffacd0b85a97d-3e64b82d62bmr11932711f8f.29.1757502995096; 
 Wed, 10 Sep 2025 04:16:35 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45df16435b4sm28084385e9.5.2025.09.10.04.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 04:16:34 -0700 (PDT)
Date: Wed, 10 Sep 2025 13:16:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Peter Xu
 <peterx@redhat.com>
Subject: Re: [PULL 24/28] hpet: switch to fine-grained device locking
Message-ID: <20250910131633.4b66856d@fedora>
In-Reply-To: <aL7oe3sis3bKJhLW@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
 <20250829125935.1526984-25-pbonzini@redhat.com>
 <aL7oe3sis3bKJhLW@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 8 Sep 2025 15:30:19 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> Hi,
>=20
> This patches causes a regression making QEMU  abort in the KVM Xen
> functional test.
>=20
> To reproduce please run 'make check-functional-x86_64', or more
> specifically run this single test:
>=20
>  QEMU_TEST_QEMU_BINARY=3D./build/qemu-system-x86_64 PYTHONPATH=3D./python=
:./tests/functional ./tests/functional/x86_64/test_kvm_xen.py
>=20
> though I recommend you first add this series:
>=20
>   https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg01540.html
>=20
> as that fixes an infinite loop in the functional test console
> code on QEMU abnormal premature exit.

I'll try to reproduce and see where it goes wrong

>=20
> In the test logs we see the following on the serial console:
>=20
>   2025-09-08 15:26:32,286: Cannot get hvm parameter CONSOLE_EVTCHN (18): =
-22!
>=20
> and then the following on stder:
>=20
>   qemu-system-x86_64: ../hw/i386/kvm/xen_evtchn.c:1619: xen_evtchn_set_gs=
i: Assertion `bql_locked()' failed.
>=20
> The QEMU command line was:
>=20
>   2025-09-08 15:26:32,097 - DEBUG: VM launch command: './build/qemu-syste=
m-x86_64 -display none -vga none -chardev socket,id=3Dmon,fd=3D5 -mon chard=
ev=3Dmon,mode=3Dcontrol -chardev socket,id=3Dconsole,fd=3D10 -serial charde=
v:console -accel kvm,xen-version=3D0x4000a,kernel-irqchip=3Dsplit -smp 2 -k=
ernel /var/home/berrange/.cache/qemu/download/ec0ad7bb8c33c5982baee0a75505f=
e7dbf29d3ff5d44258204d6307c6fe0132a -append "printk.time=3D0 root=3D/dev/xv=
da console=3DttyS0 quiet xen_emul_unplug=3Dide-disks" -drive file=3D/var/ho=
me/berrange/.cache/qemu/download/b11045d649006c649c184e93339aaa41a8fe20a1a8=
6620af70323252eb29e40b,if=3Dnone,snapshot=3Don,format=3Draw,id=3Ddrv0 -devi=
ce xen-disk,drive=3Ddrv0,vdev=3Dxvda -device virtio-net-pci,netdev=3Dunet -=
netdev user,id=3Dunet,hostfwd=3D:127.0.0.1:0-:22'
>=20
> On Fri, Aug 29, 2025 at 02:59:31PM +0200, Paolo Bonzini wrote:
> > From: Igor Mammedov <imammedo@redhat.com>
> >=20
> > as a step towards lock-less HPET counter read,
> > use per device locking instead of BQL.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Link: https://lore.kernel.org/r/20250814160600.2327672-4-imammedo@redha=
t.com
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  hw/timer/hpet.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> > index cb48cc151f1..ab5aa59ae4e 100644
> > --- a/hw/timer/hpet.c
> > +++ b/hw/timer/hpet.c
> > @@ -38,6 +38,7 @@
> >  #include "hw/timer/i8254.h"
> >  #include "system/address-spaces.h"
> >  #include "qom/object.h"
> > +#include "qemu/lockable.h"
> >  #include "trace.h"
> > =20
> >  struct hpet_fw_config hpet_fw_cfg =3D {.count =3D UINT8_MAX};
> > @@ -69,6 +70,7 @@ struct HPETState {
> >      SysBusDevice parent_obj;
> >      /*< public >*/
> > =20
> > +    QemuMutex lock;
> >      MemoryRegion iomem;
> >      uint64_t hpet_offset;
> >      bool hpet_offset_saved;
> > @@ -428,6 +430,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr =
addr,
> >      trace_hpet_ram_read(addr);
> >      addr &=3D ~4;
> > =20
> > +    QEMU_LOCK_GUARD(&s->lock);
> >      /*address range of all global regs*/
> >      if (addr <=3D 0xff) {
> >          switch (addr) {
> > @@ -482,6 +485,7 @@ static void hpet_ram_write(void *opaque, hwaddr add=
r,
> >      int len =3D MIN(size * 8, 64 - shift);
> >      uint64_t old_val, new_val, cleared;
> > =20
> > +    QEMU_LOCK_GUARD(&s->lock);
> >      trace_hpet_ram_write(addr, value);
> >      addr &=3D ~4;
> > =20
> > @@ -679,8 +683,10 @@ static void hpet_init(Object *obj)
> >      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> >      HPETState *s =3D HPET(obj);
> > =20
> > +    qemu_mutex_init(&s->lock);
> >      /* HPET Area */
> >      memory_region_init_io(&s->iomem, obj, &hpet_ram_ops, s, "hpet", HP=
ET_LEN);
> > +    memory_region_enable_lockless_io(&s->iomem);
> >      sysbus_init_mmio(sbd, &s->iomem);
> >  }
> > =20
> > --=20
> > 2.51.0
> >=20
> >  =20
>=20
> With regards,
> Daniel


