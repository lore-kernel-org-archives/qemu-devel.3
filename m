Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D98E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 23:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQwsQ-0002Hj-Px; Thu, 26 Dec 2024 18:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQwsM-0002HR-RU
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 18:02:43 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQwsK-0006c7-HA
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 18:02:42 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43622354a3eso46903105e9.1
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 15:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735254159; x=1735858959; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9gnRzJSqB29W2nOTbblCcro+YVIcu8r+q+5lSv7lGE4=;
 b=mGWHpz/WiW1B1QhnbSg42vgMPb7A73Hrv5eGGxq0zYWeGXxtMZCLENwFfV0mF01H46
 iPCbeErhECXLv4tenirytwQMJOyVXR2svfpRpk3Anhy5dDwJDJUmqxPF76tDZQynRZvF
 Jl6iXPMTtuyOo84xdP2sZ8KP1+d9wNKz6JMyxkJif4d+6eVw12wHPHXpJJRKAEirl+Uf
 NMf95nwNYbBGOEHXfQBjWZBcCk0mkz6fFxfxTBiCSrXhp+tjrydC+I4Tj6pEPvPhgEyl
 eeP83YA8fN45s5eHJStzzY3G0R5mtRdxH9zoS0NRmq2Gq2N+xAnmph7lMohkIuGmWSY1
 Wn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735254159; x=1735858959;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9gnRzJSqB29W2nOTbblCcro+YVIcu8r+q+5lSv7lGE4=;
 b=pDfCm5w59qUmQgpMctxYRR3NdRB0wOiN4LBoTFPCojDDFrbSS3q+vlmJEelUiiCqXu
 BipQAa2tjZ4hoDmW8cbqMpkFqOjyXaBsjCokYHGTZkLP7IpBk8UheT3C8e8UtZ5jrJZ5
 EBuwUQwAJGP9q3MMScaq33sp4Fnol4SIZRtag8WVsNHb9mh9lMU71EYd3aK21wwXt9Be
 FEG61V9VndNtCaiQJ7YuPkvL8sgYRCGiKIV1DQF1Ty9zlvb8zcbAM25K6Ng1W3HPad7Z
 vKcNwZwXHsUiohl1V3Llg56riMqrrl/TGNyiV06nkPM9KqRfIoYyGHx9131bhEDEpOd4
 5HuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsMWNmEAW09JTCc3TpedFkLWbDcElVm10cWAl6MZSc+iTuldjIoAcmXaJUa/SuGK3/jICjG96wFeV3@nongnu.org
X-Gm-Message-State: AOJu0YzTC6q0iNt1Ogo6fREkCUlg4L1YYPkqWwtocAmDlGiRi8+HkmB5
 m6hI0RpuECqE3ivD0HfQnI0bcPej/VBaQaeV8zvPyaPyHP0se78GaQWx1wTQdIk=
X-Gm-Gg: ASbGnctnxHDi4oZtYrRrgYROehmst0BfykxigLd2K0Pp8zZlA3OMN0d3p9u34fOToNL
 Pn5flHA27H7rWYyb7iwAgKlwJfJTp1x2Nx6K0covwVmw1aJja4q3RMVIKBIFEzO3rQ6GHWliKmc
 HsmkAnyyeLLYNxlF0uohQN2EBM6uRM7Sir9i95HNBfcrID4KLRu33CAcmo263RzaJQOLCTBA9nK
 XXxy+uVEEeHSOAcjGopiJbe4zYTO4LB88GII9xwfxx4v+QeggzmRPjnvxo19XCfKKhaTzfySnx+
 K+AzMe8HlmdttBhWz9y9tug6VpLH/w==
X-Google-Smtp-Source: AGHT+IGFeBgQNTg4gCBy6YdEcAVvKArIzJ98JplL7oyn+YkbXr53CEOiZSjT24Y4uG6AF9bXbtaQfA==
X-Received: by 2002:a5d:584d:0:b0:385:e0d6:fb73 with SMTP id
 ffacd0b85a97d-38a221fa9cdmr20416924f8f.15.1735254158550; 
 Thu, 26 Dec 2024 15:02:38 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a457584bcsm2960097f8f.89.2024.12.26.15.02.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 15:02:38 -0800 (PST)
Message-ID: <3760c644-c5d4-4331-9d1b-059486bbd740@linaro.org>
Date: Fri, 27 Dec 2024 00:02:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/23] target/loongarch: Store some uint64_t values as
 target_ulong
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU devel <qemu-devel@nongnu.org>
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-6-0414594f8cb5@flygoat.com>
 <1f72e77a-5da9-4119-8e92-a707552f856f@linaro.org>
 <b31fde39-87f1-470b-86af-bb648caf6cfe@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b31fde39-87f1-470b-86af-bb648caf6cfe@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 26/12/24 23:58, Jiaxun Yang wrote:
> 
> 
> 在2024年12月26日十二月 下午10:48，Philippe Mathieu-Daudé写道：
>> On 26/12/24 22:19, Jiaxun Yang wrote:
>>> Store internal registers including GPRs, CSRs, and LBT scratchs
>>> as target_ulong, as per architecture specification.
>>>
>>> The only exception here is tlb_misc, as it's only used by QEMU
>>> internally and need keep to be 64bit to store all required fields.
>>>
>>> There is no migration ABI change, as target_ulong is uint64_t on
>>> existing loongarch64 builds anyway.
>>
>> I'm working on a prototype series where target_ulong becomes uint64_t
>> under TCG. This patch is going the opposite direction. Not sure what
>> to say at this point (I'm not rejecting it, just wondering).
> 
> Does this mean TCGv will always be 64bit?
> 
> I'm doing this just to keep all TCG _tl load/store sane. If that's the
> way to go, I'm happy to adopt full uint64_t approach.

"full uint64_t approach" won't happen before months (except if we get
more manpower).

The idea is to add all current generic TCG ops but taking an extra MemOp
argument, having the backend sign-extending / truncating.

