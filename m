Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26DFC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 10:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi8Op-0004Il-FS; Fri, 10 Jul 2026 06:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wi8Ol-0004IK-Mi
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wi8Oe-0001Go-14
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783679030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3G2NTgaQ+pWjSErQH1KLa/zF9hIagOsTcIzbYHIJBrA=;
 b=OAA1RzPHp3lBI1LDQEypYLqaiQMrzCoYT7PkHk6fibQslNar1VCS461YsfBRxpdlPXGcWm
 pYNOHCJMXqwhpoDNze7PhHsqGtXca8op6uLEadE006va2jo2SiIMxZ9wfggbUdCBX2L3ue
 UI9y9ATluknY/pW6vZnEF1/pM4gM6l4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-KYp7UbwXPlebtY-U0-7EhA-1; Fri, 10 Jul 2026 06:23:49 -0400
X-MC-Unique: KYp7UbwXPlebtY-U0-7EhA-1
X-Mimecast-MFC-AGG-ID: KYp7UbwXPlebtY-U0-7EhA_1783679028
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-492488f8583so9199735e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 03:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783679028; x=1784283828; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3G2NTgaQ+pWjSErQH1KLa/zF9hIagOsTcIzbYHIJBrA=;
 b=WKjZB2HEQUFu0z+cAmrJKOhBuQDiZFcsnYGdaxGj11v4rscve4BR9bFqSDKeAe/RnO
 +EluxVuHDZ5OG5bfD7S+i9tGPBDLXejkFpS8yFEXPfKk6NrQt9xKBs7XDWFX2Ttf8bdc
 TGOBFxjthTgOlSGnJtrzmMenuIX+DFb3W1//mVun6/qV8ZjE+BNr+UVhKodTpjYS7utT
 CscTOEZ2MltW8atyYZcnzz7fayS3I51VDey9asbaEyUMH3qOvbmP+tm6hsnpjnUNP7Yr
 6C8pvky/t4Dc/1iTLNUZCHaArppVmslBov9C/oGpjdpWaU3mkx9iySVQkChWGzhe2513
 ZUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783679028; x=1784283828;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3G2NTgaQ+pWjSErQH1KLa/zF9hIagOsTcIzbYHIJBrA=;
 b=Jv3ARj62guWaATn0b1zx3cA5my7wh5YCbt4/jXr0kPdjl2XUfUkchtXKFHvAUZgClu
 wyo3nsmH4GcWeOzPXJXB5KdgeEq4kssSec/OOkw2yiuXsD3pwMpohMvQKp2INZkHByTK
 UW520nzALde0OkO+RjcSJUeBpmu/6R+jOdLNN0rHvoTPIKXUSUd0URtts6Y+6PuEQdBQ
 XdVf9tNvY9Gtq8D8K3LI5/Ms+6rdapJS+yROHMkPKA0BSqnjgEV5nK8n9A7FrY1oO8VY
 /wGFOBCU5e2bJ5ifo0cNh+Sho7lE8ICaGC+dxuoOblYE6aBpWVgt3cFdcWSQHp+hlJEz
 0mXA==
X-Gm-Message-State: AOJu0Yx+Y+3EemsOR9nUMrnjRt82T/k8ypXcX5o4lmYWozZuVDCCrqSI
 VihZG4e3iS0srGK0vdrDdpWhBolFbDet8q+84w+mTWQKgGsT7EOQGy5d8DZ7h9bJxrsBy85n6QH
 yPH5H4MTK8dogFafmBs4B1GhiteXzH5hFsonfH9knt8zsSBYLNSIBxRkL
X-Gm-Gg: AfdE7cln5cR9KdsYZC5uBfRoEA3D0qDHonrjFVJyEm0DloC1AaNP/HUULtjbYTkh8mS
 XK1OMcowBNBCFSWMvzKJH0RQiVZcmon1JkAjMLf78bM19p8js1D68jJCzkh1liKNkTzM7qRjMl4
 vnQLtg0JcvsXMsKVlpYF6tKf1r3SwyoF5RnN24TulnlfNiHsDSOuYmtKFAYZ5CLoCkg0BwLK+cu
 k5zNW4fdBE+7xrRSUw5oSpQM242w4mRsOS+ErfEXE2quAGzeL6IfiqGmgvmbd5do3S0DZ/CR8RM
 +pKA/DCm2upbidY9fPTFkbgNraPz1gKM/ynIfR5nnaiZw2TuFLZ4y0NOQj05LXE3U5w2Dyc=
X-Received: by 2002:a05:600c:4e0b:b0:493:f140:c406 with SMTP id
 5b1f17b1804b1-493f140cb13mr37280475e9.13.1783679027912; 
 Fri, 10 Jul 2026 03:23:47 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0b:b0:493:f140:c406 with SMTP id
 5b1f17b1804b1-493f140cb13mr37280175e9.13.1783679027513; 
 Fri, 10 Jul 2026 03:23:47 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d8cdsm62836974f8f.1.2026.07.10.03.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 03:23:47 -0700 (PDT)
Date: Fri, 10 Jul 2026 12:23:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Jia Jia
 <physicalmtea@gmail.com>
Subject: Re: [PATCH 2/3] hw/9pfs/virtio: disable hotpluggable property of
 virtio-9p device
Message-ID: <20260710122345.6a6dd56e@imammedo>
In-Reply-To: <6008134.DvuYhMxLoT@weasel>
References: <cover.1783604079.git.qemu_oss@crudebyte.com>
 <d07de8d7b33fbbdd84909c21b67156fe564dc050.1783604079.git.qemu_oss@crudebyte.com>
 <20260710093737.4948ded4@imammedo> <6008134.DvuYhMxLoT@weasel>
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

On Fri, 10 Jul 2026 10:06:29 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Friday, 10 July 2026 09:37:37 CEST Igor Mammedov wrote:
> > On Thu, 9 Jul 2026 15:50:36 +0200
> > 
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:  
> > > Harden security by disabling hotpluggable property, to prevent
> > > issues like fixed in the previous commit.
> > > 
> > > Virtio-9p is a pass-through file-sharing device that provides a
> > > guest mount of a host filesystem tree. Unlike block or network
> > > devices, guest-triggered hotplug of the 9p device has no practical
> > > use case: the guest cannot recover from the device removal, and there
> > > is no protocol-level device-loss scenario as with block or ethernet
> > > devices.  
> > 
> > hmh, I'm no maintainer of 9pfs, but to me it looks like any other
> > storage device.
> > One should be able to unmount/stop using it and unplug
> > (it doesn't really matter if unplug is triggered by guest or host side).  
> 
> Guest could still unmount and stop using the 9pfs device. But why should guest 
> be able to unrealize the 9pfs device at any time? What should be the purpose 
> for this particular device?

unrealize is part of unplug process, at the end of unplug no device should be left attached.
You might not need/use it but others might be using it actively.

--- 

In QEMU impl. it's cooperative process (we don't do surprise removal of PCI devices),
where host triggers plug/unplug process and guest side completes it, by:
  1. freeing resources on its side 1st (hopefully)
  2. issuing eject/poweroff (either via ACPI or native PCIE-HP/SHPC interface)

If guest fails to do #1 it is able to abort process, or it might continue and
do #2 with a risk of loosing data but it's guest's business/policy.

If you need to disable hotplug for a specific PCI device instance,
use 'hotplug' CLI option on pcie bridge. If you use other than PCI variant
of virtio device, then unplug as you describe it isn't reachable, and if it
should be disabled in code, it's up to actual frontend device that exposes
underlying virtio one.

> /Christian
> 
> 


