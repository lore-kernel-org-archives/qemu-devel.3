Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA10C44507
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 21:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk75I-0007EE-AJ; Wed, 15 Jul 2026 17:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wk75H-000773-52
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 17:24:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wk75F-0002u1-34
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 17:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784150639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cK6S+XRa3tXIupuLZk0/J8QrlqD5SDzC1K/IIVmIC60=;
 b=h9cu3IxeTlOM957OK8DhznuQtCSo/njeiBOQGGBjBTTghKbkAWmCoukRudbObP2XxAZD5u
 64zXTVVC91VIi05KNkG+lc2yoO4MZJoinLIp+w58ARIUU78eF78sgyYOlpDbeHuztI0iuW
 4kaYeKTrdj6wcjrU94iHSm0aTK3h0CI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-se3cfE2MOv6EeILJY5FlnQ-1; Wed, 15 Jul 2026 17:23:58 -0400
X-MC-Unique: se3cfE2MOv6EeILJY5FlnQ-1
X-Mimecast-MFC-AGG-ID: se3cfE2MOv6EeILJY5FlnQ_1784150637
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47407691804so4266758f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 14:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784150637; x=1784755437; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cK6S+XRa3tXIupuLZk0/J8QrlqD5SDzC1K/IIVmIC60=;
 b=tSIucBzXMeHDO8bJAq1mdpO0wRQMBtaxFQNY92BaTn9fYnWkC74byDW8bUiviz32Vq
 RPyGNNfUd1hWVc80VINo35iGll5J2iQfNFAXO0Wp0fZSKUoR5KKdz5HnrLSi8ebTr4Wd
 bX9S6aMbmjtmTA7mGZAo/b8bZ6EIrZtNrOEIl/TFxo9S7DdZvnXl3OnttVxsi29D0+lg
 /fQAL5M8ivGbPQginQxMddr/6TLer3WpAyO7mtD653hHG+vJB2r1uitkyZ2zsKO8WeXu
 Z9Bk/QDktWYeSd654GIO8XuuXcFY97VL0Q6u/WzTehJ5zCb9POy/nPjKiJA6+R1Q9YnD
 4z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784150637; x=1784755437;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cK6S+XRa3tXIupuLZk0/J8QrlqD5SDzC1K/IIVmIC60=;
 b=iDuqCugPs4W0W2yzRL1vlruph24oTOQ3IvTBGzqWDkwjlkmQgg/e6GRvi7kzzDmfPY
 N66RtRCbr5HtrNeRAgXes8DQgVCjg5y32YBPq6Ymagbmg0ycL4SXaD7utCxGJ3375EBl
 vJik9RWMdhdrEQ/x1Wbp9ImtnZDOFubxgzrNh451QFwyBYeGvGaL+r8ITt8zg7ybOo6d
 cO4cMTbc9isjZiwnk1coXgjQm8KKGKlgjHVpviP44EclyN4xJ9r/sr1M1m2T1Lx0bs5f
 m6WZYwGEWB477Eo9jriPNI05ux4OmZpe/7VLH2qgnxxgxLxwx064rSeMCnxjXv9V6Rzo
 qipA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoA0246Ux9e910k6Atf12Ly6VP2TQfEHR4mlAHY3gst2SJpTxrPufaSutc3i//UUxo0GgHcmVEweQqL@nongnu.org
X-Gm-Message-State: AOJu0Yz/WnhZag7XcPUZ4otw7evrg4EsrKil00D3HgEeYAMurWllwjTl
 gJRmuQJT147r2tn0onzsPGx/ODJwdLGlmYEatdK3Oi2Kbq1KXSPX39mt+AmdJa/BOMHj+kkt2S0
 H/XW0UQyI4mvsCIjibtCJ3s++e5hIQi1rqo1CycU+fnZEAVh3vdqUKseL
X-Gm-Gg: AfdE7ckGWZgIwu0ZtQ9nqbBmnHoqDU/OIsfeOa5yOs52MZs3tpwgSSgdbLWIBvevea+
 l7miXfqMxKOMvLm6V4cTrzYZHUetVW4lFiHb1dgB5CuFrcC6QhDpMK/6WnOmt96C14wvsREUG6X
 1oTPa13nDW+bedE2+9tST0rvHtoY5Wg5hq2YP6Zyw4YN/X4LtnqLTgxcijZMnvugGKizoNLr85J
 j9zHwGSSKTD3UfQbzfRFx6nMh48OXFuiSUh3H1Olj2Km+XnrH/bAX58lnJlwSFr6/zV5FyKu7Vc
 zAQyyYrpOnMrJk/UBnbj7uJrwIGgYHj/M/C+oS/p5RRA7oehhwLbAZUhtOxIbOT7foD77hC9vyn
 upgL/SEkBPFLXdoIkcoh9h5cp
X-Received: by 2002:a05:600c:1393:b0:495:3eb2:b763 with SMTP id
 5b1f17b1804b1-49541ea3f27mr5054775e9.21.1784150636457; 
 Wed, 15 Jul 2026 14:23:56 -0700 (PDT)
X-Received: by 2002:a05:600c:1393:b0:495:3eb2:b763 with SMTP id
 5b1f17b1804b1-49541ea3f27mr5054415e9.21.1784150635925; 
 Wed, 15 Jul 2026 14:23:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464b7e22sm18321633f8f.25.2026.07.15.14.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 14:23:55 -0700 (PDT)
Date: Wed, 15 Jul 2026 17:23:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Michael Tokarev <mjt@tls.msk.ru>, jasowang@redhat.com,
 armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com
Subject: Re: [PATCH v19 00/15] virtio-net: live-TAP local migration
Message-ID: <20260715172140-mutt-send-email-mst@kernel.org>
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <fa53bef0-4fbd-445a-9395-379bbfcb3773@tls.msk.ru>
 <7453c24d-7daf-4dfb-9e16-0d6f4e1f6d76@yandex-team.ru>
 <20260715161756-mutt-send-email-mst@kernel.org>
 <4e406518-2668-497e-80cd-9b50db8dfa21@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e406518-2668-497e-80cd-9b50db8dfa21@yandex-team.ru>
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

On Wed, Jul 15, 2026 at 11:48:02PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 15.07.26 23:20, Michael S. Tsirkin wrote:
> > On Wed, Jul 15, 2026 at 11:10:28PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > On 15.07.26 18:01, Michael Tokarev wrote:
> > > > On 14.07.2026 18:42, Vladimir Sementsov-Ogievskiy wrote:
> > > > > Hi all!
> > > > > 
> > > > > Here is a migration for TAP net backend, including its properties and
> > > > > open fds.
> > > > > 
> > > > > With this new feature, management software doesn't need to initialize
> > > > > new TAP and do a switch to it. Nothing should be done around
> > > > > virtio-net in local migration: it just migrates and continues to use
> > > > > same TAP device. So we avoid extra logic in management software, extra
> > > > > allocations in kernel (for new TAP), and corresponding extra delay in
> > > > > migration downtime.
> > > > 
> > > > This is quite a big patch set,
> > > 
> > > You probably haven't been following Steve's work (about 5 years) on
> > > CPR Live Update :) My patch set is small.
> > > 
> > > > - is this really worth the effort to do
> > > > all this just for *local* migration?  What's the possible use case for
> > > > this in real, - am I right this is just about upgrading the host qemu?
> > > 
> > > Exactly. You say "just for", but actually local migration is a lot more
> > > "massive" operation for us. Remote migrations are done mostly to release the
> > > physical server for service/redeploy (you should first migrate all the
> > > vms to other servers).  That's a relatively seldom operation.
> > > 
> > > On the contrary, when updating to new QEMU version, you migrate _all_
> > > vms on _all_ servers.  These (minimal) downtimes affects all the
> > > customers, some are sensitive to freezes.
> > > 
> > > > And with that in mind, isn't it sufficient to use what we already have
> > > > (namely, create new tap, start new qemu instance, and migrate the usual
> > > > way), and tolerate some very minor downtime while the networking code
> > > > learns the new network topology (isn't it happening almost instantly
> > > > anyway, and if not, the management can help by sending gratitious ARP)?
> > > > 
> > > > I wonder what's the use for this at yandex?
> > > > 
> > > 
> > > This series together with similar about vhost-user-blk local migration
> > > gives several times win in freeze-time. It's significant for us.
> > > 
> > > -- 
> > > Best regards,
> > > Vladimir
> > 
> > 
> > I believe it is.
> > But let's focus on what exactly are we saving here.
> > It is not that clear.
> > 
> > Is it the overhead of tap losing state such as
> > bridge forgetting the tap mac. Or what?
> > 
> 
> I don't have a full expertize here, but the overhead is in switching
> to a new TAP in our cloud virtual networking component.


So what is wrong with
1. using a persistent TAP
or
2. starting a server and handing out these FDs?

> Could this
> switching be optimized, to always work very fast? That's a good
> question that I don't have an answer to. Probably yes.
> 
> We decided to go another way: drop extra components from the process,
> and avoid any extra switching at all. Both cloud networking component, and
> storage (with vhost-usr-blk live-udpate series) don't even know, that
> QEMU is migrating. That seems to be a clear design for local migration,
> and shows good results.
> 
> -- 
> Best regards,
> Vladimir


