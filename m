Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B385AC021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 23:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlFu3-0002aa-U5; Thu, 20 Feb 2025 18:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlFu1-0002ZO-CR
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 18:24:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlFtz-0002pQ-LT
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 18:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740093858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N7XFD6hbEVeNJD/Coj88dbVk6TQfSyUt7e1j79/rf2M=;
 b=BcOgzkNDeIDlwZz3VkVyJplnR+eBTBtffOVDK1jlrM1TKvFqiDeTlhvjwOC+JKsK63TmN2
 COQzm90McADjCyCwiB5gPnUg9BRFvy3ZH9uYxWGJ2rzgzkGD54IkhzILS62diUuelSaxN/
 6wGZJ4WoqKsTwyarsvoFpmRNuMQWjyE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-TU-5GM31PJWCT8TI3P2iog-1; Thu, 20 Feb 2025 18:24:14 -0500
X-MC-Unique: TU-5GM31PJWCT8TI3P2iog-1
X-Mimecast-MFC-AGG-ID: TU-5GM31PJWCT8TI3P2iog_1740093853
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5dca72b752fso1898728a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 15:24:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740093850; x=1740698650;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N7XFD6hbEVeNJD/Coj88dbVk6TQfSyUt7e1j79/rf2M=;
 b=JKzQ419ieAIpQQlMX7sDsgCvbAzPtOrVoh1AwXnkMsXHCfKDrhNgrrqncypnKRZmaI
 Pw5jKUv/Tkc1o+86aX+aiAYD5je2hvS9GrROO2/gJesPSfawPVvcQcCjAkl9TZK+IUkx
 poMc0YtP3xjKPmWd2Clab596XbMm0z8J1zuIlIZrfu4LUEHGAwsZm14GyoozdP6fUckk
 9rrp3C+OGrF3xBoNFCwcCdk0f0ogp74GAxCZqny/N712vp/5FOtFI52E/ik+2ZEvT5Hy
 z7XZ7bET7nAr/jRY2z02bD4nT8I92SuHZGHux/ets7/o6LiWa5HB9TacnUCn1LxzlUVq
 5GRA==
X-Gm-Message-State: AOJu0YyZhyJWIre9ZpuxDiySi94ROcebzot/ukY4hhI/Kudb+nnrG2Jm
 8koynyDvER0AI6XjcQk5XZ+2Sz857bstdwI4DaedwFWismdLLSNKPyK7U34kNAfrvi9kPjDeBjJ
 zlKzA5CTTwHuRYzjZFiwguXpBWx4r/sbcuz+snTzyHzcQl3OQT6Qf
X-Gm-Gg: ASbGncvObGc+hXphI1ok5FwyJ4azuCwSnBAsawsXh4Qk0gJnTDD6TShgbN5juDPoCHJ
 T/1mIYQYMOrQjvtKMAMGFIQMZcD29dv4TIOwLK43tKctH9urv+uxbs5QbVeg74zJr2nGFcdOAWH
 fQ1T10Qww4gkYQzlSbZILfvwvDvhp/vTE7LyzIyJBkvCV9czjMa8e8Q+FEvpArkSYBG1ybugreS
 UFNC4T90f9QM31K69hGYJi8coxMJRAVU/G38Yd+3KALP8e5NGU3btAs0UNRQrq2THlnWw==
X-Received: by 2002:a05:6402:2548:b0:5db:e7eb:1b34 with SMTP id
 4fb4d7f45d1cf-5e0b70f07d4mr688671a12.13.1740093850591; 
 Thu, 20 Feb 2025 15:24:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfW6HdLjp4GDbt3wZTd1EvJWfxze9FEoSOCS86840f/DyruZ89XjInOyPYP+yj8+OLF3bx8w==
X-Received: by 2002:a05:6402:2548:b0:5db:e7eb:1b34 with SMTP id
 4fb4d7f45d1cf-5e0b70f07d4mr688643a12.13.1740093850151; 
 Thu, 20 Feb 2025 15:24:10 -0800 (PST)
Received: from redhat.com ([2.55.163.174]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece270967sm12704462a12.55.2025.02.20.15.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 15:24:09 -0800 (PST)
Date: Thu, 20 Feb 2025 18:24:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>
Subject: Re: [PATCH v2 0/2] s390x: support virtio-mem-pci
Message-ID: <20250220182351-mutt-send-email-mst@kernel.org>
References: <20250128185705.1609038-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128185705.1609038-1-david@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Jan 28, 2025 at 07:57:03PM +0100, David Hildenbrand wrote:
> This is based-on [1], which adds MSI-X support to virtio-balloon-pci,
> but can be applied independently.
> 
> Turns out it is fairly easy to get virtio-mem-pci running on s390x. We
> only have to add MSI-X support to virtio-mem-pci, and wire-up the
> (un)plugging in the machine.
> 
> Tried some simple stuff (hotplug/hotunplug/resize/reboot), and all seems
> to be working as expected.
> 
> The kernel in the VM needs both, CONFIG_VIRTIO_PCI and CONFIG_VIRTIO_MEM
> for it to work.
> 
> [1] https://lkml.kernel.org/r/20250115161425.246348-1-arbab@linux.ibm.com


Fails CI:

https://gitlab.com/mstredhat/qemu/-/jobs/9202574981


> v1 -> v2:
> * There are no transitional/non_transitional devices for virtio-mem
> * Spell out removal of "return;" in second patch
> 
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Boris Fiuczynski <fiuczy@linux.ibm.com>
> Cc: Michal Privoznik <mprivozn@redhat.com>
> Cc: Mario Casquero <mcasquer@redhat.com>
> 
> David Hildenbrand (2):
>   virtio-mem-pci: Allow setting nvectors, so we can use MSI-X
>   s390x/s390-virtio-ccw: Support plugging PCI-based virtio memory
>     devices
> 
>  hw/core/machine.c          |  1 +
>  hw/s390x/s390-virtio-ccw.c | 20 ++++++++++++++------
>  hw/virtio/virtio-mem-pci.c | 12 ++++++++++++
>  3 files changed, 27 insertions(+), 6 deletions(-)
> 
> -- 
> 2.48.1


