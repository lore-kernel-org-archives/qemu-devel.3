Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6287DC83030
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 03:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYcrh-0005xi-DH; Sun, 06 Jul 2025 23:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uYcrf-0005wx-QS
 for qemu-devel@nongnu.org; Sun, 06 Jul 2025 23:49:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uYcre-0003ey-6O
 for qemu-devel@nongnu.org; Sun, 06 Jul 2025 23:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751860193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=totgLjqI5c1lZth8Vm5da9UbW4fzqAO66gKPIBJC2d4=;
 b=InqwO5mAHwaKZCthVrDZt414SS+vSxJGgWuXLy/mslmnOsRE2y2FJ3kqn9+BnNbtOFQF6Z
 xBOcX38Wg7skHnb2pHHlyI5Cj4TI2orTLem+VNbTShMMsQv470E+DSVrXqlApUZ94x7n3h
 mz72DzrlaBz9dN3KJKykNeShzh7s2o0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-FzjSSCIRNVOwqbH4fPDkXA-1; Sun, 06 Jul 2025 23:49:51 -0400
X-MC-Unique: FzjSSCIRNVOwqbH4fPDkXA-1
X-Mimecast-MFC-AGG-ID: FzjSSCIRNVOwqbH4fPDkXA_1751860190
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7489ac848f3so4252736b3a.1
 for <qemu-devel@nongnu.org>; Sun, 06 Jul 2025 20:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751860190; x=1752464990;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=totgLjqI5c1lZth8Vm5da9UbW4fzqAO66gKPIBJC2d4=;
 b=TYmCXQj5CXK1Gn4/JENhscD/GKlm9qs1o1SgLukvEYtMOHo2K4wC0wRqE0k0OH/aFH
 Uv3uf/7gcw6xAkWZh3bItydMGTh37TswmIHowM2BkVSyZng+A65aeCnocnfJ2MrzN2EM
 11G4SgpLRF3fqsBog/uYDcu0RkYcgxWl+b4w0cLtRV+EF14zw1+RUULjByiI6JTc4W3w
 I4J/lhHTREFTFw9nOz1hU7YxMw/gpKLQr7hKossF9A2pG2AQgn8vRUL+zPmGPUUvopjv
 Zvz4GHEkPtHg1kUdeZ4cv3RI6L85ZcRiCNeefGlsPacDzXP05J1RdzwpBjRfHfMmjKaP
 rMnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUICLLj6rpEKDSqpWrtyAWXw9FCt/7FZfvJ0prgO+Ea87ZBnsaKNP1pBe4LBnazks3brZuUKpKKifmT@nongnu.org
X-Gm-Message-State: AOJu0YyhhXDGc6uO2E/F+eZBjaqyiDxd17l+ejX8/Lux6lgB0lM9GuB5
 l2evWYBJfs2kG/Nm8F+2ITajXk1qspOK6AvUmPKNZURSSoEA4X+2xk+mD9uMz4p9qLENqCEO+Bu
 cpU7osfWWPqlcLtPScD5cy43PiVcH05qAuydtgRvEroTjQ81CHasJFU3Ytx4v3IdeYft4gBRJp3
 bLJ4xLMYUajgLeTizwu3S2ZwIje3XrSFmfBuPZ1liasw==
X-Gm-Gg: ASbGnct/pYt0TEVviSF1ELLzWipWBXL57ZNGz51+QsJQYKDVxf+teqgTyWHD8LWxX/n
 /CQdgv8FKQ1LeiJ6+sbDYHxhkP+yY0z1BlHqSUCLGKaFmejjzJfwQgyqNmkkPgV5fDOcIdHcQRW
 n7KTw6
X-Received: by 2002:a05:6a00:1307:b0:748:f750:14c6 with SMTP id
 d2e1a72fcca58-74ce8ab16e8mr13809448b3a.14.1751860189737; 
 Sun, 06 Jul 2025 20:49:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkEzP3RLkIbVf/EUviKr2LcgNUmSaQBuyYRU8W2vBRv04IcWz+njkHCxQveBj6SLW+12IN8jz6dEp3sKlVB7M=
X-Received: by 2002:a05:6a00:1307:b0:748:f750:14c6 with SMTP id
 d2e1a72fcca58-74ce8ab16e8mr13809427b3a.14.1751860189276; Sun, 06 Jul 2025
 20:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250703105508.2380494-1-vsementsov@yandex-team.ru>
 <d7a66374-12d3-4b4b-975f-90202d83cbdf@yandex-team.ru>
In-Reply-To: <d7a66374-12d3-4b4b-975f-90202d83cbdf@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 7 Jul 2025 11:49:37 +0800
X-Gm-Features: Ac12FXxXdBaee2PSvvSJCPJI2DOfqBzBQODtPD-hcdTV7ebxpxXWZEmulKk3nrg
Message-ID: <CACGkMEv8rvoDS3PHKjBQeA4qi35BVZF0__FP04EwEeM3frPUnw@mail.gmail.com>
Subject: Re: [PATCH] net/tap: drop too small packets
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Queued.

Thanks

>
>


