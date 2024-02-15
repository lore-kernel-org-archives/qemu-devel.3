Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802EFC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raVJs-0007p3-LM; Thu, 15 Feb 2024 01:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1raVJq-0007ol-Jn
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:34:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1raVJp-0000r0-2W
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707978839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K+R5rB4jyZa9FVOzgVDgG6bCnOUGXUs1cGlhnCHIUzg=;
 b=X081MzdKqo6mX5uxYkUR5HUvP6VH5gdpawSIz+/7e4p/OZrHw+PeuZT2uMWw1rsAzQKqo7
 XBkqC1B2YgLZrknyosyav6m/wHH8d7+QOm0XnTbBE4IEP4GN6gqCXx1MqG2DHAsyohgDlS
 AdcjVkK/XFtZW2ln8a5ALwO9MzG/zME=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-n5t_GdZBPUGMqdArhKqRyA-1; Thu, 15 Feb 2024 01:33:57 -0500
X-MC-Unique: n5t_GdZBPUGMqdArhKqRyA-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-dccc49ef73eso683927276.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978837; x=1708583637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K+R5rB4jyZa9FVOzgVDgG6bCnOUGXUs1cGlhnCHIUzg=;
 b=grP699MNXfuAFjyZheKBl0yMWwg/QhW2NN9/P+Pu5Ua1iu6V7ABtVejgRjBSC8Z0TO
 wFdCF3oHOJyTzJsvMO7FnPdg5seujJEq4DcGfAEA/bW6qyTaSK11qiQeIzvmCuBYvdoX
 9Qp2HX4Lnd6bYTtRiLa4YiHMb+5YSDPf9HeJs427HOa54o4v4tLDHm0zPqNB03AdmNWy
 RhfeNxgnQVNMLjrXcGwPPWsmlCN7OTgfqkRi39DubQlOREuHUbTeiXNRxlT5PofhzqQH
 9Iib+ozDprOZEkG+JTKJsQZ+RsMYVow1Qf7pxcI3S0HEVzIPmVbKAnRxTI0eyhkhO9Ol
 e3uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCFAORBtj9BSWiJorVSj1jvFRu1fl1ACLfg/b5CreO1ROJ9dmVuW/6dkmOejTjdzro7wWrMYvZtJDnfCqjb0zbZEjrItY=
X-Gm-Message-State: AOJu0YxVrr5nzqhzS4xBzIQS5jTk6cAKUTv3OWlnEhZUbtuJgPCzdNnv
 T5yPZ/QaS4Ff4pdA/uWalzpG9taXmXY+YcO/gC6+h0sPbF+Jihch32TK5OdMjnuqgHfoRNZPzkS
 QtG7vOs1Ratw90IjnVPtQLzh2bW4O3OET6cJy0DnKWtqkbQ8BqHZ1SCHf6u8u8MA/cEFzVqEeqX
 lA83JaSDsPY61lRbHv0LNurWXOJjc=
X-Received: by 2002:a25:ec05:0:b0:dc7:3265:37a9 with SMTP id
 j5-20020a25ec05000000b00dc7326537a9mr711010ybh.37.1707978836865; 
 Wed, 14 Feb 2024 22:33:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZIzoDNRhZpQOnJmVsuXuM0249q7zpcR5Koye/GuntJHq94lpnaY5a7QcBQezRPiY8RJQRS/4RwGyBFiAwQR4=
X-Received: by 2002:a25:ec05:0:b0:dc7:3265:37a9 with SMTP id
 j5-20020a25ec05000000b00dc7326537a9mr711000ybh.37.1707978836596; Wed, 14 Feb
 2024 22:33:56 -0800 (PST)
MIME-Version: 1.0
References: <1707910082-10243-1-git-send-email-si-wei.liu@oracle.com>
 <1707910082-10243-5-git-send-email-si-wei.liu@oracle.com>
 <CAJaqyWd1qPmUn3Z=3SSbWT7rX78zza_mt1y6RQwi+62wFbda-Q@mail.gmail.com>
 <fdc1ba6f-6e25-42ac-a40f-088501c648ad@oracle.com>
In-Reply-To: <fdc1ba6f-6e25-42ac-a40f-088501c648ad@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 15 Feb 2024 07:33:20 +0100
Message-ID: <CAJaqyWcg=b7jf1uzCBds2uzVD9LMpoqX3yO9wr0rMGxfv_kBdw@mail.gmail.com>
Subject: Re: [PATCH 04/12] vdpa: factor out vhost_vdpa_net_get_nc_vdpa
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 14, 2024 at 9:59=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 2/14/2024 10:54 AM, Eugenio Perez Martin wrote:
> > On Wed, Feb 14, 2024 at 1:39=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >> Introduce new API. No functional change on existing API.
> >>
> >> Acked-by: Jason Wang <jasowang@redhat.com>
> >> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > I'm ok with the new function, but doesn't the compiler complain
> > because adding a static function is not used?
> Hmmm, which one? vhost_vdpa_net_get_nc_vdpa is used by
> vhost_vdpa_net_first_nc_vdpa internally, and
> vhost_vdpa_net_first_nc_vdpa is used by vhost_vdpa_net_cvq_start (Patch
> 01). I think we should be fine?
>

Ouch, you're totally right.

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> -Siwei
> >
> >> ---
> >>   net/vhost-vdpa.c | 13 +++++++++----
> >>   1 file changed, 9 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> >> index 06c83b4..4168cad 100644
> >> --- a/net/vhost-vdpa.c
> >> +++ b/net/vhost-vdpa.c
> >> @@ -281,13 +281,18 @@ static ssize_t vhost_vdpa_receive(NetClientState=
 *nc, const uint8_t *buf,
> >>   }
> >>
> >>
> >> -/** From any vdpa net client, get the netclient of the first queue pa=
ir */
> >> -static VhostVDPAState *vhost_vdpa_net_first_nc_vdpa(VhostVDPAState *s=
)
> >> +/** From any vdpa net client, get the netclient of the i-th queue pai=
r */
> >> +static VhostVDPAState *vhost_vdpa_net_get_nc_vdpa(VhostVDPAState *s, =
int i)
> >>   {
> >>       NICState *nic =3D qemu_get_nic(s->nc.peer);
> >> -    NetClientState *nc0 =3D qemu_get_peer(nic->ncs, 0);
> >> +    NetClientState *nc_i =3D qemu_get_peer(nic->ncs, i);
> >> +
> >> +    return DO_UPCAST(VhostVDPAState, nc, nc_i);
> >> +}
> >>
> >> -    return DO_UPCAST(VhostVDPAState, nc, nc0);
> >> +static VhostVDPAState *vhost_vdpa_net_first_nc_vdpa(VhostVDPAState *s=
)
> >> +{
> >> +    return vhost_vdpa_net_get_nc_vdpa(s, 0);
> >>   }
> >>
> >>   static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool=
 enable)
> >> --
> >> 1.8.3.1
> >>
>


