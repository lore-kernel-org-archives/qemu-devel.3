Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892DCC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhEDU-0001pe-BC; Wed, 30 Jul 2025 17:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEBK-0005Fn-6w
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:17:53 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEBI-0000De-3w
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:17:49 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-748d982e97cso233880b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 14:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753910266; x=1754515066; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X6nSnhJyJ3CVhUs7Ht1tMdScyHTH04DLX3Gqrj2lXhw=;
 b=NZ4FBIfYw5pFZimeW5dqnI55UpCbrMwZyFGjDYhDQpnuvtaxXfzzPUZj8YxDcBajhN
 P7hSnd9zfyfyMWGSekJeSv3CKyn9VZJChzCB1BdOgfL7JvHmzIG5N7TlPICWb9An+9Hh
 tRBcMpI4eINE3qjnU4HxrlGRekeI6FAgrZ1LHQXhD2OT0gh8vqD+FoE+fuFimcEBjzXI
 ocFd/MMti1q6nYqg+XvUCmQ0x/n0M5WTO16Z46I5f/bDBJOhZHbzbuJdD1NpzBYerVx9
 Fe9ocUYYyxcikjWFj2ghn0dgUOoezJ9DNEB1NgIFf11iaMaV+/jbCGdYLBeg9utjAUdY
 F+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753910266; x=1754515066;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X6nSnhJyJ3CVhUs7Ht1tMdScyHTH04DLX3Gqrj2lXhw=;
 b=wow7JNVDAlTdP/Jsx4ORPB8nAsuWohZc8o4UzXS8VI4oNBabh3fIhQVpuyxhzfPbGN
 vQtfmtQ8CNH/N0agfmRilxUs91ffhiycVHIS3uY8m3GUrIhC5N6U5dqkTKhFPwHE9xsa
 a3qM+15I6KrhHC1XC6iiZC/4nAWC/O2VnT6K17KFDonBcVo0zjSq/aq4UNsJx2M0bpVR
 91ORTeWxBSf0V5u8LbpYJdjlcbjPvLFHbrsuLwEtybtemxEejhPqU/kDF6EqYHewPZZ8
 tQRjIs9TDvmv0aHylOZ8GxOCGzBq7B98iLrufVL2nAGc3z6NaFOPqO6unR3ctzsfefSt
 KVYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8ZLkdV5i3XLFJm3PPVXoWG+EBdHAxs/l9t6zYE2CyutvoXlU8RjJHvuAcRkrApRLytn4bdfxqNy0Q@nongnu.org
X-Gm-Message-State: AOJu0YwlPMwR3xJxz3zUARAbY1jIrp0SvVdKO7s2+0VZF4FeSoB0cnHB
 OqRc5+CS+40DIWjllxzIgr/MSXcdnuOTSkGD64Vv/Jz8soJc+N54g/OO7vIXKPodPoM=
X-Gm-Gg: ASbGncvXPPZMY6k6b8SMTUF13xvrtbouemMfxCkQ8/O5s8ZompsPeXGZ/YsnEP8U6rB
 JKUgNd6YegnKJUOvsqhMWyDOJ3BbxOu8uEFhyXq9/GJWQiS+lsUl+8POWP4pCmWTJPIrjKDi+uQ
 ao7DbcolyYPgA6pEHKQQXrRFDGu5Q2Tf2iUZINE9kDzM9K/8RWQ0vUjEAsczvLkTOaZaPoQWfTn
 GbN1UA4qtg8tK9y3jIgGQLdkdi8QjuZ80o7JXinp7YgU0MdDngz1x7mDQg3rsEdhNvfVCHh8N0k
 3yxA5TEfeXt6fP3Xvx+IpspqpEv8gWSv/FmhMAFq6NCRHQm9I5X0dpZmJ9p2SuP24xHGAv2h6kL
 cvOPW5X6qzhkIHiw9Xm+ceCQoffSA9syOYpY=
X-Google-Smtp-Source: AGHT+IHrDduPK7mphicoZ+OXSYYzLXcaPr076cUKhnrMx1ifxdy7woKZHnvWb8k2pgnvSnngx/I40A==
X-Received: by 2002:a05:6a20:9189:b0:232:1f25:7965 with SMTP id
 adf61e73a8af0-23dc0d59445mr7563139637.5.1753910266628; 
 Wed, 30 Jul 2025 14:17:46 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640adfbf87sm11484446b3a.71.2025.07.30.14.17.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 14:17:46 -0700 (PDT)
Message-ID: <d03541b7-a9e5-4366-a6db-71122bae2e2e@linaro.org>
Date: Wed, 30 Jul 2025 14:17:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/82] target/arm: Convert regime_is_pan from switch to
 table
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-36-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-36-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h       | 13 -------------
>   target/arm/mmuidx-internal.h |  8 ++++++++
>   target/arm/mmuidx.c          |  9 +++++----
>   3 files changed, 13 insertions(+), 17 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


