Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25260C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 21:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXTG6-000514-AN; Tue, 06 Feb 2024 16:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXTG4-00050v-K3
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:45:36 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXTG2-00079v-Hc
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:45:36 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-410009b2ca8so2027485e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 13:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707255932; x=1707860732; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XHErp0KGTgavRlz9GvC/uW7M8B0fACoQvnMJYLHayR4=;
 b=SynaagxSS/C+yDhzPvJcAwCbkZOcUgOmKd8vCTQ4CU4W9CWBxA1T08iYEDI235Dfx0
 G8hyKDWrn6gi2FSSN9TNhZcdovEg8HQMhuu379CTnSkQmCpxlxf6T5sqzAcjAx97f7hD
 lSlGjfAmuex4JMrlx3NaAPI7olhsxyNFsPq6kOT+RgKuMqcKQmuA8n5yDNBXWa+kArm+
 p2J2Q66O+qd+h5RC2S/uDTEbifq6mGzgBCHGPxXHoO5Qsrkutlim/+OlAXJFh1TeiWNE
 a+V88b130Eg3uXOS+LIrZeAKt3f2767qeQcTLqRsZaWFLGWy1zEuntVkjCSeAf/txpQa
 G5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707255932; x=1707860732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XHErp0KGTgavRlz9GvC/uW7M8B0fACoQvnMJYLHayR4=;
 b=Bp5l/ttj00pI8ro4RQQFT8o31QusMWaceHIGUZqPSPIvKkf2cTYtma4GvFl/lgqMMG
 G5F+VVslm4x6zGCg+gdEL07E+/X76dcEyVOyTq8PQTqgo8eaFoX6dAD9kE+6Li9IINbp
 kYchYfBGbYzb4Bv7pDkXNbP/devmn93bCelcKmh/jwzu7i1fznDsnStew3Lw8P7tBCiv
 71KYQ/QnN7Tcuz22FcEgqBW/eb6+Ig9o3bv3OCMhF35qmKKIqy0ACO3scsR0oHatNd2V
 0sWqsZa+6SaxUnp4+oUl65e8w915CM6dOvRoNMJW89VN2gHLXGacyh6OySWt+ozMNsRQ
 GzxQ==
X-Gm-Message-State: AOJu0Yw+3k4vXQJhTEc5lQR2xW+NSpuw9D7Bt1b4Q080pNP4CarWke1n
 bcDp3nsqWXPUFFqalV1rX2gRk5j6R3/AodMbrQ8F0U4rLat6FMVMQimwQ/RQ3wqOSrWIGNW2WS8
 iPoZm1pOZxvtv82pvPtFFcx1CNRW4i2UBRp3HZg==
X-Google-Smtp-Source: AGHT+IGnf5U7akF0KDr5GThPh4e2AvrFOYxxSOaaJlr+sda3Ldv/9Aj4VPPFDIpBWvkgHjSYRpY+NMWIyw+ag6+YeDc=
X-Received: by 2002:adf:e9c7:0:b0:33b:128d:333f with SMTP id
 l7-20020adfe9c7000000b0033b128d333fmr2269445wrn.41.1707255932300; Tue, 06 Feb
 2024 13:45:32 -0800 (PST)
MIME-Version: 1.0
References: <20240206032151.174516-1-richard.henderson@linaro.org>
 <CAFEAcA-HOfLk9RHQpR40xz98V5r7cG5Me7_Y=1ZSoFPpHXudWw@mail.gmail.com>
In-Reply-To: <CAFEAcA-HOfLk9RHQpR40xz98V5r7cG5Me7_Y=1ZSoFPpHXudWw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2024 21:45:20 +0000
Message-ID: <CAFEAcA9DaqnMJxHr5zXqDwMffKcgudLV_evJsStUCKwSyV-pJA@mail.gmail.com>
Subject: Re: [PULL v2 00/39] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 6 Feb 2024 at 21:24, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 6 Feb 2024 at 03:22, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > v2: Fix rebase error in patch 38 (tcg/s390x: Support TCG_COND_TST{EQ,NE}).
> >
> >
> > r~
> >
> >
> > The following changes since commit 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440:
> >
> >   Merge tag 'pull-qapi-2024-02-03' of https://repo.or.cz/qemu/armbru into staging (2024-02-03 13:31:58 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240205-2
> >
> > for you to fetch changes up to 23c5692abc3917151dee36c00d751cf5bc46ef19:
> >
> >   tcg/tci: Support TCG_COND_TST{EQ,NE} (2024-02-05 22:45:41 +0000)
> >
> > ----------------------------------------------------------------
> > tcg: Introduce TCG_COND_TST{EQ,NE}
> > target/alpha: Use TCG_COND_TST{EQ,NE}
> > target/m68k: Use TCG_COND_TST{EQ,NE} in gen_fcc_cond
> > target/sparc: Use TCG_COND_TSTEQ in gen_op_mulscc
> > target/s390x: Use TCG_COND_TSTNE for CC_OP_{TM,ICM}
> > target/s390x: Improve general case of disas_jcc
>
> This really doesn't want to pass the ubuntu-20.04-s390x-all job:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/6109442678
> https://gitlab.com/qemu-project/qemu/-/jobs/6108249863
> https://gitlab.com/qemu-project/qemu/-/jobs/6106928534
> https://gitlab.com/qemu-project/qemu/-/jobs/6105718495
>
> Now, this has definitely been a flaky job recently, so maybe it's
> not this pullreq's fault.
>
> This is a passing job from the last successful merge:
> https://gitlab.com/qemu-project/qemu/-/jobs/6089342252
> That took 24 minutes to run, and all the failed jobs above
> took 70 minutes plus.

Ruling out anything about this particular merge attempt:

This is a passing job from a recent succesful merge:
 https://gitlab.com/qemu-project/qemu/-/jobs/6089089816
That took 37 minutes to run (21 mins in configure-n-compile).

This is a failing job for the same commit:
  https://gitlab.com/qemu-project/qemu/-/jobs/6086439717
That took 58 minutes (26 mins in configure-n-compile).

So there's a lot of between run variation, though in that
case it was not so much as in some of these examples.

-- PMM

