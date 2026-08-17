Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60069C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvzb5-0002Jr-VX; Mon, 17 Aug 2026 11:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvzb2-0002Gn-LT
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:49:57 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvzb0-0003mn-9a
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:49:56 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-836f34a0ceaso467207b3.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 08:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786981793; cv=none;
 d=google.com; s=arc-20260327;
 b=I4qrX9XZPeGZ9lx9WeJ3JqxZRtdRdbgj4ImAz39RIrrg3FLPPj/Mn1d+LrUc3hjRNk
 xEXKXvxG9Y4Mv9itffQhZpkLRvpjuXP27ZF0IROYqxXEc/EY6EHZgzoN8QNVRcMbFW9g
 7e/BLen3iliX7jUNj/Q/n+v2Lj+6HF2PATLZx1XABDSLyjK0pW47Yq0sqqPgTAzTRprG
 mMArvAyNhC9Xx2Aju7xswOWHLV7UYI/pXYTmJd0OIudJB4zxSfkLcE6XwTVrqCl59M6u
 u6+jPdt4jxtRL3x8rVW93STnm5sPPGanEfGS/uhnAEb5Q1QqAbVD1c3x8Do7PRvrwXeP
 /49g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=C7N0DHQYtLhmp6Pbc2ndzyTZyPyaRkhh70v7F2iqE8c=;
 fh=xChv7ieWS1sj6jE9IHpGYXOFSuW+3i48YUpPGYmP/DA=;
 b=MCnjXEg0aQ9+3LOW6n5oy9fHfKvSk8vhkULhIxvOeokK1T0GwI+WxM4Wik+PCCuHG2
 hu+FIJZvb93TFetPlTNCJOF19xKwnFiJY3ebevRaCBfqBME9XRQ/Frx3qiCxZIsdWZky
 ag2LPKBApzSsys4dAkbbKcpCVYmZjWq1qybl+Fadyqa3lZD2DppOqeygCCpJktKwuvZ2
 0Dfs/VibyQKrFotDuzpTaObS4UplhStimHO4lmcq/AjQLNO9tF03+Xj+EczvSXLzIz+o
 yagGvpVxfxGfF+voW37Vs1MAGAoSbvsiEk24A1YU7vV7N7+0h8TWDQP2F8HIlLCq3bmF
 bpIg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786981793; x=1787586593; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C7N0DHQYtLhmp6Pbc2ndzyTZyPyaRkhh70v7F2iqE8c=;
 b=QFLyTHchiUsr4TtiSRmRJfDFFnEe5qJlfYc5ZZT8gOtlFl0FjQbtDLVoqrGXfyTE5E
 bG5NFjJPARa024U5ysiKgwuCzJT1wDXjPoMecMvw3CEQNta9l//0Gj0jgbEzd8KtWe0p
 KBtvrjMNacl11mlDjT6La9qQECYS+tidK411eDX3yGjoRGQlnwZHqSZskx9HiZMoQ3P+
 toqSgW44LeV9bXJWPUT4TX8br1JARIss00evLqaLQ56ky+aYZ5+gMVPQVlgHdXa8ghjc
 QjdOMVT34/40dyyyIFv3xBhe+eRjSpe4RhfF/i4IIhS74D+EbXBhfA1a4wN7wlzYYuiY
 tWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786981793; x=1787586593;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=C7N0DHQYtLhmp6Pbc2ndzyTZyPyaRkhh70v7F2iqE8c=;
 b=msqBxgZbtII3E8G197ycF2sMg2sEahctgxlSOUj/b12YyMopUY+vgC3fn1olBnCPXu
 6RibLJRGQvNmJLGzcuhXVk6OjMwdUd0Oi3mDXka6uBn2S4ensVMxjF1w3DAU+QI+VTVb
 6ve1Q2M3oqyFpK0+uQhEHneQZpn8dMnLApUBHuhpF/YhX8yFe0z6ue8FC0KVFbdq1ksw
 W3eKbm0xuBDEViqmxgSUCxm2P6xz59AX8hlC7i1qlHUuzvGn7tvYc+EKkKJmK3GV9pMu
 KvnJ4tYyUYpYT1lnGLxIMZsUl1Toej0OEBOW4B4NkT0plMHbUc2o0MaLBFnqP3j/NCSA
 mc7A==
X-Gm-Message-State: AOJu0YxPMw8EpHjebXBVAXIGp0fQZyOlPGu72uXBzF8wklZ9J+uKDZ5x
 mOtxZpoH+am96wYvhigVVKmUifL662UT3RRiTNO1N5yQgPb4XDqo48iQCW7yi6Srjj+Aq5SaSBE
 9B/KCSQRifMmfXeGdabnqh2yQTp3sEdw0+O9luhPGcw==
X-Gm-Gg: AR+sD11Ej1tuYa4A2/mJgq5vzM0vbNJLPQ44CJRYa4HzfL95/TWs4g2/8/cGTZQ3/Hy
 eQTbi14ujaoHfiHy50U9EmTpR31gv6o5nAr30NkRNCogHlDqf9f1OYtm+H3olxfoKfPRuh0L9vZ
 NW16dJ2Xhe9m3OyY+7urFO+uxJ9B0Vv0aVgwXaCKGk9n06alYX4Ry1r/iwKoQup7nU16/S1jOgy
 HqulFPKrHBr8HGHWFdPhWqCGio3g2lVsXHSdOWZSvkpbIkkhgPF21DT67BRM3myJm8A/vMUdOXf
 7s3VvZrmq/9n75BKDUfOT3iPgytfLuAFt9jdj36FH9HYz3NyQ+l9v0HIN+sIciVEmtIwj2+3jpE
 8j3/XQtIxqv0JspkRSWdkv0QtC1wH
X-Received: by 2002:a05:690c:305:b0:826:8d02:8e97 with SMTP id
 00721157ae682-841a31b2f24mr403517b3.11.1786981792837; Mon, 17 Aug 2026
 08:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260805153005.9989-1-simonxhy0404@gmail.com>
 <20260805153005.9989-10-simonxhy0404@gmail.com>
In-Reply-To: <20260805153005.9989-10-simonxhy0404@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Aug 2026 16:49:41 +0100
X-Gm-Features: AcwNN1UPDX8c8zIKI_GBY-qn0KykqbMkHgLTURlPE9vtJVI9nniVJdZhpm-WqnM
Message-ID: <CAFEAcA8rTw8VtRrcOxs4ihqFLwCKeQUMar3HE7ijGsC9bZf5Qw@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] hw/misc/mps2-fpgaio.c: add GPIOALT2 register
To: Simon Xu <simonxhy0404@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Owen Giles <owen.giles@hpe.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Robert Elliott <elliott@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Wed, 5 Aug 2026 at 16:30, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> Add GPIOALT2 register for new an555 board.
> Implement register access as RW with LOG_UNIMP for writes.
> Add "has-gpioalt2" property to make each board configurable.
>
> Reviewed-by: Owen Giles <owen.giles@hpe.com>
> Reviewed-by: Robert Elliott <elliott@hpe.com>
> Signed-off-by: Simon Xu <simonxhy0404@gmail.com>

This patch should go in the series before the one where we add
the an555 board, so that all the features it's supposed to have
are implemented before we expose it to users.

>  static void mps2_fpgaio_class_init(ObjectClass *klass, const void *data)
> diff --git a/include/hw/misc/mps2-fpgaio.h b/include/hw/misc/mps2-fpgaio.h
> index edd9f23121..7512686616 100644
> --- a/include/hw/misc/mps2-fpgaio.h
> +++ b/include/hw/misc/mps2-fpgaio.h
> @@ -40,11 +40,13 @@ struct MPS2FPGAIO {
>      uint32_t num_leds;
>      bool has_switches;
>      bool has_dbgctrl;
> +    bool has_gpioalt2;
>
>      uint32_t led0;
>      uint32_t prescale;
>      uint32_t misc;
>      uint32_t dbgctrl;
> +    uint32_t gpioalt2;

We need to migrate this new device state. To do that we'll have to
add a new vmstate subsection to the mps2_fpgaio_vmstate. If
you look at iotkit-sysctl.c you can see an example of how this
is done: you add a new .subsections to the vmstate, which
contains &mps2_fpgaio_gpioalt2_vmstate, plus a NULL terminator.
That new mps2_fpgaio_gpioalt2_vmstate should look like this:

static const VMStateDescription mps2_fpgaio_gpioalt2_vmstate = {
    .name = "mps2-fpgaio/gpioalt2",
    .version_id = 1,
    .minimum_version_id = 1,
    .needed = needed_gpioalt2,
    .fields = (const VMStateField[]) {
        VMSTATE_UINT32(gpioalt2, MPS2FPGAIO),
        VMSTATE_END_OF_LIST()
    }
};

The needed_gpioalt2 function should return true if has_gpioalt2.
(It gets passed the MPS2FPGAIO* as a void*, so you need to
cast it to the right type with the QOM macro.)

thanks
-- PMM

