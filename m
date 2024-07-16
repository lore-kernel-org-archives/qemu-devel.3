Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8A5C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTec3-0006eq-N4; Tue, 16 Jul 2024 05:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sTec2-0006ai-LK
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:36:46 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sTebz-00070i-5O
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:36:45 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-58b447c5112so363420a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 02:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721122600; x=1721727400; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Dc/GStB3d5Kj1Bf0cTf6aqXmkTcJcXLB485vy4LOdzc=;
 b=i4IHgcAl3cl+tqmXfu8prcKlliouwOGCjZdYpkxFXskL+LeyIIbvoq2wKnG81aOeSZ
 T20ZsCKKzw2EHmsn7BrfX80liMmo/U2kxEyggm2FDtml2gPRAPNWLVIg+OkHPGRh+5ls
 W/GMFwx3w+kXRZWJM65KjZjPcUeGN8oyBdf4TGOdgEm2LWkRl1jqHOLzXXuk8yLbcqAn
 9h6PFFjbRfLLSnOYjp40EV1kqszflOheBWWD6QbAtsAy33tKszcus8AmaqXa8o+CkK8Z
 19b8JCobsvK5nknj1P6X1TEFNiZdf5PBFz3HiUzeBJOymcJA2Okyq+FevpDKs+XOo/T2
 EBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721122600; x=1721727400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dc/GStB3d5Kj1Bf0cTf6aqXmkTcJcXLB485vy4LOdzc=;
 b=IAV1I7PCtTRjG56ZfMDYy9i5S9PexGRMRVT0pjlOslyney+Fej0MwXTVQqaCNJNtR5
 PkXQWe3kZPWEqc606FgmolsM7ycQSx/js3czIcYwTmn9QLr/nX7xqSUIueFZ0YKhaCcf
 Tl4s67DrJEuGucb/gExMSFFrWM9cUFGq7Rxpml1LAvWXw26e+WrPYFQx2Mf8HgCB5YzT
 mUpQfndOt0ZaJwANYSWvqllN+kZs5EYl6HziDp8o6mDS0iuVYh4ws37a4ghiZiu8RsAC
 CCa7UP4RuJifqV8KXS+PkthA3vzjiHuZ1CUXiB3XzG7Tuto0UCg+3KC1LjcISgZ4IQbb
 RPIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSJcQlomrkpn7jic8Bmm+N1I37LNF2JGvN2qHEXMEvLJJ0tDrCcA0VLGhhoekpLisuM1QLpdoFwTwlWaIWx6DvYfPP3dk=
X-Gm-Message-State: AOJu0YxYcUOda3gt3gZCCkjYtd9FPI3xkAB8vbcavTn3bjFbTFKU9CL+
 5haKsdOwtGyrpoI4n5zu3Wb/S2mVSELWUWm9KEbrYojudscqgmd4LK+BBlT7khvkgxkORqZCOV4
 +Z8ZEsObIU8/Q03E5ouZlXAJdUAZqddX6x6lj/g==
X-Google-Smtp-Source: AGHT+IGaN+Ei2ULusap6WGT3oe08l2+JpHlHRDgnm+JkMuCHt9oh4QsPoWK0iHggAtS+dEd5b/8Ac+xbNNu3GwpoJIo=
X-Received: by 2002:a50:cd19:0:b0:57c:70b0:d541 with SMTP id
 4fb4d7f45d1cf-59eef158729mr846034a12.20.1721122599935; Tue, 16 Jul 2024
 02:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com>
 <20240716-pmu-v2-2-f3e3e4b2d3d5@daynix.com>
In-Reply-To: <20240716-pmu-v2-2-f3e3e4b2d3d5@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2024 10:36:28 +0100
Message-ID: <CAFEAcA_Rw9ceo6D1mXUhzAim6FmGKvLJOmOFLdCpgbTnYYiLMw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] target/arm: Allow setting 'pmu' only for host and
 max
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Tue, 16 Jul 2024 at 09:28, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Setting 'pmu' does not make sense for CPU types emulating physical
> CPUs.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  target/arm/cpu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 14d4eca12740..8c180c679ce2 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1594,6 +1594,13 @@ static bool arm_get_pmu(Object *obj, Error **errp)
>  static void arm_set_pmu(Object *obj, bool value, Error **errp)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
> +    const char *typename = object_get_typename(obj);
> +
> +    if (strcmp(typename, ARM_CPU_TYPE_NAME("host")) &&
> +        strcmp(typename, ARM_CPU_TYPE_NAME("max"))) {
> +        error_setg(errp, "Setting 'pmu' is only supported by host and max");
> +        return;
> +    }

This doesn't seem right. In general where we provide a
user-facing -cpu foo,bar=off option we allow the user to
use it to disable the bar feature on named CPUs too.
So you can use it to say "give me a neoverse-v1 without the PMU".

thanks
-- PMM

