Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85BBC02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQBA-0001Bi-J7; Mon, 13 Jan 2025 14:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXQB4-0001B5-Ff
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:32:46 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXQB2-0004ze-S7
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:32:46 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21670dce0a7so99966095ad.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 11:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736796763; x=1737401563; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4ov2bSdALrFYAy5nxZDetn7TmiPVPRW0fJBPLm96grY=;
 b=OaOw895zxJ4s8K3g/6/HoieTJiwXsrr5Fc9jbgcV6Prn+C4JBsMEg1vgwO91NO83qI
 67Ep5L9+ukvYwt0PZziH3w9RjFbdzPx7T1yIHHbj1DxCayoFmgrIhMtpxXyZAJ6BvBw6
 D8R5nSslRvQQUeE7QP7bdSZ61U9ncDh/qLYWPTHP73JmfDVPy0e6ZNZ4kbQl7plKj/Ov
 VjSe4LQWfiPnuybmtLSED1IgiJ50b7+rYy5BIdL17lq9LHSCyjHu5VEooa5yum5yc8Va
 ldkrSCJOQ12jR9tctBOiix7nIdVwRiGNYrlE7hm8YVvizm66xNiklrwq095CKlbDoC99
 QeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736796763; x=1737401563;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4ov2bSdALrFYAy5nxZDetn7TmiPVPRW0fJBPLm96grY=;
 b=MQNes18e27HoAsbuqoHQjqsxDsB6sWSenl8wlh69nyZJza1d/eO0rmNy6x5+6KHasq
 yNN/ZGrSE3RgVJ7dEZLmzMqoT09SulA93RBtwsVBUD6qI+VX7Lhg+Ic0tdgy/D+7YA91
 oj01O6FIDtjq0OJnwlRpxKmRlGV+Ouw7FA1rMzTNCfxMAYn5lDRDi0Cx9raMfki8Qs0+
 CanNGt+smFGtz16wsxhirZuzWvYzZTMM00dYwiiRIeQm4VVg0VOSKZn7pgKrKtm6q5TB
 Iaa+EtI3nMo07xuwqBmIlWa0QtJYU39G8hgpgbEzeB8sZ3ZGg9VLnKFh5/eSUOVK950o
 P86Q==
X-Gm-Message-State: AOJu0YzmBLXRo1QsaQW+tBk0hYq+AhSIgv4oorBDWuc70ebzHYstyDYX
 b3Dr1Vi05gNORgrcgr37b6XGKJfvE7xNZTIQ5mhV80YcmQ4IfjotcTbIvXVyS0o=
X-Gm-Gg: ASbGnctvTGNhnMJFPoS0b69yQQBHa4eSTTiU1WFjqSP+bFPicgAonNRLSeXyT3Aw/Qy
 yNgT4s0uTEBc4R5MBlM0zIIBxx9sqJYc9doub80SE/tdZlmDsSYKXRFdPbzDrjWLi9RbSv6LNej
 sL1zGDD+I3pKrcGkNnasggGjWhKg5YNk7D87WuFTfO5XhFF9/TOodQGy0wdn7yHrJMBtslgK37N
 moinitwSPW0SUO6LiUpqNf61OcOldAhrnAR+Bxn2WfOeMZyMCIraTR/UW7oogeAK3Xvbg==
X-Google-Smtp-Source: AGHT+IG5Ooa8+sFqnGL19qgItzPGcWtXg/xU1EiKGw0gnV9YAEnpnFwst3vaichpcL+77B10z04k9A==
X-Received: by 2002:a05:6a21:9182:b0:1e1:bdae:e04d with SMTP id
 adf61e73a8af0-1e88d0e0c0cmr37167945637.36.1736796762722; 
 Mon, 13 Jan 2025 11:32:42 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a318e056063sm6182257a12.31.2025.01.13.11.32.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2025 11:32:42 -0800 (PST)
Message-ID: <359e6921-fe3d-4f53-8ba9-5cf2b7ab6a6d@linaro.org>
Date: Mon, 13 Jan 2025 11:32:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Change default pointer authentication algorithm on
 aarch64 to impdef
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Fabiano Rosas <farosas@suse.de>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, alex.bennee@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20241219183211.3493974-1-pierrick.bouvier@linaro.org>
 <CAFEAcA_ChARwKyvRXsEk1U3q1T2528753Eu7LgDSsDbF1s5tNQ@mail.gmail.com>
 <CAFEAcA_SHz2a0ZU=3e9AmZyJ_qn3e7nNhNm-hR9MdiTRjOyqWg@mail.gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA_SHz2a0ZU=3e9AmZyJ_qn3e7nNhNm-hR9MdiTRjOyqWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 1/13/25 04:34, Peter Maydell wrote:
> On Fri, 10 Jan 2025 at 16:28, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Thu, 19 Dec 2024 at 18:32, Pierrick Bouvier
>> <pierrick.bouvier@linaro.org> wrote:
>>>
>>> qemu-system-aarch64 default pointer authentication (QARMA5) is expensive, we
>>> spent up to 50% of the emulation time running it (when using TCG).
>>>
>>> Switching to pauth-impdef=on is often given as a solution to speed up execution.
>>> Thus we talked about making it the new default.
>>>
>>> The first patch introduce a new property (pauth-qarma5) to allow to select
>>> current default algorithm.
>>> The second one change the default.
>>> The third one updates documentation.
>>>
>>> v2:
>>> - ensure we don't break migration compatibility, by using a specific backward
>>>    compatible property.
>>> - added some documentation about migration for arm virt machine model.
>>
>> Other than a minor change to the 3rd docs patch which I'll note there:
>> applied to target-arm.next, thanks.
> 
> I just noticed that this series breaks 'make check-tcg', because
> the pauth-3 test is explicitly checking the output of the
> pointer-auth operation. I'm going to add in this patch, which
> goes between patches 1 and 2 of this series:
> 
> Author: Peter Maydell <peter.maydell@linaro.org>
> Date:   Mon Jan 13 11:42:57 2025 +0000
> 
>      tests/tcg/aarch64: force qarma5 for pauth-3 test
> 
>      The pauth-3 test explicitly tests that a computation of the
>      pointer-authentication produces the expected result.  This means that
>      it must be run with the QARMA5 algorithm.
> 
>      Explicitly set the pauth algorithm when running this test, so that it
>      doesn't break when we change the default algorithm the 'max' CPU
>      uses.
> 
>      Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> diff --git a/tests/tcg/aarch64/Makefile.softmmu-target
> b/tests/tcg/aarch64/Makefile.softmmu-target
> index d08d9b01ded..9c52475b7ae 100644
> --- a/tests/tcg/aarch64/Makefile.softmmu-target
> +++ b/tests/tcg/aarch64/Makefile.softmmu-target
> @@ -91,6 +91,9 @@ EXTRA_RUNS+=run-memory-replay
> 
>   ifneq ($(CROSS_CC_HAS_ARMV8_3),)
>   pauth-3: CFLAGS += $(CROSS_CC_HAS_ARMV8_3)
> +# This test explicitly checks the output of the pauth operation so we
> +# must force the use of the QARMA5 algorithm for it.
> +run-pauth-3: QEMU_BASE_MACHINE=-M virt -cpu max,pauth-qarma5=on -display none
>   else
>   pauth-3:
>          $(call skip-test, "BUILD of $@", "missing compiler support")
> 
> 
> thanks
> -- PMM

Thanks Peter.

I'm a bit surprised because I ran all tests , and didn't find any failure.

I use container 'debian-all-test-cross' and ran 'make check-tcg'. Is the 
container missing something that doesn't trigger this test?

