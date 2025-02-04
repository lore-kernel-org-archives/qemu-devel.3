Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812E1C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfL4k-0000pe-D9; Tue, 04 Feb 2025 10:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfL4f-0000ot-Ca
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:42:54 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfL4Y-0007Ty-Aa
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:42:53 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e53a5ff2233so5881692276.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 07:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738683763; x=1739288563; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DnMZtMniCxINhGi11kvKfO5coLPW3VGFNFzuESVF9m0=;
 b=u2nCrmygS3D8NkbGoz0H+/HagDMpYbJ90hyykyfht/m2CmEH6DVk6CtnDDYMh6hucV
 1xQ7Gg0bLCzAG16ccf6wRtqML/LgmZz7X3x3g+FPRTDyNr0yDEGjocK+Qm8X/Vl2r9I0
 fo1fX8jVq21UB/dtQHB6Xr9ILvBBRyR1gFOEh4kTErSgbD+F8tKpsnA/zPdjFrXUr/h6
 2w2a3NHMYPgDqKpVMsdsPUQIEJPD/AQ91WMyhapIdURpIL4DDkxv8uC9vqrz/MIYYgZo
 Muy5cuKDEmMYX8dNgA26ABdp22MZ6mjMibTYiVXPuAvs6v2xs5mc3FlHXRgT3BT2DnnH
 pJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738683763; x=1739288563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DnMZtMniCxINhGi11kvKfO5coLPW3VGFNFzuESVF9m0=;
 b=PphH2DuMVEY2hvMf974ztR11QmR5QXg95fZIVPk8+OELCAoiK6RSeLEGQWYG3+0Pw7
 kJkEpqUavmGS4JvkT5+Ue0mMq/K2Fbbb4OR06wpNIJFS9g9bfbDZd3j9YeRdF4v2fYKQ
 ZT5n2fLYe2XDvtbJRfpddUpD1iqqPKsCPqR5BTszl6zAOvFxp2wJphqaGCw7ROmsE5Bm
 HabTZ5AgZu1bMud3bCOAO9xSPsu1qmzw6IgIw9kggCzpdFWr0kHKxsF9gJHSk2CtNBzr
 LGMqM64n3roWnILDovI1O8InzzDSsOXStjqqxrb88s5WiK7Y2KxhOu6dqp+kPXCZUFJF
 e/pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIkqNNjd5YR4VQjOhN3fBdR0qTn82tUmjCJ9G4YoqL7/KWmfMX++97SF8m7yRBgqWLXZlWuLJilzo1@nongnu.org
X-Gm-Message-State: AOJu0YxbB0xqfqg8iJjYuQUY9sKSPIfw5BKHUjl1JW4oMdBJBT4NV8Qc
 KBrVIEE+sd44FEZl2eZmGeEBFiphXR2R4Z3cL6G4zyQI4pO2rDf5dXDKa+WgortaNpP/U4q8fe7
 M8qCVbgeeeavi2r0rxlR93aRcZnvUntqcZ2hcfw==
X-Gm-Gg: ASbGncuOIRW+reX2AsfuQROqM4zI4rgxe6sk7wXu3lP6egAP7/m3pTrocQ9CuLz6J5L
 wHpMtHrU8ZrDXWavC6/AfFlDvLiXN9pUJaxqEkivdEh84Fgx+BL7SpMaj/nca5hBJIMTrNx90FQ
 ==
X-Google-Smtp-Source: AGHT+IHMZbMJ6xpMJ2zfhGCPHrOq021Q7cnx4HS5G1hwDJEjspC8jlK6PPekHZaRlIj7WfbZ9tMdpxEpm+mdsBhyIE0=
X-Received: by 2002:a05:6902:220f:b0:e58:3565:8ad0 with SMTP id
 3f1490d57ef6-e58a4bc462cmr20195546276.46.1738683763604; Tue, 04 Feb 2025
 07:42:43 -0800 (PST)
MIME-Version: 1.0
References: <20241226082800.2887689-1-wuhaotsh@google.com>
 <20241226082800.2887689-5-wuhaotsh@google.com>
In-Reply-To: <20241226082800.2887689-5-wuhaotsh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 15:42:32 +0000
X-Gm-Features: AWEUYZnJtlKhxZoNMXLeiS0vTX6mNhAO4q7nYO3RAE74kMk4Ycl8zp4rVWwFPLo
Message-ID: <CAFEAcA92L87bnPaTAXnzEy_pGHoFRkVve6-knTsLYb8PARAz6Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/17] hw/ssi: Make flash size a property in NPCM7XX FIU
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, mimik-dev@google.com, 
 hskinnemoen@google.com, venture@google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Thu, 26 Dec 2024 at 08:28, Hao Wu <wuhaotsh@google.com> wrote:
>
> This allows different FIUs to have different flash sizes, useful
> in NPCM8XX which has multiple different sized FIU modules.
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>  hw/arm/npcm7xx.c             |  6 ++++++
>  hw/ssi/npcm7xx_fiu.c         | 11 +++++++----
>  include/hw/ssi/npcm7xx_fiu.h |  1 +
>  3 files changed, 14 insertions(+), 4 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

