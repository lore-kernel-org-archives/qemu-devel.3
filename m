Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3E6CDE00B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 01:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcvJ2-0001PK-U8; Thu, 25 Jun 2026 21:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcvIz-0001Os-Vb
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:24:30 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcvIy-0006R5-BE
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:24:29 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6976b0c5adbso781859a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 18:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782437066; cv=none;
 d=google.com; s=arc-20260327;
 b=f8tuBke+lk2QNEteVfcP8n2rZQi7rvbGP+gH+u/mvxD+m919ra/hPbSzOx5MN05Bdi
 /3aNAoy9sjQKzmG/E9YrutcWwFVFK93ULE2anxt61DtSbdKrMtNeb6tmpmUEpMbYtHoR
 QZDdP3BB0q/Vdg5DH02pIrsJyrF/9o7e8Ovo8RzF+Wc63HolpHcZJSufjVUpk1zywdpy
 UJokJs8YnLTTf8i51IeuSIT3y6XYWfdazey1WxXJ+r+XfrcZXQcsfHfBy5h+EwBsLsOH
 0uSq14kzubVe5zpN6XwMbkGMXfIT2LAPdvdbaq9fZu1KPUJ2QiLO3cNIG/oPaWx9AJuo
 PXow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6aFSE0QtIX76LK3aJUe3u28K91h4HLU3HkEZ6L9j4tw=;
 fh=GbHm0JD0JdOJmee0T0TqCBo3I6Pkyu8ycCYdsmUROts=;
 b=HidcVXq29c4IVikG6lx3WPw7VTVOfbcalK7pkUXTIfGn6n3XEa4lt1Qgc22uxfVNtW
 oVNoHvJdpIo72cddQ1wZi3qDJqjpefmX8QLqx7BTvQec+NfMobxQqYZWGgFS8Q0tkgyy
 XVXdoJocqmkpiFjSRCEajydb6r+gu1FGexRZcZ6LDpWnjaXx9hC7asCAe5toyUPBa9nM
 LK4XoqoI0TbMms8VPXertw+eCErMzM9w1t3nshY3IzXtnMszSFLRmTKtjqcDidcpBF/T
 x8r7dEuYvhPA1tomSwitiVtQyTZxKm2+n8S1m6pjNd/W19tc60EELeucEQ32Ch/sRZd4
 BJSA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782437066; x=1783041866; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6aFSE0QtIX76LK3aJUe3u28K91h4HLU3HkEZ6L9j4tw=;
 b=d7oW7cRRKDI6nnRpdpPK4+5+JXiRtNxpekCGrnaBLKRGDAH7T5JjY5QsZehiKSpy9C
 3ISA/ldYBqJ9MoEbxcqLibHtOwFTiWq0KRJs+ip0KhM3/OUMOw7I12j2mrxTqVw0wKoI
 b9RpZvJbC3QiztMLG27XHVly+4uPXkQvuT2kX8m9HOmVgF604WHSBpJDZVUkhh4R69Ws
 IyxokuQghMWCNz5HXf47gLHtoaIlr04uax7ECRpdR2+NfJConT7tiPMoJ0Yi2VwcStU9
 qhkFUNvk7FJlVfmzOWjBAfCF/9H60Dcg1j6pXOAQ4j6K/dOdIa/gAjXcqksg/duJVfZ/
 8odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782437066; x=1783041866;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6aFSE0QtIX76LK3aJUe3u28K91h4HLU3HkEZ6L9j4tw=;
 b=jISB9TUGq671nWMx1rXiFv4AvzKzouGuSKzy9dHabwXXbLRj2EUqwhcgyQN2bah8js
 ZnIz7mjWrn+5N32TehCY3JZK12Uq2Z4Qtmky3x+MsspQerK1K+E6QWWpPs/YZ+kk1uv3
 P7Zrt/6HzsrBTFDGF6MPTWohNGPzbs0XgE7xMCe2XT//3oOE8MKhSif1S5FiNgBp0tgn
 6NvHTIEeCbsrN7yB4+9Qin7fufZX3NILRq20Le7Hqijhv5kfEqYjTWKJge0cBRqI4rYQ
 jnNjxEblZOB1u+/dDaqOrsEmxpcXJGbx1ymti71TKGbDBAsA1N11V1BdlcIO+dsDg3BO
 +CmA==
X-Gm-Message-State: AOJu0Yyf15H/eTqSopdjleYw6wYMhRQuM7Rcg7RXvUWY3+xjVC9fgTix
 qhLD9hHU/M4uIb62xPeNBcPNWF4szkvEyw6MoBBOcyb63tUzkBgd8PJ2qMgK7JXVWWOr4ozCwJB
 fuIfNpHTrm2QvpWKnTcryyZwKEKIWXUs=
X-Gm-Gg: AfdE7ckSX6a2fX1buUUGlJhLybIZE0QHNNR88sY321CiNC+pJzRtEybae+Zz6W99UIV
 VRhB0/lGUdjHCxhj/J8JM86QjWsHnTD5CdqFKJdgu2sagiz6I9V7IwAFzpbSSDz3RWiFgnTYsR4
 q4cHIr9yV3cxD2bKeFxjc0Alx6ThxvuoY3QFMB9rcwBTOY7MCK9PV1fJslYbZZrK7C7JvBX0NAA
 GY7qSAQoTqyvv0w1B1+hRqdB70qrKZE7fUlJoyMNWgFxWL6vUvd8rR4F8ySO6TFjCZbdcBx/ZHS
 fsrHR8gIINQcpCOg1sf9oLilJg8=
X-Received: by 2002:a05:6402:51d2:b0:697:750e:e9f5 with SMTP id
 4fb4d7f45d1cf-69810ae06c1mr835672a12.23.1782437065719; Thu, 25 Jun 2026
 18:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
 <20260624000632.2149359-25-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260624000632.2149359-25-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jun 2026 11:23:59 +1000
X-Gm-Features: AVVi8CcDHAKsNTE9w0uiKTR9BIEsft8XDAugUtH3sGX0aP55wLZcge8LAJtWmgA
Message-ID: <CAKmqyKMb65w5=e7BE0zwxWmoNbyvy90hiKAx+R0-v=3mBv4zyg@mail.gmail.com>
Subject: Re: [PATCH v2 24/24] gitlab-ci.d/crossbuilds: add riscv64 KVM-only
 build job
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 fritchleybohrer@gmail.com,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Jun 24, 2026 at 10:09=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> From: Zephyr Li <fritchleybohrer@gmail.com>
>
> Add CI coverage for a riscv64 --disable-tcg cross build. This ensures tha=
t
> RISC-V no-TCG/KVM-only builds keep working and prevents TCG-only code fro=
m
> being accidentally pulled into common RISC-V sources again.
>
> The cross_accel_build_job template enables KVM by default via
> --enable-${ACCEL:-kvm}, so the extra options only need to disable TCG.
>
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  .gitlab-ci.d/crossbuilds.yml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
> index eaeeb533ce..a823aaaa21 100644
> --- a/.gitlab-ci.d/crossbuilds.yml
> +++ b/.gitlab-ci.d/crossbuilds.yml
> @@ -59,6 +59,14 @@ cross-riscv64-user:
>    variables:
>      IMAGE: debian-riscv64-cross
>
> +cross-riscv64-kvm-only:
> +  extends: .cross_accel_build_job
> +  needs:
> +    - job: riscv64-debian-cross-container
> +  variables:
> +    IMAGE: debian-riscv64-cross
> +    EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-features
> +
>  cross-s390x-system:
>    extends: .cross_system_build_job
>    needs:
> --
> 2.43.0
>
>

