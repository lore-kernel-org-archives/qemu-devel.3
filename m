Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998BFCAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 19:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Ott-000177-KP; Thu, 02 Oct 2025 15:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4Otp-00014d-DJ
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:23:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4Otg-0005M9-En
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 15:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759432995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8zmL7FnK8xVSPn9e9KuV+dNmzN/HcX9g/rnok00KEDY=;
 b=A1GDTtL1ZRvEpponau3ZUre7NVeLiNJqNucMEwITeAZn1/vyMfW2cV7y9GXSh5xtaWfQVt
 DWIjw3gzXCrI1t6eoSeSNE1bJLHlx/oFA8RXefsK9zX4a1Jlg8r6GjLHbC94NYZCtJyvZB
 NmMkrC/r8RICvatlIvbl3PVzRV/B+eQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-DbxgB7kQPI6B1kIckN9IsA-1; Thu, 02 Oct 2025 15:23:14 -0400
X-MC-Unique: DbxgB7kQPI6B1kIckN9IsA-1
X-Mimecast-MFC-AGG-ID: DbxgB7kQPI6B1kIckN9IsA_1759432994
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-79538b281cdso26181296d6.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 12:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759432994; x=1760037794;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zmL7FnK8xVSPn9e9KuV+dNmzN/HcX9g/rnok00KEDY=;
 b=rUBE7JDgZJuHIvYy6fTIw7D+IqDjuQPaUztUmLtArx+7KWJoC5Ria6lqGsz3jru7jO
 Ws2dAvdETdEfAP1aE7lNmwldHObNhRqgxiRRreBMf5rb1qG72KKhZNt4Hl00qmJHLfdL
 UAF0NRWmEX1MerjsNLJZNxu4TuXsFTaewW97zokBew1mBALpx7sXYtgCmMxLB9buG4Ig
 1Zjl652rV+VSn06j9BMvyFHpZp+8AbRxVcLqQtun/chOXtBhhCH5QQ79sl2F6Slbdn7U
 CLKQDMN6LlAwAByUtAFfj6OMcfLrXh2aqW720akw6A4dcZAxp5vXzBSSlM4RsYoTb4R9
 dZ3g==
X-Gm-Message-State: AOJu0Yz0pmPlnaaA+OVGAwq58k+8t3K0OKIIgmPDbXy4Di/8LBMbz3Pr
 C935r/uOmQPgvuDhNLOPPBNty1+pYUhzrrC3WJTfP+/nqjb3pOQ88jPlCgjn/9+VoW85dPFcGX6
 YIhPcZ+164elcz+5+XTkoGygT5dciDzXHsBKdjP4IIenQVUwpFUPRxGQa
X-Gm-Gg: ASbGncungTgtUO1WG2kouozl+cnYeMPPbtrtV/iS1kkemRHAG8ztl+R5O7qSLxpJPd/
 685RDYiNJHrRiKF6gvdU1j7dA3wOg4SHnbmsvWMXuCr2XwtPlP2f3h0r8TXaNLAnar2sMCQxzDE
 NdFrrRBrr55kSO0Dqkmm42qhAxR0Q2z8LsV3AkofLqpYmhAinxSpnJPnR+J+6JCOP/CntASSA71
 a4CUmAmmIhdAS/lxu2tXxUY7openNRphoOb33ZfPoQxt6ckx4rKaGOPoNzNXwvf1Hthr2332Col
 jsApR82fqgjM3pd+09zet4w7YXAD8XZZpyFfNQ==
X-Received: by 2002:ad4:4ee6:0:b0:802:67ee:bdae with SMTP id
 6a1803df08f44-878bbf0f5ddmr67693406d6.25.1759432993699; 
 Thu, 02 Oct 2025 12:23:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyKWfBd+Pup6Vg+VGbUOLpZH2LH0jwdcZvKN2Pl9KWvEw+ZfZVbc2/oLREnbxtyjcWlUH8rg==
X-Received: by 2002:ad4:4ee6:0:b0:802:67ee:bdae with SMTP id
 6a1803df08f44-878bbf0f5ddmr67692486d6.25.1759432993008; 
 Thu, 02 Oct 2025 12:23:13 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb446cffsm23871516d6.20.2025.10.02.12.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 12:23:12 -0700 (PDT)
Date: Thu, 2 Oct 2025 15:23:10 -0400
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
Subject: Re: [PATCH 02/14] qdev: Automatically delete memory subregions
Message-ID: <aN7RHvjeQNtrXDcQ@x1.local>
References: <20250917-subregion-v1-0-bef37d9b4f73@rsg.ci.i.u-tokyo.ac.jp>
 <20250917-subregion-v1-2-bef37d9b4f73@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917-subregion-v1-2-bef37d9b4f73@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 17, 2025 at 07:32:48PM +0900, Akihiko Odaki wrote:
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

PS: I'll keep throwing some pure questions here, again, Paolo - it doesn't
need to block merging if you're confident with the general approach.

Said that, a few things I still want to mention after I read this series..

One thing I really feel hard to review such work is, you hardly describe
the problems the series is resolving.

For example, this patch proposed auto-detach MRs in unrealize() for qdev,
however there's nowhere describing "what will start to work, while it
doesn't", "how bad is the problem", etc..  All the rest patches are about
"what we can avoid do" after this patch.

Meanwhile, the cover letter is misleading. It is:

[PATCH 00/14] Fix memory region use-after-finalization

I believe it's simply wrong, because the whole series is not about
finalize() but unrealize().  For Device class, it also includes the exit()
which will be invoked in pci_qdev_unrealize(), but that is also part of the
unrealize() routine, not finalize().

The other question is, what if a MR has a owner that is not the device
itself?  There's no place enforcing this, hence a qdev can logically have
some sub-objects (which may not really be qdev) that can be the owner of
the memory regions.  Then the device emulation will found that some MRs are
auto-detached and some are not.

One example that I'm aware of is this:

https://lore.kernel.org/all/20250910115420.1012191-2-aesteve@redhat.com/#t

TYPE_VIRTIO_SHARED_MEMORY_MAPPING is an object, not qdev here, which can be
the owner of the MR.

Thanks,

-- 
Peter Xu


