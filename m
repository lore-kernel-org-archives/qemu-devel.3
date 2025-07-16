Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D0EC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 13:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc1qi-0002R3-8v; Wed, 16 Jul 2025 09:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uc1mA-0007VQ-8s
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 09:02:30 -0400
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uc1m3-0003RN-Gr
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 09:02:20 -0400
Received: by mail-ua1-x941.google.com with SMTP id
 a1e0cc1a2514c-8815049d0a8so2782791241.2
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 06:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752670933; x=1753275733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lnyqup0jSt7AmUgTdYnKdxk1IGX9+UUwGCDXD+VuRhE=;
 b=a0cTGHKphyUw2pPchXQRY5FSjQrO4Zfc0+jV8Lz5cqPLTAiOFb7jke/NtPuUcUbMvg
 BGJ2YVwi7+OY0gWYU/ZyImiKvD5N48Ag628nGXOx94bHjkVhWX3sgb8k9YcA6Fp+bSNT
 Es3n20Nz5MYaReQpHMwg8n7hWd9SKMjc3vxrQgs3GjPYcKGSk6ckzN9cS69bkZwlyoRZ
 DxX1u7BB3XfZ6iZVMAD0Pbk38JN5HtCh/KLCHep+7mYU968iCv2tOcICre4yt0ayiSX8
 gPf/Hv/4st58CRTH1khgsX5AlW7eMps0JiXLz6Brkk0HT3/JOSq8tT15BpgLkpNcJep7
 VyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752670933; x=1753275733;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lnyqup0jSt7AmUgTdYnKdxk1IGX9+UUwGCDXD+VuRhE=;
 b=BP2ThVgAbq7Tm7VkdP6vkJVdKOeVQmidHJ1bzLPLKCpcmm1MptHeWKazkGcZkBtQyg
 lP5vU5jCdaP7uvC/izzbxLBYu4LXcphezIe9VqSzQ+1JDo21S0UxWjrpHl0pds6+8mnx
 awuFpbFsaheoUL6UsEiBspjnK4plEvjzl/wfVb8zpvntFc8GE2QHfFXnMwtxIhIdUtjO
 rE7UtlK1i/Hm/ThXazIX8fugX3SzlVag2cQsESU9Ue9zqc7NsT8gSkHQAMoju9tSD5Jp
 imDim85EWvnx0XWlcHugV7qCZfbaVFCX8zT27XvzCDzBqvYc0jXBqoiV59zTvtf95948
 hTXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1+mNSPGXSwHmaRmafkeLNiRCQ8OIUFgGTzrqFbkjz5lynMI6iboPW12AAWi/WSC6Kkpxox8rUCVWc@nongnu.org
X-Gm-Message-State: AOJu0Yyd84Or/e0BFVGmEsuLE/sV8Bj+NUrtLJfzSHE5rDLZD3OBrBxs
 RlXT94n9IO+uepcBR2iskCNrQR0Yf4CmHiGFySg3TMh/lX1uTKeC3xQrZHAWYO4ZC2U=
X-Gm-Gg: ASbGncs0urdIvH+PCmovPVt79GUff6hlqn1T9lFlMIGs04b4K26+f3PEZqlwuJrEGl5
 83iz1FKU/petuW/Q3QRQm3WJRJ2hZaXFwRQFwcnP/ntQMBuiJ3xDWXUgJ4bPTht0l+NpO2WU1nm
 KFIeg/HDtTWRwJ0EjgXOIERNsZXYb/VdHoDhX41bWfzNJxyt48diQ/UG0CFsqWio/yuXCiUfcqB
 fIJinopDRxgvlKWiEedA/Ow7pS3hcZaGcr66Q08hFglAxcbxz4aouPnw0QRRvWYAw8rLI5WpIKz
 ffIV6ORiVBP+M7F0R/3a5e0ddk1UN3eMIufgd/C6PsxC2X0azglMR67rm0HOBwQnUG9JYdy8eIF
 g7O/8sx+gtRioBN6+579AJXcbbjNy24OKvZt5Mhe9Q4a9BH/BzpnJWz8A/QcC6xcl
X-Google-Smtp-Source: AGHT+IGH1FlK8dwJqul8bohrrjYJHX2rSvieSQUuRQjmbJ18b/LUvRYwWlfvdC+fHO6DF1kebxoJIA==
X-Received: by 2002:a05:6102:548e:b0:4e5:ae05:fff9 with SMTP id
 ada2fe7eead31-4f955ad8155mr881676137.8.1752670932471; 
 Wed, 16 Jul 2025 06:02:12 -0700 (PDT)
Received: from [192.168.0.102] (189-47-46-41.dsl.telesp.net.br. [189.47.46.41])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-888ec245356sm2875071241.1.2025.07.16.06.02.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 06:02:11 -0700 (PDT)
Message-ID: <3842e5bb-2600-45e0-8a11-9fc931408356@linaro.org>
Date: Wed, 16 Jul 2025 10:02:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/4] target/arm: Add FEAT_MEC to max cpu
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250714155836.1514748-1-richard.henderson@linaro.org>
 <97292e35-b7f2-40ca-aed6-34ef39396433@linaro.org>
 <f984d041-5d23-41c8-b2d5-c79217a7f77b@linaro.org>
 <a7ecb907-2183-4625-a2bf-bbfc25acc77d@linaro.org>
 <a4696a6f-9a7b-4ecf-aecc-90b2596ec9e4@linaro.org>
 <295bed63-049d-4cce-807f-e88df6ed6bb0@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <295bed63-049d-4cce-807f-e88df6ed6bb0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::941;
 envelope-from=gustavo.romero@linaro.org; helo=mail-ua1-x941.google.com
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

Hi Pierrick!

On 7/16/25 02:56, Pierrick Bouvier wrote:
> On 7/15/25 8:13 PM, Gustavo Romero wrote:
>> Hi Pierrick,
>>
>> On 7/14/25 22:26, Pierrick Bouvier wrote:
>>> On 7/14/25 4:31 PM, Gustavo Romero wrote:
>>>> Hi folks,
>>>>
>>>> Richard, thanks for v8. Pierrick, thanks for testing it. :)
>>>>
>>>> On 7/14/25 14:09, Pierrick Bouvier wrote:
>>>>> On 7/14/25 8:58 AM, Richard Henderson wrote:
>>>>>> Changes for v8:
>>>>>>      - Re-order SCTLR2 and TCR2 so that they are independent of MEC.
>>>>>>      - Enable the SCTLR2 and TCR2 enable bits.
>>>>>>      - Squash 3 smaller MEC patches together.
>>>>>>
>>>>>> This still fails the RME tests, because we still need TF-A rebuilt
>>>>>> with ENABLE_FEAT_SCTLR2 and ENABLE_FEAT_TCR2.  Pierrick, since you
>>>>>> have just done such a build, could you re-test with this series?
>>>>>>
>>>>>
>>>>> I tested that on my local Realm enabled setup and I can confirm this solved the issue and current series works.
>>>>> Both flags are needed in TF-A. ENABLE_FEAT_TCR2 is needed to boot host, and ENABLE_FEAT_SCTLR2 is needed to boot nested guest.
>>>>
>>>> I'm a bit confused because the QEMU RME tests, afaics, uses OP-TEE, not TF-A. I've built TF-A
>>>> using the scripts in [0], enabling ENABLE_FEAT_TCR2 and ENABLE_FEAT_SCTLR2, but no way to get
>>>> it booting. I understand we can embed a OP-TEE into the TF_A via BL32=<optee_image> when
>>>> building TF-A. Is that what you're using?
>>>>
>>>
>>> I agree it's confusing. In short, no, OP-TEE is not used anywhere for Realms, only TF-A and RMM are used in our images. It seems that OP-TEE is a term used generically to represent any firmware running in secure mode, but it's a *totally* different software than TF-A + RMM. Naming OP-TEE like this is like if Linux would have been named "OP-kernel".
>>
>> Got it, so we use TF-A + RMM in the test images. Thanks for the clarifications.
>>
>> Isn't the generic term (or concept) actually TEE (not OP-TEE) and OP-TEE is a real software stack that implements the TEE spec, i.e., OP-TEE is code in https://github.com/OP-TEE)?
>>
> 
> Yes, correct. The term is TEE, OP-TEE is the project you mentioned. For some reason, everybody seems to think that OP-TEE is *the* unique TEE implementation is Arm world.
> Thus my analogy with Linux that would be named OP-Kernel.
> 
>>
>>> The RME tests we have are based on this excellent tutorial [0], and build is automated with 'qemu-rme-stack' [1], that simply follows those instructions.
>>>
>>> [0] https://linaro.atlassian.net/wiki/spaces/QEMU/pages/30128767027/Device+Assignment+Enabled+RME+Stack+on+QEMU
>>
>> Should [0] be:
>>
>> https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/Building+an+RME+stack+for+QEMU ?
>>
> 
> Correct, bad copy paste sorry.
> 
>>
>>> [1] https://github.com/pbo-linaro/qemu-rme-stack
>>>
>>> To add to the confusion (*get ready*), [0] uses OP-TEE build, which is simply a build system for op-tee + other things, but in the variant it generates, OP-TEE itself is not included. Yes, that's utterly confusing and took me quite some time to discover it, after talking with Mathieu himself. They removed it explicitely to make the stack more simple. In short, for Realms, forget about OP-TEE.
>>
>> ah, that's what confused me! I see now.
>>
>>
>>> If you want to see it by yourself:
>>>
>>> https://git.codelinaro.org/linaro/dcap/op-tee-4.2.0/build/-/blob/cca/v8/qemu_v8_cca.mk?ref_type=heads#L172
>>>
>>> ...
>>> TF_A_FLAGS ?= \
>>>       BL33=$(BL33_BIN) \
>>>       PLAT=qemu \
>>>       QEMU_USE_GIC_DRIVER=$(TFA_GIC_DRIVER) \
>>>       DEBUG=$(TF_A_DEBUG) \
>>>       LOG_LEVEL=$(TF_A_LOGLVL) \
>>>       ENABLE_RME=1 \
>>>       RMM=$(RMM_BIN)
>>> ...
>>> TF_A_FLAGS_BL32_OPTEE  = BL32=$(OPTEE_OS_HEADER_V2_BIN)
>>> TF_A_FLAGS_BL32_OPTEE += BL32_EXTRA1=$(OPTEE_OS_PAGER_V2_BIN)
>>> TF_A_FLAGS_BL32_OPTEE += BL32_EXTRA2=$(OPTEE_OS_PAGEABLE_V2_BIN)
>>> TF_A_FLAGS_SPMC_AT_EL_n  = $(TF_A_FLAGS_BL32_OPTEE) SPD=opteed
>>> ...
>>> #TF_A_FLAGS += $(TF_A_FLAGS_SPMC_AT_EL_$(SPMC_AT_EL))
>>>
>>> The last line shows that OP_TEE flags are **NOT** added to TF_A_FLAGS build flags.
>>> The qemu_v8_cca.mk build file was copied from qemu_v8.mk, which itself has the OP-TEE inclusion.
>>>
>>> ---
>>>
>>> Recently, I had to generate a custom rootfs, and I experimented generating it directly from docker images, to avoid rebuilding the world using Buildroot. Once it worked, I realized it was a good opportunity to rebuild the rest of the stack too. The result is 'qemu-linux-stack' [2].
>>>
>>> Master branch has only tf-a + uboot (no Realm support), while rme branch [3], which supports Realm, uses tf-a + rmm + edk2 instead. I removed u-boot as I couldn't get it to boot, and I knew that edk2 worked.
>>>
>>> One branch is only one configuration (and it will stay this way).
>>>
>>> [2] https://github.com/pbo-linaro/qemu-linux-stack
>>> [3] https://github.com/pbo-linaro/qemu-linux-stack/tree/rme
>>>
>>> Beyond the personal knowledge I got through that, I hope it can be used for others for who it's confusing about what runs before start_kernel, and I guess I'm not the only one who didn't know about that. In the end, things are not too complicated, but as most of the build systems out there (OP-TEE build, shrinkwrap, ...) try to be "generic and versatile", it ends up being complicated. I prefer basic and straightforward script shells to lenghty documentation and wiki pages, but it's a personal choice.
>>>
>>> ---
>>>
>>> Now, coming to the change introduced by this series, and supporting FEAT_SCTRL2 and FEAT_TCR2, all those images need to be updated [0], [1], [2], [3], because essentially, TF-A itself must be patched to support this. I was about to mention that, and mention that I can send a PR directly to it once we have this merged on QEMU side.
>>>
>>> The change in arm-trusted-firmware is quite simple:
>>>
>>> +diff --git a/plat/qemu/common/common.mk b/plat/qemu/common/common.mk
>>> +index 751511cf8..6bc108492 100644
>>> +--- a/plat/qemu/common/common.mk
>>> ++++ b/plat/qemu/common/common.mk
>>> +@@ -122,6 +122,10 @@ ENABLE_FEAT_FGT         :=      2
>>> + # 8.7
>>> + ENABLE_FEAT_HCX             :=      2
>>> +
>>> ++# 8.8
>>> ++ENABLE_FEAT_TCR2    :=      2
>>> ++ENABLE_FEAT_SCTLR2  :=      2
>>> ++
>>>
>>> I'll push all that tomorrow on master, and rebase rmm and device_passthrough on top of it.
>>> I'll add this to original RME images, it's less direct though, as it's needed to update the tf-a fork, and then the optee build system.
>>
>> So, I still fail to understand how you are generating the out/bin/flash.bin used in our images.
>>
>> First I tried to use the https://github.com/pbo-linaro/qemu-rme-stack, since it's cited in the tests. I tried:
>>
>> $ ./container.sh ./build_virt.sh
>>
>> and get an error which seems a commit mismatch in some of branches used by repo:
>>
>> repo: reusing existing repo client checkout in /mnt/git/qemu-rme-stack
>> Traceback (most recent call last):
>>     File "/mnt/git/qemu-rme-stack/.repo/repo/main.py", line 869, in <module>
>>       _Main(sys.argv[1:])
>>     File "/mnt/git/qemu-rme-stack/.repo/repo/main.py", line 845, in _Main
>>       result = repo._Run(name, gopts, argv) or 0
>>                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>     File "/mnt/git/qemu-rme-stack/.repo/repo/main.py", line 293, in _Run
>>       result = run()
>>                ^^^^^
>>     File "/mnt/git/qemu-rme-stack/.repo/repo/main.py", line 274, in <lambda>
>>       lambda: self._RunLong(name, gopts, argv, git_trace2_event_log) or 0
>>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>     File "/mnt/git/qemu-rme-stack/.repo/repo/main.py", line 437, in _RunLong
>>       execute_command()
>>     File "/mnt/git/qemu-rme-stack/.repo/repo/main.py", line 403, in execute_command
>>       execute_command_helper()
>>     File "/mnt/git/qemu-rme-stack/.repo/repo/main.py", line 369, in execute_command_helper
>>       result = cmd.Execute(copts, cargs)
>>                ^^^^^^^^^^^^^^^^^^^^^^^^^
>>     File "/mnt/git/qemu-rme-stack/.repo/repo/subcmds/init.py", line 400, in Execute
>>       self._SyncManifest(opt)
>>     File "/mnt/git/qemu-rme-stack/.repo/repo/subcmds/init.py", line 146, in _SyncManifest
>>       if not self.manifest.manifestProject.Sync(
>>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>     File "/mnt/git/qemu-rme-stack/.repo/repo/project.py", line 4704, in Sync
>>       self.MetaBranchSwitch(submodules=submodules, verbose=verbose)
>>     File "/mnt/git/qemu-rme-stack/.repo/repo/project.py", line 4173, in MetaBranchSwitch
>>       self.Sync_LocalHalf(syncbuf, submodules=submodules, verbose=verbose)
>>     File "/mnt/git/qemu-rme-stack/.repo/repo/project.py", line 1636, in Sync_LocalHalf
>>       lost = self._revlist(not_rev(revid), HEAD)
>>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>     File "/mnt/git/qemu-rme-stack/.repo/repo/project.py", line 3676, in _revlist
>>       return self.work_git.rev_list(*a, **kw)
>>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>     File "/mnt/git/qemu-rme-stack/.repo/repo/project.py", line 3908, in rev_list
>>       p.Wait()
>>     File "/mnt/git/qemu-rme-stack/.repo/repo/git_command.py", line 556, in Wait
>>       self.VerifyCommand()
>>     File "/mnt/git/qemu-rme-stack/.repo/repo/git_command.py", line 546, in VerifyCommand
>>       raise GitCommandError(
>> git_command.GitCommandError: GitCommandError: 'rev-list ^6fd1cc667671a12cfc8789a390c990446e621f8f HEAD --' on manifests failed
>> stderr: fatal: bad revision 'HEAD'
>>
> 
> I'm not sure what is happening. I gave it a try now (from a clean repo), and it works as expected. I had weird errors when stopping sync with ctrl-c in the past too. Anyway, clean and retry.

OK


>>
>> Then I tried to build it from https://github.com/pbo-linaro/qemu-linux-stack/tree/rme and out/flash.bin
>> simply doesn't boot the kernel...
>>
> 
> Maybe you built previously master branch, then switched to rme and rebuilt. In this case, your kernel and tf-a are not updated. I added a note in README, there is no dependency check when switching branches, you're expected to run git clean by yourself.
> Both shrinkwrap and OP-TEE build don't really handle that properly to be honest...
> 
> It's not ideal, but I don't want to go down the rabbit hole of reimplementing any kind of half baked Make based dependency graph.
> Maybe we could use git submodules or repo in the future, but both have their own drawbacks too.

Won't dare to blame you for it, we need to keep ourselves sane XD

You did a great work already putting it in a single place and using bash scripts as much as possible :)


Cheers,
Gustavo

>>
>>> Sorry for this very long email. At least, all is there.
>>
>> Nope, that's quite helpful. This firmware stack is a mess :)
>>
>>
>> Cheers,
>> Gustavo
> 


