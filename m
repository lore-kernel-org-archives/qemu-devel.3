Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4F6CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 06:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBRms-0005yN-79; Tue, 29 Sep 2026 02:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xBRml-0005xj-OD
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 02:57:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xBRmk-0001c5-8z
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 02:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790665073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rIsszbVyWngGxO56KsFDmyWqHoVF/ehzgI8QIUjM9Dc=;
 b=IoR127bY0Ri/LXYwdiwnBZDCdedZKtc7rnFcCN/91yaDB8VQfSzzKvY52DzCUwwoAMM6yP
 KhibTN5CYA4erMFAgeNBaV5bfYpCsh+UFoquz/Rc0J5N0v47aihbSOmA6Jr/eCJwzkkijq
 0MEmBKAXARN4SLZg8m5a7sUzdb+V4L8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-QiGQNXtLMIC-xB1Aqr6bTg-1; Tue, 29 Sep 2026 02:57:51 -0400
X-MC-Unique: QiGQNXtLMIC-xB1Aqr6bTg-1
X-Mimecast-MFC-AGG-ID: QiGQNXtLMIC-xB1Aqr6bTg_1790665071
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93c5c205127so452404685a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 23:57:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790665071; cv=none;
 d=google.com; s=arc-20260327;
 b=mYOQRpe0R+Vbdc4M6++fFKTbdY6FH1hk4lA4M0vtksTsNivFtszGDvH4GwkFBxnuh2
 cDnj5sf0kmjB8tNgXGZxZN84dOAoygH6GvasNmCK7mbyubKLw+ZMAYTUHVFCBFIo7IcU
 g/ZaNmCgGFMkwIaXvchK+UlJqltDkt20OnQlgZjCPv1NBPLfdTdsJPu7ioFLYVM+S9f1
 m+ppfgR5Dkzl9ThIJk3D7Q9p0KHM4tLOyuuu2se7C+bIX/8M60R7undCcwUJJsLX8tR8
 6Ccv2RACRJgP6HzwB9GI0TVXG4GzM4cab3cyLTH8shRmz2sak5bvwxMakyN3Eis57p48
 l9rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rIsszbVyWngGxO56KsFDmyWqHoVF/ehzgI8QIUjM9Dc=;
 fh=pJdS1zFK4XdgZ3qkKnA43LS9mhU2p4PA5n38HmEKLtw=;
 b=WuMfwC93ZqMfIU3n5crM/Iavw2b2mI1d344hyrSOYzMZnrLCx6glW6QqF701nU8bvw
 3rPY23QBTVfWcJ+cU1JQwcCh8zwPquIsX6ujYOvo7WkuHWc1uV1hjiCfvnvduGN8W3gI
 WVEC95v/XUwKJDZ3Dc3XEwS+UI9J59vWphI0CDqzSTa3MsNZuQH5aWNON4Be1AsH4+l7
 HJu4QZPsjGr9RPcAaFkAZ/nGwLG7uxdir47st9I5ZKDPiQUQ7NCYxbXKkAnTOwQGgIia
 1ppyDZc6a5fhLV0Db2HKiXwBjPDPRV7w/NRmJIvVrHJpBQSifzb32mP6aMuOrPnRccjs
 lD0A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790665071; x=1791269871; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rIsszbVyWngGxO56KsFDmyWqHoVF/ehzgI8QIUjM9Dc=;
 b=FiW2URaoXAYRBlNOg8xkFMmmBOxqrfTwYCBdQ46ca5SQL6XKmtVQNziAbXOm4dFkWI
 0ixhwex9x1+wE1/y0mUbnHC5b+H2IIO5H309zcHXiiyabZovkSdAkczJOnwZvuiMdbby
 745lEONxmOEG7LGn5eaReJnDWW/ezALpMDJYi9nhsH7IeRESQnimwJCJosN/2UUiIWhw
 JBsk7AjUReDtvDsieCJ3jCbSuvRq3eTUBVrJlrWPaarf8GBx0pMo5usXxiigPEdMLGI1
 nncXbD8apo5scZeaOSr4lO8pdYNbwy6nhzoEXcfsezPe+SiLg8T4Wbiu0ZyKakbUnTKa
 CcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790665071; x=1791269871;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rIsszbVyWngGxO56KsFDmyWqHoVF/ehzgI8QIUjM9Dc=;
 b=Bt5Ox60E0QvuCS9Bz0iGwHznAQUUcuEJb/zvcNpsl+nOdee9UkrKnanvsWxi9c0yps
 g8Zkm0AnvaKm6IXkTNXN/EqLouUN3zxw+oZeHSW8MrhZEtjjFmQ/ZZdq+2bYM1Uwoa/E
 EdTF9RZ0GAnvv3cMn/ht5uTw2/3/wUK15dODgd/8zFZdBak3Dtjan9y9cAYDVoZOj2lz
 EN55M+fBSvVv1VRSyZFsXukGmWe3tyTrKSomRKjzA6iSh9zl3MHTWuuZ4cCJaom2NiGQ
 UjBnFwayMUCspi5Lvd2aeoSF38bbhdsdQ5/7cxelkMseyUcNiTb+vA0F3ocUQX2cSRs+
 WrQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwypO1ai4bt9Fl9izL3TujMuoSBqJN0WlfZDlgqK3Od8HQoi979uZRDWVTvadUcnZpONjajIH3P5HD+@nongnu.org
X-Gm-Message-State: AFuF++l2mAO98dEl7T3//yRuGzy/PR617B9U2XibZhB32AbXpmXnv0im
 MxXE4DEAbWo0EnMJZo/7u1uss474X+64oGfBBj9gvGAeEm9l4KUs/ZJO3t+DddTsA9PvCaWDnx1
 iRu/plqUiLS+YpqDa/5UPsjxSoHoZs/YC72bRTVm6SK8lLhD6Tu6Lc7si94NHVAl2Gd77DieAo8
 gykrK2hOzojnDPRLQ0SBukU+h8o6dZZwo=
X-Gm-Gg: AYBFou1Mj9SkiN4VYMYiHP7gNmEnnC+LaNkcRVvHagOfKoQMIiWiEpMzlX3oUTyiIn0
 v5n1Ajj/sPCMjy61Ruu1rQQhuOChQynKMk0gWN20h2gohetG3en85qVz0fzT3rM/zBHlAvMGWlm
 DVGDfKaDgCnJ55Bry/iDgIIL04qjfFLtZqGIg2cJwoyQdQKeo8wPpjpNvuqCU=
X-Received: by 2002:a05:620a:4611:b0:936:69dc:aedf with SMTP id
 af79cd13be357-93c43bc93e3mr2568561385a.16.1790665070916; 
 Mon, 28 Sep 2026 23:57:50 -0700 (PDT)
X-Received: by 2002:a05:620a:4611:b0:936:69dc:aedf with SMTP id
 af79cd13be357-93c43bc93e3mr2568559185a.16.1790665070452; Mon, 28 Sep 2026
 23:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <aq2m9yuSGK0m2zRb@humpty.home.comstyle.com> <aq66Bd-9wa3N5Zn8@tulp>
In-Reply-To: <aq66Bd-9wa3N5Zn8@tulp>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 29 Sep 2026 09:57:39 +0300
X-Gm-Features: AclHuK8Sy8z4T7QRMA3c0gLsqaAhjS5ZJmGAOocATgSuaM43rkQD42ca_D4YZZI
Message-ID: <CAPMcbCrBiQ5mQ_jKSoVLhP5c+1rNG0MpAs2H0aQC-sEa8xUAdg@mail.gmail.com>
Subject: Re: [PATCH] qga: implement 'guest-get-fsinfo' for NetBSD and OpenBSD
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: Brad Smith <brad@comstyle.com>, Michael Roth <michael.roth@amd.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000006fb6b6065c99b300"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000006fb6b6065c99b300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Sat, Sep 19, 2026 at 7:37=E2=80=AFPM Roman Bogorodskiy <bogorodskiy@gmai=
l.com>
wrote:

>   Brad Smith wrote:
>
> > qga: implement 'guest-get-fsinfo' for NetBSD and OpenBSD
> >
> > Signed-off-by: Brad Smith <brad@comstyle.com>
> > ---
> >  qga/commands-bsd.c    | 19 +++++++++++++------
> >  qga/commands-common.h | 12 +++++++-----
> >  qga/commands-posix.c  |  4 ++--
> >  qga/qapi-schema.json  | 12 ++++++------
> >  4 files changed, 28 insertions(+), 19 deletions(-)
>
> Look reasonable and does not introduce regressions to the FreeBSD
> implementation, so:
>
> Reviewed-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
>
>

--0000000000006fb6b6065c99b300
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, S=
ep 19, 2026 at 7:37=E2=80=AFPM Roman Bogorodskiy &lt;<a href=3D"mailto:bogo=
rodskiy@gmail.com">bogorodskiy@gmail.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">=C2=A0 Brad Smith wrote:<br>
<br>
&gt; qga: implement &#39;guest-get-fsinfo&#39; for NetBSD and OpenBSD<br>
&gt; <br>
&gt; Signed-off-by: Brad Smith &lt;<a href=3D"mailto:brad@comstyle.com" tar=
get=3D"_blank">brad@comstyle.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qga/commands-bsd.c=C2=A0 =C2=A0 | 19 +++++++++++++------<br>
&gt;=C2=A0 qga/commands-common.h | 12 +++++++-----<br>
&gt;=C2=A0 qga/commands-posix.c=C2=A0 |=C2=A0 4 ++--<br>
&gt;=C2=A0 qga/qapi-schema.json=C2=A0 | 12 ++++++------<br>
&gt;=C2=A0 4 files changed, 28 insertions(+), 19 deletions(-)<br>
<br>
Look reasonable and does not introduce regressions to the FreeBSD<br>
implementation, so:<br>
<br>
Reviewed-by: Roman Bogorodskiy &lt;<a href=3D"mailto:bogorodskiy@gmail.com"=
 target=3D"_blank">bogorodskiy@gmail.com</a>&gt;<br>
<br>
</blockquote></div>

--0000000000006fb6b6065c99b300--


