Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51B3CC6B16
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGece-0001mg-I0; Tue, 13 Oct 2026 11:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGeca-0001Zh-Qw
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:40:57 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGecZ-00048k-6Q
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:40:56 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8ab38a051aaso24619397b3.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791906053; cv=none;
 d=google.com; s=arc-20260327;
 b=TxwURB4ObEBWm6kPYTvSGqcuIEGQS2x9Sj7Rx6MdcGOXl5prM5fhygrBUjQnC07VUL
 zH4ZfWYwmcDpaoas3/Qsp6FDqIyWb8Q7Ymf2jMhcnCdf3UcL7DKrHGeKmvwn6u06W0Ti
 0PkKb5o27DtC/UiGPcSREbI4w2D8dm2LUnrHAPujhFJVBfH8vHMnnxXhjjVuzFKKnMrm
 Gpxy3NrhGV5cWpNxF1uVah8D2QWv5IQmMWHywg9nc1GjEXxfcJXpml/215+Gc/l3hPL1
 NHLUCxkOeoIiIR/Ku4Tjao2GjaW8B06ZeWS4h24/S8aRG23NUVtZ2zuFL1jvJXGR2JGI
 7uaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Xl4zRxtbD4rZ1QPQ9stJXKNnuMepND9L/DXbpKoF8Eg=;
 fh=Y1V6G491YFswb02Wlq1nXvsdCXs/+erkQQOD+Rbonq0=;
 b=BSuVEfy3OjXKJWPaKQhSob7x521xNme2YNjUaVFAQvsJoaqTwnxjayQIlcHar6plt1
 B+dZvn4rEkJna4IqISq+mDLXgIhrnNrcccXvwyyjIB6J3xf7Bjv392Ci1whfG+Y0H5Tk
 rf3fcKQwXgsIlegLjXzgRhs5JYBFVEGQBOlpoQtVHYimC7fEYZQIWBmrWlG6+O3uuQOG
 rWBjaWse2lab7E1lqQk6PqG+nw1xjLLzM0PU0N/tG2/OwbM4b081Sjm3Bcc20YwDOvtp
 PR//7oa0gzAy+Cieyf6ErYcsezE7rIttb6Kghmrkhn+XwPUTMB/hVp2/psVhAC1VC14t
 8GWg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791906053; x=1792510853; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Xl4zRxtbD4rZ1QPQ9stJXKNnuMepND9L/DXbpKoF8Eg=;
 b=RadFdz73tR3yqkaxuOuyk+h0iS6Kh+udHi1Wh7tHhu5vEqTyV+4ijAdO+2xsoR9Ynk
 9pXzZ5FHDLebThZcoeil0KZkT2mCcMzfsMisBN4avCaZxjCiwigD6hgzYWRSr8yYYdHz
 Zh6urgngx6U/K/6IVR8d1wZSbt21Shx45IWXF7NUbSjYPVR73gqHiei0PY2f4ekwUUF6
 LUaQEwq6UcPlWl9ccbxNQty9FxmHpU9n9kW82vwTC4uxhKusQdm8dhKeX72qGpT6Usel
 +RVwMEtaIgKawuc7G+0TiQn/0E0tVJYFy89fIEcU5tdJtRGpD+bTSP/DzVli6rV6y+cL
 oF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791906053; x=1792510853;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Xl4zRxtbD4rZ1QPQ9stJXKNnuMepND9L/DXbpKoF8Eg=;
 b=YSCn6pEtaLE10telFIPn3rBJkt5VhcpGPPl23GO2XSms0kZWQGEra0HTv4Phx0xZat
 Gom/HzYxySaeyoXCYo994PV3/2eRqUsl+Syu0+XCJ+XrwHLvRHjArWil1iEITXiUlqGm
 XgC7EQHlzEIK0Hs93hpJBYyzCL2/XbCjq3rLnJOgRqbSjRG0qFQXZI/H6yEpyECd50oG
 TZwi0nI63fWVpkBwYsxLf+bUOP7jwgJBJ8Q+x/B5G6TqNBliXTYr5YMEP3En6ZYSw1U8
 JLHscHCJRMB6SBLYxG2twBhO5rGlrCD2FxLO/c26grAiEi6SN4MvPtgwhF/knScf6Hi0
 jv3g==
X-Forwarded-Encrypted: i=1;
 AKwUvBygMuVGvPmSW2PkQyi04AoXT8pT1yCNpUXypTuF0unwnh5HkX9sobgnHAaPXj2Z7aJODN8LF+itPrA0@nongnu.org
X-Gm-Message-State: AFq9FYLrn8u/X615SGA48hr0T3b+5g9XPqM4M4d0MTkGUCrJ3UpjoZVs
 Tc0AQTSTYrl52rKrLzVK1Dqm4Qc6w5q8a+eGwvk7Fv3itJADsXVqvYYDSIqdwPgs2jpFkA4OwXo
 mbGJvQ2YYoF3QZ8/jAKAv/ym1y6KD22rYym5OrMZOYA==
X-Gm-Gg: AYBFou18s3HuHG9EBmi3TShQLP65g/GNeuXBmipyUyTIvJvbYn92HvE/vnn3ye2amwu
 em7eAVVsfw2Oz/i5IlzHHKP9aDHAuIf4yYV2UqM9jwSRMerQxrweXVwEz3O5BIPYBm/TK8yfwDo
 zPTVTwp1VerFqO/35U0OFEzEjoRdloUS7v97JmV1ukq421ud9utDrYeEqHsjUToKferK0SYuDJm
 JAMiWgQW1Kh4ci1PV0tWW8rdw3XvyWTtLuyMCVDJc8jrixwzE/4f2vs6DCoH+uVW8Fiw84G/cP3
 YJ6dfJ5WQjK/BRWMHb0xbtVabXANgnVICTWaLIotSTMPMsY1ENJjH9ZoGSqRyWWQW1R2vc2Z83V
 FMKzy3YZE2kuQkoQ20LxSEGGsqx4+XYNVePBo02I=
X-Received: by 2002:a05:690c:e145:b0:8a8:7fda:15db with SMTP id
 00721157ae682-8b07edb0b40mr36974837b3.22.1791906053032; Tue, 13 Oct 2026
 08:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-4-mark.caveayland@nutanix.com>
In-Reply-To: <20260916104435.600211-4-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 16:40:40 +0100
X-Gm-Features: AclHuK8SESetnPbkPIzW7fzFCm5Cs0Lztvlg79zYn30l_K_hxeD1jY48AGkU2b4
Message-ID: <CAFEAcA-7Y5AErqcOajBVjPSZywrvmCc8Ok792U8vBD9ZZfZzTw@mail.gmail.com>
Subject: Re: [PATCH 03/22] i8259_internal.h: rename PICCommonState to
 I8259CommonState
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Wed, 16 Sept 2026 at 11:47, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  include/hw/intc/i8259.h         |  8 ++---
>  include/hw/isa/i8259_internal.h | 10 +++---
>  hw/i386/kvm/i8259.c             | 10 +++---
>  hw/intc/i8259.c                 | 34 +++++++++----------
>  hw/intc/i8259_common.c          | 58 ++++++++++++++++-----------------
>  5 files changed, 60 insertions(+), 60 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

