Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B7EC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 11:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4epp-0002Id-My; Tue, 15 Apr 2025 07:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4epn-0002Ey-L5
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 07:52:11 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4epl-0002eb-G4
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 07:52:11 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso41471885e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 04:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744717927; x=1745322727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Cvl5HH4D+Fe1QVhhJtnY+0TeqveIq0ahL+Rvcq+T7pw=;
 b=F02mjAFqlIIwJf25V9Lj+ITk0ZF/e+HVbzfcG72iJuk9paL2os04OOReT2ECZScFeL
 J3BLX/Vl3RjNzGvqNYdbXmAk7Rij48KqR38/4+tSdrgsfWHc40wp2NVLD2v5YKzxLoji
 Nwe7OvPQQ7NmA0S8/yxY8V4NWzVs1WJWPwYCmfLjCtRoXHOf9OR5m6yoos+Qeqq33xv8
 rkxrBYrMNcK9COVnacH59FFcqaAho1ZBwwuA07tbHEHu8X1Id0pByDhw7YqeZM5zqgj0
 1aaGgSwqHHWdn4jydvakUqNKHrcPKKl75v5+J/vgcagjYBpWQatll/PZ74MpAbn0b7Ye
 WBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744717927; x=1745322727;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cvl5HH4D+Fe1QVhhJtnY+0TeqveIq0ahL+Rvcq+T7pw=;
 b=J/o81q33aEO81Eeb6bwNIT9LnBH+7oe03UbG8beqONH0DwvPxNbt6zl1s1vyIiY1QL
 9wrGrTrEpgZemCm7b6ZU9EhpLdlIDQ/ZziIOINlDaYw+2Wunzte3aEJ+mHFqdV55TxNl
 TEFJtW8gmqE207sVPKb+WGGAw10ph9qoqw0ywRBnwbkyN0iI9Yg3m77xL2pdGSgnQgu0
 08PwGyjSB+HOZE9xlgTzwqmUkZErL6z+zw5X9Zn3Vm4a2K70BCX9b0rh9L/sd0B8xAlw
 GnrpmzIbUvFx36WkhI2WidG24sS5CcxsnEgGp6Ut50Uk6WlWy3h8OBGsHRlTti+LcfRM
 l0bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs2UOFhI9YWc/9/NmNDYz2wmG1ryxXtMHdim7yY2S/d+6NzwecEhDmf05bXYNEKO9i7gXD3e9Jdn1b@nongnu.org
X-Gm-Message-State: AOJu0YyAh5cXEvsOEekaL9aUly8Z2r2ADdASn6m7eiIpBppky6H7p80P
 gCqPpBwboo4ZQTg+4Ovri/43Q/rSfo0cFJwkmFI5HoGxHD7l1gSLImGICbSK/+vVGSsYX9rL/5i
 e
X-Gm-Gg: ASbGnctemfvUEzDtXpnSxcQLkLvEQ+oGiOs48ILe6WdRShOQ0qAhtrSF4h63ZCQ/12V
 mJh7/5sEd2RnQJROYlNzaD5QeEVW3BSpbWIje5vN7nUEChRJgL1pKJMvCv5QN2iCYgluVGZOF1C
 QXMwNj74XR8tq3C3pzehriQsGk5o/MSEf3/uccr+uv3XrJzEHBRGiQDotRJoHvN7Ly4lZ4cWLdI
 eyqeZ/NWIagiGyTSNC4yzFawDhopuEEbzL3EphcATDMk6o+7aMifV7WQ/g4sPAVQhAYJiY3OtP6
 zJyDeez46KhrX2bDFlig1zh63T6E/DkWoYoP/YvyUi7mAz2hXfsGJtWgP9VdLEJEsl6+3Mh7tVq
 0OA343Jp8Yr9Ltw==
X-Google-Smtp-Source: AGHT+IHFFvLs8E9YbOXmXHLuTGCHivS1MvWE2S0IVvjVxHjOl4gB21rfF+SyejihxzBZNQFyJT++JA==
X-Received: by 2002:a05:600c:810b:b0:43c:fa0e:4713 with SMTP id
 5b1f17b1804b1-43f3a92620dmr147421495e9.2.1744717927448; 
 Tue, 15 Apr 2025 04:52:07 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae963f4asm14100576f8f.16.2025.04.15.04.52.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 04:52:06 -0700 (PDT)
Message-ID: <13c26e20-fe4e-4f91-9423-93704cc1f6b7@linaro.org>
Date: Tue, 15 Apr 2025 13:52:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_iommu: Take the bql before registering a new
 address space
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
 <c6f8ace8-6dfe-4ca7-992c-2fd10faa6127@redhat.com>
 <5e993b14-d94f-46cc-a6bb-b6f0c2057f2b@linaro.org>
Content-Language: en-US
In-Reply-To: <5e993b14-d94f-46cc-a6bb-b6f0c2057f2b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 15/4/25 13:49, Philippe Mathieu-Daudé wrote:
> On 15/4/25 11:30, Paolo Bonzini wrote:
>> On 4/15/25 08:18, CLEMENT MATHIEU--DRIF wrote:
>>> Address space creation might end up being called without holding the
>>> bql as it is exposed through the IOMMU ops.
>>>
>>> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
>>
>> Please use a separate lock instead of the BQL.
> 
> There is already a IntelIOMMUState::iommu_lock with
> vtd_iommu_lock() / vtd_iommu_unlock() helpers.

commit 1d9efa73e12ddf361ea997c2d532cc4afa6674d1
Author: Peter Xu <peterx@redhat.com>
Date:   Fri May 18 15:25:11 2018 +0800

     intel-iommu: add iommu lock

     SECURITY IMPLICATION: this patch fixes a potential race when
     multiple threads access the IOMMU IOTLB cache.

     Add a per-iommu big lock to protect IOMMU status.  Currently the
     only thing to be protected is the IOTLB/context cache, since that
     can be accessed even without BQL, e.g., in IO dataplane.

     Note that we don't need to protect device page tables since that's
     fully controlled by the guest kernel.  However there is still
     possibility that malicious drivers will program the device to not
     obey the rule.  In that
     case QEMU can't really do anything useful, instead the guest itself
     will be responsible for all uncertainties.

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 032e33bcb20..016e74bedb7 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -300,6 +300,12 @@ struct IntelIOMMUState {

+
+    /*
+     * Protects IOMMU states in general.  Currently it protects the
+     * per-IOMMU IOTLB cache, and context entry cache in VTDAddressSpace.
+     */
+    QemuMutex iommu_lock;


