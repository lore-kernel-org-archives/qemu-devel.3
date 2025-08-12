Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A24ACA0EDC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 22:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulxNs-0008GZ-ML; Tue, 12 Aug 2025 18:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulxNr-0008GR-3e
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 18:22:19 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulxNp-0006oJ-GF
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 18:22:18 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76b77a97a04so5530663b3a.1
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 15:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755037334; x=1755642134; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=adne2J2ROT7hnkTKJfBKESDUaK23F48i6m1g0oXh9fY=;
 b=TCP1qw9s3TSA3Ik6dZVPQ5YC/CLtu+3v4fYIyZJ12HEB4V6jQ1T+Fy1qYujFdWPe20
 84Qr9ck5nP4S0HbYxgZHUkvw4SOKAl0edybLV/3/hQPMGaac4XASAcylWJaPUk2YquDU
 EJW1cKnS4zsO6KEnmtyyt+oKjA8ll0I11FkNY+3Ua7m+pyuHi6+Dxz4UivDxIz8hJeom
 P7/mhjpRhwUaoBturx1S03EHmOgglJXssIfbkCLNuYeqDykE3rMLh8pICunwvU1d6djo
 zAA2Lstip1WHsQo7ZUTe30rw0dAij+nGO7w9nvXrezk9JjqWlVRKqfbT88z0l41xb3f1
 EW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755037334; x=1755642134;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=adne2J2ROT7hnkTKJfBKESDUaK23F48i6m1g0oXh9fY=;
 b=QzpbTsGGkTw63OaBLH8nX8ZUNQQJqb4XykkGso9sTl6REyDJnxIjosJfVij8jil27Y
 tj4h6T1OsdlFhOzffPO9SpIJI63h1fK6ICvjbZs9KFha2od+TwXqGI8TLDCyEwpjHZ64
 PZBCoIP6FYLG/iGF9ZmZs49e2DoDx29eKw/cMCtOYHNF1bajI/MYYagmsmcEfUOx2beI
 Pcj4PKxq5J3YYop4MAvUDXjvGax1P0q2fIDRVZBEy/bBYjUqg1m8QHx0eEUonhCBdLau
 D/AZTA2yGydOL5XG203MxXrGGs/nEeUwhPPQMSh1aVR0ZjqGaK0aWW66LktPq5EaAVBi
 x9uA==
X-Gm-Message-State: AOJu0YwSTRMlh/cp5BmvvbY5VOtJErzn8pVcz47bYn4/Rdd55cKQnnot
 nGNfKPKh8B2hjtakZi9a83NfNIs8MHxKtZ3xlatCmrqYw4SWZocM/f3YFcZgloMeHEkuIy6f0Ym
 yMBdWEdk=
X-Gm-Gg: ASbGncvnW7RB+0Q4DljeaAu6s0IzC2sjEDZBBA8oaBcX8VF3Akoe5BuFfommnOj5MeG
 1GNpovwKkL1hKiasfG1SXO5Tqd424liGzFS/1fl033I0a3OyIp3IxCm+fVLn10bLzihbQ9p5zYx
 RAaSA4nP3oQQnCBwHNXL1yggsKU8H2jnWRE8mcTJtQMB7En70ljE+/T6Qu1+BmQliKmnVtk0YuX
 F1bzBg69Z+zf+j1TmiWo2sDe+/zVoIdYeFZL4ykPqdLfZIXHJFUlp86jUEPIjnHHF7cvxL5kDU+
 Gsh2w2evCFIs5GYF0tce0CGvAi6O5hiItNSyrgAypyPWTz851LQgM8MXYi0ajlpq/l+9J4rmGA/
 LcYK6DG3SAkIWMZmghJbZVq9FEids2bODiCWDY6Rz
X-Google-Smtp-Source: AGHT+IGp3gz2lcewn4qH/RahsX08IROjZ0DGlmnCjlzVkIlVpIval23Bj0xYX3nuA2+5Fo8bdBodww==
X-Received: by 2002:a05:6a20:1611:b0:238:3f54:78ef with SMTP id
 adf61e73a8af0-240a8c2cf59mr1347311637.45.1755037334101; 
 Tue, 12 Aug 2025 15:22:14 -0700 (PDT)
Received: from [192.168.4.112] ([168.140.255.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfbce84sm30509880b3a.71.2025.08.12.15.22.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 15:22:13 -0700 (PDT)
Message-ID: <280aae60-01db-4b45-a12d-6a9783cb7953@linaro.org>
Date: Wed, 13 Aug 2025 08:22:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 05/10] target/arm: Introduce
 host_cpu_feature_supported()
To: qemu-devel@nongnu.org
References: <20250812172823.86329-1-philmd@linaro.org>
 <20250812173131.86888-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250812173131.86888-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 8/13/25 03:31, Philippe Mathieu-Daudé wrote:
> Introduce host_cpu_feature_supported() helper, returning
> whether a ARM feature is supported by host hardware.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/internals.h |  8 ++++++++
>   target/arm/hvf/hvf.c   | 20 ++++++++++++++++++++
>   target/arm/kvm.c       | 22 ++++++++++++++++++++++
>   3 files changed, 50 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

