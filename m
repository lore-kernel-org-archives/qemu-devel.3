Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF057C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 09:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxkLe-00079Y-6O; Fri, 19 Apr 2024 05:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxkLN-00071q-VF
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 05:15:47 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxkLL-0003tJ-Tb
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 05:15:41 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56e1bbdb362so2110021a12.1
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 02:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713518136; x=1714122936; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eM6Em04Ss5ln22i1SG+Frrt6JidlwXF8K+KF+gQPcS4=;
 b=GXgcpHs32+0/8O/Oxsu+sGv4RO1NDabOUGErzAEOMh3GjzYy2X9vNvieQQU1a87Oxr
 /yO2/6FYFt+JXt6lirwbYjgZou+gpUHQEP7C2IuTFf+OXnTO2dgRit9hukun/kzhMHyv
 S9YnZnttowRphNPL1KGTaULHKOlAu1En6Fap6dA32HY4aLsSLAfEZ2BdKiSawPVCzWQP
 NiLu5AA7cMaQ0UgNvleDk1laXUybjheig/C3zh9LY3xY3RjKaEFUS5WI1sGbCBp1J/xX
 k105ay6uVEVHJwfxk1AHeXPIJwObxWrHqdisqJ4wmgbToDvOt5dxaHHMWv0oWkFlbtAl
 XPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713518136; x=1714122936;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eM6Em04Ss5ln22i1SG+Frrt6JidlwXF8K+KF+gQPcS4=;
 b=pTN5b8jsomkS4lvPEM8QDTnx/aYwvSM2moMWzBUDn5ZkxscqJ6mQ4oQWsLIEfUffub
 DGDkN4pYvf4vnGQyrcFNzCLbssI3+246+CqkSkdWnhgsJ8BGjkmcLYWgdZX84NQJ11O2
 BbNjp5hAKn82pZM9tc20nEFUMwHsKscR0M/oecTsDuDlZo++cwcseHMkLdvWF/+hs1pn
 CnCicc80VxF8ovBaX8V/aTKHY3Z7IbL6dLscefQ0Bjxg2D0CLNlCpcbdI2Y6yG39anjM
 XIAtVEQ9fCE0cmuByHiX9On7b3PKUlz4oQFllPSxzXqaMSBFJtum1WP9XaXnvma+9edw
 sDfA==
X-Gm-Message-State: AOJu0YzwOLA/tI6PL1I4zrO0pbEUf8vFLTwKCS4zvXyxmqnJrloulhki
 v5zJZjG6XdeZ1BNxcijM5EVEWKLxIG7kkKy701J3pZ5tejPOMmUA3Gqa9R89+LI3S3vMsfghOAi
 53Qk=
X-Google-Smtp-Source: AGHT+IHLZoXnAlKh6xWv1odAX+RLt1nPoTB9Qkt8sXGzkG1xjY/57yU67eeQP0gZDRuKMN/4E3riZQ==
X-Received: by 2002:a17:906:2819:b0:a52:2c4f:7957 with SMTP id
 r25-20020a170906281900b00a522c4f7957mr1314373ejc.66.1713518136252; 
 Fri, 19 Apr 2024 02:15:36 -0700 (PDT)
Received: from [192.168.235.175] ([176.176.143.233])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a170906c00700b00a51bf97e63esm1929181ejz.190.2024.04.19.02.15.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 02:15:35 -0700 (PDT)
Message-ID: <d0f6628e-fbc3-4e82-a08e-cb72f4585e8a@linaro.org>
Date: Fri, 19 Apr 2024 11:15:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: Remove KVM stubs in cpu_models.h
To: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-s390x@nongnu.org
References: <20240419090631.48055-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240419090631.48055-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

On 19/4/24 11:06, Philippe Mathieu-Daudé wrote:
> Since the calls are elided when KVM is not available,
> we can remove the stubs (which are never compiled).
> 
> Inspired-by: Thomas Huth <thuth@redhat.com>>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> RFC: untested =)

Now tested!

Inspired by
> https://lore.kernel.org/qemu-devel/0ae778e1-b4aa-4021-bdbc-4c6a663db41a@redhat.com/
> ---
>   target/s390x/cpu_models.h | 15 ---------------
>   1 file changed, 15 deletions(-)


