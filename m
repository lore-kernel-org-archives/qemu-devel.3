Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4C8CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNiM-0003eu-UA; Sat, 30 Aug 2025 11:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6qN-0004zX-F2
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:41:11 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6qL-0000oD-37
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:41:11 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b4d4881897cso733328a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756503667; x=1757108467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fB5nmKg+3WVXiNIQHj0vBzxunuaqCaDa8V0Z/nwnd1c=;
 b=HG6aZ3zD3VNINp9d/VPatlPzXFfR032oZZJnv6S9j+7Cc7Wz3PE/CzOvPzy7eoTPym
 gJLTaE6xos1kRL2p+N0PVRecNA626zAYzUkhubO52yh3b3xwPAjEK43n4iUWAp0c7oeK
 zxYHFY75o8p/x1U5/hLQSe6s604LSadFVVCEwDmnz4MbKpolFiNnZ3MpdfGpP3Zcbcfy
 vy80IAQOpmRVvUmz/uTyFcFuxR8ppcqifVDrP/+/mGlKg3melUJA1YFbjtDf5nyUjp5Z
 IP9xfl5sj7NwFU9GW+1eOXNRXgfoUA6u+JSRQflI0nZATkrK0Qi2lsVQhFlvUHeuo6nT
 nYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756503667; x=1757108467;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fB5nmKg+3WVXiNIQHj0vBzxunuaqCaDa8V0Z/nwnd1c=;
 b=Wexi6i0CiFpLLtNYSqeL82NwfeIg8KQ085wY+LZ0tA/g+ztoYHyqqHkzwpMo8naYZW
 5AYy51N/oMx1Tw5VjsfWihz16d47TFDhiPCVBmyeeQYcvbBsNIejVYovfmNo+x6jLpNY
 Rgv6ghXByJPwZW2cl5KUnQ1zb72RMWbH/3x9oY8uQ5PlO8iR16FDKT1ePh1UwLYPeJFL
 Fw5PRUpEtFL5/okfHnvZ7XbfdMjwb4hw3JQwIGSpRXF89gbPFgCa3KnI5pfT1Nr4zbl9
 dj2S6N3SyYIPfkwtPfg0hXWhWE19c9Cgk3IKDZFsLbzkJkGMY+x8J63L0pKAVJFZ9EhK
 T/8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnk/mHyPcfJvhCxFRkOkvphw+MBr+AvHmwpwwC/VUd+kyDF6Gk0nrzoxN2ZFlCaEDTiU9/PXZ3gUmw@nongnu.org
X-Gm-Message-State: AOJu0Yz/SZbVxPgego0xjKcGBr7HIuf1z9PvKpdMISXlsKb4UJvXFhjQ
 s30ino5KaY7XDz+PJ65YGQFGzccmggXc2TIaShLTWlEzuro22ZOUNaizyUqlEB0ZJlY=
X-Gm-Gg: ASbGncsamPOVFxdpvd6BVIy95LVXlLuMx3tRI0MRXyh631M3LjnLU7Ugr85K7QNBuKu
 ILa4lJqDj85T4fA1fKsr5Cvlg0lZUlTtISrxua2UBw+UMSJU7lbprKidzLHRhaVLIGA1N1hj+WT
 pHxI2dtGoNIJVIRPppquuS2c8/gXyZnDSWtWYg7UvW2hlAvyHFbvxQx3BvNWsvHvCcD3JvmYthv
 wxyE6TPZOa6QIfY0BrTdToMHaJT66rt4IvKDru/JoZcPILl69BX+ENBh8USrPoNz3em8JZEukA3
 SsFEingLfK2Iaf2ackt/Prn5+cO/xs8QBNz35qV0TcFLs3FBSOBjL55hJK7iSZSMSHN2wHd7K95
 O3TDrXv+nWXDQBKxN3BvwKW0+kU6HsQT1uPWT3OYAo0adKN5QDcXKWrx2V+h68B3NwuLww+PNq2
 +8OyTz
X-Google-Smtp-Source: AGHT+IEtkorOF9MoxvcUzv0cph/GsCyuNrptYCGryzEgV2JQJQYBTOnlPEjSm2j+/sbRjF18WoScbQ==
X-Received: by 2002:a17:902:c949:b0:246:edc9:3a80 with SMTP id
 d9443c01a7336-249448dce41mr1720525ad.5.1756503667115; 
 Fri, 29 Aug 2025 14:41:07 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-12.dyn.ip.vocus.au.
 [122.150.204.12]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327c5fc5055sm5106273a91.14.2025.08.29.14.41.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 14:41:06 -0700 (PDT)
Message-ID: <faf499b1-c3b9-49c8-baa2-00568fd0aab9@linaro.org>
Date: Sat, 30 Aug 2025 07:41:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] accel/tcg: create a thread-kick function for TCG
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-7-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829153115.1590048-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 8/30/25 01:31, Paolo Bonzini wrote:
> Round-robin TCG is calling into cpu_exit() directly.  In preparation
> for making cpu_exit() usable from all accelerators, define a generic
> thread-kick function for TCG which is used directly in the multi-threaded
> case, and through CPU_FOREACH in the round-robin case.
> 
> Use it also for user-mode emulation, and take the occasion to move
> the implementation to accel/tcg/user-exec.c.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   docs/devel/tcg-icount.rst       | 2 +-
>   accel/tcg/tcg-accel-ops-mttcg.h | 3 ---
>   accel/tcg/tcg-accel-ops.h       | 1 +
>   accel/tcg/cpu-exec.c            | 6 ++++++
>   accel/tcg/tcg-accel-ops-mttcg.c | 5 -----
>   accel/tcg/tcg-accel-ops-rr.c    | 2 +-
>   accel/tcg/tcg-accel-ops.c       | 2 +-
>   accel/tcg/user-exec.c           | 6 ++++++
>   bsd-user/main.c                 | 5 -----
>   linux-user/main.c               | 5 -----
>   10 files changed, 16 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

