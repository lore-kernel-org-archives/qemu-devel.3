Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A828CCCF9FC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 12:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vERz4-0003tB-UA; Thu, 30 Oct 2025 08:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vERyx-0003so-Au
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 08:42:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vERyh-0007da-7T
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 08:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761828121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XrYhlZeFWBKfKgYiDLaWIQXk8NkZq8ANI03Y4aHp8eE=;
 b=NtwolPBSnobjX2nSPDHl+EKBje/BiHfvWqBupQN1TGhLfpS7RCjLmqMz5H6aCuoXaL3Fsj
 tjgI/EpjXPWDf7rzwjYcJ187cZMhfE6hM1WmxzPjSFNef/PMGwaZZQmRPAHRpGf7GORbDz
 2J2aBm7dxZ7r5OiYMABGfJllpOTxzTc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-Fgq5VwTqO_KjGuixJyLQhQ-1; Thu, 30 Oct 2025 08:40:15 -0400
X-MC-Unique: Fgq5VwTqO_KjGuixJyLQhQ-1
X-Mimecast-MFC-AGG-ID: Fgq5VwTqO_KjGuixJyLQhQ_1761828015
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-87fb496e4d1so43624706d6.3
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 05:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761828015; x=1762432815;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XrYhlZeFWBKfKgYiDLaWIQXk8NkZq8ANI03Y4aHp8eE=;
 b=fnoWJb2tXF8sUBDWUIOe7L/Ndj692R++Gqv3kFFdBZZDV/nRhHYhWN4wWVMbqtHP0/
 9hlbqJDRAgGN5fyTepdJLGDadOqOP9kx7SVzxkrWEb1cVU+dTRvR5qsxa2jdUP73BR6i
 Qmab3Q2ps+T23jAYiU+78q6QnaoPQ5lvytlDoUw0Ob6+rZ+ps7miSOVxdQKNsy/kBqAB
 xRgGxn/Bgp9DGilcApf+o7n3Qmkgen5754eU5cTgyLvhGlYQuCA0W5Q95Ypl2fTYmJYU
 TArHNBb6dfbxiHFzEpEa/zZi+NXorUnnwizVCO7SQWFUtfljbG/ZdzIecUZechsxspxd
 +9iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU905KV3z8B12CSvZmrAaTFZ0iLRshQxsZB6rBzdFBufr3Kylot3Rrpx/I0JKCyjdsirIm6mDkehJx8@nongnu.org
X-Gm-Message-State: AOJu0YwI3qwRJIyn6kTiKHjCnvpSQxrjc9/nRnXFY7KWwbh0nptii/uo
 6mINpc4jdJ3pPchuzm9BUwQ4g9iN37/BtLIK/rqKKwr+mdVV9TwjDqFykYxKbcLx/1h4LSW4Tyz
 OfTp6QHyR4jUZVIPC1L6w3diE8BoJkMsESjIHAI/aA5W2MMuJAyNBivxEHBxtax2GOjeivROKLp
 Iu/wb1jD0nx8crl8NrjxonoKPG1VporMw=
X-Gm-Gg: ASbGncvVhcO5E0gHWVeBY1uvMWlTHlYLQcAacczYS59o8YvQlF2784DXGfEKeitqnKM
 zMqM8wFthwJiNnPF4NXWwztrkojVoiGm3rQxOUgPQr5mUjvsiFuWTWSgAvQw0qBD9kZFUQZmlHf
 utRf1jZiXg4TsucCaZ/8TyBwPMsDA9j1kjB8BZIOiTHWxRqXF7xbpMu7k5MA==
X-Received: by 2002:a05:6214:1c47:b0:87e:f861:712b with SMTP id
 6a1803df08f44-88009c07ef8mr73979776d6.51.1761828014873; 
 Thu, 30 Oct 2025 05:40:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs3z7GMr3qEVu8Y5xh51LwMAd0WEwR8SLEYKEGq5CWh2p+yZM3/+HoHkzeGacxE2N39Aj1B4+F/2gPjDZVzUQ=
X-Received: by 2002:a05:6214:1c47:b0:87e:f861:712b with SMTP id
 6a1803df08f44-88009c07ef8mr73979526d6.51.1761828014498; Thu, 30 Oct 2025
 05:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250926214015.120338-1-r@drigo.nl>
In-Reply-To: <20250926214015.120338-1-r@drigo.nl>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Thu, 30 Oct 2025 14:40:03 +0200
X-Gm-Features: AWmQ_bnND2vZPgGpc0-6BMQDakK7pN3ccRQrCvzEb-7kjFPHRzXvE6uoNKT7xos
Message-ID: <CAPMcbCqSBfD5XKFPo6TJ-YxP74dZbNT+fuW6-iM3AFamCJ2CAg@mail.gmail.com>
Subject: Re: [PATCH] qga: Support guest shutdown of BusyBox-based systems
To: Rodrigo Dias Correa <r@drigo.nl>
Cc: michael.roth@amd.com, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f5b33106425f8c73"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000f5b33106425f8c73
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Best Regards,
Kostiantyn Kostiuk.


On Sat, Sep 27, 2025 at 12:49=E2=80=AFAM Rodrigo Dias Correa <r@drigo.nl> w=
rote:

> On POSIX systems, the QEMU Guest Agent uses /sbin/shutdown to implement
> the command guest-shutdown. Systems based on BusyBox, such as Alpine
> Linux, don't have /sbin/shutdown. They have instead three separate
> commands: poweroff, reboot, and halt.
>
> Change the QEMU Guest Agent to, depending on the mode argument, use
> /sbin/{poweroff,halt,reboot} when they exist, falling back to
> /sbin/shutdown when they don't.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2589
>
> Signed-off-by: Rodrigo Dias Correa <r@drigo.nl>
> ---
>  qga/commands-posix.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 5070f27..c705985 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -213,9 +213,20 @@ out:
>      return retcode;
>  }
>
> +static bool file_exists(const char *path)
> +{
> +    struct stat st;
> +    return stat(path, &st) =3D=3D 0 && (S_ISREG(st.st_mode) ||
> S_ISLNK(st.st_mode));
> +}
> +
> +#define POWEROFF_CMD_PATH "/sbin/poweroff"
> +#define HALT_CMD_PATH "/sbin/halt"
> +#define REBOOT_CMD_PATH "/sbin/reboot"
> +
>  void qmp_guest_shutdown(const char *mode, Error **errp)
>  {
>      const char *shutdown_flag;
> +    const char *shutdown_cmd =3D NULL;
>      Error *local_err =3D NULL;
>
>  #ifdef CONFIG_SOLARIS
> @@ -234,10 +245,19 @@ void qmp_guest_shutdown(const char *mode, Error
> **errp)
>
>      slog("guest-shutdown called, mode: %s", mode);
>      if (!mode || strcmp(mode, "powerdown") =3D=3D 0) {
> +        if (file_exists(POWEROFF_CMD_PATH)) {
> +            shutdown_cmd =3D POWEROFF_CMD_PATH;
> +        }
>          shutdown_flag =3D powerdown_flag;
>      } else if (strcmp(mode, "halt") =3D=3D 0) {
> +        if (file_exists(HALT_CMD_PATH)) {
> +            shutdown_cmd =3D HALT_CMD_PATH;
> +        }
>          shutdown_flag =3D halt_flag;
>      } else if (strcmp(mode, "reboot") =3D=3D 0) {
> +        if (file_exists(REBOOT_CMD_PATH)) {
> +            shutdown_cmd =3D REBOOT_CMD_PATH;
> +        }
>          shutdown_flag =3D reboot_flag;
>      } else {
>          error_setg(errp,
> @@ -255,6 +275,15 @@ void qmp_guest_shutdown(const char *mode, Error
> **errp)
>  #endif
>                            "hypervisor initiated shutdown", (char *) NULL=
};
>
> +    /*
> +     * If the specific command exists (poweroff, halt or reboot), use it
> instead
> +     * of /sbin/shutdown.
> +     */
> +    if (shutdown_cmd !=3D NULL) {
> +        argv[0] =3D shutdown_cmd;
> +        argv[1] =3D NULL;
> +    }
> +
>      ga_run_command(argv, NULL, "shutdown", &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> --
> 2.47.3
>
>

--000000000000f5b33106425f8c73
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto=
:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><d=
iv><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signa=
ture"><div dir=3D"ltr"><div>Best Regards,</div><div>Kostiantyn Kostiuk.</di=
v></div></div></div><br></div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 27, 2025 at 12:49=
=E2=80=AFAM Rodrigo Dias Correa &lt;<a href=3D"mailto:r@drigo.nl">r@drigo.n=
l</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>On POSIX systems, the QEMU Guest Agent uses /sbin/shutdown to implement<br=
>
the command guest-shutdown. Systems based on BusyBox, such as Alpine<br>
Linux, don&#39;t have /sbin/shutdown. They have instead three separate<br>
commands: poweroff, reboot, and halt.<br>
<br>
Change the QEMU Guest Agent to, depending on the mode argument, use<br>
/sbin/{poweroff,halt,reboot} when they exist, falling back to<br>
/sbin/shutdown when they don&#39;t.<br>
<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2589" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/2589</a><br>
<br>
Signed-off-by: Rodrigo Dias Correa &lt;<a href=3D"mailto:r@drigo.nl" target=
=3D"_blank">r@drigo.nl</a>&gt;<br>
---<br>
=C2=A0qga/commands-posix.c | 29 +++++++++++++++++++++++++++++<br>
=C2=A01 file changed, 29 insertions(+)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 5070f27..c705985 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -213,9 +213,20 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0return retcode;<br>
=C2=A0}<br>
<br>
+static bool file_exists(const char *path)<br>
+{<br>
+=C2=A0 =C2=A0 struct stat st;<br>
+=C2=A0 =C2=A0 return stat(path, &amp;st) =3D=3D 0 &amp;&amp; (S_ISREG(st.s=
t_mode) || S_ISLNK(st.st_mode));<br>
+}<br>
+<br>
+#define POWEROFF_CMD_PATH &quot;/sbin/poweroff&quot;<br>
+#define HALT_CMD_PATH &quot;/sbin/halt&quot;<br>
+#define REBOOT_CMD_PATH &quot;/sbin/reboot&quot;<br>
+<br>
=C2=A0void qmp_guest_shutdown(const char *mode, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const char *shutdown_flag;<br>
+=C2=A0 =C2=A0 const char *shutdown_cmd =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0Error *local_err =3D NULL;<br>
<br>
=C2=A0#ifdef CONFIG_SOLARIS<br>
@@ -234,10 +245,19 @@ void qmp_guest_shutdown(const char *mode, Error **err=
p)<br>
<br>
=C2=A0 =C2=A0 =C2=A0slog(&quot;guest-shutdown called, mode: %s&quot;, mode)=
;<br>
=C2=A0 =C2=A0 =C2=A0if (!mode || strcmp(mode, &quot;powerdown&quot;) =3D=3D=
 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (file_exists(POWEROFF_CMD_PATH)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shutdown_cmd =3D POWEROFF_CMD_PA=
TH;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shutdown_flag =3D powerdown_flag;<br>
=C2=A0 =C2=A0 =C2=A0} else if (strcmp(mode, &quot;halt&quot;) =3D=3D 0) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (file_exists(HALT_CMD_PATH)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shutdown_cmd =3D HALT_CMD_PATH;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shutdown_flag =3D halt_flag;<br>
=C2=A0 =C2=A0 =C2=A0} else if (strcmp(mode, &quot;reboot&quot;) =3D=3D 0) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (file_exists(REBOOT_CMD_PATH)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shutdown_cmd =3D REBOOT_CMD_PATH=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shutdown_flag =3D reboot_flag;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp,<br>
@@ -255,6 +275,15 @@ void qmp_guest_shutdown(const char *mode, Error **errp=
)<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;hypervisor initiated shutdown&quot;, (char *)=
 NULL};<br>
<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* If the specific command exists (poweroff, halt or re=
boot), use it instead<br>
+=C2=A0 =C2=A0 =C2=A0* of /sbin/shutdown.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (shutdown_cmd !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 argv[0] =3D shutdown_cmd;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 argv[1] =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0ga_run_command(argv, NULL, &quot;shutdown&quot;, &amp;l=
ocal_err);<br>
=C2=A0 =C2=A0 =C2=A0if (local_err) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_propagate(errp, local_err);<br>
-- <br>
2.47.3<br>
<br>
</blockquote></div>

--000000000000f5b33106425f8c73--


