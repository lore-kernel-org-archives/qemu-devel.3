Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3329BC83000
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Jun 2025 02:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVhf5-00009K-Ph; Sat, 28 Jun 2025 22:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <micro6947@gmail.com>)
 id 1uVhf0-000091-2u
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 22:20:51 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <micro6947@gmail.com>)
 id 1uVhey-0006fC-6N
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 22:20:49 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-747c2cc3419so3453186b3a.2
 for <qemu-devel@nongnu.org>; Sat, 28 Jun 2025 19:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751163646; x=1751768446; darn=nongnu.org;
 h=to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ctDS3yUrrzq8mSm1jN0BsJvpGJzKTs2nrDhWg8mL3KI=;
 b=IuEiXj3EzJ4ea7/yfHe5/pTwT3pzS9v0/y+0xEL8OtyJ/nYG3OzRrEEZrhnzWb+cSX
 hGs7GOkEhKmHs72PZPWoy7KlE5WMrxlWI48P32a0XCFifo6XZnCOohn6pBeBGiiks2Xd
 7MqzB6oJJ7LtB8beEfI8Js53jWMWeNPiMuaQVwmOocFmJc3ypFsdIO4Yr9FtNEOsVDEB
 ljKY0a/L6tMUu/i+Tz3lcT19yMVBGNJDmLeYklwvMKnRQFN5Ycc+4RY4lxtLURVv06Hf
 uqR61NntUfSvc7XXjDSEt53ZrHybwFqwCbgz+mSIcoJcPKPkXZkYcUL/h1hs/KEo3vEf
 1p6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751163646; x=1751768446;
 h=to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ctDS3yUrrzq8mSm1jN0BsJvpGJzKTs2nrDhWg8mL3KI=;
 b=EKeNWTA7WMHETm5XrYkB3FqwV523G7yNYtANzb95yJIBuA8cjngvvWSSvUGH4/tSAQ
 G75c1H8iNGODMhYKYeCQMQHrpqWN6bgYv2W/oyeHxsCfkdXmPRWP7/YqTlX/Xsjf2/kD
 IRnw/xqJQeHk5LkYMbNMJXBkyRcq72LGuLUYpNV4APB6bweC7q1v6JTplsIZGhl3OTao
 EYa3nc3PAYjkWXTdTz8dpIN+N3WgZwbhy8srEkj2DMhckSD3mKW/37i/BvXf3+ZTDVQE
 5VVkAyU/Jyd12Hnv2CwWS+mMmaI+EL77tOvTzNmv5zZF6ItsinlI4Hz32agwgITsE3yv
 Dk0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5NA54XMPn9BukgXQfCkk2B8xJiwxdEG9Q02JLnJMafPQmfa3hOadnlz1iQYFCdMtj5AQOZmDPDArO@nongnu.org
X-Gm-Message-State: AOJu0YyOsxdkaZlBe7o2Eje8XY8foFoVihZgneif5PuR3M7ovUAXGqXc
 g26TbaAA55E0ou8mkJHzHVVUhzw76wognYRf8Bwcvjg//sZo57FSiB+4VW02Gr5cGfhh3G4YLU7
 oJYv5uJz2XLUg/nrJ+VLBKevkWIs7u+E=
X-Gm-Gg: ASbGncuGIe/bmUmz5jJfSdiV38R4ZaA6qxea2vyWyiQ+FBpZCxRcdY67BG/liNHwXig
 A9XJYUfsp+9MbaNi09OqoOWebXVoxR+wQzD1p53/TLaqhhenWp2sSkjeSrYgwwAPDpN3Jx3GlAP
 2bpa9U/PTIMLJrLngtYX8ZkvNIAxQqKorcaJ35E0pDcJyC
X-Google-Smtp-Source: AGHT+IGZIYyImhFCNa8X8duoPh8DZPin+w5wHfSPp3AdTe3sFFZDdbQ8DuqtiC55ocRjNmnT7ztvM1zYOL3zUiHs3oQ=
X-Received: by 2002:a05:6a00:17a8:b0:747:ab61:e4fa with SMTP id
 d2e1a72fcca58-74af6f08162mr10863564b3a.14.1751163646192; Sat, 28 Jun 2025
 19:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250627024226.1767-1-micro6947@gmail.com>
 <87qzz46h5s.fsf@suse.de>
In-Reply-To: <87qzz46h5s.fsf@suse.de>
From: Xingjing Deng <micro6947@gmail.com>
Date: Sun, 29 Jun 2025 10:20:35 +0800
X-Gm-Features: Ac12FXwUcz1QSJGwiWXEQgyBrqj7Bh4iOPzkVYGS15XcMS9eEjakVT8zj6F28Ek
Message-ID: <CAK+ZN9q_ORcL3puNiQDs=zPagrvkZMgLquC5aWUaJZt-bT=sqQ@mail.gmail.com>
Subject: Re: [PATCH] qtest/migration: Fix potential NPD through getenv
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000001331ee0638ac8f80"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=micro6947@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLYTO_END_DIGIT=0.25, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: micro6947@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000001331ee0638ac8f80
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, thank you for getting back to me.

During my data mining, I came across the following operation:
migration_get_env, which is called after find_common_machine_version. Based
on this, I initially suspected there might be a bug. Here's the relevant
code inside  migration_get_env.

env->qemu_src =3D getenv(QEMU_ENV_SRC);
env->qemu_dst =3D getenv(QEMU_ENV_DST);

/*
 * The default QTEST_QEMU_BINARY must always be provided because
 * that is what helpers use to query the accel type and
 * architecture.
 */
if (env->qemu_src && env->qemu_dst) {
    g_test_message("Only one of %s, %s is allowed",
                   QEMU_ENV_SRC, QEMU_ENV_DST);
    exit(1);
}

However, after considering your explanation, I believe you've convinced me
otherwise. I appreciate your input, and I=E2=80=99m sorry for the delayed r=
esponse
and any inconvenience caused.

Fabiano Rosas <farosas@suse.de> =E4=BA=8E2025=E5=B9=B46=E6=9C=8828=E6=97=A5=
=E5=91=A8=E5=85=AD 04:52=E5=86=99=E9=81=93=EF=BC=9A

> xjdeng <micro6947@gmail.com> writes:
>
> Hi, thanks for the interest in fixing this. However, the analysis it not
> quite right:
>
> > In `find_common_machine_version`, the code previously assumed that
> > `getenv(var1)` and `getenv(var2)` would always return non-NULL values.
>
> That's not true. qtest_qemu_binary() has:
>
>     if (var) {
>         qemu_bin =3D getenv(var);
>         if (qemu_bin) {        <--- HERE
>             return qemu_bin;
>         }
>     }
>
> > However, if either environment variable is not set, `getenv` returns
> > NULL, which could lead to a null pointer dereference.
> >
> > Tracing upstream usage: `find_common_machine_version` is called by
> > `resolve_machine_version` with `QEMU_ENV_SRC` and `QEMU_ENV_DST`.
> > `resolve_machine_version` is used by `migrate_start`, which is called
> > by `migrate_postcopy_prepare`, and ultimately by `test_postcopy_common`=
.
> >
> > In `test_postcopy_common`, after `migrate_postcopy_prepare`, the
> > function `migrate_postcopy_complete` is called. Inside,
> > `migration_get_env` checks if `QEMU_ENV_SRC` and `QEMU_ENV_DST` are
> > set before use. Thus, these variables can be NULL, leading to a
> > potential null pointer dereference in `find_common_machine_version`.
>
> There's no dereference happening anywhere, just a g_test_message(),
> which would show "(null)".
>
> >
> > Signed-off-by: xjdeng <micro6947@gmail.com>
> > ---
> >  tests/qtest/migration/migration-util.c | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/qtest/migration/migration-util.c
> b/tests/qtest/migration/migration-util.c
> > index 642cf50c8d..45c9e164e2 100644
> > --- a/tests/qtest/migration/migration-util.c
> > +++ b/tests/qtest/migration/migration-util.c
> > @@ -203,8 +203,25 @@ char *find_common_machine_version(const char
> *mtype, const char *var1,
> >          return g_strdup(type2);
> >      }
> >
> > -    g_test_message("No common machine version for machine type '%s'
> between "
> > -                   "binaries %s and %s", mtype, getenv(var1),
> getenv(var2));
>
> I don't think we'll ever reach here in case one var is NULL. It would
> have been replaced with QTEST_QEMU_BINARY and either asserted or exited
> in the if below:
>
>     g_autofree char *type1 =3D qtest_resolve_machine_alias(var1, mtype);
>     g_autofree char *type2 =3D qtest_resolve_machine_alias(var2, mtype);
>
>     g_assert(type1 && type2);
>
>     if (g_str_equal(type1, type2)) {
>         /* either can be used */
>         return g_strdup(type1);
>     }
>
> Can you provide a test command line that exposes the issue? Something
> like:
>
> QTEST_QEMU_BINARY=3D./qemu-system-<arch> QTEST_QEMU_BINARY_DST=3D<some ot=
her
> qemu version here> ../tests/qtest/migration-test --full
>
> Thanks
>
> > +    char *varstring1 =3D getenv(var1);
> > +    char *varstring2 =3D getenv(var2);
> > +    if (varstring1 && varstring2) {
> > +        g_test_message("No common machine version for machine type '%s=
'
> "
> > +                       "between binaries %s and %s",
> > +                       mtype, varstring1, varstring2);
> > +    } else if (varstring1) {
> > +        g_test_message("No common machine version for machine type '%s=
'
> "
> > +                       "between binary %s and environment variable %s"=
,
> > +                       mtype, varstring1, var2);
> > +    } else if (varstring2) {
> > +        g_test_message("No common machine version for machine type '%s=
'
> "
> > +                       "between binary %s and environment variable %s"=
,
> > +                       mtype, varstring2, var1);
> > +    } else {
> > +        g_test_message("No common machine version for machine type '%s=
'
> "
> > +                       "between environment variables %s and %s",
> > +                       mtype, var1, var2);
> > +    }
> >      g_assert_not_reached();
> >  }
>

--0000000000001331ee0638ac8f80
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><p>Hi, thank you for getting back to me.</p>
<p>During my data mining, I came across the following operation:=C2=A0=C2=
=A0<code>migration_get_env</code>, which is called after <code>find_common_=
machine_version</code>. Based on this, I initially suspected there might be=
 a bug. Here&#39;s the relevant code inside=C2=A0=C2=A0<code>migration_get_=
env.</code></p><p><code>env-&gt;qemu_src =3D getenv(QEMU_ENV_SRC);<br>env-&=
gt;qemu_dst =3D getenv(QEMU_ENV_DST);<br><br>/*<br>=C2=A0* The default QTES=
T_QEMU_BINARY must always be provided because<br>=C2=A0* that is what helpe=
rs use to query the accel type and<br>=C2=A0* architecture.<br>=C2=A0*/<br>=
if (env-&gt;qemu_src &amp;&amp; env-&gt;qemu_dst) {<br>=C2=A0 =C2=A0 g_test=
_message(&quot;Only one of %s, %s is allowed&quot;,<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QEMU_ENV_SRC, QEMU_ENV_DST=
);<br>=C2=A0 =C2=A0 exit(1);<br>}<br></code></p><p>However, after consideri=
ng your explanation, I believe you&#39;ve convinced me otherwise. I appreci=
ate your input, and I=E2=80=99m sorry for the delayed response and any inco=
nvenience caused.</p></div><div><div><br><div class=3D"gmail_quote gmail_qu=
ote_container"><div dir=3D"ltr" class=3D"gmail_attr">Fabiano Rosas &lt;<a h=
ref=3D"mailto:farosas@suse.de">farosas@suse.de</a>&gt; =E4=BA=8E2025=E5=B9=
=B46=E6=9C=8828=E6=97=A5=E5=91=A8=E5=85=AD 04:52=E5=86=99=E9=81=93=EF=BC=9A=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">xjdeng &lt;<a h=
ref=3D"mailto:micro6947@gmail.com" target=3D"_blank">micro6947@gmail.com</a=
>&gt; writes:<br>
<br>
Hi, thanks for the interest in fixing this. However, the analysis it not<br=
>
quite right:<br>
<br>
&gt; In `find_common_machine_version`, the code previously assumed that<br>
&gt; `getenv(var1)` and `getenv(var2)` would always return non-NULL values.=
<br>
<br>
That&#39;s not true. qtest_qemu_binary() has:<br>
<br>
=C2=A0 =C2=A0 if (var) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_bin =3D getenv(var);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qemu_bin) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;=
--- HERE<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return qemu_bin;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 }<br>
<br>
&gt; However, if either environment variable is not set, `getenv` returns<b=
r>
&gt; NULL, which could lead to a null pointer dereference.<br>
&gt;<br>
&gt; Tracing upstream usage: `find_common_machine_version` is called by<br>
&gt; `resolve_machine_version` with `QEMU_ENV_SRC` and `QEMU_ENV_DST`.<br>
&gt; `resolve_machine_version` is used by `migrate_start`, which is called<=
br>
&gt; by `migrate_postcopy_prepare`, and ultimately by `test_postcopy_common=
`.<br>
&gt;<br>
&gt; In `test_postcopy_common`, after `migrate_postcopy_prepare`, the<br>
&gt; function `migrate_postcopy_complete` is called. Inside, <br>
&gt; `migration_get_env` checks if `QEMU_ENV_SRC` and `QEMU_ENV_DST` are<br=
>
&gt; set before use. Thus, these variables can be NULL, leading to a<br>
&gt; potential null pointer dereference in `find_common_machine_version`.<b=
r>
<br>
There&#39;s no dereference happening anywhere, just a g_test_message(),<br>
which would show &quot;(null)&quot;.<br>
<br>
&gt;<br>
&gt; Signed-off-by: xjdeng &lt;<a href=3D"mailto:micro6947@gmail.com" targe=
t=3D"_blank">micro6947@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/qtest/migration/migration-util.c | 21 +++++++++++++++++++-=
-<br>
&gt;=C2=A0 1 file changed, 19 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migr=
ation/migration-util.c<br>
&gt; index 642cf50c8d..45c9e164e2 100644<br>
&gt; --- a/tests/qtest/migration/migration-util.c<br>
&gt; +++ b/tests/qtest/migration/migration-util.c<br>
&gt; @@ -203,8 +203,25 @@ char *find_common_machine_version(const char *mty=
pe, const char *var1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return g_strdup(type2);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 g_test_message(&quot;No common machine version for mach=
ine type &#39;%s&#39; between &quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&quot;binaries %s and %s&quot;, mtype, getenv(var1), getenv(var2));<br>
<br>
I don&#39;t think we&#39;ll ever reach here in case one var is NULL. It wou=
ld<br>
have been replaced with QTEST_QEMU_BINARY and either asserted or exited<br>
in the if below:<br>
<br>
=C2=A0 =C2=A0 g_autofree char *type1 =3D qtest_resolve_machine_alias(var1, =
mtype);<br>
=C2=A0 =C2=A0 g_autofree char *type2 =3D qtest_resolve_machine_alias(var2, =
mtype);<br>
<br>
=C2=A0 =C2=A0 g_assert(type1 &amp;&amp; type2);<br>
<br>
=C2=A0 =C2=A0 if (g_str_equal(type1, type2)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* either can be used */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return g_strdup(type1);<br>
=C2=A0 =C2=A0 }<br>
<br>
Can you provide a test command line that exposes the issue? Something<br>
like:<br>
<br>
QTEST_QEMU_BINARY=3D./qemu-system-&lt;arch&gt; QTEST_QEMU_BINARY_DST=3D&lt;=
some other<br>
qemu version here&gt; ../tests/qtest/migration-test --full<br>
<br>
Thanks<br>
<br>
&gt; +=C2=A0 =C2=A0 char *varstring1 =3D getenv(var1);<br>
&gt; +=C2=A0 =C2=A0 char *varstring2 =3D getenv(var2);<br>
&gt; +=C2=A0 =C2=A0 if (varstring1 &amp;&amp; varstring2) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_test_message(&quot;No common machine ve=
rsion for machine type &#39;%s&#39; &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&quot;between binaries %s and %s&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0mtype, varstring1, varstring2);<br>
&gt; +=C2=A0 =C2=A0 } else if (varstring1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_test_message(&quot;No common machine ve=
rsion for machine type &#39;%s&#39; &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&quot;between binary %s and environment variable %s&quot;,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0mtype, varstring1, var2);<br>
&gt; +=C2=A0 =C2=A0 } else if (varstring2) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_test_message(&quot;No common machine ve=
rsion for machine type &#39;%s&#39; &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&quot;between binary %s and environment variable %s&quot;,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0mtype, varstring2, var1);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_test_message(&quot;No common machine ve=
rsion for machine type &#39;%s&#39; &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0&quot;between environment variables %s and %s&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0mtype, var1, var2);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
&gt;=C2=A0 }<br>
</blockquote></div></div></div></div>

--0000000000001331ee0638ac8f80--

