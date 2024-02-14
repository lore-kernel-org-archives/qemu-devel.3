Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AF7C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 18:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raKPt-00024g-PS; Wed, 14 Feb 2024 13:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1raKPo-0001zc-29
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 13:55:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1raKPk-0003xX-LP
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 13:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707936922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4jo0LW7m1DBmoiy10GZeif6FZ1vgGh5n2NzDnz4LTpI=;
 b=bwOtV3t0k3WqykSXQN1sYeBy2ej3QsgWnqcTwPNm/hJRMN2CPvjmdQf4UMXnz3246JOvBa
 sqFM04os898vXPkaRT14kKfA+t8yXM71+zNU7bs2q8wIHS1dofgvyEZpm8RI2NForDz086
 P58GwZzdr0TM91fi7GBF4J7/IRbKTyM=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-DjO4cxY1Nl6-nDswfxl8qg-1; Wed, 14 Feb 2024 13:55:19 -0500
X-MC-Unique: DjO4cxY1Nl6-nDswfxl8qg-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dc6b26eef6cso3498325276.3
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 10:55:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707936919; x=1708541719;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4jo0LW7m1DBmoiy10GZeif6FZ1vgGh5n2NzDnz4LTpI=;
 b=k+KBHvvllFIGwzBckIbyxJV0SJ1Fxpy3wpS+7lvw4fy74T4OmQs0gGMQ1KHPbEKsWE
 ByWmGz1pqM1mOs/qig8cnRhesCUF87yWExKl5XfPH4QeGKNUAKFhiO+LAeRc/x97kaZs
 ADsFqiEGiPGVZqml/q+Sn7sTwS/DVFS5Inlrmv8N5VfzpomXkfb+XQLcqOdcF/LxHx8v
 oQSzexOssoOoTPip52v6rRDF5tfUi6uq/uFWUuaIUjb5yztIm/P71uZb2kNlOExdwtA+
 4VNs5cGR6Spz+RlCONFLYbCCgbg8dqeFL4QRK5eKLjnq5ooU7FU2QJvFlTfDPG93WHXF
 nVDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJBWOBH7YI5Q64nn/x4Z4X4DyCn/sQKKJvvVgiwBb7YgXNH+GwrYlbR6hliz0HHIQSgIh1WQ/CLTE3Wf5rNPoA7OBhKmc=
X-Gm-Message-State: AOJu0Yx5Ja/HcL6NWhxoHkDl82ajFPxJWyhvohYKOJh7sppt3XO5Ov0k
 oblZ8Qgie0cr+k2CiPTx+7rAJv4uKaL5hYJzR0Oba+r1XK3IzvrkR6+iUJJnE4FWkMd/ofzH/kB
 XHDKev1w48ma7gRyL+08HDdnLAFCCq9z9PMpIo70BkZU9lGzHRHNFXLfOIsWuOAlQfXfEH97HoQ
 WutMilYJhYkxhVsK0/J4akBdGpTFI=
X-Received: by 2002:a05:6902:2506:b0:dcc:2bc:652 with SMTP id
 dt6-20020a056902250600b00dcc02bc0652mr3511099ybb.60.1707936918807; 
 Wed, 14 Feb 2024 10:55:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbknExzylWMbODTs9Q7nb8GBgfhF28V6VBmHgBR0nyH8oXPxyjAMeLrOLkku/N036Wh0QOl+itZ9XT4LeGGTI=
X-Received: by 2002:a05:6902:2506:b0:dcc:2bc:652 with SMTP id
 dt6-20020a056902250600b00dcc02bc0652mr3511082ybb.60.1707936918544; Wed, 14
 Feb 2024 10:55:18 -0800 (PST)
MIME-Version: 1.0
References: <1707910082-10243-1-git-send-email-si-wei.liu@oracle.com>
 <1707910082-10243-5-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1707910082-10243-5-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 14 Feb 2024 19:54:42 +0100
Message-ID: <CAJaqyWd1qPmUn3Z=3SSbWT7rX78zza_mt1y6RQwi+62wFbda-Q@mail.gmail.com>
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

On Wed, Feb 14, 2024 at 1:39=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> Introduce new API. No functional change on existing API.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

I'm ok with the new function, but doesn't the compiler complain
because adding a static function is not used?

> ---
>  net/vhost-vdpa.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 06c83b4..4168cad 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -281,13 +281,18 @@ static ssize_t vhost_vdpa_receive(NetClientState *n=
c, const uint8_t *buf,
>  }
>
>
> -/** From any vdpa net client, get the netclient of the first queue pair =
*/
> -static VhostVDPAState *vhost_vdpa_net_first_nc_vdpa(VhostVDPAState *s)
> +/** From any vdpa net client, get the netclient of the i-th queue pair *=
/
> +static VhostVDPAState *vhost_vdpa_net_get_nc_vdpa(VhostVDPAState *s, int=
 i)
>  {
>      NICState *nic =3D qemu_get_nic(s->nc.peer);
> -    NetClientState *nc0 =3D qemu_get_peer(nic->ncs, 0);
> +    NetClientState *nc_i =3D qemu_get_peer(nic->ncs, i);
> +
> +    return DO_UPCAST(VhostVDPAState, nc, nc_i);
> +}
>
> -    return DO_UPCAST(VhostVDPAState, nc, nc0);
> +static VhostVDPAState *vhost_vdpa_net_first_nc_vdpa(VhostVDPAState *s)
> +{
> +    return vhost_vdpa_net_get_nc_vdpa(s, 0);
>  }
>
>  static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool ena=
ble)
> --
> 1.8.3.1
>


