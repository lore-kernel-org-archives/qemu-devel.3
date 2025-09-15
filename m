Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DBFCAC598
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 10:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy6YV-0002b0-Nq; Mon, 15 Sep 2025 06:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy6YT-0002aO-0K
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:35:30 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy6YJ-0001OW-W6
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:35:28 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45dec026c78so41234545e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 03:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757932510; x=1758537310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m1WPbeC8Knedd2wFDxucmusQXXig2m9VYnzWI+NqJ1Q=;
 b=As/m5ecHE7A55nFe4V1KZ19AixNcatGL/6GNMrzWqCpNAULAa9pGhQTCgHqia7XOZ3
 pVn75cGIwSFndi+SgJFpOqKrpganUGaaWr8Wr/7nGIw3vE2huCkiJ+gCODxThuR3EqCL
 /CWsPV5MtxrR2/nUMtjJSRFZ1bMARrdsh/SQGbi6kDPl7WFOTDDiTHsBG4Jw5/U92rv2
 OmlgRSPaHoynGl3IgNi0qYM3gbyQnYXh3YFbHj9/JTAzNMJFeCf+G8CyspMSxFvKv8NB
 MEXG3dHCz+LKpgwE75hym7rfm50+PA1ex2rYNpp4nocQcMcwtBDGgbogWIEetYAa6Aia
 x/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757932510; x=1758537310;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m1WPbeC8Knedd2wFDxucmusQXXig2m9VYnzWI+NqJ1Q=;
 b=Xij7hJIVynkq5SH9HotEU3GkXrGKJH3VE/IAtutLTvtpFg/LVqnKQ/76MwTndZFHl0
 QmKjEJNHReAgqIu+mdVcYranfgEtlVfuwiObdEJJKg4mUHYfVjHCMm36PzNA6jMUw4O0
 ME1FopqyL/Dzu5JUNevtqdKw3iHp0tL1OfZF+0J8x2hmtsLk8ljS3J+5Lg7Nn/Z4wZlB
 NOPo/728JwwGT9INxpckuoVVHPyx7celcOPw8K81P8NX4KeHtx/o4rHrtXkFNgEsyKqt
 U1AJIRXnl1nfTV0twiqEi+pX7XBBP1+/k/j1GEXAL+8VtseLDurlTypXamq7lYuDW7hh
 Ol8Q==
X-Gm-Message-State: AOJu0Yx55QvXBFbsd0VSWzpI54YJpQ2PDP/6KsGCFebPuslvcpieY5CT
 GiQTW1CgIoCmBo1aQHBo87C8LizP7peYw2XKIElsKMJM2+0673lLW+2UNcT38xIUi5A=
X-Gm-Gg: ASbGncu4osslEyu+RuupbHUeo0cXaZK4RTIrVsydLfqS+DgxHXLhaxkP3aqgQqNId/o
 1FVL/wuyAxTa2b7Nqko3/9ASWtOKh96HOd1dQnaZ4vGpkMLLs7u/12ooXW7NsxVj44v7QIOr3oR
 FQymK9pRzHcmYXnIoPEoyTEaw315q+vrN/jDwcgEp6455Gg7ciKrhN5IUlWkn6iNQy1PzoSyDSd
 CrzBYJN4MibMqkEiSbyG/nyV78cbO9S+8Ks1yfcTRZEbRMUq9g/ttOXUZ/Eh1/y7FoikrfPNBgr
 oi1NOC5xeQ8cjXMdHY8iwC2TecBRgq7ZOPGNkXDkXV+mHMefguLfCJvn3O94EKFIgTdRJ8tqVN4
 /Ujq5edZP/B65mTXJnBUqZvT2RogLJnH2IA==
X-Google-Smtp-Source: AGHT+IG/BG/opD/iNOfEADTKtGuJOeb+vBXbzip1AQzBqqbfZpqLqluM1E2Ca21vNIdo6j7zOr/EBA==
X-Received: by 2002:a05:600c:1387:b0:45c:17a:4c98 with SMTP id
 5b1f17b1804b1-45f211f8ed1mr96198435e9.19.1757932509938; 
 Mon, 15 Sep 2025 03:35:09 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45f28c193f9sm92077975e9.2.2025.09.15.03.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 03:35:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4514A5F867;
 Mon, 15 Sep 2025 11:35:08 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: qemu-devel@nongnu.org,  alessandro.ratti@gmail.com,  philmd@linaro.org
Subject: Re: [PATCH] virtio: Add function name to error messages
In-Reply-To: <20250915100701.224156-2-alessandro@0x65c.net> (Alessandro
 Ratti's message of "Mon, 15 Sep 2025 12:01:07 +0200")
References: <20250915100701.224156-1-alessandro@0x65c.net>
 <20250915100701.224156-2-alessandro@0x65c.net>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 15 Sep 2025 11:35:08 +0100
Message-ID: <87a52wqa03.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Alessandro Ratti <alessandro@0x65c.net> writes:

> Replace virtio_error() with a macro that automatically prepends the
> calling function name to error messages. This provides better context
> for debugging virtio issues by showing exactly which function
> encountered the error.
>
> Before: "Invalid queue size: 1024"
> After:  "virtio_queue_set_num: Invalid queue size: 1024"
>
> The implementation uses a macro to insert __func__ at compile time,
> avoiding any runtime overhead while providing more specific error
> context than a generic "virtio:" prefix.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/230
> Buglink: https://bugs.launchpad.net/qemu/+bug/1919021
>
> Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
> ---
>  hw/virtio/virtio.c         | 2 +-
>  include/hw/virtio/virtio.h | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 9a81ad912e..44528d7f2b 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3931,7 +3931,7 @@ void virtio_device_set_child_bus_name(VirtIODevice =
*vdev, char *bus_name)
>      vdev->bus_name =3D g_strdup(bus_name);
>  }
>=20=20
> -void G_GNUC_PRINTF(2, 3) virtio_error(VirtIODevice *vdev, const char *fm=
t, ...)
> +void G_GNUC_PRINTF(2, 3) virtio_error_impl(VirtIODevice *vdev, const cha=
r *fmt, ...)
>  {
>      va_list ap;
>=20=20
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index c594764f23..961d021497 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -249,7 +249,9 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_=
id, size_t config_size);
>=20=20
>  void virtio_cleanup(VirtIODevice *vdev);
>=20=20
> -void virtio_error(VirtIODevice *vdev, const char *fmt, ...) G_GNUC_PRINT=
F(2, 3);
> +#define virtio_error(vdev, fmt, ...) \
> +    virtio_error_impl(vdev, "%s: " fmt, __func__, ##__VA_ARGS__)
> +void virtio_error_impl(VirtIODevice *vdev, const char *fmt, ...) G_GNUC_=
PRINTF(2, 3);
>=20=20
>  /* Set the child bus name. */
>  void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name=
);

For completeness you could also fixup:

  virtio_error(vdev, "%s: %d reason unknown", __func__, pnd->reason);

for virtio-ballon. Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

