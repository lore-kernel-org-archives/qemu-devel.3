Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF91CD5BCE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 11:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJVZJ-0006ry-Gp; Thu, 13 Nov 2025 06:32:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vJVZ2-000659-7A
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 06:32:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vJVZ0-0007X6-Gy
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 06:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763033549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Huv8plwq/u8CrP/U5uXd8H2NZAYgF4kJZXz/s1gCOwA=;
 b=b0d5OWWLmTMBBuTwzuQT62O5GPxoeSq98GJkW/XgT9RA+gn4NNTEsrGPsahsUm7nNOaDzV
 uzfL5c5EZ/Lm9cuPnxBayHH8W6SaJMKg/aqZG5RK/vVEKGC5mPgcSdvZc3AToNeNp/BSGN
 nwGx07dmrNN+YPov76wpfSb8SUZAm2s=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-QxR9Hn6nMbq4btm9aSCMSQ-1; Thu, 13 Nov 2025 06:32:28 -0500
X-MC-Unique: QxR9Hn6nMbq4btm9aSCMSQ-1
X-Mimecast-MFC-AGG-ID: QxR9Hn6nMbq4btm9aSCMSQ_1763033547
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-343806688cbso1028289a91.3
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 03:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763033547; x=1763638347; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Huv8plwq/u8CrP/U5uXd8H2NZAYgF4kJZXz/s1gCOwA=;
 b=mPDGqE23mvYWHxI1HEDNwWLQNga0vMDoj60TMqlyYKH1DyyhliooIc5wKQ24rW3gAa
 xdM6reMoijPHTXErfTHo3Go7p4JSqq/QmJQZH8W1Ouzde899dx6xhfJmBFCSAPMridp8
 DRnxH5tY33OphzVRUtBApdBH8zrnxUVGMxShaKqMwJ8a9EDetbFTbLJ0ORZfjQvgxFKL
 inCr93nsi2iOawcW4PUVDqzi1yB9xOSF3JydWylQHKBCg2TJlLa0H3Ykb++eaVyTdJcy
 KTqvab3Ov8ZLYXVpFnBqKEYE47CIMUXzvbtqkjdjDOAvNSXfgavbeRCj7qyiIcrgz5e+
 Bseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763033547; x=1763638347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Huv8plwq/u8CrP/U5uXd8H2NZAYgF4kJZXz/s1gCOwA=;
 b=VQU3J2Aug2pBOt+nn/BFrH7VcT8D4AF824q7MA3Vr2v54T9OvzcoDfnyIKb8FkB/8D
 5HRSD6Za3GC/79KnstNdIjFtsj1MrnuSFPuYtZJInyZrD2sSOBMpsLcgqazVb4PLRtmV
 sMvPSLpsbel3VZeR6ros1pZQ1SyHbcyzSDN5PgzEx1f0t6DdRMcJSKHapKOAgkK05P+a
 3qixB0DwwgpIk/1yf6MLFf3ZGLdgj7uscMWvR+3V03EE7WHgLV3Yd5ZUY4HYtQGjd2lV
 YR5svS1zAvISojN8pICigWx81+DYNavtT/hOjjVjvB1bfeKri8FgwdqcYyt+UEcKvbWw
 GbJg==
X-Gm-Message-State: AOJu0YyGALvloldGWU5RBgDJ2+UjlfkK+J9pb8iPQoZrM6jVcbUtguAx
 ob4owmvZ4Y7rj8ZkcLA24zjlMAYy/9Vt8BekC9LyAR2m0QK5jCKn5IgvTPlOoELaKUvy17CDxrI
 o7FuC1BK8UEu+x4A8UbUmCbbrsv4M1R4QvhIiBfVXkroSkrNlbyjkXzgmj+glX+l8VVIppPzDvb
 2nB0J52ouJNx6vDnqFr/3ykz9cyHT5ETA=
X-Gm-Gg: ASbGncvYlGd/LUAEbwBleCdQGXiFWprbznLfEUKdW8fG/v9HvSUpTFlyoNMaE1hZFnf
 AHCyNmnV1pQY1ITkwwf6BQ70GkNVrIJYWCn+GOSNbkbn3N9nlrkfpzq/85UEdoGnM2Yeec3w0Fc
 KIZivZ2Dst1ClYUamWgMFsrYC4wcgTAXkI9y1GXF3X354SkJ0LV+NYWO6Nk9sYPLhfLzU4vdkXh
 HkOVxzwyXtqXks=
X-Received: by 2002:a17:90a:e710:b0:341:d265:1e82 with SMTP id
 98e67ed59e1d1-343ddec1d11mr7435352a91.29.1763033547078; 
 Thu, 13 Nov 2025 03:32:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSnUFSV4hzvdSHVCFVQEQt2oFZtxbynC1XL5SG/me9Yn8wY1HD6B3iN6D4ErU0LirY/4sIOf7947O/5yDaG3s=
X-Received: by 2002:a17:90a:e710:b0:341:d265:1e82 with SMTP id
 98e67ed59e1d1-343ddec1d11mr7435327a91.29.1763033546658; Thu, 13 Nov 2025
 03:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20251112134143.27194-1-philmd@linaro.org>
 <20251112134143.27194-3-philmd@linaro.org>
In-Reply-To: <20251112134143.27194-3-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Nov 2025 15:32:14 +0400
X-Gm-Features: AWmQ_bmVGVH309ZBbUPfC0BxLa3iq27uF3rO0UF5BROXKr9AoudqA3IFoFt7iqk
Message-ID: <CAMxuvaxYsvQfrKOBmRVC=Fp+1zx8bHMkF7Pxwx6KNDWLqi9VMw@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] chardev/char-io: Add @docstrings for
 io_channel_send[_full]()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000046a9d60643783c9f"
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

--00000000000046a9d60643783c9f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 5:42=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  include/chardev/char-io.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/include/chardev/char-io.h b/include/chardev/char-io.h
> index ac379ea70e3..5b181be6a0b 100644
> --- a/include/chardev/char-io.h
> +++ b/include/chardev/char-io.h
> @@ -38,8 +38,28 @@ GSource *io_add_watch_poll(Chardev *chr,
>
>  void remove_fd_in_watch(Chardev *chr);
>
> +/**
> + * io_channel_send:
> + * @ioc: the IO channel object
> + * @buf: the data
> + * @len: the number of bytes to send
> + *
> + * Returns: the number of bytes consumed or -1 on error.
> + * On error, %errno is also set as appropriate.
> + */
>  int io_channel_send(QIOChannel *ioc, const void *buf, size_t len);
>
> +/**
> + * io_channel_send_full:
> + * @ioc: the IO channel object
> + * @buf: the data
> + * @len: the number of bytes to send
> + * @fds: an array of file handles to send
> + * @nfds: number of file handles in @fds
> + *
> + * Returns: the number of bytes consumed or -1 on error.
> + * On error, %errno is also set as appropriate.
> + */
>  int io_channel_send_full(QIOChannel *ioc, const void *buf, size_t len,
>                           int *fds, size_t nfds);
>
> --
> 2.51.0
>
>

--00000000000046a9d60643783c9f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 12,=
 2025 at 5:42=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:=
philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Signed-off-by: Philippe Mathieu-Daud=C3=
=A9 &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@linar=
o.org</a>&gt;<br></blockquote><div><br></div><div>Reviewed-by: Marc-Andr=C3=
=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lur=
eau@redhat.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
---<br>
=C2=A0include/chardev/char-io.h | 20 ++++++++++++++++++++<br>
=C2=A01 file changed, 20 insertions(+)<br>
<br>
diff --git a/include/chardev/char-io.h b/include/chardev/char-io.h<br>
index ac379ea70e3..5b181be6a0b 100644<br>
--- a/include/chardev/char-io.h<br>
+++ b/include/chardev/char-io.h<br>
@@ -38,8 +38,28 @@ GSource *io_add_watch_poll(Chardev *chr,<br>
<br>
=C2=A0void remove_fd_in_watch(Chardev *chr);<br>
<br>
+/**<br>
+ * io_channel_send:<br>
+ * @ioc: the IO channel object<br>
+ * @buf: the data<br>
+ * @len: the number of bytes to send<br>
+ *<br>
+ * Returns: the number of bytes consumed or -1 on error.<br>
+ * On error, %errno is also set as appropriate.<br>
+ */<br>
=C2=A0int io_channel_send(QIOChannel *ioc, const void *buf, size_t len);<br=
>
<br>
+/**<br>
+ * io_channel_send_full:<br>
+ * @ioc: the IO channel object<br>
+ * @buf: the data<br>
+ * @len: the number of bytes to send<br>
+ * @fds: an array of file handles to send<br>
+ * @nfds: number of file handles in @fds<br>
+ *<br>
+ * Returns: the number of bytes consumed or -1 on error.<br>
+ * On error, %errno is also set as appropriate.<br>
+ */<br>
=C2=A0int io_channel_send_full(QIOChannel *ioc, const void *buf, size_t len=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int *fds, size_t nfds);<br>
<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div></div>

--00000000000046a9d60643783c9f--


