Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46124F3C984
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutUz-0006yp-E5; Tue, 24 Feb 2026 09:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vutUx-0006yM-Rn
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:34:51 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vutUw-0000LK-1e
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:34:51 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64ca2b32f46so401264d50.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:34:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771943689; cv=none;
 d=google.com; s=arc-20240605;
 b=hp+refhlB/0BfZBvFLROEqpvXc1QlB/mmMSwb5r0s4x9680Kdv7FsIViatUj/6uej8
 vAd9dJlO3giur73mUnFAcJPiOIw5KCW5y/7lxj5m7yW7d1QdKW1SC0dQ5BlnYOc2h7+/
 eO1tnH8h8V4se4MamTNTMu0/M13Yh8lLdbmg/b8l52PU4YtVtAhP70lJXrj+HB1D0lhm
 IDkvoVJncjtG2F87GziLBOW2d3jg/9AU7sOzftuvitXSHxgVY8kqexNQcXwcP/JRjT/h
 LmXgNzbM7WJJqXwADui2BF9+kQrwvgH5U7GUA2xsHUZRCe3C73ap/XeeCJ9k/TaDOT6p
 23QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aflH0qDkgG4fC1sHybb7ibjojgZXGjJ7kgR08XJSBto=;
 fh=th2fSBcOgUlcOv/9VX64yOWeFDVpQbdwh4B0rMIn8eg=;
 b=cJ/k30vCgSP+x8SoXc3NSDrh3vRAiwpObUyLrFS2YLGqwVRfT2g2lGHmrHoxbWIT4B
 Q1B4GXi39cxgVHLuu4Fi6F/yy6rvTyLAlvueP4eTtU8gxv8Z5O3W8NVQGitLF23FRqjB
 MSE/CjhBWMSPqRx2Z6BDXJZwiZ09zrj4zMBqeYEWvjUkLRL9t2bNhISA+VxGRvvRSvFe
 Dev7aZxTtyETU++p5gSVC2YVZ0wV7SKnTK3v6ghvHU577K90Eyjaw5TloRptfrqr1/ez
 vV4IdqULq0ohU/FDxs/41V8KcChZygC+6vfLviK2F7LhqX++MfPqJvo48FbE/VnwFrSG
 h+pQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771943689; x=1772548489; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aflH0qDkgG4fC1sHybb7ibjojgZXGjJ7kgR08XJSBto=;
 b=ZAZQorgmGwIO3VK/Emhojicui4U2V8OFumHsUSPI1CJiySewhheWguOp4UqDzC2InD
 rYZ8XzmcOeWglNCLmytLJFrPYIvrULeXsFppOKK2Xzg9/FY7Psn9gUAmzBkE6tOeqP9I
 /4vD/Kda1XsWMa1BJjcwSW3jzp7hF1RqcgoduJShMlA9wdy5PAXrCfWzqW0Ky0P9PFIw
 QWQ1AjmeotKyoeGw0Kzvn75yc71Act/6ZgV7yaJvsllZ9bJ98HfhgxJwmI1qoq4a2P1t
 7ieBjwCiRXGm9TR3nYjE6tP7ePBjuG+RGZ63V8e1WzshASkIP7xVOJAemFTSLBsKw1qo
 fQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771943689; x=1772548489;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aflH0qDkgG4fC1sHybb7ibjojgZXGjJ7kgR08XJSBto=;
 b=BjBT4Ci5fTImPqEYigrHagPpzGhT1fFjGRhoOJCxf+43l+eIsSUDEYZYm/yDwk3M7l
 owUrlThkLNX0bnOP1M4kMMHIUhHk/IJlcCY7WwLtIQnbvHx6oSadbsuIBXRAtYme0Ve0
 gM3WSMok+8ZeCMwC9wvVcHtEdgDTEFA8gdqblSqy3n4riN59Rk8KCN1tTXn+g/t1cdtt
 IWIIpCttTqT9syZqbS88aV+krhKMRwtSV3O/NhbV4EQYQrT7HeHkrUhH3O+ieRvMz54+
 Xlv7+x+tjxIenzBT2F1pc7XVzjo8ZLg78qqXRgjMOP10RUa8e4SPM2iQ/ayguMb01jFm
 VLeA==
X-Gm-Message-State: AOJu0Yzhdikt2zCXMcxd0TBJs++DecsqJTDKmaDOK4yqJQJG3PJbKxJH
 0O77NPUWdzhDa60KqyuXNU1L8diN3PO6kE9hZq8Y8htmVLcC+fRCpFOaqSxhza5n4Wa6CPVc2D0
 s2iyOqcyFX/mTopurnaFMck6hArjvRUIfyRgbqR5WrA==
X-Gm-Gg: ATEYQzwDVhDOPh7HPfiNGJrHhRa6c1VWPsMCWZLj/GapO51NN4qGS3ziX94wDyXF85o
 3VgiKf/QpZM9ygKJwfCxTaZrXVIV7KnJPRwudopop3CfZNlc9vE5avF6X/EnYz8dKUy/ajur/JI
 ztowQsdAf6JoorwOHrI9xibKBuE+uNbI7ojoepiB9WBOaJ0FtV73LnTiNWuM+qfrTFi4s7kzxc5
 5SJmajb4Wl0kg7q/teb6BkzioVcvl/6/z8peoKCYqAmMbkEhbDmoIMgye000HJCL7jwHnVu+HR/
 OYHSMhzGQhhQ9DwtEMFLMOaf2z+lNPFtDNhQMmmSnB9GoqTovmPKmWaSj1/+cjbJ9m0=
X-Received: by 2002:a05:690e:dc2:b0:64a:d9f5:d412 with SMTP id
 956f58d0204a3-64c78c1054cmr9104750d50.43.1771943688633; Tue, 24 Feb 2026
 06:34:48 -0800 (PST)
MIME-Version: 1.0
References: <20260220115656.4831-1-sebott@redhat.com>
 <20260220115656.4831-2-sebott@redhat.com>
In-Reply-To: <20260220115656.4831-2-sebott@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 14:34:37 +0000
X-Gm-Features: AaiRm515uOhz39gYNVWQiyM_zHuBmfxeUElFEXao9Pe5eZx0PQvwmWIjvVpaqkY
Message-ID: <CAFEAcA8O2UEKToJ+zXA6=vvgkRyPKrPwtfHnti7yyGgCGwoJeA@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] target/arm/kvm: add kvm-psci-version vcpu property
To: Sebastian Ott <sebott@redhat.com>
Cc: qemu-devel@nongnu.org, eric.auger@redhat.com, kvm@vger.kernel.org, 
 kvmarm@lists.linux.dev, pbonzini@redhat.com, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 20 Feb 2026 at 11:57, Sebastian Ott <sebott@redhat.com> wrote:
>
> Provide a kvm specific vcpu property to override the default
> (as of kernel v6.13 that would be PSCI v1.3) PSCI version emulated
> by kvm. Current valid values are: 0.1, 0.2, 1.0, 1.1, 1.2, and 1.3
>
> Note: in order to support PSCI v0.1 we need to drop vcpu
> initialization with KVM_CAP_ARM_PSCI_0_2 in that case.
>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> ---
>  docs/system/arm/cpu-features.rst | 11 ++++++++
>  target/arm/cpu.c                 |  8 +++++-
>  target/arm/kvm.c                 | 48 ++++++++++++++++++++++++++++++--
>  3 files changed, 64 insertions(+), 3 deletions(-)
>
> diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
> index 3db1f19401..ce19ae6a04 100644
> --- a/docs/system/arm/cpu-features.rst
> +++ b/docs/system/arm/cpu-features.rst
> @@ -204,6 +204,17 @@ the list of KVM VCPU features and their descriptions.
>    the guest scheduler behavior and/or be exposed to the guest
>    userspace.
>
> +``kvm-psci-version``
> +  Set the Power State Coordination Interface (PSCI) firmware ABI version
> +  that KVM provides to the guest. By default KVM will use the newest
> +  version that it knows about (which is PSCI v1.3 in Linux v6.13).
> +
> +  You only need to set this if you want to be able to migrate this
> +  VM to a host machine running an older kernel that does not
> +  recognize the PSCI version that this host's kernel defaults to.
> +
> +  Current valid values are: 0.1, 0.2, 1.0, 1.1, 1.2, and 1.3.
> +
>  TCG VCPU Features
>  =================
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 10f8280eef..60f391651d 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1144,7 +1144,13 @@ static void arm_cpu_initfn(Object *obj)
>       * picky DTB consumer will also provide a helpful error message.
>       */
>      cpu->dtb_compatible = "qemu,unknown";
> -    cpu->psci_version = QEMU_PSCI_VERSION_0_1; /* By default assume PSCI v0.1 */
> +    if (!kvm_enabled()) {
> +        /* By default KVM will use the newest PSCI version that it knows about.
> +         * This can be changed using the kvm-psci-version property.
> +         * For others assume PSCI v0.1 by default.
> +         */
> +        cpu->psci_version = QEMU_PSCI_VERSION_0_1;
> +    }
>      cpu->kvm_target = QEMU_KVM_ARM_TARGET_NONE;
>
>      if (tcg_enabled() || hvf_enabled()) {
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index ded582e0da..5453460965 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -485,6 +485,28 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
>      ARM_CPU(obj)->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>  }
>
> +static char *kvm_get_psci_version(Object *obj, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    return g_strdup_printf("%d.%d",
> +                           (int) PSCI_VERSION_MAJOR(cpu->psci_version),
> +                           (int) PSCI_VERSION_MINOR(cpu->psci_version));
> +}
> +
> +static void kvm_set_psci_version(Object *obj, const char *value, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    uint16_t maj, min;
> +
> +    if (sscanf(value, "%hd.%hd", &maj, &min) != 2) {

%hd is a signed value, so this will accept "-3.-5" I think ?
Probably we want %hu.

(If you agree I can just make this fix locally, no need for you to respin.)

-- PMM

