Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D743D6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 19:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBfJ6-00021n-Lm; Thu, 14 Nov 2024 14:15:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBfIw-0001w4-D7
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:15:02 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBfIt-0006Lp-S2
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:14:58 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-210e5369b7dso11773485ad.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 11:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731611692; x=1732216492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9vGHoJxvkCObt0tZ4/jN0rAQH2YUIsNBMsZzPqHJVzs=;
 b=bXQlGrxUGK3EuOn3l0ITrvXvjGkEdYq2jm/oUvu/cwfBNTcdqomVxoNRsTMaqjJBYc
 KEleXIItHYlQ3EMwJr4Tu8/yGBBFQ+7NbVV3NLiGosCIPMrzlmJze5LqX2hulUSZzgGY
 ws2s3iiPyEiXCr8hDCwvKfC9MPVmSOytqVPQMU4F8+uPYd0qM3rJLsOUISQho8PbR0GY
 +G4Obyf8RMNVfPaiXm4fj+fxQXbuK1QYKzAlsiBmQLEFQGTvMDrac75h0aLo7dIX+fJw
 a5YCbFzTGvQnWorLSWctWfg/GXHhj0h2J/NoJCxITs6GE9wV3vr3mEyq0pFc6j0vdMYC
 y6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731611692; x=1732216492;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9vGHoJxvkCObt0tZ4/jN0rAQH2YUIsNBMsZzPqHJVzs=;
 b=Xb2dE38F3yjsRjxgJONDdbe/sx61P7qvrXrjGQ1+4C1HLjIPw3xKUsBYVctQV+wn6i
 bf4qtI0Q9XV5yGoTnmYffKV8umxbO3g440vpy+OlqUin6XvldmRugFLhslwhVzB7utBO
 vm3040u1WJWqhScLowN0amR1CUY/P9UPNibmAobFP3hyxKs4z93OdeSqZqSnhvMO8gBb
 QFwY/FoZiVM3KY+brnCKS4hKnK1ZxA0y9dG4Nsc3/UfMXA40EvPfsNi7b/VLC670IJH9
 Kpsqjd3ZTrQzzgwKE0t94980O7/V598wQfqdk2zZ+qwQhXnaMfCytR80qeiB64oNsykx
 Uufg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkbFkK45L/QVAcHAcEW4DgZmiG9y0wH3g05UVIBfQxcUKDkNXcfmIfA3JhmVn/77VQmE1GCkMFTmx+@nongnu.org
X-Gm-Message-State: AOJu0YwY1MP6CRH+lBqZViqfjyFlXOw4BnvBC7hhscGneGoT2d9Ttc+6
 eG0rHjSRfTIHYplxO78p0/+6bDuOnMPsrgze9obwtzErCZf9uxDvlCvnniLgcpQ=
X-Google-Smtp-Source: AGHT+IFie00W4vpcKb9KUmD+UtkV/8+ta6XWru8xUyBPA5Mw5K+uYZVUc1eRZo7kvxYHEdEUmgjvzw==
X-Received: by 2002:a17:902:e74c:b0:20f:5443:9ec1 with SMTP id
 d9443c01a7336-211c5049a48mr46775265ad.33.1731611692112; 
 Thu, 14 Nov 2024 11:14:52 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7d01699sm14005425ad.188.2024.11.14.11.14.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 11:14:51 -0800 (PST)
Message-ID: <fd69acb0-4ec0-4b31-89e3-7f5498f4f7f5@linaro.org>
Date: Thu, 14 Nov 2024 11:14:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/24] exec: Introduce 'user/guest-host.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-12-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241114011310.3615-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 11/13/24 17:12, Philippe Mathieu-Daudé wrote:
> Extract all declarations related to 'guest from/to host'
> address translation to a new "user/guest-host.h" header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/cpu-all.h    | 34 +--------------
>   include/exec/cpu_ldst.h   | 47 +--------------------
>   include/user/guest-host.h | 87 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 89 insertions(+), 79 deletions(-)
>   create mode 100644 include/user/guest-host.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

