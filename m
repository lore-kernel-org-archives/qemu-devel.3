Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D367A10ED65C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65KY-0006MI-Kb; Fri, 27 Mar 2026 07:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <silvan@quobyte.com>)
 id 1w65KB-000685-TQ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:26:04 -0400
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <silvan@quobyte.com>)
 id 1w65K7-0003M0-P6
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:25:59 -0400
Received: by mail-dl1-x122a.google.com with SMTP id
 a92af1059eb24-12a747e7b2fso1133711c88.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:25:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774610753; cv=none;
 d=google.com; s=arc-20240605;
 b=kXyWaEd7Dzmc41AgkpLBQRjPeMTY5OyKKSQEGuBVgFg/i2YvzrL8XlGkHyoBqwYYRQ
 mwowsx1wnFk72qkcf0TpwS7654OtGOTOP7xIrxKGunoh6qYRYKirIPWL9yRHfBVxQ3qV
 UMQYfKh0/JzFyO0VnhBqIiK3NmOfADmcVKHd5y2rLvb6KfkSxfIdY0XuDp6oEnHU3O89
 uL4KPVz0w/jgAllJrszeNu6PjfoBMSvFoda2FpSrYPT+KBCE1e99xewQlpHPSGhvMwBg
 KO9g87w6OnoZj2gpztjecHNApDnZ+PcRyId5Hehfz9wJTrdB5Knbt39OoXRnQUZm+LOP
 MmtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eOYo7LOukijabKCRXtGxtMEFaffXBN/gjjApf//KV+8=;
 fh=Zv1SoccLjFQvYa1USgeVJUHj4rO9itjJ4FL2kLiyzOc=;
 b=Cx5pFCSQs4wtqPw86gJtdvzwqwOn1iJHuzLQ5UWHiy4CDelQnpNuzF60DZU24vjSgw
 mQtu7rmzmbeNROWO3I6NWFq7+zVAkNPHiobHrIClykNKotfRNB1a5VCN60ioEzu+zD60
 FdsB5h8B+U9PNKURGwGv4xzb1jrrozoqI8NUgsom5xD+gXt4EP37j+dv5RCdgELVYFKC
 Lpk6vI5C4OieqcwoTPqKfbUtxbYzw/8G98gnxQYKzQQBHTUOUDisUBGpQYk2zBpEz//g
 y6nHOB3qX2bdjEXXtaTzTHyizdSGu5QMykEDD8LK71AKTWBR6KzXtRx5l3IyzcVAalvF
 si2Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quobyte.com; s=google; t=1774610753; x=1775215553; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eOYo7LOukijabKCRXtGxtMEFaffXBN/gjjApf//KV+8=;
 b=LnT3f0pdMcptXHJlsbXFX+Ykfze2YXo0A5ovjwmHLatWgyFCt1d/JKSMfP2NcBBkXF
 ooSx522wcVdEp1oo2JhJZQ/aBgQ2ImecWKzklklg0PqA9AtF8qNrjemPRA1Mfh/xqg+O
 HKzFkjbtXiZF+tF0F0PW5UnD379T/2dOaso34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610753; x=1775215553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eOYo7LOukijabKCRXtGxtMEFaffXBN/gjjApf//KV+8=;
 b=LgfJAAVcHqcsw13j57OWhuRibu7HfeTuj1/0SIaUVJQa5feeuycRGPDdpg/XQCI6YW
 Bapj2iHCCmLh6gZzkbjYQgmlBR1iTtdD5YRvzIZAPu84m2Bj/R5fcTBwr/Po64Samc9D
 Gwr8DFFX3m/5P6JDkrRS0SNd143DUyyJyx3+UqZwTdrtkFKu1aubu06N86mcXurkic7K
 ee/WPLvVkTIyymg5FLzPav8z66qxEWS11f317febBOFbNPUxK2vqev17Kxwu3/gisep8
 1TQVnFNdztnsSLhhdjMcLjV01DHPH4OdwPwdJb20Pw1XBP5arjTMbFg3VOHImMMRr1I2
 Bzig==
X-Gm-Message-State: AOJu0YweMZ0XcAACZNA1OTvsGEj/WDQ5sKNlfsKdW7fkzIWyRMHYPvzj
 FmeerbuM4iuBqYSrrCTY0Iat6taip3Ffmo1wdP1qxjpAwYrUDGUQNaHTzczhRA+5DHVDn2UeIW9
 5CwGy5kR7huJb6z7M9Cp+Z3OVj/5N1Z0mi9NpzvAgsSXoUx5/ea3GpxEgDIpOp7tbF+VyRh30ug
 YB53Cy+QcCwPw90TdgZ15C94le
X-Gm-Gg: ATEYQzxIaDNmPdbVzmMNLJwm8orbqUYNv5YMPhFkdqs5hjyr6qH52Cx1dbOMXINJMJj
 3uFbzD/RDKpfZdsdZkCLZZrst+Z2cpeLJIa4U3dVTXsaL6lpxs+FXh8fLqTyyhg0qEhb7YnpmW4
 joDuzbTizoiF24XVXn0peOwekpGbfn/jNtl2+5Mv9zyck4+qp/j2xYkSeZ3Wg+wF+KA46yHhntW
 OtFBJnpv+bNUzyeRnvrnKMuPZnlgipBt6+X48TPEcghHESAfwJ+vhLSuX4ntugLYyGmGPQe1NCk
 8CZL4Vul9XgAtOe/WWC78gByhW4y+3euPKmg90wFNQNb+Gu683nmv2MbHszSq3kdQF20ykZOEWJ
 EE8jBaxEbbOzMDjmFdtcnRbjh
X-Received: by 2002:a05:7022:eacd:b0:12a:6ab7:3f9e with SMTP id
 a92af1059eb24-12ab28718a6mr1236805c88.10.1774610752676; Fri, 27 Mar 2026
 04:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260326091948.194529-1-silvan@quobyte.com>
 <acT9pOs5-9D8OqSm@redhat.com>
In-Reply-To: <acT9pOs5-9D8OqSm@redhat.com>
From: Silvan Kaiser <silvan@quobyte.com>
Date: Fri, 27 Mar 2026 12:25:41 +0100
X-Gm-Features: AQROBzDtISO9Ta9lH2v-KeDFvDN4jGeBgxO58LNusqIyALPpUQN9mGAeg6CrZaY
Message-ID: <CALsyUnNqhkeA4jNP3XvNkUTJwa+O9MtkY38Kg3LK4TvB8J3BDw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] block: Add 'posix' option for file locking
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, pierrick.bouvier@linaro.org, eblake@redhat.com, 
 armbru@redhat.com
Content-Type: multipart/alternative; boundary="0000000000008732e9064dffc34e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::122a;
 envelope-from=silvan@quobyte.com; helo=mail-dl1-x122a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000008732e9064dffc34e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On FUSE, OFD locks are indeed indistinguishable from POSIX locks for the
underlying fs, which is part of the problem =E2=80=94 the filesystem can't =
ensure
the correct handling.
The practical issue we're hitting is stale locks not being cleaned up
across service restarts (e.g. Kolla/Cinder container restarts), which can
block volume access.
There's also a detection caveat: QEMU probes OFD capability against
/dev/null, which reliably reflects kernel support but says nothing about
the locking semantics of a remote filesystem actually serving the images.
Combined with varying OFD support across different versions of various
remote file systems, an explicit POSIX flag would give operators a
straightforward way to ensure consistent, predictable behaviour in setups
where OFD lock semantics cannot be relied upon.

Thanks for looking into this and best regards
Silvan

Am Do., 26. M=C3=A4rz 2026 um 10:34 Uhr schrieb Daniel P. Berrang=C3=A9 <
berrange@redhat.com>:

> On Thu, Mar 26, 2026 at 10:19:45AM +0100, Silvan Kaiser wrote:
> > QEMU currently supports three values for the 'locking' property of
> > file-based block devices: 'auto' (the default), 'on', and 'off'.
> > When OFD (Open File Descriptor) locks are available, 'auto' and 'on'
> > use them; when they are not, 'on' falls back to POSIX locks with a
> > warning.
> >
> > This series adds a fourth value, 'posix', which explicitly forces the
> > use of traditional POSIX locks (F_SETLK/F_GETLK) regardless of OFD
> > availability.  The motivation is that some userspace filesystem
> > implementations (e.g. FUSE) handle POSIX locks correctly but do not
> > fully support OFD lock semantics.  Issues with OFD support detection
> > on underlying file systems and some OFD guarantees not being fully
> > supported can prohibit users from using the default OFD locking.
> > Previously, users in this situation had no way to force POSIX locking
> > without disabling locking entirely.
>
> Don't the OFD locks silently degrade into POSIX lock semantics
> when used over FUSE ? If not, what is the behaviour problem
> you're seeing ?
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

--=20
Dr.-Ing. Silvan Kaiser
Quobyte GmbH, Berlin, AG Charlottenburg HRB 149012 B, Felix Hupfeld, Bjoern
Kolbeck

--=20
Quobyte GmbH, Berlin, AG Charlottenburg HRB 149012 B, Dr. Felix Hupfeld,=20
Dr. Bjoern Kolbeck

--0000000000008732e9064dffc34e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>On FUSE, OFD locks are indeed indistinguishable from =
POSIX locks for the underlying fs, which is part of the problem =E2=80=94 t=
he filesystem can&#39;t ensure the correct handling.<br>The practical issue=
 we&#39;re hitting is stale locks not being cleaned up across service resta=
rts (e.g. Kolla/Cinder container restarts), which can block volume access. =
<br>There&#39;s also a detection caveat: QEMU probes OFD capability against=
 /dev/null, which reliably reflects kernel support but says nothing about t=
he locking semantics of a remote filesystem actually serving the images.<br=
>Combined with varying OFD support across different versions of various rem=
ote file systems, an explicit POSIX flag would give operators a straightfor=
ward way to ensure consistent, predictable behaviour in setups where OFD lo=
ck semantics cannot be relied upon.</div><div><br></div><div>Thanks for loo=
king into this and best regards<br></div><div>Silvan</div></div><br><div cl=
ass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_a=
ttr">Am Do., 26. M=C3=A4rz 2026 um 10:34=C2=A0Uhr schrieb Daniel P. Berrang=
=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&g=
t;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, Mar =
26, 2026 at 10:19:45AM +0100, Silvan Kaiser wrote:<br>
&gt; QEMU currently supports three values for the &#39;locking&#39; propert=
y of<br>
&gt; file-based block devices: &#39;auto&#39; (the default), &#39;on&#39;, =
and &#39;off&#39;.<br>
&gt; When OFD (Open File Descriptor) locks are available, &#39;auto&#39; an=
d &#39;on&#39;<br>
&gt; use them; when they are not, &#39;on&#39; falls back to POSIX locks wi=
th a<br>
&gt; warning.<br>
&gt; <br>
&gt; This series adds a fourth value, &#39;posix&#39;, which explicitly for=
ces the<br>
&gt; use of traditional POSIX locks (F_SETLK/F_GETLK) regardless of OFD<br>
&gt; availability.=C2=A0 The motivation is that some userspace filesystem<b=
r>
&gt; implementations (e.g. FUSE) handle POSIX locks correctly but do not<br=
>
&gt; fully support OFD lock semantics.=C2=A0 Issues with OFD support detect=
ion<br>
&gt; on underlying file systems and some OFD guarantees not being fully<br>
&gt; supported can prohibit users from using the default OFD locking.<br>
&gt; Previously, users in this situation had no way to force POSIX locking<=
br>
&gt; without disabling locking entirely.<br>
<br>
Don&#39;t the OFD locks silently degrade into POSIX lock semantics<br>
when used over FUSE ? If not, what is the behaviour problem<br>
you&#39;re seeing ? <br>
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
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D=
"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div><span style=3D"=
color:rgb(0,0,0);font-size:small">Dr.-Ing. Silvan Kaiser</span></div><div d=
ir=3D"ltr">Quobyte GmbH, Berlin, AG Charlottenburg HRB 149012 B, <span>Feli=
x</span> Hupfeld, Bjoern Kolbeck</div></div></div></div></div></div></div><=
/div></div></div></div></div></div></div>

<br>
<span style=3D"font-size:x-small">Quobyte GmbH, Berlin, AG Charlottenburg H=
RB 149012 B, Dr. Felix Hupfeld, Dr. Bjoern Kolbeck</span>
--0000000000008732e9064dffc34e--

