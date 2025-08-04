Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F47C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 08:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiqOz-00076U-4M; Mon, 04 Aug 2025 04:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uiqOw-00072a-TN
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uiqOt-0005V4-5y
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754295507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G+h23Wtxa7m5hxWlm+AMYVRbu8MjC3W1YURLhVJGKZE=;
 b=BkCILw+xPA6uz+v8msHbk8XyHlnDuWVJUFZZNl9BQuTObVDwdH+z3J/x8n273bh1AHLxSC
 ifJ/f2ZMt2RYRp2o+lkWzaxaabtGIWYImhsLesaWSIDMRKTb10kmTEUM11QyMN3bjnNo7v
 MURLc2LSTr5VSx5fhA2ZM7RlCz/dWOg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-1ChsVkAuM3-mxWcQUvRZWA-1; Mon, 04 Aug 2025 04:18:25 -0400
X-MC-Unique: 1ChsVkAuM3-mxWcQUvRZWA-1
X-Mimecast-MFC-AGG-ID: 1ChsVkAuM3-mxWcQUvRZWA_1754295505
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-70748301f71so68067276d6.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 01:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754295505; x=1754900305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G+h23Wtxa7m5hxWlm+AMYVRbu8MjC3W1YURLhVJGKZE=;
 b=jwuEQR+6TGeuoH0q5lscA6wD1qg7e7GRj86LcuEgMfD3nWotLxIQy8x3I7O1eQORUC
 /ACz4o5g5BhpnZU1ZF3WzfrVjBLe+mQ/HrUdLFjSiCTOFD7Bh3xuJpl/kVYTTUkEDONn
 uYKwfb/cegYREwaziXZI9kx0RYo7pH3/i/R7RLMkePds7sraEDpnomFaXTaLiIxkTh6h
 VgriVk/4/WN1ltqqglG/iG9YNat3lTKxQ3FxN52sssFzkOB/CQvrYyzPabsAtm/nmGZD
 0Ok5zZ2zzCo4/tjdXWBfmB/HjNPcEN10i/1U6C69tlPIn+3w5LBpHFIBC1sL0IKZZPK0
 vZmA==
X-Gm-Message-State: AOJu0YwsgUrtiFyxJ2jRt7/+9FMt8qOt0DmaeD0gKsP5pU3N5dTHfZ3G
 aPQiZumATdls4NH0BH0FKDuyA12lQdW375Yg1m3fXJBYXQg7wTkWfFawue8tYz9bYp6R3gzGXhN
 MWWecun7ZXbus+okFFwD3gkwTJcc2VsBJlXUNILtsIVLkTjuUyPGB0xYkiOJrYtuo7qiULrf/NQ
 6u6FOp7dLt7BTWCCbJ16iaeOWFE5rav80=
X-Gm-Gg: ASbGnctzP9QrlNUDLJaETcUYlDxQWCID+BrFzReilsezNa/vUyvrjUuvz6HGJaanoL5
 ikJl7DJWs5XHFk2KFvszINdvCt6dIg7BeuBJAYhlqcNhsWg7F5ory/jRFzbA2M5lAJoZjH61WWX
 6YOdswjTCHdAgfRMPmEG5GCI8=
X-Received: by 2002:a05:6214:4015:b0:707:6306:28bf with SMTP id
 6a1803df08f44-709362daaf2mr120089746d6.36.1754295505103; 
 Mon, 04 Aug 2025 01:18:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPSwEgRRFKP8ixh5hkb/xrLhHqhHnT095GsCbsXv6IUPZIKz8iiDmdjZQQOspQorLU6QbSRMmvjUnqj3vsfoo=
X-Received: by 2002:a05:6214:4015:b0:707:6306:28bf with SMTP id
 6a1803df08f44-709362daaf2mr120089446d6.36.1754295504355; Mon, 04 Aug 2025
 01:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250804074641.6021-1-zhengnici@gmail.com>
In-Reply-To: <20250804074641.6021-1-zhengnici@gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 4 Aug 2025 11:18:13 +0300
X-Gm-Features: Ac12FXzyCYBxPGYMQF3MIHLK7o9yoTE8sU58tD4fa_-cst1eBGEP-WXm8QLkrp0
Message-ID: <CAPMcbCq9d+fRVkZpWRQxOdyHOOTAgBT6dNE1VJdUhfAZTqr6hQ@mail.gmail.com>
Subject: Re: [PATCH] qga: Fix error handling in system suspend mode causing
 libvirt to hold lock indefinitely
To: zhengnici@gmail.com
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, 
 panzerzheng <panzerzheng@tencent.com>,
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005e5f95063b85c0c1"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000005e5f95063b85c0c1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 10:47=E2=80=AFAM <zhengnici@gmail.com> wrote:

> From: panzerzheng <panzerzheng@tencent.com>
>
> When "/sys/power/state" does not contain "disk", the operating system
> does not support hibernation. Executing "sudo systemctl hibernate" will
> return an exit code of 1 with the stderr output: "Call to Hibernate faile=
d:
> Sleep verb 'hibernate' is not configured or configuration is not supporte=
d
> by kernel".
>

> This patch adds handling for exit code 1 in the systemd_suspend function,
> setting appropriate error messages when the kernel does not support
> standby.
> It also adds local_err handling in the guest_suspend function to set
> mode_supported to false.
>
> Without these fixes, libvirt would hold the lock indefinitely.
>
> Signed-off-by: panzerzheng <panzerzheng@tencent.com>
> ---
>  qga/commands-linux.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
> index 9e8a934b9a..26229396c3 100644
> --- a/qga/commands-linux.c
> +++ b/qga/commands-linux.c
> @@ -1300,6 +1300,12 @@ static void systemd_suspend(SuspendMode mode, Erro=
r
> **errp)
>          return;
>      }
>
> +    if ((status =3D=3D 1) && !local_err) {
>

Is there any documentation that explains that exit code =3D 1 is an error?
If you look into systemd_supports_mode, you can see that exit code =3D 1 is
detected
as a supported mode.


> +        error_setg(errp, "'systemctl %s' not suspend",
> +                   systemctl_args[mode]);
> +        return;
> +    }
> +
>      if (local_err) {
>          error_propagate(errp, local_err);
>      } else {
> @@ -1428,6 +1434,8 @@ static void guest_suspend(SuspendMode mode, Error
> **errp)
>
>          if (!local_err) {
>              return;
> +        } else {
> +            mode_supported =3D false;
>          }
>

This is very confusing. We check that the mode is supported, but after
running suspend,
we find that it is unsupported. I think we should fix systemd_supports_mode
instead.

Also, setting mode_supported =3D false does not change anything.
In the next step, we will check pmutils_supports_mode and
linux_sys_state_supports_mode,
and I think this check will pass, so we set mode_supported =3D true again.

Best Regards,
Kostiantyn Kostiuk.


>      }
>
> --
> 2.43.7
>
>

--0000000000005e5f95063b85c0c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 4, =
2025 at 10:47=E2=80=AFAM &lt;<a href=3D"mailto:zhengnici@gmail.com">zhengni=
ci@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">From: panzerzheng &lt;<a href=3D"mailto:panzerzheng@tencent.com=
" target=3D"_blank">panzerzheng@tencent.com</a>&gt;<br>
<br>
When &quot;/sys/power/state&quot; does not contain &quot;disk&quot;, the op=
erating system<br>
does not support hibernation. Executing &quot;sudo systemctl hibernate&quot=
; will<br>
return an exit code of 1 with the stderr output: &quot;Call to Hibernate fa=
iled:<br>
Sleep verb &#39;hibernate&#39; is not configured or configuration is not su=
pported by kernel&quot;.<br></blockquote><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
This patch adds handling for exit code 1 in the systemd_suspend function,<b=
r>
setting appropriate error messages when the kernel does not support standby=
.<br>
It also adds local_err handling in the guest_suspend function to set<br>
mode_supported to false.<br>
<br>
Without these fixes, libvirt would hold the lock indefinitely.<br>
<br>
Signed-off-by: panzerzheng &lt;<a href=3D"mailto:panzerzheng@tencent.com" t=
arget=3D"_blank">panzerzheng@tencent.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-linux.c | 8 ++++++++<br>
=C2=A01 file changed, 8 insertions(+)<br>
<br>
diff --git a/qga/commands-linux.c b/qga/commands-linux.c<br>
index 9e8a934b9a..26229396c3 100644<br>
--- a/qga/commands-linux.c<br>
+++ b/qga/commands-linux.c<br>
@@ -1300,6 +1300,12 @@ static void systemd_suspend(SuspendMode mode, Error =
**errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 if ((status =3D=3D 1) &amp;&amp; !local_err) {<br></blockquo=
te><div><br></div><div><div>Is there any documentation that explains that e=
xit code =3D 1 is an error?</div><div>If you look into systemd_supports_mod=
e, you can see that exit code =3D 1 is detected <br></div><div>as a support=
ed mode. </div></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;&#39;systemctl %s&#39; =
not suspend&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0syste=
mctl_args[mode]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (local_err) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_propagate(errp, local_err);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
@@ -1428,6 +1434,8 @@ static void guest_suspend(SuspendMode mode, Error **e=
rrp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!local_err) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode_supported =3D false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br></blockquote><div><br></div><div>Thi=
s is very confusing. We check that the mode is supported, but after running=
 suspend,<br> we find that it is unsupported. I think we should fix systemd=
_supports_mode instead. <br></div><div><br></div><div>Also, setting mode_su=
pported =3D false does not change anything. <br></div><div>In the next step=
, we will check pmutils_supports_mode and linux_sys_state_supports_mode,<br=
></div><div>and I think this check will pass, so we set mode_supported =3D =
true again. <br></div><div><br>Best Regards,<br>Kostiantyn Kostiuk.<br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.43.7<br>
<br>
</blockquote></div></div>

--0000000000005e5f95063b85c0c1--


