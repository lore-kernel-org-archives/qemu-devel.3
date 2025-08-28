Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FABCA0FF7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIh-00089d-Um; Thu, 28 Aug 2025 13:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ure0v-0006ZI-JM
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:54:09 -0400
Received: from [2607:f8b0:4864:20::b130] (helo=mail-yx1-xb130.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ure0q-0002ZA-1F
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:54:07 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-5f34874a934so575683d50.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756392842; x=1756997642; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pmba8F8rxESxBvImcr9ijWw2z0IRbCvTWGyPNXhZDN8=;
 b=x/mVIcMZ/2r0wkdCrQebcvLDVCMAZm250z1YkcPBppwLF/5lxDTKQ38wIgWsIVdnUp
 BBigwi1Pt2yOmTE470Z+vncrQU6FiMcrPuU/6Zzq0gZX+deF07a8AuyHk/9pvQY4Wqm/
 t0syp4w4Qh7fC9lM9ZNZd56oR7wkpwI/uQTcJ6dR9ib08Km6W9g4lIu0i+YbtLCPt6tW
 g5DbofoMUc+Qybrxy8xlqvazy2khEsMjrYOn9jMgztoQ6wggfcv36ySDQdUqJNSDUHR8
 blldLeHqbMre94sBZ62g12md4o+APGXc9DTcdNDXlfVMD36jlA0j9Y4z80HRGVqVdKi+
 1pZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392842; x=1756997642;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pmba8F8rxESxBvImcr9ijWw2z0IRbCvTWGyPNXhZDN8=;
 b=X/RqXzGVAzl5ETFdup1c0QLCQwSwhAGztK6Q055Q8BQN64HC0+gUtI9NTHwgBY84n+
 SjAeeyiXH/1rGG4U5OqD2MrD+yRvCpnLQhFLIqwbILqOpHJ3+JwH7J1PYs6+ZqF28dty
 pwX/JhOpEearyNaAIWOqnWYj6g6H04L4rW20f6tPZLu5GtgQHF0rEWrrLIWX+dQl+olX
 7NTAVlDSpman3VrATWOnVqIZRa1pKPjhkxGuy9yilobUqEmwp53/cXq6nL/OkhSEJuR9
 8rY23qQdyyS8DjEr4HUhzcLGEhCZLp+NZV3C11kzcnAnY0NtcYJwqUMrBC1UGxYvJHRp
 urRw==
X-Gm-Message-State: AOJu0Ywv3HuQsVJd5w8u6B9KYDDed8VyN1YBsINSOEz92Kf5ISERknTf
 S+jmw14AA0SBctdLB1mUdYD1/pgSRGkytgNLSGxjxAk368T/b99x9vI5ZC5nwqPSuuKA+gWrKhU
 52uAcAEnwRnP+cPeBd0b7t3Dc4CmC1GlwaUP3q6tn+aLw0yywIeS3
X-Gm-Gg: ASbGnct6pvo9jOPlEcNuA98+K6fXZT1c7EAAjRQ4Fxbh8uTHHsXVAKhvMxo8emNSYAi
 FKHeE1VZt3e23RSOvsd5f3bK8xmInT+hvq69VUzNfl2cItiG7mXxjcwlhW2phO+s0CKQvEEwuyR
 qZSyCzd8JncuVIDwqBf5ncLCP0s9qFWZo+plCROPBTm2dEp5AkH7gZce69F8wDd0xngooV90/Aj
 2S7N+4be7kuC/7ijZU=
X-Google-Smtp-Source: AGHT+IH9//1htf69zZ7VK1J7uks+n51rLa2azcjqzIyrqdzqHXcg8aaieGhagnMhjnNZJ+a96Gp3bGt5IuaQDMus5G0=
X-Received: by 2002:a05:690c:60c9:b0:721:1105:e867 with SMTP id
 00721157ae682-72111061568mr140345727b3.8.1756392841763; Thu, 28 Aug 2025
 07:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-43-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-43-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:53:48 +0100
X-Gm-Features: Ac12FXxSIHwFlTkQY7dAy_2NhBIdnjhjg-Bie_arJLPiiLq24mmnzJ9YRtiESmA
Message-ID: <CAFEAcA8jeQMDcZKVuOOxpXX5gBUCqZA41EyzTO04X=A3yDQYCw@mail.gmail.com>
Subject: Re: [PATCH v3 42/87] linux-user/microblaze: Create target_ptrace.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2607:f8b0:4864:20::b130
 (failed)
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 28 Aug 2025 at 13:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move the target_pt_regs structure from target_syscall.h.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

