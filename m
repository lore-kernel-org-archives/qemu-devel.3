Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50655CCF2C7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 14:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI5UI-0000xt-PD; Sat, 17 Oct 2026 10:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI5UB-0000x8-16
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 10:34:12 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI5U8-00054q-KQ
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 10:34:10 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8acda240937so6206147b3.3
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 07:34:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792247647; cv=none;
 d=google.com; s=arc-20260327;
 b=McQktpkA1XMSWubKMmdG6fXi8Q+atL/47Z2D6mERYli9ZC8HX0/EiLqOx2KvURJEoX
 rgSw8Ny18mnR4rF0RSTUYk5GKiptdBwGlwH0oEAQV+aWNDmY27IClC4t7CSvx4Oi45ay
 QpUGcLbxJYsxP0jJmfJQcZWbFc/2CVvE0Ss7nlUkzgTdbXpD9lN2roftBNdqvMhd9qkg
 6X1K4H674qMqCBf7nugK+4gLkAyDlBzjIBqTr1SBPVGAMRCQcEBJWKd9eP71BTeztUn7
 FeTpeAr4ZZG/qnTt7RWez3HEq4wtW23Fs18b/eJtJ0VVM7GC+qZ4ZKZGAPEnnGJ90r1J
 oXtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=deJFFRqTbUEFuiNaF+8ltNtvyq5v+1rOyKGwVeiPh1A=;
 fh=K7nln+snUdxD7vSx+57hZxjc8+cW/kJ+xOG3YICKLNc=;
 b=nU6hebnJT1VMkEuvJasAksyeD4jHjScEh2T2mbLdzg6X4D4wpQOXrFr+/gj+12XFZA
 4C5Wh6brZF9bZlgcQ5ORtdRuxHtt9Vwe1yYOyhp/6MpNl32IHiXoIAVaBSCti1Db9xsq
 8udbpldifznHcIsZeHP1ri+dNV6dBuc8rnCdz15LyvOcj20XkJQ2H4DKoWAr2w/CHPiZ
 gN5odvRp7QIKMKc56BIpytO0nLRz9gDBVpVYc+pnDz8IVDQLSe9D92Bv5zZahoAzpW19
 hsNgIMdp/fRzZoLh2+WQFkuMZie/5KKKATb3XMO2qV+G29JBaDtJpM5i1lcOUn48l5lo
 /C+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792247647; x=1792852447; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=deJFFRqTbUEFuiNaF+8ltNtvyq5v+1rOyKGwVeiPh1A=;
 b=h6VxW5j0tuqcCgwugrhuXOqOVb85PiMiHCDWtqeQK0WqB847wV52V5Pxlb+J3o08BG
 C1ZcPGYv6iajo1tN+pL2mw6AWX3dBRvprrRc3MaYO0VxzZgv+UxoNcxNiqAufHRWrbbV
 r3XsSysWCxMKj//QwYkqe5AKSK7wg18ufV5RL21dgLq3pdYM4lEHYtmw/bv0bohTFc5X
 CKCxMAY+Q3nqMG3oK8QGza+FwwLp54jrdldFIETqJjvhrCriQsCywPVspthtEpQouGob
 X1gBdZDoHCPyDsE8fJOSF/O9yy9/RfA1phF4s7GqVa/8d9gOM7GbHcY5XeTJz3ei7Ig6
 RIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792247647; x=1792852447;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=deJFFRqTbUEFuiNaF+8ltNtvyq5v+1rOyKGwVeiPh1A=;
 b=l2vX2/j1uVZvJ82MjbDa+PHzMcxExVxFkqeFuCJRNR/+M5YKbYv1CyROZ7pnlb+CPr
 pS/UAfFauOlRgI8HlNlPACupcPT1BOIwageb2pRmPM+SuNiLiLbysW2I4y1EA4u0lUxf
 emDIyYqxvFaJrM5WrZsOpyY3awIhwThymcTQ/4VhGA3fbeLANR4SLefII6WWT2psNj7e
 ocsD3Tmt9akWxycuYBoXFKPWim6u+h9Io+cVgCdKynwBFeE4VwIV97Sx1c+FDO2Ld3rN
 w98izDBhsQ2vuW84pE6W9lS40RYUN+Nrn/z1tzd+DX4D5nxTuFwFs+pL/XzEoyZlTHmW
 odUw==
X-Gm-Message-State: AFq9FYJpsxz1j7dl5xiH6mCv6el5zH2IcIiEM9gxvFBakEF8y2I6MiEr
 6Xk9nxdYW4WEHzqmDmzLPp3fv7n1k1QcFQsT/0sQIYUmb1pHTeY30cpkjeqhs5Dktd858usNV3s
 W7CLUfMkHiUOygmTaSrSyLVl10i7PgGiPJEp4MnIaaA==
X-Gm-Gg: AYBFou3cvYo+7pzdKfIQgONei7ATGi8UDhcSmRDbpJRwf28FQJKl4THXUvCfE4e8uCz
 updxcTmuiGYS88IFY4QRDPuBH5ioPs8iNuYUEoihr2+IfHDRzpVUIRBOU9mo0MzrEh0zSuc8dgd
 CKBbdAQod0xPEdOOIxEcNL7xW2fMt/A1ua4EvtzwFnEsOEO5FNrakATJcmWsQrCJ9dNZlFXPSPS
 uMm0znko0OaaNVhuKMqNoSDD3Q9oxdNyxAvd56fOgp1fx+9jGP98a/QS/h9i05Ih1FrtOj/krmp
 1ZhMchdmUs/k8a/W+alA71+osKAAe9q6XWv6u20OzLQhPB1k4zES7QP+NEAE1TrX8qVLI5SLadE
 fVn76rhAwxS+Va2PV+yZi7EXtBBTPmcdd9R7/Llg=
X-Received: by 2002:a05:690c:c58d:b0:8b0:f116:11fe with SMTP id
 00721157ae682-8b0f21b53ddmr7259217b3.50.1792247647007; Sat, 17 Oct 2026
 07:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
 <20261015181122.60608-5-marcelomanzo@gmail.com>
In-Reply-To: <20261015181122.60608-5-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2026 15:33:55 +0100
X-Gm-Features: AclHuK-MLJyYHb3lPUbih9uEumDdaI8SaaoFzy5VMgCwmiqCKbinINM6HuyqsyQ
Message-ID: <CAFEAcA-mGcgxbpUicLqrDzDa=7P6U5dnAiMbZdyAg2CetSoyEw@mail.gmail.com>
Subject: Re: [PATCH v3 04/16] hw/net/bcm2838_genet: add GENET stub device
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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
> Add a bare-bones BCM2838 GENET (Gigabit Ethernet) sysbus device:
> MMIO region registration, an out-of-range read/write handler that
> just logs, and a reset callback. No register-level behavior yet;
> that comes in the following patches.
>
> Adapted from patch 19/41 of Sergey Kambalin's Raspberry Pi 4B
> series (patchwork series 829638) against current QEMU master. The
> reset callback and class_init() use the current Resettable-phases
> API (ResettableClass / resettable_class_set_parent_phases()) rather
> than the plain DeviceClass::reset hook the original patch used, and
> headers moved under hw/core/, both API changes since the series was
> originally posted.
>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
> --


> +static const MemoryRegionOps bcm2838_genet_ops = {
> +    .read = bcm2838_genet_read,
> +    .write = bcm2838_genet_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl = {.max_access_size = 4},
> +    .valid = {.min_access_size = 4},

We should set both min and max to 4 on impl and valid here;
I think it's clearer and less prone to accidental misreading.

-- PMM

