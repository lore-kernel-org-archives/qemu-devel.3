Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D697606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YOHLGJpJ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CeZkvPZ0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM2Cb-0002Gq-PW; Wed, 28 Oct 2026 07:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM2Ca-0002Gb-A5
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:52:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM2CY-0005jJ-5O
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793188337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0nWirlGLAVuivdixLMUrtQLDUbBTFR2qlRjFO0qFdfc=;
 b=YOHLGJpJ+U5LHsNJYgi5IgoLFk9pZiK1v07Oeatvj/1+nsunuOgpGdYtSWnMoNo7cZX0w7
 t1Yj/SDFAEkgBmXNSNks9SXhkXurmOMMQznz0DJ+vmljxLigdiAjjXQGavXc9YxZcExz4F
 4uqcaZ7qPpdvPIrvkAKG71wTVQcm1E0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-RBPDjcmAPva41T_9nqzwfQ-1; Wed, 28 Oct 2026 07:52:10 -0400
X-MC-Unique: RBPDjcmAPva41T_9nqzwfQ-1
X-Mimecast-MFC-AGG-ID: RBPDjcmAPva41T_9nqzwfQ_1793188329
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c71966998so12655606d6.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 04:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793188329; cv=none;
 d=google.com; s=arc-20260327;
 b=ivIEjNSRI7BFvOGM87ktPJjQE1kJMDUXdZ8T8hRSBPk7R366My4iam3s3Se3MElqC2
 oRSSefyBW7tsjs7Cv1AtVooF5yo8hRAGjqLigKWpJXRVnabmxwk0lSr4K4lei2CpU3aC
 RCQWeKSTHR0beXuSgSOUuBPIoQJMWYHA+YwBiymnKx3s7o++8+DwW+MHyLf3ArJlIpC7
 jClZOqdDV9tg+24Ri1OTgMcOgyRsBtdwVkVrGY3ZF/rSudMCsp0z/7A15ih5K4cp4CSR
 r/oMhaqJ+H9FAUnJoM7JVCxRteqF1hvgxY45hKBZ1vf7trS8FlqrVztjmyA7yDqnK9FU
 Gdkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0nWirlGLAVuivdixLMUrtQLDUbBTFR2qlRjFO0qFdfc=;
 fh=imijeT+aVG2r2Xt8VOah32Rs98N2YS7U/06n20RFiqo=;
 b=kMv0AO3nGRDYEe0bIGjY9Yv5DWkuwfXz+ABvOngV9dQAVplJJ4JASERoxRJt81gj4Q
 RxZdhn0L+RW0DqblmMG89nAbtWtayLXuRvcrH5TiSWLME8ekOIBk6vHSSnvK0LPed1Ld
 KZiWokm4bGqUtfQGfK0+1OHoqwQq+li2fADO0cvrfDVMiCv0jeiAn1cK4vlQrTAu5NRj
 SWh7dvFZMv55smlJbImmXcevVJL0uLIjNSjeTNcRkVabYNmS09TX1SB84jCKD8Y+Zq8+
 zHbANt02/5OM8owEVaWKTVuGZztuioxh+SH/8PBxHxGgOOy+SnUeE/+9mKB919mB4Yav
 NtDQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793188329; x=1793793129; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0nWirlGLAVuivdixLMUrtQLDUbBTFR2qlRjFO0qFdfc=;
 b=CeZkvPZ0GRKNN6UL56cHasQOKO5WToEsbnlRcBv++lvHq9bukri/Zo2/lCp9UdMWEY
 /m3vpC0WDxSHeZtneMHpjvx6SNEc4hKaKtkiCtJwAW5nv9/tzNxKqlC6K8mIXgrjfaIt
 6B+W26iK0U1CQbSkjD8d5kvy3tjdvk+VswDv9muuDKdibZpGJ9wHoluARLy/1NF/scCk
 7RuISUpftT5MHW/HurMeby8gLZhZKOxyCKmYhM41P9HBK5H/OvBU0H2wKn4dk94SJRuM
 M0v6gTqhj26Y2mb6FHLFtAU86qcYOFS4CtT/iSNfa28h+i2atXeh+QXduv3IZ3D5SOsR
 BYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793188329; x=1793793129;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0nWirlGLAVuivdixLMUrtQLDUbBTFR2qlRjFO0qFdfc=;
 b=LvH+IEwa5sG3M7hcIWH84SGDZdRdpcU+VVTUSk5NBk7syv+14deLzY6ZkujqUJ41Z1
 a9I9sOgtTuT+Qt9LpIy8niqTtTfihfEBTfGy3NOAZQfGVcHsFgvkVU9H9Anl7XhWey1U
 qwbpnrN2cJmlsEJmek7wQ5EI7BQ76xoBFLQ4lZQoZeWKvz+Tkygv2Jhx7XnO/XCpcsyc
 YoSE3/qXhPVX5slirhjKgX+/oKqnSAX81LzxVxNjB4EWJzhkbCc83memgHo6TeabPOaL
 FYiFex1blqu+kPcDCWsIUbaEtjhn65YQE9kk8GXU1UFjr3Mis9gaAnxrgmQS73jDLIjW
 XdEQ==
X-Gm-Message-State: AFq9FYKbnncO+Fnz9ePymF32i+IDWml+Q2Em9pkDdsRkmsLOn+zJ9MIw
 1VPHiXGQ+T5l5oBlzXRV/Kj0znYj6U9Kw5FQ8ZlkHrE5oGNlpl6NOI8HnDSiWVVvTVCg4g76AeG
 ZXqIuagjE5wtayXFkUxdNIg09DiMnRmAgneZlQjXxZyDqGRtadNFkUmeKh7ihhv2PlfC7jl0F3X
 qEAARN2pur4kbwbxJdXBPIb8M0qC6LE7/QOGP2Cp4ddg==
X-Gm-Gg: AYBFou1n/YUsENEHyGzrfl1xsK+iwKtqd/nxyID9kaO9ZmWq8R2ePUKE9ufC1QIqNwS
 senDHo4Ogqbv38EiuXSvFJ423jYCkWRPoq2WPGTyOdLmOQ8G2cs/Mk7e58ht+ZZw3gB+zZ0LksX
 1AGZDEjsUmPd/iD699NXFQyaSlKx6LXd9MDl0f6mphVB7POCkT30UD0kpgb9Zv+qBOeiHUf1dDn
 dkO69vOWeshzZUV2A1HB4sFdnR/cHAiuneHdVKoX+Bs3HeMX2ZvDhv5y9rP6EyWPLX8pT5QV+IQ
X-Received: by 2002:ad4:5c87:0:b0:91c:6258:ec97 with SMTP id
 6a1803df08f44-91c7cf270famr34348026d6.11.1793188329132; 
 Wed, 28 Oct 2026 04:52:09 -0700 (PDT)
X-Received: by 2002:ad4:5c87:0:b0:91c:6258:ec97 with SMTP id
 6a1803df08f44-91c7cf270famr34347686d6.11.1793188328418; Wed, 28 Oct 2026
 04:52:08 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015142342.50436-1-bogorodskiy@gmail.com>
 <CAPMcbCpMtRgkWkEPj5xns7xMVCzDOjBcwp8m944q+tTtEPj1Tg@mail.gmail.com>
 <auHU4RuV_XTSV0Vn@tulp>
 <CAPMcbCpCJU=960Jj97nC9uZe+ihAZHe=Goj47YvT-Kde2=mTnw@mail.gmail.com>
In-Reply-To: <CAPMcbCpCJU=960Jj97nC9uZe+ihAZHe=Goj47YvT-Kde2=mTnw@mail.gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Wed, 28 Oct 2026 13:51:56 +0200
X-Gm-Features: AclHuK_KOfShMMYgK7Tcb3tuHoZeNoDB5kEbAapIhOdT3pZBVODGktb0g-LyYng
Message-ID: <CAPMcbCqwQh024GfCcY4zTQXpY=zubwDYrBDB1fvdkGaCSmtg=w@mail.gmail.com>
Subject: Re: [PATCH v2] qga: do not run hwclock(8) on non-Linux POSIX OSes
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="00000000000054d1af065ee53136"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000054d1af065ee53136
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Wed, Oct 28, 2026 at 1:51=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@redhat=
.com>
wrote:

> Make sense
> Thanks for explanation
>
>
>
> Best Regards,
> Kostiantyn Kostiuk.
>
>
> On Wed, Oct 28, 2026 at 12:57=E2=80=AFPM Roman Bogorodskiy <bogorodskiy@g=
mail.com>
> wrote:
>
>>   Kostiantyn Kostiuk wrote:
>>
>> > On Thu, Oct 15, 2026 at 5:24=E2=80=AFPM Roman Bogorodskiy <
>> bogorodskiy@gmail.com>
>> > wrote:
>> >
>> > > Currently, qmp_guest_set_time() sets system time using
>> > > the settimeofday(2) system call and then runs the hwclock(8)
>> > > util to set hardware time.
>> > >
>> > > hwclock(8) is Linux only, so current implementation
>> > > always fails while trying to run it on non-Linux POSIX OSes,
>> > > such as BSDs (FreeBSD, OpenBSD, NetBSD) and illumos.
>> > >
>> > > Update the code not to run it on non-Linux. The settimeofday(2)
>> > > call sets both system and hardware time on these systems.
>> > > For example, on FreeBSD settimeofday() calls settime()
>> > > which calls resettodr() [1] which updates RTC clock [2].
>> > > It is similar on OpenBSD and NetBSD, though implementations
>> > > differ a bit.
>> > >
>> > > Additional detail: on FreeBSD RTC clock setting can be
>> > > disabled with the `machdep.disable_rtc_set` sysctl.
>> > > As we cannot do anything about it, do not handle that
>> > > case separately.
>> > >
>> > > Non-Linux POSIX OSes do not provide a common utility
>> > > equivalent to hwclock -s, so report an unsupported operation
>> > > when no time is supplied.
>> > >
>> > > 1: https://cgit.freebsd.org/src/tree/sys/kern/kern_time.c
>> > > 2: https://cgit.freebsd.org/src/tree/sys/kern/subr_rtc.c
>> > >
>> > > Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
>> > > ---
>> > > Changes since v1:
>> > >
>> > > Replace "#if defined(CONFIG_BSD)" condition with
>> > > "#if !defined(CONFIG_LINUX)" as hwclock(8) is Linux only.
>> > >
>> > >  qga/commands-posix.c | 14 ++++++++++++++
>> > >  1 file changed, 14 insertions(+)
>> > >
>> > > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>> > > index 837e285b6d..ffd1744b74 100644
>> > > --- a/qga/commands-posix.c
>> > > +++ b/qga/commands-posix.c
>> > > @@ -322,6 +322,20 @@ void qmp_guest_set_time(bool has_time, int64_t
>> > > time_ns, Error **errp)
>> > >          }
>> > >      }
>> > >
>> > > +#if !defined(CONFIG_LINUX)
>> > > +    /*
>> > > +     * BSDs (FreeBSD, OpenBSD, NetBSD) and illumos do not have the
>> > > +     * hwclock(8) tool. These systems update hardware clock when
>> > > +     * settimeofday() sets system time, so no additional actions
>> > > +     * are needed. Setting system time from RTC is not supported.
>> > > +     */
>> > > +    if (!has_time) {
>> > > +        error_setg(errp, "Setting system time from RTC is not
>> supported");
>> > > +    }
>> > > +
>> > > +    return;
>> > > +#endif
>> > > +
>> > >
>> >
>> > As only Linux (not POSIX) and Windows support this function
>> > lets move qmp_guest_set_time to commands-linux and update QAPI with
>> > 'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] }
>>
>> Hi Kostiantyn,
>>
>> Sorry if my commit message does not explain the situation clearly enough=
.
>>
>> BSDs and illumos do support "guest-set-time" with "time" specified.
>> On these systems, calling settimeofday() is enough for that, it sets
>> both system time and hardware clock, so lack of the hwclock(8) does not
>> prevent it from working as intended.
>>
>> Only "guest-set-time" without the "time" argument (i.e. setting system
>> time
>> from the hardware clock) is not supported indeed, which we indicate with
>> an error message.
>>
>> Therefore I think keeping qmp_guest_set_time() in commands-posix.c and
>> keeping the proposed conditional behavior is appropriate.
>>
>> >
>> > Best Regards,
>> > Kostiantyn Kostiuk.
>>
>>

--00000000000054d1af065ee53136
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, O=
ct 28, 2026 at 1:51=E2=80=AFPM Kostiantyn Kostiuk &lt;<a href=3D"mailto:kko=
stiuk@redhat.com">kkostiuk@redhat.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Make sense=C2=A0=
<br></div><div>Thanks for explanation<br><br></div><div><br><br></div><div>=
<div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regar=
ds,</div><div>Kostiantyn Kostiuk.</div></div></div></div><br></div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 28=
, 2026 at 12:57=E2=80=AFPM Roman Bogorodskiy &lt;<a href=3D"mailto:bogorods=
kiy@gmail.com" target=3D"_blank">bogorodskiy@gmail.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0 Kostiantyn Kos=
tiuk wrote:<br>
<br>
&gt; On Thu, Oct 15, 2026 at 5:24=E2=80=AFPM Roman Bogorodskiy &lt;<a href=
=3D"mailto:bogorodskiy@gmail.com" target=3D"_blank">bogorodskiy@gmail.com</=
a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; Currently, qmp_guest_set_time() sets system time using<br>
&gt; &gt; the settimeofday(2) system call and then runs the hwclock(8)<br>
&gt; &gt; util to set hardware time.<br>
&gt; &gt;<br>
&gt; &gt; hwclock(8) is Linux only, so current implementation<br>
&gt; &gt; always fails while trying to run it on non-Linux POSIX OSes,<br>
&gt; &gt; such as BSDs (FreeBSD, OpenBSD, NetBSD) and illumos.<br>
&gt; &gt;<br>
&gt; &gt; Update the code not to run it on non-Linux. The settimeofday(2)<b=
r>
&gt; &gt; call sets both system and hardware time on these systems.<br>
&gt; &gt; For example, on FreeBSD settimeofday() calls settime()<br>
&gt; &gt; which calls resettodr() [1] which updates RTC clock [2].<br>
&gt; &gt; It is similar on OpenBSD and NetBSD, though implementations<br>
&gt; &gt; differ a bit.<br>
&gt; &gt;<br>
&gt; &gt; Additional detail: on FreeBSD RTC clock setting can be<br>
&gt; &gt; disabled with the `machdep.disable_rtc_set` sysctl.<br>
&gt; &gt; As we cannot do anything about it, do not handle that<br>
&gt; &gt; case separately.<br>
&gt; &gt;<br>
&gt; &gt; Non-Linux POSIX OSes do not provide a common utility<br>
&gt; &gt; equivalent to hwclock -s, so report an unsupported operation<br>
&gt; &gt; when no time is supplied.<br>
&gt; &gt;<br>
&gt; &gt; 1: <a href=3D"https://cgit.freebsd.org/src/tree/sys/kern/kern_tim=
e.c" rel=3D"noreferrer" target=3D"_blank">https://cgit.freebsd.org/src/tree=
/sys/kern/kern_time.c</a><br>
&gt; &gt; 2: <a href=3D"https://cgit.freebsd.org/src/tree/sys/kern/subr_rtc=
.c" rel=3D"noreferrer" target=3D"_blank">https://cgit.freebsd.org/src/tree/=
sys/kern/subr_rtc.c</a><br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Roman Bogorodskiy &lt;<a href=3D"mailto:bogorodski=
y@gmail.com" target=3D"_blank">bogorodskiy@gmail.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; Changes since v1:<br>
&gt; &gt;<br>
&gt; &gt; Replace &quot;#if defined(CONFIG_BSD)&quot; condition with<br>
&gt; &gt; &quot;#if !defined(CONFIG_LINUX)&quot; as hwclock(8) is Linux onl=
y.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 qga/commands-posix.c | 14 ++++++++++++++<br>
&gt; &gt;=C2=A0 1 file changed, 14 insertions(+)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
&gt; &gt; index 837e285b6d..ffd1744b74 100644<br>
&gt; &gt; --- a/qga/commands-posix.c<br>
&gt; &gt; +++ b/qga/commands-posix.c<br>
&gt; &gt; @@ -322,6 +322,20 @@ void qmp_guest_set_time(bool has_time, int64=
_t<br>
&gt; &gt; time_ns, Error **errp)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; +#if !defined(CONFIG_LINUX)<br>
&gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0* BSDs (FreeBSD, OpenBSD, NetBSD) and illumo=
s do not have the<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0* hwclock(8) tool. These systems update hard=
ware clock when<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0* settimeofday() sets system time, so no add=
itional actions<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0* are needed. Setting system time from RTC i=
s not supported.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; +=C2=A0 =C2=A0 if (!has_time) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Setting syste=
m time from RTC is not supported&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 return;<br>
&gt; &gt; +#endif<br>
&gt; &gt; +<br>
&gt; &gt;<br>
&gt; <br>
&gt; As only Linux (not POSIX) and Windows support this function<br>
&gt; lets move qmp_guest_set_time to commands-linux and update QAPI with<br=
>
&gt; &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_LINUX&#39;, &#39;CONFIG_WI=
N32&#39;] }<br>
<br>
Hi Kostiantyn,<br>
<br>
Sorry if my commit message does not explain the situation clearly enough.<b=
r>
<br>
BSDs and illumos do support &quot;guest-set-time&quot; with &quot;time&quot=
; specified.<br>
On these systems, calling settimeofday() is enough for that, it sets<br>
both system time and hardware clock, so lack of the hwclock(8) does not<br>
prevent it from working as intended.<br>
<br>
Only &quot;guest-set-time&quot; without the &quot;time&quot; argument (i.e.=
 setting system time<br>
from the hardware clock) is not supported indeed, which we indicate with<br=
>
an error message.<br>
<br>
Therefore I think keeping qmp_guest_set_time() in commands-posix.c and<br>
keeping the proposed conditional behavior is appropriate.<br>
<br>
&gt; <br>
&gt; Best Regards,<br>
&gt; Kostiantyn Kostiuk.<br>
<br>
</blockquote></div>
</blockquote></div>

--00000000000054d1af065ee53136--


