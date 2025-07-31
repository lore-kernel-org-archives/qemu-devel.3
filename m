Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80007C87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhURV-0005py-23; Thu, 31 Jul 2025 10:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhTTP-0003GH-5K
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:37:31 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhTTN-0003RY-4Y
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:37:30 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-71a44abb9f2so10274487b3.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753969046; x=1754573846; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2Oi7PkPZ+tDYah0ej3ajtphfDogqIjO/uBiU3ZIiFvw=;
 b=L2+dVNUGKlllp7j3VJAynG+LyPFFRRfNg1CLdc6q4tM4p62SpZWscjYdGCQgg/ulFB
 tv/XDM8lp9AmXk0fNb3vfSIfGpChrGa/VuTX11ssT5bes3DxVYZTSH59Xyi0G94e1qRA
 QKwzvBfXlexifklXzkflGBOi1LgDQ0GwLMwfdALPzEyxrl4F6SzO5lIzt7krI5RjX3cl
 1aIWgmAzmhnFh9zpH6s5H28GQTMZYdgXoW620BdKL/L+6zWTqhhhZTpQtgKJvGUthA5K
 xlhim6au0dyADbXvfm9iqCtH2p+utv5yAVHT/CI7o5O37BytFRcStGsXLvVVW94s0WRg
 sJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753969046; x=1754573846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Oi7PkPZ+tDYah0ej3ajtphfDogqIjO/uBiU3ZIiFvw=;
 b=DMheASMSPsr1VWe/jPMJ6mJ5Fwi5Ka6lj1OTvFi2AvQYohhNDEabIWVDmNvBXkG2aK
 +NVDxvh4mmbIZ5QLsuiGxJl6qAcZy+r6J8YpopNbZEcSz8OeeTcJOEKZKXYaiork/uUu
 HIMIs9bhBlCXuKq19xvXkqztcAjov34Y7HC5z/n+FoS33KCL0Vp+H6hy93SDxA2bY8EU
 U8bLKoW/1y00A/CK6e3P8/aznpuKYzF5He66PuFp3AP6LaIKimWx7poIkJXRn6iGzBhk
 of1+lsskQDqc9fxLBMZfxahJHi+xDw9Pzxo/HYK4NgT0VZUFv8Ib8pNRajIS5YCl7uMC
 9yVA==
X-Gm-Message-State: AOJu0Yx+sZDkk5dyiPUNK+iq7CjlxfL4ucVs5RZXccvMwXRMOsc09QDk
 YkRDdQXLFt5XDwgbCmxU670EUYXTsOyrNdz6XVBsB9WHkH2/hz3MDHOhJbkZBv+C0mzqNzey5v9
 mzuMGQ2zZmr2g/shVgw6pWzRF4S+UUgLDqJkFNrSzPg==
X-Gm-Gg: ASbGnctB0Couv5SbxU2Ruz2S+TGAtCpHOwT0Ne52j9wDmR4vAHE0cXff/aq0/S2gMv5
 CCBZZtvtuQv2ig8/YHHvP+raAd+PsGahLQHvz9f7COsX0hugcSu1Ae1ZGmYHExwzfzpAcfFNv0o
 8X9E9/46r7mKH/XKF+AgtiGagQHHb7qvUm/2G4l3oXbD3nlCXH38zftKFzEXVPzrb1T5gKg17q8
 9jLAXgi
X-Google-Smtp-Source: AGHT+IHQd1t5rAkF95s6dSCpjc4y4Y76sx97lO/v3/4hy49nnVAX/GduTaixKfxmV4WWELGl5dCUxujXgMx3HrMxGJI=
X-Received: by 2002:a05:690c:650f:b0:6fb:1c5a:80ea with SMTP id
 00721157ae682-71a466bf02cmr100615197b3.32.1753969046179; Thu, 31 Jul 2025
 06:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250730205245.2118-1-farosas@suse.de>
 <20250730205245.2118-3-farosas@suse.de>
In-Reply-To: <20250730205245.2118-3-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jul 2025 14:37:14 +0100
X-Gm-Features: Ac12FXzuWSWn5QKMrxs3p954Cy2DMS86j5WcywvTE4U31v-dpsb9KVW6evi-KHA
Message-ID: <CAFEAcA-acYCCXNy-udHTeL3zUFxonh4k6JwTJyxzHTMWTDN2NQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] tests/qtest/migration: Only test aarch64 on TCG
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Wed, 30 Jul 2025 at 21:52, Fabiano Rosas <farosas@suse.de> wrote:
>
> Currently our aarch64 tests are only being run using identical QEMU
> versions. When running the tests with different QEMU versions, which
> is a common use-case for migration, the tests are broken due to the
> current choice of the 'max' cpu, which is not stable and is prone to
> breaking migration.
>
> This means aarch64 tests are currently only testing about the same
> situations as any other arch, i.e. no arm-specific testing is being
> done.
>
> To make the aarch64 tests more useful, -cpu max will be changed to
> -cpu neoverse-n1 in the next patch. Before doing that, make sure
> aarch64 tests only run with TCG, since KVM testing depends on usage of
> the -cpu host and we currently don't have code to switch between cpus
> according to test runtime environment.
>
> Also, TCG alone should allow us to catch most issues with migration,
> since there is no guarantee of a uniform environment as there is with
> KVM.

The difficulty with only testing TCG migration is that now
we're testing the setup that most cross-versions migration users
don't care about. At least my assumption is that it's KVM
cross-version migration that is the real use case here.

For instance, this migration bug with the DBGDTR register
isn't a problem for KVM, because with KVM we use the kernel
to tell us what system registers are present, and whether
a register is defined with a cpreg in QEMU or not doesn't
affect what we put on the wire for migration. Conversely
there might be migration compat issues that show up only
with KVM and not TCG (though the most obvious source of those
would be host kernel changes, which is kind of out of scope
for us).

Though of course with our CI jobs we're probably not
doing AArch64 KVM cross-version testing anyway...

thanks
-- PMM

