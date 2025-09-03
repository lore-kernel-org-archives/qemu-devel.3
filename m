Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0755CA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 05:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utgGm-0003JT-BW; Wed, 03 Sep 2025 01:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1utgGj-0003J0-Mv
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:42:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1utgGh-0001HA-Cf
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756878169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jaru+fic4tIV0nDAFQSAAmsVK7Runa/xYXzjQUV7SCo=;
 b=BOKIKYIxTmQBM8b0MkJ4XyhnKEfcywgnhsp/65x7l/d/YX+g3FSLQH/6iQEgO5V/pbTZqP
 ClrGkD5U/ku6g5HtfG2dnJ+q2PfcvwBuxGph/X3QCfdclmHQbpD6cEPbiQWBJoJkM0wy8N
 DNHnF0DtanvoRvpYsi3ijmWkgQowg6c=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-1enGTOPiMGKBI9V7_fSxOw-1; Wed, 03 Sep 2025 01:42:47 -0400
X-MC-Unique: 1enGTOPiMGKBI9V7_fSxOw-1
X-Mimecast-MFC-AGG-ID: 1enGTOPiMGKBI9V7_fSxOw_1756878167
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-329e55e686dso1952639a91.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 22:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756878167; x=1757482967;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jaru+fic4tIV0nDAFQSAAmsVK7Runa/xYXzjQUV7SCo=;
 b=m/dukdH6b/jbyeg3oQaoQHXf7v8E/h1C83QpFz9eo6GEiWvhsaDLixP4LVBNYlgf64
 O4h3o93IpaL60NV7JPMhQN0SoMrpwwFqPg4m50C7BglI4qslbVjBW1obX/kxhBGSghq2
 eyIbvurITJvXp3iQs84O5tcB0Z/1/Bn5WTmNbMbYnSTpn0PjSPN25+B+hnHQg6chbi27
 j8YDPreCzjTzAJg38BPcH2se3dcq/hKDKufY0wk4aq2REm0aBII/3RVAkbkdVI5H0jf1
 sWRKEUHosCbPPbWEzWNwzywFREjLBkRr1xU4/KjTc5SKFLXO+5ObUnXtiXo8+Um5r337
 Bk1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi+xWQBvj7nNBR6NOf8+T07xQE4DhyyTo7Ze0KndVLur7+FDGda86VFs+drUV1Ml8joV81PnjExUoq@nongnu.org
X-Gm-Message-State: AOJu0Yw6Q1xwKEOiMNVCmIivqTtOOyGjLGhR1R1QzVtqJu0jxE6ddUB6
 cxJ17xTdVuYE4mWVKO+TEE8XjxaFbFukN88VK/3vXXN9+lg1H0qJlk2yTvHOw4cgkKckn+QI4KY
 xDbKnDQsBEbKlHmQScANz9ugKfjCeiaP3JAu2jtELmgwoY6PxUCS4V7fNfV5+Cv2LH2sHVbGb2q
 hb1YYTO0fuWHPZTZkGxATT7gn036bgd2o=
X-Gm-Gg: ASbGncvml0BRISiweBgt41sHpuZ2TOKj62STH0Dhx5ZIMzh+Hci4vaMurpyNg0tf8D4
 PVjixLLeXwRsyb2eKG0/WOZ8plXDFKIz0JP/FP0vntPbXP/5mwHOnAJMulRXpS1c57tIGQESv7o
 o6ifwq9I6rrqznBQaVz4kq0w==
X-Received: by 2002:a17:90b:3c12:b0:321:2b89:957c with SMTP id
 98e67ed59e1d1-328156e29eamr18361312a91.27.1756878166826; 
 Tue, 02 Sep 2025 22:42:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsEb1IjNeObNdmNUSCYV5wa2h9/4NVZvkPf9qN4JpKRTpf1z5m1tCWi/pwaARdUBCXu+HAULZ25yjFsYYSroI=
X-Received: by 2002:a17:90b:3c12:b0:321:2b89:957c with SMTP id
 98e67ed59e1d1-328156e29eamr18361296a91.27.1756878166365; Tue, 02 Sep 2025
 22:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250821142641.359132-1-jonah.palmer@oracle.com>
 <96b2392ae6f091a0d49a74c73122889c78d80dfa.camel@infradead.org>
 <e9623342-e6f3-4b7f-b51c-4b2c1ccc6157@oracle.com>
In-Reply-To: <e9623342-e6f3-4b7f-b51c-4b2c1ccc6157@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Sep 2025 13:42:34 +0800
X-Gm-Features: Ac12FXyM2hAfVpJBz9NNOuOEqeMq8ARf0W8ZZFgEbsFt6oq5YfJD9DzyuG9M4aI
Message-ID: <CACGkMEuWjUdoALFSfkC_a9XkOTP6=E5R-nCpNYCk1pRnhK5cmg@mail.gmail.com>
Subject: Re: [PATCH] net/hub: make net_hub_port_cleanup idempotent
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org,
 eperezma@redhat.com, leiyang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 22, 2025 at 12:39=E2=80=AFAM Jonah Palmer <jonah.palmer@oracle.=
com> wrote:
>
>
>
> On 8/21/25 11:13 AM, David Woodhouse wrote:
> > On Thu, 2025-08-21 at 14:26 +0000, Jonah Palmer wrote:
> >> Makes the net_hub_port_cleanup function idempotent to avoid double
> >> removals by guarding its QLIST_REMOVE with a flag.
> >>
> >> When using a Xen networking device with hubport backends, e.g.:
> >>
> >> -accel kvm,xen-version=3D0x40011
> >> -netdev hubport,...
> >> -device xen-net-device,...
> >>
> >> the shutdown order starts with net_cleanup, which walks the list and
> >> deletes netdevs (including hubports). Then Xen's xen_device_unrealize =
is
> >> called, which eventually leads to a second net_hub_port_cleanup call,
> >> resulting in a segfault.
> >>
> >> Fixes: e7891c57 ("net: move backend cleanup to NIC cleanup")
> >
> > Tested-by: David Woodhouse <dwmw@amazon.co.uk>
> >
> > But I hate it.
> >
> > The lifetime of these objects is confusing, and this patch doesn't make
> > it nicer.
> >
> > Why is it OK for the object to be taken off the list while it still
> > exists and is findable by other pointers? What does it *mean* for it to
> > be in that state? Doesn't it have a refcount? Can't it be unlisted
> > *and* freed only when that refcount goes to zero?
> >
> >
>
> I believe this "off-list but still exists" state is intentional and is
> the model for NIC peer backends. IIUC, it essentially means "detached
> from hub broadcast but owned by the NIC until device teardown".
>
> The net core explicitly transfers ownership of a backend from the global
> list to the NIC without freeing it, so it can be torn down later by the
> device itself. See the comments in qemu_del_net_client and net_cleanup
> in net/net.c.
>
> In other words, a backend can be removed from net_clients and still
> exist (owned by the NIC) until qemu_del_nic cleans it up and frees it.
> There's no refcount today and lifetime is manual.
>
> The real bug here is that hubport's cleanup is not idempotent, not
> necessarily the ownership model itself.
>
> I do agree though that the lifetime of these objects is confusing. And a
> refcount model would be theoretically cleaner, but current code
> explicitly relies on ownership transfer without refcounts.

In the long term, we should consider converting networking code to QOM.

Thanks

>
> ---
>
> Actually, now that I think about it, perhaps we don't need this extra
> 'listed' state and instead can just check 'if (port->hub)' and set it to
> NULL after it's removed from the list.
>


