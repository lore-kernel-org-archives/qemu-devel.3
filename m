Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACC5C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdXs-000744-2z; Fri, 04 Jul 2025 06:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uXdXn-0006yI-LQ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:21:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uXdXh-0000w2-4m
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751624475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9DnjmH5m3RZGvHr1tc7b1GKTed+CpJj8sS8UiupzxE=;
 b=Fecxn4Otx5zagvJoW15RwkTIEFRdyWTnJ5M9rTkVANAKYKAZ0ZZ1ztNgeSheALv7YVvcM8
 BYwNBPseJLz+0NrsamdAH9A9Pofq28FWdeo/Ng0KbGJxbPwWOm2x/08Qv9KnRvmOlHbvEO
 MqR1NOhcQMrXx1x/P3CoZwSiPNZQo70=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-f9T_MbIpMu2XD3N49stjTA-1; Fri, 04 Jul 2025 06:21:13 -0400
X-MC-Unique: f9T_MbIpMu2XD3N49stjTA-1
X-Mimecast-MFC-AGG-ID: f9T_MbIpMu2XD3N49stjTA_1751624473
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ae0c11adcd2so55955366b.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624472; x=1752229272;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A9DnjmH5m3RZGvHr1tc7b1GKTed+CpJj8sS8UiupzxE=;
 b=iyWf9v/ZALdjksgRlv+tIAE37uPjvrSnqBDnYVuj3BPRr9A0l2UlXoW48mbdnhVZCT
 Up8Xz8iFXKMGclkHP3KhbWU8AB6YAi+em1V+9UvLX8k1dWnPylxHBu3bwXy/y6qeCCJJ
 zzmfG9YubCSrVG8wl2k3IHrZ6vhNZdABn5VMtN9us6A9ACouxCso5H9Z9dyPL+TGKqpG
 3JF9kO89YmrBosW/rUDFvtm+kuvCYvD2s8KuzKBUlDpwV2EDz815rDptWNHchadflcPN
 x87xFKEWYPydHhcRCOK3OhsVGknrktKGZuOGS/tHELPE/y2MdgoknCYQqLMd/qUmpk19
 UtrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVnJs2HQDbMZiCmjGkFPgthYYDaZILsFq/F/8mPy/QEGE6tGdt4GQoHO+LqLyMCrNcquzCXITxoHXe@nongnu.org
X-Gm-Message-State: AOJu0Yxmnhm9EZN/Es2Gc3By/V8L+KUujAag+2MN8KVaibpfLHBRkx0m
 d4pW+nwRHP7v+sOjbblpSNd1f1/gWObY/9hDclVWBd9rWZF4BWIG/19yo7B6Qt2StEeOCv4GOJ1
 FnjGvPxUy9xZ369DXF6mz+BFSWKbWaH3wBQug3Kui5PC+wbmK2GTXu2WLlAExPNYqUt5xD/V5dQ
 o+zDeEHZ3cgqNnrC3S91tgh5mLm3I8L5cVa9kht98=
X-Gm-Gg: ASbGnctoMdxKhOzM56RFIRbI+7hNHh//yBuI9+X2M+YAMPEY/43Qx2DoHvwQrVnij2A
 5HRsvv8zoKL1xUl3cj2RYN/GAYjCapv1r8a5mw/wHnWbuqyyp/B6tRjo7DyQ4iguB0BKJMDS7U+
 /bO1Uz
X-Received: by 2002:a17:907:1c15:b0:ae3:674a:9af1 with SMTP id
 a640c23a62f3a-ae3fe6290c6mr144367966b.57.1751624471821; 
 Fri, 04 Jul 2025 03:21:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwZpcWShBT4BZonJ3/Fu50dKwkAtg9mlW8looFfMx4YdL8KzJXa9suHk1WOVWuw/CMnwU7urKTtz08B4rXrEc=
X-Received: by 2002:a17:907:1c15:b0:ae3:674a:9af1 with SMTP id
 a640c23a62f3a-ae3fe6290c6mr144366866b.57.1751624471473; Fri, 04 Jul 2025
 03:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250703105508.2380494-1-vsementsov@yandex-team.ru>
 <d7a66374-12d3-4b4b-975f-90202d83cbdf@yandex-team.ru>
In-Reply-To: <d7a66374-12d3-4b4b-975f-90202d83cbdf@yandex-team.ru>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 4 Jul 2025 18:20:34 +0800
X-Gm-Features: Ac12FXwJq6n_5aca6MOgrfnlib5NWXRqBJIzq30jWWUK8iJofmWEys1jo0X0H1o
Message-ID: <CAPpAL=wQym6xpq_0zDaaoqS=7XmCSCfAT0OL3WHcd94v41Ph6Q@mail.gmail.com>
Subject: Re: [PATCH] net/tap: drop too small packets
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 jasowang@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

I tested this patch with virtio-net regression tests, everything works fine=
.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Jul 3, 2025 at 10:59=E2=80=AFPM Daniil Tatianin
<d-tatianin@yandex-team.ru> wrote:
>
> On 7/3/25 1:55 PM, Vladimir Sementsov-Ogievskiy wrote:
>
> > Theoretically tap_read_packet() may return size less than
> > s->host_vnet_hdr_len, and next, we'll work with negative size
> > (in case of !s->using_vnet_hdr). Let's avoid it.
> >
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > ---
> >   net/tap.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/net/tap.c b/net/tap.c
> > index ae1c7e39832..20d0dc2eb35 100644
> > --- a/net/tap.c
> > +++ b/net/tap.c
> > @@ -172,6 +172,11 @@ static void tap_send(void *opaque)
> >               break;
> >           }
> >
> > +        if (s->host_vnet_hdr_len && size < s->host_vnet_hdr_len) {
> > +            /* Invalid packet */
> > +            break;
> > +        }
> > +
> >           if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
> >               buf  +=3D s->host_vnet_hdr_len;
> >               size -=3D s->host_vnet_hdr_len;
>
> Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>
>


