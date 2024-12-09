Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4917E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 16:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKgfg-0002Kx-Hd; Mon, 09 Dec 2024 11:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKgff-0002Kc-4f
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:31:43 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKgfd-0004Ik-2Q
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:31:42 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-434ab938e37so29579215e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 08:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733761899; x=1734366699; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wpqw5miIkSlBpDTPPmTX4uj6FCZB2X5O4MYbV3YtbHo=;
 b=a05gJ3XZ9EWNzFcXET8Nbz2n7S758u4SaIFNmqJstbTXyEv3uAH3QxAGHrwW539aHL
 MXU1Vuq2iTBEDIDv8swUy7wFA+AVlZa1E1pINcoDAvCUPJ2m8AAK4SxiMz8iGDrwGtvX
 QFJ1qZpPUEMjOudPUTTN/VpZFdpTjtTaw/C1IbQVXehiG3ILP0XRZrsd3XJJKsQnDxBw
 71OUcJ7z+u9NKeKW2OHwSSXCoRhto/r5GfIx7SeUEJMdQuCLo3PmdXQhITO3hSoZeccV
 4Y5r0t3kmXj2Z5Oi3QdHAGgTA9r/psCHxJbe/ZwoPiCWvwSbPlJaew5RBDxQt6CIebtJ
 yUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733761899; x=1734366699;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wpqw5miIkSlBpDTPPmTX4uj6FCZB2X5O4MYbV3YtbHo=;
 b=K5GA2Wa9chfbKVNR8xt7f2KpxoSwU5r3r1hgdNcnQgcuhadGPBQ3/7Ea9sH2tolswf
 RiceWTXKIko3n2522S3ez2a9Z/jm8gI3XgGrq6RUDc7skhKCAHjogs3SD/zEoJO8usaJ
 KzgI9FkpUKZN//96t3WdUHxfI8G5rDFuD8l5qsaFFn8w9v42z6Dswzhfr2oWOtXUD7Mx
 z5OHlYlRzI0oKFCFOeMxrLLJYhf7JMmsYZjL6rIkL9EDXo42pRT9QR3/1zyxqPraZtYP
 0qZCuHSgM91kAASkF4ulaQ1BhDcuyBMLQo1lcmGFbbpnwiZFORF45s5dd+VrPdT0woaB
 LQEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+ckhT9Jc0z1i6NxKWJmHz7xTbr1ZT6YAwBBk85toj4B2UnseLTLiBclrdIlSSYBTjjryADmosn33W@nongnu.org
X-Gm-Message-State: AOJu0YxzA48Hx/kbXH8Gioh4gSqidYykO086RjU4/N8JW7EKrurHJpuU
 hTVpGqnf8UEt8aTXfulWHyMBLDhvXQCWmtXHHM9uAqtL4Up3IfB0Rlj87NX83tQ=
X-Gm-Gg: ASbGncsBWKVcpep1JjrtXUCuSuXLawmJKYk/eQxhtksacczQcrtwbpy1ay1LcfVHp3Q
 66VV8HN8phXisWN2t9qTy/fW8lAOGE0d6NPlgVYU3MaFGny88Ym37d7E4iV1/mLLH+GGELT8CQX
 c1T23DLRpMIe5XYG+Lq0FbGV2oQ8TP/yxJFoS+ZQBK0ORh1uYhMxkw3bx5gFZp9STyhpmgkd2r5
 JmqWBrpZEKvZO5HGQN2wAC5mKtsThcbBYcxxQAeBUdy7EQvqmkSNm5ipCdTXKAWbpPeIlIm93RE
 saVgBSmQ0p3J7/hR3tf15/hCZrRyeYe8
X-Google-Smtp-Source: AGHT+IE+gFqeJX9+oPlISs0ojDR1mvzsgRTjDOooMV/Sddv2tSyl+UrHBHuEK6T16VlVdiOyvgXjKQ==
X-Received: by 2002:a05:600c:4fcd:b0:434:a711:ace4 with SMTP id
 5b1f17b1804b1-434ddeba502mr115850435e9.17.1733761899200; 
 Mon, 09 Dec 2024 08:31:39 -0800 (PST)
Received: from [192.168.1.17] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f8836dbbsm32074815e9.0.2024.12.09.08.31.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 08:31:38 -0800 (PST)
Message-ID: <4fa944df-ddf2-48be-bbb0-7b24f63263e6@linaro.org>
Date: Mon, 9 Dec 2024 17:31:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0] tests/functional: Convert the intel_iommu
 avocado test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: eric.auger@redhat.com, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, Yi Liu <yi.l.liu@intel.com>
References: <20241206181728.1241169-1-thuth@redhat.com>
 <d07f4ade-716c-4d58-b6d9-a95b4ffe58ab@redhat.com>
 <7e81c4a2-cc76-4d8c-b14a-fd008eff0c09@redhat.com>
 <Z1az26HxcIHVlB-d@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z1az26HxcIHVlB-d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 9/12/24 10:09, Daniel P. Berrangé wrote:
> On Mon, Dec 09, 2024 at 09:26:21AM +0100, Thomas Huth wrote:
>> On 09/12/2024 09.12, Eric Auger wrote:
>>> Hi Thomas,
>>>
>>> On 12/6/24 19:17, Thomas Huth wrote:
>>>> Convert the intel_iommu test to the new functional framework.
>>>> This test needs some changes since we neither support the old 'LinuxTest'
>>>> class in the functional framework yet, nor a way to use SSH for running
>>>> commands in the guest. So we now directly download a Fedora kernel and
>>>> initrd and set up the serial console for executing the commands and for
>>>> looking for the results.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>    MAINTAINERS                                   |   1 +
>>>>    tests/functional/meson.build                  |   1 +
>>>>    .../test_intel_iommu.py}                      | 119 ++++++++----------
>>>>    3 files changed, 51 insertions(+), 70 deletions(-)
>>>>    rename tests/{avocado/intel_iommu.py => functional/test_intel_iommu.py} (41%)
>>>>    mode change 100644 => 100755


>>>> -        self.launch_and_wait()
>>>> -        self.ssh_command('cat /proc/cmdline')
>>>> -        self.ssh_command('dmesg | grep -e DMAR -e IOMMU')
>>>> -        self.ssh_command('find /sys/kernel/iommu_groups/ -type l')
>>>> -        self.ssh_command('dnf -y install numactl-devel')
>>> I understand you cannot use ssh yet but the bulk of the test was the
>>> execution of the dnf install meaning we lose the main substance of it
>>> through the conversion.
>>
>> Ah, I see, so this was exercising the virtio-net device with the IOMMU ...
>> and I already wondered why there was this "dnf install" at the end without
>> doing anything with  the numactl-devel package ... (a comment would have
>> been helpful here)
> 
> FYI, I find 'dnf instal' to be a *highly* undesirable thing todo in
> our test functional. Its performance is highly non-deterministic
> depending on what mirror you happen to get sent to, such that it could
> easily push us over the timeouts. It is also susceptible to periodic
> broken mirrors, and instability around time of Fefdora EOL. I can't
> remember if it was this test case, or a different one, but I've seen
> problems before in avocado with 'dnf install'.
> 
> If we want to test working networking, then can we arrange for something
> more simple & targetted to run, with better worst case performance.

Could we use 2 virtio-net interfaces inter-connected and stress with
https://linux.die.net/man/1/ab ?

