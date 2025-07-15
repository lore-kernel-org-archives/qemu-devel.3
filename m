Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77422C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 01:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubURJ-0001Ej-ES; Mon, 14 Jul 2025 21:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubURG-0001DF-Uw
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 21:26:34 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubURE-0003Ww-Qa
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 21:26:34 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-747fba9f962so4046699b3a.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 18:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752542778; x=1753147578; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zch/ntOiPIKaIhdSGDojWcEDYwEo9ck8xYTypkJYbj0=;
 b=ix3kb5ZHVViwBE8AXveeqHzQ+gY18WFf0iVolV/kOa4FxNZScQFeiapOJzYLLelXMO
 qmmreXQ2s4TFyJDUOxcgLGx+YztzM2svJ2GLSpL/D2Uht6NpQDof1B8n+Moq7xdxYPrq
 1QRf5Z7jaUKDmk4HfaXSIti25F2eYGz1KNmN+Z7vz9k1SH26mfiyUz6Gr+lrzrQAr3fT
 /CcEaK4dgJDsY6/pB57EAvxRiwYGsiz58LAM1u/1Jcx6R0qBcxPkwkYyG7rPN6NCdA4U
 cu8VL2zHlHckwKhv1LuyWqBKXcrgPfXQ8AVo4+2IoS2Gmydvptl5MVnNal5YclH8hVHe
 Rsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752542778; x=1753147578;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zch/ntOiPIKaIhdSGDojWcEDYwEo9ck8xYTypkJYbj0=;
 b=OiNoO1gnm7J9TT27NorirlKQjAdcU/myHvbRx35CKvLX505eGAqQYdSaaLL6YXGjH+
 7Zzv6VjzAbCDHAav9xuu/G5QhFkcv6qzD5AnGf/r6V9ZpzEUPDqrnnQYE2I9vPvXuKg/
 NAJJOA+WnidjLB1Tp+BLzZ2FuEXqftt8C6P8/rc6PBHi+y0ysYztYkxSDqwNPClUqf4+
 mS1xJUYrNLCZxwOzEWv1258kQUtVEyTILZYYVmVRyi8R2yTBjXWVjpvHeNII0bhElthV
 yzrxDgpM4WPzJ2dHoClp2C1tu9aimo0gJX+FhHyfHycPVrtIuxqLPpdRc8HqSBf4wjtB
 vD2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/mK+Hbts4N5OJ4j9Glu1957cvcJiBAmryQvBDVtFxuxZMILZiaf1HY2Dn8tJq2hEnwsbKs0k/2n8A@nongnu.org
X-Gm-Message-State: AOJu0Yx1HDMuX/blTFbTeVupVBEQnezCgN8USc8u/37QKIuvY1dcUoCO
 kbc1ne4QT5w9PyVNDULWzE8g17rUFispgdMRz8xV1bu8vjxv8xdrKkVqg1Ggmd0K2E0oemgdqDA
 ygtjb
X-Gm-Gg: ASbGncu8JcWCYxkCXRnI7QxWpU5NVzg7PqqJ8/1fEO3tpW9NZMArcF/QEjciQknkqeA
 Ql2c4zlMB8CIHvpGP/dagy2tM5gptkiYunXJY2wGq5eg9C2OyY6HrwA3LumaZWZzNmuyc/uu1Fl
 bUsiIvlvTEsCJs5anvd55V5yght/mzTFlwDBHxYPQF7+RiaXoLaqeejcftfPBg2dYRlq6wWQUmT
 2Moq+hEJFn9m+FSrniJJhDPI3yWUAH4yXJQ0WHXf5+NMhm1Ezq60k5d54QkOG3RC3PGKn05oRqF
 DB4+zMtUpc0gjnts6JDogiPhFrrqH5HGF/ANnluyFdsaOnuqNnfOp6ICIX0LCgPv5qxymgcqu57
 QO+qhDikZUuLrRsHkaYn8vtejYq5ATcyA2xg=
X-Google-Smtp-Source: AGHT+IHF3NfaeBYNxB0Ki02qPP7zhITdcJ4Z/zp0LNnMvDVHyXBFgPnPT1Q8hUwOpov1fSUavEyODg==
X-Received: by 2002:a05:6a00:1489:b0:736:9f2e:1357 with SMTP id
 d2e1a72fcca58-75583e21b51mr2483947b3a.12.1752542778341; 
 Mon, 14 Jul 2025 18:26:18 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f8f878sm10849262b3a.166.2025.07.14.18.26.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 18:26:17 -0700 (PDT)
Message-ID: <a7ecb907-2183-4625-a2bf-bbfc25acc77d@linaro.org>
Date: Mon, 14 Jul 2025 18:26:17 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <f984d041-5d23-41c8-b2d5-c79217a7f77b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 7/14/25 4:31 PM, Gustavo Romero wrote:
> Hi folks,
> 
> Richard, thanks for v8. Pierrick, thanks for testing it. :)
> 
> On 7/14/25 14:09, Pierrick Bouvier wrote:
>> On 7/14/25 8:58 AM, Richard Henderson wrote:
>>> Changes for v8:
>>>     - Re-order SCTLR2 and TCR2 so that they are independent of MEC.
>>>     - Enable the SCTLR2 and TCR2 enable bits.
>>>     - Squash 3 smaller MEC patches together.
>>>
>>> This still fails the RME tests, because we still need TF-A rebuilt
>>> with ENABLE_FEAT_SCTLR2 and ENABLE_FEAT_TCR2.  Pierrick, since you
>>> have just done such a build, could you re-test with this series?
>>>
>>
>> I tested that on my local Realm enabled setup and I can confirm this solved the issue and current series works.
>> Both flags are needed in TF-A. ENABLE_FEAT_TCR2 is needed to boot host, and ENABLE_FEAT_SCTLR2 is needed to boot nested guest.
> 
> I'm a bit confused because the QEMU RME tests, afaics, uses OP-TEE, not TF-A. I've built TF-A
> using the scripts in [0], enabling ENABLE_FEAT_TCR2 and ENABLE_FEAT_SCTLR2, but no way to get
> it booting. I understand we can embed a OP-TEE into the TF_A via BL32=<optee_image> when
> building TF-A. Is that what you're using?
> 

I agree it's confusing. In short, no, OP-TEE is not used anywhere for 
Realms, only TF-A and RMM are used in our images. It seems that OP-TEE 
is a term used generically to represent any firmware running in secure 
mode, but it's a *totally* different software than TF-A + RMM. Naming 
OP-TEE like this is like if Linux would have been named "OP-kernel".

The RME tests we have are based on this excellent tutorial [0], and 
build is automated with 'qemu-rme-stack' [1], that simply follows those 
instructions.

[0] 
https://linaro.atlassian.net/wiki/spaces/QEMU/pages/30128767027/Device+Assignment+Enabled+RME+Stack+on+QEMU
[1] https://github.com/pbo-linaro/qemu-rme-stack

To add to the confusion (*get ready*), [0] uses OP-TEE build, which is 
simply a build system for op-tee + other things, but in the variant it 
generates, OP-TEE itself is not included. Yes, that's utterly confusing 
and took me quite some time to discover it, after talking with Mathieu 
himself. They removed it explicitely to make the stack more simple. In 
short, for Realms, forget about OP-TEE.

If you want to see it by yourself:

https://git.codelinaro.org/linaro/dcap/op-tee-4.2.0/build/-/blob/cca/v8/qemu_v8_cca.mk?ref_type=heads#L172

...
TF_A_FLAGS ?= \
	BL33=$(BL33_BIN) \
	PLAT=qemu \
	QEMU_USE_GIC_DRIVER=$(TFA_GIC_DRIVER) \
	DEBUG=$(TF_A_DEBUG) \
	LOG_LEVEL=$(TF_A_LOGLVL) \
	ENABLE_RME=1 \
	RMM=$(RMM_BIN)
...
TF_A_FLAGS_BL32_OPTEE  = BL32=$(OPTEE_OS_HEADER_V2_BIN)
TF_A_FLAGS_BL32_OPTEE += BL32_EXTRA1=$(OPTEE_OS_PAGER_V2_BIN)
TF_A_FLAGS_BL32_OPTEE += BL32_EXTRA2=$(OPTEE_OS_PAGEABLE_V2_BIN)
TF_A_FLAGS_SPMC_AT_EL_n  = $(TF_A_FLAGS_BL32_OPTEE) SPD=opteed
...
#TF_A_FLAGS += $(TF_A_FLAGS_SPMC_AT_EL_$(SPMC_AT_EL))

The last line shows that OP_TEE flags are **NOT** added to TF_A_FLAGS 
build flags.
The qemu_v8_cca.mk build file was copied from qemu_v8.mk, which itself 
has the OP-TEE inclusion.

---

Recently, I had to generate a custom rootfs, and I experimented 
generating it directly from docker images, to avoid rebuilding the world 
using Buildroot. Once it worked, I realized it was a good opportunity to 
rebuild the rest of the stack too. The result is 'qemu-linux-stack' [2].

Master branch has only tf-a + uboot (no Realm support), while rme branch 
[3], which supports Realm, uses tf-a + rmm + edk2 instead. I removed 
u-boot as I couldn't get it to boot, and I knew that edk2 worked.

One branch is only one configuration (and it will stay this way).

[2] https://github.com/pbo-linaro/qemu-linux-stack
[3] https://github.com/pbo-linaro/qemu-linux-stack/tree/rme

Beyond the personal knowledge I got through that, I hope it can be used 
for others for who it's confusing about what runs before start_kernel, 
and I guess I'm not the only one who didn't know about that. In the end, 
things are not too complicated, but as most of the build systems out 
there (OP-TEE build, shrinkwrap, ...) try to be "generic and versatile", 
it ends up being complicated. I prefer basic and straightforward script 
shells to lenghty documentation and wiki pages, but it's a personal choice.

---

Now, coming to the change introduced by this series, and supporting 
FEAT_SCTRL2 and FEAT_TCR2, all those images need to be updated [0], [1], 
[2], [3], because essentially, TF-A itself must be patched to support 
this. I was about to mention that, and mention that I can send a PR 
directly to it once we have this merged on QEMU side.

The change in arm-trusted-firmware is quite simple:

+diff --git a/plat/qemu/common/common.mk b/plat/qemu/common/common.mk
+index 751511cf8..6bc108492 100644
+--- a/plat/qemu/common/common.mk
++++ b/plat/qemu/common/common.mk
+@@ -122,6 +122,10 @@ ENABLE_FEAT_FGT         :=      2
+ # 8.7
+ ENABLE_FEAT_HCX             :=      2
+
++# 8.8
++ENABLE_FEAT_TCR2    :=      2
++ENABLE_FEAT_SCTLR2  :=      2
++

I'll push all that tomorrow on master, and rebase rmm and 
device_passthrough on top of it.
I'll add this to original RME images, it's less direct though, as it's 
needed to update the tf-a fork, and then the optee build system.

Sorry for this very long email. At least, all is there.

> Thanks.
> 
> 
> Cheers,
> Gustavo
> 
> [0] https://github.com/pbo-linaro/qemu-linux-stack.git
> 
>> As I'm off today, I'll update that properly tomorrow when I have time, and not rush things. I'll update RME images for sbsa and virt tests + device passthrough test, and post associated patches.
>>
>> Thanks,
>> Pierrick
> 


