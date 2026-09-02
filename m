Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AF7C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1oGk-0003cv-7c; Wed, 02 Sep 2026 12:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1oGi-0003cH-Lw
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 12:57:00 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1oGh-0003mn-0f
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 12:57:00 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a68ca482e2so972243a12.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 09:56:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788368217; cv=none;
 d=google.com; s=arc-20260327;
 b=kdFCRvueTamns322mRqacAukRsm+Acfw+l9gons8myqBFb608p2GeZiv9lXDfaV59c
 SBoSQU+9m4/3/NbrcfsyqViIF9YCWdjr/mXrme8kZCz9x6oQjqxiBsC46xlM0fcNb1a2
 7A2OHqGVZJrDYk+iPqQdxWr3t+Pwlgs+kLDURYD8frIxtNq4gSlRs89Z2UlrfSfL9n8t
 0CWURvt8YnsX2JvDPLttZoFytV6CGmkFuUmxnzrh8e+V+x8qMUigA9LiaHw31xoUhx/7
 QCA6G1bCybCk3p+wch8T+u/1vOtunNvY2amzbBwre8aembJpoEtpOTnPMOKzdd65SDyV
 WZ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DIRVWgaoQlTzZa9uf06FBQ8i6CdI4hdi+gGUUn+XEho=;
 fh=hJaxYieE23j1y678YRNMAXWmW4V24xBaewJ95RYenSA=;
 b=VU8VtXQO2bqrJCgO3BR/xgK5BYX0Af9sVHagOh2tY+A+rUsLBwqUOimxfxyh+QOPc4
 S9F1YcZzRgqCZ2X0zsuUxXoAdxKCyQBWPhD8u7rHbv+qJ4OYafsBBjbGvQh1gi/cX5NE
 zrxP1sz65E+M9cgZDfQKPzU2dpQ1tiNXE6i7OlYh3e/HBrfO6mKLjjNJ3uafTr7alcEs
 dkoVJHu9+qPLChK8JHzFIH80wlzzLWarNchfWTbIingA7/xXvZ8wMbaZFuZCPfj6XY8t
 vV2tHyzzck1TxLSrTydacqCfLNCH3ZhQGDn+7qI3zl3jRGscOGeDWQK6I+8qDMvpKJzo
 jNfg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788368217; x=1788973017; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DIRVWgaoQlTzZa9uf06FBQ8i6CdI4hdi+gGUUn+XEho=;
 b=gNNwUVbu7U1nSx3a/aMtLyMXKg/RXZvgc8S39GscncuVWT/pLj9Z368hYh1nuu2tDV
 FL+L++JBesXSddHPmpYjmqJp607t0yurNpUxhSUSSURxQ2eDgvQQiiZcDKadM5MNOltV
 +pitQu1NfWoVw1OIoYBaj65d2fA3ubxZWFTSrFgbQTZU83PahsIaomnIulYAbj81yKce
 7sE5sDSPyRiEBOhi9ZBXzfjK0+u0gmISrnFaY7xZfngIOWNZJTFKV4dvcH4jJXyPoZGr
 4IFPYVn5GwP4LgLdykpmsz5fdzVe6MnjBbP0+uNQVgx4uBadKRA3K0Yi61v0AxjdcQEy
 0v6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788368217; x=1788973017;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DIRVWgaoQlTzZa9uf06FBQ8i6CdI4hdi+gGUUn+XEho=;
 b=p1CxH7zoIJGbeAxH4xWrXN6TWTbDw/pTprBmn2fiQI2o0RY7dIeKlBCAVN9Mks1rkS
 ft8sgSRVVdJdCxJSdcG+qbkBOqs6+qodtohbsGqjp+auoVQSxlP9Ih76RKVjHyBaFROl
 8e2piqwbX52f1uWOUY2juYNcxGYup825YW2h0P337jU0NxjvP7CBZApsCmrfCDBHxjII
 CzXKnpP7QQ2sE6qMSmMJh7366PdpFNSjvJQ5aBSF1BY2lfUSyVEk9BHTVFWlyE9hirSr
 U+IVlYz80aN1FvUz7lviN4+eEVNb8Dx+VJp0M1WOH6X+VOk92YIPtiENdIVLvKdJA9j0
 d3kQ==
X-Gm-Message-State: AFuF++mCe8caC2UcMMeX2xs6oZoSRAvdDEKAilkiyfYHSe0mnp5024HF
 LjFfpldvw/Qnrkh7D8KsXm/OSy2rLKnvqYclaGzWZ8bXbQDSV/p+pHw25r92U+48dr74I08CHBU
 RjzkE4GPSIMV7c/lUpTmAwk/kNoCNOC6BhAQxbF/nyw==
X-Gm-Gg: AYBFou3rGZHpJiGAlWWjOegF9sR4M15ReMP93pWYpbqL8RCqvuHj6pKZhmdM8E/eqm/
 yBzAHxtT3BKC9KUmP2FMTBX/tmJknWSICw5hnaEqRY5KBPHomfQQPX9HhpWvcZPXGUP3ZugrOBX
 2itqoVnoR/Trp9CMp98+wswqiRZmNZA4XiPVDwQzJ3qXYWNVbYHh5hcAzGnVPBJLAiaGQt7/f42
 AS143eLOWUpWjSmMn3ETYYEPA2NHhWO4j/bqcJZt0hjNCpxOLmH7H0Wf/l1KbhTDBWZvWe8aTkh
 zjpaNx7Qj/3ItmRs+exoG9iKGlUe7tFdhvOxCPCGYiPvX/n18B2bxbJPWp2MfZ7BYucOR08JZlu
 943eujIq0/CK+0jKHVjQnBi5SBVbA
X-Received: by 2002:a05:6402:440b:b0:6a5:d8eb:da01 with SMTP id
 4fb4d7f45d1cf-6a6818d29e7mr5361582a12.0.1788368217345; Wed, 02 Sep 2026
 09:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260901184043.728292-1-stefanha@redhat.com>
In-Reply-To: <20260901184043.728292-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 2 Sep 2026 17:56:43 +0100
X-Gm-Features: AcwNN1V4PVdNTXGDu9nQHuXZuEDV8qg8mZS-cauQoFmCaek4tQnlqV6Mt1iU7iI
Message-ID: <CAFEAcA9n3Jig4wM7SqFf+aQyQcujz1GhHNZowZj-0ObsHA2ifg@mail.gmail.com>
Subject: Re: [PULL 0/3] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, 1 Sept 2026 at 19:41, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit eb710c255642cd7dc947f25c9a06c9fc8191e98d:
>
>   Merge tag 'firmware-20260901-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-09-01 10:38:45 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 8e02b06882e5742fb760138e3db627a8591bdef3:
>
>   file-posix: fix zone write granularity assignment for zoned block devices (2026-09-01 14:38:03 -0400)
>
> ----------------------------------------------------------------
> Pull request
>
> Fixes from Daniil Tatianin and Niklas Cassel. No new features.
>




Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.2
for any user-visible changes.

-- PMM

