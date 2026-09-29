Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A317CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBYmO-0004aU-Pb; Tue, 29 Sep 2026 10:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBYmJ-0004a5-DM
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 10:25:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBYmH-0001E8-Ku
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 10:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790691952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Juf+g2PnkHayrOU2UK+KRXm0Tg5W4W0+a1VqCSodg2k=;
 b=JNTOM9OS3IdldbCL/lxhKlmKDC+k716Y4SkJfCA308Lx4aZ1jz3nbNizs0ruMyEnRwsAhI
 NdWNxDRPtbZcI7gM6fenjVi2GUQgF3FI0+Q/6VXbIKnter21ShEmw8mo7WASaIe9EXry+g
 UIwH/y9VPkNo2dh305rge3om5HU6754=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-1C9GrWWrNk63EIbgPEfYng-1; Tue, 29 Sep 2026 10:25:51 -0400
X-MC-Unique: 1C9GrWWrNk63EIbgPEfYng-1
X-Mimecast-MFC-AGG-ID: 1C9GrWWrNk63EIbgPEfYng_1790691951
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-673abd1ed0dso6688097d50.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:25:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790691951; cv=none;
 d=google.com; s=arc-20260327;
 b=CI1KgfnDhGHUciOySnmw9DQjcn7vFmEqW+bJx5NdBFHLMpA5IC5dK9pYwiLlSMKZMe
 7D9EUVzN1lX2ahrsr387ufyEaoJkIcMqljsO2YC5uL4EmGvkDWVSE8fULxpKtgtInV9u
 mFccA3RjuVEnnwR9PFA2l58RwfN5czAYlX7m5aHvqXB+Ca9m226ZstpBSNXQ8yst3cKq
 388U5U2feyjT1jMv0Zv8b8AaZbX3x/Fkga1h4Y8NgjTD5/B3YJd72QJx/A2xFls3/856
 8Iw2CbRl1FLCnqHMKz9W4t5tW9TNYWCQzhMpnDTfLYXRe0RPCtalf02e31VnffRfRQhR
 0pyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Juf+g2PnkHayrOU2UK+KRXm0Tg5W4W0+a1VqCSodg2k=;
 fh=be+vfmX/XCacP4IeQ/q9Cx8cwWw6V3GT9VXAd+fPJLc=;
 b=Pu80BeepenH8U5fDY+ojBLvn/+uCcHnAufEO/0rE0BWLritAHdDSLAY4KEJSAOpVsp
 nzLGXeZsShJGBrjREgPGR02hKW7uSfp/fvZWNW1L9w1At9UiGFfq0E60mLsiRBDW4LrB
 UoloB5wIV7xOTIY9KWA4Plm3KHYacTgkr/F432DecBMBtTF45r9CI6/bT3ainqva9TjX
 ojofKauwd+IamWfphpgvLYlCwpld9W5Hop7SNE9Ofw5KdJLx6jzUPwrVFhMD+cJbsliz
 8czVuNvUAnrFnjSAUkLgx3EyryQYh5zx7h0E+sT9/o7CeALXQRsD92MWK382xjmpLfPW
 PuUA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790691951; x=1791296751; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Juf+g2PnkHayrOU2UK+KRXm0Tg5W4W0+a1VqCSodg2k=;
 b=YmEGJPaTLAkUANyjfkb8ve0pQQ0Qc5rk8uqUVGs9jxMmJvrne/bMrDGm/sZh9rL6ZT
 K9Y16fzaGdq6k0PWqyv9JybqbL1/sgWtAlosW6PNNUyTr0Iw/vXwo7LUPtXxlpLm26RU
 OmIiqvUrkjFOR0Bv7cRGb4Db6TVEXDVf4VVM6abOlacncJPHLyoVbYvDMkyboj3rtYb0
 mk5/dIqEBtsQYwBFM+9GFvRY+HGyaiXSrI96Wo6ANa1IPgSh/kjNgBLwVpCBjKJJ1+yA
 f3ZkChI7mohVNqMorjRX0g0SgKsCmkXvtqhKMlaAUScc5DPbgABJpUo/8Mh9TDSYDdFH
 xpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790691951; x=1791296751;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Juf+g2PnkHayrOU2UK+KRXm0Tg5W4W0+a1VqCSodg2k=;
 b=WQWkLGjb47kWGn2xlqzy0vCzZdfg5WEni64P1jpmYGUXUfL/cOkteqIA4tC2Yyj0gw
 LEA2zNyyV+KfVMZMZyYJGK1nRs0FMpi4CyBfuCaXPCc8EPBobASjngZ7WRdIbeRdGvy0
 6xNxUgx4F0aHD/2jJnPvYF2laR7Eua3IwSXtctAJLdwjI18C/5CYC9RJd5vKGhdor4vD
 ghQGeTJQ48EEQn6vCEuWlESKz1XJbkQ+NFQkThJFIjDD1yoPpDSKruarkpHHrZmyK17v
 4YhDS5+uQxf9+aOJ6VlBEkjV++gAxzyEhv0+nOGWgb0dALstaNsbkTMUnlWwAcH9I2AH
 Oihg==
X-Gm-Message-State: AFq9FYI5OUK9Ej2j/WhCtxpU+Ld2xFhr4g07ffA1Y8YQ36J8K9H9XU4c
 0BT5mmvdTvqu4DrsvOrFmlXw1ZbgSQVX4anwytFn7b2sPhgCg0eOYPrT8zcREP/6tZnlZisX5MX
 gKPomz93caqUmLgh/XiPtw07zfF/miE/gayCcw0x5popzfkG6F2KETKvl2ORh3TdwzW8q+sGtKM
 WH7rzR04BpJmPpvDbw1UE5MYyF+97LeZM=
X-Gm-Gg: AYBFou0NubQc2uDkwppJPsl/Z9UurViJOk+NvAX6EasEEIPQPybcBi5olrTYtYtYL9R
 xpQs06Nbz+OlX3/jI5hz9YXS8PbH8ivuuU8YwOEBvpUKAhDLHV8sKbcxiY14Z4x+sCGTxouZjt3
 gtlu6LLDdNr3PSS8C6mKra481Vcj8jT+38cwmHBlsL5ugcHjZnZdgX91G1MBZ5rRm5N3zLNgXDX
 RJvXydh7LJYBDE=
X-Received: by 2002:a05:690e:169d:b0:675:4565:60b6 with SMTP id
 956f58d0204a3-675456566e1mr2790573d50.28.1790691950693; 
 Tue, 29 Sep 2026 07:25:50 -0700 (PDT)
X-Received: by 2002:a05:690e:169d:b0:675:4565:60b6 with SMTP id
 956f58d0204a3-675456566e1mr2790534d50.28.1790691950194; Tue, 29 Sep 2026
 07:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260928223657.2303684-1-jsnow@redhat.com>
 <20260928223657.2303684-9-jsnow@redhat.com>
 <871pacxlpq.fsf@pond.sub.org>
In-Reply-To: <871pacxlpq.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 29 Sep 2026 10:25:37 -0400
X-Gm-Features: AclHuK9jSrq9YLHAOWms-tix-9C8uRiMDvhKq_uDX3StUIyslUD16uTxmurh9ms
Message-ID: <CAFn=p-Zq3YHVq_DMxSL07-DqGD1xTkBJFFzSbLPmjMaq9w2_mg@mail.gmail.com>
Subject: Re: [PATCH 08/14] qapi/parser: enforce strict positioning for
 "Since:" section
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Kevin Wolf <kwolf@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiri Pirko <jiri@resnulli.us>, 
 Alex Williamson <alex@shazbot.org>, Kashyap Chamarthy <kchamart@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Michael Roth <michael.roth@amd.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009814ca065c9ff517"
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

--0000000000009814ca065c9ff517
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026, 8:53=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This patch finalizes the total ordering of all QAPI documentation
> > block sections.
> >
> > ... Except TODO, which can still be wherever.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/parser.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index 8b331aa0673..c14bff2cbc3 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -552,7 +552,7 @@ def _tag_check(this: Union['QAPIDoc.Kind', str]) ->
> None:
> >                  if isinstance(this, str):
> >                      this =3D QAPIDoc.Kind.from_string(this)
> >
> > -                if this in (QAPIDoc.Kind.TODO, QAPIDoc.Kind.SINCE):
> > +                if this =3D=3D QAPIDoc.Kind.TODO:
> >                      return
> >
> >                  if this.value < last_ordered_section.value:
>
> The check for duplicate RETURNS, ERRORS, SINCE in new_tagged_section()
> is now technically redundant.  Deleting it would make the error message
> worse, though.  Do we care?
>

I wondered that, and wasn't sure. I left them in for now because I was
being conservative with regards to not messing up existing unit tests.

I suspect your feelings will become clear when we start adding unit tests
for the new error cases.

Sound about right?

>

--0000000000009814ca065c9ff517
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 29, 2026, 8:53=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This patch finalizes the total ordering of all QAPI documentation<br>
&gt; block sections.<br>
&gt;<br>
&gt; ... Except TODO, which can still be wherever.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/parser.py | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt; index 8b331aa0673..c14bff2cbc3 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
&gt; @@ -552,7 +552,7 @@ def _tag_check(this: Union[&#39;QAPIDoc.Kind&#39;,=
 str]) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if isins=
tance(this, str):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 this =3D QAPIDoc.Kind.from_string(this)<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if this in (Q=
APIDoc.Kind.TODO, QAPIDoc.Kind.SINCE):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if this =3D=
=3D QAPIDoc.Kind.TODO:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if this.=
value &lt; last_ordered_section.value:<br>
<br>
The check for duplicate RETURNS, ERRORS, SINCE in new_tagged_section()<br>
is now technically redundant.=C2=A0 Deleting it would make the error messag=
e<br>
worse, though.=C2=A0 Do we care?<br></blockquote></div></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">I wondered that, and wasn&#39;t sure. I lef=
t them in for now because I was being conservative with regards to not mess=
ing up existing unit tests.</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">I suspect your feelings will become clear when we start adding unit tes=
ts for the new error cases.</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Sound about right?</div><div dir=3D"auto"><div class=3D"gmail_quote gma=
il_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000009814ca065c9ff517--


