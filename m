Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4D5C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 13:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPL47-0003w3-T2; Wed, 11 Jun 2025 09:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uPL43-0003ps-3f; Wed, 11 Jun 2025 09:00:23 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uPL40-0004jZ-UI; Wed, 11 Jun 2025 09:00:22 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4a442a3a2bfso116827791cf.1; 
 Wed, 11 Jun 2025 06:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749646816; x=1750251616; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jf6tMngBWOppBmsTO8G8rEDGlplT+20Nq8g2MEOpmr8=;
 b=eN1QJQ/yyjRIFvmM/FHP3vmzYveR7DAPBuGJjbt8DX5/TWjZMR4089RllUdvUx/6ZB
 2N0cqNzRMZaMuAHKSzOmv7++6MAdFWuXdD7WAbU6AJ0res8zTshp5iUG+hCVT4UqkAJO
 ZQlgA3g0yDkiNJ/EsVBU48l04Bi15BllIgLwvR0obofzId6rVVkahATZnDmOPUiiKQyQ
 vFFVwFY0JtOf6sphQy4AH+/JHzm/sBbCvNcAEWcDysZUrz3d5EZrsIdseOh0FkGAdHAj
 x7aJeVtDPn5Cc3E2q1vemEEzUdSAQtmVhH1PKzYMP/M+wUKE8ITOR3ICiueaFWY1X+2u
 Zs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749646816; x=1750251616;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jf6tMngBWOppBmsTO8G8rEDGlplT+20Nq8g2MEOpmr8=;
 b=j6cU0kTzJJOw4xtU44jsKpGFcSGvTBdrGjcjCgpugUMDWd6Bf3ZQHpCevGR5L+wclY
 ocXbY3Rfp40hIX5ZgzQmzOyXEubdoqHDbvKMS7wDxXvF8jVYB1y+XOyRtibfTcRSGDcy
 RagbbLM2GQE+nEnz7JdXUkQ0qFZazjqVVxAK7FAuHxLzAh3Ck9fQ3GijZXqgoC4aESr7
 +s14lTnNr4lvxvSaAUAipwGffGpI962KFqDCWS5CLBxL8H7BtUQsOPJHKYkOGpGyIypd
 IEM/mGJuAkcHikcH8dV3i1amkEXZiQPFlmZg6bEn7rZtKN5Ht0gkuux3MpEMQx3clxHH
 1S4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT/apyg6G6QjneXqC7v0+Etmhsw2A6ldL6VdasoAFOYRmuMtGKTK3G/CyxFBxGryBO1+6lTNPJM6Y=@nongnu.org,
 AJvYcCWWBg6/J6zik+p9lrA0Rb1jZ7EPy+PUS0CzB81DNP0ygBlSX6J7BzvsiQyAjTMZlgjo8smw6aKuq8FQ@nongnu.org
X-Gm-Message-State: AOJu0YwvdJh6Iu0+EkUFZLrgtSe92Ndzj/2ZPi7gGX8g5Ti/4UW6H6gT
 yIO7ex5RCmdOVf9ZA7g1uwvf3cX5oxI6YY6cG0WZoQZz9FVIJ/6ho79ze7Nu8ImCa1Ppmn1h6NT
 pLXHOfRxohaslLHcf4ib/j1abFiYUHqErWYjd
X-Gm-Gg: ASbGnctFs4upL2kZfhSrygdaUVc0AJBk3IjyBFRm0K/betEd6G6jxPId5GKCI1nbfBm
 Yf2uzPAmnhMV2oHoeJIuO8QxW7Gd0dR1aOY/dv9vL8coYhqSlrdcGwJ1mIO0JgZAhtPGQzCo/UH
 Jg1X6VIFOc5VmoRdfjTZQ53tX614ywofjJWe6NEGfTOT1PJSW2ILJV4pWmXLaR3DRSj0GufwaX
X-Google-Smtp-Source: AGHT+IE96SQjD9oe8y0u7PgyZyBxdkDpVSsTh9D4RFnMHMu8Wsnn5AYaraeRtn4FLkdN3v00F7llwvhngheUbjf/NCI=
X-Received: by 2002:a17:90b:54c3:b0:2ff:6167:e92d with SMTP id
 98e67ed59e1d1-313b200de9cmr3245116a91.32.1749646805176; Wed, 11 Jun 2025
 06:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250610204131.2862-1-shentey@gmail.com>
 <20250610204131.2862-4-shentey@gmail.com>
 <32a05613-7606-495b-8b2b-fb64b31885c4@redhat.com>
In-Reply-To: <32a05613-7606-495b-8b2b-fb64b31885c4@redhat.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Wed, 11 Jun 2025 21:59:53 +0900
X-Gm-Features: AX0GCFvEQQIsEJPjWiVPODjyYS17LYLxJkVINVAbwoiJEX4Er78g_COisy_PVDY
Message-ID: <CAEDrbUY2=bs9oFc=vF_ZZhScCpZqKn+iEmCNH0zfYuKnjLM6yQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] scripts/meson-buildoptions: Sort coroutine_backend
 choices lexicographically
To: Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004e162b06374b6406"
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000004e162b06374b6406
Content-Type: text/plain; charset="UTF-8"

I should've made sure to run the tool, sorry. Thanks for spotting and fixing
this issue.

Reviewed-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>

--0000000000004e162b06374b6406
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr">I should&#39;ve made sure to run the tool, sorry. Thanks for spotting and fixing<br>this issue.<br><br>Reviewed-by: Kohei Tokunaga &lt;<a href="mailto:ktokunaga.mail@gmail.com">ktokunaga.mail@gmail.com</a>&gt;</div></div>

--0000000000004e162b06374b6406--

