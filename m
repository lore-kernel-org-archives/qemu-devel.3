Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2FA10775E1
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 16:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2tWx-0000F7-W8; Wed, 18 Mar 2026 12:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1w2tWw-0000Ee-D0
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 12:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1w2tWt-0000mb-5m
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 12:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773850433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rRZUpOGGHZemQWBldF14O7s+mQu036Em0tbqzBQyoS4=;
 b=GvqWafuZddiiW3Y4jeMiWWGvIgdHoQhcpEvorVBTH/aHLKJoV62i0TEihevCMQzSQw0VEc
 +NnJ/F/KZ3DvWvP5sudRW/PLvJ4ddenvTrju+wbn5kFLfNinMfYpCTYBUexrxccbIkbxBr
 xO4E/tERbL48RzVWnyMFs9KyxdsZpw8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-3ffYrw-BMySuRaOLYwIdtw-1; Wed, 18 Mar 2026 12:13:51 -0400
X-MC-Unique: 3ffYrw-BMySuRaOLYwIdtw-1
X-Mimecast-MFC-AGG-ID: 3ffYrw-BMySuRaOLYwIdtw_1773850430
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-38a247e261dso360401fa.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 09:13:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773850430; cv=none;
 d=google.com; s=arc-20240605;
 b=VfV+pFC4hmmRQGCexuCsoluP2M24JE0J/zk4Qp3wbYuujwqk2mDWJ6EwGhJSHTZJUz
 1kj+AUhi+FtCBGjdTdfU7QNvHRiF3aNHa/Xr+fIXH/VxNF3FqQFRynBztBLlN8FFQDUV
 y/PDMV1CpaemyDTv9J2p5bvUyeL7K/s9isSMzh1Jsq8hv7MikBuEJXa39w0dIVu06vOH
 0B+ChUaZCmS4OkQc+IxYN223cqQNVNT/3PYWjrl+4PA/sHEqolSpA9FCVl5ng3TQ0q8M
 LVL/wWch2w2zAYNs7w9lQbSnxWfdtFHh+VewbKUkaPz9ig1w5hcUAbz/VwqYfk1CzUTV
 GCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rRZUpOGGHZemQWBldF14O7s+mQu036Em0tbqzBQyoS4=;
 fh=71IQ9ZIOXSQ8Y1O/2FNDVQcE5FyDqKuSvM3MTWgYVks=;
 b=gAkYxDTz6FKDHImDBIPzyHuafmeIVqXMMyhs8UqEYK4zae2Ca9z7DtXJs3lf+tnySb
 BKox6WewU0xiPno5l5MaAFnlIji4RI2z5FPCYY3pGOA6YBs5CGIll67Yu2rVsrTbngQo
 gi3oe00LUXgvZoIwyX4zkdaimGH1V94Xaws4vpTXhFxfh8rwFsOZ8oyEv7nMs19RkOeN
 rXLIJCbVh+Ekr0OfguHGvG/DI2hYJz1wuH2piVky3+QvA4/IsdqYfz2GnToGKB9+zOtK
 gEbe0gpI2nX3HFRmG+fCl/2akrRFWAWO6DAp6eakbybWoBm8u0fLxQYaa51xHuJp3rkI
 N8ig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773850430; x=1774455230; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rRZUpOGGHZemQWBldF14O7s+mQu036Em0tbqzBQyoS4=;
 b=jqACHG07t7RU79Bcl6NKF0IcjjSiMkXyGZJhuqwbkXYog8o45sx5/2KHXV35E7XwqE
 CLlIEspK0tEYmB/SCGTXf+nn201xF7v7/9RArDfZllWtiYMSnQbFY+nelJLGUv1gMoxL
 Ssfh7WUTueDKJMq8fG3W9eZxv1u2R6VvkS1iE/9OujqxxSUbBQtjostPDq+f+gIw+KVM
 3JI3gHdxhMCy1dDtEyE3Bwnrp5cwFnq4j/3ZVtgQKnLlBiuI01Rt0n4qVMtaYyqaftbV
 z/umdHPBrnCPGrbaSEeaAPXMoSq55Ows15F6XdaHpcJ0WUknwgGjTrNVzGqODhbrlrsL
 VgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773850430; x=1774455230;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rRZUpOGGHZemQWBldF14O7s+mQu036Em0tbqzBQyoS4=;
 b=irw2yfNWwztJIHfrf8LRszZ52CXVPUUhBeVGbjxpZoV1G7TAWq3NDGBLDFGYn7GCTs
 eL2MjjUnbXdzn3MpBt2g64NRe1YVAPedpx/Rn89kgFMEiCXjwLFiwiYKCHLD4dT3BXm6
 nnEdEm5CqhlCDvLB+Dvvm4EWTEC9uFmFHHNK70mILFUe3VeTbC6EIugf3R3a6vWbOtQN
 Sosl4Y9Yj1CD3ocwEurBs75AtmlEgoE4IbTpQ5CMoLfwaoyh0XE9N3ij7/nh9u8imUO+
 Rq7r+Kx0No/+b2aabJEwe27NvzUzwABNlpEmcaKDRWayOyH5EobyCQ4irTv82jkxxCgF
 rwxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpZv1rBEGxiPIiag42VboN+CG1HEOYeeckb6oiOtoS2fh9Ra2/93SkE5Re2WFGOtyDvBJhwe6OJcNO@nongnu.org
X-Gm-Message-State: AOJu0YxVCV1THe00jHft1e6fgu76UVALsnd/g9KOsJ4AmdKa18fx303C
 Nmmw/3fIkFztkOyKu2NYiPB4bhBjpcu/l7eqSBHXlaRekjUdGZU23aGwk7n5JNyakaXXbKdBocp
 W7C1MLDZs053feyu3NQusY6ItGzitT4uQybqTcDNgHb5WlGZ7h/VNvY+RLQnUk9PPMdLJfEyuK0
 D+E+gSru9SbxGmieSyU6uZV70IkEwsi6g=
X-Gm-Gg: ATEYQzxKERhtQNVbkLN/QTfjGE4fBVg60NQFBCNiODKtNs3b9z+P/D9dCS2DGbEBWkH
 x5UEdAIaMrrNbTJ33GScLk7aUe9QgjWM+0VC1Kb9PwuS4zlwbh4OlQwRD7mo0UkNWi5mx7s08/q
 aUR45NK7i1C0JXhbmPI76mciGSvgVg5V4fPvw5yN0vYZcU5XKaXH8q6oBHAT4BtouKdKq7YYZHi
 KHY
X-Received: by 2002:a2e:3218:0:b0:38a:56d0:9d24 with SMTP id
 38308e7fff4ca-38bd5850543mr13894831fa.18.1773850430085; 
 Wed, 18 Mar 2026 09:13:50 -0700 (PDT)
X-Received: by 2002:a2e:3218:0:b0:38a:56d0:9d24 with SMTP id
 38308e7fff4ca-38bd5850543mr13894741fa.18.1773850429385; Wed, 18 Mar 2026
 09:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260312141657.1701801-1-eashurov@redhat.com>
 <abLVj2eLZmKbPs9J@redhat.com>
 <CAPMcbCq4i8DhwRqPkJxywt6H==NRW=3_7NA0ZQhe8cMFtVGRCA@mail.gmail.com>
 <abLdcy6eoedHgeSV@redhat.com>
In-Reply-To: <abLdcy6eoedHgeSV@redhat.com>
From: Elizabeth Ashurov <eashurov@redhat.com>
Date: Wed, 18 Mar 2026 18:13:37 +0200
X-Gm-Features: AaiRm53EfIa7SQpWBCY_RtATEHXMFzJ8wZNcSMUubUdsbAR_hMEFzx3rJGJwgRA
Message-ID: <CAK957kGvCpN22L40oJ1zJi_RAO9_rzgijzoBPqk=vTjEegt8BQ@mail.gmail.com>
Subject: Re: [PATCH v1] qga: rework slog to support multiple severity levels
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ba8a1c064d4ebc71"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eashurov@redhat.com;
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

--000000000000ba8a1c064d4ebc71
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the review and suggestions.
I updated the patch based on the discussion and sent v2.

Best regards,

On Thu, Mar 12, 2026 at 5:36=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Thu, Mar 12, 2026 at 05:15:05PM +0200, Kostiantyn Kostiuk wrote:
> > On Thu, Mar 12, 2026 at 5:02=E2=80=AFPM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com>
> > wrote:
> >
> > > On Thu, Mar 12, 2026 at 04:16:57PM +0200, Elizabeth Ashurov wrote:
> > > > ga_log() forwarded all "syslog" domain messages unconditionally,
> > > > bypassing the log level filter. Furthermore, slog() hardcoded
> > > > all messages to G_LOG_LEVEL_INFO, causing log spam from frequent
> > > > guest-ping calls.
> > > >
> > > > - Split slog() into slog_error() (WARNING), slog() (MESSAGE), and
> > > slog_trace() (INFO)
> > > > - Apply s->log_level filtering to "syslog" in ga_log()
> > > > - Move guest-ping to slog_trace()
> > > > - Move error messages to slog_error()
> > > >
> > > > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3214
> > > >
> > > > Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
> > > > ---
> > > >  qga/commands-linux.c   |  6 ++++--
> > > >  qga/commands-posix.c   | 13 +++++++------
> > > >  qga/commands-win32.c   | 34 +++++++++++++++++-----------------
> > > >  qga/commands.c         | 30 ++++++++++++++++++++++++------
> > > >  qga/guest-agent-core.h |  2 ++
> > > >  qga/main.c             |  6 +++++-
> > > >  6 files changed, 59 insertions(+), 32 deletions(-)
> > > >
> > >
> > > > diff --git a/qga/commands.c b/qga/commands.c
> > > > index 5f20af25d3..ed52a7d3c2 100644
> > > > --- a/qga/commands.c
> > > > +++ b/qga/commands.c
> > > > @@ -38,6 +38,24 @@ void slog(const gchar *fmt, ...)
> > > >  {
> > > >      va_list ap;
> > > >
> > > > +    va_start(ap, fmt);
> > > > +    g_logv("syslog", G_LOG_LEVEL_MESSAGE, fmt, ap);
> > > > +    va_end(ap);
> > > > +}
> > > > +
> > > > +void slog_error(const gchar *fmt, ...)
> > > > +{
> > > > +    va_list ap;
> > > > +
> > > > +    va_start(ap, fmt);
> > > > +    g_logv("syslog", G_LOG_LEVEL_WARNING, fmt, ap);
> > > > +    va_end(ap);
> > > > +}
> > > > +
> > > > +void slog_trace(const gchar *fmt, ...)
> > > > +{
> > > > +    va_list ap;
> > > > +
> > > >      va_start(ap, fmt);
> > > >      g_logv("syslog", G_LOG_LEVEL_INFO, fmt, ap);
> > > >      va_end(ap);
> > >
> > > This is really the wrong approach IMHO.
> > >
> > > It is bad practice for the call sites to be declaring what log
> > > output they are targetting.
> > >
> > > Also the first parameter of g_log call is supposed to be the
> > > "domain" which is a name that identicates the *source* of the
> > > error message. For code in a library it would be the library
> > > name, or a module name within the library. For applications
> > > it would usually be the application name.
> > >
> > > Passing the name of a desired log target "syslog" is really
> > > a misuse of the logging framework.
> > >
> > > IMHO the existing usage of "slog" should be replaced by
> > > calls to g_error() (for the cases which are reporting error
> > > messages) and g_info() (for the cases which are reporting the
> > > names of commands being executed).
> > >
> > > Then, we should offer better command line control over the
> > > usage of logging
> > >
> > >  "verbose" should enable g_info() or higher
> > >  "debug" should enable g_debug() or higher
> > >
> > > The log file (if configured) should receive *all* messages
> > > per the verbose/debug flag settings. (currently it misses
> > > any messages that get sent to syslog which is bad as it
> > > makes the logfile incomplete.
> > >
> > > The syslog output should also receive all messages at
> > > "info" level of higher (provided the verbose flag is
> > > set). It shouldn't get debug messages, even if 'debug'
> > > flag is set.
> > >
> > > We should not specialcase the "ping" command either IMHO,
> > > it should remain "info" like the other commands. Per that
> > > bug, users can exclude ping messages via a log filter on
> > > the systemd service config.
> > >
> >
> > What to do with Windows? We definitely want to see a freeze/thaw event =
in
> > Event Viewer, but ping is also redundant there.
>
> If we think of the recording of commands as more of an "audit" task,
> we could expose an "audit" argument to control this. It would take
> a list of command names, optionally with wildcards, and optionally
> with negation
>
>    audit =3D *
>
>     =3D> current default - all commands at "info" level
>
>    audit =3D "!guest-ping,*"
>
>     =3D> a new default - all commands at "info" level, except ping
>
>    audit =3D "!guest-ssh-get*,guest-ssh*"
>
>     =3D> a restrictive audit, only commands which modify ssh
>        setup
>
> anything not matched by the audit setting, would be logged at
> g_debug instead of g_info
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--000000000000ba8a1c064d4ebc71
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div id=3D"gmail-:1dz" class=3D"gmail-Am gmail-aiL gmail-a=
O9 gmail-Al editable gmail-LW-avf gmail-tS-tW gmail-tS-tY" aria-label=3D"Me=
ssage Body" role=3D"textbox" aria-multiline=3D"true" tabindex=3D"1" style=
=3D"direction:ltr;min-height:85px" aria-controls=3D":1jh" aria-expanded=3D"=
false">Hi,<br><br>Thanks for the review and suggestions.<br>I updated the p=
atch based on the discussion and sent v2.<br><br>Best regards,</div></div><=
br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Mar 12, 2026 at 5:36=E2=80=AFPM Daniel P. Berrang=
=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu=
, Mar 12, 2026 at 05:15:05PM +0200, Kostiantyn Kostiuk wrote:<br>
&gt; On Thu, Mar 12, 2026 at 5:02=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a=
 href=3D"mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com<=
/a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Thu, Mar 12, 2026 at 04:16:57PM +0200, Elizabeth Ashurov wrote=
:<br>
&gt; &gt; &gt; ga_log() forwarded all &quot;syslog&quot; domain messages un=
conditionally,<br>
&gt; &gt; &gt; bypassing the log level filter. Furthermore, slog() hardcode=
d<br>
&gt; &gt; &gt; all messages to G_LOG_LEVEL_INFO, causing log spam from freq=
uent<br>
&gt; &gt; &gt; guest-ping calls.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; - Split slog() into slog_error() (WARNING), slog() (MESSAGE)=
, and<br>
&gt; &gt; slog_trace() (INFO)<br>
&gt; &gt; &gt; - Apply s-&gt;log_level filtering to &quot;syslog&quot; in g=
a_log()<br>
&gt; &gt; &gt; - Move guest-ping to slog_trace()<br>
&gt; &gt; &gt; - Move error messages to slog_error()<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/=
work_items/3214" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qe=
mu-project/qemu/-/work_items/3214</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Elizabeth Ashurov &lt;<a href=3D"mailto:eashu=
rov@redhat.com" target=3D"_blank">eashurov@redhat.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 qga/commands-linux.c=C2=A0 =C2=A0|=C2=A0 6 ++++--<br>
&gt; &gt; &gt;=C2=A0 qga/commands-posix.c=C2=A0 =C2=A0| 13 +++++++------<br=
>
&gt; &gt; &gt;=C2=A0 qga/commands-win32.c=C2=A0 =C2=A0| 34 ++++++++++++++++=
+-----------------<br>
&gt; &gt; &gt;=C2=A0 qga/commands.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 30 +=
+++++++++++++++++++++++------<br>
&gt; &gt; &gt;=C2=A0 qga/guest-agent-core.h |=C2=A0 2 ++<br>
&gt; &gt; &gt;=C2=A0 qga/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 6 +++++-<br>
&gt; &gt; &gt;=C2=A0 6 files changed, 59 insertions(+), 32 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; diff --git a/qga/commands.c b/qga/commands.c<br>
&gt; &gt; &gt; index 5f20af25d3..ed52a7d3c2 100644<br>
&gt; &gt; &gt; --- a/qga/commands.c<br>
&gt; &gt; &gt; +++ b/qga/commands.c<br>
&gt; &gt; &gt; @@ -38,6 +38,24 @@ void slog(const gchar *fmt, ...)<br>
&gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 va_list ap;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 va_start(ap, fmt);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 g_logv(&quot;syslog&quot;, G_LOG_LEVEL_MESSAG=
E, fmt, ap);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 va_end(ap);<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +void slog_error(const gchar *fmt, ...)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 va_list ap;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 va_start(ap, fmt);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 g_logv(&quot;syslog&quot;, G_LOG_LEVEL_WARNIN=
G, fmt, ap);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 va_end(ap);<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +void slog_trace(const gchar *fmt, ...)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 va_list ap;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 va_start(ap, fmt);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 g_logv(&quot;syslog&quot;, G_LOG_LEVEL_I=
NFO, fmt, ap);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 va_end(ap);<br>
&gt; &gt;<br>
&gt; &gt; This is really the wrong approach IMHO.<br>
&gt; &gt;<br>
&gt; &gt; It is bad practice for the call sites to be declaring what log<br=
>
&gt; &gt; output they are targetting.<br>
&gt; &gt;<br>
&gt; &gt; Also the first parameter of g_log call is supposed to be the<br>
&gt; &gt; &quot;domain&quot; which is a name that identicates the *source* =
of the<br>
&gt; &gt; error message. For code in a library it would be the library<br>
&gt; &gt; name, or a module name within the library. For applications<br>
&gt; &gt; it would usually be the application name.<br>
&gt; &gt;<br>
&gt; &gt; Passing the name of a desired log target &quot;syslog&quot; is re=
ally<br>
&gt; &gt; a misuse of the logging framework.<br>
&gt; &gt;<br>
&gt; &gt; IMHO the existing usage of &quot;slog&quot; should be replaced by=
<br>
&gt; &gt; calls to g_error() (for the cases which are reporting error<br>
&gt; &gt; messages) and g_info() (for the cases which are reporting the<br>
&gt; &gt; names of commands being executed).<br>
&gt; &gt;<br>
&gt; &gt; Then, we should offer better command line control over the<br>
&gt; &gt; usage of logging<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 &quot;verbose&quot; should enable g_info() or higher<br>
&gt; &gt;=C2=A0 &quot;debug&quot; should enable g_debug() or higher<br>
&gt; &gt;<br>
&gt; &gt; The log file (if configured) should receive *all* messages<br>
&gt; &gt; per the verbose/debug flag settings. (currently it misses<br>
&gt; &gt; any messages that get sent to syslog which is bad as it<br>
&gt; &gt; makes the logfile incomplete.<br>
&gt; &gt;<br>
&gt; &gt; The syslog output should also receive all messages at<br>
&gt; &gt; &quot;info&quot; level of higher (provided the verbose flag is<br=
>
&gt; &gt; set). It shouldn&#39;t get debug messages, even if &#39;debug&#39=
;<br>
&gt; &gt; flag is set.<br>
&gt; &gt;<br>
&gt; &gt; We should not specialcase the &quot;ping&quot; command either IMH=
O,<br>
&gt; &gt; it should remain &quot;info&quot; like the other commands. Per th=
at<br>
&gt; &gt; bug, users can exclude ping messages via a log filter on<br>
&gt; &gt; the systemd service config.<br>
&gt; &gt;<br>
&gt; <br>
&gt; What to do with Windows? We definitely want to see a freeze/thaw event=
 in<br>
&gt; Event Viewer, but ping is also redundant there.<br>
<br>
If we think of the recording of commands as more of an &quot;audit&quot; ta=
sk,<br>
we could expose an &quot;audit&quot; argument to control this. It would tak=
e<br>
a list of command names, optionally with wildcards, and optionally<br>
with negation<br>
<br>
=C2=A0 =C2=A0audit =3D *<br>
<br>
=C2=A0 =C2=A0 =3D&gt; current default - all commands at &quot;info&quot; le=
vel<br>
<br>
=C2=A0 =C2=A0audit =3D &quot;!guest-ping,*&quot;<br>
<br>
=C2=A0 =C2=A0 =3D&gt; a new default - all commands at &quot;info&quot; leve=
l, except ping<br>
<br>
=C2=A0 =C2=A0audit =3D &quot;!guest-ssh-get*,guest-ssh*&quot;<br>
<br>
=C2=A0 =C2=A0 =3D&gt; a restrictive audit, only commands which modify ssh<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0setup<br>
<br>
anything not matched by the audit setting, would be logged at<br>
g_debug instead of g_info<br>
<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer" target=3D=
"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"noreferrer"=
 target=3D"_blank">https://entangle-photo.org</a> :|<br>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer" target=3D"_=
blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =C2=A0 <a hre=
f=3D"https://fstop138.berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div>

--000000000000ba8a1c064d4ebc71--


