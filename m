Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A152C28B25
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 23:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqgjA-00082K-SV; Fri, 07 Mar 2025 18:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqgiz-0007y2-1v
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 18:03:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqgiw-0006IM-FB
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 18:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741388600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=guy+HeO9t29cM14PvusNvEniYA3xFxX+eW0oeZNPuFQ=;
 b=GoRZyMxYzVWcROOvl9MnotuPhEMVQO8I/H7Y48Y9OTNBddXQYjHBQeqPYVQo4/9eVVHL0T
 yMtcyNjnrRSzJZa4mYMoQMvXpptH1Hc1sgfrPVd06MafLXR22cgesBm8p1OluCDLAJ03/A
 CZEOTcHpyRLo+DfvhNzXOjjthqi8tKM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-wCJLer1DOV-ESzau776RDQ-1; Fri, 07 Mar 2025 18:03:17 -0500
X-MC-Unique: wCJLer1DOV-ESzau776RDQ-1
X-Mimecast-MFC-AGG-ID: wCJLer1DOV-ESzau776RDQ_1741388596
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-22107b29ac3so35495425ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 15:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741388596; x=1741993396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=guy+HeO9t29cM14PvusNvEniYA3xFxX+eW0oeZNPuFQ=;
 b=LR37snx52GQ4dXPZfa3hyM5qLW9U972WJK0Vi/XhEHcsDH9CxS+rODBzuSIU3zDUZB
 MV2ZUl+mMLWDVjv/PtuuKApFkHQDES5IjPa4Zf3O7xmppU63QkTOXjZJLZhAJD31CmcK
 KJfGv+/tc66wbauv/W5gQ5edjc6HtRzcRV6M/jpfXNdp/ubM5Aj0yfXADdvpg3QkrxGY
 zEA9WQlM1up7tczdTrdNrn/y2KmRUZFNbZt46iKBD9VT4autoaJhannLa+yL002DyguO
 6kAAaEYrolQfVBzZLdQFA2X0rRPypajE9VEqqMruj/cvUTmYL+Ld5TSqz3wYN0pY397l
 RkdQ==
X-Gm-Message-State: AOJu0Yw/JmRQ742rdfPNnV3zttdkyqDgS+Z2J1PI9vLdCZU/AO669k8+
 tlIUkZdYXq6neDZ7DXn41XZwnBWrSysAnMNsES7Q+u/cAUAR0xiu8vyEM5o89sH6gmnJmKBSeeG
 Mk8m0y7Tm0iuPReVclpPyXFFQkXbuHiBCcYIJzM6rrvJox3QoQWG7cB0N38zRqKPHPd2njxUU3X
 I6VI+WiTfvfs9RJeTl1o5OfK/k4kg=
X-Gm-Gg: ASbGnctgKv3GZQZPsGSCvF9Hu0Hpktq59rLXgFp/DTEQuCAkZ5GpJ7RjHqIhE2rZykD
 +1bqyXrVjGdrB1hNEmpXsxnFbgfypJaMTlqqjoqVGy3tvTpjP2GivVmB19IY83jBTyQNbTg==
X-Received: by 2002:a17:903:32c7:b0:224:24d3:60fb with SMTP id
 d9443c01a7336-2244f06e31dmr20173485ad.10.1741388596402; 
 Fri, 07 Mar 2025 15:03:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHadOT8T3kPDTP+ZyQ0AQeKeKp9Uh++eExOD5wzZwWq7BJMIk/VlLx8kW51fcHT4zXNjKbhJUI4TwHmFVeae6Y=
X-Received: by 2002:a17:903:32c7:b0:224:24d3:60fb with SMTP id
 d9443c01a7336-2244f06e31dmr20173145ad.10.1741388596106; Fri, 07 Mar 2025
 15:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-19-jsnow@redhat.com>
 <87a59xnny6.fsf@pond.sub.org>
In-Reply-To: <87a59xnny6.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 7 Mar 2025 18:02:57 -0500
X-Gm-Features: AQ5f1JpG1ATUBqObfszIyZzJk0vi2XKzzxPAQhToidEblHeXlMxct7ncjxo_h0g
Message-ID: <CAFn=p-Y1YkZaG1=E_QGT93EMpiqjkXbq1_jV3GL9ONLt6J05Sg@mail.gmail.com>
Subject: Re: [PATCH 18/57] docs/qapi-domain: add qapi:alternate directive
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000aff2bc062fc8a058"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000aff2bc062fc8a058
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 5:18=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Add the .. qapi:alternate:: directive, object, and qapi:alt:`name`
> > cross-reference role.
> >
> > Add the "Choices:" field list for describing alternate choices. Like
> > other field lists that reference QAPI types, a forthcoming commit will
> > add cross-referencing support to this field.
>
> Nothing wrong with the term "choices" per se, but
> docs/devel/qapi-code-gen.rst and the Python code call these things
> "alternatives".  I'd prefer consistency.  Could be done as a follow-up
> if that's more convenient for you.
>

Done. (Wish you'd said so sooner, though.)


>
> > RFC: In the future, it would be nice to directly inline Alternates as
> > part of the type information in the containing object (i.e. directly in
> > arguments/members) - but that's a task for another series.
>
> Does it make sense to talk about future inlining projects when we
> haven't even gotten to the present one, yet?
>

Vestigial, byebye.


>
> >                                                            For now, the
> > branch "names" are documented just like qapidoc.py does, even though
> > this information is superfluous for user documentation. Room for future
> > improvement, but not now.
>
> Same as before.  Good enough!
>
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
>

--000000000000aff2bc062fc8a058
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 7, =
2025 at 5:18=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Add the .. qapi:alternate:: directive, object, and qapi:alt:`name`<br>
&gt; cross-reference role.<br>
&gt;<br>
&gt; Add the &quot;Choices:&quot; field list for describing alternate choic=
es. Like<br>
&gt; other field lists that reference QAPI types, a forthcoming commit will=
<br>
&gt; add cross-referencing support to this field.<br>
<br>
Nothing wrong with the term &quot;choices&quot; per se, but<br>
docs/devel/qapi-code-gen.rst and the Python code call these things<br>
&quot;alternatives&quot;.=C2=A0 I&#39;d prefer consistency.=C2=A0 Could be =
done as a follow-up<br>
if that&#39;s more convenient for you.<br></blockquote><div><br></div><div>=
Done. (Wish you&#39;d said so sooner, though.)</div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; RFC: In the future, it would be nice to directly inline Alternates as<=
br>
&gt; part of the type information in the containing object (i.e. directly i=
n<br>
&gt; arguments/members) - but that&#39;s a task for another series.<br>
<br>
Does it make sense to talk about future inlining projects when we<br>
haven&#39;t even gotten to the present one, yet?<br></blockquote><div><br><=
/div><div>Vestigial, byebye.</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 For now,=
 the<br>
&gt; branch &quot;names&quot; are documented just like qapidoc.py does, eve=
n though<br>
&gt; this information is superfluous for user documentation. Room for futur=
e<br>
&gt; improvement, but not now.<br>
<br>
Same as before.=C2=A0 Good enough!<br>
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div>

--000000000000aff2bc062fc8a058--


