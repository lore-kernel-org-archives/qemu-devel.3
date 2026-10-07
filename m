Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1FFCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENeT-0004PE-S2; Wed, 07 Oct 2026 05:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xEMYs-0003aV-Il
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 03:59:50 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xEMYo-0002hW-6h
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 03:59:35 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48afe0081a6so637753f8f.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 00:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791359954; x=1791964754; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t8ogpQXBxQQObl6IRlS+kMUANh7Qh6OsIuUltz8RvQw=;
 b=BsBtyR29OGHZDAbzYgOs+uM0/mf0Uw3W9t210sC5Hwitt8VZjJXdh/4up+giAt/AkT
 gytF1L680gJwDhfKiIMohfcsChpD7vAUknBQl11+jDCbenjVMQDGAduljgG7URLu96cZ
 8gCCvhWkA/avrgwLFNwcKIA0GWOnBBKjfBHei2reVlhQc40wiAjtOY6NTygrv3oDdeZJ
 9Rc3ilFvQpzyMbqMrva6v6kskfujTRd9w7Ud4l6czgdHF8uymILsKy7qh3ABRvZOhgLy
 0u3GATFV4dFDD1ENrgHNJq+04Q3GUyyQP4NthoS1jbIc11v8VIJDEs/y8nQrrwGjrNhn
 dQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791359954; x=1791964754;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t8ogpQXBxQQObl6IRlS+kMUANh7Qh6OsIuUltz8RvQw=;
 b=suOJk07ucv7a0nKp6JWcBPTHO/sgQR3H6gNbKDUMnkSBYX8q2vrehDolGBTswqhfA3
 J/qkk/HvcGeh3l9K5q0clXKAJ7iBOfg2yYOU+AmXRscwcfZqrsWem5wJseLR6DnToPlP
 rV3Gho+Gb0rtu2BFyrGuaucXHqPOvNPNMxHaBIf+kFvO/b8v6axqZE00VnnPfjFaHsbF
 MgujyHEg47Eat1tvHzFRx1eeEQ/MuvXMWd9W7F8TVT4mDYiMJS8Vhl7p+PfozC1nxHnO
 g4CAqfxl0fjefwQnYm6u8TeolGJCFSF12kB/59kRR8F3inPoRwV0tbsz5uBrP4tj2iL/
 jtGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoeMkes4dC+bJw0CIRFQkNrcqKAfxNJTMXqM12bDk8FghW01/PPkiJNJJNKEG4AMoaU0cq2gScloJE@nongnu.org
X-Gm-Message-State: AFq9FYJR3AM16C1g14OWO0MsHgqqLJ2G1gbHW9L9yf3kXxpBWWb0r5Ih
 mLTl+mrclPaFzRhKqOzteawaksgRK/f2nyQXW5QZfSPSqpPZLfTsLKsUfMYdYNcUgJw=
X-Gm-Gg: AYBFou3jNZONb41Qb9AnlWGsfTHqFKsAUueLZF5HH/QX+PYK/RYFPrSiBOPWiA69bcY
 AZIi9ZMv/8go9g4Pk+J2+nibzYBA9LfITomQ1r9+Ga4SYHbc/wjYvUtrCLjISz+n0s6lgwETBih
 49hB98H1Zv2dit4Ki7y/wix9XsWbKAupHKModmAYvWcx1qwTi7WsASIzUkNwFfumJAvgyuR3qdr
 5jPAVUtpXOmxSWWZzCTGa2EJ3lBzTOwuudIEGJhnJF83eeTNWR3TfHltMFtkFjzxn4LLV9dUEKl
 i1gPtec1Mfq0Rr5++ZUdDfMZVn3fTMJzM+Wi9uGYZN1ZVFn6TQyLDiK9HjmoMb5oyRCe9JiYdHs
 iWXYeQ2Y7FkBlTh0tswnD5sXO2l/VfT20x9+ed8ZJ8KP+eU5nLhCv5V3S58uxuGyKS0lJc5q1WT
 In4/UASJFiCtCwipsPAzx9uiTaxnYv7/Oqg4kSjjpJX+qpvF4+ziuIKj/Je3tuUbShbbEak+Qn4
 PyoK4CmcrP0+QAoS6ChZVW78WCVv/6Ld3Q=
X-Received: by 2002:a05:6000:184d:b0:48b:efb:4a64 with SMTP id
 ffacd0b85a97d-48c7288efd7mr2496405f8f.37.1791359948785; 
 Wed, 07 Oct 2026 00:59:08 -0700 (PDT)
Received: from [192.168.148.71] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d2eeb6sm3957375f8f.43.2026.10.07.00.59.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 00:59:08 -0700 (PDT)
Message-ID: <ef8ca53b-3493-4440-8913-b46bd16e2eab@linaro.org>
Date: Wed, 7 Oct 2026 09:59:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] tcg plugins 20261005
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com
References: <20261005212458.970-1-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261005212458.970-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/5/26 23:24, Pierrick Bouvier wrote:
> The following changes since commit d7a65d1793d691d356a56833620f7d1e6f5d653b:
> 
>    Merge tag 'hppa-a400-updates-pull-request' ofhttps://github.com/hdeller/qemu-hppa into staging (2026-10-03 14:17:49 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/plugins-20261005
> 
> for you to fetch changes up to 46a8b8b378259a4ddb4bc4b79f88eba7640ad899:
> 
>    plugins: fix register handle encoding to reserve NULL as invalid (2026-10-05 21:22:37 +0000)
> 
> ----------------------------------------------------------------
> Changes:
> - [PATCH] contrib/plugins/uftrace: add support for Hexagon (Brian Cain<brian.cain@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20260930175519.3601312-1- 
> brian.cain@oss.qualcomm.com
> - [PATCH] plugins: fix register handle encoding to reserve NULL as (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20261005181817.403766-1- 
> pierrick.bouvier@oss.qualcomm.com

Applied, thanks.

r~	


