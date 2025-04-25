Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBD4C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 10:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8GOx-0000mW-Qn; Fri, 25 Apr 2025 06:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GOw-0000mF-Bd
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:35:22 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GOt-0007vD-M3
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:35:21 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso23580135e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 03:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745577317; x=1746182117; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kA0W8cd4KB8E87d1e/uyPkx8dl85yv1pXirIFdrdRs4=;
 b=uWrGFTR7GACL0lzklY90G+nqpJcF5QEHFmX3A/+Nwpdskvv3FJ0WNcB262nsVrDbP4
 gxIBQl4RnLsqGQjdtgzgrhz2y8oA8nOJpuNMPESiYD5CWj/mhUljhfXxZHDv+awHd6Mg
 eiB7kBK6/1P1MeEw12hmmt3ySNsK7dFeU2OBQiEPb4q1V6kiBaPLmGe6+6iZ6jNWhZXA
 1j8IDEyJHNcK6fqzsUNq+9e5Ebt1E97lNXW3NGOxP00lEwIRIchoymXVv3Ml3U93YyUw
 A/TFGm6c2P0ca68b2RZj8NFMpJfaGSaWBMai98g9iYGKcpDKqqj3igFnGXiUnvSkMfQW
 4NOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745577317; x=1746182117;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kA0W8cd4KB8E87d1e/uyPkx8dl85yv1pXirIFdrdRs4=;
 b=WyWytiwc9WmAOV/u6WFipDi2F9O4PDrLpkvY7Z24ZHM5RlATQh5sGZ3+1QW2GhLpZa
 Oxj5Q0buvXFSC9nN3ngmlqCLE6efJjMem35FYDKkBaR26j30Sk9p5B9O8GVS0qjAoFPd
 6tO0k8TW6NVQzLPmIssbCo3ctrV5JsMeSPdfLn2ilLx9tJ7jZeMM7SXLkzGIY5MvJiOf
 Up3axv+VGIB68oNI4YHnQReen8vss1jciSeVazeaB6KLj+MRrZBnntB7j3ZdQ9Rcv9+b
 qfmUmifPHu7VcLq2w5xAPYEZLgfaBG3ZVsr/OaxcyhDpLnsvNqauPhBFNMZs9bJgNZwJ
 VHsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWehCkGgKbWc7R1oJKK3mXXbwybdVTHfA+VgjTCNATbbrtKK1xQk556Ep+QZWtLkIZm15w+qx+p5q+4@nongnu.org
X-Gm-Message-State: AOJu0YyLSjGaSRMEAoZKLo6/OJl+pKVelT6oIUPs+ZDEKepj9oOIRCEw
 Uei0L/dZUB8aCetJQTYU4olGr9IcE6aNLXnMbB8B1vTnBYm+OIuA/+04QvpVFvc=
X-Gm-Gg: ASbGncsj8eNZSKR9f1Vqjz19I8TNAdFrbQTgewbVa7VfELOj85IZtLewr1wWT262T2c
 k6Woe9z43lQC7FGSdp2+m3rPywvllp17aZFruJ+u7BQ3c2YN57mf3v5JeUBCV+6YvRi5M/yEwfW
 q47Zd/nH7Gdxs0ggqBTDxvNHNmMR7eg820YOoVh/84x5r6+f6kOcj0SzuaMjDeulPwqPFFPywIf
 Rg7wVodnQyxNwBDU9B6/492qnF15jNf1Rt12kcqwx2khR5MBVD9/N/sSG3JkFZWR8DhwjGRBBaO
 4QwiBxAO7AzBSmMQU9iRIgXn645XjBMeM1GrCDZ3YjVSCwVbyMExRG8hCei7L/U61DH/VeUiBJT
 ZyXFQKaVh
X-Google-Smtp-Source: AGHT+IGIumkJchFpnhxDOvoTMJn12J1D7niYkd5KDfOajooMuqxtsNhZGAxrQuS7jdm7hB+3Fb8ALQ==
X-Received: by 2002:a05:6000:1a88:b0:39d:724f:a8a0 with SMTP id
 ffacd0b85a97d-3a074fae1damr1251690f8f.58.1745577317346; 
 Fri, 25 Apr 2025 03:35:17 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8c7a4sm2030455f8f.14.2025.04.25.03.35.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 03:35:16 -0700 (PDT)
Message-ID: <fa6f20a9-3d7a-4c2d-94e5-c20dbaf4303e@linaro.org>
Date: Fri, 25 Apr 2025 12:35:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] qapi/qom: Introduce kvm-pmu-filter object
To: Zhao Liu <zhao1.liu@intel.com>, Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>, Shaoqin Huang <shahuang@redhat.com>,
 Eric Auger <eauger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Alexander Graf <agraf@csgraf.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250409082649.14733-1-zhao1.liu@intel.com>
 <20250409082649.14733-2-zhao1.liu@intel.com> <878qo8yu5u.fsf@pond.sub.org>
 <Z/iUiEXZj52CbduB@intel.com> <87frifxqgk.fsf@pond.sub.org>
 <Z/i3+l3uQ3dTjnHT@intel.com> <87fri8o70b.fsf@pond.sub.org>
 <aAnbLhBXMFAxE2vT@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aAnbLhBXMFAxE2vT@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi Zhao,

On 24/4/25 08:33, Zhao Liu wrote:
> Hi Markus,
> 
>>> This is for security purposes, and can restrict Guest users from
>>> accessing certain sensitive hardware information on the Host via perf or
>>> PMU counter.
>>>
>>> When a PMU event is blocked by KVM, Guest users can't get the
>>> corresponding event count via perf/PMU counter.
>>>
>>> EMM, if ‘system’ refers to the QEMU part, then QEMU is responsible
>>> for checking the format and passing the list to KVM.
>>>
>>> Thanks,
>>> Zhao
>>
>> This helped some, thanks.  To make sure I got it:
>>
>> KVM can restrict the guest's access to the PMU.  This is either a
>> whitelist (guest can access exactly what's on this list), or a blacklist
>> (guest can access exactly what's not this list).
> 
> Yes! The "action" field controls if it's a "whitelist" (allow) or
> "blacklist" (deny).
> 
> And "access" means Guest could get the event count, if "no access", then
> Guest would get nothing.
> 
> For example, if we set a the whitelist ony for the event (select: 0xc4,
> umask: 0) in QEMU:
> 
> pmu='{"qom-type":"kvm-pmu-filter","id":"f0","action":"allow","events":[{"format":"x86-select-umask","select":196,"umask":0}]}'
> 
> then in Guest, this command tries to get count of 2 events:
> 
> perf stat -e cpu/event=0xc4,name=branches/,cpu/event=0xc5,name=branch-misses/ sleep 1
> 
> Since another event (select: 0xc5, umask: 0) is not on whitelist, its
> "access" is blocked by KVM, so user would get the result like:
> 
>   Performance counter stats for 'sleep 1':
> 
>              348709      branches
>                   0      branch-misses
> 
>         1.015962921 seconds time elapsed
> 
>         0.000000000 seconds user
>         0.015195000 seconds sys
> 
> The "allowed" event has the normal output, and the result of "denied"
> event is zero.
> 
>> QEMU's kvm-pmu-filter object provides an interface to this KVM feature.
> 
> Yes!
> 
>> KVM takes "raw" list entries: an entry is a number, and the number's
>> meaning depends on the architecture.
> 
> Yes, and meaning also depends on format. masked-entry format has special
> meaning (with a flag).
> 
>> The kvm-pmu-filter object can take such entries, and passes them to
>> straight to KVM.
>>
>> On x86, we commonly use two slightly higher level formats: select &
>> umask, and masked.  The kvm-pmu-filter object can take entries in either
>> format, and maps them to "raw".
>>
>> Correct?
> 
> Yes, Markus, you're right! (And sorry for late reply.)
> 
> And "raw" format as a lower level format can be used for other arches
> (e.g., ARM).

Since you provide the ability to use a raw format, are we sure other
accelerators will never be interested in such PMU filtering?

I'm pretty sure HVF could benefit of it (whether we implement it there
is another story).

What do you think about adding this as a generic accelerator feature.
If a particular accel doesn't support it and we ask to filter, we simply
report an error.

