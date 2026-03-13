Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F322107BCC6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15Cs-0007VP-Vs; Fri, 13 Mar 2026 12:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Cd-0007Ue-Hu
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:17:32 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Cc-0006Ce-0T
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:17:31 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-829b2018c94so1448211b3a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773418648; x=1774023448; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=7DO5MoWRHHEFyAZwfWtYNfTk+gxpUay4exK4xOe88JY=;
 b=dh/rNQWusHQaSxMII+VxMXmYVPQ2/IOfYTTQJAppyimR2GgCRzd5sXXVWJ+b/Em1eb
 wdAmS1UNJtAGESjWrDWPWLoaifys68XWuomIyzdvsYbNXIajzZpBWwncihnfVJV9YFLp
 6f8DwVrHB3zTyvlfds941nMrRHF4AmoVaKDRneqc+XGrWnKM5gwKFp2eFdDs++mw8vYm
 rVkNMqjDblTXuBqQ4tPOBeWX+25uf44FsDan0kOhn/D549kMsEWN/SiBDXwms2VdJbQi
 6TZuAESKHEpbzlVjxtBw5IvUHdMI6u3op4c1AzNiRCnMY3q8xhjAupq30qh7DrdIzc3l
 oh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773418648; x=1774023448;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DO5MoWRHHEFyAZwfWtYNfTk+gxpUay4exK4xOe88JY=;
 b=a7b4OEU2BWcJ0sVXthAA5O3hUMHeAfDREATivhdgJfmskKZVHXzjvG/X8UwSLMGvy5
 jIZR86g13rJSGdRsOQL3OcrGVuEzNOzGFboeNin1pUGmSGbTE0az+y2tgvLyrfU9REfM
 52MCDXhhEauInKvEo//kkfB1YjqT/E/P/tca61iDQyDlNCrEmeC5dSEiT1aFzsEcj/WZ
 2V4fle2Kyi0yE+7oyGyyWFjYp6oFeoF1Hr4p1l2WvuPTjPMxSUWrxtMozwBgvniUSsVt
 rS++rcRJNZLTD0IYZi+z9TZzfNnM9LaVLJNEMCSUIQN8Ftc8KFBAMc3EToIAxmhQFoix
 GaRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWxQX9HX7oFA0ZeECVBTsuyYUfoP2whpib+ZAFVljCQarZO1EBEEeXLWfB1HMUPnse8dgwWkTfBr8H@nongnu.org
X-Gm-Message-State: AOJu0Yzn+UFeDyZmq1NCXPaNUHOVupBLImkqyVxEzV9G3iXIb+sm9+nW
 enYRIfYn22UJE6hBbjRe3f6KBOEMkJ9maEjaLyWGLhkHN46zTfagf8CIaiexzwMgWuY=
X-Gm-Gg: ATEYQzyGRRK5APIMx5EazMqNbp/hHuZ/xS88BieHbTL7A5otAAFNEDiLU/nS2iRpZ8J
 6TupDOuZ8qgb/5RV2PcPH5vFbGnTP7EjVa31ygfweI4DuR7Td/4pURBsNsJ7sMEPWNAAFXY6X69
 JR5GLAxI0vA61zpksSC+rRwsXfvQBZqvmEO0mKEKso3tgGD9jlBkohfD+/vhtaBkBaa7jmZBMmi
 523vC8V1i2oxzjhnjhwRMwbsJhftexahCSzmJfBiaNOzQgY67lCPPbwJcfsq6E49cv8DI9UCCHk
 cHZRTV80sNPEgLroh8gN2XtJ6sRJYpY262qJRFXdcox+FTcNrgnoyoAHBAtXDJfV+L4h0XFt6CL
 QEjG77Bwut7+umEBQPb+WG8aySBXxuFzOp/UaOasjJDaE5izOsBn+gk03ULpyUIHVVlDaZdu1BK
 dzjw8ZUpLZjcuvqlbj78eGL26CszCdVlmYiZtoHWe7/OD27g+oCEvrygtAZq5S9qbSCFTg
X-Received: by 2002:a05:6a00:2482:b0:82a:110b:e223 with SMTP id
 d2e1a72fcca58-82a1956cda1mr2654308b3a.0.1773418647962; 
 Fri, 13 Mar 2026 09:17:27 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a07366123sm6569384b3a.47.2026.03.13.09.17.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:17:27 -0700 (PDT)
Message-ID: <7533789c-a01e-40f2-b935-b587e36ee6cb@linaro.org>
Date: Fri, 13 Mar 2026 09:17:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] hw/vfio/helpers.c: extract kvm helpers in
 kvm-helpers.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-3-pierrick.bouvier@linaro.org>
 <0d62dfd9-30c4-4389-8d0d-2655ba28cb73@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <0d62dfd9-30c4-4389-8d0d-2655ba28cb73@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 3/12/26 8:18 PM, Philippe Mathieu-Daudé wrote:
> On 12/3/26 23:44, Pierrick Bouvier wrote:
>> Because those functions use kvm specific types, they need to be isolated
>> in another source file.
>> This allows us to link kvm-helpers only in configurations with
>> CONFIG_KVM.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    hw/vfio/helpers.c     | 172 -------------------------------------
>>    hw/vfio/kvm-helpers.c | 192 ++++++++++++++++++++++++++++++++++++++++++
>>    hw/vfio/kvm-stubs.c   |  27 ++++++
>>    hw/vfio/meson.build   |   2 +
>>    4 files changed, 221 insertions(+), 172 deletions(-)
>>    create mode 100644 hw/vfio/kvm-helpers.c
>>    create mode 100644 hw/vfio/kvm-stubs.c
> 
> 
>> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
>> index 82f68698fb8..f32d8573600 100644
>> --- a/hw/vfio/meson.build
>> +++ b/hw/vfio/meson.build
>> @@ -7,6 +7,8 @@ vfio_ss.add(files(
>>      'container-legacy.c',
>>      'helpers.c',
>>    ))
>> +vfio_ss.add(when: 'CONFIG_KVM', if_true: files('kvm-helpers.c'),
>> +                                if_false: files('kvm-stubs.c'))
> 
> Directly add to global stubs source set:
> 
>     stub_ss.addfiles('kvm-stubs.c'))
> 
>>    vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
>>    vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>>      'pci-quirks.c',
> 

Good idea, will do that!

