Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C64CA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 20:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwRde-0000OH-Jn; Wed, 10 Sep 2025 16:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwRdM-0000Lq-Mz
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 16:41:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwRdI-0004iP-7j
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 16:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757536893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OCKbOirbVrKVDU+z6BSpCwDxGXapoQx4nld5kaFsIss=;
 b=TMzZSrtdqIzg/NuDgmqC5eKWZlx8AO+nMB26WU5z8zVM93Ei4JlEqSSxcruT3SCLdBQC7x
 vIbEiFLelDk/yA3Y0glfgUB7imjTfd1QFXRzo+9LTb8Xf/14qN26MhcPUvVAW7tldGHrBF
 93EQZeGLj4IJDZiqT29W8KgIfBKQKkM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-bwtbl0ePNsekx9V8W-L39g-1; Wed, 10 Sep 2025 16:41:30 -0400
X-MC-Unique: bwtbl0ePNsekx9V8W-L39g-1
X-Mimecast-MFC-AGG-ID: bwtbl0ePNsekx9V8W-L39g_1757536890
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-729751964dcso138707096d6.3
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 13:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757536889; x=1758141689;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OCKbOirbVrKVDU+z6BSpCwDxGXapoQx4nld5kaFsIss=;
 b=mTjyGfle5jkrewm4VmLuhCBS7DVuQ5HqWvkrLApBbQp8X21CBULF9Sa85HMC2RXkjz
 69jVim/8im0h65zTz+/tRQUiyMvUoRlw+iVu3mQWm50W2iRP1g6EqK61QN9igZ6nTbk+
 3a61O64P7NNNxU0ZIEnC2UuU/lWJavpKBw8DbRzMlBWl9nW14r/W5eHyBqVJPle+SZot
 KzQnUy+YzeDq/qmL0F1nQWeEVbQ3EiTYuEh+7SIe/8MMvqxEBkxqKgWao5q65gaYpEyB
 8YqmCH/0fyKmO2UYtmZeiQsv/J7AQcgpKdsb/E5LEVqlsfvAZy+QmXVGDAwpFs1wlM4u
 dJcg==
X-Gm-Message-State: AOJu0YxLqvEpuSD/aodj7DJ98TXNdNYBC1ZkofcfM+2dIZlsQSakjxw/
 ntJrztQv0gd4+ljypebrWeG5tgToRgM7MYF57j/gHvXcRkWhlu8fOOiu+bBUyW6BeVb515b3PWV
 yEI9pZffOZNKHl/EJ0rl+vBo7u0+52tLjsC6nXyKM1/1wn4RNdnAHnAGp
X-Gm-Gg: ASbGncu1giglstQXDr096tw0X0OmqYvQq5AFABqgoxlC3UzP34viuee1krAMRo6bN6J
 KZDCUKp5CwDjTrzdK7EaGKtH/KClsK6eyc9oMb4QgFjv5v61t3CGVoZIVjhUWERVNF4HoY18y/Z
 JIdbtkEDDWaB2i5yjI7tXMBWy4ehpOeWEYRDSbI+XT55u3MNtuuAkEalNc6jK01P8mfQ3VTDSfP
 yIi68d6WZ1uXBHwVdjp3fKWfVwx7r6weBsXTAwGgZ6vTtN7pMoxXL9cbVmHbljxOPxEcuHlrPhe
 /s18eI/HGGQkKla6pRM782Tv8AY1DwaoAVQoWqtrvdNXxn48c8OuYvUJ34PICf46IEWm9pMprMP
 +QQcLDBcNmKhW6YxuvkVzrw==
X-Received: by 2002:a05:6214:d07:b0:707:4c0c:5316 with SMTP id
 6a1803df08f44-73941ddea1dmr171126276d6.46.1757536889083; 
 Wed, 10 Sep 2025 13:41:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe/IkFiQt9C9KhGHb7hz6KcXjfZiTut/VdPL+VsKfHTc1bn7a38hLgBuABC3OgPvBxBjk55w==
X-Received: by 2002:a05:6214:d07:b0:707:4c0c:5316 with SMTP id
 6a1803df08f44-73941ddea1dmr171125886d6.46.1757536888457; 
 Wed, 10 Sep 2025 13:41:28 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-762c70e0982sm1655016d6.50.2025.09.10.13.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 13:41:27 -0700 (PDT)
Date: Wed, 10 Sep 2025 16:41:24 -0400
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
Subject: Re: [PATCH 02/22] vfio/pci: Do not unparent in instance_finalize()
Message-ID: <aMHidDl1tdx-2G4e@x1.local>
References: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
 <20250906-use-v1-2-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906-use-v1-2-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, Sep 06, 2025 at 04:11:11AM +0200, Akihiko Odaki wrote:
> Children are automatically unparented so manually unparenting is
> unnecessary.
> 
> Worse, automatic unparenting happens before the insntance_finalize()
> callback of the parent gets called, so object_unparent() calls in
> the callback will refer to objects that are already unparented, which
> is semantically incorrect.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  hw/vfio/pci.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 07257d0fa049b09fc296ac2279a6fafbdf93d277..2e909c190f86a722e1022fa7c45a96d2dde8d58e 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2000,7 +2000,6 @@ static void vfio_bars_finalize(VFIOPCIDevice *vdev)
>          vfio_region_finalize(&bar->region);
>          if (bar->mr) {
>              assert(bar->size);
> -            object_unparent(OBJECT(bar->mr));
>              g_free(bar->mr);
>              bar->mr = NULL;
>          }
> @@ -2008,9 +2007,6 @@ static void vfio_bars_finalize(VFIOPCIDevice *vdev)
>  
>      if (vdev->vga) {
>          vfio_vga_quirk_finalize(vdev);
> -        for (i = 0; i < ARRAY_SIZE(vdev->vga->region); i++) {
> -            object_unparent(OBJECT(&vdev->vga->region[i].mem));
> -        }
>          g_free(vdev->vga);
>      }
>  }

So the 2nd object_unparent() here should be no-op, seeing empty list of
properties (but shouldn't causing anything severe), is that correct?

I think it still makes some sense to theoretically allow object_unparent()
to happen, at least when it happens before owner's finalize().  IIUC that
was the intention of the doc, pairing the memory_region_init*() operation.

It might depend on two use cases:

1. MRs dynamically created, it'll share the same lifecycle of the owner
   after creation (just like an embeded MemoryRegion)

   I feel like most, if not all, VFIO's dynamic mrs follows this trend,
   that this patch touched.

   In this case, IMHO instead of object_unparent(), we could also allow the
   owner / device to take ownership of the MR completely, by replacing:

       mr = g_new0(MemoryRegion, 1);

   with:

       mr = object_new(TYPE_MEMORY_REGION);

   Then after memory_region_init*(), essentially the owner will be in
   charge of the memory, as it'll be g_free()ed when remove the mr from
   property list (in owner's finalize() automatically).

   With that, the device impl can not only avoid object_unparent(), but
   avoid g_free() altogether.  That would make some more sense to me,
   instead of relying on memory internal to unparent, and rely on device
   impl to g_free().

2. MRs dynamically created, and it may be freed even before the owner
   finishes its lifecycle

   This is the case that I _think_ an object_unparent() should still be
   allowed, because when the mr is unparented (aka, not used), we should
   still provide a way for the device impl to detach and free the mr
   resources on the fly.

There're a bunch of object_unparent() users, I didn't check whether there's
any real user of case (2), though.

AFAIU for such case maybe it's always better to provide real refcounting
for the mr, since the mr can always be address_space_map()ed.. with an
elevated refcount. In that case, the owner shouldn't be the device impl,
but a temp obj that represents the mr (and do refcounts).

Thanks,

-- 
Peter Xu


