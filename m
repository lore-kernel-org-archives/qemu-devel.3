Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402D6C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTAHc-0005jq-U6; Sat, 21 Jun 2025 22:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAHa-0005jO-Du
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:18:10 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAHY-0001gm-US
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:18:10 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3137c20213cso3071319a91.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750558687; x=1751163487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LfbkFoYqD1GCwr/Z8vYfDjMmmiiWTo3Z9JQ9V5hkZuM=;
 b=KHWCjZU4lGTS4F5+sTDRndtwhBHe7vb6TZaKw0AounPGkKvtnXRSh2n+MF0mP9tZVW
 pZr3btYaI5vHV2KyYb5OQJaA/VNuhdwPU9pYcXxtEStZ/lR7Ek1JM33xZb5ELza2SY4N
 LYZ5O0qNjGxpm8Dsphs4jRVrA5+C1CyDer2aiJTwlFsepMcQ5LGR99r8S2BDK1VMD3vK
 rCXH/9Yo5eoVyrKAE6cMFTxulIOzKGXidMpTar7z4fLovdJB/PUeKvjoDvyjN2tmiyq9
 tO1v/NW3EVnFASqwwzL3TBjJvxJJfy9Dl8Y4OxV845c+fkzX3Jn9mQliaqGEaNVWGzHm
 E8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750558687; x=1751163487;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LfbkFoYqD1GCwr/Z8vYfDjMmmiiWTo3Z9JQ9V5hkZuM=;
 b=qWlsLp3ZCM8+py8wGeqL69OXzpMSNnzfecVYNaDH5JEYzSPQCGabYwLCFW0fDdvuoZ
 MJPb83+6CcjUjjeZUcTKyfpiB3ysE75XxGAr43by44lq/C2jAY2GwJ5GIFHBEJc97DgJ
 aGW4i/JByc0zQ9XEKu0NvDeblSRVjHJTfXWzywC8g+l9Laxwk5O0j846a1vHGjdTxRR9
 l+2HhMJMmuqdvzYuigbifny4Oa8gMc7D0lJuYAQzh6uy7OXRHS050Lw06nLNa6gXu5ES
 Xt6AqGyUHUc+7k+sggHA00Is5gyxe+nRntnZxK/nYR+Up7xGNW4tIm09Esu9NMr8WfuQ
 nqdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKRETX9f0OipEK/UfIHLSJSYCcmaUOumHJ3hKsEiQJ2KlKurtGvX6LJ99EFYKuq89B+T6eGM7yPVub@nongnu.org
X-Gm-Message-State: AOJu0YxpkFSWfQSqX+h5AzLNCZtpDJa6qyXfctSMDeyIIyC4owpIPxSZ
 pxviWJgnk0dqnJBVeD8JwluJLJGEHEMrwomwFqJphJgPqPmtlUqjklaD4oKIiixu+k0=
X-Gm-Gg: ASbGncstQACJLqUcV37UW3iG8G/PgxGkQyGp5IXibMwPae76dwN66uG+CKNKOikUVEU
 z3Ym6ymRoBrlR0AqVDtqdZ1J1TjTM3n9nnAjS2ke0s9f4spI+oO5X3xZKCeRp4vJPCqkuQjUAac
 ixTGf+tDcQmCh0hC5BP2qR//lNdNt0zUQmqbVoDQaL9NJ2d+K0qRlm516XvXq0oxXTuJB0/NS84
 ZSqoj+y2EL5vrQxeJUIJWJ773MxPF9+t6/wYpzVRatkb7uVGB74ifUQWb9T4DmD40qt+miH2dX8
 Nb9j2fel77A3Sn0QVSm9f+J+b8aP6fhbe4TJnNG8pEAqquvmjcMZdstJfwhUw83mWbP99eC9T6J
 MxoVIjXFPBzHR/fThkJPjnJbapiq3
X-Google-Smtp-Source: AGHT+IE6W671iOwVPlLgPmuXeyMGBir8MlBfDY9UjfvUU2XdWRVIfzeSKtLSZxGZjwjJ2yhdqHq7cA==
X-Received: by 2002:a17:90a:d44b:b0:311:ff18:b84b with SMTP id
 98e67ed59e1d1-3159d8d9c3dmr10760846a91.25.1750558686912; 
 Sat, 21 Jun 2025 19:18:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3158a318673sm8146942a91.34.2025.06.21.19.18.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:18:06 -0700 (PDT)
Message-ID: <4cdbfe12-3272-48f2-8964-23c97c24fbe3@linaro.org>
Date: Sat, 21 Jun 2025 19:18:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 01/42] accel/split: Minimal stubs for split
 accelerator
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> From: Julian Armistead<julian.armistead@linaro.org>
> 
> Signed-off-by: Julian Armistead<julian.armistead@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/split/split-accel-ops.c | 161 ++++++++++++++++++++++++++++++++++
>   accel/split/split-all.c       |  77 ++++++++++++++++
>   system/vl.c                   |   4 +
>   accel/Kconfig                 |   6 ++
>   accel/meson.build             |   1 +
>   accel/split/meson.build       |   9 ++
>   6 files changed, 258 insertions(+)
>   create mode 100644 accel/split/split-accel-ops.c
>   create mode 100644 accel/split/split-all.c
>   create mode 100644 accel/split/meson.build

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

