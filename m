Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DA9C8302B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGXS-00025q-LF; Mon, 30 Jun 2025 11:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWGWz-0001rk-SC
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:34:57 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWGWv-0000Te-9k
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:34:53 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7086dcab64bso20294427b3.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297684; x=1751902484; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DzC/oii9o7rPIbYU7tLpYjy4/LYNBCTnqw6z2ZXkL0s=;
 b=p2RA4p3gphMpWD2MHq2uuELtfZUtaKMc+wWHepQKHhgrfxuAxLWd37DcbmfdB9MF+G
 eKaKx6rQigcXIyvfwE0fgMUv0tjDFS6w9jo/OrT925PNnQW9I+pUOH77gwBhG1fBBPwa
 CGNEFcsUPmhFt3vwzCd9lVa03nchrtfjgMUbrszJOvw+cbNHmrcAK2wbG7lXkIIKLbz5
 A5o5AKyCQVETM4gYw9cKO9rbqRgqWGDA879qHv8eTek0BQxyVt0fdabe6xj8Wqns9/GG
 8DE4w93rHVqKdemwcftMxfNMFZ0mVDcCSLCGurnWLkZP5XiiaczzlWqvF97K3NA/i1l9
 2x/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297684; x=1751902484;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DzC/oii9o7rPIbYU7tLpYjy4/LYNBCTnqw6z2ZXkL0s=;
 b=KtXeYjvhchU9UYO9SvnHJoKT3ofRO8RbUE91mLV+X4fHlPAsb30LBWL2rXFMVGXeUC
 cUimMalwVSiWCFm+hOaA6Q5J4MJT6yHfpwarBuVtpnOKZDhm1XUxCgCKjMDzytRaMSNt
 vH+yAeklPm97zFOvayqfEb5PeDj9XbeeX6tXerKBIuZ5jswp4mZuIE285xX/roWGpF8Q
 ShLp3FoyivYFpGxaBIF6oT2eGnow3nkoUBa3u99dcggqGKokii81A7lpeaJF/A6e4P28
 E5vAyeG0cMv97y1gBTRQTizH4xNJQmiYX/DPx+qRh1VM3zENHeYAOS5wC0VILKOyoYy/
 bNgg==
X-Gm-Message-State: AOJu0YwBriPnLpmmqdKWi5MTCMUM/YfcyV6gH1MFe36Qsf+LMy9mscBj
 2sSafF4WKfEHy9NuCc6l+cGC6R+3dmT5fY6wQIigIAyqIUtlz0UbXM74K4CwE0E2Tgx4FNc2sRI
 IVJw+0I7R0EEkYq0vx8/bY23i1Vz/DuDtM0hSBQrvGg==
X-Gm-Gg: ASbGncsM29z7PhY7Etx6eJ6hz72k/yTg7KsMlq7ruLsLOrj16A90j0eTE+vRdGJf0GL
 xlOGlIBeoNZk2Nr6b+T6YVznrDpHpj9yCa2mBSe8PPbj4ZFZZj9Vhx5skBvLeCH4YvrfR619q9u
 6zbublcQyU3DwVgz7VLgRW8kq77jxyxvrv9t9WoeBQmgrH
X-Google-Smtp-Source: AGHT+IH+iwwqTU7zlX2I945lgbnNlrrxF9cxMU8gMHe6Vd7HsmOmqSLMequo3znfXJSEumDV7EvriQUoY33Fxg3xTNc=
X-Received: by 2002:a05:690c:d85:b0:70f:8884:17af with SMTP id
 00721157ae682-7151714d14emr228157307b3.6.1751297684555; Mon, 30 Jun 2025
 08:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250623121845.7214-1-philmd@linaro.org>
 <20250623121845.7214-21-philmd@linaro.org>
In-Reply-To: <20250623121845.7214-21-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jun 2025 16:34:32 +0100
X-Gm-Features: Ac12FXygwnSXLP-ZPonXcEmOAhgztcCBXBn2LNuOkJFkl9HoaCecpnHthAmLnYw
Message-ID: <CAFEAcA_xqu1oDLThHBp5T_srQs2+2oxWTXF=sQzBjKDduc0cfw@mail.gmail.com>
Subject: Re: [PATCH v3 20/26] hw/arm/virt: Rename cpu_post_init() ->
 post_cpus_gic_realized()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Mon, 23 Jun 2025 at 13:20, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> QDev uses _post_init() during instance creation, before being
> realized. Since here both vCPUs and GIC are REALIZED, rename
> as virt_post_cpus_gic_realized() for clarity.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/arm/virt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a9099570faa..da453768cce 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2032,7 +2032,8 @@ static void finalize_gic_version(VirtMachineState *=
vms)
>   * virt_cpu_post_init() must be called after the CPUs have

You forgot to update the function name in this comment :-)

>   * been realized and the GIC has been created.
>   */
> -static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysm=
em)
> +static void virt_post_cpus_gic_realized(VirtMachineState *vms,
> +                                        MemoryRegion *sysmem)

thanks
-- PMM

