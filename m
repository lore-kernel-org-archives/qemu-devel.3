Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEF6FB3CEA
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w793V-0008Bu-Ih; Mon, 30 Mar 2026 05:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w793L-0008B9-0b
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:36:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w793I-0003M4-3L
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774863408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X+aviq5Uw9nrotnwZvioHYIlQAcA7EjVSYfp05pSKng=;
 b=B/xZKSzAHYCTGpwaNEmRHVuQcLhuoV41Y8Bq/HQTrifoPyZvMgXkAKmK/JEEMGDW9y9L9R
 UbxEkqe7ap8ztHh2xCvwnY1iUU1An2i8o1l2rdxTSx9nkQ09+y5mZ7msNaThNEYyLNk5hC
 6oMNtotnN04cKPE8htSnRDYiMfMm2UQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-D6j5Ra7vPEqVftGR32yq7g-1; Mon, 30 Mar 2026 05:36:46 -0400
X-MC-Unique: D6j5Ra7vPEqVftGR32yq7g-1
X-Mimecast-MFC-AGG-ID: D6j5Ra7vPEqVftGR32yq7g_1774863405
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c739120475fso2785254a12.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 02:36:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774863405; cv=none;
 d=google.com; s=arc-20240605;
 b=lwz3cIZ4+EUuICLfMyiZN4ucXQ1NI43O5FAZmkz61zF+xJbfP5SJPgDWss0x3tAFTX
 ZC5QNeq/a31mqwS7oHXIfUkgl8t0DHdEzVE0ZADsmtQW66yHW/Og6ZIoV0+HA5OFieYq
 lfTp0dzGU4PXCMmXJf0hp/Xqzufmyu/3kSCXjZZAG5caY+hFpSwPE/iSIe/3hHZY3xOa
 0VXYibsX8fo+5OoSLMRN0D6DAlT8pSYEO4jlBH5mvkS9UKmBkF7iPBOmMKk2Uu5qX+5g
 tGZeuq4DIZDSVFsV2KCK06FAuAQnjSGevNs03J+aRfeb/mmFuVS2MSxaKseJfw7+5/RN
 4+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=X+aviq5Uw9nrotnwZvioHYIlQAcA7EjVSYfp05pSKng=;
 fh=ckKiQtaduSoU7Do81eCOdreQ45xLs6uc450ueGmOpCM=;
 b=Z9WnxRrUzqSw0dsnrGhIhphPb8xPLOGyH6nr1pNt+Nw5Sk4pLkWKJNVdqwujpi3c6U
 18XvErOSwmYQn3XfIGNQ5O+ydpINnA60mLPlTqWosLVUrMl0ENS4TtoXnzQnaAKoGO1x
 7UbXPcLT3UQn/BOT8OzQR51UbpRKs7FywXhVWd4g5d/gGYdAYY+7v5HGRaURwf4IaTIV
 th5Jpbnv1MVE65Hg4hzx8dEVuCrfy3JPO/HtKHifCzqu5DmLwd9QCtlhEaRmZAiqnZI1
 X4hgD9aAl/+QENTp0DDopnaXKxYRxG5izeh6J6CmT/34l5Ys/PTUu7lJ4eDoTZ0OcmsQ
 1p9A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774863405; x=1775468205; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+aviq5Uw9nrotnwZvioHYIlQAcA7EjVSYfp05pSKng=;
 b=EhIydlHOp93N/1eXkvfkgieBpqUm0niUQiZRSIQSoVdQIfSxSRtrUjUBnlG1BJdgAe
 IvJRMfNP6RejXorrM3c2B1w55Du4Dy6GReJrjtB/m3FNdSggjGbVEKfNh8CQcBkcJjMX
 sOu3qwI0a4UYrJbvVRtUrC+SflCKA8JZVPylNvorDyCckikgBLwS80LHHMc+hcpd3b5d
 ZxejQvXxBq00QjOmuiY9MKY58LPl4Vjp0w+jcWm48j+OohQ/vbWspL8noowLApGnyxuI
 gu6LC9/m2IwghymlgXJsD3uwSLM0Pl3LscfycQjCfhNuI+XRaCQ3RA+doyi8rUXVJSmr
 9BOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774863405; x=1775468205;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X+aviq5Uw9nrotnwZvioHYIlQAcA7EjVSYfp05pSKng=;
 b=J2WudSrIezF/vsXmWJFYA8OuSgfijv63UiKa9ShRVwAJJtcIm5G1YUsSPuqdgyD/+I
 8nnyJrBhxkRl08/FCjL7Ce/Ov1xEMrE1HkIQxTII50C50sM9bHosjw6erA0h2t4xjJRY
 IJKO2joy3P9hOr8S2rY2dNF6MGgF6dUbczOImmUQa4ptZsBeZFrpl7XljZNoX/rakH/4
 WtJolQ00A2boc30k9bI+eazp9fKfxPgu9ZecwhLcf9p2mngU3Ly04esFZhj4LvaSTYnH
 V7nagO3SvFwLYhX4/E/Z/YuGTUcS7CgNzhJ4UynSoN5DVlvXU67NoLgYnj4jDcKv7zqQ
 5dPg==
X-Gm-Message-State: AOJu0YwdISkLkHnPezkPMtNhLsPbXxItGAivtBiJSmEhpzwewyszMcTJ
 /Nq1CZmQUsye7IVkLHgNS3tf7w0vzjhguVbgGMF01z1R78dz1LFi85Ecd0bdt322oQDFc99+zyP
 bz+DZaqr/t+a/xE+J8/1AGxgQUXot7a1EhYwTppaZbu3Hk2i1QbWVMXElIgASd8YMQiClGR1FTN
 jNFXiHIyfa5cH0LUFO8xOnyRKdV94uy8QFoc4TsOdEz3mk
X-Gm-Gg: ATEYQzyAe2tpj5kD/Opdys8tc9YMO8D6W+FeN3ZHcz4moJreeDZsz3RZ8R/ngxL7O6b
 9bLJLJtZAfJO2h+nTHKbjcxet+AG7pHMoMOjoKAi0o9vDFitUtPzBv+H3pN4tESInXHRNI0/n91
 YWzg/M0IpivpGs2eiShPWjOemSoWSq3VErfqSF0Qo92+G/MEjtQ5yFcxUM6SCmINVJRJ9vtMqn8
 5ziH4Ri+Q3x1GJO+/MwB5IlmqNPMZ9rEsFVz6qQ9jXZKG09RXhklpXP/o5lNQFgo5zCpsiDBGrg
 XGUn80Eb34MDRvvcL8CwQO8=
X-Received: by 2002:a05:6a20:12c9:b0:398:b8eb:6716 with SMTP id
 adf61e73a8af0-39c878fa2d9mr11839323637.23.1774863404862; 
 Mon, 30 Mar 2026 02:36:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:12c9:b0:398:b8eb:6716 with SMTP id
 adf61e73a8af0-39c878fa2d9mr11839299637.23.1774863404255; Mon, 30 Mar 2026
 02:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260330091310.42868-1-zhaoguohan@kylinos.cn>
In-Reply-To: <20260330091310.42868-1-zhaoguohan@kylinos.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Mar 2026 13:36:32 +0400
X-Gm-Features: AQROBzD98kiMTb57-27vq2Tkezh_Xes280uaMGos1eY-C3_KNwFC09A0ttQOlZA
Message-ID: <CAMxuvaz1aac0GyBSXj9QdfGx7w-Wut5TnibK+s2geO5-d_GUFw@mail.gmail.com>
Subject: Re: [PATCH] ui/dbus: tear down clipboard callbacks on display finalize
To: GuoHan Zhao <zhaoguohan@kylinos.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 30, 2026 at 1:13=E2=80=AFPM GuoHan Zhao <zhaoguohan@kylinos.cn>=
 wrote:
>
> The clipboard D-Bus teardown path currently runs when the peer
> disappears, but not when DBusDisplay itself is finalized.
>
> That leaves pending clipboard requests and signal handlers associated
> with the clipboard proxy active past display teardown.
>
> Add an explicit clipboard fini hook and invoke it from
> dbus_display_finalize() so the clipboard teardown also runs during
> display destruction.
>
> Fixes: ff1a5810f61f ("ui/dbus: add clipboard interface")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/dbus-clipboard.c | 14 ++++++++++++++
>  ui/dbus.c           |  1 +
>  ui/dbus.h           |  1 +
>  3 files changed, 16 insertions(+)
>
> diff --git a/ui/dbus-clipboard.c b/ui/dbus-clipboard.c
> index 6787a7766877..4a01901e291b 100644
> --- a/ui/dbus-clipboard.c
> +++ b/ui/dbus-clipboard.c
> @@ -191,6 +191,7 @@ static void
>  dbus_clipboard_unregister_proxy(DBusDisplay *dpy)
>  {
>      const char *name =3D NULL;
> +    GDBusConnection *connection =3D NULL;
>      int i;
>
>      for (i =3D 0; i < G_N_ELEMENTS(dpy->clipboard_request); ++i) {
> @@ -201,6 +202,13 @@ dbus_clipboard_unregister_proxy(DBusDisplay *dpy)
>          return;
>      }
>
> +    connection =3D g_dbus_proxy_get_connection(
> +        G_DBUS_PROXY(dpy->clipboard_proxy));
> +    if (connection) {
> +        g_signal_handlers_disconnect_by_data(connection, dpy);
> +    }
> +    g_signal_handlers_disconnect_by_data(dpy->clipboard_proxy, dpy);
> +
>      name =3D g_dbus_proxy_get_name(G_DBUS_PROXY(dpy->clipboard_proxy));
>      trace_dbus_clipboard_unregister(name);
>      g_clear_object(&dpy->clipboard_proxy);
> @@ -425,6 +433,12 @@ dbus_clipboard_request(
>      return DBUS_METHOD_INVOCATION_HANDLED;
>  }
>
> +void
> +dbus_clipboard_fini(DBusDisplay *dpy)
> +{
> +    dbus_clipboard_unregister_proxy(dpy);
> +}
> +
>  void
>  dbus_clipboard_init(DBusDisplay *dpy)
>  {
> diff --git a/ui/dbus.c b/ui/dbus.c
> index 4f24215555a4..be291f220ecd 100644
> --- a/ui/dbus.c
> +++ b/ui/dbus.c
> @@ -145,6 +145,7 @@ dbus_display_finalize(Object *o)
>          dbus_display_notifier_remove(&dd->notifier);
>      }
>
> +    dbus_clipboard_fini(dd);
>      qemu_clipboard_peer_unregister(&dd->clipboard_peer);
>      g_clear_object(&dd->clipboard);
>
> diff --git a/ui/dbus.h b/ui/dbus.h
> index 1e8c24a48e32..986d77746017 100644
> --- a/ui/dbus.h
> +++ b/ui/dbus.h
> @@ -150,5 +150,6 @@ void dbus_display_notify(DBusDisplayEvent *event);
>  void dbus_chardev_init(DBusDisplay *dpy);
>
>  void dbus_clipboard_init(DBusDisplay *dpy);
> +void dbus_clipboard_fini(DBusDisplay *dpy);
>
>  #endif /* UI_DBUS_H */
> --
> 2.43.0
>


