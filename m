Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CCAE77184
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 04:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOqob-0000eC-3L; Fri, 20 Dec 2024 23:10:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOqoZ-0000bw-3h; Fri, 20 Dec 2024 23:10:07 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOqoX-0000gD-4Z; Fri, 20 Dec 2024 23:10:06 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-820b825cbfcso3067161a12.1; 
 Fri, 20 Dec 2024 20:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734754203; x=1735359003; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5AanmZRoCnbCYQR/lC9/aDm6bkUIbgKQiYO9b/9O2xU=;
 b=BtZTCZJka+oEp5BxTo2FFBjWcsQIemi6/nGQFh2T3VS74um+Fbn58uwzSW1jxGc48e
 1VLPpJ6+ijKVdQmISstAY7U+YwYrhKn50sNNb0u2JNdgNOFCqHPVhCPdxUhysGv6q48Q
 YiAclsSpBd5QylmKZzi6ypv4yIGKFsJPQN5awlM4Cp0iqNm8BnuFDuf9nH+dJ1IYDn1Q
 /MMh4qc8uhVUaiGuJPmkxqDpR/y6s2rJZwTcGK/tOUGpHx635hG+rhU+VKVRKSc3vX+i
 eYAZ8LIBrhnTYfqmsT4NOgt1VESbZTthi0RA8PVS2AkLUU+XS9vYk31fgTgYhm6RuEsu
 1rAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734754203; x=1735359003;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5AanmZRoCnbCYQR/lC9/aDm6bkUIbgKQiYO9b/9O2xU=;
 b=ISO8xh60TaWDGyFggz43ykEJluE3875MxWOOE1BB7bbIl/65LCaHmJk/X80p+cHpb+
 xcS01UOtMiXeRwGtRVW66FvaZP6ebYhG3ZxAwNJVPiQM38j3t6TCwDuV4Z4gcxN57uEG
 PkuXrsan4XNPu3kvObVZxBneUQNv5d7rh6+sjuavWtjOdGneXvcfSgB+7QnSnjZ04EvJ
 XLDiLnuFeUUf1pgWqp11Ic3oRP7ITJZq+Ddgb1Ngzg2I/3uwBYKnOo+tWWVgcYdd71XQ
 I+1LcU3IvtU5qAf0FhUJMlysbL4CBWtlPwqKVGZZg75/qXfjp6QLQUZv90zaIsegGLxt
 GREA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHySAatbyA//zjSmZvTEqbbWwxkWEvUSmC/26lvZ29DkCL+HCPqIZTz2QiCj2AQ0U0RxgdNz9HHKI=@nongnu.org,
 AJvYcCWzdbRjF/5GxK9C8kEOog1aMGRIgNQ4OTJ4E9GHF56PoxOyluYbGr9LBWEVMUf1tc0XcTRE74pR3xj8@nongnu.org
X-Gm-Message-State: AOJu0Yx0j1Jb9aeWzf2wMR9GZjo22H6Louym1hFWFAYwy9fZimmX3/Hd
 7S8mX0FEL25ptBDYuf1VNqbXoWE0GgwJG51I/bbrA2f7cr1pOGTp
X-Gm-Gg: ASbGncvkL1Ou5sdS1NMiGYlaPJxicMzUNc6exgzH7jgJNooVCgCz/V7GDWkd/9VU3dT
 8vsA2Ycvgowf3OciYKfsMpZEoQJiaNEvHtCcyDYVTSSA+gCTYrjaatSAt+kO2V9ZNecbWtcXYra
 79XPhxOiFi17rwp0cGAXQAHjACi0gbidt55TWRmoyyJ1TUY2TGWiUhnbmz4xJFwPR2sG1ifbRnd
 o5rnZLkgEuhmlqin5In9SGldVMpQZO2iIIIPMPL97OXsDV2fNf/
X-Google-Smtp-Source: AGHT+IEPaHW29MzMtzYmu6mugQl+74r55PAwH8CwxGT8eIE4eSguxynml9Vxv9yqqZV9HnBX97LFcA==
X-Received: by 2002:a17:90b:524d:b0:2ee:9229:e4bd with SMTP id
 98e67ed59e1d1-2f4536030d8mr7859813a91.2.1734754203150; 
 Fri, 20 Dec 2024 20:10:03 -0800 (PST)
Received: from localhost ([118.210.105.205]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f447882a20sm4548883a91.37.2024.12.20.20.10.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 20:10:02 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Dec 2024 14:09:58 +1000
Message-Id: <D6H31GYG88HW.35EZWFEYEE8ZO@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/5] spapr: Fix vpa dispatch count for record-replay
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.18.2
References: <20241219034035.1826173-1-npiggin@gmail.com>
 <20241219034035.1826173-3-npiggin@gmail.com>
 <4b3897e1-c9dd-45aa-bb6f-d8679fc78d25@linux.ibm.com>
In-Reply-To: <4b3897e1-c9dd-45aa-bb6f-d8679fc78d25@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x529.google.com
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

On Fri Dec 20, 2024 at 7:14 PM AEST, Harsh Prateek Bora wrote:
> Hi Nick,
>
> On 12/19/24 09:10, Nicholas Piggin wrote:
> > The dispatch count is a field in guest memory that the hypervisor
> > increments when preempting and dispatching the guest. This was not
> > being done deterministically with respect to icount, because tcg
> > exec exit is not deterministic (e.g., an async event could cause it).
> >=20
> > Change vpa dispatch count increment to keep track of whether the
> > vCPU is considered dispatched or not, and only consider it preempted
> > when calling cede / confer / join / stop-self / etc.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   include/hw/ppc/spapr_cpu_core.h |  3 +++
> >   hw/ppc/spapr.c                  | 36 ++------------------------------=
-
> >   hw/ppc/spapr_hcall.c            | 33 ++++++++++++++++++++++++++++++
> >   hw/ppc/spapr_rtas.c             |  1 +
> >   4 files changed, 39 insertions(+), 34 deletions(-)
> >=20
>
> <snipped>
>
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 5e1d020e3df..907e09c2c36 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -487,6 +487,36 @@ static target_ulong h_register_vpa(PowerPCCPU *cpu=
, SpaprMachineState *spapr,
> >       return ret;
> >   }
> >  =20
> > +void vpa_dispatch(CPUState *cs, SpaprCpuState *spapr_cpu, bool dispatc=
h)
> > +{
> > +    uint32_t counter;
> > +
> > +    if (!dispatch) {
> > +        assert(spapr_cpu->dispatched);
> > +    } else {
> > +        assert(!spapr_cpu->dispatched);
> > +    }
>
> Would it look better as:
>         assert(!(dispatch =3D=3D spapr_cpu->dispatched));

I think I wanted to know which way it was failing, but I guess
assert_cmpint() will tell us? I'll change.

>
> > +    spapr_cpu->dispatched =3D dispatch;
> > +
> > +    return;
>
> Returning here unconditionally makes below code unreachable.

Good catch. That was a testing hack. Will respin and retest.

Thanks,
Nick

