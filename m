Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E861CC3ABD9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 09:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF8AG-0005PK-4D; Wed, 14 May 2025 05:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uF8AE-0005MB-Af
 for qemu-devel@nongnu.org; Wed, 14 May 2025 05:12:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uF8AB-0003Bv-Np
 for qemu-devel@nongnu.org; Wed, 14 May 2025 05:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747213949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fa07lKXLVNmfZrVEu1PlbE/kwWhJEykL17/zMyKV0b8=;
 b=TI7QVDW/rh3fVxfQafiePKWSgaB522US21A6kRWZJdfLAeW2hF54OIg5Yjv2EhoisLWGE8
 CrHsidMsaSIpJS0YY9YdTjq5NhvqvjxWK9L+HX63xe0VBqpssLK/tncxQ6ShQsnvtLXp0I
 2QGAEk/xl60FzGtWnI7QIgnrKBZVNLY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-pjilvmwdNemuEufjmFqD5A-1; Wed, 14 May 2025 05:12:27 -0400
X-MC-Unique: pjilvmwdNemuEufjmFqD5A-1
X-Mimecast-MFC-AGG-ID: pjilvmwdNemuEufjmFqD5A_1747213946
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43ea256f039so48060475e9.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 02:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747213946; x=1747818746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fa07lKXLVNmfZrVEu1PlbE/kwWhJEykL17/zMyKV0b8=;
 b=u6NCAs+PNxZuIkzO56+38y4SIOTMuexVggdWBGA9kMwryjwjMvE76aQuRIPAs/rjY0
 QoT0C01GjbtajyiOqhgOyrq4zADo/wLijV9m4+45RKOu3r4iXfC13I8oWPJnwprWhzXF
 LVQqN7CWKLXBUCZYLDGqXZbxdTarH27a59eHNoZjzhIIpms7719ELtA1gf9j5sOWFgkE
 Y4KZBhnDI5MK7wBWZnkXG4LYC40e7gXR5cienZJTPJIpcMbtRGC1IDXXcA6/4TaGZYBC
 bXlmKgXi0fmBSBmLrXTvrpr+Sy3CsJ1YQTFt0NveQCpdXFNZqaNHMUYHmNN0AzWoeyHH
 /aiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIqMvnReN6xsMtHoCVFLhvimaT54GlooQRCTAJjky++E2PO9RCFE6kRmgwW8NXDFsBUXSlgHT8ahpN@nongnu.org
X-Gm-Message-State: AOJu0Yy+ybeZ2/NH7jnPg7n4azXI13F4wUSgd2/EdqNLc8pG6wxnyiEd
 jpbYZ9QHBUYEW8lVFh/MvV4+E/4QkOQ0PsYzpsm12MyaJ2wrhJ9Zt53FgqJNcLErzg9cshdnUHp
 L7LhK0HmhLkXYGU2amLTjWTXpEU87+iEoMzUVjJK0PBpNhiUnANLk
X-Gm-Gg: ASbGncsIwwO4QAQj0USJAodRY9F/7yrlSwloxpG7CpZ/yamaK8T8RiQYOjH1uYVu9bZ
 i25XGF9mUaONGtEtgwvXp022hHo1+1/6mFdBAhfUgixMZETd6Uvgrk8sz/GNIPQmfRFCCS768ow
 3rg/bSIkagcSTa8h2W37i/KS8JAr/UaJw15fbIlgmUVYlznNwCYt4jY5aDtizEBABPCywefk3RY
 V9lT9GZRtDl7/KtlHVkNbq0GWqryj0rsRlwCKqA7ggYDS1WKZyawEzBcctsRuOCsX9JXpmys9Do
 FMsy2CUW1ph7iAMWl4TcxU5Ayyf1SLAn
X-Received: by 2002:a05:600c:3d15:b0:441:b076:fce8 with SMTP id
 5b1f17b1804b1-442f20e73e8mr24297035e9.14.1747213946498; 
 Wed, 14 May 2025 02:12:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBl6LhRJo6ZV3ARjGkyt/GT22J+KLQibrhClLrRKCXyeVyR3RRpU//qqdonG4106XBmo4RXg==
X-Received: by 2002:a05:600c:3d15:b0:441:b076:fce8 with SMTP id
 5b1f17b1804b1-442f20e73e8mr24296785e9.14.1747213946151; 
 Wed, 14 May 2025 02:12:26 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57de100sm18745827f8f.2.2025.05.14.02.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 02:12:25 -0700 (PDT)
Date: Wed, 14 May 2025 11:12:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: yuanminghao <yuanmh12@chinatelecom.cn>, qemu-devel@nongnu.org, "Michael
 S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 1/1] vhost: do not reset used_memslots when destroying
 vhost dev
Message-ID: <20250514111224.7fb1263f@imammedo.users.ipa.redhat.com>
In-Reply-To: <36d6672a-6d06-4af2-bdc6-4349df570662@redhat.com>
References: <1741024937-37164-1-git-send-email-yuanmh12@chinatelecom.cn>
 <20250513141341.5f3ffa57@imammedo.users.ipa.redhat.com>
 <36d6672a-6d06-4af2-bdc6-4349df570662@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 13 May 2025 15:12:11 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 13.05.25 14:13, Igor Mammedov wrote:
> > On Mon,  3 Mar 2025 13:02:17 -0500
> > yuanminghao <yuanmh12@chinatelecom.cn> wrote:
> >   
> >>>> Global used_memslots or used_shared_memslots is updated to 0 unexpectly  
> >>>
> >>> it shouldn't be 0 in practice, as it comes from number of RAM regions VM has.
> >>> It's likely a bug somewhere else.  
> > 
> > I haven't touched this code for a long time, but I'd say if we consider multiple
> > devices, we shouldn't do following:
> > 
> > static void vhost_commit(MemoryListener *listener)
> >      ...
> >      if (dev->vhost_ops->vhost_backend_no_private_memslots &&
> >          dev->vhost_ops->vhost_backend_no_private_memslots(dev)) {
> >          used_shared_memslots = dev->mem->nregions;
> >      } else {
> >          used_memslots = dev->mem->nregions;
> >      }
> > 
> > where value dev->mem->nregions gets is well hidden/obscured
> > and hard to trace where tail ends => fragile.
> > 
> > CCing David (accidental victim) who rewrote this part the last time,
> > perhaps he can suggest a better way to fix the issue.  
> 
> I think the original idea is that all devices (of on type: private vs. 
> non-private memslots) have the same number of memslots.
> 
> This avoids having to loop over all devices to figure out the number of 
> memslots.
> 
> ... but in vhost_get_free_memslots() we already loop over all devices.
> 
> The check in vhost_dev_init() needs to be taken care of.
> 
> So maybe we can get rid of both variables completely?

looks reasonable to me,  (instead of current state which is
juggling with  dev->mem->nregions that can become 0 on unplug
as it was reported).

David,
do you have time to fix it?


