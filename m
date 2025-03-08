Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFD0C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 22:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr2i2-0006ft-4q; Sat, 08 Mar 2025 17:31:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr2hs-0006eB-Sr
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:31:46 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr2hp-0007TN-RI
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:31:44 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso2461404f8f.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741473100; x=1742077900; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B8Rlp4V6S1t7oJktJmT4N97/Nig9UKhKh3NovYXeL9Q=;
 b=p53yGG3Dm2Kz+xbTVWgACAHeqBpYH1JIuCTe2aoXMNo+VjCO2FG1VgOUeT6B9KQsqc
 b2D4uRUPB9hKpimlz2CiaDeJMvbHonSWVACnrjh9OpQ9h+cpqY6pPAx2g6s9dUxMLUL1
 IJQTBkW7clOehWpPDQhqNlBG/SgsK1fdJUaqYz1S3Ev8eFzTNyR1PHwuanbrgA/n48r0
 j9OskyLqoqwQEovU5wkZX3pmMB/RzrIbXma9OMc8lnJnPTkpGhQIvH1xSAXMay+8ZRpo
 /QqP7g41+dTyzN3F6MaycuEqiq4jcN+fS7lK7dhz7/EFelxW4n5LON1Kb/9Plsntjdlh
 V6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741473100; x=1742077900;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B8Rlp4V6S1t7oJktJmT4N97/Nig9UKhKh3NovYXeL9Q=;
 b=APfxQYBoxH1ByiObcKnVZzkYQ6XRgm3Z7ahVYtlTEfHfy4JrPGHDBqReF6SgR1liap
 xAT+l44ExLx7sLubWqEl13gvU5NvURKL89BGJycpJl122c9JRqFLRcqMZyKc+oTIpe/M
 9UJ1p8jmXmZ4JovI/PTac6GkoWBflrf2Q8OKAghMYSm9u3d8gKjeBuYUczljudGsibNi
 mIydQHezwkyQk0ql55j2BMnNiIEIfoR7WPYih2UrsLY0uVxzeIkpCIe59D7zWjQD2jFv
 60YAUp596utgGGXOBPxQJgW2M2MvaWvTfSdkWAU8qKs+cFCWm62g8lDb83vbP2W8FSDf
 dRqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHphxaoUl7hllCeeUanNwJTAIRduhyDbW76EyE4Ej/dq0Sz0vIc/gNzMAcxQGu4SlhYHBn81PjVltM@nongnu.org
X-Gm-Message-State: AOJu0YxQ+G0mixUCaGySS25NP9soQ2xehMJ0AOXVzhZ57gRu5yhxPcTF
 lm38owl5aNP8hmOvGcC3lMHqgCguYO/QwJpJUYwCuotwULyNuDTVQm161WDidbs=
X-Gm-Gg: ASbGnctmhb0KVFTiKAa/2pu9xG8j9Zr1RUKBwdzsPyv4m4i3/0N7gzaUdyM+KNdXwhW
 yUaRds78nWDQcjtlEXL400bfdMRc+8tMIaQbfWI84ZDstK1LuH/T33RlgT+f/Jl8okqGGpUhusr
 BjbD+rg4fQHPkyjK+C1QCAMrBjbCnkGDGruHDVLk3eQnHgZO9uSTudHi8ovYeScnRk5YFbqKWmg
 we3oIjdf7rfgV0tJUWH7wagIgi6cP0wjeVK1Qb4FvQVrjdDptH2/zOSMbJcFueDb59HqwZTvkYD
 g2A/SSij/7sp8GEaO22HP0IYPILVpiKPzHSjhKUJNOyf8NsdmDgRPdp1uO8eUCK3A33ZhqRUk7G
 XRN4VOz5NxzRY
X-Google-Smtp-Source: AGHT+IEUyp5zyLW4DlZ5XMw4Rz/AB1UhVYoOBt2PmhgSGnUVYhH1w2Daq730E4oLE2cx+AX3j4HjzQ==
X-Received: by 2002:a05:6000:1549:b0:391:3291:e416 with SMTP id
 ffacd0b85a97d-39132d69868mr5082979f8f.19.1741473099723; 
 Sat, 08 Mar 2025 14:31:39 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfba9sm10244185f8f.39.2025.03.08.14.31.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Mar 2025 14:31:38 -0800 (PST)
Message-ID: <9598e89e-b5a3-4abf-aca2-14652f541b34@linaro.org>
Date: Sat, 8 Mar 2025 23:31:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] hw/vfio: Build various objects once
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20250307180337.14811-1-philmd@linaro.org>
 <180f941a-74ce-41c0-999d-e0d4cef85c3d@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <180f941a-74ce-41c0-999d-e0d4cef85c3d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 8/3/25 18:48, Cédric Le Goater wrote:
> Hello,
> 
> On 3/7/25 19:03, Philippe Mathieu-Daudé wrote:
>> By doing the following changes:
>> - Clean some headers up
>> - Replace compile-time CONFIG_KVM check by kvm_enabled()
>> - Replace compile-time CONFIG_IOMMUFD check by iommufd_builtin()
>> we can build less vfio objects.
>>
>> Philippe Mathieu-Daudé (14):
>>    hw/vfio/common: Include missing 'system/tcg.h' header
>>    hw/vfio/spapr: Do not include <linux/kvm.h>
>>    hw/vfio: Compile some common objects once
>>    hw/vfio: Compile more objects once
>>    hw/vfio: Compile iommufd.c once
>>    system: Declare qemu_[min/max]rampagesize() in 'system/hostmem.h'
>>    hw/vfio: Compile display.c once
>>    system/kvm: Expose kvm_irqchip_[add,remove]_change_notifier()
>>    hw/vfio/pci: Convert CONFIG_KVM check to runtime one
>>    system/iommufd: Introduce iommufd_builtin() helper
>>    hw/vfio/pci: Check CONFIG_IOMMUFD at runtime using iommufd_builtin()
>>    hw/vfio/ap: Check CONFIG_IOMMUFD at runtime using iommufd_builtin()
>>    hw/vfio/ccw: Check CONFIG_IOMMUFD at runtime using iommufd_builtin()
>>    hw/vfio/platform: Check CONFIG_IOMMUFD at runtime using
>>      iommufd_builtin
>>
>>   docs/devel/vfio-iommufd.rst  |  2 +-
>>   include/exec/ram_addr.h      |  3 --
>>   include/system/hostmem.h     |  3 ++
>>   include/system/iommufd.h     |  8 +++++
>>   include/system/kvm.h         |  8 ++---
>>   target/s390x/kvm/kvm_s390x.h |  2 +-
>>   accel/stubs/kvm-stub.c       | 12 ++++++++
>>   hw/ppc/spapr_caps.c          |  1 +
>>   hw/s390x/s390-virtio-ccw.c   |  1 +
>>   hw/vfio/ap.c                 | 27 ++++++++---------
>>   hw/vfio/ccw.c                | 27 ++++++++---------
>>   hw/vfio/common.c             |  1 +
>>   hw/vfio/iommufd.c            |  1 -
>>   hw/vfio/migration.c          |  1 -
>>   hw/vfio/pci.c                | 57 +++++++++++++++++-------------------
>>   hw/vfio/platform.c           | 25 ++++++++--------
>>   hw/vfio/spapr.c              |  4 +--
>>   hw/vfio/meson.build          | 33 ++++++++++++---------
>>   18 files changed, 117 insertions(+), 99 deletions(-)
>>
> 
> Patches 1-9 look ok and should be considered for the next PR if
> maintainers ack patch 6 and 8.

OK.

> vfio-amd-xgbe and vfio-calxeda-xgmac should be treated like
> vfio-platform, and since vfio-platform was designed for aarch64,
> these devices should not be available on arm, ppc, ppc64, riscv*,
> loongarch. That said, vfio-platform and devices being deprecated in
> the QEMU 10.0 cycle, we could just wait for the removal in QEMU 10.2.
> 
> How could we (simply) remove CONFIG_VFIO_IGD in hw/vfio/pci-quirks.c ?
> and compile this file only once.
> 
> The vfio-pci devices are available in nearly all targets when it
> only makes sense to have them in i386, x86_64, aarch64, ppc64,
> where they are supported, and also possibly in ppc (tcg) and arm
> (tcg) for historical reasons and just because they happen to work.
> ppc (tcg) doesn't support MSIs with vfio-pci devices so I don't
> think we care much.
> 
> Patches 10-14 are wrong because they remove the "iommufd" property of
> the "vfio-*" devices. We can't take these.

I suppose this is due to the wrong implementation of iommufd_builtin()
I mentioned in patch #10, which check instance but not class.

Thanks!

