Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD781099B30
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 20:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3gkx-000663-Rr; Fri, 20 Mar 2026 16:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w3gkr-000654-Js
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 16:47:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w3gko-0002kQ-HN
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 16:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774039653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AA/nvRqoPnvoRSsdjWtsgXPti/RErFa1QPuweEXH9G8=;
 b=WJmYxtcfJZaW/BfCa2AmZHHALuQhY2rk7+uQbUtJ6duqIU5s+Q7Wod+LJi1RD5zWYWOYbO
 JafpKF2UhpbZjXgBevRpogPcuQLIDl+iGEaCRLA0GScch5o5/crKChETU08SvTs56fHXpm
 VbVTID5r8uc5ePeBFN+oVOUBiYeIfFs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-AFUZ1q4LPbmsBktelTn58Q-1; Fri, 20 Mar 2026 16:47:32 -0400
X-MC-Unique: AFUZ1q4LPbmsBktelTn58Q-1
X-Mimecast-MFC-AGG-ID: AFUZ1q4LPbmsBktelTn58Q_1774039651
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-899e89bf366so173229026d6.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 13:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774039651; cv=none;
 d=google.com; s=arc-20240605;
 b=Tbb0vG10706iYrzBgtEi17n8p7Lchx1UtLSSq5NbOfsRA/01f6TFp7mDVpgBxZzcuy
 /I0HEUPjAqLLtp3kYHBTuhZnaGmpZ5J64OYtYL97poufcLAgO/8rswOwEoud8eV1wC+3
 BfAe7mIUXOcKXOYMJljYRIojmQcfWnpJNtCRYzCPctHCVQ5Yz3CzrLYYgpTcyAT021kz
 1EXYPNBzFNEdMr3iMAR645JB8OwoxendcLb0EUNLLO85rDpHsyyuI5Tkb3xN991UCYYz
 pYcHagUtvYnwUZKB5jBfB+9APP1DA89q3ohYPgh7x6q6l8Hj09To3WUQH0sgO/lHB2E6
 GSAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AA/nvRqoPnvoRSsdjWtsgXPti/RErFa1QPuweEXH9G8=;
 fh=ITVUHrDuK24wfFWcPHAMT7QsL3mgm65a7A/rtIt/55A=;
 b=K9gl+dG1dLIUYZDCeA2ZVhy8AGH120sRC75jhus6KHXJpvNfPxOBN/zncZo0Gfb+uG
 psXAqmWZFVvhA6mqxidGFJLP8KS3uLmFlFABzsM9ytAeg22+VCDkqhJ6J3e+rrEHVUPU
 S+vgqUC0JSsfU/eNTQsYg17VtGgkey0Z092QnWO7szGN/WiLhYZVeGEu78H3SsWt8Hgr
 IbNqn+H2PZ6gPfv1jxpbFrA9k+27HA5bBVDORN99OaXk9nXzrfdyCbxNnHmoTT22eIGF
 EQmkLTns8nkn21LdRRHYw6cGC9LpYQfk2CnDI1Qml5gpy+ENjhODxkPj2LPUZZNzl1hH
 DN3A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774039651; x=1774644451; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AA/nvRqoPnvoRSsdjWtsgXPti/RErFa1QPuweEXH9G8=;
 b=S6rjoAs9vDlsfUQPPNuWIw3KKBuhxQdQMP10wNuDxpfCLjvSpOll8GhzIsrIBQpss9
 EF5Lk7Uyj63VNtCh0KfRDPbzcqxveuHbsaThHywch/glOTcQr4tcdEVTE/hg/OPRYVuq
 JAzvF37N0mLOAMCcizHJ2phe7DqiVHHErJiDPGHaoQ5xc3MKLhaoOHXeNqH7LRF60E90
 QG0FjJV639hTT2P+EXOzgz5sOf/DcorlDJ0COLqPES4N1MUxc5GE+eEiqG4v24D/W/rO
 +Z+vZjndqkoy7ZbokEZAsKv/TgGF/wKZ//L9lQd/amNmG+A/Nivf+ENvVNMdwb3QLOXT
 nRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774039651; x=1774644451;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AA/nvRqoPnvoRSsdjWtsgXPti/RErFa1QPuweEXH9G8=;
 b=K0YXeAfznq5qpQpGg6aDSxXYyXKg6d0F/wN9ga4iYLQ9j5D0M0zYo6t8LGA507nd5H
 8UkNuzDirLP+RxfxWgCzdKrzDLtzfFb/0aAjyz4QsZN7o7NcUD8tsJFR0IqASKXOgaMF
 VUPODU2d8MBhJJorPrLGkZJHX0miZEYzEYkUZ2Ak/yWUV7C+nNy9LWKGb+Er8aj3tsga
 1zeU5U6DknIckhV+PmY79Q53PGlTZFTh4iQL/NHIJKNa88vQj3y+5xA5ludOJp9FGArC
 iB0TH8PJeUQIA4lB6QoSGGfW2vZBGfYXyrkMoOmir9m9jO8IpWr/PMwSgq2mgxKrrCjf
 KMNA==
X-Gm-Message-State: AOJu0YwD82U9+Sqfldy9R4ParBTuYlMt3WgUWPe3VaBWFSJeoMHLanez
 QTONrxaXlnoBbaiox6pBFqIoogMQyZOC03u+zbT/IE9ARU0p66ldB8btrdi5TtMu1P0iuJqmEnT
 a2pEiCbtF5M5lj+dVES4/xIMXrYPEvFAJ9I1ljiiM3dhsjjhpHPjgij7qasbByRRfpjAoViukFK
 M4tl7AM2nwkcmATiJA9QliduITbKdDrnU=
X-Gm-Gg: ATEYQzxLLqURBcc4DVfnn4RSvwUZ2gfdnjg6CA2KlHqit6WHNBiVRKdjfXiok97oF+I
 O9w5Z0zzrnibnYof6Wn9JivKDnlcNxJ4e6MAmI3co8TFwFpPvoQGwxo/uRKzgvqj7/bzcuSuvEJ
 DlgqTPLWhB4BsPUtPZsf4aOtO4bSgK55CovtsIUO172gN7MdPwdaCnfVsHFmPeKQIZYeNfSJqFV
 EqVeZKWWa0jC4KJReeNrxvToMA7mnh5GqyShA==
X-Received: by 2002:a05:6214:400c:b0:89a:10a2:4fd with SMTP id
 6a1803df08f44-89c85a852f9mr68901706d6.51.1774039650328; 
 Fri, 20 Mar 2026 13:47:30 -0700 (PDT)
X-Received: by 2002:a05:6214:400c:b0:89a:10a2:4fd with SMTP id
 6a1803df08f44-89c85a852f9mr68900726d6.51.1774039649378; Fri, 20 Mar 2026
 13:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260316182608.148628-1-jsnow@redhat.com>
 <20260316182608.148628-8-jsnow@redhat.com>
 <87y0jm4m1j.fsf@pond.sub.org>
In-Reply-To: <87y0jm4m1j.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 20 Mar 2026 16:47:18 -0400
X-Gm-Features: AaiRm51ZnD9EPVc67GQgjSduEeXkSUT4fd3NqrboIgzBwhrlWdG1Feph9H-8qE4
Message-ID: <CAFn=p-ZGWmhO8CHQtg0p72U-6Sag=VTKZ2ai3p6g1_DTNLtY1w@mail.gmail.com>
Subject: Re: [PATCH 7/8] qapi: re-order 'since' sections to always be last
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
Content-Type: multipart/alternative; boundary="0000000000001e751c064d7acbff"
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

--0000000000001e751c064d7acbff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026, 10:23=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Note that with "Since" being moved to the last position, we open up a
> > good many new cases of ambiguos intro-vs-details text which must be
> > corrected with "Details:" tags.
> >
> > This patch doesn't only add these markers where it would definitively
> > impact inlining - it adds them to *any* doc block that has more than on=
e
> > paragraph of plaintext and no other distinguishing features (members,
> > features, errors, returns).
> >
> > It may well be the case that not every last one of these *needs* to be
> > amended in this way, but this is the broad coverage shotgun approach
> > that demonstrates which places in the code may cause footguns with
> > regards to automated stub insertions of members/arguments/etc, returns,
> > or inlining order ambiguities.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> [...]
>
> > diff --git a/qapi/accelerator.json b/qapi/accelerator.json
> > index d333a772384..5624b5d88b7 100644
> > --- a/qapi/accelerator.json
> > +++ b/qapi/accelerator.json
> > @@ -29,12 +29,12 @@
> >  #
> >  # Return information about KVM acceleration
> >  #
> > -# Since: 0.14
> > -#
> >  # .. qmp-example::
> >  #
> >  #     -> { "execute": "query-kvm" }
> >  #     <- { "return": { "enabled": true, "present": true } }
> > +#
> > +# Since: 0.14
> >  ##
> >  { 'command': 'query-kvm', 'returns': 'KvmInfo' }
> >
>
> Rendered output changes unexpectedly from
>
>     Command query-kvm (Since: 0.14)
>
>        Return information about KVM acceleration
>
>        Return:
>           KvmInfo
>
>        Example::
>
>           -> { "execute": "query-kvm" }
>           <- { "return": { "enabled": true, "present": true } }
>
> to
>
>     Command query-kvm (Since: 0.14)
>
>        Return information about KVM acceleration
>
>        Example::
>
>           -> { "execute": "query-kvm" }
>           <- { "return": { "enabled": true, "present": true } }
>
>        Return:
>           KvmInfo
>
> I guess the "Since:" quietly serves as separator between INTRO and
> DETAILS before the patch, and the patch is missing a DETAILS: line.
>
> Several more instances follow.
>
> [...]
>

Oh, drats. I suppose my yelping tool doesn't notice this kind of change in
particular.

I suppose I'll compare before/after of my .ir files and use that to
identify which cases change.

Good spot.

--0000000000001e751c064d7acbff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Mar 20, 2026, 10:23=E2=80=AFAM Markus Armbrust=
er &lt;<a href=3D"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"norefe=
rrer">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" rel=3D"noreferrer nor=
eferrer" target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Note that with &quot;Since&quot; being moved to the last position, we =
open up a<br>
&gt; good many new cases of ambiguos intro-vs-details text which must be<br=
>
&gt; corrected with &quot;Details:&quot; tags.<br>
&gt;<br>
&gt; This patch doesn&#39;t only add these markers where it would definitiv=
ely<br>
&gt; impact inlining - it adds them to *any* doc block that has more than o=
ne<br>
&gt; paragraph of plaintext and no other distinguishing features (members,<=
br>
&gt; features, errors, returns).<br>
&gt;<br>
&gt; It may well be the case that not every last one of these *needs* to be=
<br>
&gt; amended in this way, but this is the broad coverage shotgun approach<b=
r>
&gt; that demonstrates which places in the code may cause footguns with<br>
&gt; regards to automated stub insertions of members/arguments/etc, returns=
,<br>
&gt; or inlining order ambiguities.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" rel=
=3D"noreferrer noreferrer" target=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
[...]<br>
<br>
&gt; diff --git a/qapi/accelerator.json b/qapi/accelerator.json<br>
&gt; index d333a772384..5624b5d88b7 100644<br>
&gt; --- a/qapi/accelerator.json<br>
&gt; +++ b/qapi/accelerator.json<br>
&gt; @@ -29,12 +29,12 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Return information about KVM acceleration<br>
&gt;=C2=A0 #<br>
&gt; -# Since: 0.14<br>
&gt; -#<br>
&gt;=C2=A0 # .. qmp-example::<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;query-kv=
m&quot; }<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;return&quot;: { &quot;enabled=
&quot;: true, &quot;present&quot;: true } }<br>
&gt; +#<br>
&gt; +# Since: 0.14<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;command&#39;: &#39;query-kvm&#39;, &#39;returns&#39;: &#3=
9;KvmInfo&#39; }<br>
&gt;=C2=A0 <br>
<br>
Rendered output changes unexpectedly from<br>
<br>
=C2=A0 =C2=A0 Command query-kvm (Since: 0.14)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Return information about KVM acceleration<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Return:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 KvmInfo<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Example::<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt; { &quot;execute&quot;: &quot;query=
-kvm&quot; }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;- { &quot;return&quot;: { &quot;enab=
led&quot;: true, &quot;present&quot;: true } }<br>
<br>
to<br>
<br>
=C2=A0 =C2=A0 Command query-kvm (Since: 0.14)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Return information about KVM acceleration<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Example::<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt; { &quot;execute&quot;: &quot;query=
-kvm&quot; }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;- { &quot;return&quot;: { &quot;enab=
led&quot;: true, &quot;present&quot;: true } }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Return:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 KvmInfo<br>
<br>
I guess the &quot;Since:&quot; quietly serves as separator between INTRO an=
d<br>
DETAILS before the patch, and the patch is missing a DETAILS: line.<br>
<br>
Several more instances follow.<br>
<br>
[...]<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Oh, drats. I suppose my yelping tool doesn&#39;t notice this kind of c=
hange in particular.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I s=
uppose I&#39;ll compare before/after of my .ir files and use that to identi=
fy which cases change.</div><div dir=3D"auto"><br></div><div dir=3D"auto">G=
ood spot.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"=
gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000001e751c064d7acbff--


