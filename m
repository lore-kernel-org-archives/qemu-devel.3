Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581EFD2D8FD
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 11:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkgrK-0006mm-Cx; Tue, 27 Jan 2026 06:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkgrH-0006gM-4z
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:03:43 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkgrF-0005sp-HP
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:03:42 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-78fc3572431so54672687b3.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 03:03:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769511820; cv=none;
 d=google.com; s=arc-20240605;
 b=bJr2Ym4x7BNUyZwmLBVL0bmop1YIUwC6uLkb16xb67SY/ITasPqQDfR30FRaZp4FFN
 YTSO3O5uMP2kRl9Scn94FtdP3Kj7ITndujeaywOgmqBMrc2k/MLEdwfnDwpUG1/8AcRC
 91q3k7oA3P621yd7i4MSxzQDj87LzUTET6uIFMAVce3f2GITRHGLwWUOvEexpmE3gT6Q
 stof5i/03BahVWbU/mFAWl2INHXU0j94cWIWWcdYjzms0ZHSnmhWBBrUAfcYuuS6YJo/
 utkiyzJ8XuCWGtmEKOs3jsYEgWuYZSnf+WHPdOnwXNWCLR/pZDvIDthVDiHd3C2io3UF
 7cSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=N1jnLph35YoBDXCJeldeE9p7JgSNAcEGoaSTKws8yuo=;
 fh=AsFRDVg0KRVLUjMpRmk90XK9N0sgNavG1mxmQGEfUQ8=;
 b=gg0Yru0oo+QclxGP4btzj38fobIeqrylJQ2Lyvpn4E8X7Ep/DVFxufcc1QDCoGZj1k
 /Gryn0m9diNeTJfLzeljToZBI48t52yP2VuOfW8SZNhustGOf3Z4HxHRsFTZt8j7+5x0
 dNemWeLGumYyz8a22cravDymv77piYAzM7iGKrkFeFIlcqcH84skUm2g/aPDkVLrIZpQ
 qWcBHgYX1tJKi+yboD3dK9LlWlBXz+6SKKLZLjqx+Fbg1crOe8myhGiouAfOwjHejuWA
 iPM/3gf3fNKq1Zk/vAKjL3o44b49y5UahOl7e2bDYbx4UM96ygNI/U8eevF97zqBFBj5
 IrFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769511820; x=1770116620; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N1jnLph35YoBDXCJeldeE9p7JgSNAcEGoaSTKws8yuo=;
 b=KUeFzTp2+n8jZSaRjgPPWOiiQ9dUFUWtJNj5fLpKh5nQVN9SIbyYnp3o2s9JzVygMo
 6w7i9kN8A3uutHeFzdkQsBv5h37f0UKrVqquQgPGSEJ/8QdFc6A2dy5Oa98FFcD4cGW5
 jBggFonUzOpf4XVW+RGB2vDZqsrerBm37ESxEzznBekgcqBU6WAseMwCE+yOXGlNqjsU
 GX6DVi8E3ypCHxU7p7/0+UnRpgmA2RUzpg7Fi0qfc/2qRrDWFzwQp+owSWI3e9xyeBuj
 51P7e+ysI7v+ccI7BvAxvnvPPmTmvjQXcDwNxDfksltv/rEjhjyrlPm/6aMKooALauBN
 ECxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769511820; x=1770116620;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1jnLph35YoBDXCJeldeE9p7JgSNAcEGoaSTKws8yuo=;
 b=Fwqi8r62PXAhNuoXuZpF+SFkok0Se9QEFA7uU2rA5o+kDlGVs/1BIgODvbPTbHj0PW
 7+Jf4LmfPzdPQ+l5+qdNa6sdEWVwkpFONc2XeB+iV7yxd+nHdT81vNozzPSqOTLGnM/L
 kx2glZZzh6CU75ABQHVknIBVIhN0G2nECgEIqwFd6VgPGaS2/YOet73a2rx4dKsV3xt8
 6cUynowy+ej4j7uqfXzFET1ujrYjBnpWW7bYx3OjzHOhfFmMGBJ/TCedZoao/th6mfPi
 GKGy9v7rK+g6209Ag2iDtqE+2nz98Y8FaRa23Z2gAk1endn/mUL3bHkxdQ4DgvAxJcVi
 LvaQ==
X-Gm-Message-State: AOJu0YzafHS4+uoGfYy9+RmAyVpZmGMWS/nSqT1UWd912wHiQzRFlryP
 mYXEJxmQOZpGtcMeDR9Sph5rk9N36xX5V65+NtfoaN7xsGjpM486PGt6wIpkHM3Gs0FQkBvttxq
 N6oMRMA7KtNPUYjJa5lMAcBXp0mzK8ZqI8KLx2Hkx8g==
X-Gm-Gg: AZuq6aLJqI/gDbKWW8xD8IqXnw0SaYALTJuKh9X7vFLSC3aL4twdWcjl8rdtZTugzFf
 c2Qcp9sIVs0dPpQUcW2S9T8mPY2MErEY7TSQDv/UZea6ZJwzc3U2u/9fRKuxx/OMu9pBomXHvPi
 HAI1l6Rg9mnWWe9PGZM34RKBNCCC4P3JwuKWm4F3QHeY+3GstQCYAye6BxSSkClVsz5G1AhkU12
 t8FlgJSx2AeRG07IjG1Xvrboc48ASHZcUzXSaOOGYtMgqL/Lg+7N95Q5d7q5baTCAz0VA==
X-Received: by 2002:a05:690c:a5c3:b0:784:997d:b86 with SMTP id
 00721157ae682-7947aa00aa1mr5780347b3.2.1769511819980; Tue, 27 Jan 2026
 03:03:39 -0800 (PST)
MIME-Version: 1.0
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
 <20260121134114.9781-20-mohamed@unpredictable.fr>
In-Reply-To: <20260121134114.9781-20-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jan 2026 11:03:28 +0000
X-Gm-Features: AZwV_QhuN8WQJ2P7_1r55rwCH69Slg1g-ILoVMnr_9zj2rV-jvQUgLCs2GtryS0
Message-ID: <CAFEAcA9XQeo_HXS6_Zki90q2awOi8P-kN-s4KXX7AcVOr2bhYw@mail.gmail.com>
Subject: Re: [PATCH v17 19/21] whpx: arm64: gicv3: add migration blocker
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>, 
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Ani Sinha <anisinha@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
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

On Wed, 21 Jan 2026 at 13:42, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> GICv3 state save-restore is currently not implemented yet.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/intc/arm_gicv3_whpx.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/hw/intc/arm_gicv3_whpx.c b/hw/intc/arm_gicv3_whpx.c
> index 9bc036d1ac..a2f8e3c5fb 100644
> --- a/hw/intc/arm_gicv3_whpx.c
> +++ b/hw/intc/arm_gicv3_whpx.c
> @@ -17,6 +17,7 @@
>  #include "system/whpx-internal.h"
>  #include "gicv3_internal.h"
>  #include "vgic_common.h"
> +#include "migration/blocker.h"
>  #include "qom/object.h"
>  #include "target/arm/cpregs.h"
>
> @@ -204,6 +205,14 @@ static void whpx_gicv3_realize(DeviceState *dev, Error **errp)
>          error_setg(errp, "Nested virtualisation not currently supported by WHPX.");
>          return;
>      }
> +
> +    Error *whpx_migration_blocker = NULL;
> +
> +    error_setg(&whpx_migration_blocker,
> +        "Live migration disabled because GIC state save/restore not supported on WHPX");
> +    if (migrate_add_blocker(&whpx_migration_blocker, errp) < 0) {
> +        error_report_err(*errp);
> +    }
>  }

I think you can just fold this in to patch 11 where you create this device.

PS: QEMU style says no declarations of variables in the middle of a
code block. The GIC base class has an s->migration_blocker field
that you should use for this (and indeed you're already testing
that in your whpx_gicv3_icc_reset()...)

thanks
-- PMM

