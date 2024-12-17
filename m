Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA92E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 03:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNNqP-0000HO-3p; Mon, 16 Dec 2024 22:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tNNqM-0000Gp-AK
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 22:01:54 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tNNqJ-0002zZ-8W
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 22:01:54 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5f2dee7d218so2043567eaf.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 19:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1734404508; x=1735009308;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=99sTfcxkpVttkMcJNRBz5EeqlxZno4A0EzwAzLhHQjk=;
 b=pf4moVNdnZDFVBl/Bz5LvCZMMB2kjBH9QUsjljrQ+Jsgy+Th/HUYsIYyGgZcFMkV4W
 kQ8Ghu2ZnMTZjnQFNYedhqNut6qQCtbdly4EOVFpL9IUcljsk7k1KoXPZ3NZ72HSTVHr
 TVDJ+iluMQ/csuGhlBDzKnP0iFXYCL9tF6aLGyNw0be390Ukh/VYqUPPaGfG8scoZuwv
 Sfc7GicFf2Sk0Q7pibPV94ma89hGZRxF7cEHic8kPsuM3/bXeVgfu3sf8vRf/f4U0bhy
 SYndLzOLsbJ6jf2H/ZpOdykgWkHcFXWXMxJQNsC/Uaeg20iGI4pVQeolDTTdcNFQGWiY
 sIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734404508; x=1735009308;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=99sTfcxkpVttkMcJNRBz5EeqlxZno4A0EzwAzLhHQjk=;
 b=ehrr78yEKTB2Dcbf3Wzdh/1DMkltLsdaPUuldUYufpLJUC8tVYLC6JHftLXB+a8nFs
 GO2qVHflAeGLTa5p1+2MdL7Esrnw/7h126W717+IF1C+3NVYMYAIrdYPDWaqF9WPtdfw
 kblWT+dgcAZ80mi85aJfWz9PNGB75JsQ1vTo6PjoZFXFeujouYaIzEsBUeXjjmhk2AQp
 2jR0P6k/dSC+VwfhoaLzgNC1hhatbavItxdHX8PVVnrE7u/5Y4Vth6KTQvIsrhdn8iwj
 t6YFzY941H6CxD6f59z/KXEPcGGUwu3tTGFFeH+X64LfPrJPaT3FNbf2HyHUuC0AVRdp
 01Jg==
X-Gm-Message-State: AOJu0YziPInqcPhcbci+L71zLAoOenwoV9RiEv9+u65Cx2XhRxob67U5
 V0i+SyMHXg1wF1W5kyewhpT0l5/hkkS1hg/hCoO+/N4ofJGCOjFK46fSq1uVNs1EbDQYrAjVQms
 1uySfNiXEgMorWL6AUKW+BZLM2oGqzUCrt559mQ==
X-Gm-Gg: ASbGnctcNIHeVfyhVk2i8z7Y+fJ4M+SZWw3tVCTo4i/BYRw7Y6/6DeJaKnljnRdVx3+
 QErrKa1AQsTyf+S8T7p5TESCQuID3Sn2soX7ca+s=
X-Google-Smtp-Source: AGHT+IHoBi10y1CbHFUqfjUHTFuWduSYYgmOBSV/LyFAztYw6VCSWQtmvvpay7+HQzwOOSid/R3n2jgkcoROzzanugM=
X-Received: by 2002:a05:6870:3c15:b0:29e:491b:96db with SMTP id
 586e51a60fabf-2a3ac49fa7emr8821952fac.5.1734404508171; Mon, 16 Dec 2024
 19:01:48 -0800 (PST)
MIME-Version: 1.0
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-8-avihaih@nvidia.com>
In-Reply-To: <20241216094638.26406-8-avihaih@nvidia.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 17 Dec 2024 11:01:32 +0800
Message-ID: <CAK9dgmYowKNMD=5-PXGTL71K=sa22tuusZZPojkRQeMbaHyd3w@mail.gmail.com>
Subject: Re: [PATCH 7/9] system/dirtylimit: Don't use migration_is_active()
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Maor Gottlieb <maorg@nvidia.com>
Content-Type: multipart/alternative; boundary="0000000000009b588d06296e84df"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc34.google.com
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

--0000000000009b588d06296e84df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 5:47=E2=80=AFPM Avihai Horon <avihaih@nvidia.com> w=
rote:

> vcpu_dirty_rate_stat_collect() uses migration_is_active() to detect
> whether migration is running or not, in order to get the correct dirty
> rate period value.
>
> However, recently there has been an effort to simplify the migration
> status API and reduce it to a single migration_is_running() function.
>

Could you post the related links?


>
> To accommodate this, and since the same functionality can be achieved
> with migration_is_running(), use it instead of migration_is_active().
>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>  system/dirtylimit.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/system/dirtylimit.c b/system/dirtylimit.c
> index ab20da34bb..d7a855c603 100644
> --- a/system/dirtylimit.c
> +++ b/system/dirtylimit.c
> @@ -80,8 +80,7 @@ static void vcpu_dirty_rate_stat_collect(void)
>      int i =3D 0;
>      int64_t period =3D DIRTYLIMIT_CALC_TIME_MS;
>
> -    if (migrate_dirty_limit() &&
> -        migration_is_active()) {
> +    if (migrate_dirty_limit() && migration_is_running()) {
>          period =3D migrate_vcpu_dirty_limit_period();
>      }
>
> --
> 2.40.1
>
>

--=20
Best regards

--0000000000009b588d06296e84df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Mon, Dec 16, 2024 at 5:47=E2=80=AFPM Avihai Horon &lt;<a href=3D"mai=
lto:avihaih@nvidia.com">avihaih@nvidia.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-wid=
th:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-l=
eft:1ex">vcpu_dirty_rate_stat_collect() uses migration_is_active() to detec=
t<br>
whether migration is running or not, in order to get the correct dirty<br>
rate period value.<br>
<br>
However, recently there has been an effort to simplify the migration<br>
status API and reduce it to a single migration_is_running() function.<br></=
blockquote><div><br></div><div><div style=3D"font-family:&quot;comic sans m=
s&quot;,sans-serif" class=3D"gmail_default">Could you post the related link=
s?</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;borde=
r-left-color:rgb(204,204,204);padding-left:1ex">
<br>
To accommodate this, and since the same functionality can be achieved<br>
with migration_is_running(), use it instead of migration_is_active().<br>
<br>
Signed-off-by: Avihai Horon &lt;<a href=3D"mailto:avihaih@nvidia.com" targe=
t=3D"_blank">avihaih@nvidia.com</a>&gt;<br>
---<br>
=C2=A0system/dirtylimit.c | 3 +--<br>
=C2=A01 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/system/dirtylimit.c b/system/dirtylimit.c<br>
index ab20da34bb..d7a855c603 100644<br>
--- a/system/dirtylimit.c<br>
+++ b/system/dirtylimit.c<br>
@@ -80,8 +80,7 @@ static void vcpu_dirty_rate_stat_collect(void)<br>
=C2=A0 =C2=A0 =C2=A0int i =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int64_t period =3D DIRTYLIMIT_CALC_TIME_MS;<br>
<br>
-=C2=A0 =C2=A0 if (migrate_dirty_limit() &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_is_active()) {<br>
+=C2=A0 =C2=A0 if (migrate_dirty_limit() &amp;&amp; migration_is_running())=
 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0period =3D migrate_vcpu_dirty_limit_perio=
d();<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.40.1<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best re=
gards</font></div></div></div>

--0000000000009b588d06296e84df--

