Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB34AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIC0-0006t9-D7; Mon, 13 Jul 2026 11:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIBz-0006rB-JL
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:03:35 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIBx-0005Gf-GB
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:03:35 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-66771ded50aso5157159d50.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783955012; cv=none;
 d=google.com; s=arc-20260327;
 b=RA/burjMDu1jwhqpkx9MXZ4QxSMDawrz9IsERIFOJhnMIbOAV/0V7oJL7zVjwvndmD
 flRqLZG46ic6ulKDOBAnnGcaA6HcVKulhsQB4h08y7Mm3DdLdeR/LqMgHfvetZLh9kel
 flmuTOKpry/C0N8ZJHY8m13l/GRWSOcCo7sAsraljiTkxD024StE/nN3/uzdWhyzrALS
 8qP0LAx53Cu9E6ZC4CfOKfVrNOQ/XatrP1DbLZwSB81ryhefwChsoUvegmMmHKBVgM9n
 J+8WtB7KY5qCp4m8NpRXRurvZDUOGn7YGGJ5He9R1akStD8IUFzr62zhCoOxDvYdaCwE
 WEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1r4QDVK0B2DgpoU22GIjIOenw1fvpGBK23Nh/06PB5o=;
 fh=IyCSAWsTnJ3XhOS0rXF+4xldqNQBHmWjq2qIsJ+vbXQ=;
 b=GRQ48kXp6y8OslrCm5l8LjUKeJ7g/a41MjlbUiBIDDmn6deYv/3oCKVPl3uhmAgeIt
 L7NxyKdtLchpxGQ9FaafKgwgJ6En6r/uuPJj8vn629LpiHMS6BCR0R72EWDLgfVjG3oe
 M7fTFSCcImimyqR0eKYzKn7Rf1wdmXocEAtuWLEp8Ua4yEQjkRDieMZONtQoq34olo9j
 GtbbEv88x1FNGM9/WnOreiGGiZk2UONnqpVOLK/R31sUVyQhrN2eLnL4gz9XysxUNzij
 oxROhaS8V3RIFuI5V40jLcxW0Kb50/s4/eJXInEXdjR1NTwzUxGO6VMcMBkQZ4OxU0UK
 wyGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783955012; x=1784559812; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1r4QDVK0B2DgpoU22GIjIOenw1fvpGBK23Nh/06PB5o=;
 b=zDmM27rBYOmAu4i8jzv6ZjrbA9qlm7TDRWTe3TupHZytPmj3gB3OhL9aZx+FfDuo3M
 LxlTky63tcS05sXDSzfdzzct8y3Ktks80z6VA+loYMh8+KVtJbKX0I0lKMERAxL16zKE
 1KcXb1JAj4V+VDXaLNbDC+XjlJ3FtrqMujBGBWNcqJ2RvTuBaRl/oO1RNtCQMSOiwH1O
 rmAge75F42d8rvjqLhPc31GjCaaQYnGaMaVeGfraF6jZ/Hu8ohPiqR1HSYPevVTwptuI
 98o8P7EqtTPen0sOozpBMEjQELXU8jGEBNHv09PtGgV24zNjPVsrGBUxs+DGnBp79y6F
 PJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783955012; x=1784559812;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1r4QDVK0B2DgpoU22GIjIOenw1fvpGBK23Nh/06PB5o=;
 b=MrgYy3Yh/H7I3g8wBJKxDUAwzyFZUCyTwllvGCwHsttO0Im6VDMMpJLLLYsOWLWoNj
 8LorVpGB3eis1uaJwGPnCtOb1z+R/Tzon8c2KDNwXAZWIq9PDx7zF9PcfB0ZwFf896b8
 jljOfDqo8mrPoCzGj09DLX3sjLrh311Yj/7EDaT6/PCeLKKnVdvjgnCGbuAYUNLyW7MQ
 oLxbDZz/RZhRlNqPJ++RdnsKMv85fKB1rzL4KSEA6fkxGdvESLaDAF72FnM+CaZfCgJB
 s8hnFIYN7ENe8v54S7Vm1g4EcykbOtqiVb0eR/QVp9TCA+69ZZaR/saf64xKbX98LuI2
 G17Q==
X-Gm-Message-State: AOJu0YyIO6+dAqvqaHRA6wYQqocvUY2/c8Pm146vKeL8V4xiAdgLbT1C
 7192O1X8opxPi6lhKqyjreJdo7SOwITtF7TMgc+jA8z7haBK5E5SxWVTb/6wfWXYV1fi2x73xeO
 GfCk23Wmstyj1pviKQqy6u2hxXM2mLJWrgQpeHmiWSw==
X-Gm-Gg: AfdE7clta/K5HwNqs9p2fx87wjCiaDfO8/G+EX3fLrkYS5ztZgAkN1tiQXM/MmGZGWc
 7VA97/Ps65f3ZQkZdn6U6BbmLBEeqVQ2Rl0ng+MepP2a3KbcHA+hOO7YdmEKrGuPyMezEoaA8Oy
 0mdIas1NF2JSMx1k0cCl2nhPa1gQ1JPsMJSkngR6FlGcMN4O2Shqj65uWEhFjNOUnU12viXMDJM
 npyGMZf5MnMFYS4bzzXZBbP3meamYNJS0uxS4Nyl7tVFr0bA/o4bzmdu+99o18TvGDKmM//0Xa4
 wLTyzq3LShAJemOsA/q8i0tUAtmI52PriNHa3xH2/AMMOSqG5g1la4Hp
X-Received: by 2002:a05:690e:4885:20b0:664:ae68:33b0 with SMTP id
 956f58d0204a3-667d7cb86afmr4634881d50.81.1783955012117; Mon, 13 Jul 2026
 08:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_zmc=Vvs38Qos_gecCmGAbRgDQF-0+x85Ja66nsqrHxA@mail.gmail.com>
 <877bmz54i1.fsf@suse.de>
In-Reply-To: <877bmz54i1.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2026 16:03:19 +0100
X-Gm-Features: AVVi8CdPx6wL0sLSji1zVb6EBIlPYGyAJC-2lq-6eHzH46Sh09RySUKl6gXecr8
Message-ID: <CAFEAcA9Bkq+L-YmNP2bSqxw-09ZgD=mCUQdGQ=-wF5ySzCJhOA@mail.gmail.com>
Subject: Re: what is qemu_system_guest_panicked() for?
To: Fabiano Rosas <farosas@suse.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 13 Jul 2026 at 15:49, Fabiano Rosas <farosas@suse.de> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> >  - ppc TCG, in powerpc_checkstop(), for a machine check exception I think
>
> 1) The Checkstop state is the state the (modern) architecture prescribes
> the machine transitions to when: a) machine check happens but machine
> check exceptions are disabled or b) hard-to-recover storage errors. On
> older user manuals I also see occurrences of checkstop when (a) above
> happens and a "debug bit" is also set.
>
>   603 UM:
>   "[cpu] must terminate operation by internally gating off all clocks, and
>   release all outputs to the high impedance state"
>
>   750cx UM:
>   "When a processor is in checkstop state, instruction processing is
>   suspended and generally cannot resume without the processor being
>   reset."

Thanks. So since this is in TCG, is this for the case "we emulated
the CPU ending up in a checkstop situation", rather than "the real
host hardware is broken" ? Can the guest deliberately provoke real
hardware into this state, or is it only something you can get into
when the h/w is broken ?

-- PMM

