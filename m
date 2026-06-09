Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786DDCD6E79
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWt4b-0004hQ-43; Tue, 09 Jun 2026 05:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWt4N-0004gU-8V
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:48:30 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWt4L-00042m-TV
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:48:27 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-660e9ea26b9so5335068d50.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 02:48:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780998504; cv=none;
 d=google.com; s=arc-20240605;
 b=J0TfrAQHGMDqzWo+8n+/vBfTdr+is1L0y/xlyH/yGPOfcK/FXPJEzuF8LnOKHGGP4B
 GkapshoV6/GWQsStrhbrorsqmhuMk9dk8SqF6NEGyIXFLyYy9U7QUZH9Lvw1LTlyBlwN
 wGTHq/TMBkVc2CMecjoG7ZptVXbXjWNCd9d2DXRSh/KfFSqzngS3XYJ6xkuYcs9UmeRn
 zVcv4W4E0ffrt2sNnT2a/9dOPpyBzURspoU7zVW3TpHjPMS9VlDcoTQwdS2B2n+eHSjM
 THwyZ5gf2sAm1hDqauf1c3EItu7/ISKX06OF8Go9c0SEKxz055OpoH/a7zYrQCe0x3q+
 3FRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8C6ZONQVBaodsbCuk0XADIqPMQQraaAB/Zt49/PsOPU=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=a9CMV+Ee9ae1xsCNCK5CeZqRX7rziNyv7nyPGV4WcyKvRQWbaYbkzzj4CDJ/MiN9d0
 OFwbBBWjdmWkfiQxq068ocPH+YrjizCCq2TiZu4mVx/GGU3K0+GwuMWbWx0gOQR+kpnW
 eKqejj2LM6v4yMtcEuj9wDi6yesHKcxyFIwrmceZSofvWxidQnYw/2MkJpELfig1ypMn
 2KD0oKGXDMXmrWz7HLoNCahn26obuuvosSzQI5iUZbhqUbpizfVnNZkuj5HPYWhAFLG2
 lX629g54UyJhmiR4SCRHGrpeAMevKyn2wIoZZjMi/eVicaZPEZLSimLcn0TkFnn0s3Yd
 uY8w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780998504; x=1781603304; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8C6ZONQVBaodsbCuk0XADIqPMQQraaAB/Zt49/PsOPU=;
 b=V4zt27yZI0PBaw1l7RmhGbYKSNbKKhx9Qb2PpROq4c40iYNLeW8BZlyuyjUQUwFohi
 1sNB+YMLEeaSybQEwl7mH+dA1nPCS39VaxDsXeoatSW5VReMKw2fz2aBnVbdPcB/g1Bt
 r3d9+lBTB1rQhORL615A2ewB367r9R9ZlhXZoGUucbsfogXvW2AYqBNwukLZ1U6t+XEw
 zaLvbZNIVn71OcVcoiecTNsgTZQTda9uexQzhN/i+VHjC3r+rry1P1ry/vUGlcloGNy2
 TSYWQWMlVK+jC4vBEb1USz8hY/IToypV83MUbzf0tO6xZfWuRXKufJa+davdqgGlLa7R
 P4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780998504; x=1781603304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8C6ZONQVBaodsbCuk0XADIqPMQQraaAB/Zt49/PsOPU=;
 b=dsSfESL0l50e11dnaoa2KuAkwTWBR0/bxGY3jg4IYbGi/aBue+ypuq5zcM8XTf0AJL
 BR9KHcYdhYJi+JJmby4UTONoKUS6VQJpp4WJW4LxD2H31oxwnYVBOAKwVWXt07WqIt9I
 1dTvJbTdU/PCexbUogVmphAWeeKZRmxnDzTu+sd0DhBOz1TfEog5GdvUk8UVS5TYZTl5
 NfnLMfTztVYKUuA4Bus6S8fGQX0Fu6wkyYvmtfOlZEjMHLmwGUgGM1pcNDNxiE6gDlRv
 op4OoALbf7Y44HY+OHwVI0yfm3yYVhnAN3ma8rh0hn14347/064n1dgR1hM9NaCPWzae
 470g==
X-Gm-Message-State: AOJu0YyNAM4hYv4qkywcSl6GeWqv3V4UAbf51PytQoP2IJ6kMS3WVkBT
 LAmvTOUBZyUX24nwwi9SBExlxcX8vg9kdkPilKwKXU97Img5PzMdSE3uK2g701KCxu72xqMrsJF
 iTI4vsq/0OQQFMjMPSLWzA4xcZZDQiQ9DKt4Xvqz+dA==
X-Gm-Gg: Acq92OHNhg6JLWStH6aUYbgsfC4uB53wyp2qozKDz6fdVEwnGBbVG4ScJL+yKn+JsHW
 rJaaQfGDXlNyhh++3HRW7+P3Gmh5O2k0l0b7+8+34erPzoct21kC8iFUoqrWMe4SfUY15zJviib
 pe0j1ay71rvspGR7ciGkNQT9XkVXCg9SdBDP0yDeb5hSbFEKqnyB9RMYxvTd/kmdtOebGmPFaxz
 9cSrxexktv+LFtDxSzraqnrJKiuVof0w++hEpkOsYK19Ks7j3EDVApJZx19qAFg2R4RvdtxW7WY
 lgA/unFmHuMSZVzxOEHCme8ec9rcHZqcO0hTSAzj4XHctWLUCN/hovuEwce8jJdAgHmHB7QCPYl
 zfw==
X-Received: by 2002:a05:690e:440c:b0:660:57ad:a541 with SMTP id
 956f58d0204a3-66106e382bdmr12181517d50.18.1780998504302; Tue, 09 Jun 2026
 02:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-28-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-28-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 10:48:12 +0100
X-Gm-Features: AVVi8CfDJrARZbA0vgd9jBeaAjnjP5gHD1MqWfTRb5JsCsQCfXMGcW4es9325sg
Message-ID: <CAFEAcA87wAL=uaMmCkBmWKnwDrvPTpGmwZ0aymniUGb62V6dOA@mail.gmail.com>
Subject: Re: [PATCH v9 27/45] target/arm: Implement LUTI4 (four registers,
 8-bit)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Wed, 3 Jun 2026 at 04:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h      |  5 +++++
>  target/arm/tcg/helper-defs.h   |  1 +
>  target/arm/tcg/translate-sme.c |  6 ++++++
>  target/arm/tcg/vec_helper.c    | 14 ++++++++++++++
>  target/arm/tcg/sme.decode      |  6 ++++++
>  5 files changed, 32 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

