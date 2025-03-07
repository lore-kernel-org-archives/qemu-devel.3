Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563A8C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqgXK-0001P7-Sj; Fri, 07 Mar 2025 17:51:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqgXH-0001Oo-C6
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:51:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqgXF-00012S-Sc
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741387875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GK1QJER+uSR3wqOy6SlkOawTyE8X+5phzqXa6+OqlD4=;
 b=YcvyZ9doS8ZWSoSbTxjpWFXqcK+JpH13b9VuRAkvcAVhkva2V2HbkYBA0AI9jZAseXUczd
 aIcGKCvccNfKQEDbSvpYYS68MLfEGui7vQKxAQxasCFi5K9+1KIP4b5XQFtRumn4hy/fUz
 OftjZNKGkegmbGmqp5xAlmsBYE8k7qI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-DT2jfQRCPDWzVgMN_Lnl2w-1; Fri, 07 Mar 2025 17:51:11 -0500
X-MC-Unique: DT2jfQRCPDWzVgMN_Lnl2w-1
X-Mimecast-MFC-AGG-ID: DT2jfQRCPDWzVgMN_Lnl2w_1741387870
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ff68033070so3969051a91.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:51:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741387870; x=1741992670;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GK1QJER+uSR3wqOy6SlkOawTyE8X+5phzqXa6+OqlD4=;
 b=RZ8lu69ttPJQ8lygVHbiuCdV/XzRf/9J4ENhYqDzfO4jIih9xZbZraE4KK5IUDNegb
 ZV9iu0dChSm9IbbPhei5SJKbu0kqyhr9oJ7njU5rDQXbnM9vVTdWZ625R8g9jQIuFYxj
 B95qsPF2g6Xk+xexWR4jwPGwN1unSLdwQefb5IjhYtNCwRNTnmCKdLuVLl/u2P3f3rvC
 auV+jrP4z0F+RbfUIPlwAJt8lywPxFvXWgAgIGASlKauCupDcEyAEpBaXHW+54gixthc
 fRza8TsP+/sbnUfVstAR9F5SCvbZo1o41JzMmsYjxjWLQvYy3mZ56Nln6LsuxrRXPDAl
 60aA==
X-Gm-Message-State: AOJu0YyzQoJ0vfeczeYBlnqw1+uzWVVDYPQC6FNr9Grp1QlqaZN2mwOh
 uGTKx45rZtQCpFKOqTao0kM8cc/9sEYkZNDziYLwRjikwjScqqju/W3LbuJIhLr7y1EpNKlQH45
 vzfQn0n+sBT/8htgRV93Zl8ZzlnamN2wSMTZQa2nFLzsLabW2yS8p5rRCCoWSiCWdh8JWxYCH2u
 e/fTgzwnjuUERNrwh3yKJCfmaONSc=
X-Gm-Gg: ASbGncugZqUJABQClb+EaIWdmcdyJCSG0EvbjZ3tvgNcahifyYgPlwf4b++xMvHVTH+
 1d7nWgUymJY33PvQvlJxtGswAIxN4C6GwgGlLXF0N9p0ScIrGSR+SWBmzOb8/VollnDrRag==
X-Received: by 2002:a17:90a:ec8b:b0:2fe:99cf:f579 with SMTP id
 98e67ed59e1d1-2ff7ce657b0mr7712089a91.4.1741387870268; 
 Fri, 07 Mar 2025 14:51:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnfZaJM/jCd1/kK4l1SbkfZlDEEALwID1La2P38TGNHVNM5l1tKDPUD76kr3ydRbd2q4PaK9IurWKI6+zyOp8=
X-Received: by 2002:a17:90a:ec8b:b0:2fe:99cf:f579 with SMTP id
 98e67ed59e1d1-2ff7ce657b0mr7712070a91.4.1741387870004; Fri, 07 Mar 2025
 14:51:10 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-16-jsnow@redhat.com>
 <871pv9qo0u.fsf@pond.sub.org>
In-Reply-To: <871pv9qo0u.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 7 Mar 2025 17:50:57 -0500
X-Gm-Features: AQ5f1JqP1YsrPfH7n-bbmA9Kj51o5y6Ni7HaN2n6hG2DDuLHaHk9m5n1PZpuuiE
Message-ID: <CAFn=p-b-R9AORQ2OWj5-MTEzC2m5iyQoWYisJ_Tp1Xk4DZcMjw@mail.gmail.com>
Subject: Re: [PATCH 15/57] docs/qapi-domain: add "Errors:" field lists
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000068895f062fc87510"
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

--00000000000068895f062fc87510
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 2:48=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > ``:error: descr`` can now be used to document error conditions. The
> > format of the description is not defined here; so the ability to name
> > specific types is left to the document writer.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> By convention, the description is a bullet list, but we don't enforce
> that in software.  Observation, not a suggestion to start enforcing it
> now.
>

Right. This commit message is accurate, though: this field list type will
accept any old thing. I have an idea to fix this to make the aesthetics
better (fixes the misalignment) and to enforce the bulleted list in one
shot. Not for this series, sorry. Please accept a raincheck.

--00000000000068895f062fc87510
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 7, =
2025 at 2:48=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; ``:error: descr`` can now be used to document error conditions. The<br=
>
&gt; format of the description is not defined here; so the ability to name<=
br>
&gt; specific types is left to the document writer.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
By convention, the description is a bullet list, but we don&#39;t enforce<b=
r>
that in software.=C2=A0 Observation, not a suggestion to start enforcing it=
<br>
now.<br></blockquote><div><br></div><div>Right. This commit message is accu=
rate, though: this field list type will accept any old thing. I have an ide=
a to fix this to make the aesthetics better (fixes the misalignment) and to=
 enforce the bulleted list in one shot. Not for this series, sorry. Please =
accept a raincheck.</div><div>=C2=A0</div></div></div>

--00000000000068895f062fc87510--


