Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53561C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvzMq-0004XR-74; Mon, 17 Aug 2026 11:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvzMj-0004WW-WA
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:35:13 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvzMe-00078g-K7
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:35:05 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-81f3b227a4aso51666907b3.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 08:35:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786980901; cv=none;
 d=google.com; s=arc-20260327;
 b=O3gaamK6IpQa23+Afdy1rxv1Y/FMYAZ+U0ST3NLaw1K3OQx5Z9KevC2IqMgRDoscML
 o0Xf4SGrqHGW3+EkZZ2rPgpebjifdqIb8QN8VDS/MAQH6j2YLGvnfy16AGJVlTgJWPfo
 gEekTZSrsc3u0tvIb6aKepLFk592zT9iZ0XQ2Oy2xg4EgWFkgY9PiYvTXi5ARtTsXNKe
 0MlJ/tpYFgEfTYuY6ETA8uQfkQW4zkb4E5Gi8zImk6gJwpvrwhwEHRpYqnKxwJJ+qs8S
 1Nr6gDPGr3qxac7S6p5ubfbDE1ZFIpjHw+f8oC10TCmEFsWpeihnkvZjbBpSgKNVexUO
 QyNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MmjSya6t6MsCWp6oHkwzpWJlKR5JnMtoXgEi7EGW03M=;
 fh=xChv7ieWS1sj6jE9IHpGYXOFSuW+3i48YUpPGYmP/DA=;
 b=sd/zhod4pjoLLL18vlihksklSpGfRsxCIRF5EX3+Q4R56zlVtgqokVm5NfqzGZ7Sbx
 FfmcdvvWVUxrlK+O9srWC5Gt9ME7wuDxFX+Rh6KBzy4Lqu160Q5k/UaFkx67EHBEAU3l
 1xVT7U55LQptICZnptqp/5N1Ktn5+R66osbeA+DeK4Jn4I2JIEnfFaFmnbNojUc2uGZy
 n32cN7KqWwKhCS4wK3BMCZ8d9G/MQB4T8+xAvKurPdZYga3hJFoVmlCpnKmHsQgVXGJe
 IxRErIRAggc/STlNuWWVhRGjKGibCzfZFJOwtZzISl+ka16xH5ogr4l2YI2bQQaRSzTG
 WsWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786980901; x=1787585701; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MmjSya6t6MsCWp6oHkwzpWJlKR5JnMtoXgEi7EGW03M=;
 b=ubRQjr9LozUXZIZ131HNOhygapfQF1XY94IdDlq6S9BwEaQ+i9vvCbOIzSIHbmiYEk
 c2E+GoDTFUiLofqFjrRKnT74dt+Rr+Hdu9Hy0rXC7N12n9lpClrrzzvTn7F5QfIrcOF0
 w5Q6QPrVC5ejwJLKxI+wwr8UmVF1NvlttLT5UY8wOv4HQmbnFbffaq7JYowcJYG+FyLA
 n1li6UKBY/2ztJAzZ3K/QxBGMQS1kQVPTftdR+E4+jGWazsfh2S/5G/F2cC+HhC72uXG
 silsvcSU3/pToOew6Fb/1kFjk8iuYPGOZss4RCEzuqognrNLNAx+lkyZhnuuRFz56gJu
 LeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786980901; x=1787585701;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MmjSya6t6MsCWp6oHkwzpWJlKR5JnMtoXgEi7EGW03M=;
 b=ZCREj0tqjcUGGgWko9JSLcTW51eUpy22Acs0Za5CYIlgvCRuNzZN3X510aBdW0Y+3i
 SZg8CnHAYV0+8sAWBI1Rrw3i0DllcKPypbBjgIH9yBY47qx9f5D7xCflpDgIkroRyzi9
 jl40varqTvZkEKAJ0rDCOWY9VknsQ53nDu35/1QwfKEptFQrGLx4WoXmvRET0mJpOT96
 0tL96a9paHmObDJeQ0gjirwcnFfggzumMsqVktSh+tPn5UvSrrPP7kAp+vYz6ePtziuH
 foJaO5A/IuswOSC/4/dcI2DAam+v4meK05H8saoI9uvMkzaHNkZHEhCS5XHD8rlF6vOH
 xbTw==
X-Gm-Message-State: AOJu0YxLSj/8ZugxNRcp1Pav6pxK4NZjhXketZW/xwUXgec/7Mgji4C6
 TkV2FXes79Z1osOnHKF+xYYl9X6aYFlmPytKInRMmo/zZTRJp3DbnUXzp8cGb0i+QweXbAYqg65
 PzURcizzbrg46F9/CPjk87ykAjMD4j1LijUrI64AcVg==
X-Gm-Gg: AR+sD13IQMmijuVIZL35/iLfX1l8oJFxDmPAnsz9OOgRRp7MmuLPHYlERbHTVLzsZCF
 Uya21wM2W2KqOUYWZ4ohVQTgOuH1BFEE7jk9ZR0Aah+KcBULkSU8iJP1ZrdB4QGQJG3E5VROhON
 5fEPZtWZyV0cyuw80y+bMdfsk+V4o47dxDaKfcM7d7owOa8kO4RBjcH3jdYiYnDLfrIGkWj3pTw
 rLN73Px/qAyYKYQkaAN4kzPZtRGZJgF+TsZNOaFRmsA0gyVSbRE4AKWVXgmzWS+XyFrZmjtj79Z
 B3Df9Ivv4fMYidxWSw9U2W9r2QjYnhLOqYaFH4YrLivfX97H3u17KyM6iszLD34aGFm3xApA2vR
 6paJPd/8PR//VyFQVXxnISJ7NpHzm
X-Received: by 2002:a05:690c:9a12:b0:81e:89b2:91ae with SMTP id
 00721157ae682-837118357c9mr100882887b3.21.1786980900633; Mon, 17 Aug 2026
 08:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260805153005.9989-1-simonxhy0404@gmail.com>
 <20260805153005.9989-6-simonxhy0404@gmail.com>
In-Reply-To: <20260805153005.9989-6-simonxhy0404@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Aug 2026 16:34:48 +0100
X-Gm-Features: AcwNN1V5EVpivNd8Np0xC72WLDNGwcpeBvYwYsIKeinYArScF7RDCRQQP4fQKgY
Message-ID: <CAFEAcA_r40M4SpC5jLUoi2n2PcsYODCRot=io9xCOFyqBHXtaA@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] hw/misc/iotkit-secctl.c: add SSE-310 support
To: Simon Xu <simonxhy0404@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Owen Giles <owen.giles@hpe.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Robert Elliott <elliott@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Wed, 5 Aug 2026 at 16:30, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> Add SSE-310 secure and non-secure ID registers.
>
> Reviewed-by: Owen Giles <owen.giles@hpe.com>
> Reviewed-by: Robert Elliott <elliott@hpe.com>
> Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
> ---
> v1 -> v2
>         With the bug fix from the previous patch
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

