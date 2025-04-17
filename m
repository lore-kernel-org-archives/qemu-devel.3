Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE35C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Lef-0003KY-IL; Thu, 17 Apr 2025 05:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5Lea-0003Jp-B3; Thu, 17 Apr 2025 05:35:28 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5LeX-0006iK-N1; Thu, 17 Apr 2025 05:35:27 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b041afe0ee1so490275a12.1; 
 Thu, 17 Apr 2025 02:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744882523; x=1745487323; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xO5EtXdo5R5SORB6VhGJS2vroOZK0eGIlzXzvwsNqpU=;
 b=gKR6adsF2LvVei7PuZoUha0/mzanikF6WLz3pzdNIgzjwNdPCuhTCn8OxT437tj/PC
 ThldzqkrqwIYYuOVqv3Fk4egcFIWoffsyf5WqA7YxjBfwZbCjecVlbRkCLY/M6X4wlGR
 LQ2M0yDUCGtMQRMbC3rWdFefXpMUiL2lPr//RSR5VP/cLHxr6Ldf/1sdy/M076HM7uq3
 NY0TtP9EyCA4Nk1UwcJlqsPt0Wr8V/03P8qpQlr53/yHjJd6fmEJzphUcmViYfJL/GKs
 i2IrLXTVQAYPpTotxjWshOmQln+xscaJ/sQAFDrOIChlxha7mPOXzZRSjlDFIBey4U+s
 puoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744882523; x=1745487323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xO5EtXdo5R5SORB6VhGJS2vroOZK0eGIlzXzvwsNqpU=;
 b=FxFQzoxPPSrWtw0p9U7BxHeCZgzdkf+nK0mYsp5CovlrXsy13LtcB5UY4aVF1n252c
 tm/tHk+RcDeScmhJwNOG1vXxWYW8wuY+M5UL1Rg1UlJuc4fQNYd3vL+MktaORg+y0o7N
 4YefCiEQYK2b04O9wcoO7IXYwkHwvMpnv8PffHuV3oa4oMH89nrlo0Ng1U9U4w4eeuiQ
 DHw6k1BBjVjqMiSKbm8NVmyTJchZDYNpeJoABvfIyZJBCVsJFDyCozrJWWIh4XEs5c5z
 47hLHOtk+fW0rx/EWpc3XR94QLuCA1roso8Y3n/P9yV2RO3iAvbxpARQ0tK+yR7A7HPf
 t8FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN+UFJRCqod0LGtw3WhpOYk+Ax2ymBk2FJChVXqmeOk9q4VHZpb4q/5g98/KyAz80C3uChTYAgawc=@nongnu.org,
 AJvYcCWXDFBiDz8EvjHaJCuFZfwbsSrlkOuuZveNzbEWEgqXDr95TNCmVDigNarU4wXbZFhfVdVIFcVyJ6PNUw==@nongnu.org,
 AJvYcCWsQMV1P5m+u78xbCGypUZojVEOLp364qe4P/7Wj0zb6X3GIA0VbQ/1pM2g/AICCTio58ZVSG47Nw==@nongnu.org,
 AJvYcCXIocQOnd/CDtTU0lxJAezou/cxHkAqWPOxzEXULi74PTwyOoq+7jZxl7an4DMN+IDh1KsDduqKAOm/Pw==@nongnu.org,
 AJvYcCXdecSW7Si2ArriDi6l/ntVkcvxl5RVVnUPM82HPw60UEXhppLA/2K8d9X5UfP9DQelGW1RG4YLfXjuqA==@nongnu.org
X-Gm-Message-State: AOJu0YxlKvMRDfuTUq17k2QPdBK5VdiHa1RRFHJi3XPZClpqQgiN2o22
 rpupP3OiuvE5sFMncargUwVpAzu8vNVfkQN85ec1B1bsBDnblVW0QOqOiimJZzeQv4owdbKly+U
 CoUJm9sqif5cqA3Gs1qwjN1WvOdA=
X-Gm-Gg: ASbGncuRmMo0376yWsJ1GXuRGiLoMnmr6f7vVZytvMpVQ1MHJdfBdzPTCZSjvEhnM9H
 Zr/45Vj3R/geLOA0I6yaWXqW/qMhaP1a2Q2nfJmAFXi6tF3pM004PNS0pVF7L53K9m1os8NRbKG
 P052W8W3ZYJ+J9mkqJwul6lZUcJGStgKAWkYcyBRqKRMqgyrtMsx26
X-Google-Smtp-Source: AGHT+IEVLXnHZPcnnQ0+XGzkds0VJ6GfOiqMQh1ZBRq3Q9zGrdJIlmfDtyJzayKxEXYlV17znANc3AGZNGGP1of6Ik8=
X-Received: by 2002:a17:90a:dfc5:b0:2fe:8c22:48b0 with SMTP id
 98e67ed59e1d1-30863f2e193mr8333339a91.15.1744882523014; Thu, 17 Apr 2025
 02:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <7ef485c860a0c26d2ddcf6a96430f5443deb5aee.1744787186.git.ktokunaga.mail@gmail.com>
 <a92737eb-786d-4ebc-87df-a5518417195c@linaro.org>
In-Reply-To: <a92737eb-786d-4ebc-87df-a5518417195c@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Thu, 17 Apr 2025 18:35:11 +0900
X-Gm-Features: ATxdqUGQDeC-L_eWjOnDqk1i2h_NYl6uI6kQaJuEdutsEAhD4spiaw4v131Labg
Message-ID: <CAEDrbUaZYYxvW_D8ZS=qxOai06PiQQnN4mO2fjupPkwiNqqQjA@mail.gmail.com>
Subject: Re: [PATCH 15/19] util/mmap-alloc: Add qemu_ram_mmap implementation
 for emscripten
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 Vikram Garhwal <vikram.garhwal@bytedance.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f58c390632f61e38"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52c.google.com
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

--000000000000f58c390632f61e38
Content-Type: text/plain; charset="UTF-8"

Hi Philippe,

> Can we keep this code generic? I.e. with something in the lines
> of (only build-tested):

Thank you for the suggestion. I'll try this approach.

--000000000000f58c390632f61e38
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr">Hi Philippe,<br><br>&gt; Can we keep this code generic? I.e. with something in the lines<br>&gt; of (only build-tested):<br><br>Thank you for the suggestion. I&#39;ll try this approach.</div><br></div>

--000000000000f58c390632f61e38--

