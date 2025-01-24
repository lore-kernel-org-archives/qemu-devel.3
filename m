Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61848C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 14:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbKZM-0007hK-I2; Fri, 24 Jan 2025 09:22:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tbKZI-0007go-Fh
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 09:21:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tbKZG-0001yM-HG
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 09:21:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737728513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7m0mWf53NZj1YKSMelNoYrb1Nc3g4uHIAELjqyrC0+g=;
 b=Jpt0UD1q6fG8lwQHTsoSw/ifmj646l/vtSnuKP961T/BZ6YXVeEgwXhn0eMpbKSVuWKK5j
 UFRS1doCBKKMFjcNrL0K29sXc0pgMf7s3Fv0Zr+DsDeyL9n0EjGeMXSGXM2al1/i0SUc9Z
 G2E5HNtHRcV9qoYw9Uu9kkdKUdYbTh8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-Aj-Qgk6wN5OElYEVUpLrgw-1; Fri, 24 Jan 2025 09:21:51 -0500
X-MC-Unique: Aj-Qgk6wN5OElYEVUpLrgw-1
X-Mimecast-MFC-AGG-ID: Aj-Qgk6wN5OElYEVUpLrgw
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3862be3bfc9so1177081f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 06:21:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737728510; x=1738333310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7m0mWf53NZj1YKSMelNoYrb1Nc3g4uHIAELjqyrC0+g=;
 b=VCqI84yQdzw8u60FHJrcEe30sFX7uQbgJRlHMvWMoZY36oGjPhUwybUiBXPTWmYw9z
 PXG+7E09ErQh09Z2KyxTB8k5GM666TKWga6p4qBlIQU3HQDR2zk7l9sWFljm5owjukRX
 2j0WRWAPieaIsdwuJTl2suAUN3vTQLJ45M2JFVpmasia8PCxJCLpQCTkpNdgmOuMLbD8
 Njb9FgiieX6yHfd9YD093L9++CFzL/wXHW4BpzGIS9BxyK5eWm0mKaAFyqDLwS/NW2Px
 2UYVEkZd7T2oeCOxmLHedAAQ2v/JzFDT7jpn9Lihm0R5QfbvUltb/hWNUMIv7rDTNK0D
 tNjw==
X-Gm-Message-State: AOJu0Yyw41UAsffREymFNnMoDhET2TvvcaeMXLZ2UHXKnU0zLWPWqoUd
 /UWy6U81tT1X9Mu3QIoQkMFJR+isOrByzrTMDywkpmcFtjNukDwzFK8lPmLyMceDf7httivBjF3
 h5XhdlFpTwoxf9gPyiFY9scUd/z13Zq9hmhOdO1tHGn3oeTrW6luP
X-Gm-Gg: ASbGncs5IuNGAGR4eow4uTXwylPzDkVOzkAeZ/JSKluZIHYtkxzkdg83llNYCGcAPBw
 F/HsLIqudP6Xxuv6cN2fmOVcAnq1j9VkF752qpf5o1YgBNsKd1NfOLRFa3FMxzxYX59IzwtiJMe
 FQLDPsc7z9SH3QW8ur/qu4Jcte3KxrcbBd/rNIkL6vSz9J8QR7I+UozQ8w1NxmemMyvA+aQFUi4
 3JPbdsGj93YtluFvAJRlEHUAB6S4VzIHqlxk5l7h1gYBQ8u9bBec1sY4OUHT5I5Rmn5eF1i+b6y
 B1CzKlWlT/GT69zpWdPBH+CcOaH+Cit3E/Qz1P85zQ==
X-Received: by 2002:a5d:64ed:0:b0:385:e30a:394e with SMTP id
 ffacd0b85a97d-38bf56555ffmr28754072f8f.3.1737728510098; 
 Fri, 24 Jan 2025 06:21:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWI3VUthPbWIeD90fv9QqC+NjxTupnrJ7u3ho9coXSZcPvDTr6TbJuK7l9pJGQMCm2eMALZQ==
X-Received: by 2002:a5d:64ed:0:b0:385:e30a:394e with SMTP id
 ffacd0b85a97d-38bf56555ffmr28754045f8f.3.1737728509711; 
 Fri, 24 Jan 2025 06:21:49 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17640csm2942360f8f.18.2025.01.24.06.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 06:21:49 -0800 (PST)
Date: Fri, 24 Jan 2025 15:21:48 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 pbonzini@redhat.com, npiggin@gmail.com
Subject: Re: [PATCH] tcg: drop qemu_cpu_is_self() in
 tlb_flush_by_mmuidx[_async_work]
Message-ID: <20250124152148.706e88c2@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250123122343.6af8a6e1@imammedo.users.ipa.redhat.com>
References: <20250123094511.156324-1-imammedo@redhat.com>
 <87frl9ls4g.fsf@draig.linaro.org>
 <20250123122343.6af8a6e1@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 23 Jan 2025 12:23:43 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 23 Jan 2025 10:52:15 +0000
> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>=20
> > Igor Mammedov <imammedo@redhat.com> writes:
> >  =20
> > > QEMU will crash with following debug enabled
> > >   # define DEBUG_TLB_GATE 1
> > >   # define DEBUG_TLB_LOG_GATE 1
> > > due to [1] introduced assert and as it happenstlb_flush_by_mmuidx[_as=
ync_work]
> > > functions are called not only from vcpu thread but also from reset ha=
ndler
> > > that is called from main thread at cpu realize time when vcpu is alre=
ady
> > > created
> > >   x86_cpu_new -> ... ->
> > >       x86_cpu_realizefn -> cpu_reset -> ... ->
> > >           tcg_cpu_reset_hold
> > >
> > > drop assert to fix crash.   =20
> >=20
> > Hmm the assert is there for a good reason because we do not want to be
> > flushing another CPUs state. However the assert itself:
> >=20
> >   g_assert(!(cpu)->created || qemu_cpu_is_self(cpu));
> >=20
> > was trying to account for pre-initialised vCPUs. What has changed?
> >=20
> > cpu_thread_signal_created(cpu) is called just before we start running
> > the main loop in mttcg_cpu_thread_fn. So any other thread messing with
> > the CPUs TLB can potentially mess things up. =20
>=20
> it reproduces on current master, so yes it likely has changed over time.
> I've just stumbled on it when attempting to get rid of cpu->created usage.
>=20
>=20
> > > 1)
> > > Fixes: f0aff0f124028 ("cputlb: add assert_cpu_is_self checks")

bisection points to (so above fixes was a wrong one):
  30933c4fb4f3d tcg/cputlb: remove other-cpu capability from TLB flushing
which has replaced a check with assert:

-    if (cpu->created && !qemu_cpu_is_self(cpu)) {
-        async_run_on_cpu(cpu, tlb_flush_by_mmuidx_async_work,
-                         RUN_ON_CPU_HOST_INT(idxmap));
-    } else {
-        tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
-    }
+    assert_cpu_is_self(cpu);

should we revert that instead?

perhaps also drop 'cpu->created' check in  assert_cpu_is_self as it
obviously doesn't work.


> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > >  accel/tcg/cputlb.c | 4 ----
> > >  1 file changed, 4 deletions(-)
> > >
> > > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> > > index b26c0e088f..2da803103c 100644
> > > --- a/accel/tcg/cputlb.c
> > > +++ b/accel/tcg/cputlb.c
> > > @@ -381,8 +381,6 @@ static void tlb_flush_by_mmuidx_async_work(CPUSta=
te *cpu, run_on_cpu_data data)
> > >      uint16_t all_dirty, work, to_clean;
> > >      int64_t now =3D get_clock_realtime();
> > > =20
> > > -    assert_cpu_is_self(cpu);
> > > -
> > >      tlb_debug("mmu_idx:0x%04" PRIx16 "\n", asked);
> > > =20
> > >      qemu_spin_lock(&cpu->neg.tlb.c.lock);
> > > @@ -419,8 +417,6 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t =
idxmap)
> > >  {
> > >      tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
> > > =20
> > > -    assert_cpu_is_self(cpu);
> > > -
> > >      tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
> > >  }   =20
> >  =20
>=20


