Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B32CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9khc-00012Q-Pr; Fri, 17 Oct 2025 09:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kha-000126-G8
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:41:02 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9khV-0001hk-1b
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:41:01 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e42fa08e4so18126055e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760708449; x=1761313249; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=icNqRkYDJRAB6RHr00zHh3bYRCOwkWInq2ZlFKNfHLg=;
 b=ywat3rq8wBxY1/i3M6m15NvZFjQGunmft0Q5NPURAmjuiJmGekzBWI0nSinxzpHUwD
 CRlYqmnqUZkpJL1Tgf9WZTdBlmIw1AlrORWjnRFW4XFiOBo5DGWA8KNBz7rTOEJU1iys
 nCuhTGJXfyEUZIsLBmYJvsplV/uYtNCd4Rel3JVULohHfWcmZ7j34JhMrSjKTc20GVnt
 wrabCSnoYFpEoXj7ambckI43RCLuOfDMzbI4YIoSh0wnrJvXPklC3E/bSmCVwtFSh47V
 td5hknom5wbrMapeuXPcEMtlk9tq/mCOvshSHm3arfTZG8HFMu/Wie23A8hs4+Tn2uIM
 ryQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760708449; x=1761313249;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=icNqRkYDJRAB6RHr00zHh3bYRCOwkWInq2ZlFKNfHLg=;
 b=FpI8xJN7CHMOPBZzBzJJ98QgQ1TdHej+wv09pRROuWh30XiF4BeKE++V5aQuqwZbwu
 8YqLJIwyG0WoJZFpsCMZ4cc3hmPNzz1TtqWF0P/YpWhoCEfaBDllNTes5Ij8XGLqHOMX
 j4EiX6JSSh1NyAlAexJHQxZDLtUmQSuAJQFDwqmSzQcSEza7hzKTSz21LHGobb1aF0FA
 TIqcoMEzm4GIIfcnDKWqpObBcXvgc1PabcJRmvtKaFZpcFPhabD/SlL7IRWfD+clKpjS
 BlK1eu4hQlgo0U0Ske62BxAgIB9oshPZT2Y3WHRKOCyxSxAFgx4boMoDUL8AZMooRI9s
 wXbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX//eaiEWaHeQSUxPxsfkg4et/A5YNeW0kyx4EdbcsW5cFDtbz6mwnhUO8AXk9IX+BN5+AbVV5DN+EO@nongnu.org
X-Gm-Message-State: AOJu0YwXU/3L2y5ir7ZIVwCLAP+a/wj+yzJBNPeVzAnOIlF+ttVGd+Hy
 e8oUMgqL8ktzRVemJiUXZ2pgok8J2z+b/TFOiE2M/r3CDDWF/R0MjshQfGjcAjrUpTg=
X-Gm-Gg: ASbGncsDcM5fOySkpxu9xnhuZIW05adFG/RX03URujFtPv5DSP0tqXw3ZIx5AWY+Wjb
 sjCMWiKUKwmJRjiE8Wa8O49j5YX0teqO1fOmWSOJ8vTSFslHQPDCTF7v4ULQI7e4zpUZotlsypT
 8DPVZ0YkSkLB+EOlEGhu6f2WMs3dh9dNlY3Z2B/n/C6PDvif83xyyBO79ty4Fkt7yuCDfM4pT3s
 5Nmk2pwN2FYWC0sU7Q/Esz0yBNPXiYBdVzKTrai5T8+3eZRRYzrzYyb1VCpD6iDudxns9dVloDZ
 HhoYJ2P1LMXQRD69pQRZp/usQxHkAUSus+4nvRYrKkEaMU8UHAsz9N90LKeW7rf12+iyzcJCR04
 PtDcB8XlFVDr9uL2HE3ZcieetRIpS7vLFBJTo2frN/9LCq46SQdQQivYWQ1iyaIkMNUpupWoxap
 hOVTTL4A/BTY02eRQYdaiSoHwQhONBVJxjumJDkLMpEeK60N2Fx85CKg==
X-Google-Smtp-Source: AGHT+IHwE0d71v5wCkaVJaRIBovj3dj6VslZKSGY8OpKKfJGG8NC2q9yp7kZIPDXZXwQmZ0JZsNrog==
X-Received: by 2002:a05:600c:8b66:b0:46e:428a:b4c7 with SMTP id
 5b1f17b1804b1-471179120ccmr28595485e9.23.1760708449543; 
 Fri, 17 Oct 2025 06:40:49 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42708bcea1bsm2765910f8f.14.2025.10.17.06.40.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 06:40:48 -0700 (PDT)
Message-ID: <dfe5b374-4674-4cb4-8adb-b00f8e67a03a@linaro.org>
Date: Fri, 17 Oct 2025 15:40:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] hw/s390x: Remove s390-ccw-virtio-4.2 ->
 s390-ccw-virtio-7.2 machines
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
References: <20251017133002.61410-1-philmd@linaro.org>
 <edfb9f1f-b375-4295-8e61-0b86bf5818b5@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <edfb9f1f-b375-4295-8e61-0b86bf5818b5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 17/10/25 15:38, Thomas Huth wrote:
> On 17/10/2025 15.29, Philippe Mathieu-Daudé wrote:
>> Remove the deprecated s390-ccw-virtio-4.2 up to 7.2 machines,
>> which are older than 6 years. Remove resulting dead code.
>>
>> Philippe Mathieu-Daudé (12):
>>    hw/s390x/ccw: Remove deprecated s390-ccw-virtio-4.2 machine
>>    hw/s390x/ccw: Remove SCLPDevice::increment_size field

> NACK.
> 
> Being deprecated does not mean that the deprecation period already expired.
> Please re-read the paragraph about machine deprecation in docs/about/ 
> deprecated.rst carefully again.

Yes, my bad, I misunderstood the '-M help' output.

Still, please consider the first 2 patches (4.2 is over 6yo).

Regards,

Phil.

