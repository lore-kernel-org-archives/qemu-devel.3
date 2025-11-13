Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195A2CD5BC5
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 11:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJVYy-0005pV-1j; Thu, 13 Nov 2025 06:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vJVXq-0004tl-7t
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 06:31:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vJVXl-0007Rd-Ju
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 06:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763033472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N26xd4D7B4SGMStBq+tE9sHA+UWcdoEDB9VnMnesY0U=;
 b=gwx8xSNMKEVUWPvg9qaX/ePjWntOdu6wF8z0DnEA11X9wMxKSm1rIVsCJFhC3ljuUUGeSE
 R9ZWB/Du9Hwr3CfdKs/MqZI16sLnG4RtbB9a/7RI9tg6nDBPDXBbj6sX5u7Qd6MHUy4bvp
 7Y/wtE7VxHeo8oM4+YhQt0HPIm0IgCE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-78w4i_OsM0WSjkBB2rSR_Q-1; Thu, 13 Nov 2025 06:31:10 -0500
X-MC-Unique: 78w4i_OsM0WSjkBB2rSR_Q-1
X-Mimecast-MFC-AGG-ID: 78w4i_OsM0WSjkBB2rSR_Q_1763033470
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b55443b4110so629163a12.1
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 03:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763033468; x=1763638268; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N26xd4D7B4SGMStBq+tE9sHA+UWcdoEDB9VnMnesY0U=;
 b=b0fcieVP8Pkt4kGyz7CLvthiPraSzbCVMZzRLwTqnzmD0L4YDyci8ATla0ey+tIyaM
 /jKz/44hYRbLHtUD9Fh7mgalAziZkz2jLWmOokFPxzBqAY+reva0bWIuH2Jdrb1lkOmC
 hIsYFjWGczMfxjP25GwmdE3E09WE9DZZS2QgeBKHE/sFURKbPhVqBpWIBdYFeUdewjOU
 hzTrtf5pk6DElcp/pH0v6ufVwdLkMbhwcAyCHYHI2UnE3bFSxlStVIHsLBRcyVF2KN+J
 LtLxfFPupdHSV+OZRp9YNfM16GHzzXKH+eGupTD3TjZLmvyJWy7lpwvAUyZ/HnuHIPEr
 ybqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763033468; x=1763638268;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N26xd4D7B4SGMStBq+tE9sHA+UWcdoEDB9VnMnesY0U=;
 b=qiVxBaZRaJCv5NTPrZGX7bxBPhssgFJNlZ0KtIdRLww/WIU6wf3kn7zg9bACL0pu7k
 9iryVagL4rCryyXBu3ohlBnfQXjKr9LNg38QMRzB4nUmUwU/juDXFDPzcur2eV2UaAU1
 QNYmAvHBHAbYvvji4reyPcZ6lo8ADYAvtMMB6vApyuzdfXp9MkjIq/fG8WRVLgJ0FW2Y
 R4S8t9xREsRyOuTq4uAkI3naHANjo+mltRMKPyU9A/mvJ/Mob9M8iltu8UCrWvCVtX6g
 w88fr+RoRXt08n8OLAtD7lRs/Oq9Qww0X42zjQ4AEYyzSWDvwY5AQ6t2iwgfwi8V46Va
 Mb2w==
X-Gm-Message-State: AOJu0YyuJfxR23EKE7wCyWCUvOlTY0nnt1mNOHZddMW3jXShJDrQSxRC
 z0oo+M/sWa4tU6v20aWvj823EFvsZJ0+J9LavLazVF3Cnw7VEqDjSsafLvFJtGZWksw96mZOLOD
 bzx6aU/y0k1usiNzh2JAvSGcylUjzwCplQjnXlOxDJSMQr7IQqsMtpTrNb6lBp9gi6ht5kryu4U
 guM8Xv9HWGXR+NzOELtVsjrb2iXIbiDo85rpzqRqGdoiDE
X-Gm-Gg: ASbGncu6yCbj6u0weQ1Ejg245t8zsxaqgo9yj3kj7dGLwl8lAxdrbFhdFpPskbErNqL
 wPGexwViz+kHkj3t+HZrhiqgE2IFjF0JSMAm9WHd55hPwstHlXRyHGAJ1ds5jiW8uNtyNq+YilO
 VwnL+hl+NivbTOsNex/+I6E+7RrtlrHHwsdbLtLVLU87xjjK7cih8WRrQ08kjk7WXATw7q6kfuC
 osx71LswaR9qks=
X-Received: by 2002:a17:90b:1e07:b0:340:dd63:3fd5 with SMTP id
 98e67ed59e1d1-343eacd0972mr3797308a91.17.1763033468675; 
 Thu, 13 Nov 2025 03:31:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElghR14kkwaeDnL2FAvSp0pyvtvtq2PJ3KZy3NT/yfcXHN5LlJOTWpGYiYBaroYaX5C+vzZIfYwVccsF9cnTY=
X-Received: by 2002:a17:90b:1e07:b0:340:dd63:3fd5 with SMTP id
 98e67ed59e1d1-343eacd0972mr3797272a91.17.1763033468260; Thu, 13 Nov 2025
 03:31:08 -0800 (PST)
MIME-Version: 1.0
References: <20251112134143.27194-1-philmd@linaro.org>
 <20251112134143.27194-7-philmd@linaro.org>
In-Reply-To: <20251112134143.27194-7-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Nov 2025 15:30:56 +0400
X-Gm-Features: AWmQ_bnwx1ym5XCfdZYUt53YLZCzGineBb2x-mC4p3yjQ6cfVnsTVU5vEdBrpMA
Message-ID: <CAMxuvazq=AaMV7J8GoPOh7DHBqHfzaOUq3Vu_ByEgMzukXGgfA@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] chardev/char: Allow partial writes in
 qemu_chr_write()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000009a65fb064378375d"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000009a65fb064378375d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Nov 12, 2025 at 5:42=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> If qemu_chr_write_buffer() returned an error, but could
> write some characters, return the number of character
> written. Otherwise frontends able to recover and resume
> writes re-write the partial chars already written.
>
> Cc: qemu-stable@nongnu.org
> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  chardev/char.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 105b0d53184..7931f4e0832 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -186,6 +186,11 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf,
> int len, bool write_all)
>
>      res =3D qemu_chr_write_buffer(s, buf, len, &offset, write_all);
>
> +    if (!write_all && res < 0 && offset =3D=3D 0) {
> +        /* Allow partial writes */
> +        return res;
> +    }
> +
>

I don't understand this, as below it has:
    if (res < 0) {
        return res;
    }

Is it just the final return value that should be changed? "offset &&
!write_all ? offset : res" ?

     if (qemu_chr_replay(s) && replay_mode =3D=3D REPLAY_MODE_RECORD) {
>          replay_char_write_event_save(res, offset);
>      }
> --
> 2.51.0
>
>

--0000000000009a65fb064378375d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 12, 2=
025 at 5:42=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:ph=
ilmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">If qemu_chr_write_buffer() returned an er=
ror, but could<br>
write some characters, return the number of character<br>
written. Otherwise frontends able to recover and resume<br>
writes re-write the partial chars already written.<br>
<br>
Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-stable=
@nongnu.org</a><br>
Suggested-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org=
" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0chardev/char.c | 5 +++++<br>
=C2=A01 file changed, 5 insertions(+)<br>
<br>
diff --git a/chardev/char.c b/chardev/char.c<br>
index 105b0d53184..7931f4e0832 100644<br>
--- a/chardev/char.c<br>
+++ b/chardev/char.c<br>
@@ -186,6 +186,11 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int=
 len, bool write_all)<br>
<br>
=C2=A0 =C2=A0 =C2=A0res =3D qemu_chr_write_buffer(s, buf, len, &amp;offset,=
 write_all);<br>
<br>
+=C2=A0 =C2=A0 if (!write_all &amp;&amp; res &lt; 0 &amp;&amp; offset =3D=
=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Allow partial writes */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return res;<br>
+=C2=A0 =C2=A0 }<br>
+<br></blockquote><div><br></div><div>I don&#39;t understand this, as below=
 it has:</div><div>=C2=A0 =C2=A0 if (res &lt; 0) {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return res;<br>=C2=A0 =C2=A0 }<br>=C2=A0</div><div>Is it just the fi=
nal return value that should be changed? &quot;offset &amp;&amp; !write_all=
 ? offset : res&quot; ?=C2=A0</div><div><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0if (qemu_chr_replay(s) &amp;&amp; replay_mode =3D=3D RE=
PLAY_MODE_RECORD) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0replay_char_write_event_save(res, offset)=
;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div></div>

--0000000000009a65fb064378375d--


