Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC35CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 12:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9k0n-0006s6-Qj; Fri, 17 Oct 2025 08:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9k0l-0006rG-2d
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:56:47 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9k0e-0002Ig-CR
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 08:56:46 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-63bbf5f77daso1993214d50.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 05:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760705791; x=1761310591; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QLuuFgUrjqZj2YufUaU5wjLVsYpYDQu0Ovw21kGZ/gA=;
 b=RT28SeWT95TaaSeTMsZgCN62L7++TcCWuu4u1ejeuMJBbMF60tkRon/Yk09Ts3FFjT
 QG72QvI2SV3dBsan98udIZ4Fm7CUJu/e47O2ET1VMWshTU4Y+56elQLJQGS5Zs8ALDjT
 GJdQSursYxgF3LztcF19vP/M8JULe6I1cxEeOr5jmigi7DoOuNielagtUz1WDmFCAx7s
 pHUc16SaGIwnOfT8Hb/QU4eSAw8UYWHhhRzONzznQPDXgz0viWYJnUOOvVl2iNXJnrea
 YuftIsjsGFt22K6GuIY8bxvQ5nOGPv9qS8ueDs0MYxWoktYZuaI/huHzm6WnwC/loSd1
 07Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760705791; x=1761310591;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QLuuFgUrjqZj2YufUaU5wjLVsYpYDQu0Ovw21kGZ/gA=;
 b=imHb2M+hX0WmOjh7dM5gl7Gg5n6dAZq2JCYRdQAD7IrkURXYngcFd7HzWRPMAsH6gq
 yu8oOk+gVJkeRpW3oWS5xZWl+LMspsEE9fmmEscgijTyrlPkcW3eOEiQsU1LNQfZBH2+
 WHDja+NMPz1okaJJ52LgYlAyOX59hRSR6v7F5SixO9E2eUjFK8ByplDiTt1A4u70RW3n
 /CcKf9Vq6q7k1VmFvO4x/I7UrkS+JZjNnHCbQSKEo7pWznjxKIh0DB7ryGjvzvhAlXnE
 ShJ5BkSfl8x6g/6WUhCkNlM5kkzk+DtajmMlRuQG5ROlclrgfdMivUZZSIA1e40X8fDg
 Jg6A==
X-Gm-Message-State: AOJu0Yz1rcSO8RUN5LO3mm/3HpdXL8OFmG9zIDZAJM3joJo2toUPIW/l
 C5pp4yspy/yyHuNPAwIFyT2+wanCfSzzBsE3ohGZhct00VSlK/5ptp5uAnH/w0PfKeU4R7NbkLn
 YD4oQGSpp5B89RZjF912o+q+KhaE2nqq+94POb2EAL69rYeqm/jRq
X-Gm-Gg: ASbGnctAz2ZrrZMXKlm7xJLwedYaS/Yaqxut8jKGNoJ+mqHKxbAf4cs9vcnxjl4kTBK
 sAzVLAdYM9tuNlrPokk6a86gvVn33vZj2yDozCvVUCVKTocXy0P58I0OoFgoXEl60QhgKPStM2F
 RHyevKUI+adAXCRwGW7VniJNQlDxuwXGgopy+ksPlYBLQbVR7UlFafG0furGcrDrruURVegUFaB
 lpNHhGJwi7vnkHFAsqd7nGj79NxYpvDQFfMAFRm3sXZ/+tXH2gg2FHaq4uchA==
X-Google-Smtp-Source: AGHT+IE9c/cZ04N3GOH5OQ0+lqzHP3g0cuARud+eax0q1YlenyDKeFkC/QyUDZTPYXqh1tKMfdXBjWYkyj2ro9s51Vk=
X-Received: by 2002:a05:690e:144e:b0:63e:1d91:f54d with SMTP id
 956f58d0204a3-63e1d91f657mr1109187d50.35.1760705791504; Fri, 17 Oct 2025
 05:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-4-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Oct 2025 13:56:19 +0100
X-Gm-Features: AS18NWC-BZ-1hewTA9aSgu9NLBslImHJPa-tueAwAWeAzEeKJu5nklPDyi_sUnQ
Message-ID: <CAFEAcA-a3ux0gfOvN9Rq3B-5w12TMeBO7rrvSwFb9pm-XHx3iA@mail.gmail.com>
Subject: Re: [PATCH v2 03/37] target/arm: Update ARMCPRegInfo for 128-bit
 sysregs
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 14 Oct 2025 at 21:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Add ARM_CP_128BIT for type and functions describing 128-bit access.
>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

