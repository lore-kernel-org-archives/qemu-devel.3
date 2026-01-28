Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CDFD35673
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 05:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vky49-0006vm-Lm; Wed, 28 Jan 2026 00:26:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vky48-0006vS-4W
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 00:26:08 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vky46-0004dG-PV
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 00:26:07 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-81f4dfa82edso2804667b3a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 21:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769577965; x=1770182765; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W/lqzKwylhBPG9LA3ESfZEUDUErvV3vSzInQMUXIUJo=;
 b=SdFmVg3L4gn/m4Q5Y53DOdjPWrJn90Z5Bh2ZKP+q5ckolWWEJZTzRmXoNgHNyStaQC
 ZpmkTBo4UU6b0jal2qK7hc4OdK+7T5BA+AX4YGl0KzpPHE5SN3lqFuqfgs6rEttdZ2Rk
 dIdoj8/V3cbNHnheUsKk1bA/zg4SFgGWJkyWq+kaSrlbeY18RMw8m4z3iWEvdECfs2Ma
 1TRzGbOmrpAPdyfdaIxHclhW24RYDP0RjF2kvXONxJ+2MMCBmqGExL22+rSL+TNothQi
 TmVsjA0HdFoECSn2wBBjl9Rgrpz4T5KUZ+IfsiqhVAqklaeyTgx5PQvi16CDy5Irl/lv
 WDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769577965; x=1770182765;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W/lqzKwylhBPG9LA3ESfZEUDUErvV3vSzInQMUXIUJo=;
 b=vEQh61LcXcoORBc2QJjmfsA9o7ECWZhdrSMYkAV5iAJEVSwMtuwdZw4dHOQiefcj5+
 ilcJWffJSfq7dlCaOtyrlgWWLaD1NW+rDeZYEgC+oKOSkYhq90zw0AiUrX97kiz1PQiC
 nCcs8r8+z5RHDQmVXx2ZpuNZx1sW4pcTljei/ebSYjcvZyYEU5HEL6fv+TZlyotjSZBA
 3fZL3QW11zdUEcMnfxtI/Sx3dolwlcilg90g7wrvKeuT5d+dbMRhK3vu6efqgVh4IHEv
 S4BCHLJjr++2ol5dbNNugEHrZowlxI12eBKbazdydoeOZqO97W3otswlRv1lEftUsAXI
 Jp+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE7/GYfkeMyxeJSoE0iRifA18ohVKLTotIwtdKz+K2x31aIE2xf2XOLFxvBCm5KYrZKu6srf598Jrp@nongnu.org
X-Gm-Message-State: AOJu0YwOmZKOhSKkxt2LrBA54zlWMGtt3WSYB/BXGJ56fmLMkuDDIi1a
 USmotvWqeV/DLjGH0G+jlS11veXaQa7XhHA3p63tmwg0r3CdhjgCZc1tjr4ifodqCv8=
X-Gm-Gg: AZuq6aLTMcGb+PAaQIKYTMIaBE2J5VgqycgBzeedfZhTi1jb017zOnFtxAmJC3hGfsU
 O3tkoxtHKOsyN03NRbphaZlDLVx1ExW917ko4nFJXvowD8FnNX+z74bBxeK0JQGddksFzBVZjv6
 VJpK0aFixxv47rkRhecAxR4nEnE6gZjrGvkXkueZdPIdrn99IxiwxRw8IuiTER++WAbMJGASG8/
 m+srzRdgPeKpj6ChYI7hbw9DPUijc9mxlIwyNCgBKd1nU/zoY76y4TU5qlMXdELBu9LRKGfFBKi
 8WeDh8z4Ng5SW8uHxGKUMjZHW2EjyvV+4JWuNAXKDt+EOMAaCXuFxfu1QTgWBaC0lWFCGWulO0L
 GJyC00CsvUC2I+Rxh85TzEGb7npCD+M8qGQJUA/SjZoM3bi+VDZJg5LwuKcRJTWEy9IebFpu6bh
 b0bAtNtbqrXzmwVVtBrt5MnyRPCfRoXw==
X-Received: by 2002:a05:6a20:938e:b0:35d:e4b2:b381 with SMTP id
 adf61e73a8af0-38ec6249d07mr3369879637.16.1769577965012; 
 Tue, 27 Jan 2026 21:26:05 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6432e27a17sm940066a12.5.2026.01.27.21.26.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jan 2026 21:26:04 -0800 (PST)
Message-ID: <52a1bf05-9dc0-433f-a13a-47e26d4bdeb1@linaro.org>
Date: Wed, 28 Jan 2026 16:25:58 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] target/s390x: Extract s390_get_bfp_rounding_mode()
To: Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260127153736.62730-1-iii@linux.ibm.com>
 <20260127153736.62730-3-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260127153736.62730-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/28/26 02:31, Ilya Leoshkevich wrote:
> For DIVIDE TO INTEGER it will be helpful to pass final-quotient
> rounding mode around explicitly rather than setting it in fpu_status
> implicitly. To facilitate this, extract a function for converting the
> mask to the rounding mode.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   target/s390x/tcg/fpu_helper.c | 62 +++++++++++++++++------------------
>   1 file changed, 31 insertions(+), 31 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

