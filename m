Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10211C04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 10:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvEcQ-0004be-4m; Fri, 12 Apr 2024 06:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvEcN-0004Wt-74
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvEcG-0003A1-SI
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712919524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/UOnA90eP1WeQ5Qhxyy9wNz7PPoNMe8ouXcmwZ+Dcl0=;
 b=Uee1zLrfmCjry6zYFMHhWwFwZEEpf+7xuNEWtcsTfJqCFFtTNW1fTWsvmZSqndMD8Q+dzM
 4Z+v586VF92PlrgxqtI1Du7tIuRYyH66ZT4poYxka7wGOAbV+apv/mI6CBnqCPFIhHcqSi
 iWHLEsKIoVACju4fiZ/QIYd8fkgmVys=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-ECbZbrtHONad53yHvQosSg-1; Fri, 12 Apr 2024 06:58:41 -0400
X-MC-Unique: ECbZbrtHONad53yHvQosSg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-346c08df987so525665f8f.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 03:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712919519; x=1713524319;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/UOnA90eP1WeQ5Qhxyy9wNz7PPoNMe8ouXcmwZ+Dcl0=;
 b=FANv9eyes9qRNwwlMvxGLl2YnZco4pYx2cs+tA0jdqopCdOfrV33mFjtFe39ZR/1/0
 7gsVK0yN6moNcOzVeM753EXJvDk13aeiWnqUvD9xt5FZsFZNydaGx7wg4J5HZxK58pj2
 F6qNk/LcPMrBo5TeWsY+aEjfufyl7iy8c/dkAaKryj1OfSVIJ/O/1UbaVrhqiPDxnfdm
 mv2uL3dBJHzrGqeC696LJI5xuoK4azwc6if9tRzReTippKMGWodHmL9CP+V2NR6e7NPx
 t4VL4i800eeSRrUU2HC/J82tGsyaecIBw4fMVdps8JWULKpK3f8ChVkWvHbwz1yKzd/H
 efIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSoBk10Ho+NgLOULqSYAtFocDKG6XzUo1eYaBDL5WgBwY6S7D+bu13omH1WqmscwmKmL1q5RHceW6YuQ7CDw9RP4QSV3w=
X-Gm-Message-State: AOJu0Yxu9BgIWg0js5MySr6S/o25ePMA7AjTF5ZSuElGEKvtehx02mRJ
 bSgnTq5dHd/+kkIQ55/xTlWw/Gonqbom4/iEfnIXRpv9kvtnt8iQ6MoYNn9qTGOCumjwORcNrlA
 Fw+iVN7+H/aybm3HNyf/+pRdeduR0sTPAFLZn04cQz5ucMIvPeoSK3r5HpJQGm5Nca8+m5i0NSw
 E6FnlctAXw3ktyANE2fVDaZ24N7/KRP52fcsrr0g==
X-Received: by 2002:a05:6000:1841:b0:345:811b:466e with SMTP id
 c1-20020a056000184100b00345811b466emr1921071wri.26.1712919519298; 
 Fri, 12 Apr 2024 03:58:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKMo+cPtQRHx5fXIfjZ2J6ntrdnuTPUdgKFAH/RCtPYTBVjczw+/me1QdaIt9wiwj2VtAk+DyuQ9CzAPufGCc=
X-Received: by 2002:a05:6000:1841:b0:345:811b:466e with SMTP id
 c1-20020a056000184100b00345811b466emr1921055wri.26.1712919518997; Fri, 12 Apr
 2024 03:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240411121434.253353-1-aharivel@redhat.com>
 <20240411121434.253353-2-aharivel@redhat.com>
In-Reply-To: <20240411121434.253353-2-aharivel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Apr 2024 12:58:27 +0200
Message-ID: <CABgObfaq6qTEb8QFEtZB_x4P01yCa1COeOUAZw+AGGwb8Q+Uiw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] qio: add support for SO_PEERCRED for socket channel
To: Anthony Harivel <aharivel@redhat.com>
Cc: mtosatti@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org, 
 vchundur@redhat.com, rjarry@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Apr 11, 2024 at 2:14=E2=80=AFPM Anthony Harivel <aharivel@redhat.co=
m> wrote:
>
> The function qio_channel_get_peercred() returns a pointer to the
> credentials of the peer process connected to this socket.
>
> This credentials structure is defined in <sys/socket.h> as follows:
>
> struct ucred {
>         pid_t pid;    /* Process ID of the sending process */
>         uid_t uid;    /* User ID of the sending process */
>         gid_t gid;    /* Group ID of the sending process */
> };
>
> The use of this function is possible only for connected AF_UNIX stream
> sockets and for AF_UNIX stream and datagram socket pairs.
>
> On platform other than Linux, the function return 0.
>
> Signed-off-by: Anthony Harivel <aharivel@redhat.com>
> ---
>  include/io/channel.h | 21 +++++++++++++++++++++
>  io/channel-socket.c  | 28 ++++++++++++++++++++++++++++
>  io/channel.c         | 13 +++++++++++++
>  3 files changed, 62 insertions(+)
>
> diff --git a/include/io/channel.h b/include/io/channel.h
> index 7986c49c713a..bdf0bca92ae2 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -160,6 +160,9 @@ struct QIOChannelClass {
>                                    void *opaque);
>      int (*io_flush)(QIOChannel *ioc,
>                      Error **errp);
> +    int (*io_peerpid)(QIOChannel *ioc,
> +                       unsigned int *pid,
> +                       Error **errp);
>  };
>
>  /* General I/O handling functions */
> @@ -981,4 +984,22 @@ int coroutine_mixed_fn qio_channel_writev_full_all(Q=
IOChannel *ioc,
>  int qio_channel_flush(QIOChannel *ioc,
>                        Error **errp);
>
> +/**
> + * qio_channel_get_peercred:
> + * @ioc: the channel object
> + * @pid: pointer to pid
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Returns the pid of the peer process connected to this socket.
> + *
> + * The use of this function is possible only for connected
> + * AF_UNIX stream sockets and for AF_UNIX stream and datagram
> + * socket pairs on Linux.
> + * Return -1 on error with pid -1 for the non-Linux OS.

with pid -1 -> and set *pid to -1.

> + */
>  static const TypeInfo qio_channel_socket_info =3D {
> diff --git a/io/channel.c b/io/channel.c
> index a1f12f8e9096..e3f17c24a00f 100644
> --- a/io/channel.c
> +++ b/io/channel.c
> @@ -548,6 +548,19 @@ void qio_channel_set_cork(QIOChannel *ioc,
>      }
>  }
>
> +int qio_channel_get_peerpid(QIOChannel *ioc,
> +                             unsigned int *pid,
> +                             Error **errp)
> +{
> +    QIOChannelClass *klass =3D QIO_CHANNEL_GET_CLASS(ioc);
> +
> +    if (!klass->io_peerpid) {
> +        error_setg(errp, "Channel does not support peer pid");

Missing for consistency:

+        *pid =3D -1;

> +        return -1;
> +    }
> +    klass->io_peerpid(ioc, pid, errp);
> +    return 0;

The error from klass->io_peerpid is ignored:

-    klass->io_peerpid(ioc, pid, errp);
-    return 0;
+    return klass->io_peerpid(ioc, pid, errp);

Paolo


