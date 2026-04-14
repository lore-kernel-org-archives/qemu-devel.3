Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3A8F9D0D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 15:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCfm3-0008Ja-01; Tue, 14 Apr 2026 11:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCfln-0008FD-89
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:33:47 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCflk-0002PH-T3
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:33:42 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-651d692e833so1814531d50.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 08:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776180819; cv=none;
 d=google.com; s=arc-20240605;
 b=CuV7cAh8pvSv1m0FmxoklSW11P2xZb8Nqs13GPRxz7wSIlak/U6+hwjRFrp/Zd0hy7
 00WkmeI3mXe/3nPWk5h8Os6xqRkI0O9Lk/VPu+XV4mmg2ym3F8nmuSVBS3nq9dA4S+dv
 8Gvrs3m8kjuQgfakx5uSUYVAliCLVoDe16nTipcfx7z1p9Kc1AsUburcx4wzruKDQGCz
 PhtS1+3XNF9pL/NNf5z0ymiLNI2malBTwDGkZE5xSq70aCwPHEEgLvFeVNj/00didPV7
 M5heeM777N2gzkzqszqFV59f+f8HIfeG00AG4iknePEXs38B/cJvxuZqQ3/ngW6z9RDA
 Yuig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JqlTNKeKRP1EGbnPDrIlwmasHcPhUiheVy+T0tzWyuo=;
 fh=deni8HxXlep4Bc6IVKDjGikudT6zI4MmdGbZ9bUiORo=;
 b=Y7QO7HeL5h3Vf9dYufwPreDi2hru02D+DwPYbsjc/3msfSDQVtZ87Ry+xdo3PyQl9H
 CT+/a3KdzRdhq6AWOd3zw3iNv95k+PrPvPookyle2FkrwAwj3KTI5jcPeAH3ykr0TPOr
 a5q28p5vq8/6c98IAaqYv2PxV+YoG1H8nrvjq53n/sOBnITWjm1nRGC4sjMDKhP25fS5
 LEYWpNeahh+Qlv9zGJqJ4oKwTNQzbgd85D/4Hn8euUhRkOXJuwNYPEXrQs3k3ppswjVk
 RI+Hlz0XiMjFlBqoIskdPKX2ltF/fKJTF6Nh4+Zdl6S1lmtDV9NbpC5UoehoX1Ifl35P
 lmbg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776180819; x=1776785619; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JqlTNKeKRP1EGbnPDrIlwmasHcPhUiheVy+T0tzWyuo=;
 b=OGRiNil2/LBhBJYuVQNJbJiZKUBWaSBynaFalPi0csG+gWU8DyH1wLubiwutuouJR5
 7aJc5pMQGz34Rucuyyl6c5tSODrcm1gGC6qE7g+ail/NSEYUANdQldKqQvuiyRaIjUge
 06tr4FTBloi0BHmitbk4lYMu3kHTSPb0gQI0yTL8dMde5qnr5Uf9Ax+UveRqCn4qzVT/
 TEYBcMwzE/jh4PxyJR9dLoTY6CWGyVf83/ZiMCMXjy8IjHXblDFO9oLTydh7KRw/m4Q6
 0X6JDdkPzcttxJOS94tntX0XkB2irxy4BEGIdjKexQusyzeYyW8a/Y511YjRAwRSTomh
 MUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776180819; x=1776785619;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JqlTNKeKRP1EGbnPDrIlwmasHcPhUiheVy+T0tzWyuo=;
 b=QqTBmPCk8uNQ31tFl25eGyQerYRozB1Ne43QTZ5xep+4WTbuT8wG4dyEpvpHt07eSl
 7SIZ6isWxOjT9DcboUptj8mXiIyxyqZsMjfB5OpspNRqxDw3qwQomI0msPhZ91ybJR8X
 vEkkSkbXx66v24ynua3Nl2AimKn6u8FSkgKI70t/Jv3JyIb34Txxwwv3PPtvB9BVZgOV
 tKBL/yd9EkUhNp6S8XPEu1KYxWFIZzWYilfYGLhMXc9VnZhCGAxjbBB878OItcnIFUpk
 4ptfar+aMlRv94savyefG3bCTBzGKPCvn6sHpSQkJEsyvIEtI3gA8ExqpW+Idi0EbHad
 fhfg==
X-Gm-Message-State: AOJu0Yx7BF+hUpK/+eMmH5weqXHgJtBktk5FxZdpz3N9ILn6QGGH0YJ+
 cEsP2db8evmZT6ajIbUVbnCQUvUh9n/kPzxZBO2o6ZCLRKnhIWaO8bD6Vbv35FXY1F2zQFikeOx
 /X83vTxAYsVD77xdA9KK2v4WepQjKNOc4kbtDoDejLA==
X-Gm-Gg: AeBDievLaMzJe8Cp2FcrDxh36Cwum9KOj78Nu8rE7+q6/Qnim91Sa7OOVJTovo8Y43P
 iB3K+4COykVgEbbT0e2NzMvr0KuCvcetKkhs6Vm5LmqBRBYhQaAAIjBVnkIAyYljwxAnK+fEELY
 PJlS1ZrSnFsyUPUbdZAhpP6L1IcSBO5D1qE/h9f4UryKz5STqP94vVLIXNdcFQFDiu7S/+zHzES
 KLsdLvRB25DwEiifmkaPTiLjd4Jz0Tr/BpkcZ6/YAxjWzCcn36D9p8pXxs3Fo1RKmXvPf5srKRa
 5MdJvNZOpY9JVX/iFishX4/2J/dAZiQWZkrsC45usyhcHiWuHFeqz0mGVRiDKc2DYqA=
X-Received: by 2002:a05:690e:e88:b0:651:bf32:de6 with SMTP id
 956f58d0204a3-651bf321462mr9620108d50.54.1776180819161; Tue, 14 Apr 2026
 08:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260414114033.2360-1-shentey@gmail.com>
In-Reply-To: <20260414114033.2360-1-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Apr 2026 16:33:27 +0100
X-Gm-Features: AQROBzAShnZi1-pS8ZX_X7tflRIetS03e8NXhZvcBB1PGzv7p3MX1WaKFNlsfow
Message-ID: <CAFEAcA8DqYBwwNNz=ua0q8WKq+qc2qbnhY+CDurCz3fx1TH_yw@mail.gmail.com>
Subject: Re: [PATCH] util/cutils: Fix heap corruption under Windows
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Tue, 14 Apr 2026 at 12:40, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Under Windows, QEMU would only sporadically start successfully. In the
> G_OS_WIN32 case, get_relocated_path() first determines a cursor
> to the end of the "result" string and then increases its size with
> g_string_set_size(). Since g_string_set_size() may reallocate, the
> cursor may become dangling. Windows may detect this and crash the QEMU
> process with the following message:
>
>   HEAP: Free Heap block 000000000499B640 modified at 000000000499B684 after it was freed
>
> Furthermore, QEMU crashes spontaneously, even long after the guest has
> booted. For example, it presumably chrashes due to the guest setting a
> new cursor icon which may be a result of the heap corruption.
>
> Fix this by determining the cursor on the resized string.
>
> Fixes: cf60ccc3306c ("cutils: Introduce bundle mechanism")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Thanks -- this isn't strictly a regression from 10.2 but it seems
worth getting into rc4, and the fix is clear and small, so I'm
going to apply it to git.

-- PMM

