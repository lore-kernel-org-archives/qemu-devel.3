Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB34CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 06:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBRmN-0005wP-C8; Tue, 29 Sep 2026 02:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xBRmL-0005wF-MN
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 02:57:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xBRmK-0001a6-0n
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 02:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790665046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/7NJVfGY2eW0AJQWvT/7nf0EnspZT0YwEl7RSBzWsmY=;
 b=CXd822dpDBI+qN2VCBnhJF/fvFHOICcrxt238wVgHxaOQhOwAhRRb6MnTMj2W0O7eUVYgl
 IL6V53hiaaT8NeY9Tq5qJ1OX97zB1syiE9c26HN+LNdU2BZE3rZ0GZx0u6XfPCq9vKa1pp
 fL8JiyspaQ23sjubxi54bHlyxPtzTyQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-LQrCeBzVPnKgOIbUHoHvtA-1; Tue, 29 Sep 2026 02:57:23 -0400
X-MC-Unique: LQrCeBzVPnKgOIbUHoHvtA-1
X-Mimecast-MFC-AGG-ID: LQrCeBzVPnKgOIbUHoHvtA_1790665043
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-916cc44720aso28161136d6.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 23:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790665043; cv=none;
 d=google.com; s=arc-20260327;
 b=VFKs2aN9/MTeA/Oke6knnKo6TNSFp0yVFwa52FcqP08RFHMw8xWrlfVB5ljkg2I5ix
 8fz2rsywBwWWBa+//I/WA79Ai4uYrDcHFDKC18Z6rmbj0JjTEvjin/OBhX4uDxj8ymgr
 cD31Qi5P1t0kMmtj2Y9kZ+pRtcN+A0sSZXC7LQwAJ3v0kn5W3JvSWpMzYtc/mERBQ4Ey
 JEf6mSrdh1S7YDlDIcLAZd8G3TfD4M7DEzvN3WDWLBrBUNTVjcHQgDERK/5EW0iqmmu/
 Dg3itpkck+HfV6+EIZiHEaRbpl0LjObS8jUDl+RvrlW02+TXNSyhaRVk1u1z3PY3hGG3
 vSdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/7NJVfGY2eW0AJQWvT/7nf0EnspZT0YwEl7RSBzWsmY=;
 fh=o66yYXp969Oh3EEeZc2S8sCOAmDpH8iHCTG7TQEgRck=;
 b=DkL66ShKbBIi3X1vF9BKk10hosDvlIgWr6EDmY29N8Xr2MdWJyh/OMjgxY2fElxnIn
 D4d5GcLaDRhmWF+yAG4RvygpHGs5mByQeikSG+564XwIs32tlXMVyC+PiLLaU4iqMOjS
 uRrSYNjkBSYCIq81Upa4CNEcoLXBJ6YS2OzOJz0XcC7+6auVpylbPJodNIDD/O/24ENT
 65O8uHSoqIObADt1QZe+HL+BO6RTfzAW/F0btDhxrpzgNUue8pJjZwfrU7Xo1oKxmL6G
 oLd8iXLptB1I1U+1cMzZ8hE6HxSwBSosFC8Jjjz5hefDKk1cdodvnNdbrVhYwIRQupEC
 tODQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790665043; x=1791269843; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/7NJVfGY2eW0AJQWvT/7nf0EnspZT0YwEl7RSBzWsmY=;
 b=RlPOnrjkLgMRL61ic5rLpthdBP7hs/rqUyOAL27aiBjwJgcjQUheQpxhlfudY/TUg1
 7Si8sElLl6/J17F/d5ZntnK0TOqXAeOZ3BnN/1zgbQXz9c0BpRmS+iFGmBTRQHnCBMUF
 a7wvOqe5zWDYuz5pyTDxQRJUZ4nzTR4lalFMnyp2iitHVzgnAOvNI9oJ1KojqGDUEhiU
 7MwywKVT3Gg+zKShWQWtteZXUr+5rWQISEdTH7b42xTUKbcHlieManBpkmN+kY0IP15Z
 vRCXtKOwFYE+izbE2PgJoT61y49Hee4ghDv+G1cXyc//DDLfzS0eEp0vkuDXidpC1WqG
 9bOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790665043; x=1791269843;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/7NJVfGY2eW0AJQWvT/7nf0EnspZT0YwEl7RSBzWsmY=;
 b=XY26NrBK8hcy8P/kwSf+kE+vKHw/00jpH5lyhim46ltDLaZ4E7fOOpHo5JGJTyjU0g
 9zfiS0pEQIqQrRbJnuGPIY97ouHHKJmbTU4Tk2XwyTRC5CNlVWU85BA5urcAlpuRn6uV
 nPW0q8CWp+niInf1MmMS/MMPbYP0OizMrero7iSwrQFAb+PlWYYhsNMVNxRmPyoz/2On
 uuDGg51bMhCRFq+I6193e7wiuTbPW7LMTSZdk3bE4tAsARrwUC2gYRay/tUpifEEj6a+
 9u4nm6Ppe4j2TqMh4jXY5yD5uInnggV5c2k5Se+1iI0L6cepedOUv5fAmDFKP8hS0PoH
 lmFQ==
X-Gm-Message-State: AFuF++k5vhHWzNpZJXpEuWN+Kqju+SJWEkFZlZhOhbaFke5lbtC0zNne
 8Vin5TuhU+AzZO6XEdDIvqEA5IIII73jmwqPOAd3P3eloFvhqVUa37FzeHksRP2mhDhnJ5jw04O
 3GiU2MYWYNZeyqrjXVOEo12I6RauMp7MM3Tyv1lHpZ2tB09yyKZ1Zlm/2iHLfZ87/GlUYjAxVPB
 QoH5cYzaWoXNTSCCUMXSUvhUIntIryrH8=
X-Gm-Gg: AYBFou0HZDLovHLzJ/9Nmegg83eDUUaMq9Syv5pQFyAWNV5edA77EDZVLo981RZkMbd
 Wa86xNLcPIykSTGkhVu4OeZAELfRN4fhk44io/y4vN9gU/xJZuPM7KvvEadPm6Lf/a8dBzjI/Mz
 Acdqc3MD2lGzI0bXkxaSXF1CEr4cXPNbZPvGuR4TTbbuHryPN6c3F0v09CRUo=
X-Received: by 2002:a05:6214:e89:b0:90e:8be9:c384 with SMTP id
 6a1803df08f44-9142f74fd77mr258503726d6.27.1790665043257; 
 Mon, 28 Sep 2026 23:57:23 -0700 (PDT)
X-Received: by 2002:a05:6214:e89:b0:90e:8be9:c384 with SMTP id
 6a1803df08f44-9142f74fd77mr258503456d6.27.1790665042782; Mon, 28 Sep 2026
 23:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260916165620.56264-1-bogorodskiy@gmail.com>
In-Reply-To: <20260916165620.56264-1-bogorodskiy@gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 29 Sep 2026 09:57:11 +0300
X-Gm-Features: AclHuK-SCInUP7-CibxtwFReIgBmqttXtXJlxjQL-0nU1AfyfBXVSUQNLw9jNts
Message-ID: <CAPMcbCooZ1_PCt-gN-MxdkA9k4tCasTVN-Euo1FyMOwvNj+URQ@mail.gmail.com>
Subject: Re: [PATCH] tests/unit/test-qga: enable on FreeBSD
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000c98017065c99b149"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000c98017065c99b149
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Wed, Sep 16, 2026 at 7:57=E2=80=AFPM Roman Bogorodskiy <bogorodskiy@gmai=
l.com>
wrote:

> FreeBSD has all necessary commands implemented,
> so enable test-qga for it.
>
> Requires only minimal portability fixes for sockets
> in connect_qga().
>
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> ---
>  tests/unit/meson.build | 2 +-
>  tests/unit/test-qga.c  | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> index e47bc7225a..0ca0d8974e 100644
> --- a/tests/unit/meson.build
> +++ b/tests/unit/meson.build
> @@ -169,7 +169,7 @@ if have_system
>    tests +=3D {'test-qdev': [qom, hwcore]}
>  endif
>
> -if have_ga and host_os =3D=3D 'linux'
> +if have_ga and host_os in ['freebsd', 'linux']
>    tests +=3D {'test-qga': ['../qtest/libqmp.c', '../qtest/libqtest.c']}
>    test_deps +=3D {'test-qga': qga}
>  endif
> diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
> index 01ccf826e6..dbedfe3d5f 100644
> --- a/tests/unit/test-qga.c
> +++ b/tests/unit/test-qga.c
> @@ -18,7 +18,7 @@ typedef struct {
>  static int connect_qga(char *path)
>  {
>      int s, ret, len, i =3D 0;
> -    struct sockaddr_un remote;
> +    struct sockaddr_un remote =3D { 0 };
>
>      s =3D socket(AF_UNIX, SOCK_STREAM, 0);
>      g_assert(s !=3D -1);
> @@ -26,7 +26,11 @@ static int connect_qga(char *path)
>      remote.sun_family =3D AF_UNIX;
>      do {
>          strcpy(remote.sun_path, path);
> +#ifdef SUN_LEN
> +        len =3D SUN_LEN(&remote);
> +#else
>          len =3D strlen(remote.sun_path) + sizeof(remote.sun_family);
> +#endif
>          ret =3D connect(s, (struct sockaddr *)&remote, len);
>          if (ret =3D=3D -1) {
>              g_usleep(G_USEC_PER_SEC);
> --
> 2.55.0
>
>

--000000000000c98017065c99b149
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, S=
ep 16, 2026 at 7:57=E2=80=AFPM Roman Bogorodskiy &lt;<a href=3D"mailto:bogo=
rodskiy@gmail.com">bogorodskiy@gmail.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">FreeBSD has all necessary commands =
implemented,<br>
so enable test-qga for it.<br>
<br>
Requires only minimal portability fixes for sockets<br>
in connect_qga().<br>
<br>
Signed-off-by: Roman Bogorodskiy &lt;<a href=3D"mailto:bogorodskiy@gmail.co=
m" target=3D"_blank">bogorodskiy@gmail.com</a>&gt;<br>
---<br>
=C2=A0tests/unit/meson.build | 2 +-<br>
=C2=A0tests/unit/test-qga.c=C2=A0 | 6 +++++-<br>
=C2=A02 files changed, 6 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/tests/unit/meson.build b/tests/unit/meson.build<br>
index e47bc7225a..0ca0d8974e 100644<br>
--- a/tests/unit/meson.build<br>
+++ b/tests/unit/meson.build<br>
@@ -169,7 +169,7 @@ if have_system<br>
=C2=A0 =C2=A0tests +=3D {&#39;test-qdev&#39;: [qom, hwcore]}<br>
=C2=A0endif<br>
<br>
-if have_ga and host_os =3D=3D &#39;linux&#39;<br>
+if have_ga and host_os in [&#39;freebsd&#39;, &#39;linux&#39;]<br>
=C2=A0 =C2=A0tests +=3D {&#39;test-qga&#39;: [&#39;../qtest/libqmp.c&#39;, =
&#39;../qtest/libqtest.c&#39;]}<br>
=C2=A0 =C2=A0test_deps +=3D {&#39;test-qga&#39;: qga}<br>
=C2=A0endif<br>
diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c<br>
index 01ccf826e6..dbedfe3d5f 100644<br>
--- a/tests/unit/test-qga.c<br>
+++ b/tests/unit/test-qga.c<br>
@@ -18,7 +18,7 @@ typedef struct {<br>
=C2=A0static int connect_qga(char *path)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int s, ret, len, i =3D 0;<br>
-=C2=A0 =C2=A0 struct sockaddr_un remote;<br>
+=C2=A0 =C2=A0 struct sockaddr_un remote =3D { 0 };<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D socket(AF_UNIX, SOCK_STREAM, 0);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(s !=3D -1);<br>
@@ -26,7 +26,11 @@ static int connect_qga(char *path)<br>
=C2=A0 =C2=A0 =C2=A0remote.sun_family =3D AF_UNIX;<br>
=C2=A0 =C2=A0 =C2=A0do {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strcpy(remote.sun_path, path);<br>
+#ifdef SUN_LEN<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D SUN_LEN(&amp;remote);<br>
+#else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D strlen(remote.sun_path) + sizeof(=
remote.sun_family);<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D connect(s, (struct sockaddr *)&am=
p;remote, len);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_usleep(G_USEC_PER_SEC);<b=
r>
-- <br>
2.55.0<br>
<br>
</blockquote></div>

--000000000000c98017065c99b149--


