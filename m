Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E38E77188
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 03:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOpku-0000CQ-5a; Fri, 20 Dec 2024 22:02:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOpks-0000Ba-8B; Fri, 20 Dec 2024 22:02:14 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOpkq-0000YW-OU; Fri, 20 Dec 2024 22:02:14 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21619108a6bso21983785ad.3; 
 Fri, 20 Dec 2024 19:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734750131; x=1735354931; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/3aRjoQkknR7uTr8TbkjIQYe4OCWmfZ+1E+mdlllKdA=;
 b=JB1MxycUPV65Z+crXmtb27dVycRTgQElyeBtQ3wsay1UN0MgLCRaFDyqOJ9LexeL8E
 LNpbXYhD+qW7KVEu41QPrqiWvLhcaigB8z7XD+j9+aMTqOPqV5t76k2ExJaJN5cUXsqs
 IEc5dfuMjKc5xuQnnnI63mIz+BOzAVQpVPOJnfR+jMqlIKABP9IsKtfn0v5clmNp7uZC
 RvpFIuTjFFrvhtGF4of2M6e42OXTpOI/79aghNzZXq1XLntCruF7uAB8aFLad7jIlzgr
 Q3g4wefGHaKtNeGBt1+fm+1XVXn1YnkFKzrc8OtqsNnULgg3naXl3sRByQQfssK2uF9f
 lngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734750131; x=1735354931;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/3aRjoQkknR7uTr8TbkjIQYe4OCWmfZ+1E+mdlllKdA=;
 b=qZMgHHIPC/wWTZdd3N5AzslCJJDHDWhm2OZmcszU1pYyDGz6cLM+urgmVTPpuxfvKR
 p6yr41ywuD4jET4vemt8TrFIha2r6TABqUlOEDdqD/2L3oiUkl3geMQwG/quc1QDWrnb
 RIXvkFRtMDVIsIyQner5Gydf6Y24uPBJtyPkK66kCdRr6TJCmFPY2OCqC3vzDu5KD+Ps
 qi6ArEguzdsgXOxg0NwtoI3saPC1l5P1AQ369qIuU23govFvOoiBcaPh1Ox23WAJCP8y
 6nzO0pzQNaLoWJV0Fwn7+nUYl8rXGxRKPmOO2apW1eYUSGGoU/9hcLMPFyxzNaSO1OeB
 Cntg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb3Ku5z7f6/1mjLNe9PaNUevjM19Tul7o8XvK7pq+WgmdsrG7M6J5T1ybWVGNZAIa8OmyFmau5hLWe@nongnu.org
X-Gm-Message-State: AOJu0Yyy9YnY2EkRcXxnkmXGX+X9LCufOcDrwmJUY3cIjCzdek2Nu8LA
 u/35PKIog1vz7vMGsSgKysDcA944TiPk8YsVYO342BE5zkMRzEaU
X-Gm-Gg: ASbGncsauL0I4ik3fpeKD9lAt3jxzrhWMekhm6+MXGRtsbAb03+kwVH52gLc2+DP6/9
 n7LTxhLjkoOHUu48KGws+PJZa+/a9ekX+8Mio5ZHTEwmWYCGET9Zs0aA/n/DVI5k2rYSXTllgw7
 +DnI05p4aIb490MUQwZHbNxuRLT+7t7FeddwembnXxLueyaO5G0SRYGczryrXwymZ1JWWWrUQzm
 rYILTaIdckavU0V2XGU+M5V8JVBQPCBq8wXZdeeBfd90C4yHuL/
X-Google-Smtp-Source: AGHT+IFMX4Xhk4VXDa7GcEZdAcDJ8ayqe5G40rmCRI1lz5wdLLjN99S25nFgan5ln8PvFsGmGIBQfA==
X-Received: by 2002:a17:903:2cc:b0:216:2dc5:2330 with SMTP id
 d9443c01a7336-219e6f0e6d3mr80296095ad.36.1734750130613; 
 Fri, 20 Dec 2024 19:02:10 -0800 (PST)
Received: from localhost ([203.221.215.169]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc962dd6sm35783675ad.23.2024.12.20.19.02.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 19:02:10 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Dec 2024 13:02:01 +1000
Message-Id: <D6H1LG4QEYL3.3B6MWT5ZTMAQG@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, "Kevin Wolf"
 <kwolf@redhat.com>, "Hanna Reitz" <hreitz@redhat.com>, "Pavel Dovgalyuk"
 <pavel.dovgaluk@ispras.ru>, "Paolo Bonzini" <pbonzini@redhat.com>, "Stefan
 Hajnoczi" <stefanha@redhat.com>, "Fam Zheng" <fam@euphon.net>, "Ronnie
 Sahlberg" <ronniesahlberg@gmail.com>, "John Snow" <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Jason Wang" <jasowang@redhat.com>,
 "Vladimir Sementsov-Ogievskiy" <vsementsov@yandex-team.ru>, "Fabiano Rosas"
 <farosas@suse.de>, "Dr. David Alan Gilbert" <dave@treblig.org>, "Markus
 Armbruster" <armbru@redhat.com>, "Michael Roth" <michael.roth@amd.com>,
 "Wainer dos Santos Moschetta" <wainersm@redhat.com>
Subject: Re: [PATCH 01/17] replay: Fix migration use of clock for statistics
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Peter Xu" <peterx@redhat.com>
X-Mailer: aerc 0.18.2
References: <20241220104220.2007786-1-npiggin@gmail.com>
 <20241220104220.2007786-2-npiggin@gmail.com> <Z2Wb7T8oH0xbk576@x1n>
In-Reply-To: <Z2Wb7T8oH0xbk576@x1n>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

On Sat Dec 21, 2024 at 2:31 AM AEST, Peter Xu wrote:
> On Fri, Dec 20, 2024 at 08:42:03PM +1000, Nicholas Piggin wrote:
> > Migration reads CLOCK_HOST when not holding the replay_mutex, which
> > asserts when recording a trace. These are not guest visible so should
> > be CLOCK_REALTIME like other statistics in MigrationState, which do
> > not require the replay_mutex.
>
> Irrelevant of the change, should we document such lock implications in
> timer.h?

I guess the intention was to try to avoid caller caring too much
about replay internals, so I'm not sure if that will help or
hinder understanding :(

I think the big rule is something like "if it affects guest state,
then you must use HOST or VIRTUAL*, if it does not affect guest state
then you must use REALTIME". record-replay code then takes care of
replay mutex locking.

Does get a little fuzzy around edges in code that is somewhat
aware of record-replay though, like migration/snapshots.

(Pavel please correct me if I've been saying the wrong things)

Thanks,
Nick

>
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  migration/migration.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 8c5bd0a75c8..2eb9e50a263 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -3433,7 +3433,7 @@ static void *migration_thread(void *opaque)
> >  {
> >      MigrationState *s =3D opaque;
> >      MigrationThread *thread =3D NULL;
> > -    int64_t setup_start =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
> > +    int64_t setup_start =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> >      MigThrError thr_error;
> >      bool urgent =3D false;
> >      Error *local_err =3D NULL;
> > @@ -3504,7 +3504,7 @@ static void *migration_thread(void *opaque)
> >          goto out;
> >      }
> > =20
> > -    s->setup_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start=
;
> > +    s->setup_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - setup_s=
tart;
> > =20
> >      trace_migration_thread_setup_complete();
> > =20
> > @@ -3584,7 +3584,7 @@ static void *bg_migration_thread(void *opaque)
> > =20
> >      migration_rate_set(RATE_LIMIT_DISABLED);
> > =20
> > -    setup_start =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
> > +    setup_start =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> >      /*
> >       * We want to save vmstate for the moment when migration has been
> >       * initiated but also we want to save RAM content while VM is runn=
ing.
> > @@ -3629,7 +3629,7 @@ static void *bg_migration_thread(void *opaque)
> >          goto fail_setup;
> >      }
> > =20
> > -    s->setup_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start=
;
> > +    s->setup_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - setup_s=
tart;
> > =20
> >      trace_migration_thread_setup_complete();
> > =20
> > --=20
> > 2.45.2
> >=20


