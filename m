Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422B7C43458
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 05:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkEUO-0006Gr-BQ; Thu, 16 Jul 2026 01:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wkEUL-0006GX-J8
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 01:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wkEUI-0002pD-Tl
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 01:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784179101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8TOuiozhag/A48ygv8wGZfsFSkk31HZmOsR+tutULag=;
 b=PwlJ/0NYUjRuB9eyGw4PbhMZA3biMREB1JNykHHranBP2xV7nF5Z6W8Rwi8tQXa7AGsfjk
 BElrRhNTlHc9C+Mp1kk5h99QPjWl/ru8l6SBcbdB6Hc/EmVwDazlkKcJ8OY/X0o1sYH5gS
 GUEOBAblL0pJE08sMANHsbW03rff2mM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-AzNo52CvNV2dUL2roBD4Yw-1; Thu, 16 Jul 2026 01:18:19 -0400
X-MC-Unique: AzNo52CvNV2dUL2roBD4Yw-1
X-Mimecast-MFC-AGG-ID: AzNo52CvNV2dUL2roBD4Yw_1784179098
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47dfc23ac71so4887209f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 22:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784179098; x=1784783898; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8TOuiozhag/A48ygv8wGZfsFSkk31HZmOsR+tutULag=;
 b=GQYmBbZTU+AoPI7uLyEna1RZCtelTeDHdnn3+y0JRxWfYipgLrOQu0cJcMOeodWBE5
 ZUTD5ffIO61ErHEnJfhHej2XO4T2+cO3jW94nn83AyZQQxG+C2GHQd62PtFY3k3aVjVQ
 phmA12kGMNKW4ITymexMnJDer5TsuRCj3epRn5rjR336znW0tfeMv8F14PT8N86iij4s
 L1FnhibDWVa/LeMxNOMKQ1GrD+zfFRD/sYi9pFtrV34AzEKAPkLkSJ/n79KiwVw56foO
 /YQcZS7ZIG1CdBbaTOiJ1v8URCxrkQfQWZT4uazkQjvfc6wrbzBj1+wKuPCst5r4nxvQ
 wl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784179098; x=1784783898;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8TOuiozhag/A48ygv8wGZfsFSkk31HZmOsR+tutULag=;
 b=iFboZv/ZWVesMQcYShwa3AQ1NMixZpbRmuH+78EDTEb+fCrXyHy6FRPJI2RTr4fqR/
 pD+fibtzNRRY6/FjK7iO7FlibKOqq/pwqANRFtKj1lfnJTN/0t3W+lkrb4SipYap1jnw
 WqncVfPMe8WzaUtR/K++3yoDuZzx3WpyL/ql2auRBq/gKErVaVACqvpeSIrLnDiZa4E4
 E28zgI1Bbf3MHO88BZQgZcgnd4vO1MQVnQtjk5e1BlaEUfCeq5Jl0ELYdzSPUphjZk+Q
 ALMyRYUq4xvdl38Civ9ckrK2KXlofTAMFEtluWWyVAAvD1vEbaXaExPkcyI/rlMfyaEQ
 LtUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNsH7d7FLobYGUtmZLpuh5NfUB2svIRn8N7DEB4a5qxShig7MbTCNMav5x4M9ksFJNERUGuGtDC5/a@nongnu.org
X-Gm-Message-State: AOJu0YxpOAqSg6FZI66Uw2QGNuwVUMTDEg1TAsPcOtmHAXC/OKbzUB0g
 w6XRvP8NQ0VdlH7SRhZhfekA63XS2jFMv/896lBfshW96ssuP5Ym8IXH52EB0slm8+UOxfiJ4vi
 3dgEtR4hqggbLIH18jgxKuZYLrtEIeHwFrDez65bFZSi1hwh55CkrVp/j
X-Gm-Gg: AfdE7cn7GGY7Q5i77oG0Zwr1Cb8OFUQmqFCy+yZx+7+xyh0fKelTfjw47vtMQwXjGEe
 iDHl29h0PDuJfVEXcG+Vmdx23eW9ASN44/fOLVEsJ5zsb54uozCYVxqf8XdQKYRyZLj5VZAXX5d
 KASrc3TKgbIXUOUxYAlQ1dmjAyll6rwAeLSSczXyVpQabPOW086KDaNbMCgd7wiwnKlp2IIQsmi
 TKlfOMWmW9GTaEO/wMv2ogvb+1E4A0In1CGA8jdG+PiQO7viCckmbZEV54uonQlMsy3BGmx0gel
 pD3VtbVf7qOUf6MerJPq7fY6GoqNbNCYDZRvQT/Knk9rka6VwSg/+LRNu0iwu9Sh/8MnZS/ajUE
 Pk01kXx4GMhZW/5ss69suwNmf
X-Received: by 2002:a05:6000:2481:b0:476:504f:7a1 with SMTP id
 ffacd0b85a97d-47f4632fd7dmr14473484f8f.7.1784179097771; 
 Wed, 15 Jul 2026 22:18:17 -0700 (PDT)
X-Received: by 2002:a05:6000:2481:b0:476:504f:7a1 with SMTP id
 ffacd0b85a97d-47f4632fd7dmr14473447f8f.7.1784179097293; 
 Wed, 15 Jul 2026 22:18:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464bbb0esm21946781f8f.28.2026.07.15.22.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 22:18:16 -0700 (PDT)
Date: Thu, 16 Jul 2026 01:18:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Peter Xu <peterx@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, jasowang@redhat.com,
 armbru@redhat.com, farosas@suse.de, raphael.s.norwitz@gmail.com,
 bchaney@akamai.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com
Subject: Re: [PATCH v19 00/15] virtio-net: live-TAP local migration
Message-ID: <20260716011544-mutt-send-email-mst@kernel.org>
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <fa53bef0-4fbd-445a-9395-379bbfcb3773@tls.msk.ru>
 <20260715114802-mutt-send-email-mst@kernel.org>
 <ales0BaHaS0ZgA2d@redhat.com> <aleut_YyeS_YeYus@x1.local>
 <142f9286-bbc7-4aed-8822-5d560a09daf9@yandex-team.ru>
 <20260715163116-mutt-send-email-mst@kernel.org>
 <d62fa0f5-4339-49e1-aeef-85196561a94e@yandex-team.ru>
 <20260715181555-mutt-send-email-mst@kernel.org>
 <7c939f46-482d-4324-8e9f-065e5bb43c33@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c939f46-482d-4324-8e9f-065e5bb43c33@yandex-team.ru>
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Jul 16, 2026 at 03:30:26AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 16.07.26 01:45, Michael S. Tsirkin wrote:
> > On Thu, Jul 16, 2026 at 01:11:05AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > On 15.07.26 23:32, Michael S. Tsirkin wrote:
> > > > On Wed, Jul 15, 2026 at 11:21:23PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > On 15.07.26 19:00, Peter Xu wrote:
> > > > > > On Wed, Jul 15, 2026 at 04:52:48PM +0100, Daniel P. Berrangé wrote:
> > > > > > > On Wed, Jul 15, 2026 at 11:48:40AM -0400, Michael S. Tsirkin wrote:
> > > > > > > > On Wed, Jul 15, 2026 at 06:01:39PM +0300, Michael Tokarev wrote:
> > > > > > > > > On 14.07.2026 18:42, Vladimir Sementsov-Ogievskiy wrote:
> > > > > > > > > > Hi all!
> > > > > > > > > > 
> > > > > > > > > > Here is a migration for TAP net backend, including its properties and
> > > > > > > > > > open fds.
> > > > > > > > > > 
> > > > > > > > > > With this new feature, management software doesn't need to initialize
> > > > > > > > > > new TAP and do a switch to it. Nothing should be done around
> > > > > > > > > > virtio-net in local migration: it just migrates and continues to use
> > > > > > > > > > same TAP device. So we avoid extra logic in management software, extra
> > > > > > > > > > allocations in kernel (for new TAP), and corresponding extra delay in
> > > > > > > > > > migration downtime.
> > > > > > > > > 
> > > > > > > > > This is quite a big patch set, - is this really worth the effort to do
> > > > > > > > > all this just for *local* migration?  What's the possible use case for
> > > > > > > > > this in real, - am I right this is just about upgrading the host qemu?
> > > > > > > > > And with that in mind, isn't it sufficient to use what we already have
> > > > > > > > > (namely, create new tap, start new qemu instance, and migrate the usual
> > > > > > > > > way), and tolerate some very minor downtime while the networking code
> > > > > > > > > learns the new network topology (isn't it happening almost instantly
> > > > > > > > > anyway, and if not, the management can help by sending gratitious ARP)?
> > > > > > > > > 
> > > > > > > > > I wonder what's the use for this at yandex?
> > > > > > > > > 
> > > > > > > > > Thanks,
> > > > > > > > > 
> > > > > > > > > /mjt
> > > > > > > > 
> > > > > > > > Well just theoretically, imagine a big VM, reserving twice the amount
> > > > > > > > of memory just to migrate is not nice at all.
> > > > > > > 
> > > > > > > Don't we already have the ability to skip memory transfer by setting
> > > > > > > the "x-ignore-shared" capability, assuming the VM RAM has a shared
> > > > > > > memory backing.
> > > > > > 
> > > > > > Right, IIUC all similar single-host migrations like this series or CPR (or
> > > > > > anything else...) should always need to enable x-ignore-shared in the first
> > > > > > place.  That's almost always the starting point of optimizing local
> > > > > > migrations.. no matter how the memory will be shared (by the same pool of
> > > > > > page cache, or persisted over kexec, etc.).
> > > > > > 
> > > > > 
> > > > > Yes, sharing RAM between source and target + enabling x-ignore-shared is a first thing to do.
> > > > > 
> > > > > This series optimizes TAP recreating. Not only skip recreating but also allow to
> > > > > exclude cloud-networking component form live-update entirely, making the process
> > > > > simpler (less components involved), and as I already said, reducing corresponding
> > > > > downtime.
> > > > > 
> > > > > -- 
> > > > > Best regards,
> > > > > Vladimir
> > > > 
> > > > So can you explain, how is this better than
> > > > 1. a persistent tap
> > > 
> > > You mean open same tap device both on source and target?
> > > 
> > > This will require some additional steps anyway, to avoid packet loss,
> > > like keeping queues disabled on target until post_load.
> > > 
> > > Another thing is MAX_TAP_QUEUES=256 in kernel: this is a problem, if you have more
> > > than 128 queues already opened on source. Seems cleaner just pass already opened
> > > queues to the target.
> > > 
> > > And finally, on hosts with many CPUs, TAP queue allocate noticeable amount
> > > of RAM, so having x2 queues during migration would be an overhead.
> > 
> > ah I forgot. yes queues do get
> > 
> > > > 2. a non persistent tap that some server gets a hold of
> > > 
> > > You mean, just pass FDs externally, instead of using QEMUs migration stream?
> > > That's possible. But requires mgmt tool to store (or get from source) and pass
> > > these FDs. Requires mgmt to even know about these FDs.
> > 
> > e.g. libvirt already does, right? it creates them?
> 
> Not sure. But even if it creates and passes them to QEMU. Does it store them?
> Libvirt may restart, and it shouldn't break further migration.
> 
> So, we'll need also an API to get FDs from QEMU. To get FDs from QEMU just
> to pass them to target QEMU - I don't think it's more clear solution.
> 
> > 
> > > But why? QEMU already
> > > can pass FDs through migration for vfio devices (CPR), why is TAP worse?
> > 
> > it's not that it's worse. it's that we are growing bespoke mechanisms so far.
> > so if qemu gets tap fd on command line then what? how does that
> > interact?
> 
> Do you mean how this series handles that case? No problem: given on source from command line
> FDs will migrate to the target the same way. Or I don't understand the question.

But right now target gives its own FDs.

> > 
> > > Like with persistent tap, it will require some changes in Qemu anyway, to avoid packet loss
> > > (like patch 12/15 here).
> > 
> > that one is more like a bugfix.
> > 
> > > > 
> > > > IOW why does qemu need to bother.
> > > 
> > > QEMU owns the TAP fd and has full knowledge of its state. Pushing this responsibility
> > > to an external tool means the tool needs to understand QEMU internals just to pass
> > > an fd that QEMU already has. I think, that's a worse separation of concerns.
> > > 
> > > Of course, there are other ways to do TAP local migration. But looking at wider
> > > picture, where we want to migrate not only TAP, but also vfio devices (already
> > > implemented as CPR migration, but may be updated to use similar approach as in
> > > this series, to use one migration channel), vhost-user-blk (my another series
> > > in flight) and vhost-user-fs (not yet published), vhost-vsock migration
> > > ("[PATCH v3 0/7] migration/cpr: support vhost-vsock devices" in flight series),
> > > it seems a good generic approach: simply pass backends (including open FDs) to
> > > the target, not involving mgmt. Qemu has full knowledge about these FDs and
> > > owns the whole state. Migrating them in QEMU looks correct for me.
> > 
> > if you find a way to generalize things and reuse them for your
> > purposes without intrusive changes all over qemu, fine.
> 
> That's not only my purposes (i.e., as I understand, not only Yandex use case).
> Originally the work was started by Oracle (CPR), and I see interest from other
> companies too.
> 
> > 
> > But this one is poking as far as frontend code even.
> > 
> 
> You mean "[PATCH v19 11/15] virtio-net: support local migration of backend" ?
> 
> CPR-approach avoids it, because FDs are passed _before_ any devices created
> on target. Is that better? In this way I don't really like the fact that we
> start to use (call some ioctls) in target QEMU the FDs, which are still
> actively used in running source QEMU . I don't like it, but that works,
> and I started working on live-migration on TAP from CPR tap series by
> Steve. Still, such approach doesn't work with vhost-user-blk, as trying
> to share (even for initialization) the fd between source and running
> target may just break things. So I decided to move to similar approach for both
> net and storage. Do you think it's better to return to CPR-approach for TAP
> (accepting that it won't generalize to vhost-user) like in
> "[PATCH v4 0/8] Live update: tap and vhost" -
> https://lore.kernel.org/qemu-devel/20260128-cpr-tap-v4-0-48e334d4216b@akamai.com/ -
> where both approaches were compared and mine was preferred?

Hmm. Can CPR use yours?

> 
> -- 
> Best regards,
> Vladimir


