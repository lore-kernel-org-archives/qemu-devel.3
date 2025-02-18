Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51769C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQpn-0003oi-9f; Tue, 18 Feb 2025 11:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQph-0003mT-E6
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:52:29 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQpf-0003tk-TY
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:52:29 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4396d2e32b7so26004575e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739897546; x=1740502346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wgQIXygvM+I2a2L+051aRwgTFxhuGIVIJLESI8PGuE0=;
 b=DSH0FOdSqbyHDMiYRSVYByUESDKdhcvRUG80KHuvJjqSE6x9jbQ8L9w+UWqoOUeOiu
 R26rbOxMZtXmaKOj89fwSdmEpCA/87jCrX5IzyrBdTQmhN8c8zpX5h3eRRZUT2DSzFOY
 oNhlDraBMFhPwr4akotSyRcrdQ5Zokm+q+jZqgNOaEUJdMkDnvokmrsGJEQmSdhkqWfF
 hRUCr1YvJEyXqAThUNIxhknhyOk/BExG4EDBaK6LBzLuPnOTjfXBxkW8zHtdyTWKOL2+
 ork6i4CH8kiVO9C5+uuTOKR/tJcKBIRcgOCQdY7eY5O5Ck+BVJ2RgnCQJucciqxGGx+R
 ix6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739897546; x=1740502346;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wgQIXygvM+I2a2L+051aRwgTFxhuGIVIJLESI8PGuE0=;
 b=HSv6vK23fjQ1mCTlrC39ySJluvTHlpmCHpaJL0HhGGHvSy3PywafOyUEUmOiOOphWN
 ko+UzDe32+hSjYoGtuqcq8evz/Ac7/ivUQk1RR2sCKfGPPimCnRR04zQY6Ey5bpJOgrQ
 rA/awfp6ZYVtMlF0XT4P2xUJzChqVdxYKJ1jRd92HeJz2G1jiwt0ByP7HDZ6Jd83LO5J
 Gqk/6Y9TQb5YgPdWli3V5giK2pImaifOebVCUYkZFBrZCLyyBzxcOSvjtPr9mMeex5zR
 45v8bA+BVWpsF4kOQGLGRmQiMJo4Q4EO7W3JbLs/QSLCKhUorzFqVvP+Tj2fWuuN1grM
 +jQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQeoKjm5hUhp+bFrsv6t/IvNBdwdYs9FMtIONBZrjOB/SgqaOldqjzZJM/hT+dKinXT6gijNcjfOYw@nongnu.org
X-Gm-Message-State: AOJu0YyQ3XXyYWQfpG9tzucYH4gYOLVXUOjw15xodoaUkXzg7t4WUa3v
 QsmH895b1hFBDOlseH+RdNkN3S6MEUl2etG78Rxbx5vuqcS/0P1Sdo+P8hkMwnI=
X-Gm-Gg: ASbGncuNki9Hu/r8TbH64ZdGGEZyOepBr8u4rtf7t1sQGWS1CrfKnJEKUhFwfpbhh0a
 cYhVh5ELATMl8iK1GwKIZ5pLXdxx+llkmvGcmg+xlD7zsiF2SzKYq8zCk2CT4BgSkEgYUcw/wOr
 fyaZL8PQleRhSPbqvghBZhbXW4XjracLTZFNSAqQZQB1sLg4Ae1zdxodSfjbzKRmF2lNSOtAlNQ
 C4mmdCiQL+q5AYenAC1wOJVy1TAjUPZtYWoSGSaqYSjia4ye4992LBPGqQSp2znvPBNnVp/tl0i
 VhLz8FLGg3pdN8MiJlIZoKOvRcGc37z9XldoHBFEgD0BrNXQdFikC/eF+MM=
X-Google-Smtp-Source: AGHT+IEauRg6jm/6Zg3iaAKDUti4KhDizMeNwByTlQcDkm7QS+RI8vivWo6R5S+GGnG2fUbs6TEWeQ==
X-Received: by 2002:a05:600c:3d0b:b0:439:88bb:d02d with SMTP id
 5b1f17b1804b1-43988bbd322mr62595755e9.2.1739897546069; 
 Tue, 18 Feb 2025 08:52:26 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398e84efb9sm38355465e9.10.2025.02.18.08.52.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 08:52:25 -0800 (PST)
Message-ID: <3f1387aa-3f8d-4f46-8370-3668ebcbc4ec@linaro.org>
Date: Tue, 18 Feb 2025 17:52:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] hw/i386/amd_iommu: Orphanize & QDev cleanups
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Wei Huang <wei.huang2@amd.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Ani Sinha
 <ani@anisinha.ca>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230313153031.86107-1-philmd@linaro.org>
 <a2af5477-d124-e8f7-32e3-1b194769bf2e@linaro.org>
Content-Language: en-US
In-Reply-To: <a2af5477-d124-e8f7-32e3-1b194769bf2e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Hi,

 > On 13/3/23 16:30, Philippe Mathieu-Daudé wrote:
>> Following [*]:
>>
>>    "Last time I tried AMD vIOMMU it didn't even boot."
>>
>> mark amd_iommu as orphan in preparation of deprecating it
>> (or should we do that directly?).

Almost 2 years passed, should I respin?

>> [*] https://lore.kernel.org/qemu-devel/ 
>> CACGkMEtjmpX8G9HYZ0r3n5ErhAENKhQ81f4ocfCYrh=XoF=5hw@mail.gmail.com/
>>
>> Philippe Mathieu-Daudé (6):
>>    MAINTAINERS: Mark AMD-Vi emulation as orphan
>>    hw/i386/amd_iommu: Explicit use of AMDVI_BASE_ADDR in amdvi_init
>>    hw/i386/amd_iommu: Remove intermediate AMDVIState::devid field
>>    hw/i386/amd_iommu: Move capab_offset from AMDVIState to AMDVIPCIState
>>    hw/i386/amd_iommu: Set PCI static/const fields via PCIDeviceClass
>>    hw/i386/amd_iommu: Factor amdvi_pci_realize out of
>>      amdvi_sysbus_realize


