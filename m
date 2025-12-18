Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817BBD68BD8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 04:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW5rE-0003ch-RQ; Wed, 17 Dec 2025 23:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vW5rA-0003cU-Rq
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 23:43:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vW5r3-00087P-Qy
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 23:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766032986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q2d8jC028lbc/H6hmnsz1IZVLDj5uDxsf+Rsiyf8Ndw=;
 b=Ks+ebYR6gcOCsOQoofLFMhuXacunWoui6PI27+G16XfyxfRtqEfGhyFyvriUtKti8i9Vq/
 2pVL4EHo4BU0Bnv1SUhcAs/Q1SuXcs/aEaI/MYcmad0zb/fxDg7Y7y+yX/5RdXY8BvQCXv
 W8zG7aTaGPNxozp2KQI76nx2voo78Ro=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-cGTzSthjO_OZ9h-nudsmXg-1; Wed, 17 Dec 2025 23:43:05 -0500
X-MC-Unique: cGTzSthjO_OZ9h-nudsmXg-1
X-Mimecast-MFC-AGG-ID: cGTzSthjO_OZ9h-nudsmXg_1766032984
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-29f25e494c2so2674995ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 20:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766032984; x=1766637784; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q2d8jC028lbc/H6hmnsz1IZVLDj5uDxsf+Rsiyf8Ndw=;
 b=rp7f5+GiQhlKX1pibJ2MgyIm9IysKA5ouVhka00B4wkjiatu19QjC4EYD6g0CfYZaM
 Omy80J22mrBQrWD5KflDu8s0A/soup98JUsvaaXAul7gQ7UnttGv/wmdQwU7DkLDKdmz
 hvWkzjUEP+pLNBti7iNg27h6tB05OwqGO4a4yEW/G2tpjDlNMWY1aoukLwl8f2/uKlaK
 3h2JEYxhMItpFrvHJGJro9HqHGt09dj9xvTDNeHxfkzFAaeDF4jN4+HUGw4ommV88vB2
 cmJOF4nZCK/3X4WQN38sVpl4LEZv64ATIqal8E49vl69eu8ZIV64bYrDIjXSkNfmt83Q
 l6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766032984; x=1766637784;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q2d8jC028lbc/H6hmnsz1IZVLDj5uDxsf+Rsiyf8Ndw=;
 b=UFc0v82DaEOPbLF8foXDPKBA+FUoRZ/QDg8f725IgejpCjELlcDdzVy5pDcaGD/0p8
 XLLmYRT4P51OwFVs3vsENYqvnYCeznNDGkZJw/oQjOcrsXcLWSHtw4PQXPYHbWXQ8qto
 drfX9KZ07S5cFy0kZ81GhsWOgnHoH5Sxf2czGo/I6EOQ71EUnzavn+sas0QwmK6OV8Qc
 v9IZ6fKBieeXGa6hFbhiS8wbVk4K664yku99d7LghhOUJS503KIfW87JkMl16YQfwKWV
 Cv1EPWB11SUzM7TXdvoMhg7rmx1Efo/q47/Th7YJ4ZirtcO8tzIpOPECEriB1iSxdZb9
 d8yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi3iyAFmx/3z/AYqUChQgxq5/WhDF1HlxtKl9gu0f9Rz3Ocg+h5BWnM0YjRjZZT7VvXvzOr9v8shos@nongnu.org
X-Gm-Message-State: AOJu0YxsK50L8KHeT85IaQ9MZUGXX2bSMzfuVgZ92xyEvcO2yiMHQWcN
 6YsLlGZhUcOkaZCxgdugFOht2s6nPAn6LomjgcfxVl8L2DKiaBQhVz+UiPuOb9WOT4w1Fd3VrBe
 +luH7uqraeUytVcsbdLooX/kTe9NlWD5Bok0tbHdGcEPvm7ZTFM+iJcUEHjqFZHj5w90Tn/NiVC
 WQkhowC15BykdVIXHkIdzH0LqIJTfwCLg=
X-Gm-Gg: AY/fxX6JhHgROssPk8epfsKnI6B+mxO+2fWwCZSrvhIzigpDF53TSWGqwwWS9cXygyz
 RY74HINV+izlVVF979wC2Uss86M4gIOdKL2O/hSR57+zyjzD7JwnHjJeQBilNaGzvICYrPE2Izh
 tEyJrorNaGaBkQYh7Uy2UBW3kbLKNSjH593OZ5BjXgHVwan0yQTXJidODivi/SfzcM+yo=
X-Received: by 2002:a17:903:1585:b0:2a0:89c6:1824 with SMTP id
 d9443c01a7336-2a2caab715emr16850905ad.8.1766032983999; 
 Wed, 17 Dec 2025 20:43:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0J5g1GiiBgIgLU9O05AbNDmxL8stWdEHFCrGtEBqGoWBXd7xmflAqMbQafBVB4TK+d5gKmDk/mb7msJBwW0s=
X-Received: by 2002:a17:903:1585:b0:2a0:89c6:1824 with SMTP id
 d9443c01a7336-2a2caab715emr16850675ad.8.1766032983514; Wed, 17 Dec 2025
 20:43:03 -0800 (PST)
MIME-Version: 1.0
References: <20251028160042.3321933-1-peter.maydell@linaro.org>
 <59fa1ff9-6bf3-473a-bec8-8e7e2f3cba9c@tls.msk.ru>
In-Reply-To: <59fa1ff9-6bf3-473a-bec8-8e7e2f3cba9c@tls.msk.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Dec 2025 12:42:51 +0800
X-Gm-Features: AQt7F2r8NqIsY2RmFMtd5S6dN5Td1diLAonFfla6dqJ_SxpOJBSgyUTWmOOd3D8
Message-ID: <CACGkMEvKU4XYY9366j0D0xeE7rUhZFeo=e0bZ7oZ5BG70_fHfw@mail.gmail.com>
Subject: Re: [PATCH] net: pad packets to minimum length in
 qemu_receive_packet()
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Bin Meng <bmeng@tinylab.org>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Dec 17, 2025 at 6:56=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 10/28/25 19:00, Peter Maydell wrote:
> > In commits like 969e50b61a28 ("net: Pad short frames to minimum size
> > before sending from SLiRP/TAP") we switched away from requiring
> > network devices to handle short frames to instead having the net core
> > code do the padding of short frames out to the ETH_ZLEN minimum size.
> > We then dropped the code for handling short frames from the network
> > devices in a series of commits like 140eae9c8f7 ("hw/net: e1000:
> > Remove the logic of padding short frames in the receive path").
> >
> > This missed one route where the device's receive code can still see a
> > short frame: if the device is in loopback mode and it transmits a
> > short frame via the qemu_receive_packet() function, this will be fed
> > back into its own receive code without being padded.
> >
> > Add the padding logic to qemu_receive_packet().
> >
> > This fixes a buffer overrun which can be triggered in the
> > e1000_receive_iov() logic via the loopback code path.
> >
> > Other devices that use qemu_receive_packet() to implement loopback
> > are cadence_gem, dp8393x, lan9118, msf2-emac, pcnet, rtl8139
> > and sungem.
> >
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3043
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Hi!
>
> Somehow I ended up picking up this change to all active-at-the-time
> qemu stable series, including 7.2.x.  Without realizing the problem
> this change fixes does not exist in 7.2 to begin with - since commit
> 140eae9c8f7 is qemu 8.1, not 7.2.
>
> Am I right this change is harmful but not very useful for 7.2?

Yes, I think so.

Thanks

>
> Thanks,
>
> /mjt
>
> > ---
> > I think this is the right fix, but I'm not very familiar
> > with the net internals...
> > ---
> >   net/net.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/net/net.c b/net/net.c
> > index 27e0d278071..8aefdb3424f 100644
> > --- a/net/net.c
> > +++ b/net/net.c
> > @@ -775,10 +775,20 @@ ssize_t qemu_send_packet(NetClientState *nc, cons=
t uint8_t *buf, int size)
> >
> >   ssize_t qemu_receive_packet(NetClientState *nc, const uint8_t *buf, i=
nt size)
> >   {
> > +    uint8_t min_pkt[ETH_ZLEN];
> > +    size_t min_pktsz =3D sizeof(min_pkt);
> > +
> >       if (!qemu_can_receive_packet(nc)) {
> >           return 0;
> >       }
> >
> > +    if (net_peer_needs_padding(nc)) {
> > +        if (eth_pad_short_frame(min_pkt, &min_pktsz, buf, size)) {
> > +            buf =3D min_pkt;
> > +            size =3D min_pktsz;
> > +        }
> > +    }
> > +
> >       return qemu_net_queue_receive(nc->incoming_queue, buf, size);
> >   }
> >
>


