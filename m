Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E08C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 16:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrgqD-0006EB-Cu; Tue, 02 Apr 2024 12:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrgqB-0006BP-Ex
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 12:18:27 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrgq9-0001Ab-Bk
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 12:18:27 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56c404da0ebso7795912a12.0
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 09:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712074704; x=1712679504; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jjf1Luvdff/hXyCBhND4zPlm17RoRT+L4gZCFbR1dCg=;
 b=WZPBCkjEiuUH3VA6152zF7gWEhzCFds3WWV1U27o5dqXybyWQVTkpF/JAMhESVSRi/
 PsoGzPneF0R3LrC/EuYu5PwXaDkeHacR6sZcElRP8YsT5KjKReGsZalwPi5gpG2CDv/a
 Ng3gKEENc7Fp9eMlguAy0EojRDOvd744ASNGF6UDLAZvKdRRrCLltQZwdRzFOUpsFMue
 Pkd6kcuj7N4r7Lv893JHqZG8pCcPhQqI/AWI+G3RJ2MVF0V8UW1A2w66/0XFGdTDkrZS
 it8SdMg1H5gii+JUpfpx06SDJKphAtYVUVLuEKaY47ls8uzjjUjv2jz6xGfcTZn7TVDU
 l89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712074704; x=1712679504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jjf1Luvdff/hXyCBhND4zPlm17RoRT+L4gZCFbR1dCg=;
 b=WyUMbJcNClyK3XANIkh8jLsoZgOMSxcxHIZaD6G5ZJUE/AEthh/dyjicPZY0n66knO
 JeMjylZBCLp/Eeh8n5Gc+zBL6hxC/ll1khKTyiGj9UoQqqogZePpDF/E7d8fM5V2Axcc
 Idcq7s4tRaGMra4LD7DrlYNAEIj+P/jSs8nQuvK59Vy1F4fNY36SSFksxm0tF3ilETbF
 7G/6+ABXUwjiDSCvNjb6JIKwU7MDoM0UPfsq0fq2W5+7SBpLugHWKC4sKoEIVXI0OzBQ
 K8kCq1G/A4wb5NY2DfkX8iJbQA9XkUKPClQhlY/60kxH7Tgwiuya86zmLeDSguxdssLJ
 64dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJhD5pUK8z0sxOmk8O91BvmRelSRiD1zt+l8qVofP2a1Gx1U5PkpRU/hQHnPqcDrMD/kUYsXf1xOhIf7aQU29R/KxGKok=
X-Gm-Message-State: AOJu0YxEydnxaRqcYYIqAOdvl9s6dpLcaYrSpvDJKQfNuUkJTCFMcri7
 W9ZWsI1Evr+8lFmWWq+o1m7S8eBpqzCDSsLlRJODhLWrS7xzkYjrA1t8E9hYHfqre0Yf5983Pb1
 tvmQYsFfce52QRY4pg2qrJ0OZO+Iqr+Bre/7eBQ==
X-Google-Smtp-Source: AGHT+IGAFbDsPqzc3cCWFMk45INngp1wpZToIxGK5vkeqHhR0r4R9h6yEoQlz7loU8T7KBuWO/ZJZu+V1TvSz8xYlaI=
X-Received: by 2002:a50:9ec5:0:b0:56d:eeb0:cfde with SMTP id
 a63-20020a509ec5000000b0056deeb0cfdemr1340083edf.25.1712074703865; Tue, 02
 Apr 2024 09:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240330103128.3185962-1-ruanjinjie@huawei.com>
 <20240330103128.3185962-23-ruanjinjie@huawei.com>
In-Reply-To: <20240330103128.3185962-23-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2024 17:18:13 +0100
Message-ID: <CAFEAcA92Vsxot7kgVK5VDZ-H6di11LUOZJoX8kfG6-kRONgV2w@mail.gmail.com>
Subject: Re: [PATCH v11 22/23] target/arm: Add FEAT_NMI to max
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Sat, 30 Mar 2024 at 10:34, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Enable FEAT_NMI on the 'max' CPU.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

