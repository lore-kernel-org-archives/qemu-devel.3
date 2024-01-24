Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87660C47DDF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 11:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSb4n-0000w2-WE; Wed, 24 Jan 2024 06:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rSb4m-0000vf-4W
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 06:05:48 -0500
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rSb4k-0004ax-LW
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 06:05:47 -0500
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-42a029c8e62so36791761cf.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 03:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706094345; x=1706699145; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=53YEnWdPdhxryUq2GOSkVfxXJjzVokFjcst8rz25LTw=;
 b=Mvl0XB/w8Ek3fhQGVpLXQ/c/w1m23XNKctCbOlsOH9oceF4qM9lz2JjEmEI8g9+gHz
 j818Ir3Sltq4Jht7b+8BE+SFxJFQafB0rZGS3hqu+SFtACulkq8GAJTL7Anpa+v5o5fW
 zO/gWThqY7JN86y/vry2QWQ3nmaRl7QMhrdXr+d2tDfA/JP/4RXDCTiSp8QyCghEmfM8
 GqQ/hUAJEc5d5CxNMzQTBq0eP+J4XzSBbjW5TsUIkbk0zZPx7sjlVTsyNXhH3zWwJN9l
 /ZUhQ7x/aYmbFjEitPCqPGo+oZfIKX5DBghexOR+TWyoMtBh5qoEeKGJFYSIvq5VR+nb
 gVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706094345; x=1706699145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=53YEnWdPdhxryUq2GOSkVfxXJjzVokFjcst8rz25LTw=;
 b=SJrn7UVpCOlEhdnxlNxalcsARK2W94Bqx68PHYbQx2o/7E27hhIBmDC/8sJB71jzJl
 zH7Eo6tGQmVqUjuj7NLqUYkCHx6jTPq5ZmvKFWJtVVIQm1+T40CJ+r56/lP+4dlu1W35
 qGjhtD1+1xo7Doizc2CJJzmTJBr4cWR8Y9GeBTON86qVn0tkfX1EjDRa6D3Y5VnakQqu
 eErk7T+38ULRNSsC5VI2Ahx70OX90sxsEEf2I5BdVxyZVV5FVDN9SOWa94mLZCztc0j6
 KhPePIoLH7HXgot/8OaRodvixF9yahF0LZJXt3Yja/PUmkmYgQjzzM3A2pFFTvghtywX
 CEMg==
X-Gm-Message-State: AOJu0YzP99urNJGgwsnqdq2rn6avA7OYdrxqRVrZLNEUoBh81NnhFlFB
 tstzzDhNiQ/X2HVpKMxrA2pZJs9oHIgPtv3F8SMKzT+Ki4v04dO5LQA6e1E2ukGlcMNdpofQ8wk
 rcZ+F6srNt3fMsH2rFUV7Cgb84so=
X-Google-Smtp-Source: AGHT+IELAPj3xsjRMozN3nVXtm58WM0tvu77YqF+P5pVoZznq4zCIyrO7TjRbpWmsLnNstiXsgY8WbhjzCK3SiaOioA=
X-Received: by 2002:ac8:5a51:0:b0:42a:5590:3165 with SMTP id
 o17-20020ac85a51000000b0042a55903165mr1983187qta.127.1706094345158; Wed, 24
 Jan 2024 03:05:45 -0800 (PST)
MIME-Version: 1.0
References: <20240124105749.204610-1-f.ebner@proxmox.com>
 <20240124105749.204610-2-f.ebner@proxmox.com>
In-Reply-To: <20240124105749.204610-2-f.ebner@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 24 Jan 2024 15:05:34 +0400
Message-ID: <CAJ+F1C+JFUM6QH6cfvqUzaSE04upc_1uuo0QH=5+a4jr++GYuQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ui/clipboard: add asserts for update and request
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, m.frank@proxmox.com, 
 berrange@redhat.com, mcascell@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 24, 2024 at 2:59=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> Should an issue like CVE-2023-6683 ever appear again in the future,
> it will be more obvious which assumption was violated.
>
> Suggested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

thanks

> ---
>
> Changes in v3:
>     * Turn check for update into an assertion.
>     * Split out into a separate patch.
>
>  ui/clipboard.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/ui/clipboard.c b/ui/clipboard.c
> index b3f6fa3c9e..4264884a6c 100644
> --- a/ui/clipboard.c
> +++ b/ui/clipboard.c
> @@ -65,12 +65,24 @@ bool qemu_clipboard_check_serial(QemuClipboardInfo *i=
nfo, bool client)
>
>  void qemu_clipboard_update(QemuClipboardInfo *info)
>  {
> +    uint32_t type;
>      QemuClipboardNotify notify =3D {
>          .type =3D QEMU_CLIPBOARD_UPDATE_INFO,
>          .info =3D info,
>      };
>      assert(info->selection < QEMU_CLIPBOARD_SELECTION__COUNT);
>
> +    for (type =3D 0; type < QEMU_CLIPBOARD_TYPE__COUNT; type++) {
> +        /*
> +         * If data is missing, the clipboard owner's 'request' callback =
needs to
> +         * be set. Otherwise, there is no way to get the clipboard data =
and
> +         * qemu_clipboard_request() cannot be called.
> +         */
> +        if (info->types[type].available && !info->types[type].data) {
> +            assert(info->owner && info->owner->request);
> +        }
> +    }
> +
>      notifier_list_notify(&clipboard_notifiers, &notify);
>
>      if (cbinfo[info->selection] !=3D info) {
> @@ -132,6 +144,8 @@ void qemu_clipboard_request(QemuClipboardInfo *info,
>          !info->owner)
>          return;
>
> +    assert(info->owner->request);
> +
>      info->types[type].requested =3D true;
>      info->owner->request(info, type);
>  }
> --
> 2.39.2
>
>
>


--=20
Marc-Andr=C3=A9 Lureau

