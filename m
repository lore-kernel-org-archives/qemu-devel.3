Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550B3CCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 22:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGloo-0007WR-Ju; Wed, 05 Nov 2025 17:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vGloi-0007VT-DM
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 17:17:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vGlof-0000Pc-MJ
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 17:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762381040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b5TEZP3l9CYqiCCjrh7XZkVlff+R66ITMOHNmnCGmM8=;
 b=BeonXD/iBi7k7WNyP2WXbxvBJCYyOmYqtECLepb6/eA+nqOwjzy7j54bsocZ6qYNGgv03r
 7IcLYdmMrMtrIPjAWZgv1suJaiHLpx7qGrl0KoE3DcliO+ZWOysjN39sAVbu6zuaXqJYW/
 R0XkTRtjewLJLX3LQb2Ce74hm/JOM1E=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-WK0GRGEWPxi_p5xsZWhdkw-1; Wed, 05 Nov 2025 17:17:18 -0500
X-MC-Unique: WK0GRGEWPxi_p5xsZWhdkw-1
X-Mimecast-MFC-AGG-ID: WK0GRGEWPxi_p5xsZWhdkw_1762381038
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b22c87f005so97447585a.2
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 14:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762381038; x=1762985838; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b5TEZP3l9CYqiCCjrh7XZkVlff+R66ITMOHNmnCGmM8=;
 b=DfP9EbcRZyQbvou9w0i5gZUiKN84XTxx2Q5YvjM8WkqwAoj7rT4yXvIwINzn0tgjZl
 5od1nqGvpeHZXhTYdYrDq+yliR7EcdMvgaV2iXan51e970gRHWRQP3TgpIxsUFr6GM/o
 /KHskUUcSJfpeQDwGdCfkISp1KNr1rCyx/QlUjf8QeCBaXMyVsVCap+2w07RCF/mlrkj
 iKD6qD2uoNu0YiERXI7MVw5VIaI4F4AUa+6CO5dYXLPLHpV7yMVyyqjIWgY407GVmAaQ
 vvxZbprNVFwbIBjYGTFTjtk982DXwbgR0hXQ6TpVXQlP7TLhIr4p8TNoizhSSut/g7Nb
 Lw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762381038; x=1762985838;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5TEZP3l9CYqiCCjrh7XZkVlff+R66ITMOHNmnCGmM8=;
 b=A4NxMMwGEIQh+ozUtj0DyqF+y6O0DVm3Pf9f2k1E/TP/LyWkHOUekTza1Qzl3vJVcy
 +LevlKo05tIdCI/73sd2HcJAZdcMaj9sob1t0zx+i8ihdO7nBODFKqayDGSUstjw+9h6
 eU+pGr734ZZNSUuUofbgOaHzLyDDVlFDXxZ/Cfd3zEJcD/3GkB36GSTJFQwHACoasxfZ
 PgZL8RHATX2Q+zox0/teHIKNFwoLZaWPXjxSEh4hPYAP/jV5vmXD+vosNS0bDJT3QDYa
 JTwRnSuCNEXnbLMmiEmCrEyGleQhGfU7l5TnWMpYKXWbX5p0Gx1v0AGiFAEonTLtf/f+
 cBYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6+blqVKdTcljZQhpRspFMNBD8h39j737IB/u0VI0QBhHhOXQHxBe/sg4rJ666h21vd2tNxv1QVqm5@nongnu.org
X-Gm-Message-State: AOJu0YxdJASJpBr4AlUtxHruxw8PmZb2z0WkidsotR0NTpj9AtZJ+z9k
 /kQBUjR9zCQU1z38BpHL69+Tg5B/Uus4flwGvMpV1Of7y8YEzJ8DvzyJjLRe6kOe7PYmalVNpn6
 Vgdomd9F9LrOhcfh4mScWAKsVkTkqdmS/lfZacAF++b3Si+ODIr58Bkwh
X-Gm-Gg: ASbGncswNOdqPda4oY/o7GGcKNzTM3jTzqWEIZYHurbDLXZUEr1jTcMFrYkysDy8wUj
 CPOkaIgleMZqMPnSybsBnEOd+In89Y4/YtXufm/Hul/Xxf1AAz25NW8zV/aHk+LPKB6A/LyrHRN
 49MbWE4SyOSWoqt+LIVwdhryri7kxZPe15TGzDKs/rBiMnBz5+0vEpBkqcPJLWJk+zRbY9R+yqV
 mVIpnr+WSXMHDQN45qZcmTQf+uHe3hJcWpsDKh/8UDJfxcrbhJ6eoeSnfKpwIceIWCoYj1JDNsI
 YZiFGhwvmsGrf7ZEgDDmakydJLs+iwKqv8FA8ieIwrP9dySPJkjZ+C5miYfsewqduls=
X-Received: by 2002:a05:620a:1992:b0:862:3e8d:e4ec with SMTP id
 af79cd13be357-8b220bb1d60mr678989385a.60.1762381038047; 
 Wed, 05 Nov 2025 14:17:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK8+4aw40RMS0Lo3ZMrgMF0/wmVZfY7etRagC7eXruRnPU30/N1aRrQXPxEaaqQ46cUfParQ==
X-Received: by 2002:a05:620a:1992:b0:862:3e8d:e4ec with SMTP id
 af79cd13be357-8b220bb1d60mr678985485a.60.1762381037512; 
 Wed, 05 Nov 2025 14:17:17 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2357d8842sm62323585a.38.2025.11.05.14.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 14:17:16 -0800 (PST)
Date: Wed, 5 Nov 2025 17:17:14 -0500
From: Peter Xu <peterx@redhat.com>
To: Jinpu Wang <jinpu.wang@ionos.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Yu Zhang <yu.zhang@ionos.com>
Subject: Re: [BUG] Migration failure =?utf-8?Q?betw?=
 =?utf-8?Q?een_QEMU_9=2E2=2E4_=E2=86=92_8=2E2=2E10_due_to_virtio-ne?=
 =?utf-8?Q?t?= feature mismatch (VIRTIO_F_RING_RESET / USO features)
Message-ID: <aQvM6l04VeZwbUOf@x1.local>
References: <CAMGffE=cZ_TgG=Ae+oVE+emWwuDNssozKNDsidS1+yTrh=cZXQ@mail.gmail.com>
 <CACGkMEtUx0PigJrJSWY8n2N7+znc02aqotNq+Y5w3aOMOvUvjQ@mail.gmail.com>
 <CAMGffE=cqr1awRmhAMg3V82_g1-2aM36oV+hWPuczs6VUCQkgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMGffE=cqr1awRmhAMg3V82_g1-2aM36oV+hWPuczs6VUCQkgw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Nov 05, 2025 at 10:27:59AM +0100, Jinpu Wang wrote:
> > > These are not present (or not supported) on QEMU 8.2.10, which causes
> > > the migration state load to fail.
> >
> > Interesting, we've already done the compat work:
> >
> > GlobalProperty hw_compat_8_1[] = {
> >     { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
> >     { "ramfb", "x-migrate", "off" },
> >     { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
> >     { "igb", "x-pcie-flr-init", "off" },
> >     { TYPE_VIRTIO_NET, "host_uso", "off"},
> >     { TYPE_VIRTIO_NET, "guest_uso4", "off"},
> >     { TYPE_VIRTIO_NET, "guest_uso6", "off"},
> > };
> > const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
> Yeah, I noticed the same.

AFAICT, this is a known issue..

Thomas and I used to suggest we should not turn on USO* by default by
probing kernel, but only allow user choosing it explicitly in a VM
setup. IOW, dest qemu should stop booting at all when kernel is too old
(when user chose the feature).

See:

https://lore.kernel.org/all/ZqQNKZ9_OPhDq2AK@x1n/

Thanks,

-- 
Peter Xu


