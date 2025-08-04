Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC2BC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 21:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj2il-0004IZ-CD; Mon, 04 Aug 2025 17:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj2iM-0004Cj-Uw
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 17:27:30 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj2iJ-00015g-Gm
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 17:27:26 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-31efefd2655so3698373a91.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 14:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754342841; x=1754947641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DiBOPXvJDe3R1KzyVPGMdu1dw2Eaxd6/leRLY949d3Q=;
 b=qZ4TE3kS/TM0oU6LutiXQm4WdR+Ca6dZprVyl4pHeC/EEowUl/S0qAArEsJfLTM0Yn
 ZoVH/uHzABe3KeerC9Q0k2a3PF7pHUj328g/Ci87GBiCPqYqbRFZlnUkvIpHu4o+vfCQ
 JUI8cqLH86HS/9Q/1ZjWCnZVnfYB3j80jZ6KfxS0/PfAepvKBRD+SUGgWWNseEEjgzYU
 1Z/xL36BrgWT8QZ9AREbEprK6W35WxCh/Imw8FkSGaeoS4rVD73APDjYi6E8tN+K++G6
 f71utACHMz6nfGgXoSlQtKNvzBQITtWQgPzYRQUafNejp/v1c3QD9sDblWPX/AgiNVr1
 YRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754342841; x=1754947641;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DiBOPXvJDe3R1KzyVPGMdu1dw2Eaxd6/leRLY949d3Q=;
 b=rX2JfVbSSVu44xXETY1T5NpOPLWk/YrQUl35GlfA4yXjpGoN6CkyFKiSRs7ZUmllS/
 Ul8yppZZ7R20SJIJNaNiKPDRaZLV4snMaVwldfax90Xigl4u+Z2v5phSb9pda9WOKdj+
 oUJnAd4HFLjbFDYsw1c3btSNocVuAoFUzatM7oT2h+Fgv5nrAdtuWbsQye1ScGyn81sx
 Enh93CFasVJqWN/2gmqb2q1rsf/Xwuq1IpR+TvvjfWrJlzPpbiiHKwOcJt835chY0AXo
 XMlGvQPq/2rOSRK3DwI2HrUw7q6/coqbFBdOvQik2xs3gMZCrUqsSsx7acXnblfP3sH2
 AyOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAC8DEU8CTEJsAo+YljCm6VwZGW4h2jBloBVKJ1i90pAvPgICuXNAxzdf8FXOSjiHjhzfIBG978tgY@nongnu.org
X-Gm-Message-State: AOJu0YzP9mBBjPXq67jiXyZdRPRusJG5Xh+ZX1kZy1qq31LZP8pMhj4F
 X2qwAswsBxfhmtd2MwD+PYPLpywedP9s6FjdGJoCMtWnNwXiI4WqGzUPEYJeoz54If8=
X-Gm-Gg: ASbGnctCPKXh6Ms+oMtdVJcxuz1oqiLwN1ILGVEBUNZdLFFejE2HFc+Znt22pJC3sYs
 lBmAhjJg2WkB83g5mOO6N9Kz93wmV/ZX8pRxIYSEUoAcb946jO66vWfKMoo5kM20LQhCAd4z7Ge
 41LKMBZtV5UrC5DwzXBdAXo1trHnRjfpU9bYOLEdyIgUwW75YRa3PnkTgKTRaIaN7DNlQmg62YO
 c66x8m5celAwE9/y/azSYNNqHF8c3lZDRpiVTs3OmBIcEpaA2er5RSlmzl7uJedQoyt+mJv8wtH
 kYIVwf2PPOObmixqQ/OFstw5CXjAf8f7qoqivP+Cg9OEwcaOg2Sq4UYhOLkyLCZUa8rMYb/ebI4
 VsGXGg6XZg369QndMIWN1V9VTzGn3bhoqazI=
X-Google-Smtp-Source: AGHT+IG6GkhvwTgNEPW9CTuSRrzf89xhW8ZiKiSEfXIkrGG/f9i9KOA7QFDvqBYjaZW8hV7JDSDjGA==
X-Received: by 2002:a17:90b:1804:b0:312:dbcd:b94f with SMTP id
 98e67ed59e1d1-3214fe966c8mr1298763a91.11.1754342841262; 
 Mon, 04 Aug 2025 14:27:21 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63f0b4aesm15333525a91.26.2025.08.04.14.27.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 14:27:20 -0700 (PDT)
Message-ID: <4182240b-59bf-4bb3-ba73-e5c4216608e4@linaro.org>
Date: Mon, 4 Aug 2025 14:27:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/17] whpx: arm64: implement -cpu host
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-16-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250804142326.72947-16-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

On 8/4/25 7:23 AM, Mohamed Mediouni wrote:
> OpenProcessorKey and ReadRegU64 adapted from:
> https://github.com/FEX-Emu/FEX/blob/e6de17e72ef03aa88ba14fa0ec13163061608c74/Source/Windows/Common/CPUFeatures.cpp#L62
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/arm/virt.c              |   2 +-
>   target/arm/cpu64.c         |  19 ++++---
>   target/arm/whpx/whpx-all.c | 107 +++++++++++++++++++++++++++++++++++++
>   target/arm/whpx_arm.h      |   1 +
>   4 files changed, 122 insertions(+), 7 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Additional question, what is missing for SVE/SME support?

