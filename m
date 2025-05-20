Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45701C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHP8X-0006EW-Fz; Tue, 20 May 2025 11:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uHP8R-0006Cg-G8
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:44:08 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uHP8P-0001eK-Hd
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:44:07 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-70ccf9a4ab3so26060407b3.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747755843; x=1748360643; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hXwSPoCdFrnNBCDyn+um0sb/j3x3yb9Ru7xa/EvHcPI=;
 b=rpwkrcI5sMomTEBFUkSijqLHzu1F2qb3YGQMZUQ68b04fXciXeiKx18RqnJGAIrFNe
 YXSM3W364QfhzoeL4Ld753+TeuR14MSoHaBKixHZfYemtOYNklnCdQlwGo/33xyuMpOO
 X6mnwegzn2MgGIGW9Rq3pznJ5PEe6wxNDkfk3/LOYZyD9KcrXkGTmMXptdZYZb+t15ka
 MpNuRNlxyerwIYwmFIFjKSk+ILr3588+suLRt2u+U65nNoRCcw71o4vWbwK5BsaaUtYX
 XZw9B6XTf8BvBEatFd2uSiC88dTWkhSmgmbAwhhCjqxi2loeI6W2XZ9zUzFsgYjXCP7m
 6mOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747755843; x=1748360643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hXwSPoCdFrnNBCDyn+um0sb/j3x3yb9Ru7xa/EvHcPI=;
 b=nyfdTIN9/0+eoV0W72pitK6aECuMETPLI/D1GyAW2SBU8hRvEvUkLiBFHVrvIGhaJj
 l448FhdUbT5e475LazyYdaKK0Er9A+zVX6d3KZXb2bMlwghPuQivNwpg5Sm4JTCZU0hn
 UeKoQehAWybCicBTKpi6Hx/4fNxQDyzTXkJBhDctGxL7SHVfHisdDXtqaeHR/0/U/Ab0
 Zt+D36tdAF5xI6F96y+IKSBEsvdWsR1Z+tcy//aks+7FAicdgpmeGSp+z5bRS5QLT2KX
 FC2oqGLQLiIYs6o6mtm3lJxdLNf6Z/nKfNAnWBbxgLQnGOjgwv56KqIIt+b3uNy4DT8y
 1pAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ+rD5gTacZTyhqqGjSb+71r3AEum/0EKRrOmug8sJ/6R0U8rKqGhtUUO+jmR+UJZnMOLSqFgpBbG0@nongnu.org
X-Gm-Message-State: AOJu0YyO5f3IidB+o7c1RCX+evJTXnyknWKwiQiARgKlov5VKotb9TRK
 3iPGRvBL7T+P3x3zhd4RYLnjmWi8jBe1OGCIPBF4l5UFgMnVuHyyhqY3AOxX1BEtV9wOVCNeaD3
 +D+w1Mfur7I6Ugah8B0PlekpV4rIMTu0EjhrmC1XoCQ==
X-Gm-Gg: ASbGnctyvohKMyrYd6CMUlnnx9H1wzcGdir4sAc2w/Zmp878+G6YpsU1eI+dYbOhm5f
 qxOh8cpVmCrWNLstzg/ts+gZqk//pLUjzL0q0EDxw4/WIreOgkAZES5sR6sk5ekEqxIpYxZrN0T
 fiM8ITkJrv16WeRu0LVfOkEPGcnvpLs0nlO7M=
X-Google-Smtp-Source: AGHT+IH8iXeHhxnU+LzfBR2w0LfTMMP90X3xaqltyJQODtAdJk4d5ZhkRMAeS/fzUPJR1B87FL8u38McHc7iUoPqpns=
X-Received: by 2002:a05:690c:45c9:b0:6fd:a226:fb50 with SMTP id
 00721157ae682-70caaf72640mr245214227b3.13.1747755842932; Tue, 20 May 2025
 08:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250520152750.2542612-1-zhao1.liu@intel.com>
 <20250520152750.2542612-6-zhao1.liu@intel.com>
In-Reply-To: <20250520152750.2542612-6-zhao1.liu@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 May 2025 16:43:51 +0100
X-Gm-Features: AX0GCFsJ4swdr42Zpi6bNUDrfV6Dq-syz0rQiXAdQilDXhWsYEb2w2f0G04S2Vw
Message-ID: <CAFEAcA_48ZgY-aAcObASGc5VOzDDTRJcWaWLb9H2gB_tMQvZGw@mail.gmail.com>
Subject: Re: [PATCH 5/5] rust: Fix the typos in doc
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Tue, 20 May 2025 at 16:07, Zhao Liu <zhao1.liu@intel.com> wrote:
>
> These typos are found by "cargo spellcheck". Though it outputs a lot of
> noise and false positives, there still are some real typos.
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Note: But I have to admit, cargo spellcheck isn't a great tool.
>
> Picked from <20250218092108.3347963-1-zhao1.liu@intel.com> with checking
> again.
> ---
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

