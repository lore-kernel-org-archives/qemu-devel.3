Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEF0D4979F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 05:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHzEs-0003cc-JG; Mon, 02 Dec 2024 00:44:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tHzEp-0003bv-P3; Mon, 02 Dec 2024 00:44:51 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tHzEo-0003nU-5B; Mon, 02 Dec 2024 00:44:51 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21577f65bdeso5800635ad.0; 
 Sun, 01 Dec 2024 21:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733118288; x=1733723088; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6yp+gIC6r4l1ghEq9gnByCsBrBPB/dzqXzMHICeBB0k=;
 b=jdS5Ad6aMXhjQ5jtmzvUpktDiBWAYE1E1fZ+XBzF4zCAu8S02a3nuMn9+vp5g2kViz
 pA8tvTfRnwLXkoUDOiKZVSLQqrk4cgiMoh+N44qtduCAiyjdZtCaNVY5XkUHc/O4q3Wp
 joCMbC3gFVtkPFNOafJuDhJh4+JUW9LlIEYBUoEeUEUaqYkZraO28XU9lxG1qOqd3TQq
 GRLHBjmPZCSaiprol1v1ejHIlynDrKpqfGRYSUapLAuSSQUsYmRrpZmtoHNx9XB/XkEV
 zMhOrMHWbxZ1Mjs0ZWC8aLmy7yxwJlxi+Spb6IVYIYw6LXZuuxjygozubuW5HNWewV3C
 dv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733118288; x=1733723088;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6yp+gIC6r4l1ghEq9gnByCsBrBPB/dzqXzMHICeBB0k=;
 b=UnSAfhQSw8R1Ehg0yWwa3GO6pPW7Dt+gMFuvGvigniIkpzPmoJd3zqlFPa9AXmgBHF
 tVC4fy+m8VYM2mwHTgN/3LNSgLWJpYFGPGeZQbkdCbdGnoA+J3DBurWi/4p8CFcR3q80
 IIkvAXGY7HHnj5ZrFYSoU3DsQ0xPikkuKIVujMy20RMis/oxAf7o380U6DHC/7qcR297
 UyZbvjTCWM3aIargrhr6/G+ONMfI46EKAXCUU1mQctWY33C8P2IES6FOHfXTZgZ/CbNx
 tPxJxVMZmSFBJdoAhwP5bVYKmMxhCUUDvEGvdkBkJZyw/8KuzNXcf9vIDxW/BjGMKDRY
 epsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTB7Y2lRVBMDdzsa+tJAQ22jBE+WISECESL7WsqGoBRvdh5N8bN1lacOqcBYTaM62pOAVY/j3dVQ==@nongnu.org
X-Gm-Message-State: AOJu0Ywpr71E8eDLgmfmF9I71mbvmLfqtlPOfBRN6DxeYc2oZJqBmmw8
 byTWCtgXsjHeQvX6s/wd+QIA8MGpeu84ExTRzjlpOjjFGih8kEynqzBhBg==
X-Gm-Gg: ASbGnct7xriIkXZ1BLu3Mz1+MhI/siLLj+nqe3gTy2YQHhizhF6yxyPtB7Yyd3Pra65
 0gkICEL8oZk4y9bX1iHtj5gjnD8pEI0HuZ0ZBJaiX9QS7hSiVKB+/XlfH2nH+WykzYDEkFK8UWz
 R6YZyZMdUmQrMU5MNetNcLSCuxKnzaaKqbuP6JLB3wXUiB56O2s6wNaZn89BQILgO3ZUiVtzo3K
 OUj0oirTYHs1biVrKwv6OPrKzsRl76DMTn4u1SHn72sVuHd3ZG15RuXTzZDCdn2gmhOk6s=
X-Google-Smtp-Source: AGHT+IGn4Xo1KjFTgVo1YV2Rjelo/ltZCMkdVurcv6maCRP6/2uWp0T+EHN/HflG0VPc/LeHiJBoZw==
X-Received: by 2002:a17:903:32c4:b0:215:58be:334e with SMTP id
 d9443c01a7336-21558be364dmr148525195ad.10.1733118288048; 
 Sun, 01 Dec 2024 21:44:48 -0800 (PST)
Received: from localhost (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2155337b660sm36951565ad.69.2024.12.01.21.44.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2024 21:44:47 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Dec 2024 15:44:43 +1000
Message-Id: <D60Z5O1ZUVYA.3LX968A8RVHMN@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: Re: [PULL 0/6] ppc-for-9.2-2 queue
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harsh.prateek.bora@gmail.com>, "Michael Tokarev"
 <mjt@tls.msk.ru>
X-Mailer: aerc 0.18.2
References: <20241126171235.362916-1-npiggin@gmail.com>
 <e18a1d0a-7970-4985-80d7-99d0801d22b0@tls.msk.ru>
 <CAEuJdmoqatx0Crrd7hBFmO7sALuK2Cq8koUYwiGvMSZHZUmY7g@mail.gmail.com>
In-Reply-To: <CAEuJdmoqatx0Crrd7hBFmO7sALuK2Cq8koUYwiGvMSZHZUmY7g@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

On Wed Nov 27, 2024 at 11:22 PM AEST, Harsh Prateek Bora wrote:
> Hi Michael,
>
> On Wed, 27 Nov, 2024, 3:14=E2=80=AFpm Michael Tokarev, <mjt@tls.msk.ru> w=
rote:
>
> > 26.11.2024 20:12, Nicholas Piggin:
> >
> > > * Assorted small ppc fixes
> > >
> > > ----------------------------------------------------------------
> > > BALATON Zoltan (1):
> > >        hw/ppc/pegasos2: Fix IRQ routing from pci.0
> > >
> > > Glenn Miles (1):
> > >        target/ppc: Fix THREAD_SIBLING_FOREACH for multi-socket
> > >
> > > Harsh Prateek Bora (1):
> > >        ppc/spapr: fix drc index mismatch for partially enabled vcpus
> > >
>
>
> I think at least this ^^^ can be picked for stable.
> Nick may confirm about other patches.

I would say these two as well.

target/ppc: Fix non-maskable interrupt while halted
target/ppc: Fix THREAD_SIBLING_FOREACH for multi-socket

Thanks,
Nick

