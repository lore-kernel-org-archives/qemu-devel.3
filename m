Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A32CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQwj-0002ki-4q; Tue, 16 Jun 2026 06:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZQwh-0002k4-T2
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:23:03 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZQwg-0007Fx-Cu
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:23:03 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6606678420bso4540592d50.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781605381; cv=none;
 d=google.com; s=arc-20240605;
 b=O9qPYYIBs9P6VaCq8TYeytFMuli8Wl8mXqcxiZ0Y31LHge3O8gAUqu7Rt4XjCnkplW
 roZywC1wejwobBUJsAEimlk61KUzYzlJyPjdEXEgbMlHNs8V5C6cV0XGTGXIdvpXXUdA
 UHU1axSGYftdi/fqFPLtvDXEv+1wYhKWlxwKErXD0RInQMLnewl5NAsZrzxirpOeZsiu
 TwbceAmRBaYc/6xIUtzWiIIZ2m01S4cw2gy/jDSUKGNy91TKaspbf68g2InR06UTwwGI
 K0LSA0AQgT4Xna9Ct/85DuHAZzzH6VgVYDcsnxSzK+y/vonIBF0CxJWxmWx15/F3iKeu
 EXfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8t9jDR8VhGt2shfPePFmy2qffULY/LZf5arHakZEADg=;
 fh=VUZ7eJox894qpEuQTEFSefKlY4l3x+uBmRGBSaSsOHU=;
 b=hyzKs3ZWMvVm0bFYuslmqkRNsN139X1Lqf/c9SAFC2NzpCPyk/tSGRRT3FnJkEb78T
 Kx+fSLiIfSQn0fxwal+GRizsShvtwEQ6J5vRksyfRYnl5B+uWYw92+ehCM1YgAt8QOMR
 AWcMZLOP5GPRwGAySVdc8B1bCuWOeQCAQrECwn4yze/2LvbCbnYPAcIZye0Hmvz2XmL4
 lw6FhEaXar6k+l3rZW5XUd6izkD5hcSQgai77f1l/0MhYgsN2HnIy46AAeRZmnaBAGfu
 iv8Z6ZZTH5xjOFraM5QTL07sFr6ltwuXQ9Dq3ON2luix16MLymZBc661DXG0o9XS1cpy
 BNMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781605381; x=1782210181; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8t9jDR8VhGt2shfPePFmy2qffULY/LZf5arHakZEADg=;
 b=kTQ2jL1nKEnSDFlc2CPrStvLHR6M+SfC79RyFJFw92kaYEWbvCbzxF+XLpwFWmq6LX
 IlgXuKi2g1uyyC5je3hA+gVl6JWf0btbz81LfzX1vlm5EZcaSx14A8QqewPT0szh5mLS
 vOn+jSgzJoiD2b4Motj/N5C0rfjnMvfPJoN0qPPxvMQ8iXSATC0SxW5uXW7MBt0UePCd
 TXK59074jZ/f0Qc8IP7fXJOk0DDHvb++cGXaeJvmj7wLMDpuSsTZDLWjEjPomJAAQZNx
 nF9MaE6lRR6PDtjgJmeGANXQ/HOV9dO1KsxkgXS4kgrpI/MlHB/SouxKXkor+tfKWDJt
 JhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781605381; x=1782210181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8t9jDR8VhGt2shfPePFmy2qffULY/LZf5arHakZEADg=;
 b=a3EuzKVITojhhWSJQwZfsW86NkrxO11UJ+S5i1IhlxYRqMo9Z9GHkCSIewPQSPhiLT
 T2MkB8jgsk/JzT8kmidm+qOPqkusH9TjT9LfNwutERvn6jy7/kXPznWfLFgNcM9p8uzo
 sIuJ+00ychXIarlDNCPVKuHTRjnL3ErwUXdJLFFZSGaXLd+o1xy0h3yL8nWGceHx60Rb
 yBXMjV0osSrX1JXGp1SagDdCmbi7AcbB4kH8/YnP6C8SMFIuUMRronst1qUpzuHoGZmk
 VwOmix8n6eaH+Ov8ZiEgdew5gCFYWhPNqbgSCgPnvNOyAnUFgHuYVOglQE94VT7RtE9n
 IbYw==
X-Gm-Message-State: AOJu0Yxkm15mR1fhaHsOY0v4uXngZvaTiWopxWbmgIELza7/4Uwq2p3v
 g2QEvAWPMleFE1eYO6dKJVTbQ7MrSdUZ1Y45SEJkRRwvwYs+STsXeIhDYmlbdMz+wAW2M//Xaox
 fL7tOQ12Pt+hkIkncGVymCAclJLwfUi1AMsXWSHwUCg==
X-Gm-Gg: Acq92OFYvn+pByYBX6QnRuDJ5hsVtIPBAi9FRjj7v4NjauGlxOoSygwj9r3R9vWi659
 3MLpj12gU2qB8Fg94MpzbP5hJT+iqi/RcJXY++orXQ+roeGp/LhMDnkxXDFToTavMMEfbVPXRN8
 ebg+/4UXfRr3uUBdMIILzp81wTlYoi1RYb6QBmw9giJVQANx3Wu2cMj18bTefaTmMY3lkZZUd5v
 TgiGrP3BcpUwi8DI+M/U4ZFBGpWl9KnJycR3duEkV/wIwW4K2UsUFclblXUMuuQ1gPEryyLaLV0
 /3cYoaY8EF3RLhfyz19dDkyP8uKE0HLONor1qjGsfjFx++7DqsleYOlFzbSIK43Ahxs=
X-Received: by 2002:a05:690e:11c2:b0:660:580f:694 with SMTP id
 956f58d0204a3-66285054f45mr12881945d50.44.1781605380988; Tue, 16 Jun 2026
 03:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260602063350.3623723-1-kchiu@axiado.com>
 <20260602063350.3623723-3-kchiu@axiado.com>
In-Reply-To: <20260602063350.3623723-3-kchiu@axiado.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 11:22:49 +0100
X-Gm-Features: AVVi8Ce3BrxeNEkMjDtlBNReS6T9nYqI39BYEMksjsmHev0KJRp_0mPyr5aaqsc
Message-ID: <CAFEAcA_1iWjVskvWBgye6OFGgGAcvwhGUkVPmKZGT44fGMux=g@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] hw/sd: Add Axiado SD host controller with eMMC PHY
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Tue, 2 Jun 2026 at 07:34, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>
> This patch add a new model for Axiado SD host controller which is compatible
> with SDHCI 3.0 spec
>
> This device model also includes a eMMC PHY which helps to control SD/eMMC
>
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>

> +static void axiado_sdhci_realize(DeviceState *dev, Error **errp)
> +{
> +    AxiadoSDHCIState *s = AXIADO_SDHCI(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    SysBusDevice *sdhci_sbd;
> +
> +    qdev_prop_set_uint64(DEVICE(&s->sdhci), "capareg", 0x216737eed0b0);
> +    qdev_prop_set_uint64(DEVICE(&s->sdhci), "sd-spec-version", 3);
> +
> +    sdhci_sbd = SYS_BUS_DEVICE(&s->sdhci);
> +    sysbus_realize(sdhci_sbd, errp);
> +    if (*errp) {
> +        return;
> +    }

You need an "ERRP_GUARD();" line at the top of this function,
because otherwise errp can be NULL here. (There's a long comment
in include/qapi/error.h that discusses the various ways of
handling Error objects and the standard patterns to use.)

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

