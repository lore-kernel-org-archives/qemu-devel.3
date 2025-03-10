Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F0DC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1treyy-0005A7-RY; Mon, 10 Mar 2025 11:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1treyu-0004w1-3D
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:23:52 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1treyj-00019p-TT
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:23:51 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso47555615e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 08:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741620218; x=1742225018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IBr75c6ytYUhwEvF7FkBd0CgtESgZ7S9ZWDGt+QgV04=;
 b=iSEAAbYkNu93b6DzwbqzYCQCY2AgB7Xkz//fvIZQDvWssw0UCkAuEiLQHsxQ5Sl4rZ
 jWx6S17CaU0pmWTAhBTswRSWIx6onpvNlVBv2Qng6408MajPdaHw3DPFOyyhSoxBzxW7
 QI1i0ghywy9qcd1OxU2fhpntVMNbz3Z/Fc4RCSzAQb0ZpkXiKdIXZK2/Dc9iOM9E71XR
 4eYN3j68U6hVI1p/JpXoi9j4Mils6nWtFetnWkZ2g3jiDV0YGIZZySGxfR7f6WAWmt91
 aODMeO76yWrBAR5WqlvIWpsYGM1xNaK3ee1TuJozN7IfiTYFsq5Q9T+yagu81Hlij+Y6
 vZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741620218; x=1742225018;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IBr75c6ytYUhwEvF7FkBd0CgtESgZ7S9ZWDGt+QgV04=;
 b=kj3gh7mSfRrWDvsIG+Hn8WpRTNxOH8CZOgbLeA2YcwRq+467lqPBZZYrQghWqVnyIQ
 PFs7Tx/Ia1lgQKlLx2LEUItL5MGGi5B0e2u3jfny7m0KZLyhGN+smGl+78iP1rmInw6R
 rSjpU2nenhNCQGOZylMO7URG3ZMIizYAPiTWtKaZgedlm1L4vcRNpEJJ9lqe1byhlaa6
 0xPX+C9T1ZZnFM/HRRpToOq13s8zZOo2aTGpvmjvWGMhPikmCU8ML4fhY/HRYeTIdgD2
 0jgTMxrlNKgYcpth1/dTn4SO+Wl3wz8qQhDHGddCtcTPztYqy8xqtXJm365CxaJe46R/
 PHgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGz7PKWvo+xOav+ijwoZdO8y/+FDyYflnvBP6xpXQufOsqytmyI8amQ5i4njINgMCmV78IUMTFi3pU@nongnu.org
X-Gm-Message-State: AOJu0YyvFXU9fDiH5lLtslNnENzM/38HUhPHUC4UIwbXzx+y/KRVqrrX
 cbd9lRl7Cyi2/M+kKaeFYRpq+Cn83EOMywyint3CykfMbGzUJroWZNC3zNK3Nvc=
X-Gm-Gg: ASbGncsVCJHjyGcHTQUSrZ8kvGBxZD1UDqW/ZQK5LTwrCF3/B5E5CgXTq3tyt4hJt3U
 2VOeU3o6RdW8rch0cYGlmnJTAP0kd8g8SfwrKr1DjvuxElwYwCHgcQCn5IJdX3O322TCEvIkw2X
 vZv6hpyfccYl08ZAtGn9OY35Y42rTQpn239mA64hNRdtK/d7ulj3FXL4P1DOt6hnj01qB0qEWs2
 LoWH7xplylHEoWhm6ijYB6pludA4wjYiUanWKHd53ZjGNyUDwJEOYAP+RkWEViETkI/JlXIPm2N
 M0vJbWHzH2I3ZBqdxW//xr2BgZWlLRTHxzz7fcGUlrNaDkXo0ztVDc0cof9JC5sEi7cnygAOxYw
 pykXhXJl4j1E9l7mSu1sHfsM=
X-Google-Smtp-Source: AGHT+IHAV10499kmP8yqAIvnYFZpY+88ERj2RcF7X5uZrwnaq9soz6c1PpTRcxcyvgnk2ZNi6F0Kyw==
X-Received: by 2002:a05:600c:1c1e:b0:43c:fc00:f94f with SMTP id
 5b1f17b1804b1-43cfc00fb6dmr26978915e9.23.1741620217533; 
 Mon, 10 Mar 2025 08:23:37 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2bb7sm15441920f8f.63.2025.03.10.08.23.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 08:23:36 -0700 (PDT)
Message-ID: <13c7e4c3-d5d6-4b56-9d6e-cec50727d3a7@linaro.org>
Date: Mon, 10 Mar 2025 16:23:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/21] hw/vfio/igd: Check CONFIG_VFIO_IGD at runtime
 using vfio_igd_builtin()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-13-philmd@linaro.org>
 <415339c1-8f83-4059-949e-63ef0c28b4b9@redhat.com>
 <7fc9e684-d677-4ae6-addb-9983f74166b3@linaro.org>
 <8f62d7ac-7109-4975-84a2-4a7fa345dd74@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8f62d7ac-7109-4975-84a2-4a7fa345dd74@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 10/3/25 14:51, Cédric Le Goater wrote:
> On 3/10/25 14:43, Philippe Mathieu-Daudé wrote:
>> On 10/3/25 08:37, Cédric Le Goater wrote:
>>> On 3/9/25 00:09, Philippe Mathieu-Daudé wrote:
>>>> Convert the compile time check on the CONFIG_VFIO_IGD definition
>>>> by a runtime one by calling vfio_igd_builtin(), which check
>>>> whether VFIO_IGD is built in a qemu-system binary.
>>>>
>>>> Add stubs to avoid when VFIO_IGD is not built in:
>>>
>>> I thought we were trying to avoid stubs in QEMU build. Did that change ?
>>
>> Hmm so you want remove the VFIO_IGD Kconfig symbol and have it always
>> builtin with VFIO. It might make sense for quirks, since vfio_realize()
>> already checks for the VFIO_FEATURE_ENABLE_IGD_OPREGION feature.
> 
> I have explored this option in the past and it's much more work.
> Stubs are fine IMO, if we can have them, but I remember someone
> telling me (you ?) that we were trying to remove them.

We shouldn't have target-specific stubs.
(currently CONFIG_DEVICES::VFIO_IGD is target specific).

I don't think we can avoid host-specific stubs.

In unified binary, CONFIG_DEVICES disappears, VFIO_IGD
will be handled like host configuration. Although if possible I'd
rather remove VFIO_IGD, unconditionally including all quirks.

