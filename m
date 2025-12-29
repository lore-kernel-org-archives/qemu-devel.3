Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB39E784BE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 02:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va2nL-0007iX-Qn; Sun, 28 Dec 2025 21:15:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va2nK-0007iE-4F
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 21:15:38 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va2nI-0003r0-FL
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 21:15:37 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-7f121c00dedso11785167b3a.0
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 18:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766974535; x=1767579335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MTN5nkVvisxINU8VKwPesq2m5GP4KcF+AZM4ywMFfSw=;
 b=aV2JptSaOA41i14NK/NCzWnTWl/uXKTnVMy1FwnwPeDXhHd5PgbD6U5PrhniNKQUup
 2ffKQf+o0jLBjcxipn3+/eQTHLNAy+R9DqXKiDy3LkXMjnsQ6aqU7FdgOhtTaznOE+kS
 P1PDkiH0R2AkzeueNeLbnnLPhOKlDPv4+C8N6pXoMD6SnTFC2emM37zyF90jB+eN/5kg
 w64f2CxQUiyJUYiB4s9J9CT8RUGANRJSO4wCUF5fQK4B4vkhQCAAXB78x3nSZ6hYrpM4
 RW9Hf2J3rjEkqT+rSllNexILaKHnZ/6IuY41MKLMTq2G0rD41PBVa/VeCqA4CvRVPQLA
 Lt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766974535; x=1767579335;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MTN5nkVvisxINU8VKwPesq2m5GP4KcF+AZM4ywMFfSw=;
 b=uE3e2soH6CpxGYaUgdxhwGnhxw/f+MUfeNaKbETzZ0px5xhz1x0Ji4FoIx/eNIdpl4
 /aghVIJ377d1OMJlm6n8NKCRzKF0zO40Zb+VPz+ZYPU5uFkTlU+qs6/AMeFzQmHZYL0a
 fELiLQggzNPKSNG9teRBcgHYdKIr9UMcSd9ugYytaQ3KiBh5GDHB0KSzwA0n2zu8CulU
 fVQzFKfAVPCqL6i+pHpWtKr0iR2TRwuJmWA1coRgonifnsXRJ4/QmbxIYvVfPeoKskcR
 zdW2l3JNhu9aYPSuum42W31DFu6r8GcwClPzvzs4fN5l1Hz8wdynIGzOKjwL/J49Zcnr
 WAIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5VCx0VP4qi5WX50AyDWABYaQnaXd2sSV3528Tkn528XpQqhsdsmu5rIQtj5t/zV2rTk1Lx5+IufMb@nongnu.org
X-Gm-Message-State: AOJu0Yyy8wBHgEi2vUB82smXq5nBkJV2JT1XC1/MH17fffdOhLqJ1NS8
 IRl1gZuR82juB4S90GKP9jS5axuZEXoh0nYyqlzoFafRsGlvzYiD3rfllUKrrNT+7d8=
X-Gm-Gg: AY/fxX6AcVqTb4X1+xJD+7QL+4+SUInCqVbyCJo3zG2t8MT6pAYMTMfP2uQUx/2cXV6
 JIAHsV87YSE7LKRvgUDO54iUbpmoz8PL08AJrF+4FP9rZwEmaxMmd/6Kzo7rfeLit2iXCUvG/Gr
 yHLDkQNWXmgwdY9vW+/4TXQPmdtolNGkIhVsuIing3koVv7hktgeNBUOu+tnmKaGHzlfD1meaoC
 KgaX5ul6fk/Q3lpqqC578IZl99Vs9aUJapAxeaLcmZkC4PCsVmJj2oN1XML72ajRd7OJklsLyfx
 +YG3xvJTqUZbmxUoN150fO0HJN56+CUyTCgHkLV7eZH5rLDEhRik1WrEED8SElAK9oWn3T0kiAQ
 1hcEjmnWravLulVyuMy1YRvEkWJWcrXw/OIKXSUm0vLKAEKxonyMYSj9EeDJ0hO1NvDZQSAvv0I
 aVeFTbOaDuxvL0PYs3MsvqFQucczp4CWeTeG7FrmQFW+k770ZR3dAjph8xdCM746GZJDZaBw==
X-Google-Smtp-Source: AGHT+IHphUFOthu5h1kIF8QWHEDmaWCUoQktP2ReRKT3+8KCGi8q7BHs0fT7YOJcRmkgtt/tlWw00A==
X-Received: by 2002:a05:6a00:3689:b0:7b7:c078:9f7b with SMTP id
 d2e1a72fcca58-7ff64cd5844mr23950424b3a.18.1766974534760; 
 Sun, 28 Dec 2025 18:15:34 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e0a19besm27364413b3a.40.2025.12.28.18.15.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 18:15:34 -0800 (PST)
Message-ID: <3876d0e8-96e4-46d4-a862-c187fffdbd90@linaro.org>
Date: Mon, 29 Dec 2025 13:15:29 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 000/153] Bigger than average pull request for QEMU 11.0
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251227091622.20725-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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

On 12/27/25 20:13, Paolo Bonzini wrote:
> The following changes since commit 8dd5bceb2f9cc58481e9d22355a8d998220896de:
> 
>    Open 11.0 development tree (2025-12-23 14:45:38 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 12e50722e444d8b69c93f90be3f555c9b2ffc699:
> 
>    block: rename block/aio-wait.h to qemu/aio-wait.h (2025-12-27 10:11:12 +0100)
> 
> ----------------------------------------------------------------
> * cleanup include/hw headers
> * cleanup memory headers
> * rust: preludes
> * rust: support for dtrace
> * rust/hpet: first part of reorganization
> * meson: small cleanups
> * target/i386: Diamond Rapids CPU model including CET, APX, AVX10.2


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

