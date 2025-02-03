Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CA2C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 21:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf4Q0-0004KO-D7; Mon, 03 Feb 2025 16:55:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tf4Px-0004KB-J8
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 16:55:45 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tf4Pu-0006sw-Qw
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 16:55:44 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21ddab8800bso68512855ad.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 13:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738619740; x=1739224540; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yvaPmVtbJpUbcl8izaOeKH9jF+8Y8qcKsxyN9OiSW1c=;
 b=tTm0+cKVXa/mCFfHYuic8vxDncAVV5Eb1yU43657SRdXAC5WR0jP8R8zaustQbLTwu
 2Q/H9r5m68QngQK0dILVpk4+xgpj+KAt0cGbeoXheegfrgnAwV57W6h1azu1Yh3DUchF
 UdYOOtc+BIvmMDRwD+tf49KAZDsIYibouhB0rEXLU9PDStgKZ6x7L58O+ZyIK1uI/wo5
 HGwA/rpdaXzNNTsXleBiLlSG08YUKN3JoqA0/NXH/qDlwJCb00pI/D5soZU6Fy3SZThQ
 H4roHHFHDcgIBUiXXRBH5MBOchx8apTKSJsKhmBwWWr5PHxpcSoInCnfxDoG0P4Fd3cx
 2wog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738619740; x=1739224540;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yvaPmVtbJpUbcl8izaOeKH9jF+8Y8qcKsxyN9OiSW1c=;
 b=THQyzuR1I4NNUtXwOS/XpuvTT01VWkwmqpm6U37z3O/83IKjQ45dk7ACD+wiFbfRRd
 RRDvE3f0Qd5ATObMVAhQbo2qmhBtIvGD8UOUQMoJUaS4ajh2qEpT7LUZ9plPiuwn8oMi
 2lhL4HwUcE/ZdP8aCCbhYVmQPJva4krIFtc4nfdJtgQTUn2vEq48jfT7bzTH7+l+5Y+H
 XOiLGn0KV9S4+1HwvEwoJk4LbbHcJWyvVhk33ID2zAqzf9YAmtflNB/68rYu2aLgD2Fb
 a1eHUXqwC7AXaPADlUtF3nX+W7vzHvCd2MdvwgPPX2/Xlf/YAQQpsEO7FlYixptnYFxY
 xsbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhljR6TMrc8mU3rCjtT9AzLAicqEf2fMttb5QyIBwrPuRAXb8qL0/th+0E31wlMQGw+oYWzbKp4JDf@nongnu.org
X-Gm-Message-State: AOJu0YwNlitLMXqV27eF/8LAL9yxfjLIRwrpYO+zhgs1k9T+YpMTVj9j
 K4KNZsx1ZSXPDIz3CrfzzxawqlAuoF6EWP8D/mQO9ZtWfUYsdQGdI/hxpQQ0nZg=
X-Gm-Gg: ASbGncvEyFaiaG8Q7p6BR5CtxK48xhfL7BdoHsZaKluWp8SYcP41JVIR+OA5vaEMp15
 DVwps8kpGPF8S3mzV9RccVNTHpqtFP+qVIysQwvKw7h4oOh9sGHQi9ke8vS0bHcbD0XDMMlPljR
 +fGCEjJG+k8zYp9/LXf+xa2ym/1D5vx3S+8pMTW91sD65WAzQea1gRUUXFJJy5DMURxclEnnyoM
 cg+fYszZUp4h9vceAfD4WwE+cq4B/QX4mVU/0ZiOJ3TT+3JRg9I/d+sraRQh8PX6mLgJkMTcB18
 rei8dTOCLNT/p4Neldpdvab+M/zGrsqB++Ea6CCyAdhLSEdNjI+BF8Q=
X-Google-Smtp-Source: AGHT+IHV74xAjQYh5V057MZUZgxd5L5oxF+/XIH9IWZYdFs4eAz1xg8e6V7QUNuaq7+SWOVnnj2U5A==
X-Received: by 2002:a05:6a00:1411:b0:725:9f02:489a with SMTP id
 d2e1a72fcca58-72fd0c5ee8cmr33213659b3a.17.1738619740422; 
 Mon, 03 Feb 2025 13:55:40 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe64275c4sm9348350b3a.61.2025.02.03.13.55.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 13:55:40 -0800 (PST)
Message-ID: <e40c39d4-425c-4566-af41-373941894045@linaro.org>
Date: Mon, 3 Feb 2025 13:55:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] meson: Deprecate 32-bit host support
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: mark.cave-ayland@ilande.co.uk, berrange@redhat.com, philmd@linaro.org,
 thuth@redhat.com
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <467a5a58-952e-4930-8e91-744eda6d87d9@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <467a5a58-952e-4930-8e91-744eda6d87d9@redhat.com>
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

On 2/3/25 04:54, Paolo Bonzini wrote:
> On 2/3/25 04:18, Richard Henderson wrote:
>> v1: 20250128004254.33442-1-richard.henderson@linaro.org
>>
>> For v2, immediately disable 64-on-32 TCG.
>>
>> I *suspect* that we should disable 64-on-32 for *all* accelerators.
>> The idea that an i686 binary on an x86_64 host may be used to spawn
>> an x86_64 guest via kvm is silly and a bit more than niche.
> 
> At least Xen used to be commonly used with 32-bit dom0, because it saved memory and dom0 
> would map in guest buffers as needed.  I'm not sure how common that is these days, perhaps 
> Stefano knows.

As a data-point, debian does not ship libxen-dev for i686.
We cannot build-test this configuration at all.

I can build-test Xen for armhf, and I guess it would use i386-softmmu; it's unclear 
whether x86_64-softmmu and aarch64-softmmu are relevant or useful for an armhf host, or as 
an armhf binary running on an aarch64 host.


r~

