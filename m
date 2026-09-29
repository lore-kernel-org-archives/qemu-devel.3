Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9DBC9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZI0-0003pv-Vh; Tue, 29 Sep 2026 10:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBZHz-0003pI-A0
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 10:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBZHx-0004lQ-MR
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 10:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790693916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=enrQN9GZJPOJb0oiSEHrh/bAHO2V8VrOClgIJvGDKAQ=;
 b=N2OHuFkWRyqrUflaI5Ksp3kJ0CX9i45YhAUiUBbRzKUfFwfDC0BtnLmYDd3DNuisQuex/x
 3PW01mWgsas0b7aIKHeM69G+atuNGHWjYPVD2U9GPGtrLfyoBep3+59OMMfMEtU3fO4/qI
 224s+gBu843g93scvvICczxtSV7xY2o=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-r6OKpPj8OTCrZIp3PqWVlg-1; Tue, 29 Sep 2026 10:58:35 -0400
X-MC-Unique: r6OKpPj8OTCrZIp3PqWVlg-1
X-Mimecast-MFC-AGG-ID: r6OKpPj8OTCrZIp3PqWVlg_1790693914
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-6713ebbca2dso5940794d50.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:58:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790693914; cv=none;
 d=google.com; s=arc-20260327;
 b=r1CtRFLdjvSzgoK2wuEZL6eB+RxmbhipkZqnUrQd/ufiIeq3jMMFWWDBhy0NJovxEh
 Bs6sbcijjeJipn8KPNS9uGIiG6luM1F1gR0N7DzLDq1rDuJqA/JDtOnfXU7PGtdQoBJ7
 6nk4LlgJjuqbSYNVjIJpO8MrSSf1vvdkPHrFE/lR2bqj1dJ5F3m/r0Zoig19Y0oY1uIP
 mA+yPFEUF0ZgcnnK/5hXtvhgWpoSJkPUbzrtJhdmhcQz4w9wQHEIAaxdSEm1ML8udGxG
 MUU0KhrKYIEJs7mQSY/1BDuqArx6X9hQeXWzfzwnyzkGwhNpyBQvxw2EXV671lnWEzJp
 fZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=enrQN9GZJPOJb0oiSEHrh/bAHO2V8VrOClgIJvGDKAQ=;
 fh=n+2DAFMZlHp3F1d4nio56yaatBOIj9xQxACGOxQdYUk=;
 b=j13s1WT2SLp9byCgal+SlUBkVn0P6nSk1FHqpO76ajlmuA7uZati05bq1E/v63eLEY
 YFmaVcsiH4sp8NcdA0qfHuUIKifcBO1gBq+z2D4vUJ+K6mf+s6bxCNpl5tVbzkyQdn6A
 LaApk9aykkNdR3fxtW8G11mqvV2aCCAcKIGNVyFWdUHHhZWiaUGdKwK6IjwMl2X3+qb4
 QzWTGtb7mXRUdrhHGAbcO+X9T6z+IXTOz99atwXQCb+K4r8eKNX+eesjCUTJTt15l73I
 GP/f4URAfcCsfvkeE5MPdzl1LrhCcJIz8BTNO1SkQ1uOxBbeVvk0upoZy3s/qxtQ1yZf
 Nqvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790693914; x=1791298714; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=enrQN9GZJPOJb0oiSEHrh/bAHO2V8VrOClgIJvGDKAQ=;
 b=CoagNMuKv+/PaSaMcNEI1+cN1EP0G9a5+fpIZ05XRUqqS78nP+YPRTLrZRYDVsjOOr
 Av9dCKUOWaaQiG/y8rBld25Me+G1twUuUYcv9KzeikX8zPhSR4Mcs9TEtdOijUdWj6QJ
 Oed+I4Lprx+quNCnIDjwJYYqoIFv6XYx15CV5M1oMjZmsz7Hazjn/D9gCgmJxdCBOqbd
 btaCEXKeDefeenbWJ1bMNFQPwXeGJYGWLIQ7EPSW0ij+UQ0bTtF1/5j2raqx5N+CYVF1
 78lfqmwgeePdeFuj/DtxVLD612E7D5vgIMgnGmt7GXlBBI27uIJkRC/kjYQ9V/x9JuGB
 Uejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790693914; x=1791298714;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=enrQN9GZJPOJb0oiSEHrh/bAHO2V8VrOClgIJvGDKAQ=;
 b=x3DjfBgHTRqFwLQeRWJq05xND1RY4XLOhq/LALR41VDBJVgymojAyCItbFSiP0AJuO
 4zHdKT2oenrdgUKIzoq4FQRp7G6+aVWTsFSPzNMJwEOVy33RD/uv91WqZ8ugst6Xe4E/
 MOrTujrV9dZF+SkFv4r2V9ROGprtEHLVvr03JuQ7d/F+wm2OOh+gcZO8eKKBxodq4Zd6
 llMaUiq8ad6LuArB8Eqw6OkSwlQs15Om2W82LIv7SBPZWA4gjA3bY1nncrLCaOXq+RnV
 bL+Xh8Ew2LPMg5Vvy7fb2Z0M3zeMDQT9SDGtb9l/vgoAcbU8kwSMf0ajO3dWF55h9EPd
 mJiw==
X-Gm-Message-State: AFq9FYJqTXedy85sZMY6AwQ+4wUIB1K4gtaIpPmHfwwcbICu80FGUPfI
 44zzVoVMiUmSCTiMyJ2741jlnGjcJCw1r04doINzXmPGFBOWgOf5Bxt0nzBZyUBQzYSPxVY9gRk
 pp/XHUOa8JTgZ+vdTPOiA1el0Nsfyu2WdHWQYX0i2HJgS/XvECW+nQHHBtKB32wR3GnD37guDtb
 MurahDm0v6h2x8UWAPkULbH/aCMUL8wzE=
X-Gm-Gg: AYBFou2rXWUrcCUZlsB+Ujikr2/0IUN+hWk31SltFqZd7jyAZInvgq51BhV52yzvogJ
 jQ2oL3M/hEtABvvHB8GfDCFwEuNO4Ewo60pDE6wZzYcsFbR0jibCFooNEDjXIsmtFPeHl9gvTw+
 cw+rrvLRXCfhhSgD1Dsqw5dpRzctV4US+DiZWj4enZZS5LyKbIDqQQz1pxTlK1OUTIyVN7CeJXV
 LJyVNQAFh3yYbk=
X-Received: by 2002:a05:690e:168a:b0:673:335c:1a7d with SMTP id
 956f58d0204a3-673335c2ce1mr5835348d50.88.1790693914210; 
 Tue, 29 Sep 2026 07:58:34 -0700 (PDT)
X-Received: by 2002:a05:690e:168a:b0:673:335c:1a7d with SMTP id
 956f58d0204a3-673335c2ce1mr5835328d50.88.1790693913601; Tue, 29 Sep 2026
 07:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260928192557.509157-1-jsnow@redhat.com>
 <20260928192557.509157-3-jsnow@redhat.com>
 <87mrt038cj.fsf@pond.sub.org>
In-Reply-To: <87mrt038cj.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 29 Sep 2026 10:58:22 -0400
X-Gm-Features: AclHuK9BuE3oVXpKqu2qB-7NOjq3J00WJQAhkH0eMZBaYDzqtsSUi8TNlDq3z98
Message-ID: <CAFn=p-akLen+sJfTTUYnxGdaE_isKhNoebjD+ojztTfbuRUtTQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] qapi: convert/split intros for block-core.json
 commands
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Zhao Liu <zhao1.liu@intel.com>, 
 Igor Mammedov <imammedo@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowangio@gmail.com>, 
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: multipart/alternative; boundary="0000000000009f5860065ca06a41"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--0000000000009f5860065ca06a41
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026, 2:00=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Convert, or split off, intro sections for commands defined in
> > block-core.json. In general, this does not currently impact the way
>
> Suggest to scratch "In general".
>
> > these commands are rendered, except:
> >
> > 1. blockdev-reopen sees its arguments shit up to just below the
>
> I trust you meant "shift" ;)
>

oh my god


> >    formalized introductory section.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Happy to adjust commit messages without a respin.
>

ACK, yes please ...

>

--0000000000009f5860065ca06a41
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 29, 2026, 2:00=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Convert, or split off, intro sections for commands defined in<br>
&gt; block-core.json. In general, this does not currently impact the way<br=
>
<br>
Suggest to scratch &quot;In general&quot;.<br>
<br>
&gt; these commands are rendered, except:<br>
&gt;<br>
&gt; 1. blockdev-reopen sees its arguments shit up to just below the<br><br=
>
I trust you meant &quot;shift&quot; ;)<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">oh my god</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 formalized introductory section.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
<br>
Happy to adjust commit messages without a respin.<br></blockquote></div></d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">ACK, yes please ...</div><=
div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000009f5860065ca06a41--


