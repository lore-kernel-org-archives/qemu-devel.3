Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4FBCA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 21:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwS5Z-0007ni-P1; Wed, 10 Sep 2025 17:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwS5V-0007kN-7Z
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 17:10:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwS5S-0000HU-Dn
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 17:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757538641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rQznIyDnV//Jb0e9NldDJA5X//sUkKCNDoqUK7y/N0s=;
 b=B48xnc0PrsQ3yJPEZR1RWn6wWJIAdFHVp0Q5HMc0ixSH27gyC1VbIypdnfk+UwhF8srZx8
 Zi2VomGCkVy5aZJYRtoBWN4NpxCJpkZzLDvvxH2aXHc18qlXfa3z5TN36ebLjcO0oogfcE
 HNgXckAukKaW3otVhb4p6eHafZjv9oA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-plLb1sshNIO1nzVRhaMVDQ-1; Wed, 10 Sep 2025 17:10:40 -0400
X-MC-Unique: plLb1sshNIO1nzVRhaMVDQ-1
X-Mimecast-MFC-AGG-ID: plLb1sshNIO1nzVRhaMVDQ_1757538640
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-807056330b6so1221785a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 14:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757538640; x=1758143440;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQznIyDnV//Jb0e9NldDJA5X//sUkKCNDoqUK7y/N0s=;
 b=wPwpr4t4aJ9tz8ZDWP39Ilokof3QuBMD9GzPPnykUPCN3AnPRWKJLOkaE2lssSj0uZ
 Zj9AzwveDAEdAYK3zRtWmj9rn7wLr2Ir+yHX1hu3QA//ipWZPri4GTv0gFkAQLHdRQdn
 JaDPHMETBuNnOcSDFPhZsWb7hij+iCrTcy+Hqqo1IrrxEZWLOWJmRd7tYxQLPNzLBXmm
 xhUtTwpdU2TlAX5ZZNfViyIAJRuh5URuGyyooYQezWWEcGyMmD2ImNa+qtoLMQzMROQV
 Bb2gcPAXt7XgjS6NGU4dO5za7B8EBR0iawFVIrMRfPPCONPiShkd2vv+5OWY2LktGHzD
 1qyQ==
X-Gm-Message-State: AOJu0YxWawoMKYNYt6sYVeiq+vRdq7HeOo+uml6AqrsOFj4pPNuNgwni
 2EXxonSG0PdQE7K2VNennvL0pRkX/oreUCFmCz/JWEM3IY50U/Fttwq9FuJ0ddAO6ks7CDUJ0ex
 UVPoY3lE7A9q7fBW4n18n3QPyJfZEFLoKJ4n5/waAW0y+fb+5ElPbTyxw
X-Gm-Gg: ASbGnctAh3BS8RRAIwXnkH+TnC64mw55leIkmKl1L0FcP6m/7R+wQFDtTRR0aIGfUCl
 laV+VWiaUEy4JsdL+Ds6W0n4k4G3T5TY2V4KkKCkV4c3QpPAbrG7a+h9ZtukC03PzRkiXZx9a7i
 rVFn9ZAQpCiNyiZftV55ihEYJam2TvQq33my6RXhIta0WOvYvrwAQ4xR4Us1w4B4RGJS8rn9YOM
 DHZpuuZ+5cQIK6ZG/UO3zWsL0ysD2q9URU+cLiwJug3hPHcp6EWRrUImL6+NNR0JvF7oI8LjkPP
 bNvk/oRUnT+Z7z3jqz9XAvrTtybhazgp
X-Received: by 2002:a05:620a:711c:b0:7e9:f81f:cead with SMTP id
 af79cd13be357-813c39a0e8emr1937462185a.71.1757538639605; 
 Wed, 10 Sep 2025 14:10:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjxIiwzkLtv/PGkZE39cjtfP7VsfEx2JZunKOfe2bOzkMboSF+ZO6a9fCvI//M3W72Wrc4zQ==
X-Received: by 2002:a05:620a:711c:b0:7e9:f81f:cead with SMTP id
 af79cd13be357-813c39a0e8emr1937454985a.71.1757538638947; 
 Wed, 10 Sep 2025 14:10:38 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-81b5f8fff60sm350442285a.60.2025.09.10.14.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 14:10:38 -0700 (PDT)
Date: Wed, 10 Sep 2025 17:10:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: Re: [PATCH 10/22] qdev: Automatically delete memory subregions
Message-ID: <aMHpQbx1z_p6bC3E@x1.local>
References: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
 <20250906-use-v1-10-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906-use-v1-10-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Sat, Sep 06, 2025 at 04:11:19AM +0200, Akihiko Odaki wrote:
> A common pattern is that to delete memory subregions during realization
> error handling and unrealization. pci automatically automatically
> deletes the IO subregions, but the pattern is manually implemented
> in other places, which is tedious and error-prone.

I don't think they're the same?  What is the ultimate goal of this change?

PCI core only detachs all the BARs from the address space registered from
pci_register_bar() explicitly.  It's not an object_dynamic_cast() detaching
every MR not matter what it is..

The other thing it does is detaching the DMA root memory region.

I'm not fluent with pci, but IMHO it's good to keep those explicit.

> 
> Implement the logic to delete subregions in qdev to cover all devices.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  MAINTAINERS            |  1 +
>  include/hw/qdev-core.h |  1 +
>  hw/core/qdev.c         | 14 ++++++++++++++
>  stubs/memory.c         |  9 +++++++++
>  stubs/meson.build      |  1 +
>  5 files changed, 26 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8147fff3523eaa45c4a0d2c21d40b4ade3f419ff..4665f0a4b7a513c5863f6d5227a0173c836505e6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3212,6 +3212,7 @@ F: include/system/memory.h
>  F: include/system/ram_addr.h
>  F: include/system/ramblock.h
>  F: include/system/memory_mapping.h
> +F: stubs/memory.c
>  F: system/dma-helpers.c
>  F: system/ioport.c
>  F: system/memory.c
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 530f3da70218df59da72dc7a975dca8265600e00..8f443d5f8ea5f31d69181cc1ec53a0b022eb71cc 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -526,6 +526,7 @@ bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
>   *  - unrealize any child buses by calling qbus_unrealize()
>   *    (this will recursively unrealize any devices on those buses)
>   *  - call the unrealize method of @dev
> + *  - remove @dev from memory
>   *
>   * The device can then be freed by causing its reference count to go
>   * to zero.
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index f600226176871361d7ff3875f5d06bd4e614be6e..8fdf6774f87ec8424348e8c9652dc4c99a2faeb5 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -451,6 +451,17 @@ static bool check_only_migratable(Object *obj, Error **errp)
>      return true;
>  }
>  
> +static int del_memory_region(Object *child, void *opaque)
> +{
> +    MemoryRegion *mr = (MemoryRegion *)object_dynamic_cast(child, TYPE_MEMORY_REGION);
> +
> +    if (mr && mr->container) {
> +        memory_region_del_subregion(mr->container, mr);
> +    }
> +
> +    return 0;
> +}
> +
>  static void device_set_realized(Object *obj, bool value, Error **errp)
>  {
>      DeviceState *dev = DEVICE(obj);
> @@ -582,6 +593,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>          if (dc->unrealize) {
>              dc->unrealize(dev);
>          }
> +        object_child_foreach(OBJECT(dev), del_memory_region, NULL);
>          dev->pending_deleted_event = true;
>          DEVICE_LISTENER_CALL(unrealize, Reverse, dev);
>      }
> @@ -606,6 +618,8 @@ post_realize_fail:
>      }
>  
>  fail:
> +    object_child_foreach(OBJECT(dev), del_memory_region, NULL);
> +
>      error_propagate(errp, local_err);
>      if (unattached_parent) {
>          /*
> diff --git a/stubs/memory.c b/stubs/memory.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..9c36531ae542d804dc19ed2a3c657005881a2bca
> --- /dev/null
> +++ b/stubs/memory.c
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "qemu/osdep.h"
> +#include "system/memory.h"
> +
> +void memory_region_del_subregion(MemoryRegion *mr,
> +                                 MemoryRegion *subregion)
> +{
> +}
> diff --git a/stubs/meson.build b/stubs/meson.build
> index cef046e6854ddaa9f12714c317a541ea75b8d412..b4df4e60a1af89c9354d5b92449ce5409095b9f1 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -95,5 +95,6 @@ if have_system or have_user
>  
>    # Also included in have_system for tests/unit/test-qdev-global-props
>    stub_ss.add(files('hotplug-stubs.c'))
> +  stub_ss.add(files('memory.c'))
>    stub_ss.add(files('sysbus.c'))
>  endif
> 
> -- 
> 2.51.0
> 

-- 
Peter Xu


