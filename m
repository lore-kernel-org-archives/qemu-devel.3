Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CA6C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 19:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkUSu-0005yg-Ak; Wed, 13 Mar 2024 15:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rkUSs-0005y8-FN
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:40:38 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rkUSr-0004Au-29
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:40:38 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56899d9bf52so259779a12.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 12:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710358835; x=1710963635; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wv6PR31IpeRCrdiWV9ppttAHnl6/2+vuVtyTTu0/Kpw=;
 b=BAyJAP/sovCD0ieAYGcmicAKqPhmzJiIXzvT6w6x8ypAYHMYrrtciAwjfbUeUDAP5h
 owKEpQ7dHIlIik7BOGX2BjFkWu+F4FOfp/QmUf0XyToERgixkUXu0uJCl2xan9vIn1uC
 +gh+CC/Hf7QKQe3riLAu9buZa5+zbWzYX+KG2b3BERq3i3+HAki3tjqzvXdWZ9hGXjYS
 /l1y/fHMs5WzJU2AvQScf6090T0W+djMD9/8U+fPdYHiKZ/kd5cWWzUlot3k1zcnrP/T
 fgKxCDCggEsFwH+E1Tn6dJpmY648PqYZWEdVHf4dIIH+fksMJvmpArVjNSjME90hPLUE
 ALOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710358835; x=1710963635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wv6PR31IpeRCrdiWV9ppttAHnl6/2+vuVtyTTu0/Kpw=;
 b=MZ8E6dWm3i7uiLquimmdTS4NNmGeBZVSRtPTzDcM+6UgqFuLtq7J4phk5Gy9z3rP1V
 uBDxFamTfymBKftPt6QLwQlP4AmYR23feHRqnn86dOKgozQCqADaaAuHNhPPuQmliIDm
 dY1fM7PwEgRlgqOmb2fgrd0iwzTNStkC+8GTNq2o4xfKb75HkKQiPtFhqeDf7/ildpGl
 7kC2TW7UWNm670mIzqMsrl/KcBC0M9MUy/6J9QtM1K/zeomMmxSowe7ts5hCtltBgI1O
 ZzTS5xwYIW7ZMD1g2xnXNhOA+/zJFYWHl8C5ukxirJ0Bbjz/ESV0HQ3YoMo/juno8GXQ
 Re4A==
X-Gm-Message-State: AOJu0YyfaZqVxxM4YZpjLZbTOJjErEE8dsX7joXY6C8NHUIVzZR7JS9U
 MUd6OLneYgOOX8xkEoKcxDdCKdV24P/kB/dHqqRFeWr4wuLEBFdZAGgBN78C5Q5x9ybgZpYspxS
 AMXQhdYHAwp5vJ+9DZdZ1A46wW0J8s9N88ng79nmRHXZGnPJI
X-Google-Smtp-Source: AGHT+IHt/SsLK/8NHh5VDgqQMhY1reUwFuZFHeKCwrYsZP/5pmVkVpUqt6IrrzNXGSAEim1+vMp8FDWSoJUCa3zKvvI=
X-Received: by 2002:a50:934a:0:b0:568:1882:651f with SMTP id
 n10-20020a50934a000000b005681882651fmr9461639eda.25.1710358835488; Wed, 13
 Mar 2024 12:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240313184954.42513-1-philmd@linaro.org>
 <20240313184954.42513-3-philmd@linaro.org>
In-Reply-To: <20240313184954.42513-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Mar 2024 19:40:24 +0000
Message-ID: <CAFEAcA8KhyikEOusdJwFR5JbuDMnx_rnzm5w=U-OVcpDaSy9fw@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 2/4] accel/hvf: Un-inline
 hvf_arch_supports_guest_debug()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, 
 Eric Auger <eric.auger@redhat.com>, qemu-block@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 13 Mar 2024 at 18:50, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> See previous commit and commit 9de9fa5cf2 ("Avoid using inlined
> functions with external linkage") for rationale.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

