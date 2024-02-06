Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C0CC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 21:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXSw4-0000iX-Uj; Tue, 06 Feb 2024 16:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXSw3-0000iA-JT
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:24:55 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXSw1-0002Jf-St
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:24:55 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-55cca88b6a5so7255862a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 13:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707254692; x=1707859492; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pO7eqJkbK2DDtOmRp2lzU4+OhwS84friZjuSZqfdgww=;
 b=zZoYC/J7bWsbkMj2NYkrFypFcrff3r9hL35rxQSjeZxvfdvH/ofJxo3kGk22mJpX5h
 lXCVSXlkRywwWFFp9WlzxTnh9ShKguKMf89vx78rcLaHebH33LwOxPTLSocBPKV44Mcv
 kJJ7BVeuchEWAeOdUk3zOwhMxKfEWaHJdgfy0zNP240N4CVdZ3y6mVCC9FKFqeD+Lk+Q
 pJkN8V+8toibckuHt+G7yHrY7ub/hW35bMaxY+bANDwMim7RrQtzV2goInPtn/Hy2XMi
 ZSnONTA1nSH5C7niC8d6nhuTRsDcAKDBDROJJq2sAX1j2pdBZ64Jv55v3L2bLoaTj1H4
 Nx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707254692; x=1707859492;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pO7eqJkbK2DDtOmRp2lzU4+OhwS84friZjuSZqfdgww=;
 b=nXJiEwXvkC6QeiDSzOwUi6SME/Xyo6vkFo+ztInwu3ubvzt0fMBAgnsGX1cdTVHGms
 nWKxBap/SkeXEWUSDrIGV0ImteN+78w80Hpn7VMyVUgIRYF2l1VL2JZEDR0eUyr/TqjO
 brv7OOzIAeOtUisSiXRd8d520HSUumk9WBFmE/LiPsj+YG3XOGgSo0EEVk9SF8EB8Ixe
 ZQ3d/d2ePG/xS4Jto9VV4PXQAD5ROw/ttSu670slqL5Agyj5ceo2TY8gXyEFaoxHAbbA
 m58CTigSvnjzpSQN4TcFubmwbLzR4fjaOncsVj4q/SCOTlTiRTDhmyepyxC2n1kH4JX9
 +dUw==
X-Gm-Message-State: AOJu0YxTEd/Gufb0pPkgcZYCfE8Ffy/IBQsjTiLYq78XKuk0dEnmp/JV
 Tp28uMxqPKL3GpfyemWLFuJJ6NmN+MLJ3Q7qEKlQ1PS8IdL8oDU8o79WDa7cVyfbAjpZBU3MYzz
 JgChr45EA6PlHAWUjC6Xv/Z3Pbdf2mtSiPr390A==
X-Google-Smtp-Source: AGHT+IEeoHFFaDDkMJM8/wcEnBRXBMC8osG9DEfOy1VbZ+ZXiv5F5Wol31MxSvuHX3D1AMfN24ttLwiK0fL0WzN4A0Q=
X-Received: by 2002:aa7:c557:0:b0:560:8010:b678 with SMTP id
 s23-20020aa7c557000000b005608010b678mr2518157edr.30.1707254692107; Tue, 06
 Feb 2024 13:24:52 -0800 (PST)
MIME-Version: 1.0
References: <20240206032151.174516-1-richard.henderson@linaro.org>
In-Reply-To: <20240206032151.174516-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2024 21:24:40 +0000
Message-ID: <CAFEAcA-HOfLk9RHQpR40xz98V5r7cG5Me7_Y=1ZSoFPpHXudWw@mail.gmail.com>
Subject: Re: [PULL v2 00/39] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 6 Feb 2024 at 03:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> v2: Fix rebase error in patch 38 (tcg/s390x: Support TCG_COND_TST{EQ,NE}).
>
>
> r~
>
>
> The following changes since commit 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440:
>
>   Merge tag 'pull-qapi-2024-02-03' of https://repo.or.cz/qemu/armbru into staging (2024-02-03 13:31:58 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240205-2
>
> for you to fetch changes up to 23c5692abc3917151dee36c00d751cf5bc46ef19:
>
>   tcg/tci: Support TCG_COND_TST{EQ,NE} (2024-02-05 22:45:41 +0000)
>
> ----------------------------------------------------------------
> tcg: Introduce TCG_COND_TST{EQ,NE}
> target/alpha: Use TCG_COND_TST{EQ,NE}
> target/m68k: Use TCG_COND_TST{EQ,NE} in gen_fcc_cond
> target/sparc: Use TCG_COND_TSTEQ in gen_op_mulscc
> target/s390x: Use TCG_COND_TSTNE for CC_OP_{TM,ICM}
> target/s390x: Improve general case of disas_jcc

This really doesn't want to pass the ubuntu-20.04-s390x-all job:

https://gitlab.com/qemu-project/qemu/-/jobs/6109442678
https://gitlab.com/qemu-project/qemu/-/jobs/6108249863
https://gitlab.com/qemu-project/qemu/-/jobs/6106928534
https://gitlab.com/qemu-project/qemu/-/jobs/6105718495

Now, this has definitely been a flaky job recently, so maybe it's
not this pullreq's fault.

This is a passing job from the last successful merge:
https://gitlab.com/qemu-project/qemu/-/jobs/6089342252
That took 24 minutes to run, and all the failed jobs above
took 70 minutes plus.

TBH I think there is something weird with the runner. Looking
at the timestamps in the log, it seems like the passing job
completed its compile step in about 14 minutes, whereas one
of the failing jobs took about 39 minutes. So the entire
run of the job slowed down by more than 2.5x, which is enough
to put it into the range where either the whole job or
individual tests time out.

thuth: any idea why that might happen? (I look in on the
machine from time to time and it doesn't seem to be doing
anything it shouldn't that would be eating CPU.)

Christian: this is on the s390x machine we have. Does the
VM setup for that share IO or CPU with other VMs somehow?
Is there some reason why it might have very variable
performance over time?

thanks
-- PMM

