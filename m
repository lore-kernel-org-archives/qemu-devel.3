Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE6A1099B33
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 18:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3eYU-0000QX-Ln; Fri, 20 Mar 2026 14:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w3eYP-0000Kl-RW
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 14:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w3eYO-0005Ac-1n
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 14:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774031195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AW2p7ZUy/rUqWvXRGtu5Scgh0GX+ilZ9QInWlyuiTqk=;
 b=Y4pGt29I29YVAjRth/JLCvzh8PuznPlC2FeNqZ+A/XfIjC3lYnN1bkEqVcB9KvCSvx9agM
 wVhmCZGHAUU0Fg0uikpBQERE/GwrwgOPzqGbKh2Rtwd0HGGBHgRJhG5dioUR0n6lzn0oss
 HXkLfTDqmUU36MD2L372wfXcyz2hrGU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-Z2sa71rGNZCZrABpeKNSPg-1; Fri, 20 Mar 2026 14:26:33 -0400
X-MC-Unique: Z2sa71rGNZCZrABpeKNSPg-1
X-Mimecast-MFC-AGG-ID: Z2sa71rGNZCZrABpeKNSPg_1774031193
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89c4169cef1so173364326d6.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 11:26:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774031193; cv=none;
 d=google.com; s=arc-20240605;
 b=hbln3Nj2/p233NWfUQigKHNZBsIPQr79/F98BulpuQuXP1gjiIXjJ8QFRHF5nCwzQs
 NkcZUtZa5w5REue3m+j36auU8Uqzc6RtJt1Abm6SW5myElh0dggfzCWHdhB62J3L/ErS
 gxC+N3EfVviF9NyGECRUkoJfLw8OrAStoTv1Nab91mR6wp/ctz31L9dn4wVxzkhUU/Ep
 Elz/mWN++nO5ne25U/yW4Qe763AX/0A006RZAIYCooxiGo8QVBJvwA3tGFBl2s+v3wlT
 c7/ewTLswCyjXtixH84AnoI4ENJX40oEiAoPPZtBfsYBFEQwlZtXk6nb3sEmABYLyw3c
 bXAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AW2p7ZUy/rUqWvXRGtu5Scgh0GX+ilZ9QInWlyuiTqk=;
 fh=ITVUHrDuK24wfFWcPHAMT7QsL3mgm65a7A/rtIt/55A=;
 b=JvIUnWzGte2l1758YPlsM4HKew69mhtUd1Y+xsmqLkieB0mC03RPjb31CvnJmobfU3
 15b5rp6vbHLf+/ghskiU3GDtVDkCMpeCkBaiKrcHyeLr9jPByzduIK9bSS0f7gUvKMhK
 u3Il5TdZo7ntvz6htbSFJKF3B8oYgtGckDQBtxy8sS832XjbVSV1P37T5oquosTjSbSK
 JkGPzcCy3FuLV6mcEXjz5iFnAclEx07QP9K+98VcsqQ+I+EcXZxg4X8UkwG6NhRwX6jn
 NRxPghrOenlaYW+STLWLkEOc+mZTQYx5zk0shQ+P9en+QSOow7C4ijKXSSVFCKi6t54x
 9SgA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774031193; x=1774635993; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AW2p7ZUy/rUqWvXRGtu5Scgh0GX+ilZ9QInWlyuiTqk=;
 b=S+PPyW0WB4Mb8s7/sXV+hxuM6zWm/48fOlI3Rcq9Czzdh4GKQcixeGM9UkNC6YwGXK
 QTHlL0M7HOuSaWgeWSBXpgh6J9hC4LsLWB9Rp/XHVcokL3mmGUpEeQLpQxOXkHm5KliH
 cZcmNDRpLVNl6Kqey5XNRaURD4dZXnCwzy3WVsuOWGVYUSL6cskXO4A5SgI3l+XopfS1
 gT2gzAmWMBzZHiElVxWqx+/8H9auT5dNmpPayGFbUZEdqZxIRlV1zGUsx1CqAiFT+0pL
 Fb4jGDmLnZqXpEa7w/LaTWLPKH8JcjJCVXZa9/e11CEWnajgOMk9d8S2wbOv4sqD5Znw
 YJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774031193; x=1774635993;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AW2p7ZUy/rUqWvXRGtu5Scgh0GX+ilZ9QInWlyuiTqk=;
 b=TtLEMyFaib9lUEuhIAAgeusm3E/8up/GLczXG+KuB28on1WaHIYMFRJCDl0D4Rmik4
 jcXRBwBeVX815v7y+iG78gVCpWJ8v4HUAFmlOOMrVo6al2lR0BnhMb6RQ1LICrD1MAkb
 Y8LTMUsG2k9lkK1ymxTTtuv3IGlK85POsVnVnYK4VJF7gVQRbm5VhVN8MZl9t0+qPkml
 +h/QGZ4eOlKR8MAfuIqAghRaPSOWuYwSWCq0/LvqXneiVr92yhykqSpAL473wDL2TAJ4
 daEJEyxeM+eRz4ROT4v2N2tBSefAjotYJx4Yvj1bFlHv9d4gnqNipkXQkPrOy3/QwxkF
 sP4g==
X-Gm-Message-State: AOJu0YzgxRlgnt5h9C6EzqvEoxje0xepsZe334Z+0YQs/+rJKiYLwIky
 Ba2huYL0ByCUkqIoo0SV6IvsQFPovwmcRhEGcItT+YIaCB+p8v/T3qRCo7wcwhgqbe2LYaystxZ
 +XuOrEAIT/w8GJj+/DF92r1CBs6nylYSkWg8DfARXSVoG7/eaj6kcXePT3GfyQAG+dpaUB7yzhu
 JRxbJRoOrxlqhug5pR4gJvzZsRBRnoAT8=
X-Gm-Gg: ATEYQzzW8COAsqC1EWjb3IpyHh7ExYh7UpgfcW+mE1aHvNo6f/fFddMO/1AFF7RCaJL
 ASk1Lr9mlqWE5NEP0/Nn6zxQpcQO+5aLxyltPznwgRsamypOtMadD8BjJTAig5UyhLZzKA3LaAB
 zSy7NNwRugqEj2bGbnfio94Q85JO4aVRpqcfTCiyBVvWWNBOv0C5nVKy0hlfikycxi9rpQ0UPDw
 cGqBczW9nUYfH3SIWY+7Q3OGX0X8JU43bvZ1w==
X-Received: by 2002:a05:6214:4801:b0:89c:5e6e:7764 with SMTP id
 6a1803df08f44-89c859f2ad8mr59595246d6.19.1774031192855; 
 Fri, 20 Mar 2026 11:26:32 -0700 (PDT)
X-Received: by 2002:a05:6214:4801:b0:89c:5e6e:7764 with SMTP id
 6a1803df08f44-89c859f2ad8mr59594766d6.19.1774031192417; Fri, 20 Mar 2026
 11:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260316182608.148628-1-jsnow@redhat.com>
 <20260316182608.148628-5-jsnow@redhat.com>
 <87ecle622r.fsf@pond.sub.org>
In-Reply-To: <87ecle622r.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 20 Mar 2026 14:26:21 -0400
X-Gm-Features: AaiRm50oxbyQVx_GmtLVJXtq8wYsI1YKgw5ak8wSKctD-p9_s5gFdrgjByGY7LI
Message-ID: <CAFn=p-ZXvUuixLDHpg+2tTeONGyPqfcXDW6LgJRBN3qLac720Q@mail.gmail.com>
Subject: Re: [PATCH 4/8] qapi: detect potentially semantically ambiguous intro
 paragraphs
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Lukas Straub <lukasstraub2@web.de>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowang@redhat.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Kevin Wolf <kwolf@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, 
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000b7c8c064d78d370"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
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

--0000000000000b7c8c064d78d370
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026, 9:52=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Cajole the QAPI Doc parser into yelping if a QAPI Doc Block contains
> > more than one paragraph of plaintext and has no instances of Members,
> > Errors, Returns, or Features that would naturally delineate an
> > introduction from additional details such as notes, examples, and
> > additional details.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/parser.py | 44 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
>
> Test coverage, please.
>

Adding a FIXME for now. This patch is kind of a hack and we may find we
want to refine it before merging, or maybe not.

>

--0000000000000b7c8c064d78d370
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 20, 2026, 9:52=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Cajole the QAPI Doc parser into yelping if a QAPI Doc Block contains<b=
r>
&gt; more than one paragraph of plaintext and has no instances of Members,<=
br>
&gt; Errors, Returns, or Features that would naturally delineate an<br>
&gt; introduction from additional details such as notes, examples, and<br>
&gt; additional details.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/parser.py | 44 ++++++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 1 file changed, 44 insertions(+)<br>
<br>
Test coverage, please.<br></blockquote></div></div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Adding a FIXME for now. This patch is kind of a hack =
and we may find we want to refine it before merging, or maybe not.</div><di=
v dir=3D"auto"></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quot=
e_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000000b7c8c064d78d370--


