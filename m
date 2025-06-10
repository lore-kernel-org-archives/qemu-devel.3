Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317A3C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP2Bv-00026F-Rv; Tue, 10 Jun 2025 12:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1uP1PH-0005Tj-JT
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 12:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1uP1PE-0000DY-01
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 12:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749571251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dp64+H62dto2vYWHN2pdtS9nRn/63AVOPtYCyVP++rg=;
 b=Apq7XWXO07ylwc6h+0+86EPlemLpufyAspTvZA29x5BZjzSc2pO6eIpD7UgWXrZYQogJ1Q
 jilkF8D7R1N3FNTLILxbsHI7+gozHmPHKswzwcSoSGL9BuvvCYj4g3cZtagz56AWxkKQtW
 FbJU88EwlQg4iBH24eEDZBExZXnOeMw=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-iiNsd2h2P42GfvAxL-orvw-1; Tue, 10 Jun 2025 12:00:50 -0400
X-MC-Unique: iiNsd2h2P42GfvAxL-orvw-1
X-Mimecast-MFC-AGG-ID: iiNsd2h2P42GfvAxL-orvw_1749571249
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3dde751641aso3220765ab.0
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 09:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749571249; x=1750176049;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dp64+H62dto2vYWHN2pdtS9nRn/63AVOPtYCyVP++rg=;
 b=BvBVR2UM/3SpRkoTDBtTnRhRRx8KF2CQwOVYTDQP5Dffocb070UYqXONd3mV40hZA5
 3vyiQE2InD0TAJscEmvGnrjO17HaqVeoPncvIiikSRZBLQE4/Wd64ltH3oQXNnxbIi5l
 o0ci8hSJ/ST8j/WP36Va0EklzlPEhhywzH2TndX8mUVCHbBiDpL1AvgatlKx82c8Pm/U
 AJBggSmILogBRlYY5dtsk3xMPeSgRM9/awyWm6vvryB6r9F2VxNA9UJjXPzdT0v0UZJM
 c/pxo7r+RL+NRM0pByyTr6HemorpE0nNV2xf19RFPcG/lYM0vDYLzg/abw03ffYHcTDt
 oEmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMFYpAonk4fN9SKI7VWCAPp3N8BQavIosvEuOpK801piVcp+a1gQtpvY+8qqNfzYTiip4zD1tv0XNk@nongnu.org
X-Gm-Message-State: AOJu0YwbNroyysOqz7AUAdEGdqxZVnu7Pe8tp/JNBpfO2MHj9hOCcmw6
 +FZuaPBHZGZrI+pfve9AE1y72mXG/pdbjgXShyqo4j5HFW4glhdxPB49Q1ZgWTktVUhnmuNtiiO
 Vk32QNBbUd2PXcKOw1W7s9DsuTaNz0AQO7AL1+qQLbhXW1oYKiIqx9MZH
X-Gm-Gg: ASbGncsy2SKNXnGWXarbb1nX13ERjWmA7gwb7gRoDbS+7YXKY/Ww81nMK8fej7XP+Av
 YodiLn9hHEWUXqdOcfmwOaB+xbT5AdiPKmA8wOSr6zq/Ks0TGT4HgyHn4DMWXyf8NUYETQiDAnQ
 Cfr2a+1urWHlFY5n6+jAC9nFKCKf4PXW7yVn32eO5GQdWX+dmVvBwDtGqeEG59c2A/3t+xKMgz4
 gWRCqzXjZ6DdoCnVllmCQL7aDLJVU8iEaw5x+OhXjgpFqL4jfj6U9w91grEi82NszNdj5ljNtXR
 Lm3E/NHN+h8BYyEn31aGqQ/Zvw==
X-Received: by 2002:a05:6e02:b48:b0:3dc:7c9e:c3d6 with SMTP id
 e9e14a558f8ab-3ddcfd32d99mr43155705ab.5.1749571249261; 
 Tue, 10 Jun 2025 09:00:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA7RGe+25nJWCQsKDje7z2DCuw4/cUv4FPKY3ATl+CaD9HVcSp5+YZhP17uzT+1APqn+QhgQ==
X-Received: by 2002:a05:6e02:b48:b0:3dc:7c9e:c3d6 with SMTP id
 e9e14a558f8ab-3ddcfd32d99mr43155245ab.5.1749571248051; 
 Tue, 10 Jun 2025 09:00:48 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-500df3f606asm2397415173.24.2025.06.10.09.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 09:00:47 -0700 (PDT)
Date: Tue, 10 Jun 2025 10:00:46 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, qemu-arm@nongnu.org, Eric
 Auger <eauger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Gerd
 Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] ramfb: Add property to control if load the romfile
Message-ID: <20250610100046.3577ee29.alex.williamson@redhat.com>
In-Reply-To: <c2e0ece0-1ee1-4867-b01c-20e847ef6af3@redhat.com>
References: <20250606070234.2063451-1-shahuang@redhat.com>
 <aEKeNSc8mAZ8vhGj@redhat.com>
 <cf34f5b2-d422-453f-85d4-15938ae59e9f@redhat.com>
 <c373ee81-d094-4b40-93c9-5ece6e24e520@redhat.com>
 <c2e0ece0-1ee1-4867-b01c-20e847ef6af3@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 9 Jun 2025 13:16:14 +0800
Shaoqin Huang <shahuang@redhat.com> wrote:

> On 6/6/25 4:07 PM, C=C3=A9dric Le Goater wrote:
> > On 6/6/25 10:06, C=C3=A9dric Le Goater wrote: =20
> >> On 6/6/25 09:52, Daniel P. Berrang=C3=A9 wrote: =20
> >>> On Fri, Jun 06, 2025 at 03:02:34AM -0400, Shaoqin Huang wrote: =20
> >>>> Now the ramfb will load the vgabios-ramfb.bin unconditionally, but o=
nly
> >>>> the x86 need the vgabios-ramfb.bin, this can cause that when use the
> >>>> release package on arm64 it can't find the vgabios-ramfb.bin.
> >>>>
> >>>> Because only seabios will use the vgabios-ramfb.bin, load the rom lo=
gic
> >>>> is x86-specific. For other !x86 platforms, the edk2 ships an EFI dri=
ver
> >>>> for ramfb, so they don't need to load the romfile.
> >>>>
> >>>> So add a new property use_legacy_x86_rom in both ramfb and vfio_pci
> >>>> device, because the vfio display also use the ramfb_setup() to load
> >>>> the vgabios-ramfb.bin file.
> >>>>
> >>>> After have this property, the machine type can set the compatibility=
 to
> >>>> not load the vgabios-ramfb.bin if the arch doesn't need it. =20
> >>>
> >>> Can you make this a series, with an additional patch that updates the
> >>> current in-dev machine types to use this new property, so we're clear
> >>> about the proposed usage. =20
> >>
> >> yes. And please change the vfio-pci property name to use underscores. =
=20
> >=20
> > Sorry, to *not* use underscores : use-legacy-x86-rom =20
>=20
> Thanks for pointing out it. Will fix it.

It's also not evident from the property that this is restricted to
ramfb behavior.  Should the option on the vfio-pci device be prefixed
with ramfb?  Thanks,

Alex


