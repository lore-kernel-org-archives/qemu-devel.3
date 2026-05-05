Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FF8CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 12:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKF93-0006Bp-JP; Tue, 05 May 2026 08:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKF91-0006Bh-IU
 for qemu-devel@nongnu.org; Tue, 05 May 2026 08:44:59 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKF90-0002hd-1L
 for qemu-devel@nongnu.org; Tue, 05 May 2026 08:44:59 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6563f83ae9fso5488924d50.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 05:44:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777985096; cv=none;
 d=google.com; s=arc-20240605;
 b=lPVeg+AVJQ2K4NhnOoDWWkgiIwQFCg93IsZ+RYL1DNykxkvX5cVi8XnGcDqRB0IAfL
 I33jyiDcGFRjg8rWFgUijDl8d+m8Vrayi8Rwo7pKCkl6i88GMhYzEEKDKWqmBUVnjO0g
 Vp7ytCCfTROalD5fZuO7l8K6Rc3na9N7lgMY58TGQERDN3tXsSRck4zpIZSnshPFY1og
 uwWI4XJkVlc5aZEQ/6PWF2hBArSSi0gXs927LSuC3JutjuvY+X3GFdDTD9Rm5ZocSgMc
 d9ZNK35q1h5G2rKOKZkzWF+dpYWPIvPvzTUfIMelL1syiOH7S7mu/aIqRKlY/tUDSxFE
 r+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=578kcVIq70LRkE/tXCXweHBe6EoGb6qm24NJB3/Va1E=;
 fh=5ifsYViDQI4ryXXuz1S6AJZD6fiep3QdWXULqnoAMe4=;
 b=Rdqnf0QEUPJrC6mzgJbXXcAme+9CHdg7j9mW3aIDltXsGxgjx6v0QelYWhcu7yRIFT
 9fSGhe5rEQz1yh/y7b40CEkwm7UQiKsoCYGcVCPIFVPgLzrUPLy0i/cfHezkkteYeK6c
 TGdKSs13STUby6ZdokIY96DxmEZe6EPvg9ZuJK1eDTkD5tPbGtIAgIlKfl0QKMGI3kZx
 VsyAW5g7DcsDYAOc/vjiJbCX/kbYht68DrMLufaa7v4QiQUZMnMYiqtrIEwOspZoLDUV
 pfFuy/6z5xCdCqUQlVi79kcsSzXt9KqBpl2IZvxSnpe747pKDStptgiQUfxYkLO8n3K6
 Wozg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777985096; x=1778589896; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=578kcVIq70LRkE/tXCXweHBe6EoGb6qm24NJB3/Va1E=;
 b=zzUStcvWsy9N3DhIs8dTzV1guaxK/NinlTfu9IZ5kdehxc8KnLD3nW+Vk7a6SGY8oq
 kCQlPemiVedTprC80snFiDzg5e3oNDHaT9yUTqotKtKRglB09tGjdVl2qPx2N/gS5tJr
 mfEM7abEBgUOmmADtRpica5wF8qnfKJfYB7i98Djv0QjX8+JTJ8zSV2JlI2sh0y2VJ+a
 4u6Mrz0nXv/b/OsseB34kH8rdFVNVzfqnvC8kvV51T5sQuOWbcCRLWQ5Xzka9/e8LQNC
 dOi1Pu66y5KAlqYqMpDftb1EPhfVMgBqp9SaRk3RxzU/vlfqSSyg23zZqYEDkJReaGnh
 aXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777985096; x=1778589896;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=578kcVIq70LRkE/tXCXweHBe6EoGb6qm24NJB3/Va1E=;
 b=AJ2F58JAmcSDmADIx9e8cEMgxF3iyKyVu7uV5WlUVtgt7f93fgsjIXXcHPOTjeJhb8
 BvTnvNQ/Cmopf13Llkc/wdGWMBvek/FuLI0Fa2+8eP2U2ZBi6Fbx+cBQnsncRIUj8aZ0
 g91biTKggmJGY7AuATz3FWonn3lR6E5ssLVF+cUh3yZvvT8bz4UHmsdsOBKFt1ntlj3f
 U7+z/dsuFJdczXmjbtXb/6goivwBb/UHK/wn7hlSE33yckJjJTN7CceDb/Oz0bi34rXE
 r3pqls7ysuqMOGQ1HCxXe1dbEVct67nmtnJvtSjDxPIPhwRHVDv/f52P9R7TjeFLI3CA
 oXog==
X-Forwarded-Encrypted: i=1;
 AFNElJ/E8XuRtYOhhM0hDVvMMsKeYOrP1s5UgwYlQy6jkDYqW2j6QlhYWecLAGIkv5/Rkh7ID8H1Mg68NgLY@nongnu.org
X-Gm-Message-State: AOJu0Yxz+3Y3MRYYvvF0vrxk4oMIj9n3oD6sqKBu04KZeysTHHrqaWYU
 1mIQ4+A5q35irrOrIuT8u79PLVxkC62pkXxwQ+8MbQzA5EDjnBQ8JxplWFwRpKZaVVWOS7H6wj/
 8mw2WHnwpJc1q1T7GPq4kG/uXd3F90YY0dnbdD2hkSQ==
X-Gm-Gg: AeBDieshMXbE7XuW8aHDBCNwmrtf528D7f6t+NKK7sHJ9YOq7u1LZ+YTbZede9g/O3i
 7rVUwTRa9D8j4jsk8YbI3Uw2IZfXzYxxEIyO9TT81oKp+gsC9q3BfdYC0//uA0VBQE+W3f0IV+X
 aBAOy6fEk7emyiFYFB3NxSsMDW5BP29Kr/vKXAwREVYzr8ZJc2aAz3uXIlMP41G4FnnfOvYAKem
 JXGPnLNxwe3RiLzN9bFs2cosWiJj26vHjBFlUqjDCdtCuEBA/eCehH2bkbl7UAHLUQrnJ85TEDJ
 iRZ3jiNgK4tVN2HEePun4x507S/elc45+oLrk6zV4ULFpC9P/v/juqjEdv6qaTDoxnaCQ9qPZe4
 Gww==
X-Received: by 2002:a53:cb43:0:b0:651:bc3b:75c7 with SMTP id
 956f58d0204a3-65c69c7ad12mr2194525d50.11.1777985096250; Tue, 05 May 2026
 05:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260501165812.2212713-1-alex.bennee@linaro.org>
 <dc540970-bad4-4883-b4d1-9e206de8a73c@linaro.org>
In-Reply-To: <dc540970-bad4-4883-b4d1-9e206de8a73c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2026 13:44:44 +0100
X-Gm-Features: AVHnY4J1-xyzWUBDyCbLoRxS7_xgO4wk_nI4oFNbWIbJFuY8YkHPCwTerbWkSqQ
Message-ID: <CAFEAcA8OQ_h2ogT3=oDcbts-DL4VeDoitTH2or=_CH53xc6LoQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] .eca: add an issue triager agent skill
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Tue, 5 May 2026 at 13:13, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 1/5/26 18:58, Alex Benn=C3=A9e wrote:
> > While triaging the issue tracker I wondered if this would be a
> > suitable job for an AI agent. Unfortunately the OSS program doesn't
> > give any credits to run agents in gitlab. However I do have access to
> > models from my editor and ECA so I built one and tested it on a few
> > issues.
> >
> > Obviously this can't apply as is because it probably encodes too much
> > of my local setup (using pass for API keys) and uses the ECA as my
> > preferred coding agent. I assume at some point there will be agreement
> > between all the agents where skill live.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> > +workflow::Confirmed        Bugs that have been confirmed and reproduce=
d.
> > +workflow::In Progress      Someone is working on this issue.
> > +workflow::Needs Info       Issue has insufficient information to verif=
y.
> > +workflow::Patch available  A patch is available
> > +workflow::Triaged          Issue has been triaged and given a topic la=
bel.
>
> Some of these labels do not match the case of GitLab ones,
> resulting in new (duplicated) labels being created there.

Notably, the label listed here and used in gitlab is "workflow::Triaged"
with a lowercase "w", but many of the references in the SKILL.md text
get it wrong, e.g.
" - Use `Workflow::Triaged` once categorization is complete."

Similarly for "workflow::Needs Info" and "TestCase" vs "Testcase".

-- PMM

