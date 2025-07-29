Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3827BC83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 07:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugeW8-0007ku-G8; Tue, 29 Jul 2025 03:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugeW4-0007hG-7v
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 03:12:52 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugeW2-00047n-9J
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 03:12:51 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4561514c7f0so50049695e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 00:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753773168; x=1754377968; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8+HDPO0mHdpjFtanzf0XYaatNRpGhx7CdnNlogMCenw=;
 b=Iw+AWnbjh5HgF2cRELi+b20b0qp12TuBa+kdjMcerx3cm6JZ/RSgGTAci9X2Cb/JHJ
 CeV56eTEVNdM95LnmUxu7wrWg3cl+izA9inR5BTbHSVurmSMdBy+KG8SaLJGnyi4TjDu
 9lCJ2lp7qRzrqCu+KwYnezL6fwlXfaiGRhP9HdoWWFPjhBhwHIMXCCL4oqDIwflZ6gm+
 pXZdbVtN/jwefFNO86sze3Zlnv99Uz4hWJQ2CBgXbwazivSfbiqWBhCmzxaCxcDKSgs6
 H3bNCnIAVFvh41f9qJ9dpoLr9OwRKlx77sbngcYaPb5eIIqDOfVLl+bxaywRAV1vTip9
 J6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753773168; x=1754377968;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8+HDPO0mHdpjFtanzf0XYaatNRpGhx7CdnNlogMCenw=;
 b=AZ/8myZzh18nJyy0aJKtwJjLqr4lZKhOcSO2mVhABd3gQUJywEtxZS4u9RGSzRYaKA
 CewsISH5YwHK3yLbdIbDa2Qogz5pQ9FIfGSE2y7mW/W4Xj7aFR7W03HwCC6FrHFuVRCC
 dXNXg1EbJFtuYF9h5HN8fxEcM8T5GF5tN4JZ87H08PdGDb0FIBIIVeMe9uLwpoW08/w6
 pitnd3u7r6sXiddWoOHlcrAdmxo45VasfpLvjlb/h9FHeZik2URsEtP9W8/wrqmPzeka
 IKj2bHSl8ZAvGfCJUXDpo/vZLgBfgkSkFcH6rsW94py1DV0KDL6lL8bPLxIF8/nnER/X
 jxZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmLd4yrrkrvia5kpM5UzvOzmRWOnAjHgAmEa6ZbqjnyJWdGiIkLcZdezS5VzFpQL9JoExQltTtnpYA@nongnu.org
X-Gm-Message-State: AOJu0Yw2euwMw5QkAfkvpCTjIR4qFLc+JEqiYrosQKLg6h8FJnrczxAF
 xNIW9+FDxVxtMed7BYVr4yDCg1H7YdQZ3qm/W5DpLdOSKxWkEo9EVv8g3k7PaOGKALe9uLmDEpJ
 k5g5y
X-Gm-Gg: ASbGncuqBVY6XtzOn36srwA+pbx33wy7lf4TYvjHv71/ToWy3+tfpyZnQHm7HpT7+bX
 X2OhZhK6JU83NakuBoNSdMDhX5cNzvTktyUGVXt6nM/eco4AvBt5hQL6ENsD6X3YADDQ+G96Ozr
 UO5VgUY4053koNMtr8hrOKPCqtm52JCoF5HzDFXrrAX1o5j8Epihn+RMxLMNdw/TSGtXMpSFPaC
 Kw/Lnf9VpScAJpavahaf5C80Cr8FXnlfl8iQTxfuf3oTZ0hO6B4bJITdjiC1WXPs+QunSJpvLPg
 07RnhyGVys6WNlwp/eyCLYdZ4j4waLnH732OJyxOKgGB4mi2MF8GvJPiEPECNhoW/Khbb1x6scP
 BwqStc8YyMWqXl6W/FqPYBYGpNiUb2KbZBBTlxCOn/nHY78FFXZsrF0tD4knkjLVVIg==
X-Google-Smtp-Source: AGHT+IFOSx6JeSyiVzNWdA1QNlp01+dlrwGo45/YrrgGPsOgGnLe0JZFPO2w2FGMzBDh6GdgVhyogg==
X-Received: by 2002:a05:600c:1992:b0:455:fc16:9eb3 with SMTP id
 5b1f17b1804b1-45876656c6fmr98418825e9.33.1753773167649; 
 Tue, 29 Jul 2025 00:12:47 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45888e48c6fsm60463415e9.1.2025.07.29.00.12.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 00:12:47 -0700 (PDT)
Message-ID: <9515c06c-f636-4bd3-8534-56a7dd8562e5@linaro.org>
Date: Tue, 29 Jul 2025 09:12:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i386/kvm: Get X86MachineState in kvm_arch_init()
 without the cast check
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org
References: <20250729062014.1669578-1-xiaoyao.li@intel.com>
 <20250729062014.1669578-2-xiaoyao.li@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250729062014.1669578-2-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 29/7/25 08:20, Xiaoyao Li wrote:
> Commit 8f54bbd0b4d9 ("x86: Check for machine state object class before
> typecasting it") added back the object_dynamic_cast() check before
> casting MachineState to X86MachineState. And commit 035d1ef26565 ("i386:
> Add ratelimit for bus locks acquired in guest") followed it.
> 
> The reason to check object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE)
> before commit 8f54bbd0b4d9 was that smm was not supported for microvm
> machine at that time. But after commit 8f54bbd0b4d9, smm is supported
> for all x86 machines (both pc and microvm). And since it's the
> target-specifc implementation of kvm_arch_init() in target/i386/kvm/kvm.c,
> I don't see how it would be called for other machines than x86machine,
> and why the check of object_dynamic_cast() is needed.
> 
> Drop the object_dynamic_cast() check and simplify the code.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   target/i386/kvm/kvm.c | 22 +++++++++-------------
>   1 file changed, 9 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


