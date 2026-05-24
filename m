Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97C9CD5BBF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 16:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRC94-0000Rr-Rf; Sun, 24 May 2026 12:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRC92-0000Rj-Kq
 for qemu-devel@nongnu.org; Sun, 24 May 2026 12:57:44 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wRC8z-0002OZ-K5
 for qemu-devel@nongnu.org; Sun, 24 May 2026 12:57:44 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-36a7bbb9698so1251143a91.2
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 09:57:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779641858; cv=none;
 d=google.com; s=arc-20240605;
 b=jLwLYvejcHoOqR6GWnZEXhMrKNFrcbUo4ksUHmLqst7ToRVV58DKmQdfwBCjfgNG16
 Ngc2dIBXTl545UYStmHm8VodKabH0jTrygCdIO7ALqIJegFGG/caChQp/6NPIyG43T3G
 8xNDP6W8QHMOr7GM4BYveiPBw4ZPL4AOHpslTxrZkh3vxZB4UdaPyGrsbdYMtjVyIrsy
 JohqVnserV634D4MYFfwC8utNVibMh3jJ5YqILPgdDcvJAYzvi1RKNmxTW/nYGmIcUkN
 cFWIIaTg5f/AptNvcUggLDwd6RI6okGm/Po0iMOcNbE/PPuxkLXE+yJGw390gNsyq4/J
 fngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=f4K/Z3KBAPgRLMANkM0OscBelFpROOvbTw8tzDAVweE=;
 fh=auXky6MbHvI/BelePkZYald8UfencEibALzsoTdXrYs=;
 b=YrIHu0CFKBVhK/OsAL47ouyHhs6UmFk8Cz9m6gjxALPGWwPqCP5Duz19X1ij5MtWZe
 YW1vcetW37soBs6IEx9AWb8aEySxTTlm0e3GQGbyXnUYkqhNk31vromOYOTNWmu/jO/O
 Vq1Wykaro3hT6uBTZeHcbnVnnlj+79yKMs3iOi+1sJQzWaFpSwV+muKAirqLOOLT6dHU
 ZKrQCmkq+4WZKCa4VVF8aj7k8P4CFZjLrV5LnTaX+YrGvnir794tKsuf4cRlOkSHv4VM
 iO1XQLsv5HSkGrq3U0l7/C8ofyALbNfadRddznihWK7/QmNiFGahd/CIGpqvqEc9b8Z8
 hwuw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779641858; x=1780246658;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f4K/Z3KBAPgRLMANkM0OscBelFpROOvbTw8tzDAVweE=;
 b=tLYPdvjKdtEXh4Ofu0c/Tz7d5eHQe7btMLZXAithFyBjLpAmOY0kzdIBHQCPX3quT7
 0aARlf+6bq0Rv5KUDM0fEdoo7+O3H3i4gscDZFt/JbjbKPu6l+UuUL4DglsitVxmnrQk
 vpJIFJi9GoNKVcadIoo+e4Uzml0rNXVFvmveyowBJxG5Tj5Dyxc8aJNdQErQu5EtsfEz
 /tD7hgyIqQRTFmtb1czzNde3N3bHi78gDuVjZ5xNl0Hd9/H+qOYSc1oLVRE3GPlpMjd/
 iBTSWJ3AUJ5efMQFt3NQbFrNnLv3D5qhs/m4Z5FzXQflasycxJFaWVi4tNCCVkF9nNxw
 l1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779641858; x=1780246658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f4K/Z3KBAPgRLMANkM0OscBelFpROOvbTw8tzDAVweE=;
 b=XTZqmPq6gqnPzMBVajhVYpnFJqt7Hz/17Pm1kREnlLeV/U0iyfKyTjTg44B1QUw7hM
 Su5FZl/W64mBz6W4YI5nJshW9p7heT+Ra+PYSBadyScpJoJbfbzdZOuPMYW6oHauD+mL
 XKuKBZraLrFUT9uOrh7zRjrSiiWANLmLhof13OmQ+0af7KeOa8DVAcltWaLBFj3zAYyx
 orGKIFQzgViyEiNzRMZz9TB/YgWOKOEDxwCeyrl92u5AOP52fgAPP2E7liEUFBNkimFW
 kL3G2+A9jn5Ac3nGODCTwn7veWq17Q9m4LWKzPU/xmiNlN/HOT5GdX5tf3QOHGBTVO3W
 +y1w==
X-Gm-Message-State: AOJu0Yw2EMcINMvLgOh2moBlbcV2AtAmXkiy3RaSheFf9ujOVK5uX3y2
 BRpX9Qnp7PZkNMvP0XAggWCYxbGgO9GLeaGijjpVmCtdfEycHWHlKK5cXx+s8dQqAiSA88Begm1
 ZucPPQMKqKmZEHwa+KyAldOTGQO5RdRZrvFu1oh7Tbw==
X-Gm-Gg: Acq92OG4bRZ0a4RKBbTzxacFCvhnN11fnpqw6jakE4gbU3ebPK++rTKdzt1C4pidDEF
 70T/CnBIO2i1KodMxPvTCwoSovbOs7K8ZXuomFiHdmf3uqSvZezjIxTxeDh/WJtCPzxF/frwszw
 cprx0ApNWHEZa4wkSJjWlm2klBrjZ7UuZi66pHVHctFMtQXc1z4JuF/Jsy4g+vhIyTQzsFf4MYA
 kvGADMSZD8fZ3SM7ffTjDaeFqC7u3f8+KBU6Bo7RsoxAMIq11y9Z1HxireT8izcSxmWKgrk6GJ4
 cJUUTENAqRMQTa0LCgy78UVFcVJDPAIrVQs=
X-Received: by 2002:a17:90b:3fc7:b0:35b:9894:f6f9 with SMTP id
 98e67ed59e1d1-36a6765a2e6mr11391003a91.18.1779641858230; Sun, 24 May 2026
 09:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <CANCZdfr6xs9n8sF8AXVWVu9i2_rViKErrMHAVbopnaor4uCN6A@mail.gmail.com>
 <875x8g1pmi.fsf@draig.linaro.org>
In-Reply-To: <875x8g1pmi.fsf@draig.linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 24 May 2026 10:57:26 -0600
X-Gm-Features: AVHnY4JZ8Mu3JVHSne3yojDIEqa7pwo_ITD_bkfEeUih0cMRznMYKzbx4HjE4lY
Message-ID: <CANCZdfqT7r9jcTuiwe3=CcjRExL-FP1msx-Q8ftQM5amJ_t0YQ@mail.gmail.com>
Subject: Re: Question about tb_flush()
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000c99cb20652932832"
Received-SPF: none client-ip=2607:f8b0:4864:20::102d;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000c99cb20652932832
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 1, 2026 at 7:54=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:

> Warner Losh <imp@bsdimp.com> writes:
>
> > OK. I've updated bsd-user fork from last year to yesterday. I had one
> question.
> >
> > I see that we've gone from tb_flush() to queue_tb_flush(). Why was that=
?
> And is it a drop in?
> > FreeBSD's fork has this in the thread creation:
> >
> >     /*
> >      * If this is our first additional thread, we need to ensure we
> >      * generate code for parallel execution and flush old translations.
> >      * Do this now so that the copy gets CF_PARALLEL too.
> >      */
> >     if (!(cpu->tcg_cflags & CF_PARALLEL)) {
> >         cpu->tcg_cflags |=3D CF_PARALLEL;
> >         tb_flush(cpu);
> >     }
> >
> > I think the right thing to do is to just change this to
> queue_tb_flush(cpu), and that compiles. I'd like to get some confirmation=
,
> though.
> > Did I parse the changes right?
>
> Yes, because ultimately we use safe work which:
>
>  * Schedules the function @func for execution on the vCPU @cpu
> asynchronously,
>  * while all other vCPUs are sleeping.
>

So I've done this in the latest blitz branch. I encountered one gotcha. I
replaced it in the one place, but that didn't work too well. I finally
tracked down the issue: I had implemented the change in only one place
instead of the three required locations. I also had to bring the
begin_parallel_context() function over from linux-user. I like
user-internal.h that's in linux user. What is your touchstone for deciding
where that code belongs in it? I'd like to do the same in bsd-user once my
upstream focus shift to refinement of blitz and maybe my next cool thing
there.

Warner

--000000000000c99cb20652932832
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Feb 1, =
2026 at 7:54=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@=
linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">Warner Losh &lt;<a href=3D"mailto:imp@bsd=
imp.com" target=3D"_blank">imp@bsdimp.com</a>&gt; writes:<br>
<br>
&gt; OK. I&#39;ve updated bsd-user fork from last year to yesterday. I had =
one question.<br>
&gt;<br>
&gt; I see that we&#39;ve gone from tb_flush() to queue_tb_flush(). Why was=
 that? And is it a drop in?<br>
&gt; FreeBSD&#39;s fork has this in the thread creation:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * If this is our first additional thread, we need =
to ensure we<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * generate code for parallel execution and flush o=
ld translations.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 * Do this now so that the copy gets CF_PARALLEL to=
o.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (!(cpu-&gt;tcg_cflags &amp; CF_PARALLEL)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;tcg_cflags |=3D CF_PARALLEL;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tb_flush(cpu);<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; I think the right thing to do is to just change this to queue_tb_flush=
(cpu), and that compiles. I&#39;d like to get some confirmation, though.<br=
>
&gt; Did I parse the changes right?<br>
<br>
Yes, because ultimately we use safe work which:<br>
<br>
=C2=A0* Schedules the function @func for execution on the vCPU @cpu asynchr=
onously,<br>
=C2=A0* while all other vCPUs are sleeping.<br></blockquote><div><br></div>=
<div>So I&#39;ve done this in the latest blitz branch. I encountered one go=
tcha.=C2=A0I replaced it in the one place, but that didn&#39;t work too wel=
l. I finally tracked down the issue: I had implemented the change in only o=
ne place instead of the three required locations.=C2=A0I also had to bring =
the begin_parallel_context() function over from linux-user. I like user-int=
ernal.h that&#39;s in linux user. What is your touchstone for deciding wher=
e that code belongs in it? I&#39;d like to do the same in bsd-user once my =
upstream focus shift to refinement of blitz and maybe my next cool thing th=
ere.</div><div><br></div><div>Warner</div></div></div>

--000000000000c99cb20652932832--

