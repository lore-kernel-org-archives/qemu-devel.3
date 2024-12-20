Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2F9E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOadn-0006yh-A6; Fri, 20 Dec 2024 05:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOadl-0006y9-Ej
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 05:53:53 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOadj-0002qP-Pm
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 05:53:53 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso17790755e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 02:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734692030; x=1735296830; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hg+YJQn0624TSszQmG8fkRhmQOLHzpqyuh9XL94aFTo=;
 b=TF+cA0EOT5j5USPnXlgmN4mLiMsDDSGAsFvO9ceSQ7I5LIez+rbjZkxn4kpGE/HPRx
 DqgI3Sjwo5N5+aSg4CJJqt4h0vSQR2fiz/PGAqLSXSiVUPaq1JbCxcf/Q8cvpASbxRT+
 vXP3EsKOK8pYLz6nU0N23PNaOIQGp1XLDFyhwCfLrjw/1XfIQuQzqnroYW+00eRkA19l
 9LjFcqzcvxq+dISYSjrvPgT9Orubwm7MDtkT4CLk+KUc+XH6V2bM2u4v8mSgePQPWWa6
 EoCaEdu6hu8fFA9JycoC8fnpbUYzo8kquSYKj4GlisMXtUu1X693nklBvSw6Ss1gWCsu
 gTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734692030; x=1735296830;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hg+YJQn0624TSszQmG8fkRhmQOLHzpqyuh9XL94aFTo=;
 b=LbwaiVdf+V/P8EyI1qaTwNl+9skgmktiFktU8/9LD15zm+szdMNBwVlnonHZ8eHVq8
 4kcQ+6i5bEPLFgHXUeITt/M5jLMibg0NqwanG7bacAxze3u3pnCqSub+tibl8S66du1c
 wvOg4SZEkaLOb1yaioO2R6hhAXuNg+1F8UdSY2/Uv0l+l5iWyidC6sa7uimSWjzLHwe9
 F1+D/zL7tkQpIqenUvsSCLokd3l+yMGSVEz03OIvmVyMS+6HR46VlcZFEqnk8nB5jUP3
 rUGoVRRZlWvQ73anH8GHNQSw65dLBbNcRpOPUbroVAEjk4TKbJTG/FAKAhm35UMQDKXJ
 nLiA==
X-Gm-Message-State: AOJu0YxnuNQbia+cbraBH/sTDRos2p3uYgUC2T4RP7K0sNQidf3UHvRi
 Ef+7G/Rf/7fEknlfRYaNPwtr73HGo6ytWiNteXaJbpSQd02Bxl03SQa2gEzHctE=
X-Gm-Gg: ASbGncuzUniiXRkGwFhrFfiOe1PnVuRKf/Uo7mLDVtdNv8vnODvV7QkZaGdxOBZHs+o
 3hF2pFyyuVwBKm7kKNl3BIrjxkT44zV58biccX1jbNwEUI5QteuPrtIyRC2XbI4TTrnS84Qh26d
 8VMwBdzIY6gwhr7pcSCNUC6+IEn2NIZZO8nUs5k4V/HSdXcsZnZaMXZskNrQfLqRucmY32SC+9X
 uKSPOyiwy6QKCx/VBSgjxYa817P14LABy+KN5FtezmVxQKIlhDeLK2CfDK2GIGCxDGhrc0=
X-Google-Smtp-Source: AGHT+IHsdV+oZOZIS6Qys1YExqB40lTSpL8a6Yg9i+TuSc3JqOjmphJP7MvExs3FpDHfVWjlGznRkw==
X-Received: by 2002:a05:600c:3c9b:b0:434:ff30:a159 with SMTP id
 5b1f17b1804b1-4366790f1a3mr23791095e9.0.1734692030242; 
 Fri, 20 Dec 2024 02:53:50 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c515sm42666095e9.30.2024.12.20.02.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 02:53:49 -0800 (PST)
Message-ID: <ee023925-c34a-437d-b2d9-657be8e14f51@linaro.org>
Date: Fri, 20 Dec 2024 11:53:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/10] hw/misc/vmcoreinfo: Implement 'vmcore-info'
 object
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 devel@lists.libvirt.org
References: <20241219153857.57450-1-philmd@linaro.org>
 <20241219153857.57450-9-philmd@linaro.org>
 <CAMxuvayAVM4UvDjnSKEMD59YZpCgYVQHMVXkBrbTf3S79zRQ7g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAMxuvayAVM4UvDjnSKEMD59YZpCgYVQHMVXkBrbTf3S79zRQ7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 20/12/24 09:50, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Dec 19, 2024 at 7:39 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> 'vmcore-info' object allow to transition from '-device'
>> to 'object', following the deprecation process.
>>
> 
> Is there a strong motivation behind this? just replacing -device with
> -object doesn't really give anything, does it?

No. (Daniel mentioned the same on the cover letter:
https://lore.kernel.org/qemu-devel/2ae4799b-f78d-4fde-becb-9ee7f767e8f1@linaro.org/)

Sorry for wasting review cycles.

> Also I'd rather keep the name "vmcoreinfo" since that's how it used to
> be, and also the name used by the kernel ELF etc.
> 
>> No need to modify VMCoreInfoState since DeviceState
>> already inherits from Object state.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/misc/vmcoreinfo.h |  4 ++-
>>   hw/misc/vmcoreinfo.c         | 48 +++++++++++++++++++++++++++++++++++-
>>   2 files changed, 50 insertions(+), 2 deletions(-)


