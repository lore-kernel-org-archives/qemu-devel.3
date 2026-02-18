Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93948E9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 18:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsmQJ-0004v5-8A; Wed, 18 Feb 2026 13:37:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsmQH-0004uj-Fw
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 13:37:17 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsmQG-00045G-08
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 13:37:17 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-78fc4425b6bso1325187b3.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 10:37:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771439834; cv=none;
 d=google.com; s=arc-20240605;
 b=IqBvPMK/jOIO8+8+7b78VdiQ0fguXnPLTHbByICe0UC97cMRoE73FrhtQUL9hSN7Ee
 2pg3JYJTBcWbLbA+qVzHVZDeF/rN8QMq8zB4y6Or6DDTGhYPl/+IyCDoHHJ+mQUnF9JD
 XLmi6sS7Cn24YCaGg9cDj2XW8TA1evtdovxdIySOeKLPJdxunbQBlKnoe9vlIhCXBb3g
 K9ald8o947LTbh/CAF8oiNrx79E7KDYIXWer1art6xL8SuVrTPB/ScyZxGlm5+x3iMIP
 3geqyzT6+8+X95se2QOETI1C/QfMvJImXr01cP3JyZ4BdHpW3cfCMW5ZZ7Q2pQyFuSLH
 QSHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=44EEzCK8wsogbyPOQe5WaZgG5z0u5zw9+yNPgn+TjLw=;
 fh=QwYyyUxj49fE3r2/5S05Hg3zHNtF3HBjcsjpjamgaAA=;
 b=dZprqYMNtTTN54f1pWPfp1AnfLbC0ZyzvgijmljbdSnaZ8hgR+hef8YUzqkjOrT+1n
 m//MOayvrdrM18x+YWJRlRbX6lPSiogV7CWODSrkJ7eh4spy7lq7IZXLNI1SI72N+nli
 qdtjD+s8ZNzogtuDQBbeo3aJSawBpq8/ycPkFowvQltJAwvt8tekHwFzJIs4fMJ3IxUy
 G93fNyGdnhS+Aj7khMM/NvrdAge3Ee0wQ6Te3mVxC4j+FgXNfs7yQ6Ncy6b5PHFa4Wtr
 DPQ3hdhnzLgJ0AnoRLEqx9yPjmaFzO5wHhGnA7aw8fx7EIZQyvpGe+MSZUYxpSQ8uax4
 vOKQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771439834; x=1772044634; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=44EEzCK8wsogbyPOQe5WaZgG5z0u5zw9+yNPgn+TjLw=;
 b=g8c8OCvKkHXIJStIRLpe5dELgJIAo3W1wDbg1PHXzD4LcIUxpcHQueQXn8cQnuopGd
 lGkIuPefzDtFEOPVidMmik1aVMJ2ufAbPZyye1wwz/d5zM91tqWgO5kDc2BfP5/7nlIV
 d7wSfCOxNFmvfYrDo1XTyGc6Rzrh0nhIb+g9QpvhV5mZcjn/C8WaXPk5JEXKVzoIz4zy
 cI1FzKgY9BTp7orCNLTgTr8bspdYrtfCB4QqsTtLYro9GJwuuio0sDFRMVWOHPn4+AmP
 +/O4g+zMS0zgoHBCTMFLMr6EFZdxUQye0JbnpayH+oG5aGmcih1za4h8f9dFB49i+g6m
 OwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771439834; x=1772044634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=44EEzCK8wsogbyPOQe5WaZgG5z0u5zw9+yNPgn+TjLw=;
 b=TAPrD9BHM5Epm1SWB8Wf/qLWo4ZV3o4X7jQgx1ddQMFvyBmI86vSyZFYE+7e+4+JC/
 MrJlDb4FKkDqyq3jCJMcpPsWnclatmr6gWtxic6iLpRVslsDCcAU0U2HfeJ5EkogJZvS
 /mQto72kyfcGIUGHhTPeWmfoHcoDUZW31fAcRkst06nvxB69R6KhSYjXMAQ5gii6u1EF
 EhDfhTrHpMmunqNQ2Im9lTZO/3QNCnLg9p3A45cWHp+mLxmFcL39iVSb8RgUszk7hi1X
 3OEuZ5sL6aANUq5aZNmLqach0F9vF64C3N2wBjSAU7PT55E+9oFfIQ1uspR787yPFLYm
 QIVQ==
X-Gm-Message-State: AOJu0YyA3LvSlJ7iQheiqWN55CP5BR/OyUVX5qnWshNwXhsO39toOGwz
 /UfxTNP2Q0UZ4bKONyjggaOZesrAI8V3SL9k9RuRiF2uc8FDckLGqduPUhr+An6cBHLJnZC1k5q
 nCHKEwdef3TqX5yhOBhGmE8V8h3VTvCXG2fVoJvOqdQQxXGTVXPgb
X-Gm-Gg: AZuq6aLfY6PjoXMTQSiTbKDdPM1eW1sjuWh1r0SBcxPeQ1DSFoznGUr6VQe8eNfTm9Z
 U2aFbukJE91Ean78I6jR3kKj4ngaW8lyDfrvgXyBW2jUynqkQgGbfBkf9hEbx8iij0Y9Ipd2nP1
 hyPqcvjZiX9Bmyztq23rZVlhn+Hs6uZ2QE+llRjKC7tpqVELbpWG0Nm42hYsgCp1164vph6VB2v
 gJuul4ZPDywTfQqBuEPCNMB4/9poO4+ND8SQwy4YYI7cEI0B0BC/pBe3ziOYkdM9isMai2zh/JW
 suHTv+/knlP1l9lA5WKcJ5TXc+H0M1xOKh7UD95QRZfoRl/mSjebC3MYG1MAWKyvzRQ=
X-Received: by 2002:a05:690e:11c2:b0:64a:ceb8:30b9 with SMTP id
 956f58d0204a3-64c556e074amr1892377d50.92.1771439834203; Wed, 18 Feb 2026
 10:37:14 -0800 (PST)
MIME-Version: 1.0
References: <20260217162106.13630-1-farosas@suse.de>
In-Reply-To: <20260217162106.13630-1-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Feb 2026 18:37:03 +0000
X-Gm-Features: AZwV_QjOeEJS4Bgp_uDmgsEMhItChd49uay1oB9vENsCBrB6vfxxqh14oPcIIyw
Message-ID: <CAFEAcA_AvAeaPgwBwJL+ftdKTJxbBxmHkuTEkFqb4yn1ZJD-Aw@mail.gmail.com>
Subject: Re: [PULL 0/2] QTest patches for 2026-02-17
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Tue, 17 Feb 2026 at 16:21, Fabiano Rosas <farosas@suse.de> wrote:
>
> The following changes since commit ece408818d27f745ef1b05fb3cc99a1e7a5bf580:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-02-13 10:30:08 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/farosas/qemu.git tags/qtest-20260217-pull-request
>
> for you to fetch changes up to a8f98ffd7b22a5c6554bc475096cf5de1d0cbd6f:
>
>   tests/qtest: Add RISC-V IOMMU bare-metal test (2026-02-17 09:37:40 -0300)
>
> ----------------------------------------------------------------
> QTest pull request
>
> - RISCV IOMMU test
>
> ----------------------------------------------------------------
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

