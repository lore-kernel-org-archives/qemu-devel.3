Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2689AE9273E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 17:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaHO4-0003T1-PM; Mon, 29 Dec 2025 12:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaHO3-0003Rx-7q
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 12:50:31 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaHO1-0003k0-Pb
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 12:50:31 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7b8bbf16b71so9202554b3a.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 09:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767030628; x=1767635428; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NMJvl+26zye/uc6N8hPetEtCSv2kkfCtjjQWUsWfol8=;
 b=CRJkdZei0wytMIcABr7VpzsInWHKa8yEK3eTLIdnxT82ibFbRWpXYgOJM32IGPUqFl
 MRR7vuhdzGVa7JyoL7ROjV0P+7h3hc436d/7Ek3rlRLPAKH1ByJfWt8FVHwXqrBs3iJU
 2FuDpZuhmKqIIj1DueC5z0LjtjBxmSM1mJ2B64G3c8CkiHIsoi2TU0sSRbYWr/m0Uagn
 ucdpBLsLwZ0ogI7N852say4o8JxT8Vtlav7ri6hmsdkYbmoUdwm9BaNiA+RBH8+6WKLY
 0VyMvdKbjLtMX/SJalcIPpPdMZxj23dlBToTIk0dTLqjpxjx0bE8KQb/m3ALYHmtxCoe
 qapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767030628; x=1767635428;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NMJvl+26zye/uc6N8hPetEtCSv2kkfCtjjQWUsWfol8=;
 b=Zxd1GjoX/aC61ossOxfF4otBCst7bBNCRV5H1r6n9C7ssdnbxbMG7L+M2wsx4c5NzV
 69WbulGGpMZM8YEtKyLnlK89wUXBVOT2k5raJO5NSbxt4/Bs9JJpCh2cYJgRtNLJqOQ0
 5EXJrgaDBkJjxXiGLs7/g+CbTTTMteC6QNRaQbgguAjHC7eql+H7cDC4Vx6dUHuNI9HP
 JDC3kCzqB5g066lmWGSLtRfsuHQadsfbPgFMYISrjftN0mncJjfVaDVDYYyd0Ou8XH1y
 xGGMu90IfawJaOnlFW+mJm22uYgT8tPfbiJhA1cXHbBfXWhKvmTiz93sXtRO+O/0FYEP
 UnkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0oWU67Kby6PsJ2NfSOVXCsgLwuOm3VSgyHFbjS0PEKBupEMyVEeQmFp5LbX0AKfzTvGBni7vlaQzl@nongnu.org
X-Gm-Message-State: AOJu0YycoEW6ZPUn47vLTzGVz9ZvCErtVKdtbPpbWyoVLYar29YcVeue
 +ooJJ2pX2aADMnCSrbB8aw2LN7Lr7pQIoLpsfwntbcKgmdwJu+K1jlqLK2kBjUjvzew=
X-Gm-Gg: AY/fxX629Di/CDWnT/XEPG/nGGYF4sz2G3COU9dyzkzN75v0pc7h9z76Y46IRjOmSp/
 9l1DhDaeC7wCABu3D755UbuWfJVk5iV3GQJiTqt6w9ex75Cfa3h7pCWqYBYHKAxqoskB2ENfoef
 aLpYp4wzoz6q+YPIKR2ShdGrEt9SONaC9gsTQ6EYKKwEPp0Hzsxw14nbLD76s4D0oPJ2DllAm93
 /9N/gLXlpH0EoO9DCVGOogoUEqTm0c2rZb1tR6EWTawFGlGbze+OjtBcqpIt7y/jO6aWW/8z3Jg
 tpDZCzxI6l2Mhj3u4pZHRIlHQBHmCrLvnOCJX/7CFrfKHYw3kPoLAACuNafppTl8GoSb/H5zLBr
 X43s0homOYoxnyoQKxV43JwdByBAZeA6z/9ZVIaxrDGbGcxWXHf2KMl1xHp5rGP1cdtLsoZY1k/
 VW7xNHYH2828gvL+GBHzja/KR2lUdEpNqqdTjTZvnFFuKD4It1MPP79xGZ5lwnxIiZTus=
X-Google-Smtp-Source: AGHT+IGWKwlx6v7gYluQ1MLIMhcafWyUo/A9TAcRutAdcXVCZWqG3IA4aGb+/LU8vGsEZaPt18WRVw==
X-Received: by 2002:a05:6a00:4c83:b0:7a2:710d:43e7 with SMTP id
 d2e1a72fcca58-7ff648ede90mr25019660b3a.24.1767030628311; 
 Mon, 29 Dec 2025 09:50:28 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7b31c479sm29978778b3a.24.2025.12.29.09.50.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Dec 2025 09:50:27 -0800 (PST)
Message-ID: <52121d27-59ae-4547-8c07-90514f1f2d74@linaro.org>
Date: Mon, 29 Dec 2025 09:50:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 05/28] tests: data: update AArch64 ACPI tables
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
 <20251228235422.30383-6-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251228235422.30383-6-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 12/28/25 3:53 PM, Mohamed Mediouni wrote:
> After the previous commit introducing GICv3 + GICv2m configurations,
> update the AArch64 ACPI table for the its=off case.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 164 -> 188 bytes
>   tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>   2 files changed, 1 deletion(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


