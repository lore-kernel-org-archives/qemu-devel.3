Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042E9D1CDA8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 06:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t38ct-0007CE-7T; Tue, 22 Oct 2024 02:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t38cp-0007C4-Lu
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 02:44:16 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t38cm-0005ee-Th
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 02:44:15 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-288c7567f5dso2336717fac.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 23:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729579451; x=1730184251;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JdpQowOr+ThWpuhVLLLAt5IEkymkcCUMyPoHM7QrM7Y=;
 b=JXMoDVuI70vjW/xejUT0hLEzKPH+vqh3cYu388A8lqm8sTb9jl8mY7m5CJoQxAedSR
 Bh+1RsDfQLTF2BIsIg1yFsRj8dlaAVQfMrEyOF9i+rwbGCGvOAmrsuHmUmvGyMvyYHUm
 JGL2J46nrRVLM7yfsF3f8kSvKTX+kgsbo7PRV86NwkwGpRaKyzNzSt8lJzj6/zcYN+U2
 uu3tEMQK7ZbbFMM2qf17Amqym4QMwhitLwvfKJU9br2cTUUwbrawdOSqorSGMHlUudvZ
 UzEtCMoG1cXb4/LNb8Kl0+Z8D+TUpqiWuenW/ycXBs2DpX5a7npGiWPFVuIS0r5OM7w6
 0qVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729579451; x=1730184251;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JdpQowOr+ThWpuhVLLLAt5IEkymkcCUMyPoHM7QrM7Y=;
 b=CMDp3GHvy1/dqiIkvRWkaA1TZYuMvtyPm/wuAP6ZeYOAcr83zmOle0MgeHlGKs0Zem
 pJ/jaFFm94j4m7Ku/ZPUQ/yRvbwMfVURNytRp9okb91WcasM0R/wlYMWdMsBLpuhNvyQ
 8juqzWhYWUuXbdBDje87YN1GdE9RyZ/nPOO5D5VYp4IGQmcQ7spceq2N8dGzH7mZRR/6
 7AZeunz/2A7gZqGLyXr1evws915j38wst7FjqLxzomYr9j1AY6D5a2yYyjxwVcYZX1Vz
 XG9KzL5RImKmvAlrebH683stxLM/mS9o9vRSs0sqMpn3oFVOJHiXNg/sNR+j3bA5cu0w
 Fg4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLS+Gme8teanj7buWI9jLwSh/APyfCCpI2QwHXUxDjFWiFizT+3BXcBl6TOzyrADFQkEDnyLx7oJol@nongnu.org
X-Gm-Message-State: AOJu0YyDjg+rmy26pI5EV2Ah38AMAKy9aMke6DE9KCk6zbc5NjiwTi+h
 QECwQHM9SReXfyMCjn8ykqByKo0igJISLmzobimDkraByYrx8azFN4tFYLMSANH+DKYb7ZJY7Jr
 QKeD2nMoIANNbXQt9QboOa7OgN3EjzatdPvFhRA==
X-Google-Smtp-Source: AGHT+IFpZcNkB6AMG3XE4cxqhX0proIfUi2lsUyY0awapahxmKVxk20b+wHyVOv5+wTt2gBF+/7cnwy8WCkikRqjcUY=
X-Received: by 2002:a05:6870:6120:b0:288:5f71:4e71 with SMTP id
 586e51a60fabf-2892c56d050mr11743224fac.44.1729579450278; Mon, 21 Oct 2024
 23:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241022063402.184213-1-thuth@redhat.com>
In-Reply-To: <20241022063402.184213-1-thuth@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 22 Oct 2024 14:43:54 +0800
Message-ID: <CAK9dgmZaT3FbBpfEm+N6rd3YBF-P4e7oXgg37Uug8teAtD3A5w@mail.gmail.com>
Subject: Re: [PATCH v2] migration/dirtyrate: Silence warning about strcpy() on
 OpenBSD
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000bec46406250b1848"
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000bec46406250b1848
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 2:34=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:

> The linker on OpenBSD complains:
>
>  ld: warning: dirtyrate.c:447 (../src/migration/dirtyrate.c:447)(...):
>  warning: strcpy() is almost always misused, please use strlcpy()
>
> It's currently not a real problem in this case since both arrays
> have the same size (256 bytes). But just in case somebody changes
> the size of the source array in the future, let's better play safe
> and use g_strlcpy() here instead, with an additional check that the
> string has been copied as a whole.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Check the return value of g_strlcpy to avoid truncation of the strin=
g
>
>  migration/dirtyrate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 233acb0855..0f941024be 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -436,6 +436,7 @@ static void get_ramblock_dirty_info(RAMBlock *block,
>                                      struct DirtyRateConfig *config)
>  {
>      uint64_t sample_pages_per_gigabytes =3D
> config->sample_pages_per_gigabytes;
> +    gsize len;
>
>      /* Right shift 30 bits to calc ramblock size in GB */
>      info->sample_pages_count =3D (qemu_ram_get_used_length(block) *
> @@ -444,7 +445,8 @@ static void get_ramblock_dirty_info(RAMBlock *block,
>      info->ramblock_pages =3D qemu_ram_get_used_length(block) >>
>                             qemu_target_page_bits();
>      info->ramblock_addr =3D qemu_ram_get_host_addr(block);
> -    strcpy(info->idstr, qemu_ram_get_idstr(block));
> +    len =3D g_strlcpy(info->idstr, qemu_ram_get_idstr(block),
> sizeof(info->idstr));
> +    g_assert(len < sizeof(info->idstr));
>  }
>
>  static void free_ramblock_dirty_info(struct RamblockDirtyInfo *infos, in=
t
> count)
> --
> 2.47.0
>
>
Reviewed-by: Hyman Huang <yong.huang@smartx.com>

--=20
Best regards

--000000000000bec46406250b1848
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 22, 20=
24 at 2:34=E2=80=AFPM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">t=
huth@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:so=
lid;border-left-color:rgb(204,204,204);padding-left:1ex">The linker on Open=
BSD complains:<br>
<br>
=C2=A0ld: warning: dirtyrate.c:447 (../src/migration/dirtyrate.c:447)(...):=
<br>
=C2=A0warning: strcpy() is almost always misused, please use strlcpy()<br>
<br>
It&#39;s currently not a real problem in this case since both arrays<br>
have the same size (256 bytes). But just in case somebody changes<br>
the size of the source array in the future, let&#39;s better play safe<br>
and use g_strlcpy() here instead, with an additional check that the<br>
string has been copied as a whole.<br>
<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank">thuth@redhat.com</a>&gt;<br>
---<br>
=C2=A0v2: Check the return value of g_strlcpy to avoid truncation of the st=
ring<br>
<br>
=C2=A0migration/dirtyrate.c | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c<br>
index 233acb0855..0f941024be 100644<br>
--- a/migration/dirtyrate.c<br>
+++ b/migration/dirtyrate.c<br>
@@ -436,6 +436,7 @@ static void get_ramblock_dirty_info(RAMBlock *block,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct DirtyRate=
Config *config)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint64_t sample_pages_per_gigabytes =3D config-&gt;samp=
le_pages_per_gigabytes;<br>
+=C2=A0 =C2=A0 gsize len;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Right shift 30 bits to calc ramblock size in GB */<b=
r>
=C2=A0 =C2=A0 =C2=A0info-&gt;sample_pages_count =3D (qemu_ram_get_used_leng=
th(block) *<br>
@@ -444,7 +445,8 @@ static void get_ramblock_dirty_info(RAMBlock *block,<br=
>
=C2=A0 =C2=A0 =C2=A0info-&gt;ramblock_pages =3D qemu_ram_get_used_length(bl=
ock) &gt;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 qemu_target_page_bits();<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;ramblock_addr =3D qemu_ram_get_host_addr(block=
);<br>
-=C2=A0 =C2=A0 strcpy(info-&gt;idstr, qemu_ram_get_idstr(block));<br>
+=C2=A0 =C2=A0 len =3D g_strlcpy(info-&gt;idstr, qemu_ram_get_idstr(block),=
 sizeof(info-&gt;idstr));<br>
+=C2=A0 =C2=A0 g_assert(len &lt; sizeof(info-&gt;idstr));<br>
=C2=A0}<br>
<br>
=C2=A0static void free_ramblock_dirty_info(struct RamblockDirtyInfo *infos,=
 int count)<br>
-- <br>
2.47.0<br>
<br>
</blockquote></div><br clear=3D"all"><div>Reviewed-by: Hyman Huang &lt;<a h=
ref=3D"mailto:yong.huang@smartx.com">yong.huang@smartx.com</a>&gt;<br></div=
><div><br></div><span class=3D"gmail_signature_prefix">-- </span><br><div d=
ir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"comic s=
ans ms, sans-serif">Best regards</font></div></div></div>

--000000000000bec46406250b1848--

