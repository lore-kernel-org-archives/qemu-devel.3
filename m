Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2EDC83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 03:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubsZl-0005WR-Ni; Tue, 15 Jul 2025 23:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ubsZj-0005RX-N8
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 23:12:55 -0400
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ubsZf-0007dS-Nz
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 23:12:55 -0400
Received: by mail-ua1-x941.google.com with SMTP id
 a1e0cc1a2514c-884f2b3bc2eso2499244241.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 20:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752635570; x=1753240370; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m+PfM5ZHY9OuxDgQlZyLsykzYAwecLDm0E9VEcWMvKk=;
 b=spzKPwUK2clZCHf729BdAO9itcxhnekYiQ1Dj14qaxAHBoM1rH30vCOf/CLaJFyB59
 BIa4Isld/fQUXygiV0Ovnca1EJE/IdfsZmeMQXecRaoYzcoq01VB2H5MJqRp5cFtvkea
 SwdUwypwpD/JyZpWspZ3FMAaHVrKl/EQBXec8vPibN1CnCxVbsihhPwdR5tdEn+luBvj
 Fjpt3U9HwH1dHNJ84kl0huBqBW0o9kdoSG1hkKeM3oj/LkcxHYM/svGVPKcwcYnabqG+
 y32JVOwcbLNIqe4Arz7Xif2/GaiaS3f/W7gjEZSK++cur44oSeVR0fb+BTFclnKRVLTc
 Ed9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752635570; x=1753240370;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m+PfM5ZHY9OuxDgQlZyLsykzYAwecLDm0E9VEcWMvKk=;
 b=ifg5UtaaNgFsCMw+lezdgJbWA+nIVXn/lOe5dRcnroZ/7+sw8Wq8wFIoUQNO1ZRGmY
 7nEPbGEpNwUqs+s6S6tQ9/xvGISuT9sOBmc/hqzfMubMa5SiNwoL0rzUaQntG1R0x22q
 tdB5lOzUF/vOQ0E+NO1M1Phs8uZAKp/7/tFXX1610bV+gNdDF9wBLl3uvZrVIUZweEtv
 kpmg0Cx/15LNHOS3PlyUQ1cPb0jUGQXDmpYhl6BtrdH3V5w9p9V8VWFqS5plUJeCaMcz
 OeQ7r5RwhuvBbmlOqzL0ZnWjLhbZBL/n62lImnxohpFyKpzm1CPc9xQvpP9vRd+1I1cT
 SZNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKnADiW50p3oS7665x2fNRjosJiBYiIPIQ3ToJfRxSSLvmmE/Q2/NyGRtV9+1aykEkuEju0PdSgc7O@nongnu.org
X-Gm-Message-State: AOJu0YypSdz29x/HMOzLKCREi+f72X92L+mYYMXupWKhRCXsqngTqkCh
 L+yke7CS7jWrZbEUiagatREnHNNbWs366cWatJZwj0gZ5CTJiJtz60i2ioyPaiEPF9bEkKy1FRj
 tTHCoGrjxVA==
X-Gm-Gg: ASbGncstmfLimXNtjRREAAhbfNnEj0YyMrCHBhS77c1A6mnrikcmdLLwPYmKX/M9Iib
 uyvwmBdPxCf9y9/MqsvQ/Z4W1p6jl36TM3bUANoEr1bMhK67URsk823NKzmmtUe5qofx6szH0DL
 RGX9mUkMlrgesZE+koPpSM4l2AfV8fZG9uzTm8wzo1HAzOvmedP8+6lHjHLzyrL8ztOijc5BZI0
 MC9pUcXyI1+BhFK1DTr6QN+BnF0yrXm3k+bCBXL2LBf3Xps++PcwCzK+oO4Ihp/vz+j7JQfSBdY
 TmTtjIdeq8y/v+3Hvz87c91yIv8iQ9Dn9VxfIRFII9/agpLrOwgyAguG0WDhkWBVGJokkqgdSW/
 63EWI58QYzaFiCbDvpAtTC6rI+XBr7ijNMqSm5qX3sSbr1LTlpxze7levHzUD1O7S
X-Google-Smtp-Source: AGHT+IGKtfmq/I6F/e4wHznYqu6WPFxtx2mDRZNFK4MSmguyY6tZCIlCWJoln0wdXSP8w7cybXn6QQ==
X-Received: by 2002:a05:6102:3ed0:b0:4e5:a394:16cb with SMTP id
 ada2fe7eead31-4f955adbfa4mr406067137.7.1752635569803; 
 Tue, 15 Jul 2025 20:12:49 -0700 (PDT)
Received: from [192.168.0.102] (189-47-46-41.dsl.telesp.net.br. [189.47.46.41])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-888ebe6bcf8sm2792986241.0.2025.07.15.20.12.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 20:12:49 -0700 (PDT)
Message-ID: <a4696a6f-9a7b-4ecf-aecc-90b2596ec9e4@linaro.org>
Date: Wed, 16 Jul 2025 00:13:36 -0300
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
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <a7ecb907-2183-4625-a2bf-bbfc25acc77d@linaro.org>
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

Hi Pierrick,

On 7/14/25 22:26, Pierrick Bouvier wrote:
> On 7/14/25 4:31 PM, Gustavo Romero wrote:
>> Hi folks,
>>
>> Richard, thanks for v8. Pierrick, thanks for testing it. :)
>>
>> On 7/14/25 14:09, Pierrick Bouvier wrote:
>>> On 7/14/25 8:58 AM, Richard Henderson wrote:
>>>> Changes for v8:
>>>>     - Re-order SCTLR2 and TCR2 so that they are independent of MEC.
>>>>     - Enable the SCTLR2 and TCR2 enable bits.
>>>>     - Squash 3 smaller MEC patches together.
>>>>
>>>> This still fails the RME tests, because we still need TF-A rebuilt
>>>> with ENABLE_FEAT_SCTLR2 and ENABLE_FEAT_TCR2.  Pierrick, since you
>>>> have just done such a build, could you re-test with this series?
>>>>
>>>
>>> I tested that on my local Realm enabled setup and I can confirm this solved the issue and current series works.
>>> Both flags are needed in TF-A. ENABLE_FEAT_TCR2 is needed to boot host, and ENABLE_FEAT_SCTLR2 is needed to boot nested guest.
>>
>> I'm a bit confused because the QEMU RME tests, afaics, uses OP-TEE, not TF-A. I've built TF-A
>> using the scripts in [0], enabling ENABLE_FEAT_TCR2 and ENABLE_FEAT_SCTLR2, but no way to get
>> it booting. I understand we can embed a OP-TEE into the TF_A via BL32=<optee_image> when
>> building TF-A. Is that what you're using?
>>
> 
> I agree it's confusing. In short, no, OP-TEE is not used anywhere for Realms, only TF-A and RMM are used in our images. It seems that OP-TEE is a term used generically to represent any firmware running in secure mode, but it's a *totally* different software than TF-A + RMM. Naming OP-TEE like this is like if Linux would have been named "OP-kernel".

Got it, so we use TF-A + RMM in the test images. Thanks for the clarifications.

Isn't the generic term (or concept) actually TEE (not OP-TEE) and OP-TEE is a real software stack that implements the TEE spec, i.e., OP-TEE is code in https://github.com/OP-TEE)?


> The RME tests we have are based on this excellent tutorial [0], and build is automated with 'qemu-rme-stack' [1], that simply follows those instructions.
> 
> [0] https://linaro.atlassian.net/wiki/spaces/QEMU/pages/30128767027/Device+Assignment+Enabled+RME+Stack+on+QEMU

Should [0] be:

https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/Building+an+RME+stack+for+QEMU ?


> [1] https://github.com/pbo-linaro/qemu-rme-stack
> 
> To add to the confusion (*get ready*), [0] uses OP-TEE build, which is simply a build system for op-tee + other things, but in the variant it generates, OP-TEE itself is not included. Yes, that's utterly confusing and took me quite some time to discover it, after talking with Mathieu himself. They removed it explicitely to make the stack more simple. In short, for Realms, forget about OP-TEE.

ah, that's what confused me! I see now.


> If you want to see it by yourself:
> 
> https://git.codelinaro.org/linaro/dcap/op-tee-4.2.0/build/-/blob/cca/v8/qemu_v8_cca.mk?ref_type=heads#L172
> 
> ...
> TF_A_FLAGS ?= \
>      BL33=$(BL33_BIN) \
>      PLAT=qemu \
>      QEMU_USE_GIC_DRIVER=$(TFA_GIC_DRIVER) \
>      DEBUG=$(TF_A_DEBUG) \
>      LOG_LEVEL=$(TF_A_LOGLVL) \
>      ENABLE_RME=1 \
>      RMM=$(RMM_BIN)
> ...
> TF_A_FLAGS_BL32_OPTEE  = BL32=$(OPTEE_OS_HEADER_V2_BIN)
> TF_A_FLAGS_BL32_OPTEE += BL32_EXTRA1=$(OPTEE_OS_PAGER_V2_BIN)
> TF_A_FLAGS_BL32_OPTEE += BL32_EXTRA2=$(OPTEE_OS_PAGEABLE_V2_BIN)
> TF_A_FLAGS_SPMC_AT_EL_n  = $(TF_A_FLAGS_BL32_OPTEE) SPD=opteed
> ...
> #TF_A_FLAGS += $(TF_A_FLAGS_SPMC_AT_EL_$(SPMC_AT_EL))
> 
> The last line shows that OP_TEE flags are **NOT** added to TF_A_FLAGS build flags.
> The qemu_v8_cca.mk build file was copied from qemu_v8.mk, which itself has the OP-TEE inclusion.
> 
> ---
> 
> Recently, I had to generate a custom rootfs, and I experimented generating it directly from docker images, to avoid rebuilding the world using Buildroot. Once it worked, I realized it was a good opportunity to rebuild the rest of the stack too. The result is 'qemu-linux-stack' [2].
> 
> Master branch has only tf-a + uboot (no Realm support), while rme branch [3], which supports Realm, uses tf-a + rmm + edk2 instead. I removed u-boot as I couldn't get it to boot, and I knew that edk2 worked.
> 
> One branch is only one configuration (and it will stay this way).
> 
> [2] https://github.com/pbo-linaro/qemu-linux-stack
> [3] https://github.com/pbo-linaro/qemu-linux-stack/tree/rme
> 
> Beyond the personal knowledge I got through that, I hope it can be used for others for who it's confusing about what runs before start_kernel, and I guess I'm not the only one who didn't know about that. In the end, things are not too complicated, but as most of the build systems out there (OP-TEE build, shrinkwrap, ...) try to be "generic and versatile", it ends up being complicated. I prefer basic and straightforward script shells to lenghty documentation and wiki pages, but it's a personal choice.
> 
> ---
> 
> Now, coming to the change introduced by this series, and supporting FEAT_SCTRL2 and FEAT_TCR2, all those images need to be updated [0], [1], [2], [3], because essentially, TF-A itself must be patched to support this. I was about to mention that, and mention that I can send a PR directly to it once we have this merged on QEMU side.
> 
> The change in arm-trusted-firmware is quite simple:
> 
> +diff --git a/plat/qemu/common/common.mk b/plat/qemu/common/common.mk
> +index 751511cf8..6bc108492 100644
> +--- a/plat/qemu/common/common.mk
> ++++ b/plat/qemu/common/common.mk
> +@@ -122,6 +122,10 @@ ENABLE_FEAT_FGT         :=      2
> + # 8.7
> + ENABLE_FEAT_HCX             :=      2
> +
> ++# 8.8
> ++ENABLE_FEAT_TCR2    :=      2
> ++ENABLE_FEAT_SCTLR2  :=      2
> ++
> 
> I'll push all that tomorrow on master, and rebase rmm and device_passthrough on top of it.
> I'll add this to original RME images, it's less direct though, as it's needed to update the tf-a fork, and then the optee build system.

So, I still fail to understand how you are generating the out/bin/flash.bin used in our images.

First I tried to use the https://github.com/pbo-linaro/qemu-rme-stack, since it's cited in the tests. I tried:

$ ./container.sh ./build_virt.sh

and get an error which seems a commit mismatch in some of branches used by repo:

repo: reusing existing repo client checkout in /mnt/git/qemu-rme-stack
Traceback (most recent call last):
   File "/mnt/git/qemu-rme-stack/.repo/repo/main.py", line 869, in <module>
     _Main(sys.argv[1:])
   File "/mnt/git/qemu-rme-stack/.repo/repo/main.py", line 845, in _Main
     result = repo._Run(name, gopts, argv) or 0
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/mnt/git/qemu-rme-stack/.repo/repo/main.py", line 293, in _Run
     result = run()
              ^^^^^
   File "/mnt/git/qemu-rme-stack/.repo/repo/main.py", line 274, in <lambda>
     lambda: self._RunLong(name, gopts, argv, git_trace2_event_log) or 0
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/mnt/git/qemu-rme-stack/.repo/repo/main.py", line 437, in _RunLong
     execute_command()
   File "/mnt/git/qemu-rme-stack/.repo/repo/main.py", line 403, in execute_command
     execute_command_helper()
   File "/mnt/git/qemu-rme-stack/.repo/repo/main.py", line 369, in execute_command_helper
     result = cmd.Execute(copts, cargs)
              ^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/mnt/git/qemu-rme-stack/.repo/repo/subcmds/init.py", line 400, in Execute
     self._SyncManifest(opt)
   File "/mnt/git/qemu-rme-stack/.repo/repo/subcmds/init.py", line 146, in _SyncManifest
     if not self.manifest.manifestProject.Sync(
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/mnt/git/qemu-rme-stack/.repo/repo/project.py", line 4704, in Sync
     self.MetaBranchSwitch(submodules=submodules, verbose=verbose)
   File "/mnt/git/qemu-rme-stack/.repo/repo/project.py", line 4173, in MetaBranchSwitch
     self.Sync_LocalHalf(syncbuf, submodules=submodules, verbose=verbose)
   File "/mnt/git/qemu-rme-stack/.repo/repo/project.py", line 1636, in Sync_LocalHalf
     lost = self._revlist(not_rev(revid), HEAD)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/mnt/git/qemu-rme-stack/.repo/repo/project.py", line 3676, in _revlist
     return self.work_git.rev_list(*a, **kw)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/mnt/git/qemu-rme-stack/.repo/repo/project.py", line 3908, in rev_list
     p.Wait()
   File "/mnt/git/qemu-rme-stack/.repo/repo/git_command.py", line 556, in Wait
     self.VerifyCommand()
   File "/mnt/git/qemu-rme-stack/.repo/repo/git_command.py", line 546, in VerifyCommand
     raise GitCommandError(
git_command.GitCommandError: GitCommandError: 'rev-list ^6fd1cc667671a12cfc8789a390c990446e621f8f HEAD --' on manifests failed
stderr: fatal: bad revision 'HEAD'


Then I tried to build it from https://github.com/pbo-linaro/qemu-linux-stack/tree/rme and out/flash.bin
simply doesn't boot the kernel...


> Sorry for this very long email. At least, all is there.

Nope, that's quite helpful. This firmware stack is a mess :)


Cheers,
Gustavo

