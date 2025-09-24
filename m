Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F879CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 13:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Pva-0007BM-Ru; Wed, 24 Sep 2025 09:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1v1PvO-000782-Ci
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:52:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1v1PvJ-0006pf-Vy
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758721963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JKnU9DCcwHpQnlwynGmkJLdzOdMeZde0r7m8Rz4bk4o=;
 b=PjWibYeFdeLkqpAoPFyrc4yqazISAxrzWBt+MfX5VfsJPCYxQoGoogSc4zx8n9DNUJ4H/V
 ho+qHrygYzuTuXhPLKSK8xmd0n39nK8vHnlPBAioJgy835ZCpba6cWopQ1QNjBSF16PLAB
 RKW9rAOwBPiUWsLI2UqUG4Uzeik4NwU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-MVeFhhPGN1mC0-ZnzdREAA-1; Wed, 24 Sep 2025 09:52:41 -0400
X-MC-Unique: MVeFhhPGN1mC0-ZnzdREAA-1
X-Mimecast-MFC-AGG-ID: MVeFhhPGN1mC0-ZnzdREAA_1758721960
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-32eb18b5500so10944214a91.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 06:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758721960; x=1759326760;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JKnU9DCcwHpQnlwynGmkJLdzOdMeZde0r7m8Rz4bk4o=;
 b=Dbrd64Q23ldf39yofRDr9o0oYmAXGfDOmFvqj3DTvJTKzVT1RLqDafisjKqPacMOFW
 D6OirboIvYdwG5W1FgJmGfSPAKKfeIPR1/zKb/UzoUdDI9XaF7gMe1ePUcnLBvasBDnL
 7/2F8gHkZn0WtSgTVyjJtIyWQfAh4DqX9QiAHg+dLWUgATpLYMY7wrjNvVR+UDPg6xfa
 jmg9ypX76qeEp5mU/OkZ8r7FmeCV28GbY0ypG7TBT05bXWeYANaokZ6a9et1pR+EtsBf
 vptbm+8rj5K/EWoN/D/G+lrakw/kRZUTZPajXNsVxASgJwtxjOdhvzH0ccztyrMgOc3F
 vq3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtqkBgpkMBbZZGipocldWWJ/cXacEaCardjSnNYzmlwTO1eeUGJWTiPCvoRnsdMllqehAGP1CcANcB@nongnu.org
X-Gm-Message-State: AOJu0YzVfrx+S1KcRu6CnQ2iNNP7TtyWWNWQIXU3HUCtmFVH1BzZmUPh
 ZCJsR+auDJGDOnZBKKiEw3AQcUH77pBI5UbAmT0TC4HsWP1zEnSGY7lBB+7t4/wbg/7WtHvxxXQ
 LwYoa1XTUDNpxn3tRlbU1aXEMofQd+/1MAk+GuX8iBxmO20ebkluDeA8SXYmnleUJvFZM45cxAr
 xEJ6FzqKFcH4yUfWkBzzlQtdaQdHRvzZY=
X-Gm-Gg: ASbGncsFHuCupyan5ituk14it0NCN0U4ECIQ4xaZdYexEqPEZXIOoiVYo4L67eUPDz8
 0PX/R/Ru4KI3LLQqV6mmNUVB75rzfnDl9grt/vwt0FHPbFrPyuSCq7hK/8okttdl5tiqjtLDcjk
 FxmCqzokkUQH/mo/ADG11xqhl2xtlpbf/pmuzU4+CJ3I50IPUoTXR7rw==
X-Received: by 2002:a17:90b:544e:b0:332:8133:b377 with SMTP id
 98e67ed59e1d1-332a95376b9mr8836580a91.15.1758721959996; 
 Wed, 24 Sep 2025 06:52:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHy41LE06pJdG9ReJs6v3HynzKNI2Zc+AUm0LtmlcduxgySjuFZ77ox8iZtB/oW9GxwdMG46AqdiDXNg5tdCA=
X-Received: by 2002:a17:90b:544e:b0:332:8133:b377 with SMTP id
 98e67ed59e1d1-332a95376b9mr8836537a91.15.1758721959435; Wed, 24 Sep 2025
 06:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250924133309.334631-1-vsementsov@yandex-team.ru>
In-Reply-To: <20250924133309.334631-1-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Sep 2025 17:52:28 +0400
X-Gm-Features: AS18NWD82AkqL0r4LcxA4Eyx52y0_ZrUgxZEXAtxrYHwr9lu2RiG46e4lgTifrI
Message-ID: <CAMxuvawmG7-2zaiy3cPui3z_uzVUqM5Yz+2e926GyGQ1aPNkvQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] remove deprecated 'reconnect' options
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: armbru@redhat.com, qemu-devel@nongnu.org, eblake@redhat.com, 
 jasowang@redhat.com, devel@lists.libvirt.org, pbonzini@redhat.com, 
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: multipart/alternative; boundary="000000000000a6d225063f8c5d28"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000a6d225063f8c5d28
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Sep 24, 2025 at 5:33=E2=80=AFPM Vladimir Sementsov-Ogievskiy <
vsementsov@yandex-team.ru> wrote:

> They were deprecated in 9.2, now we can remove them.
> New options to use are reconnect-ms.
>
> v2: fixup docs and error messages
>
> Vladimir Sementsov-Ogievskiy (2):
>   chardev: remove deprecated 'reconnect' option
>   net/stream: remove deprecated 'reconnect' option
>
>  chardev/char-socket.c           | 24 +++++-------------------
>  chardev/char.c                  |  3 ---
>  docs/about/deprecated.rst       | 15 ---------------
>  docs/about/removed-features.rst | 22 ++++++++++++++++++++++
>  net/stream.c                    | 20 +++++---------------
>  qapi/char.json                  | 14 +-------------
>  qapi/net.json                   | 13 +------------
>  7 files changed, 34 insertions(+), 77 deletions(-)
>
>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> --
> 2.48.1
>
>

--000000000000a6d225063f8c5d28
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 24, 2025 at 5:33=
=E2=80=AFPM Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vsementsov@y=
andex-team.ru">vsementsov@yandex-team.ru</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">They were deprecated in 9.2, now we=
 can remove them.<br>
New options to use are reconnect-ms.<br>
<br>
v2: fixup docs and error messages<br>
<br>
Vladimir Sementsov-Ogievskiy (2):<br>
=C2=A0 chardev: remove deprecated &#39;reconnect&#39; option<br>
=C2=A0 net/stream: remove deprecated &#39;reconnect&#39; option<br>
<br>
=C2=A0chardev/char-socket.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 24 ++=
+++-------------------<br>
=C2=A0chardev/char.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 3 ---<br>
=C2=A0docs/about/deprecated.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0| 15 ------------=
---<br>
=C2=A0docs/about/removed-features.rst | 22 ++++++++++++++++++++++<br>
=C2=A0net/stream.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 20 +++++---------------<br>
=C2=A0qapi/char.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 14 +-------------<br>
=C2=A0qapi/net.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 13 +------------<br>
=C2=A07 files changed, 34 insertions(+), 77 deletions(-)<br>
<br>
</blockquote><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a=
 href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a=
>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">-- <br>
2.48.1<br>
<br>
</blockquote></div></div>

--000000000000a6d225063f8c5d28--


