Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6ACCD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtKY-0004hM-8W; Fri, 15 May 2026 10:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtKS-0004g9-V5
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:15:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtKQ-0005SG-8c
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:15:52 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48fe26a177cso13582345e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778854549; cv=none;
 d=google.com; s=arc-20240605;
 b=HXEzFBz+vKwl8IcUG1I+TZ7dsJbE6rO4Eq0bRHWedREvtfAJ1ehAiGXaXaDgLxB/fZ
 7Q+jKB17ilJhzgiBBkaaRFQfg4QKRhF8wdsNyiG7GK7O8Lh9+u16+NFhcEwCdP4fHg9r
 3mAaiyHzKPVM8/yNtssiyL2ET74st1c4quynuluMg5X1W9hBivgd1ElA6HnwKKFelDN+
 buJg0FLzGsKy9k8RevLFAaiu0hh/rBUCUXIGB/HR73OGX0iVazSh6qHkZzGQQWlJuvso
 T4LlZLZyZa+N+4FkXtNBniISi4jC2SsiSmRqSUqRqftLaffVVLA/iErIe9ZF6Q43qiKm
 DoQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1d9w2+FoGd+jgDsmSJm8V0KL/IwlX9fOqPjHhF1Gaq8=;
 fh=G+JBw2Pu6hUZ8zKsXx/FXyHuhiws+/jrNByUetwlSSw=;
 b=DYDEl8hggeIQZ6IQ8kyLQlhRDHygPmBaUWTaUtEdAhv5ry1TdB4lhyeKKu7RD9Ex5U
 WFr5cat5zPERbEuiQa3cIWEcXzY7EMvqPK+WsEjkGP1dwfva+kZa1fc2iYCe9oReMuoK
 bEOlWh0Qlvc1RKh0t2CEoTsnmlDZ06GyoO4v1n4K1htxVlW+sm3Gg72DQn1+5SIamv6a
 Mq6C5/BVvMpTvL9yZTM4HySW77mbt6bOChztDLeKpTnW3loH77yCcJlzoZUGz1u/rwmh
 ixV9QmBdmbBYJ79udFiAko6rq/6sKRLWPS9LYHyv8YX7uxhTeaRCD7BeqpQ/VAIF2YR2
 MBDw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854549; x=1779459349; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1d9w2+FoGd+jgDsmSJm8V0KL/IwlX9fOqPjHhF1Gaq8=;
 b=zei09q3nlQ/DeVFzuVbaUbAMTL3qfzFLd1zncEx6iEHJOssY0pxOkrCZ7r6VPqYtEK
 idFivpuQpdjb2HD8O3tQL8a8Ct80y3M7NPRiqi/SlQj2gHVq0xobrd7zCZlBGPmQdsac
 aBf1DQQPjuTc9kRO+lKPlx9s6uXmd9GE2k2zQT5EP2kADbUHZeF+BPOcsKqjTAMJQAeI
 FsJHOllJpSG9721OnIlopgNEH+YWnL3D0aVc3WjIQvsCdAjylHEHcIN/4Xoz+CKwMunM
 g+GzLLUlnZ5rwYzWllrjqobMKpCU9wdr9Y4h1czloydd+/cICw2+XYMdKf9cFc47m5ME
 g4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854549; x=1779459349;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1d9w2+FoGd+jgDsmSJm8V0KL/IwlX9fOqPjHhF1Gaq8=;
 b=ANtEWh9Q4SL9cUvtOb0EIklBFdOKJRlwjoWDainnJLsEk/gSgl7dt0edyAK/pWpj6O
 RejBIZa1S/bLy3tIGI2naEkVFpyZ0AE8Bv55k4qOyJHDMZKmgeNBl+xTsUK00/FY+jA/
 dSeL+QGIfpJ0RjKobN2atq2MDPzB/6M4P7IcG032Ao965Kk4P+rdiglnEgta2urJPznr
 EYx5+xHptuWtGdmEh0sZAonehBFAvQSNxV8upCh2ge5t8r+j1PdUaGzWvDZbEvrtcKNo
 EFdQ2iDa3rFt6Yki09HqI74u/OEsWzr0bFItN/5lGddfE1EYd0ZqO75ZhaI4X/8sMuM0
 63JA==
X-Gm-Message-State: AOJu0Ywv/E8eI5vzppCwfYNt7Uf80yaQ7ql2LU321sp7sR6Z/I7YHvxy
 y7baaRcO7jUPXPaQxsyjeZJ2XX47ssvvUrzJmRnagQkoR50wAkSKYkWgZBaOeE6fuu9PeWU4XDl
 FFBloNfxOmJHNV1Ca80fDf2oeDbn8icGIld7w3O66dg==
X-Gm-Gg: Acq92OHj7K7OI4ZCH+r3Ej8heAYTu6NedjQwqAhy1vrZ4Jcwey+KQldsU6Nu13mmQER
 5qiAP0IkuQwLmnwr+NPrsnQCbzf1Hi98l6Zye4B89tlRIXxaAJp0zZ2MSujGFCgmMBbOzM3f+Iu
 MSfntC+6rmqueO5rMqPAiZQOxkQX+lblJ80YunN8H88GfmDJFpmKPgvKo05+OU+DPkhYnOonRgp
 ylhlytfs9bDyp6rlhAf9YTZuEo/nK+3RCHuLHYDfgBr9ui6psOJkaS9Ks6nnJBMOJ1JRRyuMSA3
 4o9uZ06OEtWvYhEiyn6TgOa7vYy6+0L/WpG4bihwl5FXR/EKtg==
X-Received: by 2002:a05:600c:354d:b0:48f:e230:72f9 with SMTP id
 5b1f17b1804b1-48fe662a15cmr52279165e9.30.1778854548663; Fri, 15 May 2026
 07:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-3-philmd@linaro.org>
In-Reply-To: <20260515141032.3271-3-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 15 May 2026 17:15:22 +0300
X-Gm-Features: AVHnY4KxUoiTXLy6v457wFnHOe1l4XGFsG5OkaTn0uvdLNPjkFS8n_GtdCZRcQE
Message-ID: <CAAjaMXaaFZmYys0Kw6p3Bfb-qzWD4Jy-+Q7igpqJPNPKtbkkmA@mail.gmail.com>
Subject: Re: [PATCH v6 02/20] hw/arm/raspi: Initialize 64-bit CPU types during
 DeviceRealize()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
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

On Fri, May 15, 2026 at 5:10=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> bcm2836.c models 3 similar SoC: BCM2835, BCM2836 and BCM2837.
> The BCM2837 is a 64-bit only SoC (Cortex-A53), only available
> in the 64-bit binary.
>
> If we build this file as common object, all BCM SoCs become
> available in both 32 and 64-bit binaries; however when running
> the introspection test on the 32-bit binary, the BCM2837 init()
> method tries to init the Cortex-A53 type -- although not
> realizing it -- which is not available. This can be avoided by
> deferring the CPU type initialization to the SoC DeviceRealize
> step (this is safe because nothing uses the CPU type before,
> only the GIC access them, just after their realization).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  hw/arm/bcm2836.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index ee2f44debd1..03825e69d06 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -25,12 +25,7 @@ static void bcm283x_base_init(Object *obj)
>  {
>      BCM283XBaseState *s =3D BCM283X_BASE(obj);
>      BCM283XBaseClass *bc =3D BCM283X_BASE_GET_CLASS(obj);
> -    int n;
>
> -    for (n =3D 0; n < bc->core_count; n++) {
> -        object_initialize_child(obj, "cpu[*]", &s->cpu[n].core,
> -                                bc->cpu_type);
> -    }
>      if (bc->core_count > 1) {
>          qdev_property_add_static(DEVICE(obj), &bcm2836_enabled_cores_pro=
perty);
>          qdev_prop_set_uint32(DEVICE(obj), "enabled-cpus", bc->core_count=
);
> @@ -65,6 +60,11 @@ bool bcm283x_common_realize(DeviceState *dev, BCMSocPe=
ripheralBaseState *ps,
>      BCM283XBaseClass *bc =3D BCM283X_BASE_GET_CLASS(dev);
>      Object *obj;
>
> +    for (int n =3D 0; n < bc->core_count; n++) {
> +        object_initialize_child(OBJECT(dev), "cpu[*]", &s->cpu[n].core,
> +                                bc->cpu_type);
> +    }
> +
>      /* common peripherals from bcm2835 */
>
>      obj =3D object_property_get_link(OBJECT(dev), "ram", &error_abort);
> --
> 2.53.0
>

