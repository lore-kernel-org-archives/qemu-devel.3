Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79B2CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBYtT-0006ih-Mc; Tue, 29 Sep 2026 10:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBYtF-0006hO-Tn
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 10:33:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBYtE-00024j-KB
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 10:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790692383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O33wHsx9hFc57nwbQ+4eNwdDDviU2EiwJ+GyTz6zSE0=;
 b=P3N7e27LByHuYWkOOCl1MMLE6wNOwKD4lyw10+rEG+Fz8sngiGOTIZt6aFxCOLVWgwSgJa
 xlYoC9U83StvgmGorOKmLhCCtWg31kSqe1isKNwwGh0lzfsiw3d/UgyXWZHjLlbWNPqpGI
 QkhKV7JcJxtVi6jnlu29ybJu1dU79aU=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-lu_wxB1lNSKJTMB0xeAYmg-1; Tue, 29 Sep 2026 10:32:59 -0400
X-MC-Unique: lu_wxB1lNSKJTMB0xeAYmg-1
X-Mimecast-MFC-AGG-ID: lu_wxB1lNSKJTMB0xeAYmg_1790692379
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-673e272fbbeso4487114d50.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:32:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790692379; cv=none;
 d=google.com; s=arc-20260327;
 b=ggmld/sf0I0Ai2mVZm2IwyhkxcEjLDB+Mcq4WL0swiyLsVLMtd5PAUMmIwWAnQ5eJ/
 CEl5KjXJvacjlec/h6Xx1nM/uHu1DVKTxh0ZiZttI45T4VcPu406NB+G4geu+Ru2GK9P
 O0OP3CQn0yjrtX1ziFEbvucSLB45HSa54OFHdw960GaHgb72k6/G/q+5wEEdttxqK6rb
 6whH4S0AynJ4f+f7f5sdI6pCVTxmdObZXyk7eXGmbUbIZAkMElJK7qYEsLd/nU8CUoQG
 vBx2UqIQ0KiJofgOTOhpn97dXc5DtB+4kwFpegt6id+nTBnJiQ8Yh0/6n0P0NZu9WUrm
 msKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=O33wHsx9hFc57nwbQ+4eNwdDDviU2EiwJ+GyTz6zSE0=;
 fh=be+vfmX/XCacP4IeQ/q9Cx8cwWw6V3GT9VXAd+fPJLc=;
 b=mVWsU70XsEANQWhib7aEkbhH9C5UffjXcIDlH7k+5CNQ50A1R+K4dkpFujRe3rOJl4
 ckNi31bPbFPIodr5WxAABTbwRO5kUGw9LLKLgrvOJ+mx1nRrAOpKZo77U8zl8GBItw0L
 1QiH8eWxRgM0vpoWpP4g+h9jjI1lav70amxmty/jBTAQ0p4QaLPnUKpmopGoMFB1bwNm
 4GfgnwrpfszXsdX9tF4byAq3uZjEuehWoXIW40M+TBFypb2ka9PP4fVKXYBN+i8f6/w9
 8dUM9vuFqaz+yLyFWqJdmxzjASZnSLuDscsoe94YcHYDdCeK5TciUS8x1XCjW+ilQaq7
 rSOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790692379; x=1791297179; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=O33wHsx9hFc57nwbQ+4eNwdDDviU2EiwJ+GyTz6zSE0=;
 b=Mxbgj7W9z7fOwE35iRdv+KnBWdy4+fAWFdm3fXjakeztmxaunGHSkLCdGa+38egzxL
 e2rI6053618NyxWh1kiqVZkUBVh2udYpSqAtJQDqhSpOoUwc2NWHVeDrM2264M8n8S2a
 r0pvJqzlvp1EzQ0B+sKfdiOuKILteFTwZmNjBx/hFtFXKGD+uPn4nL8srGMFJa/d48z5
 aKZiTNi+TyfwfmfE0GIR0khxFabuuVHZ6vBWtFwOWiAiG1vcSdl7O1OYjjBUsKQgcrFz
 TQVTRQXmCK/nnjg6p8fFl8OPC5aOhaHe+uPxe9s5E7rQ1S5G0yIXKwIRkSr4wIyqmeOj
 paaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790692379; x=1791297179;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=O33wHsx9hFc57nwbQ+4eNwdDDviU2EiwJ+GyTz6zSE0=;
 b=kaVBXRnzYiZGWm1ARKQhaOzUnRg6OgZk4pNlWzfae+SnVSM47D/ahyetiCsvQvqVgL
 7bwvBCWPL82mtNGqFFKsbzcEgSG85M4pPKaHmYJjGUQmNjuRrrjYCHAz1eQ2uPqQmt51
 O/zngvO24LgwzVF3DI2HnnN5+GYAJTvp1xXI670oM5UYST+OHDI5bzfaMJM5HWwznSKA
 /EzBTeQ956ai2BQfhT26NN1qh7GbLRVbieHsOHzVgycW1GHks9cqt1fhnyxVYS5zB608
 1oE8Kr6VW1mzQEmAIjwKuMqjcyLAZCRZiYN/rZx+Qmagx4LS3E+3+th72RrtAzgUSQvc
 y13A==
X-Gm-Message-State: AFq9FYIvkcq0Tevd77BHndzF+gqfioQ8NwxpJ/F/2v5ZBrQ3Iyks9H7K
 25elyIpy7MyKuuTfsYtErqGfU/83GSzG0hunPCJc6btoTZfSUi+wxTZHOhza2A6rUxkG1lzZseW
 8ywdbExg/QY7H/GqqCp4JLGxsOId+JSw/pNU9wKIfIhqL8wgy9BiGDhlxWQce3Qmxb08cFblyLI
 Bny40WSeAchNAXV1PtGjsjtPCtNA42v14=
X-Gm-Gg: AYBFou04Aw9htKPHMPC5ZKYaoBvYxIpb4qeMSyF5ObkD89z9Mmqnnf+wZrk36GGMXo+
 5ZWnEaql0kGsptqF/TQv1PoEVH0QNNhgKyM2JcRdY4cy7i735GrjIuIJS/+n8k8+UkyigmMNvHZ
 zgfTpqqedaOS0RqNIYhwsVnp21l2wrrV1LVapjAFMHv5/V2heBoTJjKeMbXtAqDjYoUtqbgJ8ZZ
 3/VoruqeDghOWg=
X-Received: by 2002:a05:690e:1c07:b0:675:47ba:21aa with SMTP id
 956f58d0204a3-67547ba266bmr2411704d50.87.1790692379023; 
 Tue, 29 Sep 2026 07:32:59 -0700 (PDT)
X-Received: by 2002:a05:690e:1c07:b0:675:47ba:21aa with SMTP id
 956f58d0204a3-67547ba266bmr2411673d50.87.1790692378565; Tue, 29 Sep 2026
 07:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260928223657.2303684-1-jsnow@redhat.com>
 <20260928223657.2303684-4-jsnow@redhat.com>
 <87h5j8xnq5.fsf@pond.sub.org>
In-Reply-To: <87h5j8xnq5.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 29 Sep 2026 10:32:47 -0400
X-Gm-Features: AclHuK9iLZXcCcnKy9SfAXrDvaBFV68wmXmiUL-P_JfVdqOFiB9tv3PwQFRdrYM
Message-ID: <CAFn=p-YcABv7kk+9_NmYNfXSTzyOqAzdErNXBsV96mLRonOhVg@mail.gmail.com>
Subject: Re: [PATCH 03/14] qapi: re-order QAPI doc block sections
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
Content-Type: multipart/alternative; boundary="00000000000020b5d4065ca00ff4"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000020b5d4065ca00ff4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026, 8:10=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> What's a "block section"?
>

"doc block" section. Documentation block. probably.

I dunno.


> John Snow <jsnow@redhat.com> writes:
>
> > This patch is focused on making sure that "Returns" appears before
> > "Errors", and "Errors" appears before "Features".
>
> Aha.  Suggest
>
>   qapi: Move Returns:, Errors: and Features: into this order
>
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Patch looks good to me.
>

ACK

>

--00000000000020b5d4065ca00ff4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 29, 2026, 8:10=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">What&#39;s a=
 &quot;block section&quot;?<br></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">&quot;doc block&quot; section. Documentation blo=
ck. probably.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I dunno.</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote=
 gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"=
noreferrer">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This patch is focused on making sure that &quot;Returns&quot; appears =
before<br>
&gt; &quot;Errors&quot;, and &quot;Errors&quot; appears before &quot;Featur=
es&quot;.<br>
<br>
Aha.=C2=A0 Suggest<br>
<br>
=C2=A0 qapi: Move Returns:, Errors: and Features: into this order<br>
<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
<br>
Patch looks good to me.<br></blockquote></div></div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">ACK</div><div dir=3D"auto"><div class=3D"gmail_quote=
 gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--00000000000020b5d4065ca00ff4--


