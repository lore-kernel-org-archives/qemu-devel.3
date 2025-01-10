Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4160EE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWE93-00030B-4P; Fri, 10 Jan 2025 07:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWE90-0002zS-I2
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:29:42 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWE8y-0005yN-Jp
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:29:41 -0500
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e3a26de697fso3058291276.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 04:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736512171; x=1737116971; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AivpEUPvu4XqN7QhBIWcNtaeHxL3gUSC8LCMUCmgVnI=;
 b=L9AkLjPM1JWZbpkytwn2XvDCa5yUj4uKK5S1T0PIr2hUg4GANnJGWz/7azJktTCUqd
 AXrM76OP6zCNLAXRvFt3qN9otvULmsW+zFl4wfPCImDf4nXjXLljIKrNexMfzre7HLSG
 iGoyeeopAhLn2qJr57UHTJ7JgF4OLdwMHD8zBFmIOX4//bk6MH+FerZwoqCTyNj7cXQX
 xWJ6K1eN06afBT3Lup+0elLHhmPzZZRjqwTt/LjVJqmLyhEb7nV/ruBo92QM7DHxLpO/
 Oiri91Ef6Lp+F9kphbmINLvAizv296fpLbSm7NZBVfr5u7OO7mj7idnDfx/i9YMcb6UK
 bs5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736512171; x=1737116971;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AivpEUPvu4XqN7QhBIWcNtaeHxL3gUSC8LCMUCmgVnI=;
 b=Ojf7DmnFOb9rkUtFUzFtzzL2yp43cv7qyiSqq6/FrEX4YThs5eeKfDmRFa7/y/QTfY
 DqUtKNMiAggIGYO5dJxCD1uILJkBdPIT8wM+GDoKX7qKcBLQ8rJfIbAKYPk+apzFGH2g
 Yo8iq30s/hcBUSlF0SlHtoSEZu7U4LYUw+JI1uHyUPYxFcjDF5vyzQIq5Z5b0uw2HTVw
 mtI7nGJsX2SjcUpStQVkjB4plMjgzK+mzvxutmm5uczsYdTRNuyS78rgDdOIqDEPK6QH
 S5Stgv/l+B5s3442Ee9S4D52+lydE6gK2jueRAN+JWSE1KeMi29oTvBXaNzBXPpul1Mt
 zVlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrsOZuMN0kNIppa8LwLsI5m5/+M4kL0XtrJlecdCPipv8rDQZ4VkmKLiH6m1LVHrOWEQwIzd0YG4NN@nongnu.org
X-Gm-Message-State: AOJu0YwI4RXSbMUXiw4lGV4hg693gLYQ6HJSNTz9uw+PHpuS3PhfUDNQ
 nhiuH9IuntllMOk223NINWJKB/BKU0G3JM0hgtzIEWYD2UWIud68xUlu1xDoK4bG37ozEnZqWhy
 gW4tOHM3fPlTUEv4PidJilbtRQ05QOfDhcqAb+1CxoU5SiFsp
X-Gm-Gg: ASbGnctLOpYy0XJGufx7z7kADg7HyjW3zq40kR9Ov8meDSAyU9WdeHGCIBU7OLeMu8f
 BPF0uSrneGqx9VXvK+TkAf8e+xsSL43O2K6oW2EQ=
X-Google-Smtp-Source: AGHT+IEiSUP4Hl1zPhHq7wKDCBUC+RlIXG9coPy1BYQV6BcS2qyRMie+wovcT1a4uhD1biHMkxJFwWlXmzWWAbCNgqA=
X-Received: by 2002:a05:690c:9a87:b0:6ef:6cdd:57e3 with SMTP id
 00721157ae682-6f5311e6427mr83278947b3.8.1736512171210; Fri, 10 Jan 2025
 04:29:31 -0800 (PST)
MIME-Version: 1.0
References: <20241220125429.7552-1-abelova@astralinux.ru>
In-Reply-To: <20241220125429.7552-1-abelova@astralinux.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2025 12:29:20 +0000
X-Gm-Features: AbW1kvZgF33SI4fc98M6C_juQrmP4eeQ6JMCd_7K9izf_NeRcL5hScNEydHCG3k
Message-ID: <CAFEAcA89TWtcjt4SQrzSsuESWs6ur6BaR8nTQdtAo1UoV51zSQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm_sysctl: fix extracting 31th bit of val
To: Anastasia Belova <abelova@astralinux.ru>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Fri, 20 Dec 2024 at 12:54, Anastasia Belova <abelova@astralinux.ru> wrote:
>
> 1 << 31 is casted to uint64_t while bitwise and with val.
> So this value may become 0xffffffff80000000 but only
> 31th "start" bit is required.

This can't happen, because the MemoryRegionOps uses the
default max access size of 4 bytes, and so the high bytes
of val will always be zero. But the extract API is clearer
anyway, so the change is worthwhile.


Applied to target-arm.next with a clarification to the
commit message that there's no guest-visible wrong
behaviour; thanks.

-- PMM

