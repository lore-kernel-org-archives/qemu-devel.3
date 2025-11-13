Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FE2CD5BCE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 11:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJVZ5-0006CW-RK; Thu, 13 Nov 2025 06:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vJVYY-0005aP-Cz
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 06:32:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vJVYW-0007V5-64
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 06:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763033519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JyvvNBbs0r6nhHSQfmAuFPatiNO1j0fZDxkPfvONF1s=;
 b=dbtAgYPgfIy2YdPXoEwmiaJtlJnXTuZkvO3ybyiNpUYQv3ErJe/j8MY8cYjzL9V2SAKW1d
 sk3W6OY1TqB3PVuN4fBnHqp8m+xUecLIAbb0m8Cn68QSVGboANvWtJo3n9c0gPhyi4KMqg
 gpgolweYf++Ulrf3n3K2csk66QCvydI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-FSGCsRZhOVma8ayhXAUxzA-1; Thu, 13 Nov 2025 06:31:57 -0500
X-MC-Unique: FSGCsRZhOVma8ayhXAUxzA-1
X-Mimecast-MFC-AGG-ID: FSGCsRZhOVma8ayhXAUxzA_1763033517
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-bc2a04abc5aso608984a12.2
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 03:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763033517; x=1763638317; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JyvvNBbs0r6nhHSQfmAuFPatiNO1j0fZDxkPfvONF1s=;
 b=IndylFkCrM8BERcylMemDEcmduXozIxAboMuJ12LQh2ArlqWp0llgfXvj/VzHSjser
 U0kOsAfz4+eBrrQMCeoJzoVsfknUU9rC8Iiqhrky9/+HnJulfnMohTh0zu7QaHCVFSxe
 MzVqIaa7UAUU5MKOP1WOHsGwyBcMGlEZc+JNvaCmk2KBZx++/TaWRHof91hGjH7FHEpt
 9PHH3sE68RlPIh8HULiO7iI4zb6/h+H5fwtTui3RoqIo9telpSDpUx6Cje2RmZvrfh7i
 D/vtdN4qCUWyQLjIqCpHEneV3U6yUq99Ze2dGBTq0/uTCpsC6ytQ0j5rWtKxFEXq7wR/
 dLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763033517; x=1763638317;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JyvvNBbs0r6nhHSQfmAuFPatiNO1j0fZDxkPfvONF1s=;
 b=sZq2NUk92NVtMNKfDBuTo2iH/wO0vG7pOuv6KfCRhLk5fWwYqrDnoTxW2jbeW46ZuP
 ZJDq9jarIsYn5hZk8OY6a30gfdOtIgLXA0sqyLGlWPaN5ZNas577ea7vOKTrvY3/0De8
 dwVh209jKZRe8XBrZFj72LEEJXTxjZ/XgEjtYSaQaFozVzft74e/w55tWevBVHMXVCAH
 OIcJbkF4LKygj+ktmZCPIR/f+6QSEDeFvE4PgiSAZjSXuYNN0GsDk+7LTDVeb5eNUb8x
 pKXBMIbAj1FMPnOLOpfd1XeHzpPZTZsPal6kHStdxhz+jLKe9mI7qojtiFb3SkSGDQ/Z
 1NoQ==
X-Gm-Message-State: AOJu0Yyq6XUOHpd4kPbbOJG1SlvMjjM9nHB0BoBv3nfGAdRnY3SOBpwT
 S3do5wlHrJsjfUwwMznyUOs/jrL0EW6GuQS8WHSTATUaRtVL0QjSIuVTcjVMUJdukQGnJJ/Bz+r
 NQo5vZAYncIciHcE5QZFTFZOswaN0YFdt9onj4qM3XRmHw1U84Agnh4exNJLOJiByL6GKwf1xfv
 WA/U8uS6ySQlb0MppnMTPwm4ac9jtpITk=
X-Gm-Gg: ASbGncsJfPvgtI4SYy6cTMolDaUNXYAU12qKmtg9XVWjFLaBVubyKKz6W8LBYuB8dNT
 XoeFNuH8bV4k86wOtpgb9mtQRu6Cb7quVG2OfxAgH2L+emQ5iwQ9QgiYwc6DNHv/MBqwmHfv3NK
 yKuVOVpyxq4ci9S55nkkGWN0gsPfvEKIpg9QlvQpPaTqw/GZm0nwoqIcZDTj2SzX8uKHeZrpvp/
 LKSXsCsAs8wE68=
X-Received: by 2002:a17:903:2c05:b0:297:f088:56e6 with SMTP id
 d9443c01a7336-2984eda0de8mr86940885ad.25.1763033516708; 
 Thu, 13 Nov 2025 03:31:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEInBjbWiBk72ICaw/01e941wWuI2gcpeYq5qVWAAAqKhixTIrqbWXPzQ62DWZPvg43Ee2vUc3XEouSE5eZUt8=
X-Received: by 2002:a17:903:2c05:b0:297:f088:56e6 with SMTP id
 d9443c01a7336-2984eda0de8mr86940605ad.25.1763033516318; Thu, 13 Nov 2025
 03:31:56 -0800 (PST)
MIME-Version: 1.0
References: <20251112134143.27194-1-philmd@linaro.org>
 <20251112134143.27194-2-philmd@linaro.org>
In-Reply-To: <20251112134143.27194-2-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Nov 2025 15:31:44 +0400
X-Gm-Features: AWmQ_bmuUo-WLZ9b3TtjUvGdCqsyhVCj-aGtlXmGlhQZZaeF6YCg6AdoE6UpJiU
Message-ID: <CAMxuvax+u21iCDx3SX3AtQDh8mS2vL53yJUYwnMDMBeDspXwqQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] chardev/char-fe: Improve @docstrings
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000077b4d60643783a14"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

--00000000000077b4d60643783a14
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 5:41=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Describe the @c (this is the *frontend*) and @s (the *backend*)
> parameters. Fill qemu_chr_fe_[gs]et_msgfds() method docstrings.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  include/chardev/char-fe.h | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
> index 5f8a6df17dc..36bcf1f88a6 100644
> --- a/include/chardev/char-fe.h
> +++ b/include/chardev/char-fe.h
> @@ -26,6 +26,8 @@ struct CharFrontend {
>
>  /**
>   * qemu_chr_fe_init:
> + * @c: the character frontend
> + * @s: the character backend
>   *
>   * Initializes the frontend @c for the given Chardev backend @s. Call
>   * qemu_chr_fe_deinit() to remove the association and release the backen=
d.
> @@ -47,6 +49,7 @@ void qemu_chr_fe_deinit(CharFrontend *c, bool del);
>
>  /**
>   * qemu_chr_fe_get_driver:
> + * @c: the character frontend
>   *
>   * Returns: the driver associated with a CharFrontend or NULL if no
>   * associated Chardev.
> @@ -58,6 +61,7 @@ Chardev *qemu_chr_fe_get_driver(CharFrontend *c);
>
>  /**
>   * qemu_chr_fe_backend_connected:
> + * @c: the character frontend
>   *
>   * Returns: true if there is a backend associated with @c.
>   */
> @@ -102,6 +106,7 @@ void qemu_chr_fe_set_handlers_full(CharFrontend *c,
>
>  /**
>   * qemu_chr_fe_set_handlers:
> + * @c: the character frontend
>   *
>   * Version of qemu_chr_fe_set_handlers_full() with sync_state =3D true.
>   */
> @@ -116,6 +121,7 @@ void qemu_chr_fe_set_handlers(CharFrontend *c,
>
>  /**
>   * qemu_chr_fe_take_focus:
> + * @c: the character frontend
>   *
>   * Take the focus (if the front end is muxed).
>   *
> @@ -125,6 +131,7 @@ void qemu_chr_fe_take_focus(CharFrontend *c);
>
>  /**
>   * qemu_chr_fe_accept_input:
> + * @c: the character frontend
>   *
>   * Notify that the frontend is ready to receive data
>   */
> @@ -132,6 +139,7 @@ void qemu_chr_fe_accept_input(CharFrontend *c);
>
>  /**
>   * qemu_chr_fe_disconnect:
> + * @c: the character frontend
>   *
>   * Close a fd accepted by character backend.
>   * Without associated Chardev, do nothing.
> @@ -148,6 +156,7 @@ int qemu_chr_fe_wait_connected(CharFrontend *c, Error
> **errp);
>
>  /**
>   * qemu_chr_fe_set_echo:
> + * @c: the character frontend
>   * @echo: true to enable echo, false to disable echo
>   *
>   * Ask the backend to override its normal echo setting.  This only reall=
y
> @@ -169,6 +178,7 @@ void qemu_chr_fe_set_open(CharFrontend *c, bool
> is_open);
>
>  /**
>   * qemu_chr_fe_printf:
> + * @c: the character frontend
>   * @fmt: see #printf
>   *
>   * Write to a character backend using a printf style interface.  This
> @@ -197,6 +207,7 @@ typedef gboolean (*FEWatchFunc)(void *do_not_use,
> GIOCondition condition, void *
>
>  /**
>   * qemu_chr_fe_add_watch:
> + * @c: the character frontend
>   * @cond: the condition to poll for
>   * @func: the function to call when the condition happens
>   * @user_data: the opaque pointer to pass to @func
> @@ -219,6 +230,7 @@ guint qemu_chr_fe_add_watch(CharFrontend *c,
> GIOCondition cond,
>
>  /**
>   * qemu_chr_fe_write:
> + * @c: the character frontend to write to
>   * @buf: the data
>   * @len: the number of bytes to send
>   *
> @@ -233,6 +245,7 @@ int qemu_chr_fe_write(CharFrontend *c, const uint8_t
> *buf, int len);
>
>  /**
>   * qemu_chr_fe_write_all:
> + * @c: the character frontend to write to
>   * @buf: the data
>   * @len: the number of bytes to send
>   *
> @@ -248,6 +261,7 @@ int qemu_chr_fe_write_all(CharFrontend *c, const
> uint8_t *buf, int len);
>
>  /**
>   * qemu_chr_fe_read_all:
> + * @c: the character frontend to read from
>   * @buf: the data buffer
>   * @len: the number of bytes to read
>   *
> @@ -260,6 +274,7 @@ int qemu_chr_fe_read_all(CharFrontend *c, uint8_t
> *buf, int len);
>
>  /**
>   * qemu_chr_fe_ioctl:
> + * @c: the character frontend to control
>   * @cmd: see CHR_IOCTL_*
>   * @arg: the data associated with @cmd
>   *
> @@ -273,6 +288,7 @@ int qemu_chr_fe_ioctl(CharFrontend *c, int cmd, void
> *arg);
>
>  /**
>   * qemu_chr_fe_get_msgfd:
> + * @c: the character frontend to access
>   *
>   * For backends capable of fd passing, return the latest file descriptor
> passed
>   * by a client.
> @@ -286,9 +302,12 @@ int qemu_chr_fe_get_msgfd(CharFrontend *c);
>
>  /**
>   * qemu_chr_fe_get_msgfds:
> + * @c: the character frontend
> + * @fds: an array of ancillary file descriptors to get
> + * @num: the maximum number of ancillary file descriptors to get in @fds
>   *
>   * For backends capable of fd passing, return the number of file receive=
d
> - * descriptors and fills the fds array up to num elements
> + * descriptors and fills the fds array up to @num elements
>   *
>   * Returns: -1 if fd passing isn't supported or there are no pending fil=
e
>   *          descriptors.  If file descriptors are returned, subsequent
> calls to
> @@ -299,6 +318,9 @@ int qemu_chr_fe_get_msgfds(CharFrontend *c, int *fds,
> int num);
>
>  /**
>   * qemu_chr_fe_set_msgfds:
> + * @c: the character frontend
> + * @fds: an array of ancillary file descriptors to set
> + * @num: the number of ancillary file descriptors to set
>   *
>   * For backends capable of fd passing, set an array of fds to be passed
> with
>   * the next send operation.
> --
> 2.51.0
>
>

--00000000000077b4d60643783a14
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 12,=
 2025 at 5:41=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:=
philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Describe the @c (this is the *frontend*=
) and @s (the *backend*)<br>
parameters. Fill qemu_chr_fe_[gs]et_msgfds() method docstrings.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:mar=
candre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0include/chardev/char-fe.h | 24 +++++++++++++++++++++++-<br>
=C2=A01 file changed, 23 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h<br>
index 5f8a6df17dc..36bcf1f88a6 100644<br>
--- a/include/chardev/char-fe.h<br>
+++ b/include/chardev/char-fe.h<br>
@@ -26,6 +26,8 @@ struct CharFrontend {<br>
<br>
=C2=A0/**<br>
=C2=A0 * qemu_chr_fe_init:<br>
+ * @c: the character frontend<br>
+ * @s: the character backend<br>
=C2=A0 *<br>
=C2=A0 * Initializes the frontend @c for the given Chardev backend @s. Call=
<br>
=C2=A0 * qemu_chr_fe_deinit() to remove the association and release the bac=
kend.<br>
@@ -47,6 +49,7 @@ void qemu_chr_fe_deinit(CharFrontend *c, bool del);<br>
<br>
=C2=A0/**<br>
=C2=A0 * qemu_chr_fe_get_driver:<br>
+ * @c: the character frontend<br>
=C2=A0 *<br>
=C2=A0 * Returns: the driver associated with a CharFrontend or NULL if no<b=
r>
=C2=A0 * associated Chardev.<br>
@@ -58,6 +61,7 @@ Chardev *qemu_chr_fe_get_driver(CharFrontend *c);<br>
<br>
=C2=A0/**<br>
=C2=A0 * qemu_chr_fe_backend_connected:<br>
+ * @c: the character frontend<br>
=C2=A0 *<br>
=C2=A0 * Returns: true if there is a backend associated with @c.<br>
=C2=A0 */<br>
@@ -102,6 +106,7 @@ void qemu_chr_fe_set_handlers_full(CharFrontend *c,<br>
<br>
=C2=A0/**<br>
=C2=A0 * qemu_chr_fe_set_handlers:<br>
+ * @c: the character frontend<br>
=C2=A0 *<br>
=C2=A0 * Version of qemu_chr_fe_set_handlers_full() with sync_state =3D tru=
e.<br>
=C2=A0 */<br>
@@ -116,6 +121,7 @@ void qemu_chr_fe_set_handlers(CharFrontend *c,<br>
<br>
=C2=A0/**<br>
=C2=A0 * qemu_chr_fe_take_focus:<br>
+ * @c: the character frontend<br>
=C2=A0 *<br>
=C2=A0 * Take the focus (if the front end is muxed).<br>
=C2=A0 *<br>
@@ -125,6 +131,7 @@ void qemu_chr_fe_take_focus(CharFrontend *c);<br>
<br>
=C2=A0/**<br>
=C2=A0 * qemu_chr_fe_accept_input:<br>
+ * @c: the character frontend<br>
=C2=A0 *<br>
=C2=A0 * Notify that the frontend is ready to receive data<br>
=C2=A0 */<br>
@@ -132,6 +139,7 @@ void qemu_chr_fe_accept_input(CharFrontend *c);<br>
<br>
=C2=A0/**<br>
=C2=A0 * qemu_chr_fe_disconnect:<br>
+ * @c: the character frontend<br>
=C2=A0 *<br>
=C2=A0 * Close a fd accepted by character backend.<br>
=C2=A0 * Without associated Chardev, do nothing.<br>
@@ -148,6 +156,7 @@ int qemu_chr_fe_wait_connected(CharFrontend *c, Error *=
*errp);<br>
<br>
=C2=A0/**<br>
=C2=A0 * qemu_chr_fe_set_echo:<br>
+ * @c: the character frontend<br>
=C2=A0 * @echo: true to enable echo, false to disable echo<br>
=C2=A0 *<br>
=C2=A0 * Ask the backend to override its normal echo setting.=C2=A0 This on=
ly really<br>
@@ -169,6 +178,7 @@ void qemu_chr_fe_set_open(CharFrontend *c, bool is_open=
);<br>
<br>
=C2=A0/**<br>
=C2=A0 * qemu_chr_fe_printf:<br>
+ * @c: the character frontend<br>
=C2=A0 * @fmt: see #printf<br>
=C2=A0 *<br>
=C2=A0 * Write to a character backend using a printf style interface.=C2=A0=
 This<br>
@@ -197,6 +207,7 @@ typedef gboolean (*FEWatchFunc)(void *do_not_use, GIOCo=
ndition condition, void *<br>
<br>
=C2=A0/**<br>
=C2=A0 * qemu_chr_fe_add_watch:<br>
+ * @c: the character frontend<br>
=C2=A0 * @cond: the condition to poll for<br>
=C2=A0 * @func: the function to call when the condition happens<br>
=C2=A0 * @user_data: the opaque pointer to pass to @func<br>
@@ -219,6 +230,7 @@ guint qemu_chr_fe_add_watch(CharFrontend *c, GIOConditi=
on cond,<br>
<br>
=C2=A0/**<br>
=C2=A0 * qemu_chr_fe_write:<br>
+ * @c: the character frontend to write to<br>
=C2=A0 * @buf: the data<br>
=C2=A0 * @len: the number of bytes to send<br>
=C2=A0 *<br>
@@ -233,6 +245,7 @@ int qemu_chr_fe_write(CharFrontend *c, const uint8_t *b=
uf, int len);<br>
<br>
=C2=A0/**<br>
=C2=A0 * qemu_chr_fe_write_all:<br>
+ * @c: the character frontend to write to<br>
=C2=A0 * @buf: the data<br>
=C2=A0 * @len: the number of bytes to send<br>
=C2=A0 *<br>
@@ -248,6 +261,7 @@ int qemu_chr_fe_write_all(CharFrontend *c, const uint8_=
t *buf, int len);<br>
<br>
=C2=A0/**<br>
=C2=A0 * qemu_chr_fe_read_all:<br>
+ * @c: the character frontend to read from<br>
=C2=A0 * @buf: the data buffer<br>
=C2=A0 * @len: the number of bytes to read<br>
=C2=A0 *<br>
@@ -260,6 +274,7 @@ int qemu_chr_fe_read_all(CharFrontend *c, uint8_t *buf,=
 int len);<br>
<br>
=C2=A0/**<br>
=C2=A0 * qemu_chr_fe_ioctl:<br>
+ * @c: the character frontend to control<br>
=C2=A0 * @cmd: see CHR_IOCTL_*<br>
=C2=A0 * @arg: the data associated with @cmd<br>
=C2=A0 *<br>
@@ -273,6 +288,7 @@ int qemu_chr_fe_ioctl(CharFrontend *c, int cmd, void *a=
rg);<br>
<br>
=C2=A0/**<br>
=C2=A0 * qemu_chr_fe_get_msgfd:<br>
+ * @c: the character frontend to access<br>
=C2=A0 *<br>
=C2=A0 * For backends capable of fd passing, return the latest file descrip=
tor passed<br>
=C2=A0 * by a client.<br>
@@ -286,9 +302,12 @@ int qemu_chr_fe_get_msgfd(CharFrontend *c);<br>
<br>
=C2=A0/**<br>
=C2=A0 * qemu_chr_fe_get_msgfds:<br>
+ * @c: the character frontend<br>
+ * @fds: an array of ancillary file descriptors to get<br>
+ * @num: the maximum number of ancillary file descriptors to get in @fds<b=
r>
=C2=A0 *<br>
=C2=A0 * For backends capable of fd passing, return the number of file rece=
ived<br>
- * descriptors and fills the fds array up to num elements<br>
+ * descriptors and fills the fds array up to @num elements<br>
=C2=A0 *<br>
=C2=A0 * Returns: -1 if fd passing isn&#39;t supported or there are no pend=
ing file<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 descriptors.=C2=A0 If file descr=
iptors are returned, subsequent calls to<br>
@@ -299,6 +318,9 @@ int qemu_chr_fe_get_msgfds(CharFrontend *c, int *fds, i=
nt num);<br>
<br>
=C2=A0/**<br>
=C2=A0 * qemu_chr_fe_set_msgfds:<br>
+ * @c: the character frontend<br>
+ * @fds: an array of ancillary file descriptors to set<br>
+ * @num: the number of ancillary file descriptors to set<br>
=C2=A0 *<br>
=C2=A0 * For backends capable of fd passing, set an array of fds to be pass=
ed with<br>
=C2=A0 * the next send operation.<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div></div>

--00000000000077b4d60643783a14--


