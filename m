Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050BCC28B25
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqECQ-0003QY-9G; Thu, 06 Mar 2025 11:35:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqECJ-0003On-KV
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:35:47 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqECI-00040d-08
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:35:47 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso17887415ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741278944; x=1741883744; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XAgfEPaoGHSZq07mbdjEXSxpSubJXrriPtuulftaiNs=;
 b=GhoYwYo9pKvHids2sX9XG31ag3B8p+cCAmdxZ7tzDJos01Fd8FSpCpWvl/b5VK0nWD
 6A4TZLXt5r44cLICRvM8OXZvbaZPQLinqOrNznLRIaAvDZZCJ3WQLNIZlQ5b8fwUVMI0
 rS/Zuo96UYjuSjrqXDsqpOpHUbMqxs5jrCBLp/pKixA1ocYKbAB6QM94P84ftbOEWBae
 VXmXg0Shsx8gIgoEaKs6/iU7tk72GuNsUZPGzewKS7hynAq8FHiQpe/M4ZsasMQ8i4Na
 tPhTjdE8T42Zy4bNznhQeNty5f5dRUlfD/RqsQmh7GvN9qQ4IpM8MBKN8t7Z9WXX8nin
 InGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741278944; x=1741883744;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XAgfEPaoGHSZq07mbdjEXSxpSubJXrriPtuulftaiNs=;
 b=Ls2fNd9spuULx8JVihPJxZwczNumOODt7THLP64QeFoCzDVWxsVldaqUmZaLWuT0h2
 VfNVsUD1zSbP0FoE9mhK3Ur9LXBKNHwjolmyljxxiQtFE6LnP40S3GR1DQcLxWMxdkGw
 ZUqLQ3zJTLvfhRSKW4UIUAialmcfPlCkFX0h0YCDv4fCHP58RGiXC+UV2lmlBU1fgS66
 64c1PqIyJunCwC2y00ywrTLFucK6/54tYwJ57bHRSTcYTB2QSSO9/tFBHl0K/dZmgmWc
 QXxTZj/B9Emf+uFd9AqlmpCjMR/56jlM9ivIZP/IhZJ826ABtLJ9FHYKueKZtzgX1Sni
 fMAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVMsh9aBf25SIHFmXqO5uQzech/veZMCrJrtQp5dSjO5X/98vnqzA2k+YRID64hyY6HezvJiE+T/Mq@nongnu.org
X-Gm-Message-State: AOJu0YzSn1RuLdCwfgLxRaX2IgmSzxUDAoh/bi/x1+eyDtMS4up4RryT
 OwfdB+6RKdAsP8s40oT37IvDvzb5VaBJKNtMMM1XCP683Q0iAX+4WOP2kGVugOQ=
X-Gm-Gg: ASbGnctCium5hrf2i0PRoDn85UWWUPmjlJfuq/6AUvt45xQ2Rnb40NF1yyqmCbKJPL5
 MztwPn94gOzCbmHqlSRlv7S5mMSVEUcBYHHDG9qD7Rg3m+6BoVLD/C8xbHO5/v/w3qSDGToxEIg
 uVCHLxLW7UbrxK0nfz14XgCfOhQ2PkbA9cUuhlbWR6gJYcrLC9a7sqkopHAMjVEK1eUYotlwBv7
 sgBYoxPeeD3ZcggExT2HkhuW9dQcTZRqwsna1/fpj//r2htUSIes6tXnacaG+oRlnFoS7Qj87Wy
 Ea/5Bn1WXwVR/G+EMqYRA+IXnM4Duw0kTjwIuQ4L1IMt8pNIQhiME308Ag==
X-Google-Smtp-Source: AGHT+IFEcsPPTb++NpYeNs25boDWH44SnjrXjA5LUkchp6XeuV57Gmop2Z0lHg35HUzrTyjL9tiNsw==
X-Received: by 2002:a17:902:e802:b0:221:89e6:ccb6 with SMTP id
 d9443c01a7336-22427071ce8mr2054765ad.25.1741278944389; 
 Thu, 06 Mar 2025 08:35:44 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109ddbf2sm14609215ad.18.2025.03.06.08.35.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 08:35:43 -0800 (PST)
Message-ID: <9604ac56-4fff-40da-a95a-57bca9d88251@linaro.org>
Date: Thu, 6 Mar 2025 08:35:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] hw/hyperv: remove duplication compilation units
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, manos.pitsidianakis@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, alex.bennee@linaro.org
References: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
 <0226e9d5-edbc-417a-8cf0-8c752f52b7ed@linaro.org>
 <badcb867-64db-4b45-93b0-fd4ff203c35a@linaro.org>
In-Reply-To: <badcb867-64db-4b45-93b0-fd4ff203c35a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/6/25 08:35, Pierrick Bouvier wrote:
> On 3/6/25 08:26, Richard Henderson wrote:
>> On 3/5/25 22:41, Pierrick Bouvier wrote:
>>> Work towards having a single binary, by removing duplicated object files.
>>>
>>> hw/hyperv/hyperv.c was excluded at this time, because it depends on target
>>> dependent symbols:
>>> - from system/kvm.h
>>>        - kvm_check_extension
>>>        - kvm_vm_ioctl
>>> - from exec/cpu-all.h | memory_ldst_phys.h.inc
>>>        - ldq_phys
>>>
>>> Pierrick Bouvier (7):
>>>      hw/hyperv/hv-balloon-stub: common compilation unit
>>>      hw/hyperv/hyperv.h: header cleanup
>>>      hw/hyperv/vmbus: common compilation unit
>>>      hw/hyperv/hyperv-proto: move SYNDBG definition from target/i386
>>>      hw/hyperv/syndbg: common compilation unit
>>>      hw/hyperv/balloon: common balloon compilation units
>>>      hw/hyperv/hyperv_testdev: common compilation unit
>>>
>>>     include/hw/hyperv/hyperv-proto.h | 12 ++++++++
>>>     include/hw/hyperv/hyperv.h       |  4 ++-
>>>     target/i386/kvm/hyperv-proto.h   | 12 --------
>>>     hw/hyperv/syndbg.c               |  7 +++--
>>>     hw/hyperv/vmbus.c                | 50 ++++++++++++++++----------------
>>>     hw/hyperv/meson.build            |  9 +++---
>>>     6 files changed, 49 insertions(+), 45 deletions(-)
>>>
>>
>> I'm reasonably certain that hyperv is specific to x86.
> 
> That's correct.
> 

But potentially could be extended to arm64 one day as well.

>> Are these only "duplicated" because of qemu-system-{i386,x86_64}?
>>
> 
> Yes. A lot of duplications in hw/ is related to 32/64bits variants.
> 
>>
>> r~
> 


