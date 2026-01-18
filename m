Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0B9C9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhasU-0008Al-P0; Sun, 18 Jan 2026 17:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhas3-0007rz-Dz
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:03:45 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhas1-0000Ps-EV
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:03:42 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4801d98cf39so14063785e9.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773820; x=1769378620; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FaZNk12IqzS05+aUpzyIrcevxknb2qrEovM9BwTaCGo=;
 b=XbuKK7uZEJNauF/GjSU9N+aZn8Q+67PHXqJO1pwBeaVVb5QPkI8y0t4W1VVNzkgY5k
 cnRhHFdzD4m2EjoFqI9BI1gGVucydMJ9vVZjWOAMrt6ZCpl+HzKuQZ82tsjdArDCuuGF
 lW5WOleAA02FopT00P5dxeZnwn/OKNKJeJN/XaBTDk6cWTsoVF8Bpn1dIyN6M98XKvcq
 MI/HUNbTuV6E5EfJJJaLDG/d9xlMDkzGkpETIi7I5TkSv+scwh9ukOmC7vH0GwjsWPrS
 EVmQE+le0A5tnlsNHkSl0xQHDIRfeQz06Z0qyGUd/kPuLf7bABC3WR0e6kLr34hlGOv3
 NnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773820; x=1769378620;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FaZNk12IqzS05+aUpzyIrcevxknb2qrEovM9BwTaCGo=;
 b=QZfUwSEp45bNaOKBRORNQ+w70oQqE8UZKxeaYcWdRXu7lyBQ+S5yPKFU5VY/Sp2Qdh
 b/0uh1UE+zmB2++k3xa0sfNVEXrLhDl5bH68MqNM05Xz200YBHNsTQA8/SPECORtOo3d
 5NsO78Ijg1OgcshkhNg9FwHEQYiqtYsSU6OldvBJ/fpdGlqBQQoqjeQZo9H/VartAYfo
 nZ3C0Wl/CtFy6NyYbzz25x7NMG1hb4G77dad3uIwFK0MT9i/RsIZFgqIacol0knT71vL
 05aqGmYjVLEtAnBqBGdaFQFM7a7E+21EpliljwvYDJgrQLLPIxo5O+2TICdncZ5NI77C
 8msQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVPskJhOBtIWV2nlrNyu66lr1VVb0HaES4NXqI7p3K/ymOtxEBKuTGM0w1wjmwoVoLvEfD3jar30+2@nongnu.org
X-Gm-Message-State: AOJu0YzL39mgG69bxW9ywMC6EoldVBMwyBISec2i5UpZlyvcOhQOC/Cq
 niYI0na8mAh2+bvibnM+1DUAVSwRoWRmAUfPygezGBz4ccqJqEvOeE3lhMinRbevLjSO56CK95r
 fYwAaVt0=
X-Gm-Gg: AY/fxX6DGaVjUikpbMagybrmVR+SqERdVJyc5CgJdXiR64LHNLmXLaDDbfWvdCCaJa9
 ZyW8a8C108VI9j4oR2lwv3Cga8Hz9+C5x37QIpVzcp6nbGv55n1JHKBy5ITiCPnsKG2QTRWOueF
 f6UhEo3B/jHy0GcFgRG98Vu/gLh3cM2aWwdiZVHmZj8uAGGAysr0dt7jgT1/oBSoK/qSM1UCUCj
 /0l9RWnOqyW7nElYwSCmbjiBBDUM69nc6xD9K/16JUc8S4CIjQPTeWh0vR4l4C7I5+5AOELZzBg
 lQ4YUS1O1ryeEHL6aZONLyZGJ5+DoBSsGABC3J7kn4jTUhe0hxYOio1M2cDcjwki5FNChh2t3GL
 Qv3jC05dXn4l3cIZj38r9/MZ9MqQqSBLZu6Plg2J9rdZ2jvmE9TIj89SAjDs6vBzoVhfiIs57Ix
 KHEOl57YaTNzTgOLVp/eYTuDK2qyTUEcINKclxV71aZSno1iHafDNa/A==
X-Received: by 2002:a05:600c:3b8e:b0:47e:de23:dd6f with SMTP id
 5b1f17b1804b1-4801eac0a1dmr101632225e9.12.1768773819837; 
 Sun, 18 Jan 2026 14:03:39 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e879537sm160228885e9.5.2026.01.18.14.03.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 14:03:39 -0800 (PST)
Message-ID: <8af2b03c-6fc3-48c6-a307-7d49d38532b4@linaro.org>
Date: Sun, 18 Jan 2026 23:03:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 51/59] hw/arm/virt: Warn when HVF doesn't report IPA
 bit length
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>
References: <20251028054238.14949-1-philmd@linaro.org>
 <20251028054238.14949-52-philmd@linaro.org>
 <cd27bf13-a8ef-4b7a-bfea-0e4220091ec1@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cd27bf13-a8ef-4b7a-bfea-0e4220091ec1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 28/10/25 13:07, Richard Henderson wrote:
> On 10/28/25 06:42, Philippe Mathieu-Daudé wrote:
>> Emit a warning when HVF doesn't return the IPA bit length
>> and return -1 as "this accelerator is not usable", allowing
>> QEMU to try with the next one (when using '-accel hvf:tcg').
>>
>> Reported-by: Ivan Krasilnikov
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2981
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/arm/virt.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 175023897a7..1d65fa471dc 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -3225,8 +3225,12 @@ static int 
>> virt_hvf_get_physical_address_range(MachineState *ms)
>>   {
>>       VirtMachineState *vms = VIRT_MACHINE(ms);
>> -    int default_ipa_size = hvf_arm_get_default_ipa_bit_size();
>> -    int max_ipa_size = hvf_arm_get_max_ipa_bit_size();
>> +    uint32_t default_ipa_size = hvf_arm_get_default_ipa_bit_size();
>> +    uint32_t max_ipa_size = hvf_arm_get_max_ipa_bit_size();
>> +    if (!default_ipa_size || !max_ipa_size) {
>> +        warn_report("HVF didn't report IPA bit length");
>> +        return -1;
>> +    }
> 
> I suppose this goes back to the previous patch.
> It might have been slightly less confusing to merge them, but the 
> underlying questions about when and how this can fail remain.

Right. I'm dropping this patch.

