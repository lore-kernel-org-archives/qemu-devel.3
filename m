Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095ABCCF2C1
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 12:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI3iv-0007Z4-TD; Sat, 17 Oct 2026 08:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI3iu-0007Yg-J9
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 08:41:16 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI3is-00047Z-Q2
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 08:41:16 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8726acc5eadso5776667b3.0
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 05:41:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792240873; cv=none;
 d=google.com; s=arc-20260327;
 b=QSZY16raPUWIxkznv+QHpGA/tFbgFnx0nlsczAItMMGa2qlX6UQjCx54p4fBz8T9gw
 +v4bfkeNj1BubTyBpytElmqtkiDNv/eEvLCM8IRomNJW1xYSVh+dljj9IyEDafgFk21p
 b/yfgRwCBZH9nlB8faSNsSEeMfJ2nxXY/B2qNScbPD/Q744MG244K7stF/cmJaJdnsUZ
 o3oEjvCnTH7xj87I3dEdg0EXkCEzCVKg0gk26/iuIxasBApjGOkR4+6cIzVx6oWku8js
 /17JXsedsIWYGKnciFy8MzMDt7lHrTLlMiuU7E13W1aiuEDVfVeE39n8bi0gsczT04Ju
 bvXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eQ4uXyWKz4n12BhIGvymZiStphOTlPHz0IVI/q2BL1A=;
 fh=TUfzxw1B/DFEA1jNT0iQFdzEda/YXFE68WBEXYJToV4=;
 b=kdyEhfQkaFjNhWvWy8I1+XU+Lv9924tE7ZdMw+kKQCoAxk15Sd4y8ox2dg05O1WnZM
 bsaqH/KLq7Isrm4Xcpqk7OYmxN8TDzD3ydaLmj+raKVogv9YgGfCXtcZeyjafxoTotrS
 h21WOMSOtN59g73Onrp2GfYRft0FPJ/fBeJLFf9XP/ppGnKcc1t7zgG3rKYK+hpNl+09
 fwNAwyoFnrhhtTNMdS+IraIAXk7YIOcLv52dgLo2ZBQ3IhUWAP1pQMKo5SSHz/ldPdYZ
 +FarQtzk9eSpblquUk5muQbGYaCy1/MOYBo+k2AdF9PM2Ls9A6E08IwK9voF3HcnFvq3
 ficQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792240873; x=1792845673; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eQ4uXyWKz4n12BhIGvymZiStphOTlPHz0IVI/q2BL1A=;
 b=w893OpVisqBKqulF0tV6Yujo+v9i5uHtmc9DbzmcH78v11mj1zFog5u3N75kTARSKa
 C4URcVG/pN26qu25rATatHY0iFQzWdc6q7r9ENJtWRkGqHnfme+zEgYviA3X/Tbn/PGR
 bQT3K2O4yHBgU8JEboMOSXumEMRQd6RG/Uqz7hBTXAEKbIbq5jGacGGg+NCQp31w+947
 63Oq3O/2DYIKsmknQSU6BlhuPYxONwR0/eSwHS0RWMGx9kH1CR/kAhQkAWaxOGpFylcm
 d2lqPKYafg0QlbXDDjqym2ADgcYWNObnjAUEnujD0hWax2sDLOZAB2901T+7nWBAHpkV
 ow9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792240873; x=1792845673;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eQ4uXyWKz4n12BhIGvymZiStphOTlPHz0IVI/q2BL1A=;
 b=byUVerVGB5iiK3KoZOIYKOEwGLXkN7Gx3wCcT7b6QsVUFx2rQdAd1js+BeWQhZD9dk
 yDWOz1kCBc1LmmL6mQVbxnKXB3pNXOW4gTCC0xVVh9JVMgWztjoWclasIwZjvSOgNrRW
 qqfCwWVu7vLI3SKsJMhK/fPXS7omIWdQ1ZPxSgOhrcCMqx2L+W/E4IpC5Vm2qwr6DQqy
 MpDXSTV1N9JrSbRksJrr+Ndm0dcVDGKYMy8kOduBDW8/978ZakgOa6AaE4wBHXeQ9U9L
 TxeH6WTvbHrbAFgyXnl/P+UG3HrzY7giJnXcTcGePwjX3LxqrHM9Fkd8rTVGVZpU+VUs
 oY/Q==
X-Gm-Message-State: AFq9FYLF8BkMgpGXSpyyBUwDXqasNCNDRd/bI1X6Et4yY6O+3vEJEe0r
 nugFN4x5B+WZTpcybgt7Dz1o+UWXEKIWp+TSd8/TDWCMreJhOSgpv9AQNFeIPyRWPU2VuJi2opf
 ZqHfNZL11pg6nqFcxVxt8TVzaG/LkMAdRyUczpDuWfw==
X-Gm-Gg: AYBFou2TsNR5r/VTfgH7bg68AcYAjp03JWAlLsFp+I6HCvaHXKJepTiWETFHhYtaqMT
 BZJJJtWWn0Csvw9SbR9HYM6p4y9xfIjhb+qnaJ/xq49cGN+fWdBvUJ70Pk7g+/SD/koYcIfKs+m
 j5oFmogZchkAV1E/F4SEsReD9WTepcNmHHLJhT0lQHTwrWGFMwiXo9E5D8JmepM+Y6EzDEAzunZ
 RWfdvXonWf4LyfN7pnsjnbRT0g0j4WYOvCMSOIuBWETbQNQsgnNmmU8TUOMB65Gw6/+0Z/OxHC2
 xhcoUByXCgyM4kEsuO99GUk7HJj3ZTA8rrqCDPtW+vdMPRgTJqhqn8osBj69BkzmDdCmWW3jwT7
 VijiYCmjTvckdzSTddFIOAy7zE1Yv2bylxr1z7zM=
X-Received: by 2002:a05:690c:c4e2:b0:8b0:9409:5ff with SMTP id
 00721157ae682-8b0f21f78d0mr10965137b3.47.1792240873426; Sat, 17 Oct 2026
 05:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
 <20261015181122.60608-6-marcelomanzo@gmail.com>
In-Reply-To: <20261015181122.60608-6-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2026 13:41:00 +0100
X-Gm-Features: AclHuK_o6dt3oJ6AOKTeKfU3h70t4IDBQLOWhVeEWUh42UcGMqMxDwFrc5HBQ1U
Message-ID: <CAFEAcA-dDUp87JnYVZjTnd6TMAj7nMSSGfjA=t=-=PgbU8ah_Q@mail.gmail.com>
Subject: Re: [PATCH v3 05/16] hw/net/bcm2838_genet: add GENET register
 structs, part 1/4
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Thu, 15 Oct 2026 at 19:11, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> From: Sergey Kambalin <serg.oker@gmail.com>
>
> Add the SYS, GR_BRIDGE, EXT, INTRL0, and INTRL1 register block
> layouts and the top-level BCM2838GenetRegs/BCM2838GenetState
> structs, plus REG32/FIELD accessors for the revision-control and
> interrupt-status registers.
>
> Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
> networking series (patchwork series 829638, posted to qemu-devel in
> 2024, never merged). Carried forward and completed by Marcelo Manzo.
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

