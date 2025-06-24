Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DD7C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 14:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU4pu-0007fl-MD; Tue, 24 Jun 2025 10:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uU4pq-0007ee-L6
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:41:19 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uU4pn-0007qy-75
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:41:18 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-235d6de331fso78870615ad.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 07:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750776071; x=1751380871; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5OwbS5zbiB0CjJOMj2vgpQYOF3JsiZ5A0Zkjye7Emjw=;
 b=NeGvENpqy9hAbZ7wP3ta2sTCY4W/C6ZUTtRtfnqMHJqJTmrR17GavN0DbnVhZ1GXgX
 +GAQ29ptp+Z14LDk2ASr2TTY8wzwXQrl4FAwaljdseUiyrUkXH+uJGvCXuS05jrt/rYz
 tFYv3Uozmsd1nd6v6eUXJ2mh14FYcD13+8DFlQpVpxRVTXnYsk64y0F1p2R8gBJiAwqE
 u+cDVAVvQHuvDaUJieN2VlmurLEdykm6bGsRiv44o9pH5X/QeIgTkaLap5DfQ45YerrF
 koIws8Sq6ZQr9jFLUcvXkfg2LkdIAFicZwnswh0in6fwe9mbha+O974J1fMr6Ntpz242
 td0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750776071; x=1751380871;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5OwbS5zbiB0CjJOMj2vgpQYOF3JsiZ5A0Zkjye7Emjw=;
 b=hYmhVRZnlS6s9kcjj5rsmhPBdLQCqK0kuCuxklpgI7OtSArXNIqTpRBr0NQI7H12Gz
 4EbPn5YL0lpXqff6ufOe+42uvm0g60OD/SNUt6he7McJf3d/GZBK7KwlwXp4t03PA92H
 1nPK/kG/o1sD9cFDxbQF0x3lxvXD8BZ+W1TlWW1tyeOKeWzFeNKbBHeiAbILzF5LeyRh
 ClILEyxM8e+8/TiorRDqTDI7OPHfmcODX7e75wcisHraeffOsDUthPSq95z1NdKrevJl
 SIGtCQx2zMQ62d9lqEuWsXnjwWtAKV7KYIl7Ao08J0CsuFF2OeXRu/XMj3gzS36lIROK
 h8Yg==
X-Gm-Message-State: AOJu0YzQiIh8m97hNFl8jT+0B+NWPCdV8xzbL/NHm8KdSbUh+1vf6Hqi
 k3E2XBbuldrS3nnXmMv3hB3utK9ns5CAFy9i3SeTM6GM+PS6wv+/ubTOTL2it3gXwmmNzGfhAcz
 Sw8NoQfY=
X-Gm-Gg: ASbGncvmEiiaRoq7Rt9tHDBVguUe5EAU009l0lpJMiOB1URz+BmHupNiOLSAMbUpcnF
 QNLMZq1E9x1KZLLKrmEriyjuyQQG/KNI4NOCLtGtQiWksJXHxsIwug9Aw8nrD+e12p+83WehxDd
 LkVR65OM5bqPQVm0ubhJKyEe6Dkl/+sJNBvOUdV25B/ojTZR2NN2BZJuap0kpn9vhP6qgv+Jcg1
 Vb9ZgpDMu0D1fFZYtyD1lJTSL9ZW6PkE88+HGQg1AVKYub9ZO6kdM7TehYx4KaaKsXeS61E4A+4
 74vCMIc9iUQyFf4vyoEGQ6MGbS9V0UaZU1LTV9xdJUGwNIDbguiNp0ocqlegpd+o9XrT8Nqt5l3
 VsqkVcNd10aIWWWxwozMTdvrHYAYz
X-Google-Smtp-Source: AGHT+IFl1ryAguo6SZxiNdzbnz4oAWzN6ZYPtvST84Nikv3MxUERmCWqVXQDZpSE8rSc3C8Ombs9Nw==
X-Received: by 2002:a17:903:198d:b0:235:711:f810 with SMTP id
 d9443c01a7336-237d991fb70mr248561935ad.23.1750776071566; 
 Tue, 24 Jun 2025 07:41:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d86a3083sm109332115ad.195.2025.06.24.07.41.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 07:41:11 -0700 (PDT)
Message-ID: <4cbf06d0-9bf3-4bfb-afb3-09098e0be105@linaro.org>
Date: Tue, 24 Jun 2025 07:41:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/arm: Fix sve_access_check for SME
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20250622213509.277798-1-richard.henderson@linaro.org>
 <20250622213509.277798-3-richard.henderson@linaro.org>
 <CAFEAcA8uoBSSro3CCfM6KWseZX52ZtgMvCkpbH4WczNxNKknkg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8uoBSSro3CCfM6KWseZX52ZtgMvCkpbH4WczNxNKknkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 6/24/25 06:58, Peter Maydell wrote:
>> +    switch (dc_isar_feature(aa64_sme, s)) {
>> +    case true:
> 
> Why this rather than
>         if (dc_isar_feature(aa64_sme, s)) {
> 
> ?
> 
>> +        if (s->pstate_sm) {
>> +            ret = sme_enabled_check(s);
>> +        } else if (!dc_isar_feature(aa64_sve, s)) {
>> +            ret = sme_sm_enabled_check(s);
>> +        } else {
>> +            break;
>> +        }

I used break instead of a goto, or replicating


>> +        if (ret) {
>> +            ret = nonstreaming_check(s);
>> +        }
>>           s->sve_access_checked = (ret ? 1 : -1);
>>           return ret;

this block.


r~

