Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE87E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 21:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUuLB-00052c-TC; Mon, 06 Jan 2025 16:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUuL9-00051e-Oo
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:08:47 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUuL6-0001mm-R6
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:08:47 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso102160295e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 13:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736197723; x=1736802523; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dt1f81EVsgW5OvATu4Z5FjJ0Vm5UWbdIlHsy1CTjJ6o=;
 b=Et3Q8kBHmpMr45jUJb+mG9U3WF/0K0w8jUhcLcbvxN5gS8zaweX9UVRiHlG1ew8dXe
 pVS+vWLLU3URfQ7EjYcTNf7PqKFh/z6J7Tnp1RVorjWIhZYHzo6Xd0lC5YYtWqG4faxl
 9Emnl5pVhNHmab/dQpU0h5cuW7uiYGCLOVQAROd1+jXdmRRhDp84SGHr4hl66FKIganH
 xDUQFmL/WKlGBoyApzhRzQgximWDk1y/QTsCPPmwRH1yMnDagAcyCBAx6GxxegjOprPI
 u9yZMlsB7r0uHBBhOny35yDg4fuMQOTKQdH/ZTwRrPG/UjwNxDs5sSQ+D+Hotb/JD6kD
 epOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736197723; x=1736802523;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dt1f81EVsgW5OvATu4Z5FjJ0Vm5UWbdIlHsy1CTjJ6o=;
 b=aX8heF5pNOE41X/AwdyjwSJzQdvukz+QXg+XgkPbgm6VC/4H7UehkQaERgdbJn6Q+K
 mZvLBGKkqti3GHKFm5BvFjjviQ2kvM6DXY04/xoBtVczZeZmXHPV0ogYfyKLr/kTs82A
 25DPiIbTicuMzawMfZv07tVfr+zr/gij0iZ0vl6ZtS+tEsuawYqYq3mrYnIVjKIIngX5
 185reC7cTcqfSPqJAk8XhiX1WUZIHXl4RpIzj1he+0QudULq0HCglW7pZ1YH76ULCLBf
 NC2X2Tf4ZXB7LPIIn3k+MdB5z/mTeFrxcgvFIJmv7Qb8hA3yyGFRwdhmpaEbyQky4ELk
 xgPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZln7SguH29amii2aV7+6BjZChK2J3uPz7AAkIJe7soQV3piuUJBmVw6G5Gds7yH9it6DzeICFQbug@nongnu.org
X-Gm-Message-State: AOJu0Yy6PKjC/K/K4sVR8FBDT121eNwOs+3B9ol1UYbMYLnMyaWoFMpf
 TabQlwIAAnyuRZsE1lbnYU9E/Cbn14iwUIZErpzqRvZBlNzGRvuOUVBOnFjhb7w=
X-Gm-Gg: ASbGnctyYLKRaxBhPLOK1Vvgk1m9QeStygRNOFTPuibgwvRhShrbItMtKogFL1L+DF8
 skO3huserK/ntZqTDXKW3vYEm6M2m1LHNjxf7LxmTvpj2JOUdPbkw/gZHgf7PV+2dfFfU5DOEv/
 Vpqoje5dF/Vi7ljaT6+7u3y20HWkmEdI+6Rp02YbQ0qeKuV4YmnyN28hcTNXQQGk/79TFHLgL+m
 CBzJ6tGE4OZTeR1y2Y7sxUufhrIeeXpm4uHV1q2vn+AkQLrCTRhVg2oytaSeJS0hG+T4SMIZ7oH
 0QsHyINItz1k8/kAiD6rPYYI
X-Google-Smtp-Source: AGHT+IHQlDMHE5yzCDH0asXIjYrH5p/B5ofNz91YmLcogyERBoJ0h4sXot+iT1K99vchhPpxIvHj0A==
X-Received: by 2002:a05:6000:188e:b0:385:f840:e613 with SMTP id
 ffacd0b85a97d-38a223fd52dmr44054103f8f.51.1736197722710; 
 Mon, 06 Jan 2025 13:08:42 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e528sm49330255f8f.83.2025.01.06.13.08.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 13:08:42 -0800 (PST)
Message-ID: <6df59c2c-e29d-4b86-8908-4cb9093bad13@linaro.org>
Date: Mon, 6 Jan 2025 22:08:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/7] accel/hvf: Use CPU_FOREACH_HVF()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Alexander Graf <agraf@csgraf.de>, Paul Durrant <paul@xen.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>, Anthony PERARD <anthony@xenproject.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, Zhao Liu
 <zhao1.liu@intel.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 David Woodhouse <dwmw2@infradead.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anton Johansson <anjo@rev.ng>
References: <20250106200258.37008-1-philmd@linaro.org>
 <20250106200258.37008-7-philmd@linaro.org>
 <bd8168fe-c774-4f75-8a94-1a67ec31e38d@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <bd8168fe-c774-4f75-8a94-1a67ec31e38d@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 6/1/25 21:33, Daniel Henrique Barboza wrote:
> 
> 
> On 1/6/25 5:02 PM, Philippe Mathieu-Daudé wrote:
>> Only iterate over HVF vCPUs when running HVF specific code.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/system/hvf_int.h  | 4 ++++
>>   accel/hvf/hvf-accel-ops.c | 9 +++++----
>>   target/arm/hvf/hvf.c      | 4 ++--
>>   3 files changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
>> index 42ae18433f0..3cf64faabd1 100644
>> --- a/include/system/hvf_int.h
>> +++ b/include/system/hvf_int.h
>> @@ -11,6 +11,8 @@
>>   #ifndef HVF_INT_H
>>   #define HVF_INT_H
>> +#include "system/hw_accel.h"
>> +
>>   #ifdef __aarch64__
>>   #include <Hypervisor/Hypervisor.h>
>>   typedef hv_vcpu_t hvf_vcpuid;
>> @@ -74,4 +76,6 @@ int hvf_put_registers(CPUState *);
>>   int hvf_get_registers(CPUState *);
>>   void hvf_kick_vcpu_thread(CPUState *cpu);
>> +#define CPU_FOREACH_HVF(cpu) CPU_FOREACH_HWACCEL(cpu)
> 
> 
> Cosmetic comment: given that this is HVF specific code and we only 
> support one hw
> accelerator at a time, I'd skip this alias and use 
> CPU_FOREACH_HWACCEL(cpu) directly.
> It would make it easier when grepping to see where and how the macro is 
> being used.

I find it more useful to grep for a particular accelerator, or for
all of them:

$ git grep CPU_FOREACH_
accel/hvf/hvf-accel-ops.c:507:    CPU_FOREACH_HVF(cpu) {
accel/hvf/hvf-accel-ops.c:546:    CPU_FOREACH_HVF(cpu) {
accel/kvm/kvm-all.c:875:        CPU_FOREACH_KVM(cpu) {
accel/kvm/kvm-all.c:938:    CPU_FOREACH_KVM(cpu) {
accel/tcg/cputlb.c:372:    CPU_FOREACH_TCG(cpu) {
accel/tcg/cputlb.c:650:        CPU_FOREACH_TCG(dst_cpu) {


