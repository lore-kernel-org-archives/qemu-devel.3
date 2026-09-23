Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131EEC98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 19:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Sp1-0003zj-7v; Wed, 23 Sep 2026 15:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Soz-0003xH-4L
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:40:01 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Sox-0007if-Gh
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:40:00 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85469e2254dso216826b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 12:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790192398; x=1790797198; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1qnECVgX0O0SwwzUh2wLEJspk7VLrc0D2r9ifxHANcQ=;
 b=Dg4eGT+mZLVXFRxcChMq4ZBqt+o0aTnntlsyE+eILO7G7TotQbjfC9DanlPMFPLPVr
 rgiFjXcuUVhKqrwkInjDhFfT4wgDuKPrjmr9E6hWrk+ZXpny6x1+yrMOmAAEGHipmkYq
 fgmiK9gZhaK9XJED1rHJaCMKT+FPh9X9HmlqHCygMdfuQqAoy1gjVdownUvufZ/KHpAY
 uf+fwdP2WwCI1+3V+kusFHeIXm+GXRhIUVZ9wRcf6uEsjYRr/smY2acGLryXNfOIZEcn
 E7Nm/ssjt9kBxVB5MirWHDJg0eddAjr9tfYIJruEBKpg+YmJqb8vcsjJ2qeL5zQw20E0
 yRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790192398; x=1790797198;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1qnECVgX0O0SwwzUh2wLEJspk7VLrc0D2r9ifxHANcQ=;
 b=Ia3wzQa5vlBYWeSn+0nnXsMCs1KUXqBOsVZOyF7SjlJr4b8bJMjIunrADqTtDeeQ1t
 d7bnl58XmSygiaeSDgiuXPc1O+vZZbFt9zhAEOs/Hpy/lQQKKGw2kiLMqy2uiQOqZ2Z5
 l/9U8Fz7kTZLdrxeGsH8pP99BAdaXk0qNhS8BsV1d2Gkz2H80uvXexec/Keu55acncYt
 cM3vIN3tu7gEHek4qHzooPGidJkMrQPyREG1tu2iBxNceR7K5Ni2PCrzF1BPr6Ry2Ylq
 XGttcU26BbEfhWHQTjh/7rToQMXeuks4nHax3jy7vCHHauBsXENUznBYySW7auh5nMYM
 z4UQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTxFeDTTNaVqhg8I/uacAAuh28G09z43oWOYkxkyYv3cSMUCK0Qq5CqvSbDftcIAxzuiYdQ2l+rsjE@nongnu.org
X-Gm-Message-State: AFuF++kCxLu9jg+TumHYr8PFIXYDFT3pk8MNaKyrfhS+39TJGaEXQ7ZR
 D2aza8CAFeeCsBDw/txPiH4Wv9xMDnluUYpmSBQMst+dUn3DDsmcNZo1eQtm6VbIROQ=
X-Gm-Gg: AYBFou3mkOwcGyh88wwNRz6gmGSAZgMa01bV5q/AG9xBGIBjkWzIvVNJhDRLuKhrgGR
 1E7VCKOfE6pmqe897K1RuTzyRPWXdjd+nsCJtJQ/aMCjuSCWE8ateMSixLppB05+EsZ+X9Z0X55
 AieeSBh2LtnRavTfss/H4qmk/ylMHQB6lyZlUOhDa92HlzBOT8TKs6wZLKpjxLbb0PDuVsejXZz
 6vj8VVvXkXZstd0VCXt3tarGlCdZOekhbktWfI5R0qaEUD6mKeOb//18wgm5aLBCJl2yH4FbNTx
 p9xPczxgIkmESLpzpjmPOzZ4g/4mwuOEr6OHad0Fi/pAs6MVk99OZtLVpXDx/K8Zn2OOc7EI7sp
 9yr+CtmUJYGX3ojcT9AaXRCyXbwHEGWgHw5RUUVc5Zpl235wSk3VgHEW/jMVj24RF1OpinmVqFm
 3ZYdQYoqslw5uuGz2sw3KAKxNp7yDsk5cNq7aQxyeYYLvte4x8n+yjN1o7fqtja5y/fJPRzOolX
 6GPkuR7rn7lDifQM5m2ESz9fQ181pusZH8sj12rmA==
X-Received: by 2002:a05:6a00:1255:b0:878:3704:e0f0 with SMTP id
 d2e1a72fcca58-87ea0103044mr75848b3a.22.1790192397939; 
 Wed, 23 Sep 2026 12:39:57 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1837b594sm1810680b3a.0.2026.09.23.12.39.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 12:39:57 -0700 (PDT)
Message-ID: <469e0994-68f9-43d0-aad4-e96564e04f5d@linaro.org>
Date: Wed, 23 Sep 2026 12:39:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] target/i386/tcg: unify MOVBE and BSWAP generators
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com, zhao1.liu@intel.com
References: <20260923173021.317809-1-pbonzini@redhat.com>
 <20260923173021.317809-5-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260923173021.317809-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

On 9/23/26 10:30, Paolo Bonzini wrote:
> APX allows register-to-register MOVBE, which is normally done by BSWAP
> (except 16-bit is also allowed).  Modify gen_MOVBE to also handle
> BSWAP.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/emit.c.inc | 22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

