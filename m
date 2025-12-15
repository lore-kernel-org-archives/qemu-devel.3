Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA442D5B85E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 17:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVCgu-0000Oy-N5; Mon, 15 Dec 2025 12:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcmorcos@google.com>)
 id 1vVCgs-0000Ob-W6
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:48:59 -0500
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcmorcos@google.com>)
 id 1vVCgr-0005bJ-9B
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:48:58 -0500
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-559748bcf99so2962697e0c.3
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 09:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765820935; x=1766425735; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FI7UcnmRmSjYBv7OLwGuk+M9ZTcTnewwPCw0e97p1Ek=;
 b=E2F2Q1+RACB+9g0CqItAaOkrE0PSfKxfUJboNnDawI4qAhhDLVD2LzIntVA7LI8KGR
 aUFv14qbXmV6P5wTdYuquWUhRyvpIY2CMMFdB5Xy6AdUYyKUdY6Rh4XWhW8W8eHvTJ2d
 BHHpWamW5vh0Fw84cWa1Lj6Yg3R+TcTSWs4dGRqWpfTcPlkY3SB4REo5WpnXqdZ8LBPl
 01/47/ERp3n+T2UVAnyHOHBBxbIVxfKdZXV79c2Bf4poijE8dqbyxVox4Fd9SByP8Qjv
 aN97Vif80jtRRHZ6EWdO+xlnBI3GQB+n5fGPz9OY8vGExF6IEvSy1GQxgUAv/zQ2131e
 /F0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765820935; x=1766425735;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FI7UcnmRmSjYBv7OLwGuk+M9ZTcTnewwPCw0e97p1Ek=;
 b=Z9JtHBw/t1msNiVoQU0c/HwOT3pu35mNSW3BmhZLVMazN5vvH+ltsamLj3ULUyLe/S
 io4H6R33LCP9KY176JrfMwmbfIj9Y+CC3PdSEcfbtRWXFWxO6OpZtszDIpCCcCMu4tge
 WNZWC81ACx6+a086lAMfKwHIspvYOABz379GNZ/0/1igXsO6A4+6tVqYZMbvvS0VwVSI
 wULVAqIYUu1rMMinxRHlHhjEPJWJZASGHzeC6nmphmcbDpvuCWA5b/7z3fiHcpSY4YxS
 n2VoBbtWBryUNzY19B9jOSbVuhv0SIm/FiYjqDXbAEA1RMx5fXyQdAxMWepHHT3AOfIn
 OqWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1UFbgYhSmbFgyObRirhvCXdv0rE8Lc3Z1tKWQgCDPaa+9wQ1LY2vZ+X9haSnbx2rAS4sle4ylF0i4@nongnu.org
X-Gm-Message-State: AOJu0YwnI/zbGioDnu7/CWjFIY2who3F/zZ5XJbXKIIQ1wg2EQ/9OT1Q
 xJAS1WIegxVvlx6F8ynzyG8fU3S51xRB179uaAXDI4QuW12CD65P2VveHIAcXEkGcLiXYxGq7b2
 dfO3PgmnkDnxqjCstmWLh6LJXXYeGBP8OAML8G8HW
X-Gm-Gg: AY/fxX5ulUPiF85d/5a3w3BNZIDHTHHRql3Ert9q25cx/20BKshWXL7BJwMtg/m16T8
 3m/j9hJkspJiaeY/GMa/tPwi8Mrkh63vXDI/rO9rb0xrToN8LbEX7zbaLw27FU0tLhNV5BeNjpL
 ezQxKC4hqL0GLG2s94iP74WgwMHBL+1XerqSd3YZa5kKm4uHRkWE6OhnMHVcWLmW/ZSfTQKJs0l
 VDudMVjXcCJ+37wLSIibhxboHExbewQNVhGSHQRXn0Y8AFowssHeNpwk4VVvOpbEy7oHJpzuRbE
 MIsl8m1TfBkjSJdr5oqnJlcv4J6kF8Byog==
X-Google-Smtp-Source: AGHT+IHKEJlRG8kkwtcr6RV2KjC4mYeyWDGbR77XR3Y7OLZ5xj5OV7KZUS1WDfYBU2SjUy286UEmqrBJ4QHPv/nqY/M=
X-Received: by 2002:a05:6122:2a10:b0:559:7077:9a8f with SMTP id
 71dfb90a1353d-55fed5887b3mr3595793e0c.5.1765820935061; Mon, 15 Dec 2025
 09:48:55 -0800 (PST)
MIME-Version: 1.0
References: <20251213001443.2041258-1-marcmorcos@google.com>
 <20251213001443.2041258-4-marcmorcos@google.com>
 <b6f193d4-b780-439a-80eb-bb8b43acac4e@redhat.com>
In-Reply-To: <b6f193d4-b780-439a-80eb-bb8b43acac4e@redhat.com>
From: Marc Morcos <marcmorcos@google.com>
Date: Mon, 15 Dec 2025 09:48:46 -0800
X-Gm-Features: AQt7F2q46qGvfJHP5RGbzhCj-urSqFZcDzlJTa7Pgdiy1-vh4lnoI_-5tazn-dI
Message-ID: <CACKn2CzdT3SxgjgZJQcvuC4j3EVDcvkmFGm_qW18yU6gwRRJ7w@mail.gmail.com>
Subject: Re: [PATCH 3/4] qmp: Fix thread race
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000930b2c06460139a3"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=marcmorcos@google.com; helo=mail-vk1-xa34.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--000000000000930b2c06460139a3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, that looks correct. Thanks!

- Marc

On Mon, Dec 15, 2025, 6:52=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> w=
rote:

> On 12/13/25 01:14, Marc Morcos wrote:
> > @@ -346,7 +347,15 @@ static void monitor_qapi_event_emit(QAPIEvent
> event, QDict *qdict)
> >           }
> >
> >           qmp_mon =3D container_of(mon, MonitorQMP, common);
> > -        if (qmp_mon->commands !=3D &qmp_cap_negotiation_commands) {
> > +        do_send =3D false;
> > +
> > +        WITH_QEMU_LOCK_GUARD(&mon->mon_lock) {
> > +            if (qmp_mon->commands !=3D &qmp_cap_negotiation_commands) =
{
> > +                do_send =3D true;
> > +            }
> > +        }
> > +
> > +        if (do_send) {
> >               qmp_send_response(qmp_mon, qdict);
> >           }
> >       }
>
> We cannot use WITH_QEMU_LOCK_GUARD with "continue" or "break" inside,
> but we can use QEMU_LOCK_GUARD:
>
> @@ -347,17 +346,13 @@ static void monitor_qapi_event_emit(QAPIEvent
> event, QDict *qdict)
>           }
>
>           qmp_mon =3D container_of(mon, MonitorQMP, common);
> -        do_send =3D false;
> -
> -        WITH_QEMU_LOCK_GUARD(&mon->mon_lock) {
> -            if (qmp_mon->commands !=3D &qmp_cap_negotiation_commands) {
> -                do_send =3D true;
> +        {
> +            QEMU_LOCK_GUARD(&mon->mon_lock);
> +            if (qmp_mon->commands =3D=3D &qmp_cap_negotiation_commands) =
{
> +                continue;
>               }
>           }
> -
> -        if (do_send) {
> -            qmp_send_response(qmp_mon, qdict);
> -        }
> +        qmp_send_response(qmp_mon, qdict);
>       }
>   }
>
>
> Let me know if this is okay for you!
>
> Paolo
>
>

--000000000000930b2c06460139a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><span class=3D"smart_draft_text">Yes, that looks correct.=
 Thanks!<br><br>- Marc</span></div><br><div class=3D"gmail_quote gmail_quot=
e_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 15, 2025, 6:=
52=E2=80=AFAM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbon=
zini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 1=
2/13/25 01:14, Marc Morcos wrote:<br>
&gt; @@ -346,7 +347,15 @@ static void monitor_qapi_event_emit(QAPIEvent eve=
nt, QDict *qdict)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qmp_mon =3D container_of(mon, =
MonitorQMP, common);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qmp_mon-&gt;commands !=3D &amp;qmp_ca=
p_negotiation_commands) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_send =3D false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 WITH_QEMU_LOCK_GUARD(&amp;mon-&gt;mon_loc=
k) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qmp_mon-&gt;commands !=
=3D &amp;qmp_cap_negotiation_commands) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_send =3D t=
rue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (do_send) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qmp_send_respons=
e(qmp_mon, qdict);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
We cannot use WITH_QEMU_LOCK_GUARD with &quot;continue&quot; or &quot;break=
&quot; inside, <br>
but we can use QEMU_LOCK_GUARD:<br>
<br>
@@ -347,17 +346,13 @@ static void monitor_qapi_event_emit(QAPIEvent <br>
event, QDict *qdict)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_mon =3D container_of(mon, MonitorQMP=
, common);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_send =3D false;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 WITH_QEMU_LOCK_GUARD(&amp;mon-&gt;mon_lock) {<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qmp_mon-&gt;commands !=3D &a=
mp;qmp_cap_negotiation_commands) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_send =3D true;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QEMU_LOCK_GUARD(&amp;mon-&gt;mon=
_lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qmp_mon-&gt;commands =3D=3D =
&amp;qmp_cap_negotiation_commands) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (do_send) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_send_response(qmp_mon, qdict=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_send_response(qmp_mon, qdict);<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 }<br>
<br>
<br>
Let me know if this is okay for you!<br>
<br>
Paolo<br>
<br>
</blockquote></div>

--000000000000930b2c06460139a3--

