Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C624CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 14:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZX1p-0004hr-TC; Thu, 01 Aug 2024 10:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sZX1n-0004hL-FY
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:43:39 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sZX1k-0001Is-U5
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:43:39 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7afd1aeac83so1788768a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 07:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722523415; x=1723128215;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o5uEPZmBALVhkB8zBE1rg3ejDHIi7NrCyvVnKiBAGA0=;
 b=fo0ysU7FetLBT3t2pbhBYJii15g0y24TtT74zGNMYs0eYBNJzyypjtH1V+iI8KilYr
 NyaitRQRKbxHUyrLPOAe2HiVT4qbghdxErx9m2Fw15MosPl/P5Hzpyf8btTmEA1Jp6Av
 9YlU7wdXLzjHPAV7JjSnamOh7E4pmwXteZWLUQqKgkjhH8A8LPJKOdTduuq8YZKtuU3a
 MXkaPEv3aeq5H4Kdb7ht2n1O5wWHpVnvyknkixqVWlFDd4K0/a+PxDWctuIm/+RiU2yL
 dSaCH083cErcYSeBXB9LO07cBImDX3j5uWwX+DY1YgmRwFZzv4/I00E1idpIAe/KaCPt
 nZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722523415; x=1723128215;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o5uEPZmBALVhkB8zBE1rg3ejDHIi7NrCyvVnKiBAGA0=;
 b=xCvQx4NT3HAcg7f84sMe1swzjAJ3L/kwIFAA+RZtbeKkPlYKvDCJ85cQ7hlPFpHE6N
 fP9PqBRT86Mgp1/Yq3EWqqzPfO5FiI7E6H9uH0gnRqDnFPnBcfKemiHEF4Quww+i60qB
 PZgC1rfrLrWooTgkYE5mMDowBIMFNYHsOcRuvjrXGX62ludOid3cQ5mkJwAYYAzjZi5S
 eqkJINsnGyVJUBUAtGfoFKeO6Wbbg0a4wO7VfpPOIvQ9bP4yjXTfVgkTEjhmc5laFHh8
 +mm+wmBI1e83fr7cbtTCegVLWITediliS5BF7kK5ICeCqmD5S1MZVtMri5bxfu5IAdTV
 1Elg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTAZssAdHbFB4Jy/KB+8zvRrtd3j6DiM/Mj/tazn7dJqKQ/82bjthjmhhkSoX23W64AhYoTGR76uJNibo1B1QOn+xspp4=
X-Gm-Message-State: AOJu0Yymy+lGTH0QGqrlPn3JDndkVLfr9MlbUCKdOondVGwQhkq9/WsB
 z08GdIFhVVOKVgFyTQ8fhT131RKIuzF0QsOtx0a+6AUR/MnC8foCgJerpgfXb4KjSfiMeKqMLGt
 fZee6DiO6+MhnmMUbKOLjYw18R0Xt5/zzHvhnDg==
X-Google-Smtp-Source: AGHT+IF1DFJD/lOHm1JpDsBZdzS+s/gpPaFLC9VPw8NODlcRWjp/+Kck1ppZSPNWHtrxPTN5FhBGNiovzY+U/Wl40oU=
X-Received: by 2002:a17:90a:8d09:b0:2cb:5fe6:8a1d with SMTP id
 98e67ed59e1d1-2cff0934695mr2531492a91.9.1722523415019; Thu, 01 Aug 2024
 07:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240731144532.5997-1-iii@linux.ibm.com>
 <CANCZdfpw7iDr4fBmsuukA5aVzcWBgCX09DVngg1RYHtv832zQQ@mail.gmail.com>
 <fd23f7fd27a9928fd0a07b2cbe72e1487bf063c1.camel@linux.ibm.com>
In-Reply-To: <fd23f7fd27a9928fd0a07b2cbe72e1487bf063c1.camel@linux.ibm.com>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 1 Aug 2024 08:43:24 -0600
Message-ID: <CANCZdfo8+a2KugwN-q7-Whj_mVdVmefNqwyg_ApSW4FaBLmgVA@mail.gmail.com>
Subject: Re: [PATCH] bsd-user/main: Allow setting tb-size
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000451d7e061ea03c1d"
Received-SPF: none client-ip=2607:f8b0:4864:20::52a;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000451d7e061ea03c1d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:25=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com>=
 wrote:

> On Wed, 2024-07-31 at 15:21 -0600, Warner Losh wrote:
>
> On Wed, Jul 31, 2024 at 8: 45 AM Ilya Leoshkevich <iii@ linux. ibm. com>
> wrote: While qemu-system can set tb-size using -accel tcg,tb-size=3Dn, th=
ere
> is no similar knob for qemu-bsd-user. Add one in a way similar to how
> one-insn-per-tb is already
> On Wed, Jul 31, 2024 at 8:45=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.c=
om>
> wrote:
>
> While qemu-system can set tb-size using -accel tcg,tb-size=3Dn, there
> is no similar knob for qemu-bsd-user. Add one in a way similar to how
> one-insn-per-tb is already handled.
>
>
> Cool! Are you using bsd-user and need this for some reason? Or is this
> purely theoretical? Is there a larger context I can read about somewhere?
>
>
> I needed this on Linux in order to debug an issue where I suspected full
> TB invalidation may be an issue.
> It turned out to be something completely different, but I found it useful=
:
> setting it to, e.g., 4096 makes full TB invalidation very rare, so if a
> problem is still reproducible, then the root causes is something else.
> Philippe suggested to implement this for BSD as well in order to keep the
> interfaces in sync.
>

Excellent! Thank you for taking the time to do this! And the other bug fix.
Both have been queued to my first post 9.1 pull branch.

Warner

--000000000000451d7e061ea03c1d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 1, 2024 at 2:25=E2=80=AFA=
M Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com">iii@linux.ibm.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div class=3D"msg-6262023560108835313">





<div><div>On Wed, 2024-07-31 at 15:21 -0600, Warner Losh wrote:</div><block=
quote type=3D"cite" style=3D"margin:0px 0px 0px 0.8ex;border-left:2px solid=
 rgb(114,159,207);padding-left:1ex"><div style=3D"font-size:1px;color:rgb(2=
55,255,255);line-height:1px;height:0px;max-height:0px;opacity:0;overflow:hi=
dden;display:none">On Wed, Jul 31, 2024 at 8:=E2=80=8A45 AM Ilya Leoshkevic=
h &lt;iii@=E2=80=8Alinux.=E2=80=8Aibm.=E2=80=8Acom&gt; wrote: While qemu-sy=
stem can set tb-size using -accel tcg,tb-size=3Dn, there is no similar knob=
 for qemu-bsd-user. Add one in a way similar to how one-insn-per-tb is alre=
ady</div><div> </div><div style=3D"font-size:1px;color:rgb(255,255,255);lin=
e-height:1px;height:0px;max-height:0px;opacity:0;overflow:hidden;display:no=
ne"></div><div> </div><div dir=3D"ltr">On Wed, Jul 31, 2024 at 8:45=E2=80=
=AFAM Ilya Leoshkevich &lt;<a href=3D"mailto:iii@linux.ibm.com" target=3D"_=
blank">iii@linux.ibm.com</a>&gt; wrote:<div class=3D"gmail_quote"><blockquo=
te type=3D"cite" style=3D"margin:0px 0px 0px 0.8ex;border-left:2px solid rg=
b(114,159,207);padding-left:1ex"><div>While qemu-system can set tb-size usi=
ng -accel tcg,tb-size=3Dn, there<br>is no similar knob for qemu-bsd-user. A=
dd one in a way similar to how<br>one-insn-per-tb is already handled.<br></=
div><br></blockquote><div><br></div><div>Cool! Are you using bsd-user and n=
eed this for some reason? Or is this</div><div>purely theoretical? Is there=
 a larger context I can read about somewhere?<br></div></div></div></blockq=
uote><div><br></div><div>I needed this on Linux in order to debug an issue =
where I suspected full TB invalidation may be an issue.</div><div>It turned=
 out to be something completely different, but I found it useful: setting i=
t to, e.g., 4096 makes full TB invalidation very rare, so if a problem is s=
till reproducible, then the root causes is something else.</div><div>Philip=
pe suggested to implement this for BSD as well in order to keep the interfa=
ces in sync.</div></div></div></blockquote><div><br></div><div>Excellent! T=
hank you for taking the time to do this! And the other bug fix. Both have b=
een queued to my first post 9.1 pull branch.</div><div><br></div><div>Warne=
r=C2=A0</div></div></div>

--000000000000451d7e061ea03c1d--

