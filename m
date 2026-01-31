Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27E5D49C9E
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 00:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlyXl-0004cU-9e; Fri, 30 Jan 2026 19:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vlyXf-0004bx-6o
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 19:08:48 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vlyXc-0004CD-VR
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 19:08:46 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-34c93e0269cso2263549a91.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 16:08:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769818121; cv=none;
 d=google.com; s=arc-20240605;
 b=VIexl1P5JbYfmsQVII8IJfQUbhAzDlxQEFbS1bO1koFhqaWkgKdIyseBV3vYrERdUT
 NaxxiWLBIsre0WO3K5blr3gqZIs4QsCVJefanA0Hih4VfyjswM0pcDFQ3rRDIEdOJ6SE
 3txn/NeZt/BYv3BbuTEhiJrU3mXCZTfkAgEKlo281Meth6KmGNpt6Li2zHicWvJNUr18
 nqn+fofSUgJSeffovlluMPm4TPOqZrALpJ5OIh+pjfl7oqFbaOBODq1p7U3XhAAipjL5
 Xogc9n7mDD913lfHT20UetoSTeTGfmRaVXEmq4kNXuyxudXqpUsX1LSRHqk/MizVJA0V
 LMZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=xHqL5L3Hj/ocHNVQ/Mpso4fgxoNVxMLSjD754BUuDcI=;
 fh=VqS+tPLsGlswY454e0dYtkegTr3u8RL39VDhCWIP5Lk=;
 b=lgtYChBxW6C1Yb6p24mNTWDdVCKCvZw3eDR7ATjV99QPSrzUxzb9gOUAZB8oFKdVka
 l/2KOJykZCxdUNem5AR9zuHHsFCEFTI/GMguz64hzgVztxh0Wc0EsjDgaXe7Nc10av1P
 Iq1rSOJYXtWsFgwIW7zKiGfsX3E+blX3dT9y0Z315dlcVYzbcI68wvMIbp+Tg2E8H1pf
 3FHhNxLh7QnsgORwAXnegHuZDCf4VDz3/chX9EQz4Jfy4QoW0f6nkV/J91mbo2yoj6kn
 VDhPqNkfSD8bFGAGVEmMEhWXhPxzYnVvrmN1ymVXVF1FuHDWQTg4Rw2D5V4fxQjBZkxh
 a/nA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1769818121; x=1770422921;
 darn=nongnu.org; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xHqL5L3Hj/ocHNVQ/Mpso4fgxoNVxMLSjD754BUuDcI=;
 b=bhj+kw9SQh2TqmuR7AQGvsMiK7u+WcnIFF9tLmRcBNn6y7h+TlxzSHx7W0FsR8b6+r
 WcELd7ZsvYuEIkAZlj+7I3geW46P3fm/s1vpWI9bzYR0MKCMW+HW1I41Z2dfjOOOSll0
 1D84DLONhgdehGJvXLRs0Njrtto1YSvYBRrJC3960hN7KZHBe7byUih7UxPEcdmz/SMr
 /1K0IUHaSjWyowa5k8/n2jbN0bkLDVgviTlrDVHTXVHe947s8zdX1QC9qzomfDwg//kA
 g8i57QZdMw4VN2w9jTg1iAJ9p51ruyAw2ZOjP3/WEJyd1A5KRfwAF2Ccl1aATYJw1Eev
 zLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769818121; x=1770422921;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xHqL5L3Hj/ocHNVQ/Mpso4fgxoNVxMLSjD754BUuDcI=;
 b=ezqHBClhuZ0hfshnniqzKkhY9+JeGpG/PsixkTAAg9PUHb1u5w7bpAEXgeVQg+NJBG
 0MEoaBuOe7XZfREGv7+mf8JZqST4b+bGnFoNiwHluTVMZDufPytvT6EMs7Zii/thCFkA
 PDaWcr0wrPlMMrvE0smYTzsPMV2gkTQbkyWGMdJzZVCJ+Haa+fMREzNVdW3fU4PLAFQ4
 ZxagbDDmC1oOamAYiK4969aLymcMUnVEOLfg4B0dLOsS7SN2Rt5JUk+wCRejOTjPry2m
 Ge6dyRzVOhYCtT2vub9OSuBmtabWV2ltN2zE+ZejmAvWntWRmV1qkKT5tk5Nkw1kAOy8
 ZiLQ==
X-Gm-Message-State: AOJu0YwmOdSOhu6tAhGYCdvrHYF6qj+5Hy0uL/gVScpSzJO9rRFYtJQK
 wqnEUAEBnBQf6popzGveiyIiJcXSOVvPSIizy0THA/e1u3yVBE5iA2il2/+Gh422Au9MhNlzBcj
 /uicBfux0f53pKm9fFKIPN29FMeW5H1N7FEnTzo29o4CkMC75UtN7jm8=
X-Gm-Gg: AZuq6aJvRhHIh6v2IOMGyfWCe66w0wrYV2PpfSpecn3xYgMRK52qNqTZO2ypZA0ie8/
 UhNi3Fl+4fJFhFcIJCQyqwpbaAcPn4GxC/mPQ6WgvSJyyYxC1Me7k3eYz86LUEWZAvTtGbAC0Qi
 PNcG+13HroHjfB1Q+8sCkTAgdfPNc//Op9jf1FeqdEZqwMRcQZxVp+PcngMcLi662z5gNu5JH24
 ALdXEWBU0FH4oalcgAoz6RxxsNchdfwA3zHicjJ+cMqWwZw4lfp2RlVkLldrENuUE1njBo=
X-Received: by 2002:a17:90b:4d8d:b0:343:747e:2ca4 with SMTP id
 98e67ed59e1d1-3543c4a9d8amr4488077a91.9.1769818121358; Fri, 30 Jan 2026
 16:08:41 -0800 (PST)
MIME-Version: 1.0
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 30 Jan 2026 17:08:30 -0700
X-Gm-Features: AZwV_QhrT4RUskpDtKcQNRhvJzFdvtRrnvarIUV6d2vMkQ8SnxZoZFbAzhX_T9k
Message-ID: <CANCZdfr6xs9n8sF8AXVWVu9i2_rViKErrMHAVbopnaor4uCN6A@mail.gmail.com>
Subject: Question about tb_flush()
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000070de3e0649a3e42e"
Received-SPF: none client-ip=2607:f8b0:4864:20::1030;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1030.google.com
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

--00000000000070de3e0649a3e42e
Content-Type: text/plain; charset="UTF-8"

OK. I've updated bsd-user fork from last year to yesterday. I had one
question.

I see that we've gone from tb_flush() to queue_tb_flush(). Why was that?
And is it a drop in?
FreeBSD's fork has this in the thread creation:

    /*
     * If this is our first additional thread, we need to ensure we
     * generate code for parallel execution and flush old translations.
     * Do this now so that the copy gets CF_PARALLEL too.
     */
    if (!(cpu->tcg_cflags & CF_PARALLEL)) {
        cpu->tcg_cflags |= CF_PARALLEL;
        tb_flush(cpu);
    }

I think the right thing to do is to just change this to
queue_tb_flush(cpu), and that compiles. I'd like to get some confirmation,
though. Did I parse the changes right?

Everything else is mundane changes that were more annoying than difficult :)

Warner

--00000000000070de3e0649a3e42e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">OK. I&#39;ve updated bsd-user fork from last year to yeste=
rday. I had one question.<div><br></div><div>I see that we&#39;ve gone from=
 tb_flush() to queue_tb_flush(). Why was that? And is it a drop in?</div><d=
iv>FreeBSD&#39;s fork has this in the thread creation:</div><div><br></div>=
<div>=C2=A0 =C2=A0 /*<br>=C2=A0 =C2=A0 =C2=A0* If this is our first additio=
nal thread, we need to ensure we<br>=C2=A0 =C2=A0 =C2=A0* generate code for=
 parallel execution and flush old translations.<br>=C2=A0 =C2=A0 =C2=A0* Do=
 this now so that the copy gets CF_PARALLEL too.<br>=C2=A0 =C2=A0 =C2=A0*/<=
br>=C2=A0 =C2=A0 if (!(cpu-&gt;tcg_cflags &amp; CF_PARALLEL)) {<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 cpu-&gt;tcg_cflags |=3D CF_PARALLEL;<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 tb_flush(cpu);<br>=C2=A0 =C2=A0 }<br></div><div><br></div><di=
v>I think the right thing to do is to just change this to queue_tb_flush(cp=
u), and that compiles. I&#39;d like to get some confirmation, though. Did I=
 parse the changes right?</div><div><br></div><div>Everything else is munda=
ne changes that were more annoying than difficult :)</div><div><br></div><d=
iv>Warner</div><div><br></div><div><br></div><div><br></div></div>

--00000000000070de3e0649a3e42e--

