Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042E1C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 13:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVtx4-0002e7-Du; Fri, 02 Feb 2024 08:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVtx0-0002VI-H5
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 08:51:26 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVtwz-0004rS-1O
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 08:51:26 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55a035669d5so3090847a12.2
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 05:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706881883; x=1707486683; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gbtRmvNq3shEGyYoYnnp/hVL/MwE8wg+HWsl74QhMu0=;
 b=tzbiN3fi3VoaHReOJmJKGxQVVunQspFFWK2H2Z9eqwSEsWjHu9QF815LTic8+I/fuM
 Tca7vShHAJOsNvjynRMQcIESoiN7UpazZgcDy+7ncSLXkIVBqMno48xa76lZO0Lqy9yj
 A0bEf3PeAiGJ7yv45B5Fp2rXSW32km50TXo0i1gyFXlajrpc1SQfGIrl97T6FoG3JV3o
 MQSArXbXzGF2W4yiWWwLKW5p7IiYWGEI4tKRHwZ6xvULz2lKr4JYFw+crPKHrvKhPW+T
 3+XKdqULcJ2O+GQTYxmYixknjOoJ7CsIeNIXsr88aF+/WiH4VLL4n22zppSPi5H6dOlX
 PArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706881883; x=1707486683;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gbtRmvNq3shEGyYoYnnp/hVL/MwE8wg+HWsl74QhMu0=;
 b=rUldgv05gg5FGfipQb0Xp+CNYNuQpX7a4JVtBYZcjty7fTcWz5UjNQV55NQ44xKzrZ
 c+xlOKfmoOKO09NqDW4deeAsgALB6I5y7ehXPyyC8qpOoubFfyLAGkpqU9qjxBJXfeoc
 Jy/pHp+GrDDmCUK3vgyWcpHJtjMs7I2p1pwNtGZWUoSbnv13c6suSHttT7RYVpXAEgjA
 fD07lfttUqhNuUQNbTNu18HhJss6Md007mNbiLHpvV70RwiVoWl5Kv2UFFGRhheFVGZk
 JOKu/tfwywMTI1mzejOBAFAkHYjOYNV3Qoza8Phu8/SuXx4YpvWl3PXmeYVbTBoeLeGz
 SeFA==
X-Gm-Message-State: AOJu0Yw7j1B5UT0QBPNtBQDoF8OD3SHrqD/CFPFCDo0oRMv6KS8YzNlM
 /TMZd1oJsC/1gJL8wAksb9r7nQ7Oi5ZbxVjBYdvz3NY4/lgvEanFH0+vQE9OnHYfMUo5wyaXfiA
 NPbo2faSkx8dWs80uWeJh8LXLHLdZHytFtWeZkQ==
X-Google-Smtp-Source: AGHT+IGZ6NBcWhnHyc8f9chhazbkb9eGz3krZR1sRf2b6vMrIf7tBWIbxHPjiC1kOaqUifIulk5iuFr17hTuTq0SJ/4=
X-Received: by 2002:aa7:d505:0:b0:55f:2be4:61d with SMTP id
 y5-20020aa7d505000000b0055f2be4061dmr1333180edq.14.1706881883309; Fri, 02 Feb
 2024 05:51:23 -0800 (PST)
MIME-Version: 1.0
References: <20240129221807.2983148-1-rayhan.faizel@gmail.com>
In-Reply-To: <20240129221807.2983148-1-rayhan.faizel@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Feb 2024 13:51:12 +0000
Message-ID: <CAFEAcA_=2LoYGsNKMWnKu--suyK3n2jP+UvA4pU-R8vVc9Ag4g@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add BCM2835-SPI0 to BCM2835
To: Rayhan Faizel <rayhan.faizel@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, alistair@alistair23.me, 
 pbonzini@redhat.com, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 29 Jan 2024 at 22:19, Rayhan Faizel <rayhan.faizel@gmail.com> wrote:
>
> This patch series implements the SPI controller for BCM2835 boards.


Applied to target-arm.next, thanks.

-- PMM

