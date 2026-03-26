Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B365910A62D5
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5ku7-0005IH-QZ; Thu, 26 Mar 2026 09:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w5ku4-0005Hs-0s
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 09:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w5ku2-0000vu-8Z
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 09:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774532257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mFQHmByGh3TTGSfBYHs0/nsoUb9gaPMy64snZE8mTkU=;
 b=fh63Sca/qWTBzZfa9xT11sWn0T0pYZttmrM2hAd2zBfGsf5eOd11WlLSSY9ik/RzugbO0E
 aUWGl2GS48kH8NVB1R8lwrT9D5jYLSKHgrwBysQdbpzg/NyR2Y9VSs0hg0IFuetMbDorOi
 E1h7OHVACSrqsuyglhAOOD8bXyZl5ug=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-ag472i24OKOft_OwWhpbbw-1; Thu, 26 Mar 2026 09:37:33 -0400
X-MC-Unique: ag472i24OKOft_OwWhpbbw-1
X-Mimecast-MFC-AGG-ID: ag472i24OKOft_OwWhpbbw_1774532252
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c73a4983fc0so809513a12.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 06:37:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774532252; cv=none;
 d=google.com; s=arc-20240605;
 b=lwYBV2RVs6b28olYgFMpW8Lv4R6fHJ3wNf1Dc+HHgpWFNLCnumL4Pbb9/X0OZwMdtR
 m21Uhbe4tzDUcos/fJ3yrqcy6I9Ph9bAun0G+Ekjh3oyMUUCzclDUqAq128KWgEXZ2kR
 6xazG3uQlMssnhOZOYRoKdRz0ArOFeH+qL7AJ2Nxu41EKu0qelheRmCS0b4Sj9/ig6sI
 eHLIF8RhNz+FLicPRB0oQy0EHBqKZ0OPerG12zYblhgUG+FuO+75zAa+FBhuvD6Q2+pJ
 ZAQ1YErgAzMk7Poo+fQlusmBe3HDld+Ay+EM7EgbtvqybucSoQFKm9EEwr/lMV7Pk00I
 gC5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mFQHmByGh3TTGSfBYHs0/nsoUb9gaPMy64snZE8mTkU=;
 fh=ckKiQtaduSoU7Do81eCOdreQ45xLs6uc450ueGmOpCM=;
 b=ICtk5ZLH3BOIJRIy+Z9YOr3fMQas8HFVDA/uNSkOfCsYdRLoiEHTVGCICyGd97/xI2
 tbduGJsC0HHQ8tlhDpe+3lRaMWd3o80wc3hrJTmNLO4SPW0cusS9ek1fsTLH4lBAclF8
 16VdMVzFFaefc+YkNmtsRJzLRWwHhxDUAdGupi5sVfIWC4ZzUYtITbBCqvknxK6XcFFz
 AeaMSXv0hrzZRb0YyAxhEDCJaEj5Q53GJa0V2iPjjNXoAP1VAhyzq57ivugieSwQ3iIf
 aWjaHj1MJVl8I67rDDYHE6HsIHXMuTuAgNW54MsA/1uhVjuG9ZV/m1twPxlLKn8jagys
 OZ4A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774532252; x=1775137052; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFQHmByGh3TTGSfBYHs0/nsoUb9gaPMy64snZE8mTkU=;
 b=Uhgv0PKodSvW8X8o0hBzWg/sdu7+7j41zTfGnRdNRndqDqg0hBlfauzPA4rSRg3OiV
 U8iCtZEKfIPTVi/qaq8lb1H1Btu7Qv+TPxfcl2pfVUWqwA9eI3EppdrQ3w+5XVu35HxZ
 TgPC4bVvzAXj9ai/qbHBSS19HEq8D9B/7UzlPBQxzkmg38eMgTM/oBSYkGCIwzwpjC2x
 MzFhywWa2jaXpozpzx4nbD9SkjdDsNL/zUAf7he6IMpXfw1rRvTxjIkTZhRgAtbbmHYH
 CPzIkRpZcV5/s6p04W7HxQ3DwZKx0gl3251i/861AchTD2EfX7i7y0enPIwOM+JVptVX
 DLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774532252; x=1775137052;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mFQHmByGh3TTGSfBYHs0/nsoUb9gaPMy64snZE8mTkU=;
 b=KRY0uTKMNKtjLQALQZKNEL7ZKHD7zFKTUkHxG1wDIqFdWJuuPQDNing0rquCj24d1O
 qEWItWb7emVFunwDbGEVj306AZm5xbiP5Py5mOPnnK83evL9U62dJdRNrt+duucGJPS/
 IzH+zuWYmhYBQar8x3ib1SfRngR9RyMgMa05vELf+Xnr8RYicCk/YGV6CBpFUT0TZZZ9
 8us7R7U2x1ABnJiVge654IXuJGDavI0Fsj6vSv/sjF8BFWXaQ9FsEFkOpi/Lbf6g9J8o
 OFRkychdED7gvxJboYUxxD/jXviRB4/uGoDXI0hdN6gY3qWpaic0uW7OlZgw4QXM3+YP
 A1og==
X-Gm-Message-State: AOJu0Yxp/4XNfjlrFt2i29Cgj1r+RjJ+SmeLDMPbA+ZkDP55Fpr9cLIF
 RSPw2SI4xnaoO7q383rPRuF5HeQ7LxW5FGJYhsb3d27imSTmXQXq2yTU68RXtHS41FypVn+rd1N
 t5pUDI/raPNjKXR28AtzcEVQywbA4tMLUUygPOZGkAGDRdRhgw6X1bbvYSfL5/boRFFf4RlN8Bu
 uxw4e8r6k+xHoeGwIn3TYrWycM5Iq/9ets46ddEP0iug==
X-Gm-Gg: ATEYQzz/Swr90jOymjeJPYqYYiuH8rWkBnB8bRdZLLLCNgCu1p01ym5QCkxm7pf3NTn
 BCeJCgcD4HUHAOyouGbu8w3I3yS3YB25wkrKECySoVNPk7qGhsva/akEH1vQXjsC5cJT6ypm6Bk
 Td7Cjg9DmQhVlYmZS7EnaQ5HYYsMKPRZX+jqtI2fVs7sIl8w37ztoSN3HzVCJi/a/iKkveZqZ9n
 ZXosYWaSIfHqe4Naoh6YCxyHHo+YgWZFRDTx49BH2t/iTXuTahTErMXhb49Hjqqxg==
X-Received: by 2002:a05:6a20:3d06:b0:398:7eea:50a0 with SMTP id
 adf61e73a8af0-39c4ab43060mr8316844637.18.1774532252148; 
 Thu, 26 Mar 2026 06:37:32 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d06:b0:398:7eea:50a0 with SMTP id
 adf61e73a8af0-39c4ab43060mr8316807637.18.1774532251601; Thu, 26 Mar 2026
 06:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260326065111.626236-1-zhaoguohan@kylinos.cn>
In-Reply-To: <20260326065111.626236-1-zhaoguohan@kylinos.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 26 Mar 2026 17:37:19 +0400
X-Gm-Features: AQROBzCqCj3uc0kV0VjqsDhnJ7cwmb_O415ECeSP5sp0ZU43i32tYK39VjBnjN4
Message-ID: <CAMxuvaxCkoRYkY17DRWC_3jXLtjpWjVvV_tnHrhTgZtFR=5uoQ@mail.gmail.com>
Subject: Re: [PATCH] ui/dbus: associate add_client completion with its request
To: GuoHan Zhao <zhaoguohan@kylinos.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
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

Hi

On Thu, Mar 26, 2026 at 10:56=E2=80=AFAM GuoHan Zhao <zhaoguohan@kylinos.cn=
> wrote:
>
> Commit 99997823bbbd ("ui/dbus: add p2p=3Don/off option")
> introduced an asynchronous D-Bus client setup path, with the completion
> handler reaching back into the global dbus_display state.
>
> This makes the callback effectively operate on whatever request is
> current when it runs, rather than the one that created it. A completion
> from an older request can therefore clear a newer
> add_client_cancellable or install its connection after a replacement
> request has already been issued. It also relies on the DBusDisplay
> instance remaining alive until completion.
>
> Fix this by passing the DBusDisplay and GCancellable as callback data,
> taking references while the async setup is in flight, and only acting
> on completion if it still matches the current request. Also drop the
> previous cancellable before creating a new request.
>
> Fixes: 99997823bbbd ("ui/dbus: add p2p=3Don/off option")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

thanks!

> ---
>  ui/dbus.c | 44 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 40 insertions(+), 4 deletions(-)
>
> diff --git a/ui/dbus.c b/ui/dbus.c
> index 4f24215555a4..7c54b6a502d2 100644
> --- a/ui/dbus.c
> +++ b/ui/dbus.c
> @@ -263,22 +263,52 @@ dbus_display_complete(UserCreatable *uc, Error **er=
rp)
>      }
>  }
>
> +typedef struct DBusDisplayAddClientData {
> +    DBusDisplay *display;
> +    GCancellable *cancellable;
> +} DBusDisplayAddClientData;
> +
> +static void dbus_display_add_client_data_free(DBusDisplayAddClientData *=
data)
> +{
> +    if (data->display) {
> +        object_unref(OBJECT(data->display));
> +        data->display =3D NULL;
> +    }
> +    g_clear_object(&data->cancellable);
> +    g_free(data);
> +}
> +
> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(DBusDisplayAddClientData,
> +                              dbus_display_add_client_data_free)
> +
>  static void
>  dbus_display_add_client_ready(GObject *source_object,
>                                GAsyncResult *res,
>                                gpointer user_data)
>  {
> +    g_autoptr(DBusDisplayAddClientData) data =3D user_data;
> +    DBusDisplay *display =3D data->display;
> +    bool current =3D display->add_client_cancellable =3D=3D data->cancel=
lable;
>      g_autoptr(GError) err =3D NULL;
>      g_autoptr(GDBusConnection) conn =3D NULL;
>
> -    g_clear_object(&dbus_display->add_client_cancellable);
> +    if (current) {
> +        g_clear_object(&display->add_client_cancellable);
> +    }
>
>      conn =3D g_dbus_connection_new_finish(res, &err);
>      if (!conn) {
> -        error_printf("Failed to accept D-Bus client: %s", err->message);
> +        if (!g_error_matches(err, G_IO_ERROR, G_IO_ERROR_CANCELLED)) {
> +            error_printf("Failed to accept D-Bus client: %s", err->messa=
ge);
> +        }
> +        return;
>      }
>
> -    g_dbus_object_manager_server_set_connection(dbus_display->server, co=
nn);
> +    if (!current) {
> +        return;
> +    }
> +
> +    g_dbus_object_manager_server_set_connection(display->server, conn);
>      g_dbus_connection_start_message_processing(conn);
>  }
>
> @@ -290,6 +320,7 @@ dbus_display_add_client(int csock, Error **errp)
>      g_autoptr(GSocket) socket =3D NULL;
>      g_autoptr(GSocketConnection) conn =3D NULL;
>      g_autofree char *guid =3D g_dbus_generate_guid();
> +    DBusDisplayAddClientData *data;
>
>      if (!dbus_display) {
>          error_setg(errp, "p2p connections not accepted in bus mode");
> @@ -298,6 +329,7 @@ dbus_display_add_client(int csock, Error **errp)
>
>      if (dbus_display->add_client_cancellable) {
>          g_cancellable_cancel(dbus_display->add_client_cancellable);
> +        g_clear_object(&dbus_display->add_client_cancellable);
>      }
>
>  #ifdef WIN32
> @@ -318,6 +350,10 @@ dbus_display_add_client(int csock, Error **errp)
>      conn =3D g_socket_connection_factory_create_connection(socket);
>
>      dbus_display->add_client_cancellable =3D g_cancellable_new();
> +    data =3D g_new0(DBusDisplayAddClientData, 1);
> +    data->display =3D DBUS_DISPLAY(object_ref(OBJECT(dbus_display)));
> +    data->cancellable =3D g_object_ref(dbus_display->add_client_cancella=
ble);
> +
>      GDBusConnectionFlags flags =3D
>          G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_SERVER |
>          G_DBUS_CONNECTION_FLAGS_DELAY_MESSAGE_PROCESSING;
> @@ -332,7 +368,7 @@ dbus_display_add_client(int csock, Error **errp)
>                            NULL,
>                            dbus_display->add_client_cancellable,
>                            dbus_display_add_client_ready,
> -                          NULL);
> +                          data);
>
>      return true;
>  }
> --
> 2.43.0
>


