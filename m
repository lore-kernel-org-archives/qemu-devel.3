Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725F1C7115B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 03:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTu44-00074R-DM; Mon, 23 Jun 2025 23:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uTu41-00074D-QN
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 23:11:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uTu3z-00030p-G8
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 23:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750734670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zym72MgY0cen2fhR6Whp7aGRbKjS4E38R+vZxOcBX/k=;
 b=MwCieku3QRDOOBNbpU46duJpsLYa6rQ5Ck192yU4Pmx55e/bk+76wwLDRZj1vPKdNXQ6Pz
 xXlk6RpRPsgfF1FsYr0bJhQryfhsoQEYiHuFknmCxmJkfM+wlq96pasZCxhEryEdQ88wf4
 2OkrOxMh7drKS7ItMy+TNYcwkqvxOhM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-vhJO6rxFO5CKe7sfU7rNow-1; Mon, 23 Jun 2025 22:57:56 -0400
X-MC-Unique: vhJO6rxFO5CKe7sfU7rNow-1
X-Mimecast-MFC-AGG-ID: vhJO6rxFO5CKe7sfU7rNow_1750733875
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ad5697c4537so437626966b.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 19:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750733875; x=1751338675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zym72MgY0cen2fhR6Whp7aGRbKjS4E38R+vZxOcBX/k=;
 b=EicDR269WKRZpk1MVfRW8n9E86uHg97+M1ufzMlO9F+gyFR8cd97qIda8L3hvaBCD/
 sWGmEgy2mCJdh01OizvPSqAWOEaw+zF/SxchZeiCHN7Fjp6fTW0gKO9mE+pd+j6w+sqA
 drH0IK3+A3DATYlqyTLAcx89vFsyH4tMTZR4VLTKTeTqvlX5MOK01ovPnOqr9IAb17NK
 tFT8O3ePsyjlFz7VhiQEV0Ur4KwjCoK5ELY0hvv+4rKW0pFOqYxNElqPTxKaWdTdiVgL
 B0vixfWGWhceAQPBYj9sPHFRBI/1xlWSpDIKxbQvbNOo5owI8V100RdZ5Oroh0V6j5pO
 gtTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV01ClgRQciKduRjmI5VPfZl3h0nPAG4aZlfZ/Gyvsbh1SJI3015+Dfz7gtSvzjh5XihgHAyfYZtxbO@nongnu.org
X-Gm-Message-State: AOJu0YzVmMTI2FaUG7ue3Ba3U9I2mrsNuO22Xy5R46Arqd9a5hFMOJlU
 5Z7xSfNHPkRxHo0LDeHVmGgyXoUZ/566g/ugUW9eMAKqSwFYYNPb/hszKFzRplW0bIvAcAmiSWx
 SjXoTQikzsvDLZHaeyqeN97cEpWFJEfEIhyr46FrN1IJwKNjpVX8lKj7oAQYfoCLc1jHyPSkfW7
 78i3p4lMEuTskV/v/IbFzA7qBRHJL3o5I=
X-Gm-Gg: ASbGncuitBnHDEuQLgA/xqUIvfV5kb0a8VZPJx9LiDx/hnG0sBAXkYS7jvfbYxPgdKo
 tIVNU0E7klqXQO2hrEtLWbKbL5rRxR1kTFFIl12YhL/2mBXBFi68EyglOKOFx9zA1ZPFgH5+fjF
 3LvEap
X-Received: by 2002:a17:907:3da3:b0:ae0:a245:2ff4 with SMTP id
 a640c23a62f3a-ae0a6fe05efmr193913366b.0.1750733875312; 
 Mon, 23 Jun 2025 19:57:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWqvT6Vhcat6Fu9D/62IgTqefRbAk0xloeNtaQMaGyyG95HHdFLnxtfBQcxxBjzXsZcgoBujBmH1C54prvDe8=
X-Received: by 2002:a17:907:3da3:b0:ae0:a245:2ff4 with SMTP id
 a640c23a62f3a-ae0a6fe05efmr193910966b.0.1750733874868; Mon, 23 Jun 2025
 19:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250618083930.451313-1-lvivier@redhat.com>
 <CACGkMEv1r+-MUpoPZ2Va-b-dkjB2prHYhtZEtUB7-s1CZCBFdA@mail.gmail.com>
 <b1a9b090-e8f2-4e80-943a-001db1229707@redhat.com>
 <CACGkMEutttY=+4GuMZxe5jigx4x_NVNqccqJvL2swYtP=B11dw@mail.gmail.com>
In-Reply-To: <CACGkMEutttY=+4GuMZxe5jigx4x_NVNqccqJvL2swYtP=B11dw@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 24 Jun 2025 10:57:18 +0800
X-Gm-Features: Ac12FXz5HW6UXG-5mPCZURzgj0v-F-MMNqei4U7ZB4wuklLrZiF89VIJ4oc2xkU
Message-ID: <CAPpAL=wQhoRUs8vROv0QC-5opAU0A_y1nQ5RQ0tuZm_XXMn7Mw@mail.gmail.com>
Subject: Re: [PATCH 0/8] net: Add passt netdev backend
To: Jason Wang <jasowang@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Because of these code changes the virtio-net files, CI triggers
regression tests for it with virtio-net, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Jun 24, 2025 at 8:41=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Jun 23, 2025 at 4:10=E2=80=AFPM Laurent Vivier <lvivier@redhat.co=
m> wrote:
> >
> > On 23/06/2025 10:03, Jason Wang wrote:
> > > On Wed, Jun 18, 2025 at 4:39=E2=80=AFPM Laurent Vivier <lvivier@redha=
t.com> wrote:
> > >>
> > >> This series introduces support for passt as a new network backend fo=
r
> > >> QEMU.
> > >>
> > >> passt is a modern, unprivileged, user-mode networking solution that
> > >> provides guest connectivity by launching an external helper process.=
 This
> > >> series adds the core backend and integrates it with vhost-user for
> > >> high-performance, accelerated networking.
> > >>
> > >> The series is structured to first improve the general networking cod=
e
> > >> before adding the new feature. The first patch extracts from the str=
eam
> > >> backend the functions that will be reused in the passt backend. The
> > >> following patches are a preparatory refactoring to decouple the gene=
ric
> > >> vhost layer from specific backend implementations (tap, vhost-user, =
etc.).
> > >> This is achieved by replacing hardcoded type checks with a callback-=
based
> > >> system in NetClientInfo, making the vhost infrastructure more modula=
r and
> > >> extensible.
> > >>
> > >> With the refactoring in place, subsequent patches introduce the pass=
t
> > >> backend itself, reusing the generic stream handling logic. The final
> > >> patch adds vhost-user support to passt, which plugs cleanly into the
> > >> newly refactored vhost layer.
> > >>
> > >> Some benchmarks:
> > >>
> > >>   Reference '-net user':
> > >>
> > >>    -net user,hostfwd=3Dtcp::10001-:10001
> > >>
> > >>      iperf3 -c localhost -p 10001  -t 60 -4
> > >>
> > >>      [ ID] Interval           Transfer     Bitrate         Retr
> > >>      [  5]   0.00-60.00  sec  14.2 GBytes  2.03 Gbits/sec    1      =
      sender
> > >>      [  5]   0.00-60.00  sec  14.2 GBytes  2.03 Gbits/sec           =
       receiver
> > >>
> > >>   New backend '-netdev passt'
> > >>
> > >>    -netdev passt,vhost-user=3Doff,tcp-ports=3D10001
> > >>
> > >>      iperf3 -c localhost -p 10001  -t 60 -4
> > >>
> > >>      [ ID] Interval           Transfer     Bitrate         Retr
> > >>      [  5]   0.00-60.00  sec  27.1 GBytes  3.88 Gbits/sec    0      =
      sender
> > >>      [  5]   0.00-60.03  sec  27.1 GBytes  3.88 Gbits/sec           =
       receiver
> > >>
> > >>    -netdev passt,vhost-user=3Don,tcp-ports=3D10001
> > >>
> > >>      iperf3 -c localhost -p 10001  -t 60 -4
> > >>
> > >>      [ ID] Interval           Transfer     Bitrate         Retr
> > >>      [  5]   0.00-60.00  sec   224 GBytes  32.1 Gbits/sec    4      =
      sender
> > >>      [  5]   0.00-60.05  sec   224 GBytes  32.0 Gbits/sec           =
       receiver
> > >
> > > Do we have latency numbers of even PPS?
> >
> > Could you propose tools and tests I can run to have these numbers?
>
> For latency, we can use netperf -t TCP_RR.
> For PPS, we can use pktgen, kernel source has samples under
> samples/pktgen, pktgen_sample03_burst_single_flow.sh could be a good
> script, please make sure burst is used in the test to stress the
> virtio-net as much as possible.
>
> Thanks
>
>
> >
> > Thanks,
> > Laurent
> >
>
>


