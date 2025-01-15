Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F1CC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 08:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXzAe-0008BH-8l; Wed, 15 Jan 2025 03:54:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tXzAd-0008Ao-3i
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 03:54:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tXzAb-0000SW-5S
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 03:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736931275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bX2k2ZiBZRX13Y9JoCkdAZHEGJZzthaPLku+rB4EUdQ=;
 b=KKN2iJXQucN1bMeohQQ/7jgY7LctGapXUHCJ7SDS/02qiiPSh/meKSlnB+9FhiS8YW1YoQ
 pmQdvtpxfH/CESZRBmT624PkTSEdsFIWGIxsHbdCe17jEvS+ff3b0CewliYnXfYheqSj6y
 MBiNAlKXhICTukq6vNRfaL6Me5g0MUM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-ACmg0bY9Or6cDmU3nmqYYw-1; Wed, 15 Jan 2025 03:54:33 -0500
X-MC-Unique: ACmg0bY9Or6cDmU3nmqYYw-1
X-Mimecast-MFC-AGG-ID: ACmg0bY9Or6cDmU3nmqYYw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385f0829430so3918205f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 00:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736931272; x=1737536072;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bX2k2ZiBZRX13Y9JoCkdAZHEGJZzthaPLku+rB4EUdQ=;
 b=T3d6iR/vFI6WTWkLodvKSGGNgAZsMbOo3kvNtK9zu/Fma1y1gdTQj7Awovxy3rZBUY
 FWVSuRL9NNufmUyBhXtFFRQ+9C1ObUIjPwexAFNvTlLUhU5rxrbfNH41goHAH3E8A6aB
 t7rkvvJvGSLZB38ySw5iw4bcaIZIf5dkIXfvsJr78Pd8BQr4Q4U8NkEMFeH8gSE5vxzR
 GqpsAWViOOY9MrY1ibdzfv2x0csOTGl8FEukVcNeOsFf67JagV9XiK4NZTPyhJcc+mbJ
 tFnacztmt+b5pvNG6bv+SrjoiYadxs4Cu6AvZCqYVdaelriD28teR2P1WigXlLMeQ6Zp
 hVOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnVvv7cqwDdGph9pvtAUUaajgta3BqYzsxAamklh0+U2WmqYiFf+Uy/VsbrATXxB5lKdO+VVH36TPL@nongnu.org
X-Gm-Message-State: AOJu0Yzan/0FW2w/VPXgNEa359modvGrHKPqqSMpNaiR7ImwNCv8Lydo
 /M5LqMKBfYLCIWuWMvK5LKqmpNFqJbeR2gEWKWvw9WpLG5bWrvEh8z1+hFHcX8vdGZoQGdFq9XV
 /8bNcGldU0ccmhMouJaJGsncTz9Pa/neIPg6Xkfi3XVHdtbPvrstd
X-Gm-Gg: ASbGnctLUrnir3AWeaTyQdDpIZ5+gG/iClMRQYx7ZdUZ+bMk4StFIutBKdEdczcf/+n
 DGD6ayaSP8ESazkf9ifLj+NIlC175LU20IjZ5tg/bJ+5f5H28sQx9C/F25KM/BSS8JcfuaXhIUd
 56Ih3PwVOsUghZJUcZRt97mLrMB+Cu9oYKMjEJnVT/VBv/4mB35tYk6LGokiUKiX2sD3fjLdEEy
 o9fOZPS9FH9eBD/wbrKP8d2j5rY2th/MpkxfrgqBDdVMZ5e3Q==
X-Received: by 2002:a5d:6c6e:0:b0:385:d7f9:f16c with SMTP id
 ffacd0b85a97d-38a87356cd4mr25095022f8f.46.1736931272257; 
 Wed, 15 Jan 2025 00:54:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKJluuQiQ4dCcQiG+lY3c+Oc+lYPtF33S2Vzd0oAIiQoSUIIE+EnlauoWeF43KNtAdg5p16w==
X-Received: by 2002:a5d:6c6e:0:b0:385:d7f9:f16c with SMTP id
 ffacd0b85a97d-38a87356cd4mr25095009f8f.46.1736931271957; 
 Wed, 15 Jan 2025 00:54:31 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f5:8f43:2a76:9f8c:65e8:ce7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e383654sm17340983f8f.30.2025.01.15.00.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 00:54:31 -0800 (PST)
Date: Wed, 15 Jan 2025 03:54:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Reza Arbab <arbab@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH] virtio-balloon-pci: Allow setting nvectors, so we can
 use MSI-X
Message-ID: <20250115035133-mutt-send-email-mst@kernel.org>
References: <20241216163125.438156-1-arbab@linux.ibm.com>
 <cf465326-1eaf-4ad1-99ae-1e0d5a562a84@redhat.com>
 <b406b176-4b6c-4d82-824c-5c0ced0d9fcf@arbab-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b406b176-4b6c-4d82-824c-5c0ced0d9fcf@arbab-laptop>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jan 08, 2025 at 09:14:35AM -0600, Reza Arbab wrote:
> On Wed, Dec 18, 2024 at 11:37:05AM +0100, David Hildenbrand wrote:
> > No expert on any of that MSi-X / PCI magic, but LGTM
> > 
> > Acked-by: David Hildenbrand <david@redhat.com>
> 
> Thanks David!
> 
> Did anyone else have any comments? Just want to make sure I have things in
> order to get this into the next release.

Causes a CI failure:

https://gitlab.com/mstredhat/qemu/-/jobs/8800804175

In file included from ../hw/virtio/virtio-balloon-pci.c:15:
../hw/virtio/virtio-balloon-pci.c: In function ‘virtio_balloon_pci_class_init’:
../include/qemu/osdep.h:261:35: error: call to ‘qemu_build_not_reached_always’ declared with attribute error: code path is reachable
  261 | #define qemu_build_not_reached()  qemu_build_not_reached_always()
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../include/hw/qdev-core.h:956:13: note: in expansion of macro ‘qemu_build_not_reached’
  956 |             qemu_build_not_reached();                                   \
      |             ^~~~~~~~~~~~~~~~~~~~~~
../hw/virtio/virtio-balloon-pci.c:69:5: note: in expansion of macro ‘device_class_set_props’
   69 |     device_class_set_props(dc, virtio_balloon_properties);
      |     ^~~~~~~~~~~~~~~~~~~~~~
[2493/4296] Compiling C object libqemu-ppc64-softmmu.a.p/hw_virtio_virtio-scsi-pci.c.o
[2494/4296] Compiling C object libqemu-ppc64-softmmu.a.p/hw_virtio_virtio-9p-pci.c.o



> -- 
> Reza Arbab


