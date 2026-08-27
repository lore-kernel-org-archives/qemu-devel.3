Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70649C5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSVz-0001Gs-Qa; Thu, 27 Aug 2026 01:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzSVy-0001Gc-1h
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:19:02 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzSVw-0005q9-5O
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:19:01 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cc1cc1b42b5so1282259a12.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:18:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787807938; cv=none;
 d=google.com; s=arc-20260327;
 b=TOsZWmWVEg5NJIHU7au4bOr/p2HvME9jK5YTqmNaj98eIPdcP3PwKFNVpb0xRZr6YP
 y9IJLqGLvyTmLKZKqPqwjX9vYwsC+x4SlkPdfyj9flF6QXCdJZG805vneydbuiig3dhF
 4fzuwt4awHbOWtv8o4grwhKkM3zpG1zK1c8+FEtx8l8lsOzBIiuVnmcKq+ZLjUJga6u2
 KFihh614ETDnRPPMS3Wz0BqNXXvfrdXR6TYoXI2EPYZb8/k3N3AtEIVN9oT+X8ZQMp6s
 jYHakuRtStQZnqwS5sfqH3fb0OTvQ/o91Q/qH1Esa7DS3NLzNvgEK7ToR8VJj3rBIHbZ
 ACuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BVjPHVNFtbbt4NMLfE0oYpeZ2wgFlY7nGKpNUYSowlk=;
 fh=A291yEVSkXF7nIxhNTXlrgMxx+6cdsgywmmTt9h4sug=;
 b=n/qULMWo1Lqy3w8TKnRTAQD5cBu29dP6eq/ivEMsznUPycxhv1lrRFx703q8rqiG/W
 VIfUu7/XdKF9u2eAn/up1qlnttCHSc0au7B6SWcNC2anf37+8xx2JTDNxGitoPCdew64
 0F7c9QIw/CG3yP074ZILv+NE8cU4jodsC7JoP6pUaVko2jouZQjQJo9yez2g1BRhWFsh
 GHQMhI65j4GvSrd435CXPOO1vQVDIWwP9xBDA1IgruQfcPBJloe1Mwlt9DuFIYVcAHzN
 reTPkZAkRS8sw78I5Ws6kizNLbMflVWLWnXYOQthz2+SebkY9DYbBaS5y6jrY8dVa1mt
 buWw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1787807938; x=1788412738; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BVjPHVNFtbbt4NMLfE0oYpeZ2wgFlY7nGKpNUYSowlk=;
 b=VwT/6DNAI5993GowgSPNz2Oc/+L2MNEk/hLFZqNMqZ0I1azigfEJLZ3+xMv5jGD7SX
 6DYupqIvG32sFZflSfwVQppi9olTjHhxdTacxVP5QDJPBpVoOS89qpjSriYVh/f0LOwo
 OpT62mQh7qU7gvQmZIwSSE+1CJrQbtbfL8iqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787807938; x=1788412738;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BVjPHVNFtbbt4NMLfE0oYpeZ2wgFlY7nGKpNUYSowlk=;
 b=EvIcLbhxFWWLpDKeTfYsAdYa36BWp8eRqFxlW4uv5GLASkEUKwAHXFaOx2sa1zrVHn
 /w2O5LgstdFWwN4RjSOBfzz8Fcv5tQO4zFfUo+IEOGHr362X6tHOv1jP5iaJf9sOgNsy
 ziYb2nYW5F6UDZuwg9p2xLCDcsdVfm5hHyov40AQiy65dzhHQbLfXoO/hjtms8pkfO4+
 /QHTjUMvsLqLDhyiEXq8TCFvB5L/4tj/igxf/GkdhrQRP4Y3goh713G5ub8VXSgpgck+
 sST6JBd/hTUdDbIFGe6q7QCmpv+pIbskXsNa2OPImIGobqrd38w/juRsnZq/Ax6BC7C6
 +UVQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtgMLiWrQIVwh4Q5ye3cUMBxI8nNXXMyGZZ/TPi1ehj8tei4C5sJDyNbkuxnUTImKSGwwPZHoENxwA@nongnu.org
X-Gm-Message-State: AFuF++kQzLg3lu8HrVRKjSqMoJQ+IbDchL1EHcN6EfzZJn7JAc2GuqHh
 z/hr2IaGGxgujnfr09sGlzRXXrCvM+HKJrjG+S4EfGXKst/ilTxBz8bPicakX04Ot7mA0qB98yE
 aXAFILCPghhJHZPPatJPhVwXufkPbeN4=
X-Gm-Gg: AR+sD12FcPaF0oCdQZJc4PG/dUg1Im2ntYGdkByj4o9plInQkYBHbGyz7GOo8i8HaOz
 gPjW2yD/o3GYmpN5ZMdDQkB/qe66aLf2mv0VZ7tE1vox/y4XaDIYNdghTs9r3/eypb61ht+VFOY
 rJqXnULfO5PpCJb9ZC0IPkFZIJ9HcxIGfsr8JwdlGYinv0zFG5ANjM+C2OWSrX6HUb7GjKSj0ur
 AiQmowCG/kSGLNnZwCDIwMsl3yNIAoBcE6cPsbjtgq1BNSIYhJiTNRFMaSYQS2Tr+r+DQOwrJyQ
 9ROHCe6Jt6c8Sj6PPoSmf7mzWPj6RqWPgePlS7b+Est1ydm4/m8Q0MDHcAtefYAO17uzwOMZ3tf
 XYfcusuh+1R7tWKbSRE5gPlXfqwIsY3Scx/rX5zMOW5Rps4ISDGyIOhVvKe98u5ShA9iVrEZKis
 wjx6xejEdKKcxsKcS2
X-Received: by 2002:a05:6a21:e081:b0:3c4:3112:33 with SMTP id
 adf61e73a8af0-3cf75f83f45mr20380876637.6.1787807938324; Wed, 26 Aug 2026
 22:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260802113130.7818-1-nendensu@ispras.ru>
 <e350bfda-cd57-4b25-9c72-40585e30a488@tls.msk.ru>
 <a985157941bd10429a3048618e3fb977@ispras.ru>
In-Reply-To: <a985157941bd10429a3048618e3fb977@ispras.ru>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 27 Aug 2026 14:48:46 +0930
X-Gm-Features: AcwNN1X23rdJ7vu-qDzyCNQTuwju6ArsSUxpre5apaty1dMCpUOCxPKP1b9Es0M
Message-ID: <CACPK8XfEQnEqQ923ag8kWXcvBNsxmUKZK_dCdUm-AddD2Mf0dg@mail.gmail.com>
Subject: Re: [PATCH 0/2] target/riscv: Fix seed CSR sign extension
To: nendensu@ispras.ru
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com, farosas@suse.de, 
 lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 27 Aug 2026 at 07:57, <nendensu@ispras.ru> wrote:
> > I'm picking this patch set for the currently active qemu stable
> > series (10.0 LTS, 11.0, 11.1).  However, it does not work on
> > 11.0.x already (it works ok on 11.1.x), the test fails:

> > Should I pick something else for 11.0 and 10.0 (on 10.0 it fails the
> > same way),
> > so the test succeeds, or should I drop this patch set from 11.1.x?
> >
> > Thanks,
> >
> > /mjt
> Thank you for testing. From my runs it seems that 10.0, 11.0 lack commit
> 569aa628 (target/riscv: tt-ascalon: Enable Zkr extension), which enables
> Zkr for tt-ascalon, so reading the seed triggers an assertion in
> csr_call. Apologies if I`m missing something here. I`m not sure which is
> better for stable: backporting 569aa628, or skipping the test patch.

Backporting 569aa628 seems reasonable to me.

Cheers,

Joel

