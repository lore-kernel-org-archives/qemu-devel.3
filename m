Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920BBC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 18:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgSkL-0000EC-BV; Fri, 07 Feb 2025 13:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgSkF-0000De-VD
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:06:29 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgSkC-0002MK-Ro
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:06:26 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21f48ab13d5so33743725ad.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 10:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738951583; x=1739556383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ztT8JPFAAyCY8lhC3q1Zv06uGofp2/BHzQwqQVdAdt8=;
 b=iuBgnapoDouAddAsnJuA7+Iqyi2KqYaG4emRZ+Ya526QhXImdsTxE9n66At9+Me/TZ
 j4Nu+FheNA38MsZKmI2c2Ocdmzf3yA4xk9nMFHHNrsrNCCDSwf5hWQQtkq1IX4aJw6kY
 PZFYofOfxmJs6UaovA1fphHO8Rm1VRwqQzcoHE0G4/5V5JlENudwReo5DqIaw4JwhTex
 7PT3aFwXQ+6AOAFJkbA2AYwoQWGwtKRxeHjEUSLe7gZgrgmV4YpFPy/IdQnp+EqiqbH2
 9BcVjz4YQz/vJE8Hkh4H0C2hZVlFzd1SitslLa+Y3KJQR3AEPk+uzO5qm4W056oIATyG
 Z6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738951583; x=1739556383;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ztT8JPFAAyCY8lhC3q1Zv06uGofp2/BHzQwqQVdAdt8=;
 b=tOOSNH/NutnhC7RpjW00qUDdXfp1cnjARtTecnYNilF3+mbvINdmpyhtr1CnmwgcOI
 dvBXlYWHB6Vy3Lv6uztw4iqfxplPJ+kRddjvMOZjBzCNqffwUawXfuhqHhqrN8nePFsn
 3NkV68f7h1Zdr2ltewfoPW0FQ/wShX7AyEIlG4aGjyjtJkkzYAhoGlKd6pGCPBV1tafQ
 YHsXDh3VxQdIeD4QL+ieVDX1WLGHK/z8A3vbFjzvh0yT6xri1u37b8W8b+WnT9nQ0FfX
 mABFv+OAeZx9Qf2RqPrz0gNIaRyj3pwRgb9ccVNTyKlZpLaEPjSnkSG8gdEbUz4RdYbH
 PNvw==
X-Gm-Message-State: AOJu0YykLwtuPFQDvg+gqPFY39yHnlvCcV63/Azj7UFvYv/Ai6Z8caGr
 9wPCf40GBKNrH93uD423iU/Zv8LQNxKy8N5FuA0p+zBTc9riYWhQyGfxxAbG2Bot7eq7ZJaiNe9
 t
X-Gm-Gg: ASbGncvps57CawNRbqhXw3M/iWp0tmy0KVwAPDwDqhtWC+c/HTdeojgkiEqTZm9/IOK
 utyToBfRsu/yDurshpXrxqpNKXhogmm7Jk2CM1PWQaiBgRFoBBSk/+SoXcS9yoh+ffZ1uTkk664
 MTsgzIOhRIuGH2W3duHs4Pd/eJCCN1LVBKDkNW9Ju8q/IJDcdrr2YkBNL0aTpXsFsoYkV7+SkBL
 p2y5PLWwKj+ipebbO8A/RbvkWHrlx/TShIlSq7mxRmJhV1PpOEBq87gCD1r2Pdtl2j059cY+CyE
 bnxw2Nl7JlfEw5276KRDrRxE3LptzGd4lkP8o4HA2Giv94K4XsOLi58=
X-Google-Smtp-Source: AGHT+IGgeRF9nH5yh80CZR+Bn/JEfGJRDFceT/+9pCIgMeLYUXZyCP6qWLX06ZbjPCxKzXwwo28mZA==
X-Received: by 2002:a17:903:983:b0:21f:134f:22ad with SMTP id
 d9443c01a7336-21f4e759f57mr78628425ad.38.1738951582928; 
 Fri, 07 Feb 2025 10:06:22 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f368ce639sm33319115ad.243.2025.02.07.10.06.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 10:06:22 -0800 (PST)
Message-ID: <a6b3b729-d452-48ac-ad59-a60611ea6b1b@linaro.org>
Date: Fri, 7 Feb 2025 10:06:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/17] tests/docker: replicate the
 check-rust-tools-nightly CI job
To: qemu-devel@nongnu.org
References: <20250207153112.3939799-1-alex.bennee@linaro.org>
 <20250207153112.3939799-2-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250207153112.3939799-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 2/7/25 07:30, Alex Bennée wrote:
> This allows people to run the test locally:
> 
>    make docker-test-rust@fedora-rust-nightly
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> 
> ---
> v2
>    - update MAINTAINERS
> ---
>   MAINTAINERS                   |  1 +
>   tests/docker/Makefile.include |  3 +++
>   tests/docker/test-rust        | 21 +++++++++++++++++++++
>   3 files changed, 25 insertions(+)
>   create mode 100755 tests/docker/test-rust

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

