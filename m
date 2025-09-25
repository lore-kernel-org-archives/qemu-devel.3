Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F44CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1izC-0005Me-Sw; Thu, 25 Sep 2025 06:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1iz5-0005JW-RU
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:13:56 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1iyv-0007vy-Vj
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:13:54 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-ea5d1270b56so922196276.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 03:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758795220; x=1759400020; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lGT1XRd6mFHHrJyh0DIX8x9k5bXs1BvOOEdx1L+eyJs=;
 b=wb3h8cX8/JFzAqqOOphZq9rPWlsl92o2W4VdQBAr9S626SBg+3KGiGy0xVsdpydr5t
 bU1Xc5XX/fw1DiXfEdsTUvpqDAR1JsoLwkqSe4meZH1SAj0mtfRAPSFrLvQavHjqphOg
 wY19n1u0T4yVrqTE05Ju2min4SVG4WqoDnnNr2SRpRZoBGTe1RcvmVHNXIiP5nZ32wZF
 S5zIEpah4nOM7IhMA9DiQWgMKgxIpyhzXCIHK0+cr6eVArmb+JF0oCGbp1iv7B7Y5yxH
 Zdu4iziAAS8BeyCt95NleefzLFjBR7nF536KMf9AZTKeeWRZq8QD9LUhpIlK7GVnfO4e
 6gXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758795220; x=1759400020;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lGT1XRd6mFHHrJyh0DIX8x9k5bXs1BvOOEdx1L+eyJs=;
 b=GULthuyx+nGZpCecEcSzZUIibXwwkaMJrMar0uUhRd9JoVQCyZLkJMS4wwU8asSEJ6
 By6lQo3LQrl32sm2xOOBTo+Nr8o8Yh52RcMlzGawtb6wScraw4jSe0idZKA5kRxj7C2r
 JllKgL/ztRWzZPoy6fnJt2LT6beNaifXcfbLV9taEg8XtOxzYPSjGpym7GS9WrAp+AhZ
 b9zT5+6KWERMJrav+pR3NARjIIbJkraP84WTuRwrIBhY+KecI4QkOSOPe7jx51ReF+93
 8ON2G7BjFPX4j9+UpSXKDybHR6BAoxzZ4QGlE4WXMiZhWu24O5jVbo6o9ZAhh5mLZqoh
 Z2Ww==
X-Gm-Message-State: AOJu0Yx4Hqe1Dg47pJIYihF+p9MWP6nYNW1iqfFbyGnLDcjkjkXjZGDP
 T/zAiKTWcoCAMKPw5vOCDHjeMZXAH1hXdrUqtbC7KMl9BlzDt7F1W7Y7C4UaSbrIUMrrJ1oXtqw
 AyvM+f5YnLReAm6TZHqkjGAeaGLtCv/KVKkAFf/iiwK4mnJ5g0bsE
X-Gm-Gg: ASbGncv6qFRcvS3A6N+Y8e1E5RUe4MZ0Ciynv95nhcP/n4uMl/hlIYQBQ3dTbwlsOfM
 FccJv7iRYnz4HMn3B44Y3wuKRILH508wB0X4egjjFNdyW/s9mmDjzVB0SCVZqqDKdnRVA3cTxgx
 rYApgQIcTzi5Oi1q5aerH7Zuid/+BCeOrqJLL4zvCB6P3dVAmAVcvDpYSsTlWEFkgllsgYVb0jX
 4Bwd5o5OrLBwu7zfrU=
X-Google-Smtp-Source: AGHT+IHSQ0YOlVU9G600Vh5gqbc079fQ49o9WQoXV6QhrCrwzSuRik9fBnsPTq4DjCcDia2P9Kul00CLp1q5welyQl8=
X-Received: by 2002:a05:6902:2d07:b0:e97:e05:3253 with SMTP id
 3f1490d57ef6-eb37fbf11ecmr2464174276.17.1758795220186; Thu, 25 Sep 2025
 03:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250718133110.1510978-1-lvivier@redhat.com>
In-Reply-To: <20250718133110.1510978-1-lvivier@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Sep 2025 11:13:29 +0100
X-Gm-Features: AS18NWDEKgYcfP738Nc4fZvHsGvgVWp2o-WgZKbmhcxM1_pVcfHaxzqyWWM9AQs
Message-ID: <CAFEAcA9TgPYv3CxP59gXSOnsCqYJ7ZQ07FhikMy-HYkWHfNakg@mail.gmail.com>
Subject: Re: [PATCH] net/passt: Fix build failure due to missing GIO dependency
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Fri, 18 Jul 2025 at 14:32, Laurent Vivier <lvivier@redhat.com> wrote:
>
> The passt networking backend uses functions from the GIO library,
> such as g_subprocess_launcher_new(), to manage its daemon process.
> So, building with passt enabled requires GIO to be available.
>
> If we enable passt and disable gio the build fails during linkage with
> undefined reference errors:
>
>   /usr/bin/ld: libsystem.a.p/net_passt.c.o: in function `net_passt_start_daemon':
>   net/passt.c:250: undefined reference to `g_subprocess_launcher_new'
>   /usr/bin/ld: net/passt.c:251: undefined reference to `g_subprocess_launcher_take_fd'
>   /usr/bin/ld: net/passt.c:253: undefined reference to `g_subprocess_launcher_spawnv'
>   /usr/bin/ld: net/passt.c:256: undefined reference to `g_object_unref'
>   /usr/bin/ld: net/passt.c:263: undefined reference to `g_subprocess_wait'
>   /usr/bin/ld: net/passt.c:268: undefined reference to `g_subprocess_get_if_exited'
>   /usr/bin/ld: libsystem.a.p/net_passt.c.o: in function `glib_autoptr_clear_GSubprocess':
>   /usr/include/glib-2.0/gio/gio-autocleanups.h:132: undefined reference to `g_object_unref'
>   /usr/bin/ld: libsystem.a.p/net_passt.c.o: in function `net_passt_start_daemon':
>   net/passt.c:269: undefined reference to `g_subprocess_get_exit_status'
>
> Fix this by adding an explicit weson dependency on GIO for the passt
> option.
> The existing dependency on linux is kept because passt is only available
> on this OS.
>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>


I've picked this up via target-arm.next, and added some tags:
Cc: qemu-stable@nongnu.org
Fixes: 854ee02b222 ("net: Add passt network backend")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3121

-- PMM

