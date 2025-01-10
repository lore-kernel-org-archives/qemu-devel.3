Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77881E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 15:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWGkK-00085K-1d; Fri, 10 Jan 2025 10:16:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWGkE-00084T-1r
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:16:18 -0500
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWGk9-0004FT-5I
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:16:17 -0500
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e4930eca0d4so3050413276.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 07:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736522172; x=1737126972; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xFW3AqiH2OxJtqsDqzybe4ztFotFLMTPVfavlCSFn5M=;
 b=R/l2lggL+rr3JDVSwafo85wT4eeId+bWxUQ//AzoNGEqvkb3UTFt1Fx4qFEwAENIHl
 XLbH9Swg7gPYeTnw/3GrvEfnkyqc/p4wjOlvoo4Wmcn8hoYjdC9ZaEVDtPotGLfX4grL
 hhsRVyp3RCjArF37doDyfuUwZwZPBVfJ/GIk6du+bGaxGivhTXUOQBe2RONmWeDOtO7m
 M/KxYuNwO7J52ntJPtLQ9WIqWOqcaWA6j5dCfWfOgwVxN+L83zBNF6Hsb0gU/ZXRcPki
 D1+3/Grkzku4GUbIoZ2/V02Mny0V/GchsjQcC3NsNfd8h7TZao8oMJucrt5/sFgZ88qq
 0syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736522172; x=1737126972;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xFW3AqiH2OxJtqsDqzybe4ztFotFLMTPVfavlCSFn5M=;
 b=bME7OBpZJc/DUssftN+TIF5IEoV3Q8CrwPFItGaNyppdba3726gE5FuByiHrLwfk7Z
 YU1PXnLFMPh9DEMjjdJ6N2xQdS8395EvQhTSTYk0F8QzAgnw6v7dYlnLcHs5591WxWGQ
 AWshfm6CjsBwuqj3a8Vt3yPLZFwdx35q/zEkGqon6sBBXW3hGr0FyAUaM1wzREYpTNas
 aQ6r/YES4yG36RVOuXUBj1rcF34462nDCg5tuy1lLCgQN/S7aygeUpbs34Fuyx8aPoZb
 sikSHk5BJQlvu8zXSOKv+epiuhFu4uFS8MdCN/ytZN7yaDZO8NoeRSd5l42+rKGEl72Y
 jS2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXZ38NLp418BGVLK0aLBwvoX1Z9Y6KAeLZ0jxHLnDf9nBkK3GGaJqFBqkgMiegcLoy69121PlFNcWx@nongnu.org
X-Gm-Message-State: AOJu0YyZnwLWO2Iq635ETH28fD0Hd9fhJzPuZHeSW53McSJzNt0iwy6y
 gIzC45RPkhTvwugXkOab+d8QIPdg+GXpD8hhVHQxTMW1BnFvwQPPC9zk5MvVMutjdDqL/yeslnP
 EJEkLPDeoFFlUNFmV+7J+YjPj6Lfvqmi0sU0g7A==
X-Gm-Gg: ASbGncuyqYOtJ/gF6aFeN43FCs8bKaSpycHF350wAIVKAOx8CKix9yRAf3RBESAhs2Z
 FjjurceZhpJ0QiUAHEWBARwEFpZtT9Db4dv8W7Go=
X-Google-Smtp-Source: AGHT+IEmI0C1gwvywrs+d0zU/ZnwCn+TVntLz1v7H/yT/PeN+4Q/jEpGM/0EEMBvLyP1rIZk2wEduo13j0jsmbAH5g8=
X-Received: by 2002:a05:690c:660c:b0:6ef:4fba:8153 with SMTP id
 00721157ae682-6f531248264mr92938397b3.10.1736522171805; Fri, 10 Jan 2025
 07:16:11 -0800 (PST)
MIME-Version: 1.0
References: <20241220195923.314208-1-git@zabka.it>
 <a9313931-a41e-46e1-b8b9-d2cc83cd663c@redhat.com>
 <44f99f89-edb6-4007-a367-f7f3b9e10b7b@zabka.it>
 <b36f85c4-4f1b-4721-bab5-56e89550f421@redhat.com>
 <f1d67bea-7389-40c3-a304-6cec459a2f49@zabka.it>
In-Reply-To: <f1d67bea-7389-40c3-a304-6cec459a2f49@zabka.it>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2025 15:16:00 +0000
X-Gm-Features: AbW1kvbVfRetUY5JcG1Kg7hVBuAYvV8MphVVrvVZAe-KddfkVgZj2YZr3rtVDgQ
Message-ID: <CAFEAcA-nMhLYZ2UHeKDwaRU3V=dPAY8ROKJSgkGCKnCVYDR=Lg@mail.gmail.com>
Subject: Re: [PATCH v2] physmem: allow cpu_memory_rw_debug to write to MMIO
 devices
To: Stefan Zabka <git@zabka.it>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Wed, 8 Jan 2025 at 18:36, Stefan Zabka <git@zabka.it> wrote:
>
> On 21/12/2024 15:55, David Hildenbrand wrote:
>  > Let's wait for opinions from others first.
>
> <https://www.qemu.org/docs/master/devel/submitting-a-patch.html#if-your-patch-seems-to-have-been-ignored>
> states that two weeks is a reasonable amount of time for follow-up.
>
> Should I also ping the original patch? I thought pinging the thread
> would be more appropriate, as it contains relevant information.

Two weeks is fine, but in this case the two weeks are across the
Christmas holidays, so it's likely that people might not have
got to things yet...

-- PMM

