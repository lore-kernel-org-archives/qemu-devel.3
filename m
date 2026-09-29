Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F8FC9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZN2-0006bV-O2; Tue, 29 Sep 2026 11:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBZMw-0006Oa-Ld
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBZMt-0005F7-0d
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790694219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XKns6kxfa4XGM0NEhh9NmMaT09uzb++Q3AWtoqGxwgw=;
 b=O+1Q/D/qPMir0jkC+3O9bUte2LzTEfBPRODx+Su1HX62QJc3kTpj0bUno7UTEOOx9kxT8D
 QL+ph7zNkhKEQra67IHRnohOVm3C8RwLZhb3CMYGV8pkK22L6Ru9SSGWI2CRLtBiDs4ZEn
 xdpdc5y1XJV2C/Jjdi3VcltrRUcCaCM=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-3HHKxg3MMhmvA9tF6GQvtw-1; Tue, 29 Sep 2026 11:03:38 -0400
X-MC-Unique: 3HHKxg3MMhmvA9tF6GQvtw-1
X-Mimecast-MFC-AGG-ID: 3HHKxg3MMhmvA9tF6GQvtw_1790694217
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-6755fef4f96so1932209d50.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:03:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790694217; cv=none;
 d=google.com; s=arc-20260327;
 b=eIkAFbSdaGeOKhIj3YKlStcObJ5kUZ0P9CmJOJjhpf/QNIjb8+k7+5kqjjLsEwRZqG
 w8XPROgnRRO4nAUv1i7zBPZEaeSF3S4vCtCmI3FUuywFMU/Ky44IqqGR5qagFEhpddL9
 AkBwOGDdkzKU7BiFGL262XT656mC0MymR8bc6J3bvcuoasOOPjYikhHGUp3pYTwhmkdi
 ArY4IKSfR+MECuLdfUDOO/MerdY8cdixzGjm/wIH2W3GS/csnln5DXoSwK3oNdVv9S0b
 pTHER2DwL6BLB2+yZ7prOnKLm27Ci4HG5kWoBwWZVjUYVKJlT/FAdbVezQDpWn38BhKu
 4AUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XKns6kxfa4XGM0NEhh9NmMaT09uzb++Q3AWtoqGxwgw=;
 fh=n+2DAFMZlHp3F1d4nio56yaatBOIj9xQxACGOxQdYUk=;
 b=UVtE9PVXBztUvlnvFEf1nzzlnaDoU++F3d0FLAtYTYxEWYYmDGAoo7LOloQZDztl6K
 lKYQPfvTTVN8N0pmjfY/RciqWhTou+eAjwsXkbguSKbWwNBx/ia1QaFglmGYxil3xkCY
 TD6/XfyowTwT6PKE2EZQdurKzIhN1wDsAdSfbu/yT+PvRCCwfOkRKvq3QTxHHLzZ/DFF
 hdVC05YDjcPkjl2yBXslj8IEETFbNNK4ndVN0Vo5vn8hHrGs+681vBB+Y7ODlKCGXPpj
 b8wtG6ZCl+oM29fXS3oQ/ttLcdfyPMki4lC+94H6XYWTXpDgtW/jiUtMhCSjSuiPP8yX
 ILBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790694217; x=1791299017; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XKns6kxfa4XGM0NEhh9NmMaT09uzb++Q3AWtoqGxwgw=;
 b=l75sTSeyeKFegGDFNMQoAhMg92G3FRzJkEJI1PkAMAhBPzozPlJQaNHGnphv8vZngd
 4U2qpaOOvxiYYR+YOKgM5g/62ZVRzidbaXtNZxPViCFAbVM1RbxHwhJDOdoqrDDyOJEP
 60B3TZQ1FGKtMrcYUNChK/nOeqMb457DsWjhPX7km0BVj2Zi+aHu2UK8AbomEfT+brH9
 HvudK/VwI/IPy5OR1gOvPRWA/CKLl7Ln6CK3tL4YtHuc+5O3yOXxliqNVbs8qRN+wZrQ
 rNKXvcc7Aaz7IvnbF6vjBP7+xcNVAiZy/NBAJqZKqh9Cs4oJ6l4GIrhFxTHB6KG9rQ2t
 4CTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790694217; x=1791299017;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XKns6kxfa4XGM0NEhh9NmMaT09uzb++Q3AWtoqGxwgw=;
 b=lS7ibHO4CuJMZfVz9gHsAKgeqZh0rjJvC38YTZsbw1TLFoRVCsB0h7lqf+rMkUkmvJ
 p/oZ4nLryLWO6YntX0dYXin4w/xReLveDwaRsLkd7cxE2pi+ly1Jp1w6LPMsNfkuWLz+
 ftUbPvarlGOOMQNl92MsDGNUa/woQ7zn7Uj+Dx1LKfKyEzylirU0N/7bhukDjo4wI6NO
 VqFTtJXj2/IDJPCRime8CKQw4J7CU9WArXY3JXE4+alV7bt1gWPHxRITxxXODzRMreX0
 riR3+M+TKCJRiRbpPp21XlOm0GBoje26gnp1+YGi9cHo9xPSqk9FYBgBCs2OkSK3Qflc
 TbhA==
X-Gm-Message-State: AFq9FYJLQaGOvzjd+NsHZFK7KALz5vLB2Bgz0WFKYzl0mZcgEMQ1dOIY
 jAAkmW5LZNkntXF7jRO5FzjaxXZm0POyJzVsaeiurxPiLkn6S2FRJvblPba3BnBooBlYD5+hxFW
 JFgL3oEuQCOCnsxZ8Q5MIiSBvnmN5y5lzhdkqT/67C839N8wryC+twayOx08x09QxOXAi1k7ov8
 ZCVY5SC+xT3mXp8aPaj/GEuV5xfs9WeWA=
X-Gm-Gg: AYBFou0Gz9WJ1Mf8A/B9jfPehXzwXjxcUFFjvGQIg8H6WCgMcxluzEsoGJsbq58PIUy
 /tUAOPwwAOmOSGEyTFBVggWy3ukqKHy8oZNyANobzBpzESvgE2ds/LQdrOGGQhux5ODuk9ZgIz/
 HIR0e7+27BHH+EremPu/hEMrjLokFhIzbnk6lyVH0f33f+iCi7asOleaeEzDDU4qbM7mJS7MKPi
 pBz35VEA17+Gag=
X-Received: by 2002:a05:690e:400d:b0:674:2095:58e2 with SMTP id
 956f58d0204a3-67420958220mr3719158d50.7.1790694217185; 
 Tue, 29 Sep 2026 08:03:37 -0700 (PDT)
X-Received: by 2002:a05:690e:400d:b0:674:2095:58e2 with SMTP id
 956f58d0204a3-67420958220mr3719127d50.7.1790694216626; Tue, 29 Sep 2026
 08:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260928192557.509157-1-jsnow@redhat.com>
 <20260928192557.509157-7-jsnow@redhat.com>
 <87a4p037c5.fsf@pond.sub.org>
In-Reply-To: <87a4p037c5.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 29 Sep 2026 11:03:23 -0400
X-Gm-Features: AclHuK_v6yfXkIGyFzBWk9Q9pOg2ij9B3ZMI4c92Hs1q9IArYQj2n329IienMx8
Message-ID: <CAFn=p-Z=xnoUgesoe2acZAoHCPza3fBFZL7U0Ve-mpeu7hMmbA@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] qapi: convert/split intros for commands
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
Content-Type: multipart/alternative; boundary="000000000000af103e065ca07c77"
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

--000000000000af103e065ca07c77
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026, 2:22=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Convert or split apart the existing intro for any remaining commands
> > in the QAPI schema into introduction and details sections. The
> > introduction is indented, remaining plaintext/details paragraphs
> > are not.
> >
> > For commands that have automatically generated documentation inserted
> > at parse time, these new split points serve as the new insertion
> > point. This affects the rendered documentation for `netdev_add` in
> > particular, whose arguments descriptions are pushed upwards.
>
> Missing: query-stats arguments and query-gic-capabilities "Return:" move
> up.
>

d'oh.


> >
> > Minor rephrasings are applied for `query-qmp-schema` to help
> > the split flow better in rendered documentation.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Happy to adjust commit messages without a respin.
>

Yes please.

>

--000000000000af103e065ca07c77
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 29, 2026, 2:22=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Convert or split apart the existing intro for any remaining commands<b=
r>
&gt; in the QAPI schema into introduction and details sections. The<br>
&gt; introduction is indented, remaining plaintext/details paragraphs<br>
&gt; are not.<br>
&gt;<br>
&gt; For commands that have automatically generated documentation inserted<=
br>
&gt; at parse time, these new split points serve as the new insertion<br>
&gt; point. This affects the rendered documentation for `netdev_add` in<br>
&gt; particular, whose arguments descriptions are pushed upwards.<br>
<br>
Missing: query-stats arguments and query-gic-capabilities &quot;Return:&quo=
t; move<br>
up.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">d&#39;oh.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;<br>
&gt; Minor rephrasings are applied for `query-qmp-schema` to help<br>
&gt; the split flow better in rendered documentation.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
<br>
Happy to adjust commit messages without a respin.<br></blockquote></div></d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Yes please.</div><div dir=
=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
</blockquote></div></div></div>

--000000000000af103e065ca07c77--


