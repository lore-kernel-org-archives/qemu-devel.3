Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F945C282D1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 16:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp8jI-0007FN-5F; Mon, 03 Mar 2025 11:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pefoley@google.com>)
 id 1tp8is-0006ru-0s
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 11:32:56 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pefoley@google.com>)
 id 1tp8il-0007yL-SG
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 11:32:52 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2c11ddc865eso1109760fac.3
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 08:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1741019563; x=1741624363; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A2xcNRNJae2FH3uMsH3kGbGXwUWLrPgf/nnan00/M88=;
 b=VggGX9fgnsB0kE8Y+gwiaj53yPBp70RMhFsqD8TWiENWlYmD0pZ+JUbHWe2/xDw5rz
 Y7jHmXkg19vGmvuh3V5ITU9VZ4YQzL0jTinTjEjg16nq0JDAd8jrwS66wWiV0xMeoScf
 ptQn75IwOpKBj2hPPOIpv05MVXHUSDn1fEtbqPyq/Zi+2UYW28npcKPxQmZ34sXRBqqz
 /98jWkwSnKlIOINoicA0doH9aTvKZmRzw8O0WfmZiWcaGKfq2HFHAUetbvN7ZPV/ZoL4
 VJmhtDnDgTRlAe0qVPjZXfni/E/+6WlFJ7k3DNgl2Z0pGwz7FUSDDYrClsFJr7q8Od7P
 4fyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741019563; x=1741624363;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A2xcNRNJae2FH3uMsH3kGbGXwUWLrPgf/nnan00/M88=;
 b=S71Rn41XKh2u417LAWbwPSovBt6xoxtnHA6P6Tm0dE7/F3U9ZSKsAp5/IMbG8sw/GY
 MHzaLKlCHGBDhgmgq+j8txdQBj2F5QxFD+4tWcCUEU+DwzlBCvQLFwovIx+7zor2FF6o
 0TuV/AI45moT4ya/x4Meb+E6ZkexNhKooaFTodnSUfS5D8RMV4a1wIzR0xIqPxbudjwO
 hQVZO1I4bM5WXha361cWO/Xk0p/p/P7O9+Xr4mwUln5zUPcZZJFC9Nsd8suFFrc0Us7C
 5KoL0Ic0lSZBU8AhpkAHXmkwD1RP4gipwfzfBTGaG7jg+M8vU037hVRWeY8RpOX83X5f
 F1FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0bAoNe/NR0+lkgXCymnFJIPRyOWNYwsLSU8c8O3DFwu2q0C3szKSTrr0GEKK8SanKfftisbQg5KrV@nongnu.org
X-Gm-Message-State: AOJu0YwIlaWqBMDOlvV/doAwUTkF+V94UTH4N/FeoIbnOZZYsw+cqXdR
 3k9cDqyNXeuIUgOoBn1kPhAELkkAmIzs8bAIbRlrUtxVElCJyHVPDVJS5OlspzaPsyKZ2VFc0hS
 fNGYXsOEtYbM7uszoJz34sgEy2OuccwqoE4gm
X-Gm-Gg: ASbGnctwpaXQCCLLw+YiJvtWzNdGDm1c2a6SpmG3TcIu6TX+6809nWFbQOxK6hhqjqr
 uY1TKtu2HH/tRxaDCx2YVtxQf6RUONn71ihs17sOOwzgaIhHBgIrKTPqdy1028ysiOPyMI3uhma
 i0Hbe1+xpttwjafj/1lhwdEACl/I125f3LOaZj2B7ixkjMujDdRgSyM4w=
X-Google-Smtp-Source: AGHT+IG6Vi9YpNkCB3aSPfIzPfI38FpwkWeL6dTzcWJEG4z1/HBeOYdPHfHmk3Cepkr8NbphAymBnskHK91hCRFAlQ8=
X-Received: by 2002:a05:6870:44cb:b0:2c1:9a53:83c4 with SMTP id
 586e51a60fabf-2c19a53b8a9mr5457042fac.26.1741019562688; Mon, 03 Mar 2025
 08:32:42 -0800 (PST)
MIME-Version: 1.0
References: <20250228212039.1768614-1-venture@google.com>
 <fc1f2750-f4c7-419f-b667-301fb0bb2edf@redhat.com>
 <87frjxcjea.fsf@pond.sub.org>
In-Reply-To: <87frjxcjea.fsf@pond.sub.org>
From: Peter Foley <pefoley@google.com>
Date: Mon, 3 Mar 2025 11:32:31 -0500
X-Gm-Features: AQ5f1JoYbxKZH2TIl8fEQQQZuZgpHHNFkgPP-RzcqPYRSvH35zIrgn-Lxc5LI2Q
Message-ID: <CAAAKUPOmAHht=HgNzKvLPinfXJbWjqp=AnmQDwBEbcNFUaOetg@mail.gmail.com>
Subject: Re: [PATCH] util/keyval: fix msan findings
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Patrick Venture <venture@google.com>,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000953fed062f72b40c"
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=pefoley@google.com; helo=mail-oa1-x2f.google.com
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

--000000000000953fed062f72b40c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 1, 2025 at 2:14=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > On 2/28/25 22:20, Patrick Venture wrote:
> >> From: Peter Foley <pefoley@google.com>
> >> e.g.
> >> qemu: Uninitialized value was created by an allocation of
> 'key_in_cur.i' in the stack frame
> >> qemu: #0 0xaaaac49f489c in keyval_parse_one
> third_party/qemu/util/keyval.c:190:5
> >> Signed-off-by: Peter Foley <pefoley@google.com>
> >> Signed-off-by: Patrick Venture <venture@google.com>
> >
> > This is not a fix, since there's no bug to fix.  It's just the tool
> complaining about something it can't reason on.
> >
> > Paolo
>
> The code is designed to read @keyval_in_cur only in non-first iterations
> of the loop.  The previous iteration assigned to it then.
>
> The two lines you quoted don't make sense to me.  Is this the full
> report you got?  If not, show us the full report, please.  Ideally with
> a reproducer.
>

The full output looks like:

Uninitialized bytes in strlen at offset 0 inside [0xffffd1958110, 5)
=3D=3D9780=3D=3DWARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0xaaaac1c4b170 in tdb_hash third_party/qemu/qobject/qdict.c:46:31
    #1 0xaaaac1c4b4a4 in qdict_get third_party/qemu/qobject/qdict.c:164:36
    #2 0xaaaac1c78468 in keyval_parse_put third_party/qemu/util/keyval.c:15=
2:11
    #3 0xaaaac1c77740 in keyval_parse_one third_party/qemu/util/keyval.c:29=
5:10
    #4 0xaaaac1c77740 in keyval_parse_into third_party/qemu/util/keyval.c:5=
30:13
    #5 0xaaaaba2f9524 in qemu_init third_party/qemu/system/vl.c:3322:21
    #6 0xaaaab9641c2c in main third_party/qemu/system/main.c:54:5
    #7 0xffffba320000 in __libc_start_main
(/usr/grte/v5/lib64/libc.so.6+0x61000) (BuildId:
613d20d3b812b4c87fe9ebf8c4caae83)
    #8 0xaaaab934bd10 in _start
/usr/grte/v5/debug-src/src/csu/../sysdeps/aarch64/start.S:92

  Uninitialized value was created by an allocation of 'key_in_cur.i'
in the stack frame
    #0 0xaaaac1c7708c in keyval_parse_one third_party/qemu/util/keyval.c:19=
0:5
    #1 0xaaaac1c7708c in keyval_parse_into third_party/qemu/util/keyval.c:5=
30:13

SUMMARY: MemorySanitizer: use-of-uninitialized-value
third_party/qemu/qobject/qdict.c:46:31 in tdb_hash
Exiting


I don't have an easily shareable reproducer, but it's probably possible to
whip one up.



>
> >> ---
> >>  util/keyval.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> diff --git a/util/keyval.c b/util/keyval.c
> >> index a70629a481..f33c64079d 100644
> >> --- a/util/keyval.c
> >> +++ b/util/keyval.c
> >> @@ -187,7 +187,7 @@ static const char *keyval_parse_one(QDict *qdict,
> const char *params,
> >>  {
> >>      const char *key, *key_end, *val_end, *s, *end;
> >>      size_t len;
> >> -    char key_in_cur[128];
> >> +    char key_in_cur[128] =3D {};
>
> Suspect overkill.  Would "" do?
>

It appears to resolve the complaint, yes.

--000000000000953fed062f72b40c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Sat, Mar 1, 2025 at 2:14=E2=80=AFAM Ma=
rkus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com<=
/a>&gt; wrote:</div><div class=3D"gmail_quote gmail_quote_container"><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Paolo Bonzini &lt;<a href=3D"ma=
ilto:pbonzini@redhat.com" target=3D"_blank">pbonzini@redhat.com</a>&gt; wri=
tes:<br>
<br>
&gt; On 2/28/25 22:20, Patrick Venture wrote:<br>
&gt;&gt; From: Peter Foley &lt;<a href=3D"mailto:pefoley@google.com" target=
=3D"_blank">pefoley@google.com</a>&gt;<br>
&gt;&gt; e.g.<br>
&gt;&gt; qemu: Uninitialized value was created by an allocation of &#39;key=
_in_cur.i&#39; in the stack frame<br>
&gt;&gt; qemu: #0 0xaaaac49f489c in keyval_parse_one third_party/qemu/util/=
keyval.c:190:5<br>
&gt;&gt; Signed-off-by: Peter Foley &lt;<a href=3D"mailto:pefoley@google.co=
m" target=3D"_blank">pefoley@google.com</a>&gt;<br>
&gt;&gt; Signed-off-by: Patrick Venture &lt;<a href=3D"mailto:venture@googl=
e.com" target=3D"_blank">venture@google.com</a>&gt;<br>
&gt;<br>
&gt; This is not a fix, since there&#39;s no bug to fix.=C2=A0 It&#39;s jus=
t the tool complaining about something it can&#39;t reason on.<br>
&gt;<br>
&gt; Paolo<br>
<br>
The code is designed to read @keyval_in_cur only in non-first iterations<br=
>
of the loop.=C2=A0 The previous iteration assigned to it then.<br>
<br>
The two lines you quoted don&#39;t make sense to me.=C2=A0 Is this the full=
<br>
report you got?=C2=A0 If not, show us the full report, please.=C2=A0 Ideall=
y with<br>
a reproducer.<br></blockquote><div><br></div><div>The full output looks lik=
e:<div><pre style=3D"color:rgb(0,0,0)">Uninitialized bytes in strlen at off=
set 0 inside [0xffffd1958110, 5)
=3D=3D9780=3D=3DWARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0xaaaac1c4b170 in tdb_hash third_party/qemu/qobject/qdict.c:46:31
    #1 0xaaaac1c4b4a4 in qdict_get third_party/qemu/qobject/qdict.c:164:36
    #2 0xaaaac1c78468 in keyval_parse_put third_party/qemu/util/keyval.c:15=
2:11
    #3 0xaaaac1c77740 in keyval_parse_one third_party/qemu/util/keyval.c:29=
5:10
    #4 0xaaaac1c77740 in keyval_parse_into third_party/qemu/util/keyval.c:5=
30:13
    #5 0xaaaaba2f9524 in qemu_init third_party/qemu/system/vl.c:3322:21
    #6 0xaaaab9641c2c in main third_party/qemu/system/main.c:54:5
    #7 0xffffba320000 in __libc_start_main (/usr/grte/v5/lib64/libc.so.6+0x=
61000) (BuildId: 613d20d3b812b4c87fe9ebf8c4caae83)
    #8 0xaaaab934bd10 in _start /usr/grte/v5/debug-src/src/csu/../sysdeps/a=
arch64/start.S:92

  Uninitialized value was created by an allocation of &#39;key_in_cur.i&#39=
; in the stack frame
    #0 0xaaaac1c7708c in keyval_parse_one third_party/qemu/util/keyval.c:19=
0:5
    #1 0xaaaac1c7708c in keyval_parse_into third_party/qemu/util/keyval.c:5=
30:13

SUMMARY: MemorySanitizer: use-of-uninitialized-value third_party/qemu/qobje=
ct/qdict.c:46:31 in tdb_hash
Exiting</pre></div></div><div><br></div><div>I don&#39;t have an easily sha=
reable reproducer, but it&#39;s probably=C2=A0possible to whip one up.</div=
><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 util/keyval.c | 2 +-<br>
&gt;&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;&gt; diff --git a/util/keyval.c b/util/keyval.c<br>
&gt;&gt; index a70629a481..f33c64079d 100644<br>
&gt;&gt; --- a/util/keyval.c<br>
&gt;&gt; +++ b/util/keyval.c<br>
&gt;&gt; @@ -187,7 +187,7 @@ static const char *keyval_parse_one(QDict *qdi=
ct, const char *params,<br>
&gt;&gt;=C2=A0 {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 const char *key, *key_end, *val_end, *s, *end;=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 size_t len;<br>
&gt;&gt; -=C2=A0 =C2=A0 char key_in_cur[128];<br>
&gt;&gt; +=C2=A0 =C2=A0 char key_in_cur[128] =3D {};<br>
<br>
Suspect overkill.=C2=A0 Would &quot;&quot; do?<br></blockquote><div><br></d=
iv><div>It appears to resolve the complaint, yes.=C2=A0</div></div></div>

--000000000000953fed062f72b40c--

