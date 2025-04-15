Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD42C369B4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 11:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4esh-0004LB-Bv; Tue, 15 Apr 2025 07:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4esf-0004JN-1m
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 07:55:09 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4esd-0003Jg-3F
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 07:55:08 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39c30d9085aso3395083f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 04:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744718105; x=1745322905; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ldzFzHvSf/6Igwmoj84xCkmI0LWE21uSvQGIuh+rlPg=;
 b=eh8aBnUAY+iZ4ZCEDKVRJ1vxmO+YN0m8lYel/tYvg3rCY+CfF/Esf11RaOCRQrgLU9
 l+loZa50BaJENfoy4k6rtnWdgExhmz+nRh5+NQR14ueHdvXm1tNlTUOkbQXNg6QK+mSZ
 KB7EiiKpsOvnlJofZV4cCL8Vs+5AQN/4eoJo51l3tjdLOMoZeJSDbWPDExH+DHT+T0C0
 3f1+VBkA3iYB8j/9KaC7M1E5ZTuVM1Bbm80zkci5//wFVpq0kJ3XgMUD/99sg+u44SDN
 ooMsS328pCq342humqY+E2+lUPM82jEoogZ8f/t1cPYvLUhbvuCEudktpbQGU7J8nevD
 hejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744718105; x=1745322905;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ldzFzHvSf/6Igwmoj84xCkmI0LWE21uSvQGIuh+rlPg=;
 b=bYzgVJBvh+sle+h8VmgOdXc+d48a3DIa+zlvlgzZ5zpGocrimC6oov6vhPfhnwPQ8Y
 5FIZYeVM6l+xVnNsN/YJV5ZlxZmv0yBvcWz6qE4j6BEfHbFO7/hjBFrxaL4yi2Hhd5qM
 ZxD9ml1fkw+zT0AVeV1GYochi69rkvJu9uhDw4wFI6mnR/SVpd4yiBikoz00tgJAag7T
 yN+vdnpxiw85HuAdM0l6algEFQtfcpTyvp3oVmnDe8qKDCuARIBMCq3/c0NHV8+ZhVZw
 BRN7ME3bXkCML4EiSDuiaRTNOeRKvM8zzQGkksi5G70q6cE7heUySgyKqjzGudMVxKW8
 YzCw==
X-Gm-Message-State: AOJu0YwPcD2tG9jmrbQj+cY1i/OgXuUuKpLum4OFGbiDL09yuxjHkN6J
 4SQm/KaF5VsUfgKMXjrAcrYyjMj2Dascyzqt6cVwS02RvLn1/YH/PsLwomSp+Sg=
X-Gm-Gg: ASbGncu+6uIjSbPFbQ0IRMtMZ9TDqFl3Dcf7Ma5zb8JojNDRWB1fynk2gYiKj4ciC9R
 JwBmDzONJyByJuWW3qjRNQ1UN04X+D8nM7+A7CwPDsncrZPpWaX2acx8sq+ZAo5pXAcLt5qkHnZ
 qBNgphVT93EJBdkwDzUu5iyxLKHkKKbnXgBgP3iBfQUn/h55jxywM8KdgI4QxZNGy+b2JX7IWd8
 xgqvbeVx7iVxAggWcKnsduQODkpBkLoEkUY715dRgUEkPkRLgppvGWfDZtRWJngRzVVaEwcb9M/
 PqjU2GB++Qtwn/dNZJeDvfnZkE2eQG1wVKX5SR+4uTFmJ2D56LZg/TZuqvKsYy0fpboeBWUAvSs
 X/EexIGoVdMAIlQ==
X-Google-Smtp-Source: AGHT+IGc5nnm4ZhCQzKYyIZvg9rglbvS7WNqWB9rGQoKUNEj4+3/lKU5xArwUaqWuMGQJC8LvkyODA==
X-Received: by 2002:a5d:584f:0:b0:390:fb37:1ca with SMTP id
 ffacd0b85a97d-39eaaecad0fmr13713065f8f.53.1744718105094; 
 Tue, 15 Apr 2025 04:55:05 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f2075a65dsm214996305e9.31.2025.04.15.04.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 04:55:04 -0700 (PDT)
Message-ID: <88a62763-cb43-4984-91c1-ead8136c7d2a@linaro.org>
Date: Tue, 15 Apr 2025 13:55:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_iommu: Take the bql before registering a new
 address space
To: Paolo Bonzini <pbonzini@redhat.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
 <c6f8ace8-6dfe-4ca7-992c-2fd10faa6127@redhat.com>
 <ed082405-06a7-4407-9230-3a9b7e91406e@eviden.com>
 <CABgObfb4knJpLiPsQY35dFbT6kpS6p4iKcjHTeUn3_9A_8XSpw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfb4knJpLiPsQY35dFbT6kpS6p4iKcjHTeUn3_9A_8XSpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 15/4/25 13:51, Paolo Bonzini wrote:
> On Tue, Apr 15, 2025 at 1:51 PM CLEMENT MATHIEU--DRIF
> <clement.mathieu--drif@eviden.com> wrote:
>> On 15/04/2025 11:30 am, Paolo Bonzini wrote:
>>> Caution: External email. Do not open attachments or click links, unless
>>> this email comes from a known sender and you know the content is safe.
>>>
>>>
>>> On 4/15/25 08:18, CLEMENT MATHIEU--DRIF wrote:
>>>> Address space creation might end up being called without holding the
>>>> bql as it is exposed through the IOMMU ops.
>>>>
>>>> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
>>>
>>> Please use a separate lock instead of the BQL.
>>
>> Hi Paolo,
>>
>> We need this particular lock because some of the functions we call
>> require the bql to be held.
> 
> What functions do you need?
> 
>> Is it a problem?
> 
> It depends on the function. :)

memory_region_set_enabled()
   -> memory_region_transaction_begin()
      -> assert(bql_locked())

