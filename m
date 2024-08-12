Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA912C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 22:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdde0-0004F9-0u; Mon, 12 Aug 2024 18:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdddy-0004Ed-Sa
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 18:36:02 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdddw-0006Sr-Ig
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 18:36:02 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fc587361b6so38841295ad.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 15:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723502158; x=1724106958; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8g/O6T+XxHNWkXv/Sukt6io1EeJAVgrC4XlmfNjLoSE=;
 b=Sc92HTZ6qHdf5gVevmx7JFcLpU7y0R65xp9mAv+Xp1ghLK1Oqm/naG52+9pTm1zJx8
 b3wyZEzoY5ClOzeuw5SSh+3UGGfrL0yl8APBApI4sgs7eT/NMNNqPOKHRuQd+wug/tab
 dkzlDudQiB5Goj6gtqVX3OuRKhecNuDz/DCoGIE0eTUitYBVmpy3nIp7tF/oBo0lc4vf
 X7SKIxrcviVuR1AuQfiBIA1+UNOreyxg0rz9wHr3fbkH9rvx1lH3VlsguVNkoBNhioNe
 VMNECBvnNj73WCuUO/zD4m6b+CU50hT2oPl1/u7BfKhWcILU0Cr18Mv/hvrilkeIsJr/
 TnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723502158; x=1724106958;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8g/O6T+XxHNWkXv/Sukt6io1EeJAVgrC4XlmfNjLoSE=;
 b=uptp06cRpaVL9U6z+biWDrmDVaJgPCE51y8jHp8HwpfodiIeO+ltdApiYS1heFpRdR
 4k3W+uuwN606Wm+qj0Toupy4jAZHbNm/FeFyILubO/T99eQsk21VNYuFFX6ddE57JbTH
 /Kefk5DBweFIyrAhpT+SxQ/l8F4md2b7m/PUaOp64fVsE7sHRoDNDlN0v17Y+hy3Y5gI
 CZSl0IApp1a3RK9BOddXHSxXwWl2VQ24Ka+RXDbkZQWD8M+6qen/GgRzHwYC91GxnnRz
 r4P12tum0dfx9glfzbgf23CTPk6lLYTYAuB3YsWxx+jKZZEGdGxSMCJ4ThXgwAlxuk3Z
 6htw==
X-Gm-Message-State: AOJu0YxQIpUIqWnhtpywhKVOrjVhMY6ntuHBtFdnS6peUlLaWjzFHQ5G
 svJ5py7UeofF1IqFQNo7hIOpqbDYOtBmVpF3cAW/un7PQHdMAsSLa/9l01PcpI8=
X-Google-Smtp-Source: AGHT+IFxi9luHq/cZedPi/7Jve27/1js9v5+xTKrNTHigHuiWemr+B+7S7COAhLUjvql9Z6PklM0xw==
X-Received: by 2002:a17:903:41cd:b0:1fd:8f14:a109 with SMTP id
 d9443c01a7336-201ca148a66mr25041015ad.32.1723502158467; 
 Mon, 12 Aug 2024 15:35:58 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd1b8dbbsm1706715ad.214.2024.08.12.15.35.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 15:35:57 -0700 (PDT)
Message-ID: <c73d4524-bdb1-42e4-aa34-6875a2135135@linaro.org>
Date: Tue, 13 Aug 2024 08:35:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/23] hw: add register access utility functions
To: Octavian Purdila <tavip@google.com>
Cc: qemu-devel@nongnu.org
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-6-tavip@google.com>
 <CAFEAcA8w47gZYV8GBQa3fNf1cBWNtm_k4DAdnOVt4RWBdSrghg@mail.gmail.com>
 <CAGWr4cSwJPMngzA7DAHRHu7eJkWGhzxuAMB2fbGRnNAx-7AR7g@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAGWr4cSwJPMngzA7DAHRHu7eJkWGhzxuAMB2fbGRnNAx-7AR7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/13/24 07:14, Octavian Purdila wrote:
>>> +#define BITS(hi, lo)       (BIT(hi + 1) - BIT(lo))
>>> +#define BIT_IS_SET(v, b)   (((v) & BIT(b)) != 0)
>>
>> To the extent we need these we should be putting them in
>> bits.h with the other bit-related operations. (But
>> prefer the existing MAKE_64BIT_MASK over adding a
>> second macro that evaluates to a mask with a given
>> run of bits set).
>>
> 
> BITS is useful when defining masks from datasheets. Specifically, in
> this patch set they are used to define writable bits. While it is
> possible to use MAKE_64BIT_MASK, I find it less error prone to use
> BITS.

The formulation of BITS is less than perfect: BITS(63, 62) cannot be evaluated because 
BIT(64) is undefined.


r~

