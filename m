Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0908C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSeY-0005CZ-LY; Mon, 14 Jul 2025 19:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ubSdR-0004Sa-OY
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:31:02 -0400
Received: from mail-vk1-xa42.google.com ([2607:f8b0:4864:20::a42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ubSdO-0001eQ-GJ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:31:00 -0400
Received: by mail-vk1-xa42.google.com with SMTP id
 71dfb90a1353d-535ae7eeebeso4347101e0c.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752535854; x=1753140654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X75wJIItq4OqbIAPklTwtODvxkpfw/gyst8okQEwAP4=;
 b=DbjC8u70spIao9LMU2W849rNF7Z6NW2ypCMk0zVCUD5WLIq5qBLUfB6UTusW2nMONT
 1hjHWzs4k46pn2LxAZeLn8TZOFpp76wEzVbxM9V6HftHRps5CfhXEgszVGwAkocJKYrS
 jdvU4uAvIjLriDxJAkFXl35Z6CLc/UswKLiHkjUgFlERcZA4qGT+9ilx2Ou/9jS6nb3/
 ZarMVaeOKL/dzCe+WJfvUd2hq3fQeEeaa41UJkUwMxouf9mAKu7aR786Q8houzQfrmdn
 g5foXxd+CmSm4HpSJZAIcNoOPuwivY6bG9qEbsS2FNCDsHztbWt1fyy2l4krbPXaUI2K
 oP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752535854; x=1753140654;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X75wJIItq4OqbIAPklTwtODvxkpfw/gyst8okQEwAP4=;
 b=SiPCxmocD5A8pV56OPoorM/CaGc7Fj8PfKbIVqYhDLWIR7zEQZftC4TRMlSiPitYrr
 tPqqFHbWt5JwmKpAixIfuGsuUxxJDUM0Zyl/06YiA6TVkAta3jWdNaDgtjo67OI7NIo+
 im761yVKNUs8Vsxm7nPs+grx30kWD4nYmjonNDmdAyUOFz3vCgBQasE2LjQkn1jZl91m
 8Whd0SsHsXUFsKsLHc1obsKsbTUGC79HBEc3J7xg1HPZkg1w3twKmYUpF3I0BccNjdGf
 +q0PqO7yVPotyZ9YDMuz8pprk6V+hc9jiKjmr4wuuMJez0jo1HkbOmwgBHSo9vGzdvnd
 jK3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCValuiHIxx/ug+QbfDZ6E9XxKrIyCl1v8dwQeCZb459TpoO/nRhZmaJqr2sQX6bxWZVqqf2vM+0dbhU@nongnu.org
X-Gm-Message-State: AOJu0YxWpEUR2xtMCHD5MwWB7+Kl1R5Q8p0JEaPh39tpMTOptUGmMJRJ
 9EcypuvWyE7LC8GpTWXgaFPNFwQZPPTXIwDMl/Wd8LfB6Rtz+9T58l+6xJAiW+H+vqA=
X-Gm-Gg: ASbGncvXj9DgMHrdZl3wPPhCxIDUlyU0PhyriCLifnv/s+iM1x1lhgNP/tBHvxJTkRS
 FVIJEdvWVybSErlF5SbnBbS6JUDUNwkJ8BwGBBvbqbFn95MxyFw73actpOcWYHFEH4I7+u7w9Fv
 OoxmtPv3Pv+P2q8+CwTofWi+BsUvRz0QKfhkOEResBH40hp+egsi6N/WCKBMxX7lTx9Ysi5nQ/M
 d/leB5uWy7sGR+DNVAEu8YHj0T2/V1RZAUu1v7Hi3+2ESUOaI7Ar5VtKdI2ZDLUu/yAZnkjMKXf
 rb1gJltac6HWNK6nlKixLDycAEB+K1DS/+p1ZLcyCUkxgGJD4h4522RnwGTRncSOVVq7mcXWGm1
 QzU79XjX6OV0yYyNcStLuHh0YuYQERSa6pvb3oenq8bZcVGp/dC5hgbICDNa890bT
X-Google-Smtp-Source: AGHT+IGc+MFaR1v0MiVIFZcsUipBslOF+8lH7n0MDixoBhL8lZ7FRP7Kz4oQngH5Z1HpOSGv10yCLA==
X-Received: by 2002:a05:6122:8ca:b0:523:dd87:fe95 with SMTP id
 71dfb90a1353d-5373247a137mr258702e0c.9.1752535853873; 
 Mon, 14 Jul 2025 16:30:53 -0700 (PDT)
Received: from [192.168.0.102] (189-47-46-41.dsl.telesp.net.br. [189.47.46.41])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-535e73dbae0sm1971061e0c.46.2025.07.14.16.30.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 16:30:53 -0700 (PDT)
Message-ID: <f984d041-5d23-41c8-b2d5-c79217a7f77b@linaro.org>
Date: Mon, 14 Jul 2025 20:31:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/4] target/arm: Add FEAT_MEC to max cpu
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250714155836.1514748-1-richard.henderson@linaro.org>
 <97292e35-b7f2-40ca-aed6-34ef39396433@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <97292e35-b7f2-40ca-aed6-34ef39396433@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a42;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa42.google.com
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

Hi folks,

Richard, thanks for v8. Pierrick, thanks for testing it. :)

On 7/14/25 14:09, Pierrick Bouvier wrote:
> On 7/14/25 8:58 AM, Richard Henderson wrote:
>> Changes for v8:
>>    - Re-order SCTLR2 and TCR2 so that they are independent of MEC.
>>    - Enable the SCTLR2 and TCR2 enable bits.
>>    - Squash 3 smaller MEC patches together.
>>
>> This still fails the RME tests, because we still need TF-A rebuilt
>> with ENABLE_FEAT_SCTLR2 and ENABLE_FEAT_TCR2.  Pierrick, since you
>> have just done such a build, could you re-test with this series?
>>
> 
> I tested that on my local Realm enabled setup and I can confirm this solved the issue and current series works.
> Both flags are needed in TF-A. ENABLE_FEAT_TCR2 is needed to boot host, and ENABLE_FEAT_SCTLR2 is needed to boot nested guest.

I'm a bit confused because the QEMU RME tests, afaics, uses OP-TEE, not TF-A. I've built TF-A
using the scripts in [0], enabling ENABLE_FEAT_TCR2 and ENABLE_FEAT_SCTLR2, but no way to get
it booting. I understand we can embed a OP-TEE into the TF_A via BL32=<optee_image> when
building TF-A. Is that what you're using?

Thanks.


Cheers,
Gustavo

[0] https://github.com/pbo-linaro/qemu-linux-stack.git

> As I'm off today, I'll update that properly tomorrow when I have time, and not rush things. I'll update RME images for sbsa and virt tests + device passthrough test, and post associated patches.
> 
> Thanks,
> Pierrick


