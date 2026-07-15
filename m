Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65670C44507
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 20:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk6HP-0000D4-PC; Wed, 15 Jul 2026 16:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wk6HO-0000Cb-Fx
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 16:32:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wk6HM-000424-Df
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 16:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784147546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O1SIfYYA024H6e7dPyy3uLUFJrUYmP39Feg+PF7PAKk=;
 b=CW/dRJ+9KS9DorLugdiLCBKPDNw0m53ow35vvajrls8F+T88IDyhZ8E6VAi3+OJlBx8xRp
 2eXuUsSU4Ydy8Jn93+JxUb4FOsuv1x/lTebOxdMgqrYVylVJ/+/9GVMsBUOQwWMERrLxyj
 kzMWhcWzA8Poty8ccMg7mjuusNN9w5k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-zzC5jrmWNc61u8DkQdBdJw-1; Wed, 15 Jul 2026 16:32:24 -0400
X-MC-Unique: zzC5jrmWNc61u8DkQdBdJw-1
X-Mimecast-MFC-AGG-ID: zzC5jrmWNc61u8DkQdBdJw_1784147543
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47e81aca584so2917269f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 13:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784147543; x=1784752343; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=O1SIfYYA024H6e7dPyy3uLUFJrUYmP39Feg+PF7PAKk=;
 b=YSUIciz7+0YABn9zbFQWONe+GHT4ed26i7W/LWmT6au9T2pfgVnh/n7pgaDDwEoZVa
 SAquAe3vT5WQd20pG8oKK45VvT5y3/Atu/iro3PDB0+OwQV80cznyWPG/iS9XrK0Pc/9
 2RCmJ/i/12ZuDyIZbwRhfOePUo7qo9hhKy4J3+ZDuvotlOtijB6yXSLX3gBhjiFPVufS
 uv3gCDo7isWOKBgFAmgcgaIAPtuzr7MSgJniunIjDYZPuEOecVn4VCkLH0HPfZEITLyJ
 Lqd5tPJmd01x35Fb+ufEosbIMEbdSHu3p1E49+3ohSRh4tPG5NOUC2bAyCgPwKqwtWR0
 OeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784147543; x=1784752343;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=O1SIfYYA024H6e7dPyy3uLUFJrUYmP39Feg+PF7PAKk=;
 b=Qg4q8cLoN8FOHgjouKI6+wchCVkacief7F2OCayOE30ZeqT/xX3panHy6wiv8XVjw6
 W0XAuPgZ+pP5TSgCxXqzA8WQnub4Mkw5kYsvaVl8UZKuBld6t7+5VVU9OJzzDLYBikSt
 CoUdAowZ6oqsOPpgB0Bt9CeSAd6BFPoaEUQUIcQPv5aqgUWdaak01df2fBvmvarllvbB
 H7bObCbs1v19uZv3Nht9Ra6VWANil+9PC65oTRT6wIA5/6SaRawHtzm3UQ7gOa9z5K9g
 Xe6+sD1LG2NQq+Se64a9oq0+5u4GwBU+UsgIAch+M6H/EJqDvuKUBhxvkfII7GFJltyD
 YNAw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpeECGsUSejv8DKzMwBDyHOMPI8CBh5+zkyxr3y3XOULmZwNO2erouG6PFQrumvLzGU4m3RGFYGGJ6U@nongnu.org
X-Gm-Message-State: AOJu0YzuJZ1jL6mKsnvdu6jPEB5hQkOnFfrQVgUXILO5Ob0R3QbuJZA2
 wGBxgu6FWJf2P0wIFHRovBLPc58TUvyTPtX9NahAg01oKN1H6pM17Dil8FgclZXe/ZGE2XiY7E8
 aDk58J/BrraupUVWXOwwisyMz2e5ou/u3ebWDpYeHb4V5nzmNC004Uc12
X-Gm-Gg: AfdE7ckbAFdzoCDFtNr/mEjHaTMqRQAL30iXLjaH7+QaPYigYvQlKi2B7GAayi8XSjB
 47WT6P0etBjiqjKJzGfhlSk4pdM0mCDwdL/AcA+mu7Gh+r2f/Z3G+XVfu9EvoYncj3l62y2yFW0
 dpq4ZpKpgxPOt3A/+P0DC3ENTYWbbYNsGg37GGgLeo3FNoe0J2EpddVHU37kQGMwQgDiDQiZA6h
 FC409Cr+DL5gfmQS8FL902RwQw1p1FfPl6C24y8R1CHldt5iJGJYWOShIa93YoJPxK+MmZdB84O
 Yz15KWPrEu2Ox9ZSQnr+yM444LKN51lfKtIT/i39of6lpMqr6Y6Yt8OIDrCjw+Qeja/9/1hWF8F
 qRwKLNrBogEYikwP6YKDyUYxMHgrF/Bwr35A=
X-Received: by 2002:a05:6000:4284:b0:477:3986:9b54 with SMTP id
 ffacd0b85a97d-47f4fca8622mr4705773f8f.20.1784147542541; 
 Wed, 15 Jul 2026 13:32:22 -0700 (PDT)
X-Received: by 2002:a05:6000:4284:b0:477:3986:9b54 with SMTP id
 ffacd0b85a97d-47f4fca8622mr4705747f8f.20.1784147542032; 
 Wed, 15 Jul 2026 13:32:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e029sm19300702f8f.3.2026.07.15.13.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 13:32:21 -0700 (PDT)
Date: Wed, 15 Jul 2026 16:32:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Peter Xu <peterx@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, jasowang@redhat.com,
 armbru@redhat.com, farosas@suse.de, raphael.s.norwitz@gmail.com,
 bchaney@akamai.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com
Subject: Re: [PATCH v19 00/15] virtio-net: live-TAP local migration
Message-ID: <20260715163116-mutt-send-email-mst@kernel.org>
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <fa53bef0-4fbd-445a-9395-379bbfcb3773@tls.msk.ru>
 <20260715114802-mutt-send-email-mst@kernel.org>
 <ales0BaHaS0ZgA2d@redhat.com> <aleut_YyeS_YeYus@x1.local>
 <142f9286-bbc7-4aed-8822-5d560a09daf9@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <142f9286-bbc7-4aed-8822-5d560a09daf9@yandex-team.ru>
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Jul 15, 2026 at 11:21:23PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 15.07.26 19:00, Peter Xu wrote:
> > On Wed, Jul 15, 2026 at 04:52:48PM +0100, Daniel P. Berrangé wrote:
> > > On Wed, Jul 15, 2026 at 11:48:40AM -0400, Michael S. Tsirkin wrote:
> > > > On Wed, Jul 15, 2026 at 06:01:39PM +0300, Michael Tokarev wrote:
> > > > > On 14.07.2026 18:42, Vladimir Sementsov-Ogievskiy wrote:
> > > > > > Hi all!
> > > > > > 
> > > > > > Here is a migration for TAP net backend, including its properties and
> > > > > > open fds.
> > > > > > 
> > > > > > With this new feature, management software doesn't need to initialize
> > > > > > new TAP and do a switch to it. Nothing should be done around
> > > > > > virtio-net in local migration: it just migrates and continues to use
> > > > > > same TAP device. So we avoid extra logic in management software, extra
> > > > > > allocations in kernel (for new TAP), and corresponding extra delay in
> > > > > > migration downtime.
> > > > > 
> > > > > This is quite a big patch set, - is this really worth the effort to do
> > > > > all this just for *local* migration?  What's the possible use case for
> > > > > this in real, - am I right this is just about upgrading the host qemu?
> > > > > And with that in mind, isn't it sufficient to use what we already have
> > > > > (namely, create new tap, start new qemu instance, and migrate the usual
> > > > > way), and tolerate some very minor downtime while the networking code
> > > > > learns the new network topology (isn't it happening almost instantly
> > > > > anyway, and if not, the management can help by sending gratitious ARP)?
> > > > > 
> > > > > I wonder what's the use for this at yandex?
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > /mjt
> > > > 
> > > > Well just theoretically, imagine a big VM, reserving twice the amount
> > > > of memory just to migrate is not nice at all.
> > > 
> > > Don't we already have the ability to skip memory transfer by setting
> > > the "x-ignore-shared" capability, assuming the VM RAM has a shared
> > > memory backing.
> > 
> > Right, IIUC all similar single-host migrations like this series or CPR (or
> > anything else...) should always need to enable x-ignore-shared in the first
> > place.  That's almost always the starting point of optimizing local
> > migrations.. no matter how the memory will be shared (by the same pool of
> > page cache, or persisted over kexec, etc.).
> > 
> 
> Yes, sharing RAM between source and target + enabling x-ignore-shared is a first thing to do.
> 
> This series optimizes TAP recreating. Not only skip recreating but also allow to
> exclude cloud-networking component form live-update entirely, making the process
> simpler (less components involved), and as I already said, reducing corresponding
> downtime.
> 
> -- 
> Best regards,
> Vladimir

So can you explain, how is this better than
1. a persistent tap
2. a non persistent tap that some server gets a hold of

IOW why does qemu need to bother.
-- 
MST


