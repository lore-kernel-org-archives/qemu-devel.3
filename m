Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A83CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 18:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ultMH-00036b-Pr; Tue, 12 Aug 2025 14:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ultME-00035y-4T
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 14:04:22 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ultM9-0000Hv-1N
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 14:04:21 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b34a8f69862so4349942a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 11:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755021853; x=1755626653; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7/gSRppnirG3P42CH6t/aeDpchyaRHzJmZFb7xB9suA=;
 b=giNukbF+Gwn04Y1ZEjSDYJUkwnd30qmZk4VMlXeJKlDCc70bo2CLt6LKqczSIpRfSo
 nN+T5hd0xjZVD5sC88NwaMlQzmWshcgj/56yaM04FYTAfxUMeu8aaMAzkyCMeyPR+s5I
 Srbp8tDrHgMlHv8JBe7YlPmjLRAil2ksZgy1kOlvuE4FlasSjF8RAginhz0W+ZVqCins
 IGjszEurbOBQdWpCvKwdIc+O2XaDRKGKfp+AnTV3kksq5D00RVbaje6PY6sDbx1Xcirr
 snsxuVnuIq56MRofkIOZABRZQsBBWqQoTLhLo86O8ZJhJfW4k6lSXDMuaAsWzKKTUi47
 6GMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755021853; x=1755626653;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7/gSRppnirG3P42CH6t/aeDpchyaRHzJmZFb7xB9suA=;
 b=P1GuEzsLsIhUegcgPZMtJReuvoe965y92hlEpqPij+pz78ui0Mg3J8BhKEMQqyRRbh
 5VoOqmTxJc/YfaLNEcdsytCE9TTBsKakWIKfgKKF51iCL4R6b3wsYVi4SPJI3/i+plOD
 hRtRcmdCeNJCo81I41w1XGBdB0K+40DeuqWs1nesCeERIYFtlpPBKaazhJIH+52pf6w2
 70lixnGO0uA/5cFEFAOEYRNfvGjZDnEAb/kXY43tc6EP53+iJEnTlQpLciHuoQjiqwJ3
 L8gv53XOndc13L3kFEyZXNJ1+p7Tcbr5NnyzCa4EYoWfmykrbEfw4rdt46fcGzwDaNVN
 BZ4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlu5AgWXTPPkmaFbqoVdxsmXGujnzmoqSi1Qidj3Dfuv4HGNrmIvYkH1FYsRxTN3nd8DQWYhsNqlZZ@nongnu.org
X-Gm-Message-State: AOJu0YxJNVoMBTcycIPBHW1XQ6kgy0VWSS7JbOoKUwGt/PSOWH2sZkGZ
 8kg7p1/6WvC7T9KDpkqmM5Qcl1VXZoCi2rGn8lt2R9lPn2h+enFAPagPk9ki2aOheRk=
X-Gm-Gg: ASbGncsj2bXR65aFG67al2W6rXp4Arb6EIdqs3QKZqAI49/PEStvmGRrVNeHAKO79SO
 +kFwHUqs5jjXwX5p64xPFhXbYBFxUDHj8ynTqZc0jZ14f5vsp0UWy/EGZzFKyYlVrA6jPpwF7l8
 ZPMvMkt5xaeEqZNk5z7/KNm7ImTROrZECH2WSoJ1QiBtD4l+Bbimas1civBQ8VkRlljPzQfQqzc
 6Gpgzi6uqukH0Dc//UiSyl09uEQyjdWDpzCy7RmYm4vyhqgdfW4fuM4a3IycAp855Tssl1LKV8O
 Urw6XVCUybh8TZ+jniCrTmgL3F6CYs5+m1uRbNRDGr63WtX/Zu3WLXOI4kbExyxV5YpMXGMS+Aa
 LV9IRMsFZwrOZ7OSndIfqj6woYEm98aCM7YH+8U5K9TFI0w==
X-Google-Smtp-Source: AGHT+IFNZ8KegwiiDxgBgnLSz8mvCHczFEevnaSBjtDuLJiirEeOfUMiU4PA9c3vgcf7PK4SgO13Ig==
X-Received: by 2002:a17:903:3c4d:b0:243:3da:17bb with SMTP id
 d9443c01a7336-2430d1ccb42mr2088505ad.32.1755021852561; 
 Tue, 12 Aug 2025 11:04:12 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-242bc894dc8sm123129685ad.72.2025.08.12.11.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 11:04:12 -0700 (PDT)
Message-ID: <8b5cbf44-02a1-45f0-8a59-3cb7b762ad0a@linaro.org>
Date: Tue, 12 Aug 2025 11:04:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/11] hw/arm/smmuv3: Add initial support for Secure State
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>, smostafa@google.com,
 jean-philippe@linaro.org
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <d4fcf3a2-6789-4926-882e-1abac4c07843@linaro.org>
 <2169e4b1-97d1-43c9-a512-5e6e25a562ad@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <2169e4b1-97d1-43c9-a512-5e6e25a562ad@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
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

On 8/10/25 9:11 AM, Tao Tang wrote:
> 
> On 2025/8/7 05:28, Pierrick Bouvier wrote:
>> On 8/6/25 8:11 AM, Tao Tang wrote:
>>> Hi all,
>>>
>>> This patch series introduces initial support for emulating the Arm
>>> SMMUv3
>>> Secure State.
>>>
>>> As Pierrick pointed out in a previous discussion [1], full Secure SMMUv3
>>> emulation is a notable missing piece in QEMU. While the FVP model has
>>> some support, its limited PCIe capabilities make it challenging for
>>> complex use cases. The ability to properly manage device DMA from a
>>> secure context is a critical prerequisite for enabling device assignment
>>> (passthrough) for confidential computing solutions like Arm CCA and
>>> related research such as virtCCA [2]. This series aims to build that
>>> foundational support in QEMU.
>>>
>>
>> Thanks for posting this series, it's definitely an important piece
>> missing for emulating newer SMMU versions.
>>
>>> This work is being proposed as an RFC. It introduces a significant
>>> amount
>>> of new logic, including the core concept of modeling parallel secure and
>>> non-secure contexts within a single SMMUv3 device. I am seeking feedback
>>> on the overall approach, the core refactoring, and the implementation
>>> details before proceeding further.
>>>
>>> The series begins by implementing the components of the secure
>>> programming
>>> interface, then progressively refactors the core SMMU logic to handle
>>> secure and non-secure contexts in parallel.
>>>
>>> Secure Interface Implementation: The initial patches add the
>>> secure-side registers, implement their read/write logic, and enable
>>> the secure command and event queues. This includes the S_INIT
>>> mechanism and the new secure TLB invalidation commands.
>>>
>>> Core Logic Refactoring: The next set of patches makes the core SMMU
>>> functions security-state aware. This involves plumbing an is_secure
>>> context flag through the main code paths and adding logic to route
>>> SMMU-originated memory accesses to the correct (Secure or Non-secure)
>>> address space.
>>>
>>> Cache Isolation: With the core logic now aware of security states,
>>> the following patches refactor the configuration and translation
>>> lookup caches. The cache keys are modified to include the security
>>> context, ensuring that secure and non-secure entries for the same
>>> device or address are properly isolated and preventing aliasing.
>>>
>>> Framework Integration: The final patch connects the SMMU's internal
>>> security context to the generic QEMU IOMMU framework by using the
>>> iommu_index to represent the architectural SEC_SID.
>>>
>>> To validate this work, I performed the following tests:
>>>
>>> Non-Secure Regression: To ensure that existing functionality remains
>>> intact, I ran a nested virtualization test. A TCG guest was created on
>>> the host, with iommu=smmuv3 and with an emulated PCIe NVMe device
>>> assigned.
>>> Command line of TCG VM is below:
>>>
>>> qemu-system-aarch64 \
>>> -machine virt,virtualization=on,gic-version=3,iommu=smmuv3 \
>>> -cpu max -smp 1 -m 4080M \
>>> -accel tcg,thread=single,tb-size=512 \
>>> -kernel Image \
>>> -append 'nokaslr root=/dev/vda rw rootfstype=ext4
>>> iommu.passthrough=on' \
>>> -device
>>> pcie-root-port,bus=pcie.0,id=rp0,addr=0x4.0,chassis=1,port=0x10 \
>>> -device
>>> pcie-root-port,bus=pcie.0,id=rp1,addr=0x5.0,chassis=2,port=0x11 \
>>> -drive if=none,file=u2204fs.img.qcow2,format=qcow2,id=hd0 \
>>> -device virtio-blk-device,drive=hd0 \
>>> -qmp unix:/tmp/qmp-sock12,server=on,wait=off \
>>> -netdev user,id=eth0,hostfwd=tcp::10022-:22,hostfwd=tcp::59922-:5922 \
>>> -device virtio-net-device,netdev=eth0 \
>>> -drive if=none,file=nvme.img,format=raw,id=nvme0 \
>>> -device nvme,drive=nvme0,serial=deadbeef \
>>> -d unimp,guest_errors -trace events=smmu-events.txt -D qemu.log
>>> -nographic
>>>
>>> Inside this TCG VM, a KVM guest was launched, and the same NVMe
>>> device was
>>> re-assigned to it via VFIO.
>>> Command line of KVM VM inside TCG VM is below:
>>>
>>> sudo qemu-system-aarch64  \
>>> -enable-kvm  -m 1024  -cpu host  -M virt \
>>> -machine virt,gic-version=3 \
>>> -cpu max -append "nokaslr" -smp 1 \
>>> -monitor stdio \
>>> -kernel 5.15.Image \
>>> -initrd rootfs.cpio.gz \
>>> -display vnc=:22,id=primary \
>>> -device vfio-pci,host=00:01.0
>>>
>>> The KVM guest was able to perform I/O on the device
>>> correctly, confirming that the non-secure path is not broken.
>>>
>>> Secure Register/Command Interface: I set up an OP-TEE + Hafnium
>>> environment. Hafnium's smmuv3_driver_init function was used to test
>>> the secure register I/O and command queue functionality (excluding
>>> translation). As Hafnium assumes larger queue and StreamID sizes than
>>> are practical without TTST support, I temporarily patched Hafnium to
>>> use smaller values, allowing its driver to initialize the emulated
>>> secure SMMU successfully.
>>>
>>
>> Would that be possible to share your changes, and build instructions
>> for this? While working on SMMU emulation, we finally left this on the
>> side due to lack of a software stack being able to use secure SMMU, as
>> we were not aware that Hafnium + op-tee could make use of it.
>>
> Hi Pierrick,
> 
> Thanks for your interest! I'm very happy to share my work on this. I've
> documented the setup process, including our code modifications and the
> step-by-step build instructions in  this link:
> 
> https://hnusdr.github.io/2025/08/09/Test-Secure-SMMU-with-Hafnium-ENG
>

Thanks for taking the time to assemble all this in a comprehensible 
post, I'll give it a try when I have some spare time.

> 
> The core point of these changes is to enable the SMMUv3 feature in
> Hafnium. This leads to numerous read/write operations on SMMUv3 secure
> registers and various queue manipulations within the smmuv3_driver_init
> function in Hafnium.
> 
> However, it's important to note that this initialization process itself
> does not initiate any DMA memory access that would trigger the
> smmuv3_translate flow.
>

I understand the difference. It can be tricky to generate specific 
translation scenarios, which is where a custom test device can really help.

> Even so, we've devised a method to test the subsequent Secure
> Translation Path by leveraging the smmuv3-test platform device. This
> approach allows us to verify the entire SMMUv3 flow, from initialization
> to translation.
>

Does it rely on a custom driver integration into an existing firmware or 
the kernel?

> 
>>> Secure Translation Path: Since the TF-A SMMUv3 Test Engine does not
>>> support QEMU, and no secure device assignment feature exists yet, I
>>> created a custom platform device to test the secure translation flow.
>>> To trigger the translation logic, I initiated MMIO writes to this
>>> device from within Hafnium. The device's MMIO callback handler then
>>> performed DMA accesses via its IOMMU region, exercising the secure
>>> translation path. While SMMUv3 is typically used for PCIe on
>>> physical SoCs, the architecture allows its use with platform devices
>>> via a stream-id binding in the device tree. The test harness
>>> required some non-standard modifications to decouple the SMMU from
>>> its tight integration with PCIe. The code for this test device is
>>> available for review at [3]. README.md with detailed instructions is
>>> also provided.
>>>
>>
>> I am not sure about the current policy in QEMU for test oriented
>> devices, but it would be really useful to have something similar
>> upstream (Note: it's out of the scope of this series).
>> One challenge working with SMMU emulation is that reproducing setups
>> and triggering specific code paths is hard to achieve, due to the
>> indirect use of SMMU feature (through DMA) and the complex software
>> stack usually involved.
>> Having something upstream available to work on SMMU emulation, at
>> least on device side, would be a great addition.
>>
>> Eric, Peter, is this something that would be acceptable to merge?
>>
> 
> Looking ahead, my plan is to refactor the smmuv3-test platform device.
> The goal is to make it self-contained within QEMU, removing the current
> dependency on Hafnium to trigger its operations. I plan to submit this
> as a separate RFC patch series in the next few days.
>

This is very welcome. Once this is in place, it would be great to add a 
new test to make sure things don't regress, and from where we can iterate.
By self-contained within QEMU, do you mean a QTest based test?

Regards,
Pierrick

