Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2521C369C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 03:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6hez-0007Qk-J2; Sun, 20 Apr 2025 23:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u6hex-0007QX-TC
 for qemu-devel@nongnu.org; Sun, 20 Apr 2025 23:17:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u6hew-0001xI-8f
 for qemu-devel@nongnu.org; Sun, 20 Apr 2025 23:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745205445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Ph6UnaKYzyRAIqcdJfzBVZGEKqj8hksRTdh3Z0o1mo=;
 b=MB8qlbdgw51CR1xlTAqZOlD0cepZJM7JwdMA7+K/SOpXg1ZKU7//fjJ4LFcjSgTawAvNYN
 P00XUeNPw411GZfe+8mCUM/M3zxLUx9j4Yut/hQpq05hfrMDC8+Ga0VE1LMsdEpDw2LN88
 POQvVk02v7qvJ+gVERYSzad3W3Yanxs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-f1NLNKBdNjeChUOdKpTglg-1; Sun, 20 Apr 2025 23:17:21 -0400
X-MC-Unique: f1NLNKBdNjeChUOdKpTglg-1
X-Mimecast-MFC-AGG-ID: f1NLNKBdNjeChUOdKpTglg_1745205441
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3032f4eca83so3101260a91.3
 for <qemu-devel@nongnu.org>; Sun, 20 Apr 2025 20:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745205440; x=1745810240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Ph6UnaKYzyRAIqcdJfzBVZGEKqj8hksRTdh3Z0o1mo=;
 b=gydywwj+qzR22INoatD5pr8pg95xRG7migliK33IsK6CHwzut1AVNiY42n1YtO7PtK
 dm00fTVK4HrMKXEQvL7MrbxpAmjFcQRiwD6KwxZhLkUQf8ZhIGeS6ctj7Ed49rY78Nkq
 9fzPMWJObnfzpWGFwahwGfMp691pjoTuoxxpOqsVSQaEPKOEzQvFZlj+9zcrF8DvBHDt
 c7kurkfPBFmVY//sVi312skw1d0tISJqx4o1SN1g6uYkRBMkc5aSMoN1iEFqPuZ/J1CJ
 CkZkW1OyUtsxKCkD9tEcM85zmXSmYOxGHTnxSWEY06BXs3STh1TpXviHChoORqTEO/Fs
 B8kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkm8CiiUkHim5kszDV1SVaGXhdpTUjOeanKw7h7oD7TcDRd5Js2QYIV5exnA3ceOuq8bVijnT0SsNB@nongnu.org
X-Gm-Message-State: AOJu0YxoHxGoyfnCf2Huvjs+Z1p0wpT5qhzmQo4f5D1dqs0W2So7G4Lw
 lOIahdAC+eZFFiIo2T5DXhpj0ZmKK7XlA1JQIpdrdPAsHcLPc1bev1rRMFmFGRJFauQtegLoxP+
 uG8PJk11QjdDE9l0yvkfEhmIfGkd3HL8pY9RkTE2dvkrWMOKuYkoYUeSjB2QzYKdd9MFLgu02ow
 quPwz8SOlshNxKTeQNhgws1Mp5kPE=
X-Gm-Gg: ASbGnctTn+UCodGjrylAld6KqgVf92neFOkE5D3UH5vSV6EksP+qCbY5l7acBQRa0rt
 bmT6uWT+ryFvssAvrP/ihWqm0lZsufCV4EgZ2ejMRugIsqYmj9+MQR9m/jJ+bN192QnY+Og==
X-Received: by 2002:a17:90b:4c84:b0:2fe:ba7f:8032 with SMTP id
 98e67ed59e1d1-3087bb5324cmr17410708a91.9.1745205440595; 
 Sun, 20 Apr 2025 20:17:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrB1/wB/USOzu70Gwo6gCmhnAQBNOVDUFo0G7Mzi9CYkU4UCH3c4T1p7VMtQXockYk5tkhTaOzoW4A8lcC9mA=
X-Received: by 2002:a17:90b:4c84:b0:2fe:ba7f:8032 with SMTP id
 98e67ed59e1d1-3087bb5324cmr17410679a91.9.1745205440189; Sun, 20 Apr 2025
 20:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250417102522.4125379-1-lulu@redhat.com>
 <20250417102522.4125379-2-lulu@redhat.com>
 <CACGkMEvrX0FouHnrog_GV7Rjtwao+ZU50U-2BpuaceSMz_hmNw@mail.gmail.com>
In-Reply-To: <CACGkMEvrX0FouHnrog_GV7Rjtwao+ZU50U-2BpuaceSMz_hmNw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Apr 2025 11:17:08 +0800
X-Gm-Features: ATxdqUEU87DYBDpRl_hIc9OlhtbQGKgiAYNHSyWHJNsvRnnenjMpOrapZWms09E
Message-ID: <CACGkMEtt8rrhVh9j2U2fLnLgJwu6NpBJdu0+LdLXz-Yqi9M2pg@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] vhost_vdpa : Add a new parameter to enable check
 mac address
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.69,
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

On Mon, Apr 21, 2025 at 11:14=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Thu, Apr 17, 2025 at 6:25=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > When using a VDPA device, it's important to ensure that the MAC
> > address is correctly set.
> > This patch adds a new QEMU command line parameter to enable MAC
> > address verification,  which is enabled by default.
> >
> > Usage example:
> > ....
> > -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0=
,check-mac=3Dtrue\
> > -device virtio-net-pci,netdev=3Dvhost-vdpa0\
> > ....
> > To disable this check:
> > ....
> > -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vdpa0=
,check-mac=3Dfalse\
> > -device virtio-net-pci,netdev=3Dvhost-vdpa0\
> > ....
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> This patch needs to be squashed to the patch that implements the real
> logic of the checking.
>
> > ---
> >  include/net/net.h | 1 +
> >  net/vhost-vdpa.c  | 5 +++++
> >  qapi/net.json     | 5 +++++
> >  3 files changed, 11 insertions(+)
> >
> > diff --git a/include/net/net.h b/include/net/net.h
> > index cdd5b109b0..fac1951b6e 100644
> > --- a/include/net/net.h
> > +++ b/include/net/net.h
> > @@ -112,6 +112,7 @@ struct NetClientState {
> >      bool is_netdev;
> >      bool do_not_pad; /* do not pad to the minimum ethernet frame lengt=
h */
> >      bool is_datapath;
> > +    bool check_mac;

Rethink of this, it is vDPA specific, we probably need to move it to
VhostVDPAState instead.

Thanks


