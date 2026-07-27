Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CCDC53200
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 02:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woBPO-0001Ry-2F; Sun, 26 Jul 2026 22:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tripprobins@gmail.com>)
 id 1woBPH-0001Ri-Va
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 22:49:32 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tripprobins@gmail.com>)
 id 1woBPC-0003AX-T1
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 22:49:29 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c167bda216fso317430066b.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 19:49:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785120565; cv=none;
 d=google.com; s=arc-20260327;
 b=kPuIqRF1pYEEMWt0ogOTLe2fwsQ/o/vVjI2QAmaxdvue00TcljBI1uUqlu5ogUMnPB
 TXoUDhHs29E2+sepwPwPIKmvHTyNuxhmLbXfS/KoRfPdRPsMxqw8Zndri7KyTPqg4Oc3
 Yj2k+1Y5V58vXNZOyz1J23K1Mk+7eNz2DUw3IHfNocO0xhKPwCKxlysAMLQvUb3R7UvJ
 JVMetF/6jjgD7bev2DgamPJ4QR3qnoW3GgWDej4FnZ453L6BafLUzbVdEXMQYSU99OPT
 LgZ/bAxAp2MotMNJiBgCSu4NeJeULzCrOxtldtNGDMI/xRgqWWXNp7b37lCjofMbdzrs
 QIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=M+dh6ql1LDEW7dl1hWUXn2oVvkTaWOdQHRDWDj/flhE=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=ASzAV/XWq88+Qh3zGGwFctXcUDbddZO5C4R7UgrRL+3qP9TbGV4LUcM5kRYd3eCcas
 KNDFSGqyd5vfx9qDGLuW4hKUI4m2qe4j2JXj5oqQgSPjFRxJN8aL5IqFB/iCgIq7IcAy
 hUVvm++BDCC+YgvxN3IMhWk9P3B+yn/O8WaTDjMb7kQLq93jDDVg1MkIebhoOhkv81MV
 qqr5KSf+OQ21odrQo97PXoAJO2u9Wo/OxrVLOFZZ2h8SQAc47JWpFVrKDszXSzf+z97p
 n4vqxh1cL54SW9joAsCIOXMDnUU9+6YUX1I4ldvcGgNUQ164taE9AG/gJqLvEJtnQW7r
 9sxg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785120565; x=1785725365; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=M+dh6ql1LDEW7dl1hWUXn2oVvkTaWOdQHRDWDj/flhE=;
 b=qM3CAOXQp07wnxkYKxmiMGU3f5kERhZI1wrXOs8TPvzKFRTj7a8wb3EpGCRF9PkjQE
 l9EnmCGwRZNwqipSDgnZ0UWlM3fiFPHa7W71YaUFua5nZMyTabRfYOktzX5prIUeKtqW
 MtHin/IY1EH7OxMK/jsXW2GL0QFxLtCWDROSghYFk3Myj8OBydGvUgCfaq/+lXwEKoh8
 0e7PvK9/+LEIU/D4pmnm/oWE8hwrlzTB08a7tSTq6/gKMj21apLQeLiHdzj5FAfMPbEZ
 x3nJ6sdgQk+C4jcVfsM20GlP9MFZE+QRSWYKAfv9gqaivpJwAhq3wD9vu5b81uvlJkAO
 TCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785120565; x=1785725365;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M+dh6ql1LDEW7dl1hWUXn2oVvkTaWOdQHRDWDj/flhE=;
 b=ClBAowlg/PucvLo1Am4XQhiwHeUano27I9HXnZln1qB5y858lec/bf1jARkpylFHuf
 XWsArkJWriDYHBc30oOK3j+Lpn+a8V3vulpfux/zjL98+639Dbr44kNbY4DB8mFAD7xF
 itvyJOj3DRVN7R7zxLvWUJSkrgAAlKVPHCwMquUoirN1AH8RLNe8ovnmx1ckOETrVWHl
 s3z6OC+BosVUkP6VC+uNYmpxs2KOy3LGujhxR5GQKjvU/i1n2r8T0W76eFHRrzUhMP/1
 tu3Zo6reWYJxZssAdu+4z0DXXUknjwYOeBC8Yd2aJ/HLV8O1a6eOCj39ljLbTMB/ZDfH
 foTw==
X-Gm-Message-State: AOJu0YxkVrgWI3QuMY953a43rNNkKUQF0WbmFKkzRg7w6FtxEB3rrKRE
 L8OETA04ss1irLXRs8MpRn1gqErz1erVmzZqaFHze74xdO4JHg4NMnQgCBe7UtbLfw0IgTeizum
 bhAWy9gEuHggC1R9kJCTnNGgAJ5ZjFOxdGQJ4
X-Gm-Gg: AR+sD11NEU9n1Tvh73pTFBLdJ3rN/VulWoaXokzgjndAsX1IwSFoHAHPLGCMhP+KfLY
 6QYXDlcXJpCZ6TgVDe4ifgXGiNKnfiGQ2ABjRyAuO8/XMueDoHkUAWO1VokkjXkphEy6i6tjOaj
 uWSe4C96+sAsHO4oE6xQEJJJYX7fajTqfVpqE4IwMrIDVPaQeyGUhTJ+Dy+NlWbQZgmiQgZOSJx
 rCCqKqt0nfEgvKTlcPytJ8jExkqoRzl3h4BROmensH9IiUHi2nSqQKoMIaVyuQ=
X-Received: by 2002:a17:906:fe4b:b0:c16:6469:3f1b with SMTP id
 a640c23a62f3a-c1f1f159f79mr295705366b.41.1785120564433; Sun, 26 Jul 2026
 19:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260726-xbhmpcmd-v1-1-45d79d0f28b4@gmail.com>
In-Reply-To: <20260726-xbhmpcmd-v1-1-45d79d0f28b4@gmail.com>
From: Tripp R <tripprobins@gmail.com>
Date: Sun, 26 Jul 2026 22:49:13 -0400
X-Gm-Features: AUfX_mxJzMaDB72JqeOotQhv1XbTaXH1sFwNQ5MkK5I4Zg0kkKyOD6EFSk0vKvw
Message-ID: <CAGk4qDxR-KqAVwiop1VmAjFCETvv_U0MCfH_k38nEG7c2sHU5w@mail.gmail.com>
Subject: Re: [PATCH] clarify address type in 'xb' cmd
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000001fd7ee06578ec5f2"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=tripprobins@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000001fd7ee06578ec5f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello David,

Hope things are going well. Just resubmitted the patch, which should
(hopefully) be correct this time around.

On another note, I noticed a minor bug in the memory_dump (x) command, is
the procedure for opening an issue much different from that of a patch?

Best,
Tripp

On Sun, Jul 26, 2026 at 12:50=E2=80=AFAM Tripp R <tripprobins@gmail.com> wr=
ote:

>
>
> ---
> Implemented the xb (examine block) command to print the contents of a
> block     device to the console.
>
> It is effectively a clone of the x/xp commands (examine memory / examine
>       physical memory), having the same arguments for those commands,
> albeit preceded by the name of a block driver.
>
> e.g. usage
>          xd floppy0 /510c 0
>
> Signed-off-by: Tripp R <tripprobins@gmail.com>
> ---
>  hmp-commands.hx | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index db63b58a47..26b7cadcf2 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -481,7 +481,7 @@ ERST
>          .name       =3D "xb",
>          .args_type  =3D "device:s, fmt:/,addr:l",
>          .params     =3D "device /fmt addr",
> -        .help       =3D "block memory dump starting at 'addr'",
> +        .help       =3D "block memory dump starting at 'addr', in units =
of
> bytes.",
>          .cmd        =3D hmp_block_dump,
>      },
>
>
> ---
> base-commit: bcc42fe49f7aae8982604900e307d783615bc79c
> change-id: 20260726-xbhmpcmd-e8c82287a035
>
> Best regards,
> --
> Tripp R <tripprobins@gmail.com>
>
>

--0000000000001fd7ee06578ec5f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hello David,<br><br></div>Hope things =
are going well. Just resubmitted the patch, which should (hopefully) be cor=
rect this time around.<br><br></div>On another note, I noticed a minor bug =
in the memory_dump (x) command, is the procedure for opening an issue much =
different from that of a patch?<br><br></div>Best,<br></div>Tripp</div><br>=
<div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"=
gmail_attr">On Sun, Jul 26, 2026 at 12:50=E2=80=AFAM Tripp R &lt;<a href=3D=
"mailto:tripprobins@gmail.com">tripprobins@gmail.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
---<br>
Implemented the xb (examine block) command to print the contents of a block=
=C2=A0 =C2=A0 =C2=A0device to the console.<br>
<br>
It is effectively a clone of the x/xp commands (examine memory / examine=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 physical memory), having the same arguments for th=
ose commands, albeit preceded by the name of a block driver. <br>
<br>
e.g. usage<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xd floppy0 /510c 0<br>
<br>
Signed-off-by: Tripp R &lt;<a href=3D"mailto:tripprobins@gmail.com" target=
=3D"_blank">tripprobins@gmail.com</a>&gt;<br>
---<br>
=C2=A0hmp-commands.hx | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/hmp-commands.hx b/hmp-commands.hx<br>
index db63b58a47..26b7cadcf2 100644<br>
--- a/hmp-commands.hx<br>
+++ b/hmp-commands.hx<br>
@@ -481,7 +481,7 @@ ERST<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot=
;xb&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.args_type=C2=A0 =3D &quot;device:s, fmt:=
/,addr:l&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.params=C2=A0 =C2=A0 =C2=A0=3D &quot;devi=
ce /fmt addr&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .help=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;bloc=
k memory dump starting at &#39;addr&#39;&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .help=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D &quot;bloc=
k memory dump starting at &#39;addr&#39;, in units of bytes.&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.cmd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D hmp_b=
lock_dump,<br>
=C2=A0 =C2=A0 =C2=A0},<br>
<br>
<br>
---<br>
base-commit: bcc42fe49f7aae8982604900e307d783615bc79c<br>
change-id: 20260726-xbhmpcmd-e8c82287a035<br>
<br>
Best regards,<br>
-- <br>
Tripp R &lt;<a href=3D"mailto:tripprobins@gmail.com" target=3D"_blank">trip=
probins@gmail.com</a>&gt;<br>
<br>
</blockquote></div>

--0000000000001fd7ee06578ec5f2--

