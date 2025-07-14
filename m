Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EB1C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 02:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ub8gU-0004uh-8N; Sun, 13 Jul 2025 22:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ub8gJ-0004pR-2B
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 22:12:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ub8gG-00079o-VS
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 22:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752459155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c1jYc9smeyo7EeooRqNPFsCI0KnfvamMk31E3P62jrg=;
 b=Rw9ZM9DutWLVBtSvgi3DmOavYFHe+ZnvBHrbzLbjtHwxLEWnlaZmHH2Bh7YcZVyj2sDLTP
 kB+1q7+ZI6kt98k6HyApvOODnMOqin5CxW2DTSRSrnSxogonqKnOXiMg99o6Fhg9DKg0nH
 iwhTwEVrfVhIVzQOGBMROmDmELGwa5E=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-k2JNKAaRM8OPhxyuiegQBg-1; Sun, 13 Jul 2025 22:12:33 -0400
X-MC-Unique: k2JNKAaRM8OPhxyuiegQBg-1
X-Mimecast-MFC-AGG-ID: k2JNKAaRM8OPhxyuiegQBg_1752459153
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31215090074so7274753a91.0
 for <qemu-devel@nongnu.org>; Sun, 13 Jul 2025 19:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752459152; x=1753063952;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c1jYc9smeyo7EeooRqNPFsCI0KnfvamMk31E3P62jrg=;
 b=u3whZd5r0icd6H+85eHMflxpel2bNZA+p4X5L7+iAen0iKiZUZqJNatSY88DQoe6Mk
 7t8YGV0Yh/mcwQNril+RWCsHqZRk8OmWHxPdDzsTTWv/D0ERX+j8l7T1sRy/7iMllPSz
 2Wie5QlC8mxwweLFoUMwnZq4WmF3CL8zoTNYx3EaD5LQo7LqE6fn/y8C+q8HtiqmQtOD
 mHSxbZlxQYrH7mC+tLlGBWPFyE0ouk4QkogPxq5fbkPflHizbUS973isCM/lejJIFljo
 hRzJdKzzTuZT/H6EuKyedf/b3UwCX3IVXS7aAD4MxblYl8r/h8+Gau18h0nGylf40SG1
 n8/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8lu2j8Hh4NlPnATO4eeedQz8vIBZsq3re80UQHFovauk34GCmWLrUoNjFDlNaO5YguJu656Q+1dEb@nongnu.org
X-Gm-Message-State: AOJu0YzxpuUlsxorS14ZFQAe3WcMm7qtat4z9LWGrigvFIrN327XbOJ7
 c3YQtb2o+Yj4KI4H0XOFLjc25YuX368u2pDPPZZqGDJELJ0iRpjsylUsd8+6mgWbLTJEw3n6FTV
 YzR3VdfTs+v6/MSOWsy6zW6DfPAyLb10l1QTuGeM6M55evFtmx0jh6g7UJ6b1JgMjeWRnzvympo
 RMobMx+qyHE1DfRhMQ4+4HXxO+JCfOQXCbU1+3nH50WQ==
X-Gm-Gg: ASbGncv2Ae1kUl40iEibyiziupUKSlXvPoOyLJbojMifXzfMCf4eRAfK8JAFx8pPHTH
 VOtdamLd+kJOdGZ/owWSW184B5vEVYo6tBRNtEPY+aZ+k/gGatJZ4lQPIt1AI/0nTCgVryHhg8d
 aNiP+A2VgYx4fUmKSOni9E
X-Received: by 2002:a17:90b:5710:b0:312:e731:5a66 with SMTP id
 98e67ed59e1d1-31c4f4b56b7mr16247756a91.3.1752459152359; 
 Sun, 13 Jul 2025 19:12:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUd9L24/naFtX3s4qi7gU/2Vu95uSTWo6po91q1JtdHAbg/7nT3+a6at2WXiDVZDZw3e2BpURfbAS0+co7Pa4=
X-Received: by 2002:a17:90b:5710:b0:312:e731:5a66 with SMTP id
 98e67ed59e1d1-31c4f4b56b7mr16247721a91.3.1752459151885; Sun, 13 Jul 2025
 19:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250703105508.2380494-1-vsementsov@yandex-team.ru>
 <d7a66374-12d3-4b4b-975f-90202d83cbdf@yandex-team.ru>
 <CACGkMEv8rvoDS3PHKjBQeA4qi35BVZF0__FP04EwEeM3frPUnw@mail.gmail.com>
 <40114688-ffc6-4f33-9928-a383d69c9320@yandex-team.ru>
In-Reply-To: <40114688-ffc6-4f33-9928-a383d69c9320@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Jul 2025 10:12:19 +0800
X-Gm-Features: Ac12FXz5F0-zeDJR7KYuvQszrKBlI6Jmw38OsLUo-CuqqvREnMa8KXV5ZnaNFg4
Message-ID: <CACGkMEt8cFEc_sv=TLcCARNjAUsQm6p=Hz_ihBy19yKk9DoZjA@mail.gmail.com>
Subject: Re: [PATCH] net/tap: drop too small packets
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, qemu-devel@nongnu.org
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

On Wed, Jul 9, 2025 at 10:43=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 07.07.25 06:49, Jason Wang wrote:
> > On Thu, Jul 3, 2025 at 10:59=E2=80=AFPM Daniil Tatianin
> > <d-tatianin@yandex-team.ru> wrote:
> >>
> >> On 7/3/25 1:55 PM, Vladimir Sementsov-Ogievskiy wrote:
> >>
> >>> Theoretically tap_read_packet() may return size less than
> >>> s->host_vnet_hdr_len, and next, we'll work with negative size
> >>> (in case of !s->using_vnet_hdr). Let's avoid it.
> >>>
> >>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.r=
u>
> >>> ---
> >>>    net/tap.c | 5 +++++
> >>>    1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/net/tap.c b/net/tap.c
> >>> index ae1c7e39832..20d0dc2eb35 100644
> >>> --- a/net/tap.c
> >>> +++ b/net/tap.c
> >>> @@ -172,6 +172,11 @@ static void tap_send(void *opaque)
> >>>                break;
> >>>            }
> >>>
> >>> +        if (s->host_vnet_hdr_len && size < s->host_vnet_hdr_len) {
>
> Should it be better to s/</<=3D/ here? To skip size =3D=3D s->host_vnet_h=
dr_len as well?

It would be better.

Thanks

>
> >>> +            /* Invalid packet */
> >>> +            break;
> >>> +        }
> >>> +
> >>>            if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
> >>>                buf  +=3D s->host_vnet_hdr_len;
> >>>                size -=3D s->host_vnet_hdr_len;
> >>
> >> Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> >
> > Queued.
> >
> > Thanks
> >
> >>
> >>
> >
>
> --
> Best regards,
> Vladimir
>


