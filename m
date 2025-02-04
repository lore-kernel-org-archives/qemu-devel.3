Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FD0C0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 09:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfExn-0003E2-Eg; Tue, 04 Feb 2025 04:11:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1tfExm-0003Dp-4Z
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 04:11:22 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1tfExk-0000CP-9v
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 04:11:21 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5dcb060ca2dso3338492a12.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 01:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738660278; x=1739265078; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=wHv6bVR1cHAduHzOBPtdl12AxupWPf09/YoJP+NcNq4=;
 b=d2AhmohYQvBDZ3MaKncYWIBFfx60JsWt1SYp/aXZv9tVNwKBzMSnESLT1v//+lEG1l
 8R1toxYU6BgxEMQXbbl/wvQn++tBQSX9l9lBI5fyHahEjRq/5r4c2Kuu4T8g3HSj+sOZ
 nEQgLRCK3jr8sQjdha+k5yvwbz4ZDuBs/MrlCKbQMt8nIEpfamYovp1cUsuvwLVcw8q7
 ZGa7UuKZme4J33CCPX6bELS673jjK0dy32Jf3FLpLWHrb/IkoJVHZm6r7PVC0C94K9I9
 xRTrMhLjdkT4jgtLCZrkLDjTqlQmznz19c+JRHj/UC8wfsDcEeJfmvp9YKMJF42YLfXn
 6ICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738660278; x=1739265078;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wHv6bVR1cHAduHzOBPtdl12AxupWPf09/YoJP+NcNq4=;
 b=OijPSTdMgJH3TugNdbmHRDYL0lqpCfOR8AcQNC/AiBD9jiyqYwYqToZdNUnRJihY7m
 aN+ePL8nfrTtIZ/VyldhdEWyeGOusIyuRbn2WLIDPgTzrvxoEkD44IwDUEDP8nDcMhBt
 qG7r5lwsJ+XpJ2ZRmuMdWmgCiuLOk81v39BcxSvunY7tHF6/r94qV3nlWzsgrrwNFRCV
 4FNdlsfl00B/Vu50iXoIekfaI4OqHbji6rK3mhKg6rFDNU4oxpCE2u+tsmrAap2o42U4
 itTO1kfhT8dvimDMDjeETBzihSeYZk4rh/G+C/Hiz875WT+OIVNMZpRAZGVzYh8u6NGD
 c4IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOn+S3au5GWOE08yYfb0dnQWaSvryRiePF5PDkvEUmRC4EpsHX1L6eDgGfVEA6/HWlu3xl1xsHkBwS@nongnu.org
X-Gm-Message-State: AOJu0Yzyh4fsJBk99V/kJWEe1mFwruNrHNFd3mCnoVuxhVt0EPLETUrC
 doiwpmyVaQgsAU97Kv9lvK9XOTKPwCesw8lk3r32GOV+Stx2DR9HEkV998AnRg==
X-Gm-Gg: ASbGnctC5opQKs7sTrKjJ2jpT1hemxMLeq+uBvZR1jqKY/zHSDXXbIWYMXKOgU+/p87
 VijvzmWTMdb5LOxR7xIcvJg0suLx+I5nO+W9k4qgmCT570HxlJaY0ruPOudwmxHsScQqMyHluRR
 WHFNkvppJXmhi5iYXYihwkwB38vZ1L93kPZd/rlBTJ0JskG8ASc6m6YsrwC2VSu+DPtmC2I5JWp
 JvHJkzTW4gzqLbmRHwwCDH/lVxjvjTwfziBJ7hURE94uaaQ03C1ykiYRqQe0sazPR87Vc9JWT+z
 Qb/ZEV8HZ/EBWyK6RAskmu5f+ACYqrN52DZt/tJkzQfcI4p52TOiT5xjT63A7gHHqzGMvfkhyYi
 f
X-Google-Smtp-Source: AGHT+IEQcC3xIpVeK/iGl3mVUJICJjqITTTH6TRzP2xTaraDTtlIC4aKUTm3bZ1eESrhbLQcfs7eWQ==
X-Received: by 2002:a17:907:940f:b0:ab7:b7d:62b with SMTP id
 a640c23a62f3a-ab70b7d06b9mr1364304766b.6.1738660277808; 
 Tue, 04 Feb 2025 01:11:17 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de.
 [37.24.206.209]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47f1e23sm880322966b.82.2025.02.04.01.11.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 01:11:17 -0800 (PST)
Message-ID: <173d18bf-f68c-4bd5-b822-abb1c1f0c51b@suse.com>
Date: Tue, 4 Feb 2025 10:11:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] meson: Deprecate 32-bit host support
To: Juergen Gross <jgross@suse.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 mark.cave-ayland@ilande.co.uk, berrange@redhat.com, philmd@linaro.org,
 thuth@redhat.com, andrew.cooper3@citrix.com, anthony.perard@vates.tech,
 michal.orzel@amd.com, julien@xen.org, roger.pau@citrix.com,
 xen-devel@lists.xenproject.org, bertrand.marquis@arm.com,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <467a5a58-952e-4930-8e91-744eda6d87d9@redhat.com>
 <e40c39d4-425c-4566-af41-373941894045@linaro.org>
 <alpine.DEB.2.22.394.2502031438170.11632@ubuntu-linux-20-04-desktop>
 <e7611136-1e90-4f3a-8f37-68244c22c4cc@suse.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <e7611136-1e90-4f3a-8f37-68244c22c4cc@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=jbeulich@suse.com; helo=mail-ed1-x529.google.com
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

On 04.02.2025 09:19, Juergen Gross wrote:
> On 03.02.25 23:43, Stefano Stabellini wrote:
>> +Xen maintainers
>>
>>
>> On Mon, 3 Feb 2025, Richard Henderson wrote:
>>> On 2/3/25 04:54, Paolo Bonzini wrote:
>>>> On 2/3/25 04:18, Richard Henderson wrote:
>>>>> v1: 20250128004254.33442-1-richard.henderson@linaro.org
>>>>>
>>>>> For v2, immediately disable 64-on-32 TCG.
>>>>>
>>>>> I *suspect* that we should disable 64-on-32 for *all* accelerators.
>>>>> The idea that an i686 binary on an x86_64 host may be used to spawn
>>>>> an x86_64 guest via kvm is silly and a bit more than niche.
>>>>
>>>> At least Xen used to be commonly used with 32-bit dom0, because it saved
>>>> memory and dom0 would map in guest buffers as needed.  I'm not sure how
>>>> common that is these days, perhaps Stefano knows.
>>>
>>> As a data-point, debian does not ship libxen-dev for i686.
>>> We cannot build-test this configuration at all.
>>>
>>> I can build-test Xen for armhf, and I guess it would use i386-softmmu; it's
>>> unclear whether x86_64-softmmu and aarch64-softmmu are relevant or useful for
>>> an armhf host, or as an armhf binary running on an aarch64 host.
>>
>>
>> On the Xen side, there are two different use cases: x86 32-bit and ARM
>> 32-bit.
>>
>> For x86 32-bit, while it was a very important use case in the past, I
>> believe it is far less so now. I will let the x86 maintainers comment on
>> how important it is today.
> 
> As dom0 on x86 is a PV guest per default and Linux doesn't support running as a
> 32-bit PV guest since a few years now, I guess there is no need to support qemu
> as 32-bit on x86 for Xen.

Yet then, just to mention it, you can run a 64-bit PV Dom0 kernel underneath
an otherwise 32-bit distro. I've been doing this successfully for very many
years (with a very small kernel adjustment, just to work around an apparent
shortcoming in system init scripts).

Jan

