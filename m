Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D22CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 20:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v43n9-00051m-4i; Wed, 01 Oct 2025 16:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v43mz-0004zI-SR
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 16:51:06 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v43mp-0002Ms-6y
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 16:51:04 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-77f67ba775aso538591b3a.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 13:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759351844; x=1759956644; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jz+NRhjaS/1Hh98xh7Dyxe9b+oTbTFdLuOyulxvVWdo=;
 b=od6gsa3sjvnZPnCZxISahZjInKnfMF0aMYSQMa4Ehb430q/P941xEnCgtLiqJCwAej
 TCjxYSO9F2fTMvL7tiFQmNwuob/pclQxjNLRRBmlIZUMMdgtePR9yNCbho1hIKkbu5y3
 qZ8HrmTMeRCY3bYpjaORdC78r2UBJSTHGpzWgfw1DYa7nnTKgBrzfAJW1/tWBnHfUjTt
 d12Htc2InzxAkNfSe0Uux/6rOPYzrbBIxcvMeukrgqqC2frS405WOvXOkeaMB2MDblvw
 2nzyQjF1otvef0ZjAiH+y06RynOrZfr8Iv2OlazNiunzQ6KI9VCBSiMH8l3jiuLfBWlH
 3YoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759351844; x=1759956644;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jz+NRhjaS/1Hh98xh7Dyxe9b+oTbTFdLuOyulxvVWdo=;
 b=ffaGJHZ7w3gE6w2bUGzFw+vlWt7c2qUHL+hE5atxUVODMFo2iV00maZM73K28Wf/1+
 2mrxggyD9MJKLBbGMIqFb1OvqZqSl0eroalzTe4/L5IHiEYyuhsCsMFkl6vxFAahWGAu
 vaBPr4bLoDt00AfMW5X72A0SThrakG9Az6tdbZKBYXarl4fiW7HMFfP8+VDDDWRjgmdX
 9Gp+1gJZYprb2diZqdXPdGnlLSjyGCRAy+FIMHGW1NnOUZKulKRiL8jj/+fEWcWw81/E
 SEHUFwFBtJaTc+uK1puPBGfZnvcASqLK56szlgTVKMvwqX9gmG8dEwW2Cm63xtY3AZ1Z
 a8TA==
X-Gm-Message-State: AOJu0Yy78pN7kN9MfcuvPT9fi6wqHKXhrTiCxbuRm8ndzt+k/ICACJzh
 HgqPDlXC0fT256nFX8/A98lOAk1ecqy/B5e3IaMuJt5epdVeiR/zH96mhmBjP144cBawIolAu5B
 yerZXA78=
X-Gm-Gg: ASbGncsP7+tcm8pbPBuEL8WXQz/ikpuaA35sQu91Toam1CADOFuUjaVuXGKCwpi3d4o
 GX2FPeiqTexI+CgtcHLOGoTwS3/cHWWbQHv4e5EI51WvvrmeBKxytNQSchOibLYhxmY1yo4WNRA
 IYmq9c3OObCvmkUJRA0iIEAST0UkVru0P3nPAXuE+aDvKuBX6Zr81gkVZC42wLNUHvVCjJ0r8kS
 7iP+slzMGF8WUofVb4QXZ4JMwNTQukksRyJbVDGICwEyQsUuC6B/0X6Fd2GntoS7V+Vr0pApNRK
 8PxKAXrErCJ/NO3Jk+sne2Yh0BlJNdmVLXpPSC/8VvBVppnRlBIrOg452TZlrqeirr8QWM+tVY7
 S+AT/F71ObfjmVheq4mtcm0m3sHUTOYna/Peqm8zsjfb/9xVrBujY56O5Tvba
X-Google-Smtp-Source: AGHT+IFqV133IUBrU2oz9szrzLXQXiCZrL0m1/dhf50/amo8OWXxONeckjJjFrGjB/SX8E0QpeDncQ==
X-Received: by 2002:a05:6a00:17a9:b0:772:8101:870c with SMTP id
 d2e1a72fcca58-78af4143e9emr5083960b3a.11.1759351844117; 
 Wed, 01 Oct 2025 13:50:44 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b01ea8cb8sm596644b3a.0.2025.10.01.13.50.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 13:50:43 -0700 (PDT)
Message-ID: <ca83f9bd-e023-477c-aa16-2c3550dd6605@linaro.org>
Date: Wed, 1 Oct 2025 13:50:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] tests/lcitool: bump custom runner packages to Ubuntu
 24.04
To: qemu-devel@nongnu.org
References: <20251001170947.2769296-1-alex.bennee@linaro.org>
 <20251001170947.2769296-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001170947.2769296-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 10/1/25 10:09, Alex Bennée wrote:
> In anticipation of new runners lets move to a newer Ubuntu LTS.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   scripts/ci/setup/gitlab-runner.yml                   |  2 +-
>   scripts/ci/setup/ubuntu/build-environment.yml        | 12 ++++++------
>   ...tu-2204-aarch64.yaml => ubuntu-2404-aarch64.yaml} |  4 +++-
>   ...ubuntu-2204-s390x.yaml => ubuntu-2404-s390x.yaml} |  4 +++-
>   tests/lcitool/refresh                                |  4 ++--
>   5 files changed, 15 insertions(+), 11 deletions(-)
>   rename scripts/ci/setup/ubuntu/{ubuntu-2204-aarch64.yaml => ubuntu-2404-aarch64.yaml} (96%)
>   rename scripts/ci/setup/ubuntu/{ubuntu-2204-s390x.yaml => ubuntu-2404-s390x.yaml} (96%)
> 
> diff --git a/scripts/ci/setup/gitlab-runner.yml b/scripts/ci/setup/gitlab-runner.yml
> index 57e7faebf10..7350f6cff4a 100644
> --- a/scripts/ci/setup/gitlab-runner.yml
> +++ b/scripts/ci/setup/gitlab-runner.yml
> @@ -103,7 +103,7 @@
>         when:
>           - ansible_facts['distribution'] == 'Ubuntu'
>           - ansible_facts['architecture'] == 'aarch64'
> -        - ansible_facts['distribution_version'] == '22.04'
> +        - ansible_facts['distribution_version'] == '24.04'
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

