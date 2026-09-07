Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5835BC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3XIW-0002G4-VL; Mon, 07 Sep 2026 07:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x3XIU-0002FX-J8
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x3XIR-0005Ok-AG
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 07:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788779634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=129aGMOppIvs7DM0D+x5WTDYJFayJvwlM9+iPsAyyMs=;
 b=W1es+dGYiX7NdmWQAk3sZ39yhqbAT1qgOcH9+xqvyFpXnj7Kd2jUftbhjS/6nZDc/m1BUp
 eeIZX1WGNL4+YxO7kIqW47XO1fcoYVyegHi9xEv0LtdUMEm0xiFj8bHiAvZJwt4B4jm0bX
 Aolsa/4OMshVq/AXlpK4sq+z+CrgVIE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-jIhECJZ8O4KveV4ttO64pQ-1; Mon, 07 Sep 2026 07:13:52 -0400
X-MC-Unique: jIhECJZ8O4KveV4ttO64pQ-1
X-Mimecast-MFC-AGG-ID: jIhECJZ8O4KveV4ttO64pQ_1788779632
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9105be46009so14630436d6.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 04:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788779632; cv=none;
 d=google.com; s=arc-20260327;
 b=KovgFmnwMOvzXC+euF1xJIWP38Ab8vDSaMdvff5buQ/hDurIBVcCxKHmZuuxFDeuG/
 Rp9L+OAicF0jI7rDMGxiqA5o2yJN4+JIru7Jfo0DDwXPPATqMZjhNaiEQlg7iXg2PIQH
 33XL0e5+m7W2QrqtvUC9vujgDELwgnr2Tyl//rwoontfAYgZB7dDdaOpUxfcp7sLXUvc
 nSFv27SCHBWZ3lajKKN9PBDg53jS9rwzdPyoeTWKCWg7iFArCHBHT5BWx3bXYNiFmJrQ
 zuPMj4kFOAqNzF/WBzLJ2o+P8Q03KkQVmS3qoT31tgaFDyNQLw4Wq1fTnJLn6DLETJ4A
 8SDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=129aGMOppIvs7DM0D+x5WTDYJFayJvwlM9+iPsAyyMs=;
 fh=2UZlmMdSzD3+f507HMdukLRvlcEDzodjJVY4NLN3tLg=;
 b=gGNqGVsZUecuUnrRwFOpPCukcp7qrY62mZVXa2pA727PEvsWnnHzDHUba4FgQQQnQw
 GySTPNxGh5PWTH9oXHJyBhjMwzf/mVvRPf954fPHOvdZXy3kTcW9zVjZu/9i18IjGhoT
 hYrSheTYqi70rlUbLEX9PnEsshzbLdzAb7RvIdMQIWDwdwYD0KT4fCZ3goiMG5Hir+4C
 F7nBW6h9EWLKg/KHAcJEw+8nrR6oj/zoyShHMJniu2vCElFKRQzU+hsXK4hKhtMosgCZ
 iTVmQ33Q+VsDxok+Tb/xbm6A18bleaqoQwLRpMJOlYgPnIxLi1VIjfz3tHgyY40oP6oe
 BzBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788779632; x=1789384432; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=129aGMOppIvs7DM0D+x5WTDYJFayJvwlM9+iPsAyyMs=;
 b=CeFOL4Ip7Z62rlb+mBBwVm5llATQYPP+ooIXCxWR3WuJ99Mg6/f47Wmm4/tUumcMP1
 a3SBBlHrCFamHqi7HOxRSRqiXApanodKVOdvjRmTS8F57MHDZ0BqeVtTEAtbHJArW9ws
 n2fr7UmyesPzm+NtO/Nmp2zdsDMJinQ5Zsu5Wm50sLbAAQDGCrq2qCbAZsI91YDEYP8H
 Aqx9gdfVnf+i09S4Heni88Gskv+jdaovV06Njlo+PVCH1QYeMkhZe+QGtDScIqynbbSL
 knxxxPNb30OKXVnsGBd5xYESOn1EzJdFasyAL8pRrV+uhFuDk2VQwaTwLmapQ1pomLYz
 dMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788779632; x=1789384432;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=129aGMOppIvs7DM0D+x5WTDYJFayJvwlM9+iPsAyyMs=;
 b=CwGN/QJ/L3EHqIxkAZaHVxcttV5uDu4ciEAHMjixzs5YDqU5VgST6xysjHEYy61Nsg
 x+5m2/duNu09Jb1zvFVsIBUyKvedKW0ABSqzYji5aPpBhv41+NdcdFxRVpN1vvKkERUA
 oM639Nht1A50/th20J5MvEAZWK9VtmrVn9Mr8MF14BxnVwlX9RexOPXxggfo2CTATJjX
 YJe7GNqqXhdn73+oVhUBw6TH0uzTRNGTCa8TlNpm5zehA86Q7tOeqKkA50Mjge2tkmS0
 kmHNdOjE3hTs/4u2h7rir3LvFiZXVjWSdEsqj1Gw/X2W5AbF+mkZ4/8j5hPE5fU2nxfG
 +bmA==
X-Gm-Message-State: AFuF++k6pq4diMIygZzf1l1rIvKPyW/SFaNOQaKUy2lifUWbhZkKooGH
 7Q7kKF7c8dhTNkYZvjnIIkTBth8rC0fgA9iZgUiL8aj9mEL41uhfdq2F20SmCyphn/qq/8WUQMS
 p9F2bxNeZkidBUw2aotDq3sgscspneYmzR103pp3fHupSEK06S0gKefz3RJ/y1OEQloTPUVniLy
 fqT9cq2t3PwbkbGy8EjLZduATIyTjIr2E=
X-Gm-Gg: AYBFou2kwEUIUMTIObeO8Cw3sr4uBvT0LdXBAHjmWVheEZh5KG++UN/eOOF28sm7U/W
 hxGt17sQJeGod7uw76b0W1Kp6C2klOkbTEpF/SSfd3odjVVRj5/khc361T1bHp9edRTMTGU5tpo
 VS82YwWABiy7G/1VBEy565/DQKQEZi81zMKTpCfs6clW2kw/MHFUiJkourA4A=
X-Received: by 2002:a05:6214:c21:b0:910:3923:cc6c with SMTP id
 6a1803df08f44-9103923d14dmr228228406d6.21.1788779632175; 
 Mon, 07 Sep 2026 04:13:52 -0700 (PDT)
X-Received: by 2002:a05:6214:c21:b0:910:3923:cc6c with SMTP id
 6a1803df08f44-9103923d14dmr228228046d6.21.1788779631753; Mon, 07 Sep 2026
 04:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
 <20260907-qga-v1-5-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-5-86456ad356e2@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 7 Sep 2026 14:13:41 +0300
X-Gm-Features: AcwNN1XQCfj4-lJgzKJKXZr4U-E7T6lx8c01pd2VPBe8GvCuS6iQws3UAZzoobA
Message-ID: <CAPMcbCrUXbkxZm0-nONRLFP=CJy=75B5AGfyC1SsEH1XiRWX6A@mail.gmail.com>
Subject: Re: [PATCH 05/17] qga/vss-win32: free bstrWriterName in outer writer
 loop
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000008852be065ae2b6d5"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

--0000000000008852be065ae2b6d5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>


On Mon, Sep 7, 2026 at 1:52=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> bstrWriterName is obtained from GetIdentity in the outer writer loop,
> but freed inside the inner component loop. When a writer has multiple
> components, the second and subsequent iterations operate with a NULL
> bstrWriterName. If an error occurs in those iterations, the error
> message passes NULL
>
> Move SysFreeString(bstrWriterName) to the end of the outer loop where
> it belongs.
>
> Fixes: b39297aedfab ("qemu-ga: Add Windows VSS provider and requester as
> DLL")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/vss-win32/requester.cpp | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index 52176d751274..b9269acb5b8e 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -230,11 +230,11 @@ static void AddComponents(ErrorSet *errset)
>                      goto out;
>                  }
>              }
> -            SysFreeString(bstrWriterName);
> -            bstrWriterName =3D NULL;
>              pComponent->FreeComponentInfo(info);
>              info =3D NULL;
>          }
> +        SysFreeString(bstrWriterName);
> +        bstrWriterName =3D NULL;
>      }
>  out:
>      if (bstrWriterName) {
>
> --
> 2.55.0.543.g5ebe2ebe4ea8
>
>
>

--0000000000008852be065ae2b6d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br clear=3D"all"></div><div><div dir=3D"ltr" class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Re=
viewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com">kk=
ostiuk@redhat.com</a>&gt;</div></div></div><br></div><br><div class=3D"gmai=
l_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon=
, Sep 7, 2026 at 1:52=E2=80=AFPM Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mail=
to:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">bstrWriterName i=
s obtained from GetIdentity in the outer writer loop,<br>
but freed inside the inner component loop. When a writer has multiple<br>
components, the second and subsequent iterations operate with a NULL<br>
bstrWriterName. If an error occurs in those iterations, the error<br>
message passes NULL<br>
<br>
Move SysFreeString(bstrWriterName) to the end of the outer loop where<br>
it belongs.<br>
<br>
Fixes: b39297aedfab (&quot;qemu-ga: Add Windows VSS provider and requester =
as DLL&quot;)<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/requester.cpp | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp<br>
index 52176d751274..b9269acb5b8e 100644<br>
--- a/qga/vss-win32/requester.cpp<br>
+++ b/qga/vss-win32/requester.cpp<br>
@@ -230,11 +230,11 @@ static void AddComponents(ErrorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SysFreeString(bstrWriterName);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bstrWriterName =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pComponent-&gt;FreeComponen=
tInfo(info);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SysFreeString(bstrWriterName);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bstrWriterName =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0out:<br>
=C2=A0 =C2=A0 =C2=A0if (bstrWriterName) {<br>
<br>
-- <br>
2.55.0.543.g5ebe2ebe4ea8<br>
<br>
<br>
</blockquote></div>

--0000000000008852be065ae2b6d5--


