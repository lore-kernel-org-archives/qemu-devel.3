Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FB7D2C546
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 12:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3E49-0000du-1j; Tue, 22 Oct 2024 08:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t3E46-0000dW-Js
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:32:46 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t3E44-0000WH-Sk
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:32:46 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e2c6bc4840so4086426a91.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 05:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729600363; x=1730205163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T2BBSawxJb9hvH5HcLsQ7yerA09YYQcV6F8+v48uPAM=;
 b=JBYjx4DRdS9LLteCVfjoZ9x1cCsAO/XEn8IvboPHjh+1dvzZdnjwKJB2VNHsSkOeN2
 voUA70C1pxSQBnB66BhnyuOTuSsq+mp0NDPNrdx7cJVbfFe4PPai3atxdhdo1MdtJM6E
 2k8EPeNPo78CNb0oy0FdiFlMZL/VT/wrMs534SlwbpzcZKWeYO4/xJdqaGVRIUTB7wCw
 ocXM7F8RE+wYNrDiVG49bECGjL3dNXBZ7pBi6r0CghkDK5T85Y3cWXtfQocWnK3SJhk5
 dFtsH3qBJvgCFbVAIdELONwXCglsar3EeCqSrQF5I1BJ1XPS0HZ7fCppTjbJxtFubGCn
 ocyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729600363; x=1730205163;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T2BBSawxJb9hvH5HcLsQ7yerA09YYQcV6F8+v48uPAM=;
 b=mifc9tq/G0No1+adwOYi6BWgBVLdE6uHXyE64KY/6/jnhdR1DHgOXXFH3QMf40GrBE
 yaDgpsrb2qjf3zHtfbcnEt0wPX1AgAarmU/VQNNdqYEYLeacXOkBkywlYmu5oMbJGl2z
 LfkLRJE+1E4oJItlxHAa2nbf98eS+St+1XNQOh71b4QQHQTuPuCD4xU8QfsI4XU1v7U/
 pi/yF7y3OTJQVsFf+OkmYhNzCaVCuHneN2O0CVILu4j1dLJwY5Ljw5Qn3k0LLD9o/bsx
 eYOTpP/cCqghvlVGGq5dSPsmxvJdb2y0hSDdkzrE4SS34lVrHOC9Q57GbFzoX0aVyOui
 PtdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlmZACRg/MlZs6d2D6z1mZPDAWqTPPG86eBDvs8r5/36L+5411uJEviB40phVuW6U5CsfBo6wBh36O@nongnu.org
X-Gm-Message-State: AOJu0YwRFXf3vEckcHRwOumuUVshBqoltYZc5aiNaWkhp69RmGvXuzak
 C6Zukhjt89spHc9CkZzVx+NopCx95al3agcIMJ9rA7QycJHzHFSMo3dt09lvySg=
X-Google-Smtp-Source: AGHT+IFQDi3FmXrZuTZSlpLc4z4MNYr+WYGVBJnSyKJNjp5/TrBV+I32+lXjr70S4NS7ID3HwlUv7g==
X-Received: by 2002:a17:90a:4e06:b0:2e2:e937:7141 with SMTP id
 98e67ed59e1d1-2e56172bb5cmr18409147a91.20.1729600362726; 
 Tue, 22 Oct 2024 05:32:42 -0700 (PDT)
Received: from [192.168.0.102] (200-207-104-238.dsl.telesp.net.br.
 [200.207.104.238]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad25caf5sm6077581a91.8.2024.10.22.05.32.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 05:32:42 -0700 (PDT)
Message-ID: <83ed8630-3d02-43b7-a908-be49f19d3d31@linaro.org>
Date: Tue, 22 Oct 2024 09:32:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 0/4] Arch agnostic ACPI changes to support vCPU Hotplug
 (on Archs like ARM)
To: Miguel Luis <miguel.luis@oracle.com>
Cc: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 Karl Heubaum <karl.heubaum@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 "zhukeqian1@huawei.com" <zhukeqian1@huawei.com>,
 "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
 "wangyanan55@huawei.com" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <B1CFD37B-3422-4766-A5EE-64D000FDEC2B@oracle.com>
 <b2593ab0-f5b2-46fe-8a8c-3725598a6ae1@linaro.org>
 <2033A23F-0516-4C2D-BD28-CF130AA4E086@oracle.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <2033A23F-0516-4C2D-BD28-CF130AA4E086@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x1032.google.com
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

Hi Miguel!

On 10/21/24 05:04, Miguel Luis wrote:
> Hi Gustavo,
> 
>> On 18 Oct 2024, at 17:57, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>>
>> Hi Miguel,
>>
>> On 10/15/24 15:41, Miguel Luis wrote:
>>> Hi Salil,
>>> I’ve ran the usual tests successfully of hotplug/unplug from the number of cold-booted cpus up to maxcpus and migration on ARM. Please feel free to add:
>>
>> Do you mind sharing what cpus you used for your tests?
>>
> 
> Not at all. I’ve used -cpu host and -cpu max. I had used RFC-v5 from [1] in order to test
> this patchset as they are at the base of it.

ah, got it. Thanks for the clarification, that's what
I was wondering at first :)


>> Did you use tcg or kvm for the tests?
> 
> I’ve used both in the following configurations:
> 
> -M virt -accel kvm -cpu host
> -M virt,gic_version=3 -accel kvm -cpu host
> -M virt,gic_version=3 -accel tcg -cpu max
> 
> And
> 
> -M virt -accel tcg -cpu max
> 
> This last one presented defects in QEMU on behalf of RFC-V5 but, if you don’t
> mind, instead of me transcribing everything here, could you please take a look
> at [2] ?
> 
> I could have given more detail from start, apologies for any confusion on my part.

Sure, thanks for the pointers ;)


Cheers,
Gustavo

