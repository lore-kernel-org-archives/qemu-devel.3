Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E55C0218F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 17:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdC0h-0004Es-El; Wed, 29 Jan 2025 12:37:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC0e-00046w-Qw
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:37:53 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC0c-0003C9-I1
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:37:52 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so3884803f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 09:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738172269; x=1738777069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gCE0qaUI0EToISVxCnPMtWYamxuiJ8Qi3fv3iCcekc8=;
 b=fv6PGb32A0YZ+RRplQRBXDlUX/937NLypDg0wid/o8BSFoY4j2ERkYfaDr2XE2Q7M2
 6HGs4hMxAi5trgQ2O6/3GV56jy4Iexm7liEVOiRycc8YBX0VpWb+vS5emfvpIJKmHnzm
 Ds4vmBgrSbagpFKc3yij6OTJyuYRDZ7fPW+HfHMquc6nrSYSxjX0OC7g709bjoX8NUZi
 XWyEEa2Mf0asoMfc7b8kvs5UmTwJ0aI4Qf9usK7vGho0/wtVAeH9L438Gr5m4BvtVbC+
 9HGlDu+MR51L2yA8c+SLA5l9gwpgJeZBaByxs9m2DSVgguzYu8ej3V493no1DAXe1D+o
 lbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738172269; x=1738777069;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gCE0qaUI0EToISVxCnPMtWYamxuiJ8Qi3fv3iCcekc8=;
 b=s5RXqjKnhOt/eG/7e/wF/C4wkapvkUyFblzpNO8um+kb2YBf/LFwDJ+4ObTcx4Eapl
 I1nUbmnw57QP/omJHdgFymvvo8G1d0u+zgyX6L8IxVL6ROwGMRm9bAxLI73IVw99ureF
 eKKG3Uxup5Z3XlPIblayUpqHRKmMQixJnnrx6LKAVdxv5JMMevhnCWYKbO05FilN4LsX
 ANMhN8ELynEOeOi/WJCCkny1gchVXwflUxDf37sVBmTyciSI1Sq14AR4Ely8DZB4qeVs
 b33QlU5oeLS0YZYn5uEcDI4zu4IEcdaqPvFFB2uft0ELxnBMHiTNVqxo8bjkb6Ybub25
 PoZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV19HJkQEq8SSHQyPQv0B/tMfxzU25DaYcBDNSCWGyaXLqFe+q4OMxe/lINh6qmHgNn/V7WEah3EB1y@nongnu.org
X-Gm-Message-State: AOJu0Yxt4l3y6TEsC6lf3i9VKxkjC0EoCAcvfaV+I/1QBOvkRYJ/LhuF
 IBuuqMjzx1nDHQmEhquauGSsF+Aa4b8Vt4J0pKsDTA3Dh284mMJu68+5f4CgZT4=
X-Gm-Gg: ASbGnctFYgTDYxpEmpy+SIwuA47ncb8WEOfu5een4zZcOpykvXtSBKIA7izv/vpbtjU
 cSXDUXfiKK/oR1AfCh1r4UrjcmIn1R/0Z9ZYNopsao30W6mkr8JSgA1FOT9+JrI4UkPI5jH4nkB
 zGQSyK1TpMcJ6Shq6XIpvps2EHUc5muESW+HRBqYv3MfCcJ1X5c9U2N15NGl1cknHWtyoUhOE5U
 aCq4xXIbjgsFw35voAl14md5FUfIkKbGSs5Z3/ENqd42TN38q2HvpSuSuISI6JEvNb8O78Bn7ch
 4jneG8hyv6a4rZsEqQjZO2Pja41L5eu+zhnyd0b+oe68MOa2tK0ZODd0KDo=
X-Google-Smtp-Source: AGHT+IEa+Q5LtOiTXm2hujp6LaI5OHpwcxM9ZOheh+Ln1CKm+CKENpG+9bkFJk7CMU39HVcGbjzqEQ==
X-Received: by 2002:a05:6000:1fac:b0:38a:614b:8632 with SMTP id
 ffacd0b85a97d-38c52093f16mr4393129f8f.39.1738172268942; 
 Wed, 29 Jan 2025 09:37:48 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1764b7sm17922125f8f.10.2025.01.29.09.37.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 09:37:48 -0800 (PST)
Message-ID: <6a34116d-3bd7-4e5e-91cb-adcb830ff9ea@linaro.org>
Date: Wed, 29 Jan 2025 18:37:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/34] target/arm: Remove fp_status_a64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20250129013857.135256-1-richard.henderson@linaro.org>
 <20250129013857.135256-14-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250129013857.135256-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 29/1/25 02:38, Richard Henderson wrote:
> Replace with fp_status[FPST_A64].
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h            |  1 -
>   target/arm/cpu.c            |  2 +-
>   target/arm/tcg/sme_helper.c |  2 +-
>   target/arm/tcg/vec_helper.c | 10 +++++-----
>   target/arm/vfp_helper.c     | 16 ++++++++--------
>   5 files changed, 15 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


