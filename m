Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B82ED4A5E6
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 08:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgf1a-00045T-RV; Fri, 16 Jan 2026 03:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vgf1O-0003RS-3R
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:17:30 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vgf1M-00081m-6V
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:17:29 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b7cf4a975d2so316088466b.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 00:17:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768551446; cv=none;
 d=google.com; s=arc-20240605;
 b=KmZ82OKVvIKeVwxlxcKNrdtdPxZGmjNOrzmfD0v8YpdRcsHt0U363+j4nYF/fT+YRz
 rVG/USyuynskeCECBlCX/rMvX/dYFFJrW9/2YIyG/NtAIH2gRNA7Zed9527YEzAxwKVw
 /T0P1TSYTmcsDfa/tUxpt05S1KnVrGEsXFxzzaLWvYmhB2MKu3uap0t0QT8QaFAyIlet
 MpE35ndI1v2+lUr8qxzkcPqUaMDnBTnPZu06N3Tf4StGZPIiZsByqxiAgS+f78NDUi1D
 vwtRO4sMY0+OMiYoUkFbwkqQUxDFx4FJXO78fBTiG0bX8nwQ766Ndixo0mLWGBrFL8t2
 rlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZbLFSN9pqTaZWsW7Tv51kV6cq099MEEUFR2Eyj6INTI=;
 fh=alzSlbJrEVf4j+8up1O0SatIUsbQdSZIvVMUSs3NYlQ=;
 b=T8XO51vHM6ppXIfL8z5wrLQzJYFmok21+F4MPsIodaOnfNlkQbakJLXscLehvdziIc
 Tolb1JzRvBMFPVecrstJoLURPzatnOWJZd6Bha9dQW+jtjaA2VuGL7t0m/v45qWVEZDA
 6HfTCnuTK2PVAWWyu0fUH6WfjGrHK06z1dYrBLl0NNASOTK7H2pSSVzK2gC/TM0ao+2A
 pCF1ZsSfJjIrthqPF5Z1y+2Nu0L/AjUyzxA9cmdbt4RxJvHLDajvvR+hE9p+qTjl/RUr
 D1O9LNMrKv/SGcsn+Bgxxu5Wj+geumR52j8LlEVLUPcLPMHU3ZqCIxcXRIhOD5rBz5BX
 ijEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768551446; x=1769156246; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZbLFSN9pqTaZWsW7Tv51kV6cq099MEEUFR2Eyj6INTI=;
 b=cI305o9r0J0MLJNWP+Kjh1LaG98dDI1GFghOtfItv9E5LBpsHWE4NpV15vaTFC8+Ng
 vsuHQcHX6mQzEA/7wBVIWdT+yGXifC/cARi++KcUKt89XKw+xT8VJrESO/hexV3CgXDz
 99oL3XOL3r7bt4djSaZyt812k/vNggkB1NS2PG55BqLyEVcgVthaaJwCn/GC0utRdTr0
 SjEAKtkHqH1QnIMr739c23d9ZbaNBcxPADsPoHLoObsfVC6r1WECRO4zrVjVm3LWJs3l
 wacmHncGTXkTGQ7pN7v15E2SbanGV8HiC0aeQuJreAoxKhldbXOlg/F2CisBWaPbfpx5
 LkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768551446; x=1769156246;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZbLFSN9pqTaZWsW7Tv51kV6cq099MEEUFR2Eyj6INTI=;
 b=Z4Cx8fIZa0b5rfYLkW17KvasPKne4+itRrIU/Kz6DZ6ocZsJ1ncxq07pn+9TdK4CwV
 SAT5f6EMGPVOIv7XiUg08cY/yc2K9nm5s4d5jCaF2T/ElZoYHPh6d+YtHfVGpVtOE3z5
 bKY720Z7QXRDrSOPo5ED31+ZAAf62R9jGR/XWpkYNJ2B155MwiAlyhwANLxuFJ9FYnel
 3J7aehD6vWhj5T0my54s0616JHRZa7XFxrVjVGoXLfn5El8oXjfFRh9+FyXGQgA1ey5e
 OswC5WXg/r36h/FJ200bZX1GjCDg4k1MzpvgEO+3DkrS6SpcIXdrzJ+LPe0JEUW14bMp
 n+Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlSC6KhM4UklEeWFFXVqV/N03gvOxdNjfboGxELWOIatt/QbdEtJ8raeLNngegN99VsIxEJjRR1aYX@nongnu.org
X-Gm-Message-State: AOJu0YytROLJICIYFDRDzAta+x4N4aVupZvNqPU1As8lMsoqlLhZqucl
 FvftnXz4uZcXk8lX9zajXk4I0qecymFMCx37isq7j54Yz0aKp7oXuQVWH2tU5KNseacoIqaKPJD
 KLCjNP/ELJJgQAeAS+YqKZA1rX6PQ+rs=
X-Gm-Gg: AY/fxX4zmu0Z3GkmzuG2mLq18qrX8gV/IDSMfPbNsNzxPB68B4NIpwIz9x+TXj7c7XN
 xUgmUrLD/ITHOM4vZCcUKY051P9nSety1+8Q8teSHxvUf8Ndn8ysWBUVgDizcnAHw5/yHPmSBQL
 WRckTxq8qy8HcPgKD9ouhfPbK3VJmVjAbUax0/wuKEgPB7aD4Pbka6zg0EnD03f4WBsekAAVLbQ
 LlOIh3rtYZueyFd5HG2Q3fB0mbqSwwxIHZvVxsOSZ3G5WyxLnqxvXga4ObBRntp3KyRFi6Q
X-Received: by 2002:a17:907:3cc4:b0:b87:2b1a:3c55 with SMTP id
 a640c23a62f3a-b8792fc438cmr220003966b.39.1768551446190; Fri, 16 Jan 2026
 00:17:26 -0800 (PST)
MIME-Version: 1.0
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
 <aWf4i7EOXtpAljGX@x1.local> <20260115224929.616aab85@penguin>
 <aWlso1w39cQnEh2t@x1.local> <aWlxY9TWGT1aaMJz@gallifrey>
 <aWl6ixQpHaMJhV_E@x1.local> <aWmIWrXjxLsqwLd6@gallifrey>
In-Reply-To: <aWmIWrXjxLsqwLd6@gallifrey>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 16 Jan 2026 16:16:48 +0800
X-Gm-Features: AZwV_QjvJRzK-O_kPoMMemGuq55c5kVSZXp1rMwJoXm73ajmcrQ775GwXWD5bP0
Message-ID: <CAK3tnvKGtCfGPqa73wyYHQbzSC_eiZWGHcMS-E=Sjbb_ngkM3g@mail.gmail.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Peter Xu <peterx@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 qemu-devel@nongnu.org, 
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, 
 Juan Quintela <quintela@trasno.org>, zhanghailiang@xfusion.com, 
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 16, 2026 at 8:37=E2=80=AFAM Dr. David Alan Gilbert <dave@trebli=
g.org> wrote:
>
> * Peter Xu (peterx@redhat.com) wrote:
> > On Thu, Jan 15, 2026 at 10:59:47PM +0000, Dr. David Alan Gilbert wrote:
> > > * Peter Xu (peterx@redhat.com) wrote:
> > > > On Thu, Jan 15, 2026 at 10:49:29PM +0100, Lukas Straub wrote:
> > > > > Nack.
> > > > >
> > > > > This code has users, as explained in my other email:
> > > > > https://lore.kernel.org/qemu-devel/20260115224516.7f0309ba@pengui=
n/T/#mc99839451d6841366619c4ec0d5af5264e2f6464
> > > >
> > > > Please then rework that series and consider include the following (=
I
> > > > believe I pointed out a long time ago somewhere..):
> > > >
> > >
> > > > - Some form of justification of why multifd needs to be enabled for=
 COLO.
> > > >   For example, in your cluster deployment, using multifd can improv=
e XXX
> > > >   by YYY.  Please describe the use case and improvements.
> > >
> > > That one is pretty easy; since COLO is regularly taking snapshots, th=
e faster
> > > the snapshoting the less overhead there is.
> >
> > Thanks for chiming in, Dave.  I can explain why I want to request for s=
ome
> > numbers.
> >
> > Firstly, numbers normally proves it's used in a real system.  It's at l=
east
> > being used and seriously tested.
>
> Fair.
>
> > Secondly, per my very limited understanding to COLO... the two VMs in m=
ost
> > cases should be in-sync state already when both sides generate the same
> > network packets.
>
> (It's about a decade since I did any serious Colo, so I'll try and rememb=
er)

Haha, that was a pleasant time~
I already explained the background in the previous email.

>
> > Another sync (where multifd can start to take effect) is only needed wh=
en
> > there're packets misalignments, but IIUC it should be rare.  I don't kn=
ow
> > how rare it is, it would be good if Lukas could introduce some of those
> > numbers in his deployment to help us understand COLO better if we'll ne=
ed
> > to keep it.
>
> In reality misalignments are actually pretty common - although it's
> very workload dependent.  Any randomness in the order of execution in a m=
ulti-threaded
> guest for example, or when a timer arrives etc can change the packet gene=
ration.
> The migration time then becomes a latency issue before you can
> transmit the mismatched packet once it's detected.
>
> I think You still need to send a regular stream of snapshots even without
> having *yet* received a packet difference.  Now, I'm trying to remember t=
he
> reasoning; for a start if you leave the difference too long the migration
> snapshot gets larger (which I think needs to be stored on RAM on the dest=
?)
> and also you increase the chances of them getting a packet difference fro=
m
> randomness increases.
> I seem to remember there were clever schemes to get the optimal snapshot
> scheme.

Basically correct. As I explaned in the previous email.
We cannot expect to lose migration for an extended period of time.
Even if the application's results are consistent, it cannot guarantee that
two independently running guest kernels will behave completely identically.

>
> > IIUC, the critical path of COLO shouldn't be migration on its own?  It
> > should be when heartbeat gets lost; that normally should happen when tw=
o
> > VMs are in sync.  In this path, I don't see how multifd helps..  becaus=
e
> > there's no migration happening, only the src recording what has changed=
.
> > Hence I think some number with description of the measurements may help=
 us
> > understand how important multifd is to COLO.
>
> There's more than one critical path:
>   a) Time to recovery when one host fails
>   b) Overhead when both hosts are happy.
>
> > Supporting multifd will cause new COLO functions to inject into core
> > migration code paths (even if not much..). I want to make sure such (ne=
w)
> > complexity is justified. I also want to avoid introducing a feature onl=
y
> > because "we have XXX, then let's support XXX in COLO too, maybe some da=
y
> > it'll be useful".
>
> I can't remember where the COLO code got into the main migration paths;
> is that the reception side storing the received differences somewhere els=
e?
>

Yes. COLO secondary have a buffer to store the primary VMstate.
And load it when triggered the checkpoint.

Thanks
Chen

> > After these days, I found removing code is sometimes harder than writti=
ng
> > new..
>
> Haha yes.
>
> Dave
>
> > Thanks,
> >
> > >
> > > Lukas: Given COLO has a bunch of different features (i.e. the block
> > > replication, the clever network comparison etc) do you know which one=
s
> > > are used in the setups you are aware of?
> > >
> > > I'd guess the tricky part of a test would be the network side; I'm
> > > not too sure how you'd set that in a test.
> >
> > --
> > Peter Xu
> >
> --
>  -----Open up your eyes, open up your mind, open up your code -------
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/

