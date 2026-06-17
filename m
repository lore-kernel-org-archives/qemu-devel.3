Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7201CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs1i-0002gW-G5; Wed, 17 Jun 2026 11:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZs1Z-0002fa-CE
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:17:54 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZs1Y-0001cY-2q
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:17:53 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2c68190ade4so8453425ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 08:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781709470; x=1782314270; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=giAJqJFI0d0XIuFU4gFg5fuBP1WlyitvqIxIera60ac=;
 b=FsdUgVgxWeIrA5WfsLC86F7I3fEyt8ebbGcKKvbpgHxrEKXZJZMVdwsmHsSi9hmVZu
 B8PRdD9f6Sq55bNRE67Jps1xgumC59GEZFWjgEjmx/Wb0EvwSgPdjceW6RMjJkHazGMf
 /xNvaWk/8OD2tgXLWlUDxo3T7O5FX23xrOjwzvIHZmqW+Pt5oCUbreo5UD3cI5637QBk
 1gh1QcEFuV1iKKo8SeSWytTuq1FQk1kYPcQHOa1+CoZhLYwtKkLY677srtTEJqNKhhR/
 S1AaYwvTkWa1Kd9d3nCtRJ5ID/vGcxdlqQURhw6XtSeKGB2UkK4ReIYwsH9XN7i7jbok
 HzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781709470; x=1782314270;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=giAJqJFI0d0XIuFU4gFg5fuBP1WlyitvqIxIera60ac=;
 b=U4HTCVpPcTY2cjJpiuDjiM4efqqo0eFFPaj6QYW9lHos9Tx5a3byFQk0DXnTZjWPAh
 wy8VViQ4qxYZSnifC5wS2w0MiFBDLPbnFmjUjdku3gKQqMWNnCiX80wbiC0XaVDp1uv/
 BiM50VXb99eq1jigPjfVfiUGWtFDxt3VrWnSrYUPskPKUPIDDyxDX5DlKdG8wvty5a+s
 Ex4OArKAzf+EGhtva7VJi+gXtpLtkUiHzBmlmKQBGR7bAWBspfaaP6DyJMqN8A15WlIr
 5lyO4zr/Zc7/VLD5Y6vEvmVy+9rlv3UXHhTeeAy/XltWXTnOwq+9c20YMlrlnx7eVZjJ
 UP9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/QryqmCQqa5A77XqQeCjTbPsxfHfajj7KmcHg0OqYalA9XlaRwAjdk7NCZWRLdjSJMlQMoixRsNULZ@nongnu.org
X-Gm-Message-State: AOJu0YzCNjJTEKZk17y2/W1Xq1LrcSgUsDtytsJqFPt82YPcWiJ3UEkV
 wfSQpeLCEaS6WGry7cb4d11kmPOkj3+/AsE3aqpAOeKrZNS5a+8wNvPXo/0qnY4fKI8=
X-Gm-Gg: AfdE7cl+EWE226GGp/MGgrhoyfaaMJOVE2q1CX8DWjfUc+V+ji9KPYT3FcxtOC7NSLw
 utUshextOhJwWV74/ldRW+/OWczvExC98Zt0DO2Pe/r3JPelALvbulO1/byJ5+zQqBzeLhDTc+4
 JZ/+sJEIGkDJ5NkOW8qfToM/RGP7kMzGsjOk+weoGpOCLaSZP0ysQSdtpYx1oBj50Oqe2Q0gjV2
 zn5LsUc/O0JQp0Rw+sm76fORhbQ5nWfrdG4QrWVaW9NPGSnpwuAfchRJmKSubhCHpRQ13ozBBBk
 T2feZhDqbOjX4siHtexajE8tYMEN4s58rxcZo5GRA0LrC7JzixpJjfBanIkV7OYQzoIhcsGcbWg
 q4H/BRgVLXd2ifsmD806uqrepuYtwqQPpFkzM59m9iZngbDOYrEhmzqzrT1W+62XJEDno6lTpCM
 cL5MpLk8L4mAR+kfddZjgsQtT6vei4/Y/P9h9pexLoddrxOVXRsvYDLUVkCw==
X-Received: by 2002:a17:902:f549:b0:2c6:b3dc:b838 with SMTP id
 d9443c01a7336-2c6bd11dc47mr30877695ad.18.1781709470054; 
 Wed, 17 Jun 2026 08:17:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c4328a4c14sm159097275ad.43.2026.06.17.08.17.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 08:17:49 -0700 (PDT)
Message-ID: <dcdcf41e-70c5-4a26-9714-28a936e30f78@linaro.org>
Date: Wed, 17 Jun 2026 08:17:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] accel/kvm: Replace legacy
 cpu_physical_memory_write() call
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260616020839.19104-1-philmd@oss.qualcomm.com>
 <20260616020839.19104-3-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260616020839.19104-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 6/15/26 19:08, Philippe Mathieu-Daudé wrote:
> cpu_physical_memory_write() is legacy (see commit b7ecba0f6f6),
> replace it by address_space_write(). Both if() ladders only
> differ in the address space argument: rework to have a single
> address_space_write() call. No logical change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   accel/kvm/kvm-all.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

