Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575B6C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 06:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubvDf-0005tQ-CF; Wed, 16 Jul 2025 02:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubv7x-0005uE-Eo
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 01:56:25 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubv7u-000459-JF
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 01:56:25 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-234f17910d8so61761445ad.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 22:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752645381; x=1753250181; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qtnBtwyb1RrL6ZQf2Fh026A+6mEJMNBFCbnLugvgWUg=;
 b=UoFh39n8R5OVST8VUFiw71UhcN8MUbUTessaYF8JRmknBc6evh9IMEr1T1l9Ovk8NK
 jFv/y//bZ605sE5EieJnw3K8oRYpTTImwpwprQZnNcUzaZRQ9ZjOE1Xv53us72hY4HZ0
 DTX/CwGHtcLmdW1xdXXVMMTCyzvJAEWvE2RmEqfDxYZOB5BwqltEANeHAW7JCv8Lhvh4
 t/X3q8zkeyOa3ua1xd/VdVP9nP7ePIcQ7ecLjcmPf29BJ3NX/56C93jH8ioL43UBCM3N
 DBNLOoyxjar6MWuY9XnH5r7+CwS35lrOLuja+IkT5X+LCm0kEibs4O+A1QKoAj94A6Jq
 0GDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752645381; x=1753250181;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qtnBtwyb1RrL6ZQf2Fh026A+6mEJMNBFCbnLugvgWUg=;
 b=B3ZI+QqWfUU8nP/hxAlI446AdjFGOKaTX8h/pMuW5aPYJJLRYaydNQUQq6C+EefF7Z
 pXrvbwTodxc2mJR6lINA+T6nS5AVwxro8co83x6VqvXf01JELYvFb5QXiTObS9E7rptz
 Fp4IMBk8StiebFlVX98Z/U4n5k1xF4bfErwRAuosMMfM6ieG9c3HPp8e9j/8W3Vzbrf2
 wV3mepJ0oxeJqyBdOsuMaCd+d9HjF+pMefss05Qm0jpMePqAswrMRkwsMR1SKnBPjxbN
 J4dWxhgoUrXMY5PfU0fBAtvIRXv5vrcHEy58O3M4wn7IFXB20oalD+wUrVzuy1BYO+ho
 NVRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/ULkzmRrNZrR+uJt2CzSyljFi7tIJn6/r1IByrohZrrzYHfceRYXa1HcLz7ILWkj04cz6Dq1o17JH@nongnu.org
X-Gm-Message-State: AOJu0YzthmFvQWXkJK93twtpI0rz4NXOPAAcjZ4ac6XaZG5Jw35PP3Wu
 yJycov52gYhEDF0dbzxm9D68h6z+iMDqjvhFqX6EadJSDFCO5lSF57Iw9JiPUCr2540=
X-Gm-Gg: ASbGncs//CP1COgdUkC9L5zqskmsf0WnvBmnR+lRj6Pqnd4eCWYQbtLGXDVDy9RTWqM
 spgoIsKqWnSrt0/QJr7h8uPBcWy+qt6GqRlV3ZT68hAm4bAAvArNC0NBEPWpP9ZJ/ReqUoIPtwG
 YSEcUzVq4VVgCziP2HgDRaq0FCpgeGX45RXRjzJlsaqMuWI8yRNCfk34EI5Am6oVqk3mIIgVy2Z
 CZvYZ5VBNCn9hU3Cqu3znLHSnmwMJvPlZJkrPhsUmXvo0i24E7weMRAurGlaWIBrwzrm09Kn6EN
 fvihB/OmEea3rzKUMyetPuWdPhYC/3uR96JOfQGaHkatLsvIulUEqu2vasmjPasx0iIXIPWnc/a
 2i6gNLQGc5SWh7Q/Q5V/6TN0mvqaBqrDGXQkR/Me1QRIGow==
X-Google-Smtp-Source: AGHT+IFrIG3GAwGhX1d5JPCJsUqQgLPSnShr4lsUdWi12ZXYtVTTwd26HDUuQwsStzb8p5SVfhQ/hw==
X-Received: by 2002:a17:903:2452:b0:235:2403:779f with SMTP id
 d9443c01a7336-23e24f44f27mr26515355ad.29.1752645380691; 
 Tue, 15 Jul 2025 22:56:20 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de43226c3sm123382695ad.117.2025.07.15.22.56.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 22:56:20 -0700 (PDT)
Message-ID: <295bed63-049d-4cce-807f-e88df6ed6bb0@linaro.org>
Date: Tue, 15 Jul 2025 22:56:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/4] target/arm: Add FEAT_MEC to max cpu
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250714155836.1514748-1-richard.henderson@linaro.org>
 <97292e35-b7f2-40ca-aed6-34ef39396433@linaro.org>
 <f984d041-5d23-41c8-b2d5-c79217a7f77b@linaro.org>
 <a7ecb907-2183-4625-a2bf-bbfc25acc77d@linaro.org>
 <a4696a6f-9a7b-4ecf-aecc-90b2596ec9e4@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <a4696a6f-9a7b-4ecf-aecc-90b2596ec9e4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 7/15/25 8:13 PM, Gustavo Romero wrote:
> Hi Pierrick,
> 
> On 7/14/25 22:26, Pierrick Bouvier wrote:
>> On 7/14/25 4:31 PM, Gustavo Romero wrote:
>>> Hi folks,
>>>
>>> Richard, thanks for v8. Pierrick, thanks for testing it. :)
>>>
>>> On 7/14/25 14:09, Pierrick Bouvier wrote:
>>>> On 7/14/25 8:58 AM, Richard Henderson wrote:
>>>>> Changes for v8:
>>>>>      - Re-order SCTLR2 and TCR2 so that they are independent of MEC.
>>>>>      - Enable the SCTLR2 and TCR2 enable bits.
>>>>>      - Squash 3 smaller MEC patches together.
>>>>>
>>>>> This still fails the RME tests, because we still need TF-A rebuilt
>>>>> with ENABLE_FEAT_SCTLR2 and ENABLE_FEAT_TCR2.  Pierrick, since you
>>>>> have just done such a build, could you re-test with this series?
>>>>>
>>>>
>>>> I tested that on my local Realm enabled setup and I can confirm this solved the issue and current series works.
>>>> Both flags are needed in TF-A. ENABLE_FEAT_TCR2 is needed to boot host, and ENABLE_FEAT_SCTLR2 is needed to boot nested guest.
>>>
>>> I'm a bit confused because the QEMU RME tests, afaics, uses OP-TEE, not TF-A. I've built TF-A
>>> using the scripts in [0], enabling ENABLE_FEAT_TCR2 and ENABLE_FEAT_SCTLR2, but no way to get
>>> it booting. I understand we can embed a OP-TEE into the TF_A via BL32=<optee_image> when
>>> building TF-A. Is that what you're using?
>>>
>>
>> I agree it's confusing. In short, no, OP-TEE is not used anywhere for Realms, only TF-A and RMM are used in our images. It seems that OP-TEE is a term used generically to represent any firmware running in secure mode, but it's a *totally* different software than TF-A + RMM. Naming OP-TEE like this is like if Linux would have been named "OP-kernel".
> 
> Got it, so we use TF-A + RMM in the test images. Thanks for the clarifications.
> 
> Isn't the generic term (or concept) actually TEE (not OP-TEE) and OP-TEE is a real software stack that implements the TEE spec, i.e., OP-TEE is code in https://github.com/OP-TEE)?
> 

Yes, correct. The term is TEE, OP-TEE is the project you mentioned. For 
some reason, everybody seems to think that OP-TEE is *the* unique TEE 
implementation is Arm world.
Thus my analogy with Linux that would be named OP-Kernel.

> 
>> The RME tests we have are based on this excellent tutorial [0], and build is automated with 'qemu-rme-stack' [1], that simply follows those instructions.
>>
>> [0] https://linaro.atlassian.net/wiki/spaces/QEMU/pages/30128767027/Device+Assignment+Enabled+RME+Stack+on+QEMU
> 
> Should [0] be:
> 
> https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/Building+an+RME+stack+for+QEMU ?
> 

Correct, bad copy paste sorry.

> 
>> [1] https://github.com/pbo-linaro/qemu-rme-stack
>>
>> To add to the confusion (*get ready*), [0] uses OP-TEE build, which is simply a build system for op-tee + other things, but in the variant it generates, OP-TEE itself is not included. Yes, that's utterly confusing and took me quite some time to discover it, after talking with Mathieu himself. They removed it explicitely to make the stack more simple. In short, for Realms, forget about OP-TEE.
> 
> ah, that's what confused me! I see now.
> 
> 
>> If you want to see it by yourself:
>>
>> https://git.codelinaro.org/linaro/dcap/op-tee-4.2.0/build/-/blob/cca/v8/qemu_v8_cca.mk?ref_type=heads#L172
>>
>> ...
>> TF_A_FLAGS ?= \
>>       BL33=$(BL33_BIN) \
>>       PLAT=qemu \
>>       QEMU_USE_GIC_DRIVER=$(TFA_GIC_DRIVER) \
>>       DEBUG=$(TF_A_DEBUG) \
>>       LOG_LEVEL=$(TF_A_LOGLVL) \
>>       ENABLE_RME=1 \
>>       RMM=$(RMM_BIN)
>> ...
>> TF_A_FLAGS_BL32_OPTEE  = BL32=$(OPTEE_OS_HEADER_V2_BIN)
>> TF_A_FLAGS_BL32_OPTEE += BL32_EXTRA1=$(OPTEE_OS_PAGER_V2_BIN)
>> TF_A_FLAGS_BL32_OPTEE += BL32_EXTRA2=$(OPTEE_OS_PAGEABLE_V2_BIN)
>> TF_A_FLAGS_SPMC_AT_EL_n  = $(TF_A_FLAGS_BL32_OPTEE) SPD=opteed
>> ...
>> #TF_A_FLAGS += $(TF_A_FLAGS_SPMC_AT_EL_$(SPMC_AT_EL))
>>
>> The last line shows that OP_TEE flags are **NOT** added to TF_A_FLAGS build flags.
>> The qemu_v8_cca.mk build file was copied from qemu_v8.mk, which itself has the OP-TEE inclusion.
>>
>> ---
>>
>> Recently, I had to generate a custom rootfs, and I experimented generating it directly from docker images, to avoid rebuilding the world using Buildroot. Once it worked, I realized it was a good opportunity to rebuild the rest of the stack too. The result is 'qemu-linux-stack' [2].
>>
>> Master branch has only tf-a + uboot (no Realm support), while rme branch [3], which supports Realm, uses tf-a + rmm + edk2 instead. I removed u-boot as I couldn't get it to boot, and I knew that edk2 worked.
>>
>> One branch is only one configuration (and it will stay this way).
>>
>> [2] https://github.com/pbo-linaro/qemu-linux-stack
>> [3] https://github.com/pbo-linaro/qemu-linux-stack/tree/rme
>>
>> Beyond the personal knowledge I got through that, I hope it can be used for others for who it's confusing about what runs before start_kernel, and I guess I'm not the only one who didn't know about that. In the end, things are not too complicated, but as most of the build systems out there (OP-TEE build, shrinkwrap, ...) try to be "generic and versatile", it ends up being complicated. I prefer basic and straightforward script shells to lenghty documentation and wiki pages, but it's a personal choice.
>>
>> ---
>>
>> Now, coming to the change introduced by this series, and supporting FEAT_SCTRL2 and FEAT_TCR2, all those images need to be updated [0], [1], [2], [3], because essentially, TF-A itself must be patched to support this. I was about to mention that, and mention that I can send a PR directly to it once we have this merged on QEMU side.
>>
>> The change in arm-trusted-firmware is quite simple:
>>
>> +diff --git a/plat/qemu/common/common.mk b/plat/qemu/common/common.mk
>> +index 751511cf8..6bc108492 100644
>> +--- a/plat/qemu/common/common.mk
>> ++++ b/plat/qemu/common/common.mk
>> +@@ -122,6 +122,10 @@ ENABLE_FEAT_FGT         :=      2
>> + # 8.7
>> + ENABLE_FEAT_HCX             :=      2
>> +
>> ++# 8.8
>> ++ENABLE_FEAT_TCR2    :=      2
>> ++ENABLE_FEAT_SCTLR2  :=      2
>> ++
>>
>> I'll push all that tomorrow on master, and rebase rmm and device_passthrough on top of it.
>> I'll add this to original RME images, it's less direct though, as it's needed to update the tf-a fork, and then the optee build system.
> 
> So, I still fail to understand how you are generating the out/bin/flash.bin used in our images.
> 
> First I tried to use the https://github.com/pbo-linaro/qemu-rme-stack, since it's cited in the tests. I tried:
> 
> $ ./container.sh ./build_virt.sh
> 
> and get an error which seems a commit mismatch in some of branches used by repo:
> 
> repo: reusing existing repo client checkout in /mnt/git/qemu-rme-stack
> Traceback (most recent call last):
>     File "/mnt/git/qemu-rme-stack/.repo/repo/main.py", line 869, in <module>
>       _Main(sys.argv[1:])
>     File "/mnt/git/qemu-rme-stack/.repo/repo/main.py", line 845, in _Main
>       result = repo._Run(name, gopts, argv) or 0
>                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     File "/mnt/git/qemu-rme-stack/.repo/repo/main.py", line 293, in _Run
>       result = run()
>                ^^^^^
>     File "/mnt/git/qemu-rme-stack/.repo/repo/main.py", line 274, in <lambda>
>       lambda: self._RunLong(name, gopts, argv, git_trace2_event_log) or 0
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     File "/mnt/git/qemu-rme-stack/.repo/repo/main.py", line 437, in _RunLong
>       execute_command()
>     File "/mnt/git/qemu-rme-stack/.repo/repo/main.py", line 403, in execute_command
>       execute_command_helper()
>     File "/mnt/git/qemu-rme-stack/.repo/repo/main.py", line 369, in execute_command_helper
>       result = cmd.Execute(copts, cargs)
>                ^^^^^^^^^^^^^^^^^^^^^^^^^
>     File "/mnt/git/qemu-rme-stack/.repo/repo/subcmds/init.py", line 400, in Execute
>       self._SyncManifest(opt)
>     File "/mnt/git/qemu-rme-stack/.repo/repo/subcmds/init.py", line 146, in _SyncManifest
>       if not self.manifest.manifestProject.Sync(
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     File "/mnt/git/qemu-rme-stack/.repo/repo/project.py", line 4704, in Sync
>       self.MetaBranchSwitch(submodules=submodules, verbose=verbose)
>     File "/mnt/git/qemu-rme-stack/.repo/repo/project.py", line 4173, in MetaBranchSwitch
>       self.Sync_LocalHalf(syncbuf, submodules=submodules, verbose=verbose)
>     File "/mnt/git/qemu-rme-stack/.repo/repo/project.py", line 1636, in Sync_LocalHalf
>       lost = self._revlist(not_rev(revid), HEAD)
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     File "/mnt/git/qemu-rme-stack/.repo/repo/project.py", line 3676, in _revlist
>       return self.work_git.rev_list(*a, **kw)
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     File "/mnt/git/qemu-rme-stack/.repo/repo/project.py", line 3908, in rev_list
>       p.Wait()
>     File "/mnt/git/qemu-rme-stack/.repo/repo/git_command.py", line 556, in Wait
>       self.VerifyCommand()
>     File "/mnt/git/qemu-rme-stack/.repo/repo/git_command.py", line 546, in VerifyCommand
>       raise GitCommandError(
> git_command.GitCommandError: GitCommandError: 'rev-list ^6fd1cc667671a12cfc8789a390c990446e621f8f HEAD --' on manifests failed
> stderr: fatal: bad revision 'HEAD'
> 

I'm not sure what is happening. I gave it a try now (from a clean repo), 
and it works as expected. I had weird errors when stopping sync with 
ctrl-c in the past too. Anyway, clean and retry.

> 
> Then I tried to build it from https://github.com/pbo-linaro/qemu-linux-stack/tree/rme and out/flash.bin
> simply doesn't boot the kernel...
>

Maybe you built previously master branch, then switched to rme and 
rebuilt. In this case, your kernel and tf-a are not updated. I added a 
note in README, there is no dependency check when switching branches, 
you're expected to run git clean by yourself.
Both shrinkwrap and OP-TEE build don't really handle that properly to be 
honest...

It's not ideal, but I don't want to go down the rabbit hole of 
reimplementing any kind of half baked Make based dependency graph.
Maybe we could use git submodules or repo in the future, but both have 
their own drawbacks too.

> 
>> Sorry for this very long email. At least, all is there.
> 
> Nope, that's quite helpful. This firmware stack is a mess :)
> 
> 
> Cheers,
> Gustavo


