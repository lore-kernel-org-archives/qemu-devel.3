Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4CFCA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 14:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvctX-000280-27; Mon, 08 Sep 2025 10:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvctS-00026l-E1
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:30:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvctC-0002Wv-Hc
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757341827;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=llpvceQl/WeQu9WHN+bpq9FjG/NNmjKhW6KVEYxrIsI=;
 b=Eo0Jh14FcF+JCFsRyi+rkGpSuLdGhr9NQ8Z6CkTLtVuA8F6UDr8iWAbNGNP6d20ccjZK2S
 KdoeoRXT4BIA61v0KJsck93Bp2Hm+YiCBmQpwt59XCaj3tQzTsQScmvyCk/2rbmkBPc+Ag
 L/o/iwlNOhSuolWszim04UKERZr8Fdk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-5qhixWmwO2KPrn9sthQZwQ-1; Mon,
 08 Sep 2025 10:30:26 -0400
X-MC-Unique: 5qhixWmwO2KPrn9sthQZwQ-1
X-Mimecast-MFC-AGG-ID: 5qhixWmwO2KPrn9sthQZwQ_1757341825
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57CBD1800366
 for <qemu-devel@nongnu.org>; Mon,  8 Sep 2025 14:30:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4DF01800446; Mon,  8 Sep 2025 14:30:22 +0000 (UTC)
Date: Mon, 8 Sep 2025 15:30:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 24/28] hpet: switch to fine-grained device locking
Message-ID: <aL7oe3sis3bKJhLW@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
 <20250829125935.1526984-25-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829125935.1526984-25-pbonzini@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi,

This patches causes a regression making QEMU  abort in the KVM Xen
functional test.

To reproduce please run 'make check-functional-x86_64', or more
specifically run this single test:

 QEMU_TEST_QEMU_BINARY=./build/qemu-system-x86_64 PYTHONPATH=./python:./tests/functional ./tests/functional/x86_64/test_kvm_xen.py

though I recommend you first add this series:

  https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg01540.html

as that fixes an infinite loop in the functional test console
code on QEMU abnormal premature exit.

In the test logs we see the following on the serial console:

  2025-09-08 15:26:32,286: Cannot get hvm parameter CONSOLE_EVTCHN (18): -22!

and then the following on stder:

  qemu-system-x86_64: ../hw/i386/kvm/xen_evtchn.c:1619: xen_evtchn_set_gsi: Assertion `bql_locked()' failed.

The QEMU command line was:

  2025-09-08 15:26:32,097 - DEBUG: VM launch command: './build/qemu-system-x86_64 -display none -vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control -chardev socket,id=console,fd=10 -serial chardev:console -accel kvm,xen-version=0x4000a,kernel-irqchip=split -smp 2 -kernel /var/home/berrange/.cache/qemu/download/ec0ad7bb8c33c5982baee0a75505fe7dbf29d3ff5d44258204d6307c6fe0132a -append "printk.time=0 root=/dev/xvda console=ttyS0 quiet xen_emul_unplug=ide-disks" -drive file=/var/home/berrange/.cache/qemu/download/b11045d649006c649c184e93339aaa41a8fe20a1a86620af70323252eb29e40b,if=none,snapshot=on,format=raw,id=drv0 -device xen-disk,drive=drv0,vdev=xvda -device virtio-net-pci,netdev=unet -netdev user,id=unet,hostfwd=:127.0.0.1:0-:22'

On Fri, Aug 29, 2025 at 02:59:31PM +0200, Paolo Bonzini wrote:
> From: Igor Mammedov <imammedo@redhat.com>
> 
> as a step towards lock-less HPET counter read,
> use per device locking instead of BQL.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Link: https://lore.kernel.org/r/20250814160600.2327672-4-imammedo@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/timer/hpet.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index cb48cc151f1..ab5aa59ae4e 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -38,6 +38,7 @@
>  #include "hw/timer/i8254.h"
>  #include "system/address-spaces.h"
>  #include "qom/object.h"
> +#include "qemu/lockable.h"
>  #include "trace.h"
>  
>  struct hpet_fw_config hpet_fw_cfg = {.count = UINT8_MAX};
> @@ -69,6 +70,7 @@ struct HPETState {
>      SysBusDevice parent_obj;
>      /*< public >*/
>  
> +    QemuMutex lock;
>      MemoryRegion iomem;
>      uint64_t hpet_offset;
>      bool hpet_offset_saved;
> @@ -428,6 +430,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
>      trace_hpet_ram_read(addr);
>      addr &= ~4;
>  
> +    QEMU_LOCK_GUARD(&s->lock);
>      /*address range of all global regs*/
>      if (addr <= 0xff) {
>          switch (addr) {
> @@ -482,6 +485,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>      int len = MIN(size * 8, 64 - shift);
>      uint64_t old_val, new_val, cleared;
>  
> +    QEMU_LOCK_GUARD(&s->lock);
>      trace_hpet_ram_write(addr, value);
>      addr &= ~4;
>  
> @@ -679,8 +683,10 @@ static void hpet_init(Object *obj)
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>      HPETState *s = HPET(obj);
>  
> +    qemu_mutex_init(&s->lock);
>      /* HPET Area */
>      memory_region_init_io(&s->iomem, obj, &hpet_ram_ops, s, "hpet", HPET_LEN);
> +    memory_region_enable_lockless_io(&s->iomem);
>      sysbus_init_mmio(sbd, &s->iomem);
>  }
>  
> -- 
> 2.51.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


