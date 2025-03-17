Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4670C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 18:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuErc-0005F5-DG; Mon, 17 Mar 2025 14:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuErV-0005Dr-SX
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:06:54 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuErT-0001Rc-Uy
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 14:06:53 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-223594b3c6dso98319945ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 11:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742234810; x=1742839610; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kFwHl7z1IKdRbGcPt8gK8rQZUFyDKeJYbAaBOPvDmz0=;
 b=xSEZyznbkHE8uRXyFY27y0PYPB2gkEnMbjVrNatoamRK3WTlvt8uXSl9Yia12K88wO
 huNMIiJ1WHd8EYSj+F/kuqe2Z92woxEuCaPcgZ4Kqw+wtfyPRZ25T5IlubCW3dvgY55O
 Sg7lgJLHcJrHiKJxgvd9tE0/VSSbbPcpZDlyfMkYLFFCBHcv+bL+vCzEU2/4nEiM9oXz
 QHhei8SMWqWsFhQVw8gtED9TFNdI6XQ3p6dXHNXn26dMdUXnKvKHOTHVNPFOVjGOBMfn
 77igZ49c+R9WEQv0VGhAZP+bQzvH3TCVI3ux3OBZzPnNBbcth6Hy9hWU0eaP6jLupnt0
 iPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742234810; x=1742839610;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kFwHl7z1IKdRbGcPt8gK8rQZUFyDKeJYbAaBOPvDmz0=;
 b=viXLmLovQtsaV/xGMnPJK7aimwGPNQYMnDJD8Vk9D9tWKMUhJFE7xpo8oJJIUUPcGZ
 u/YNT0k9xwBxsCdvuyfHX1U3AGsXbsS2meQII8bAut2bJ7mPyeV96Od1XqX7H2RzXyxy
 bofAaw1mBNt5xS056lIMfbnBqpcMoHA2oL1ji0pfiTNOvX2THZNjadEOT6mqmoZ5VY+V
 CDvIRerTe3pxbKp5Ew7N7OVhIQGd6/MtBXiqw8pjgU9hnoVoYH2M08f1d5Mcxy33Zlfa
 0lnjFU0wT7qwFUCr8IRnxnAysJAGNEP/+fmhnmWJxZWH4UgtDUcjwsp8D2QNNqlrEYgA
 iVkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9RPayZ1aUAVk7fwzg5mvebjvuPli271wmRDaYT4HsZXQB+Gy61nB8nwXx3EecoCnKLWd2b3Pg6n9/@nongnu.org
X-Gm-Message-State: AOJu0YzfwvEnkpzuUbBMi+mX+jweD5dz31R/Qh1NSBCI5zdqkhqQ5xpC
 Q0IoGL2nO+1QxpttxilIVX2dCkK7a7lkp5iC01josDimuoY7cFTl9KJroSe9b6M=
X-Gm-Gg: ASbGncvDAAPzUZLnli1uIkYVyFDtHIhwvdMwlZndwYFV2Pumz5khpnh8hP5WA0KJTnf
 vJDvUbmvtd3f4fpwKn8FXYhD8oGKPKxZ2Je9YtphgJASUcv8x5BYCUOQVmHCRXPN5fbDt8hbx2A
 iCv+3JMuqHqg35M8c1zPFSq57VC6EPsg4D2YQ83An0qLZUiliv5RlByzT5gd7l8rXOuPuWG9eMu
 kq/98un1ExMMiVOqxjBoYawjhlihHr8BBUivRnZZHzi562nfe9tXQ9sXc/fXz0a6hIURnIWbs3g
 hSFlQHa9AhwqFAuzFTMExQAqdD7RnfAqwfKuZsfkhDjuCoCVWr/hoN7Nan8nNhMGtAhn+DcPJs8
 YFPOX+MRy
X-Google-Smtp-Source: AGHT+IEhmPg/lbl6ZpgVDdMbaH/XR4w16zrYZfoYtGIzdkVlltyZtyDTJk8unOqHwiUoAulSJd9YoQ==
X-Received: by 2002:a05:6a21:3289:b0:1f3:41d5:65f6 with SMTP id
 adf61e73a8af0-1f5c12d7e47mr18733684637.32.1742234810246; 
 Mon, 17 Mar 2025 11:06:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9e1fabsm6252152a12.28.2025.03.17.11.06.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 11:06:49 -0700 (PDT)
Message-ID: <7487ed03-83cd-4109-8a61-4136bb6a1c7d@linaro.org>
Date: Mon, 17 Mar 2025 11:06:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] exec: Restrict memory-internal.h to system/
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250317161329.40300-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250317161329.40300-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 3/17/25 09:13, Philippe Mathieu-Daudé wrote:
> Only file units within the system/ directory need access to
> "memory-internal.h". Move it to system/ to restrict its scope.
> 
> Based-on: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
> 
> Philippe Mathieu-Daudé (2):
>    accel/tcg: Remove unnecesary inclusion of memory-internal.h in
>      cputlb.c
>    exec: Restrict memory-internal.h to system/
> 
>   MAINTAINERS                                | 2 +-
>   {include/exec => system}/memory-internal.h | 6 ------
>   accel/tcg/cputlb.c                         | 1 -
>   system/memory.c                            | 3 ++-
>   system/physmem.c                           | 3 ++-
>   5 files changed, 5 insertions(+), 10 deletions(-)
>   rename {include/exec => system}/memory-internal.h (88%)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

