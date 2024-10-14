Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7222CD1624B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 11:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0JWX-0000aE-78; Mon, 14 Oct 2024 07:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0JWT-0000P3-V7
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:46:02 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0JWS-0005UI-8m
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:46:01 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c40aea5c40so7927165a12.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 04:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728906358; x=1729511158; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bkls/Pvpwf1pArR/5f94UUM/aOuCRxQSiBRxDXvhQoI=;
 b=vlItAcXL0ufY3/c1zHIzKTmjXYbitNDEn9dFpvrXW38ApfjWU3atVetKrJJcUgaFY9
 bDJR+iaJ2NtBA/6diHCU594N3DXMrOjHZt3WnIkCOw4cQv3G/0iPXOj141Xk9EYD0pde
 lm5ocoYuk3qSLZLRNHYsRKcl2UiQkg76Kby0z1ToQxAs9oiFKpJnTp4KbDTB05bS/hrp
 qNl0GY272Do7aI3rxLO9E0G0l6sgZgD5wt+2Ldu0l7kOnq5lze21/oGXzxbAz00R8b7o
 rNQbe8hXcLw6wJ4HQ7PjJ9O0WY4YQ1QQwkT4pm9UwtwJ+oeyR/WwZsMq3T/MWVrhE/9w
 NvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728906358; x=1729511158;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bkls/Pvpwf1pArR/5f94UUM/aOuCRxQSiBRxDXvhQoI=;
 b=UUdOV5tU+Ch3KF786Cq+hLYCjuTVOdkM/5HT8abo0JNTAkurhGi25Wk7OfFY8Sl2f2
 FlcBRJ0FL72siUMsJncx5zVR/BskeWtEaqpJgwJcE0vQosqpu3wQdhSwHDXlacYEcey6
 kH8mou/WuYXE4Z4s+ok7TkTfvzspaM4bzbW/tUxkCTVeHQdu7W7qOaYtdBlT1JOdz0fZ
 AKlR2XmdeNNBiUgBdpQENgDuC7Dn8kqAgonWqHdcfFHYpTWn8VbTE0LbS89v8M1c+OPp
 uZKSqrB35gyK/DAs9eDtAGtRuhmcZmZS+R16JkkIwJMPKBr+k793WeUEG35H7ZbzFhLN
 o0/w==
X-Gm-Message-State: AOJu0YxltvkdjnsUPWNmb8e0Eq5EELlarL1AZO7G4ki63AOtfWQ9MrM8
 Vy19Opz5+ZefXd3jQ4zhuj4ynv7i/678uYbehJdY1zUjvGcrPQNOtrBK0IzuRaywLakRmMoW4ve
 QZ6MWOxmDahsZJ70Dpq04J8SG3jeIZw/Gfx7MWw==
X-Google-Smtp-Source: AGHT+IFQxhWcOaYM7P147PaWYUgTU3n85V/MN5mpDbt+Q9IbteGbFF/UiEzJ5fCZU6n1945BzZybOgZjSl9mRcmp+ZI=
X-Received: by 2002:a05:6402:3493:b0:5c5:c444:4e3a with SMTP id
 4fb4d7f45d1cf-5c94719da8fmr9819364a12.0.1728906358387; Mon, 14 Oct 2024
 04:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20241014110113.173946-1-pbonzini@redhat.com>
In-Reply-To: <20241014110113.173946-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 12:45:46 +0100
Message-ID: <CAFEAcA-8wdDV4fziAj5FqfR2isjdAvLxXZHvqN0=GewDNS9iLA@mail.gmail.com>
Subject: Re: [PATCH] configure, meson: synchronize defaults for configure and
 Meson Rust options
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 14 Oct 2024 at 12:01, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> If the defaults for --enable-rust ($rust in configure) and Meson's rust
> option are out of sync, incremental builds will pick Meson's default.
>
> This happens because, on an incremental build, configure does not run
> Meson, Make does instead.  Meson then gets the command line options
> from either coredata.dat (which has everything cached in Python's pickle
> format) or cmd_line.txt (slow path when Meson version is upgraded), but
> neither knows about the rust option, and the meson_options.txt default
> is used.
>
> This will cause have_rust to be true if rustc is available; and the build
> to fail because configure did not put a RUST_TARGET_TRIPLE in config-host=
.mak.
>
> When in the Rust pull request I changed the $rust default from auto
> to disabled, I should have made the same change to meson_options.txt;
> do it now.
>
> Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

This fixes the issue I was seeing with my local
incremental rebuild.

Tested-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

