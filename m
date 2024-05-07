Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31FFC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 15:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4N7c-0006Gs-0H; Tue, 07 May 2024 11:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4N7a-0006GU-AR
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:52:50 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4N7Y-00053I-Cd
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:52:50 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a59cf0bda27so261673966b.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 08:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715097166; x=1715701966; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eOCPxri9o5Qn3OAXWI10hYMRo0TIT5UXHdlgSRC1roc=;
 b=BcmRC135WVI4pEn0ypf6G6puxroXXFWrPOq8O4tg5R88kYsCrdxQS4YVTXWKKRlBpQ
 DDrANhlFor6QWty/UciztLSyVjkaTcgaI9f3R/2mheflOBgdgPZkmJHnMrc1PaT5Lxfi
 HFQcDhOC8XYBRduTaNyPGjSOq0B7Y9OpmEAUi9aug4AFQl1a6QNPuov2ELQ/Y7/rg58V
 hu8rVUm2fxP4m0rNpu6sKmWSMeGh7iNtla6SE5EBFRZjMrW4lgOEATMM1rLzZGGA6SN0
 dfUsj/JtYKImmjghk09WPEYOUDmwOjb+Pa07vOls3gaFT/LpCvP5vDikE2S7JYCzoHUv
 L0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715097166; x=1715701966;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eOCPxri9o5Qn3OAXWI10hYMRo0TIT5UXHdlgSRC1roc=;
 b=Cf8U2J9dtA2cxA/3HtW/JlJHwGgBBnfFhY2P2AKrMEli7SYHWz/vZJZLn5uXoeG+9+
 lHUUd33AGQ4Xjl6YyrhhwMo2yDhVp/Vp6TDBPcjRYULUsS/4iU1MqD1ItjRsaWHThHKx
 U6ielu+HfVhytMlZL5WOHDDih50RzUuzQ9rHrQgmoEM7A0AC+NTYS+F2xLvGrKnsCjM0
 lfBcIJ4w9Tk2JKgvwKbPuVBahqN6okWgdsOC3LCDPV1zI4Zu6j8Pc93eYTHUW1uZMxDz
 k7/nOnlYyeW/qViDmLAZQ0NtVszmrP8FNx+MHAN/qrmg9IMlgOE/UEAc0mZTt+WHwSU9
 ZQTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdvcv+65JnSFgGfZ3zN6x6QwL975OBa5W1mvJYI1ScEUJQR5TOnObfj6tzg7NVT5ycOBvdzUesmuQ0s1K+7ZQ7MPR+KKI=
X-Gm-Message-State: AOJu0YxHUsny1jf6fdLKDao67tnUbszPZJXvViKUBE4c7W9kYe8DE1WQ
 Ivcjx/9+KHGWLb9CEqgeZWR4corsfJoNkhDvA9yz+ueP+Xzd61qxSVS6mdWOuYqrirI2tx/XefK
 WLtfhOQPNn6qrEIcsYLGkQ4fdVtnlk40+jzsjEg==
X-Google-Smtp-Source: AGHT+IFBJX39cIlnYPsQukFwTK3P7V6gs+9v/lsogtrd8PcoiSJn1mNKpAXDp8VcG6RW/qbMYZS4uA+EmXpxC6sCHuc=
X-Received: by 2002:a50:8ac2:0:b0:572:5630:d8d6 with SMTP id
 4fb4d7f45d1cf-5731d9d1b7amr118318a12.22.1715097166068; Tue, 07 May 2024
 08:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240430012356.2620763-1-gaosong@loongson.cn>
 <f9956c18-3530-4fc2-8150-beba7b673f89@linaro.org>
 <87edanlzlz.fsf@suse.de> <ZjJjl2fIU1s24uFD@x1n> <87o79oo00b.fsf@suse.de>
 <c9bfd6a4-befb-c17d-a87d-15eeecdfb75a@loongson.cn> <ZjpM-1MImDyQKyHI@x1n>
In-Reply-To: <ZjpM-1MImDyQKyHI@x1n>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 May 2024 16:52:35 +0100
Message-ID: <CAFEAcA9vTfhakvVRTfRvtgxTxfADVARX5yHAKT6a1_QXAC4MgQ@mail.gmail.com>
Subject: Re: [PATCH] target/loongarch/kvm: Fix VM recovery from disk failures
To: Peter Xu <peterx@redhat.com>
Cc: gaosong <gaosong@loongson.cn>, Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Tianrui Zhao <zhaotianrui@loongson.cn>,
 pbonzini@redhat.com, 
 richard.henderson@linaro.org, maobibo@loongson.cn, lixianglai@loongso.cn
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
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

On Tue, 7 May 2024 at 16:47, Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, May 07, 2024 at 04:12:34PM +0800, gaosong wrote:
> > Just remove CONIFG_KVM  would be OK?
>
> You're the loongarch maintainer so I'd say your call. :)
>
> If you're not yet sure, IMHO we should go with the simplest, which is the
> original oneliner patch.

The original patch needs to also bump the version numbers when
it adds the new field.

Even when we do not wish to maintain migration compatibility,
bumping the version number means that users get a (more or less)
helpful error message if they try an unsupported cross-version
migration, rather than weird behaviour.

thanks
-- PMM

