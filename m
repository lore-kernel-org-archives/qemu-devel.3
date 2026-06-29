Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EEDC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCAQ-0000Aq-JM; Mon, 29 Jun 2026 09:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1weCAO-0000AM-Rl
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:36:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1weCAN-0003Tm-6H
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782740209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dYTTV9TjkG/+IdI3+8N4Jcda4sBwtPZ3h/J56YePBFI=;
 b=PbULOoDmui3usSWpJGgIXob4QFcwhzShXOpf2RTpwHEEf7CZqFFD3xpj0t96kpd95+9EEH
 SBmn8efTLLsjUBAnXvLjkO7PufC/ms5bZuXuIBdgP0vpEtxL95znvXgfcU2rJc+8YosXRv
 RAKjRi37c9NCtlS/n3DEbZbjJkQxnZ0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-Zzya0iSPNk6rVt_TMh5vQw-1; Mon, 29 Jun 2026 09:36:48 -0400
X-MC-Unique: Zzya0iSPNk6rVt_TMh5vQw-1
X-Mimecast-MFC-AGG-ID: Zzya0iSPNk6rVt_TMh5vQw_1782740206
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49244130073so28298195e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782740206; x=1783345006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dYTTV9TjkG/+IdI3+8N4Jcda4sBwtPZ3h/J56YePBFI=;
 b=iCTRHAv8Cdt5o8jOUczj3ik17ZuI43J3QB+dbaiEoFyticn9Y8R94rJgtEvPbN+is+
 +fgG4lyyoGD8lOQlkgswTQsPk/d3/2kZzOVWfonVUwTgeyhrxG19hy7EfVyl2t1PdMmc
 /DnDblSl2g+y2BO2EVDpHn5JOfcb1atYpSOQjyJyoRgVv4rlCDznVt561xJt8s7arS5R
 ZyFqo5zlsc0AnT14bJOqaL4597URvRT16Yb+FGsTxcsuW1EhxAM7IkSGyhwi0K8XVksd
 GC93P3wCEizIrK7AmnWi/smkg6wjJn1yUhNY3bZ/rndKe+dK4Sso6afPoCBQ6uj77kSH
 XBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740206; x=1783345006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dYTTV9TjkG/+IdI3+8N4Jcda4sBwtPZ3h/J56YePBFI=;
 b=jgNaayOfNvfmMwkwiy7O/oFX6AzXtdTYGumBTsZYnI53GThwIXh5UphqC0mECS+aQ2
 ClsLJcxfqmjcpSb/ay+e8G6T8IRmsl0ximV1eSrwVRk/Q7Jm9ayStGo6799JPAr8IxjP
 tHjSkPEqdl6CzlGphlKRnZrHmno+mT9V8YwwdTmAFPzhfeKNXn/8TPdi88AVLTsBTyAp
 pFl1+bRjjCE6Lwgef15mFe/QhHyG+YM35YCBR/pZak2ROF5aobqktAr0y3cgvdi2Hk9p
 Jz6yznEm1A6enADV5d5ZC4JxH/0FGJVs6BLaDJV97+OPZtq7U9ZbWNpkSYs6e5csRvaf
 tuIA==
X-Gm-Message-State: AOJu0YwGEyxdRa1VANwSpnG53jZ6k7Gb7XGbyvWzIoU6oyvH540Uxtnm
 E9lkCwyDV+4LnK4APu6SkQuN8dF22nEfZVGqV4ZPNFujuaU+5b3OL458nr23pezRtghsLoYoYFS
 cbi6wHYy8C8B19nlWBSVgA1e+iEcZ+YZmn5PFU5Pbq/N37vI1JbkOC/RR
X-Gm-Gg: AfdE7ckoIJteSb8jhGrT96h1MDdqiRaenoF2BYolk8pblMQZOkoAlic3bG4n3YbiW+9
 NtUHD2lf8MIv7l/yemCOwDpp5m2lKGCrxQWvpK4tZ2ouJUhou8BRkOXw1ZoJcWqjqChJVw0w5d+
 31mBZSrfP+uEi0FGQX3EoXrghoKtcChF3jqjxGm9NGPh8aODqtxWcBtEYN9gJVzTo9lKl4MFifs
 1OeNo7CXIqxVQtQRJ2RLHFEnoWo+KMT5gI1UGLgE/S9bki1mTqN0MgeHh/znLADi9wcrdXA5T5Y
 1C2giNdObqy8xfba/FDRg0cRvEFygWAeEc/FSqvWMi4lqZJZooztxW2s73W+1bcpyC6gjX8=
X-Received: by 2002:a05:600c:c83:b0:490:e196:eaee with SMTP id
 5b1f17b1804b1-493b7197579mr13933125e9.10.1782740205821; 
 Mon, 29 Jun 2026 06:36:45 -0700 (PDT)
X-Received: by 2002:a05:600c:c83:b0:490:e196:eaee with SMTP id
 5b1f17b1804b1-493b7197579mr13932545e9.10.1782740205326; 
 Mon, 29 Jun 2026 06:36:45 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-472bca3caccsm15345909f8f.33.2026.06.29.06.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:36:44 -0700 (PDT)
Date: Mon, 29 Jun 2026 15:36:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eauger@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v3 04/17] arm: virt: create sbsa-gwdt watchdog
Message-ID: <20260629153642.14ce960e@imammedo>
In-Reply-To: <db203d86-7280-4210-8640-e94c9f11f9da@redhat.com>
References: <20260624102830.1355552-1-imammedo@redhat.com>
 <20260624102830.1355552-5-imammedo@redhat.com>
 <db203d86-7280-4210-8640-e94c9f11f9da@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 29 Jun 2026 10:37:59 +0200
Eric Auger <eauger@redhat.com> wrote:

> Hi Igor,
> 
> On 6/24/26 12:28 PM, Igor Mammedov wrote:
> > Allow to use SBSA generic watchdog with virt machine type.
> > (includes conditional generation of corresponding FDT and
> > ACPI GTDT descriptors)
> > 
> > Use '-device sbsa-gwdt' to command line to enable it.
> > 
> > Instead of using dynamic sysbus infra to wire up MMIO/IRQ/FDT,
> > statically assign resources in machine's mem/irq maps and wire
> > them up at device (pre_)plug handlers. It's similar to dynamic
> > sysbus wiring, modulo resources are nailed down statically,
> > and wiring is limited to virt machine only.
> > (Benefit is that tests don't break anymore on rebase due to
> > address being stable)
> > 
> > Tested with Fedora 43:
> >   FDT: -M virt,acpi=off -device sbsa-gwdt
> >   ACPI: -M virt -device sbsa-gwdt
> > 
> > Note:
> > Windows sees GTDT, initializes watchdog but instead pinging WRR
> > it sets/advances WOR to way too large value, so it's never going
> > to trigger watchdog reboot (it's Windows driver issue though).
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > v3:
> >   - (Eric) assign MMIO/IRQ statically and abandon most of
> >      dynamic sysbus machinery.
> >   - (Peter) set watchdog freq to system clock explicitly,
> >     machine version compat won't work in case host is not runing
> >     1GHz clock. (Tested on Jetson machine)
> > ---
> >  include/hw/arm/virt.h    |  3 +++
> >  hw/arm/Kconfig           |  1 +
> >  hw/arm/virt-acpi-build.c | 29 +++++++++++++++++++++++++++--
> >  hw/arm/virt.c            | 37 +++++++++++++++++++++++++++++++++++++
> >  hw/core/sysbus-fdt.c     |  2 ++
> >  hw/watchdog/sbsa_gwdt.c  |  1 +
> >  6 files changed, 71 insertions(+), 2 deletions(-)
> > 
[...]
> > @@ -3820,6 +3824,10 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> >          qlist_append_str(reserved_regions, resv_prop_str);
> >          qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
> >          g_free(resv_prop_str);
> > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_WDT_SBSA)) {
> > +        uint64_t cntfrq = object_property_get_int(OBJECT(qemu_get_cpu(0)),
> > +                                                  "cntfrq", &error_abort);  
> missing extra line.
> > +        qdev_prop_set_uint64(dev, "clock-frequency", cntfrq);  
> 
> Can you explain why you cannot do that in virt_machine_device_plug_cb()?

sure,
all prep work, typically is done at pre_plug time. (it's stage we are allowed to fail)

While at plug time we typically do final (post realize) wiring/exposing model to guest
(no allowed to fail (I need to do cleanup and remove errp from all plug handlers
but that is orthogonal to series))

> >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3)) {
> >          if (vms->legacy_smmuv3_present || vms->iommu == VIRT_IOMMU_VIRTIO) {
> >              error_setg(errp, "virt machine already has %s set. "
[...]

> > diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
> > index acb970e8b3..c4dd8005b7 100644
> > --- a/hw/watchdog/sbsa_gwdt.c
> > +++ b/hw/watchdog/sbsa_gwdt.c
> > @@ -285,6 +285,7 @@ static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, const void *data)
> >      dc->realize = wdt_sbsa_gwdt_realize;
> >      device_class_set_legacy_reset(dc, wdt_sbsa_gwdt_reset);
> >      dc->hotpluggable = false;
> > +    dc->user_creatable = true;
> >      set_bit(DEVICE_CATEGORY_WATCHDOG, dc->categories);
> >      dc->vmsd = &vmstate_sbsa_gwdt;
> >      dc->desc = "SBSA-compliant generic watchdog device";  
> You may document somewhere that the device can be dynamically
> instantiated, in machvirt alone and this required machine specific
> hardwiring.

Any suggestion wrt where to put it? 

> 
> Thanks
> 
> Eric
> 


