Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B49109C047
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RUi-0005rE-2r; Wed, 25 Mar 2026 12:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5RUg-0005qn-NC
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:54:10 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5RUf-00008X-3j
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:54:10 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64ae222d87dso78905d50.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:54:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774457648; cv=none;
 d=google.com; s=arc-20240605;
 b=ER4seJNj/9cE6jnlPHj7stJu3YcLhvzYJl8Zotd67gb870siCnTIvY9/kgWafGg4EE
 mHMgBcrPY6reePuP/YxZk4/KYMbLUHKn8DWy+vHT5TmkVXEi/lplXVvZ2SyobcGmxM/C
 2yjbyVxWg2wylUbLdZXWhAFu1zOKfGdWFMV5vKSvpyk9O7aomv6L2tkBMffk2RASQ9Dj
 cMFCANgiYWBSP3Qrg8I8tr5/YBrXa/qgoNqKpV6Dpqr+1Guv7+yAEUGYjsy4ew/xTYzg
 HqtLfNS9dsjcGYXGSx2twATJtpx095TBXLj30rnXZndvCXT5NE6FSzGrWDhFjeNsbXzE
 rjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+BSREqrVhedecRfmLo1etrldCPEkziaWacl7xzOOjE8=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=fP4JQq0DYsBERb3ruO3qpGf2sYQsWdlQSvdwI05ofFeBlf6nhy0T7KUyArt/cVMDnn
 jI1G4Nq/9esUd8NR3b3I6UOYBOu/q+cm7u5qtAC9Kd38LkM+r09EAvFHGAvN1oZsVslt
 YCoJqH4e/fXFRqOQyHSpRO9HgV4QsF13XYc+P81sVFpVtn5zITIhuF7NsZbvYqOoJXvC
 FJMhpq1PCEfplnoAy9s7d7R+nknudQzzM6z43RuqpFZEeYdw/fehc6jMP0zGJsmkfMzA
 r1a7TpPJQONyqiN0rZZ8QxGi4AybL8MTMIeNRwuqPz6fQWVXOna5sYo47lClWEitXccx
 Uofg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774457648; x=1775062448; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+BSREqrVhedecRfmLo1etrldCPEkziaWacl7xzOOjE8=;
 b=EBVWD/2ouOSArkMv+rkAABf3DV5bqbK65PkOQdUL7pikjrtIJe4yKY3sGcK/WxyAbf
 CiiUYzisb1+qV5Q//l0iVdbZ1VUb5MVFGPrR8o5UNT/sLTNtAtvmwesmmeUrm+AqwY2/
 GcybagKVVrxabeP9Fq+TgCq4vxmUJd8VGKhRE6wLbdHkcvEPQhm3yUC7ji4Im7sB1z9v
 PuxLAF5Xr8sDdsDqRl0S2VR6j+W0q3hXFt7KM/Phi7vedIoSgnMP33jn256mjg+vk7wj
 pEkD0wC6KjdhJL7zvkZAIt03ExdwEjyA02jjv/yF1QMrvu9g1l8kddma8FZk3PEmLMD/
 NaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457648; x=1775062448;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+BSREqrVhedecRfmLo1etrldCPEkziaWacl7xzOOjE8=;
 b=Nbfcc1WG0YpkBPkEeQYcEAwE78rOFb245MgBR2eUZ8y7GoEZ4Tt9gpj6YpyeIcVvZ8
 ID9EbQeTQ/m+8Y5At3uFPtyzeOa53hht+8IEORW+QTCz7ZXM9Y+Prg2Bb7o9ioRTmJ5T
 ElR9tnXQGM112OXgTxVHpou4oLgH5Edaep6fUQA0DX7PYpbc2UKiC3C9EQtZB+rpW609
 E1mRP5gZWeeQTP3x4p1yRmXQFpzwMGnDRwqOETr5rsvP+n7MV7oIF6i6uipNZsMfMPN6
 3+w0R0JzcH0WDa2++aQGhOFjoJJqljAfLXCutJN0KaFAHC3ZgUAG5VqiJ/AS47q78Dqa
 1pVA==
X-Gm-Message-State: AOJu0YzMFCHu9bAkVX1DWhcsOqUNqA094NunTML1oQsx0HCidgJbPw+t
 8MF0bsRW36GYdwS6N1se6CjnWRJYC6GfyQ4V+h1K6NxJ2PvL+jRbRNHZOc550i8o7D2uVowJEO7
 v350t2ch5CACXnAEuERkV9ZibrIX/LqfHOcGYzPiudg7aYDtL9+uQk9A=
X-Gm-Gg: ATEYQzxOWFwySv7YM+nZP7Yme80SkGLquFuV3hQ5SgEAYRI11l+Yg2sIXfgbAzH4Nw3
 XRjOs2TjGeIUDdEOP5fyCEYEy96DvmYRV3mtFzgj5oqhoyTQe04w9LBelIzd1fqnXgJEdI6PNH5
 6S8P4qiUAeRWw5bN3WNM78sbQfrIZ1vFE9x+pPUkyN0922bz3hIWRLsQrasXsGB3AkRLQHTpAcv
 F/4NMcKG3D10CHMNdG/8kVQEVu7u74mzvNM2saFgDx5n/GtSoP0rv+VAcl8vOSfFkJMj+3ToKf1
 rE1Qtuir2W7q6GqFXiFa3BvabQvjnonjXR+nO0DkyLg0A62Yxe/esQRVUtSGi3Nr2OM=
X-Received: by 2002:a53:c786:0:b0:64a:f927:b3b7 with SMTP id
 956f58d0204a3-64ee617fab7mr2900130d50.77.1774457647686; Wed, 25 Mar 2026
 09:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260325164453.72127-1-pbonzini@redhat.com>
In-Reply-To: <20260325164453.72127-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Mar 2026 16:53:56 +0000
X-Gm-Features: AaiRm52tPjPm-kn6nP3GeckItd9ZZij3nn-rbZWPC-moBmBb74X0RjrHE5nofX8
Message-ID: <CAFEAcA8W+9jqqUovu-0oyMDa2vBO+gxGN5c9KHVLyZm1Lfx+wg@mail.gmail.com>
Subject: Re: [PULL 00/19] Fixes (including big i386/emulate performance
 improvement) for 11.0-rc
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Wed, 25 Mar 2026 at 16:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 8e711856d7639cbffa51405f2cc2366e3d9e3a23:
>
>   Merge tag 'hppa-fixes-for-v11-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-03-20 10:04:48 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to dfbc524fdd8932951791e78121be0ddca0529162:
>
>   target/i386: emulate: follow priv_check_exempt (2026-03-25 17:43:41 +0100)
>
> ----------------------------------------------------------------
> * tests/functional: preserve PYTHONPATH entries
> * target/i386: show GMET feature
> * target/i386/emulate, whpx/i386: on-demand access to runtime state, MMU fixes
> * tdx: fix use-after-free in tdx_fetch_cpuid
> * treewide: replace qemu_hw_version() with QEMU_HW_VERSION
> * sb16: detect invalid migration stream
>

Hi -- this has conflicts in tests/functional/meson.build --
could you rebase and resend, please?

thanks
-- PMM

