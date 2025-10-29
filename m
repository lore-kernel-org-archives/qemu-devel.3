Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1EBCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 11:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE4Fg-0005ad-3d; Wed, 29 Oct 2025 07:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE4Fe-0005a6-2K
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 07:22:02 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE4FW-00078F-IS
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 07:22:01 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-430b45ba0e4so35247015ab.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 04:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761736908; x=1762341708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iZ6bWxM6COZrVavPABH85e4M314ppYX/3vwalEvZLvA=;
 b=YyQXc4ReBe4W6u9nUeTn53oA9hzCpF8IwRpXT41GVpUkakMcmrYe6oRfVoJQu3Ef0U
 iJbzFV6sZ9TEC8IGBkc3qAKt2TykB7hbvZN3sf2gPzGiUvgr0b9C5SXeU747cX+JKSoA
 MhH+iFf4mTDRRF7XcjfmguLgqfAF510iDNQxbpVc0LcOOsmSY2QJrPPR2qIqDaG9Z7Qw
 GyTCNOHVTurmXMHh0kT3N64cquZofA1rl46QJvXWn/nH6AuHaptl9/9jvbyMlGLzpHK1
 O/JqPLXyx73bJpuQAIx/rS9a9bTkUSnVIb0p84UeAsHOly8ixobcxsxyo/OQr1mUJ4je
 SwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761736908; x=1762341708;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iZ6bWxM6COZrVavPABH85e4M314ppYX/3vwalEvZLvA=;
 b=h99qIMIb61R+IOw0aWtRDdtspmGHA2+b6N8Lxw2X1ChXG3QcWVhZlAVB3i9nHwp303
 0NiuVxlYSJNIemnPbXE1q5npk2uF28GBy3KjCFmf3k16pTfRDyvOzDOLqwQJ2vuQ7gzb
 CYJecrT+6k4XwLhekGpJBMO5O5osv8/Zi2QfXkKYjBmIV7SxDyvKnp3NfTRemVurq/IL
 ykW/jHdTGqDHcwxHcz48Uck6NaYcTheY48zM0gDrijHQ5sup5fVXzTPXBECawwYKFwAD
 U6S9yoHFeYAVUJbxQ0hZqJvch5j/azWQfFk1TfRGPTbyXTluul2BO1wpQRXKduWpEhKS
 mIIw==
X-Gm-Message-State: AOJu0YzuK8MSS4LZjpuJzRnxDnOrahP5MFkBxo/HqVCUcb50vDfWLXmm
 rYAdSQheuwpu+LCyj2Lgfapq7LbfKyssSatOJm47U0S9JSR1QkUeVQHKR1CVeofr5jVLP+RzXaD
 X+/1AXLw=
X-Gm-Gg: ASbGncuHJPUSpx0Kp27hk42xkCmbmLxfsxtCvkRRGhS8O8BG+PKIEdHjxk5kCWF3D7M
 j+y76lSFxJiBdsvZLeHVhTz5eM+mZATffE66EAzYWO1/lAqSPvLQ1ABs8J1NeMSsWUo32noNtRp
 RVX2XQbeNLiMCZf03x4Us1TEBOixetouwKGwJmFNfv4OINk5yrZv6EQ6g+iMMUMrZIt2KpshFXh
 ySk3+H7SIJnQEgHVxCnQIfaQDOFbk4O7fOo5VkEIZYq9tD+K1MCUNR5YYtqEsfc0iklKqUFvM30
 gC/aNuBG+XC4PxQFLi4E6rL1vbjZt30u+nsHSLqtyBZZM5EVlLh9THQGvXNWmB/wMPHFSBE1goM
 jxnZiK6j2IhyGjBbr83lN0hwMdP9huN+NXaiaz5eCohC4kHBT+MecNA3D7U6V/ywtoYZEya/P4T
 f6FlaxLNbnhl4bR40ZQdlh8xfbeSTu4Mps7Ey7Ifdcud2++iOIJXLeHXqapTGhHZN0Pg==
X-Google-Smtp-Source: AGHT+IEw7Z0Ps426XBRGW2mYJqBnzodRwi24NBduuHGGF14WeTBp3uYazKZeTmurAx7b8+vP0VL4DA==
X-Received: by 2002:a05:6e02:470b:b0:430:c49d:750c with SMTP id
 e9e14a558f8ab-432f9055864mr27291645ab.27.1761736907685; 
 Wed, 29 Oct 2025 04:21:47 -0700 (PDT)
Received: from [10.240.88.227] ([172.56.16.75])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5aea78e1a56sm5414738173.18.2025.10.29.04.21.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 04:21:47 -0700 (PDT)
Message-ID: <0e6949c7-9282-43a9-95da-746d0148ba0d@linaro.org>
Date: Wed, 29 Oct 2025 12:21:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/7] Trivial patches for 2025-10-29
To: qemu-devel@nongnu.org
References: <20251029090148.648212-1-mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251029090148.648212-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12a.google.com
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

On 10/29/25 10:01, Michael Tokarev wrote:
> The following changes since commit bc831f37398b51dfe65d99a67bcff9352f84a9d2:
> 
>    Merge tag 'hw-misc-20251028' ofhttps://github.com/philmd/qemu into staging (2025-10-28 11:48:05 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches
> 
> for you to fetch changes up to 7c7089321670fb51022a1c4493cbcc69aa288a0f:
> 
>    linux-user: Use correct type for FIBMAP and FIGETBSZ emulation (2025-10-29 11:58:55 +0300)
> 
> ----------------------------------------------------------------
> trivial patches for 2025-10-29


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~



