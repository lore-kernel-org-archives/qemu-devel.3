Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1986C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWXxw-0005rh-SL; Tue, 01 Jul 2025 06:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWXxh-0005qZ-Rp
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:11:39 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWXxf-0002tc-MZ
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:11:37 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4538bc1cffdso29506735e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 03:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751364691; x=1751969491; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xukDN3H63LwhhQewlIjnzCHEaos/m6LMLbLr7A6Mjes=;
 b=K1M8jDb+jDDl7KwLIBWNGb+wYbY/A2fzugmmpoQ2W4IfPNw+WkUpDScT3uKGdF/DVS
 XHXzhUNrpnXhawZC192FKwXwI3p5JoxnwSxf5uX7nq4qEFj0dhpMtN4kz2/yqQgJrsBT
 tVY0e3PPA2z9fXFzJuPOy5Hs0Oyur9v9vo3AHzkIPOOqfyPVBt9MFAwWbqwV74H1cqZi
 iMjWSAcPDtavIxOJRMg78Vr9EXIapNZShBxHxj8T2WWHbnts/+SAQQ7Q3v2ymmKs1KVc
 F2roG3FjgNswBFu8HVLDdMdpExiJ41v0SSplYjgKU1JNOBi7yptl31L99jA2Wyab0NYv
 78VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751364691; x=1751969491;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xukDN3H63LwhhQewlIjnzCHEaos/m6LMLbLr7A6Mjes=;
 b=WytSCtg0zqvH/LvPnyu92egs27OR30EkNn/beTgQSArt5vw395Mt3kX3Sgf+HzNPu0
 9sG13JofNlWPNQTeQMHlvPch61cLGhDxkw/GYKFflAUbwnxwxbR1AprZy3G1hpQDyu7q
 rvCzQFrXq322Ug9zVvYHpOZ98OycTTjE9KJ27Ty9pyE/bztV8g/yz4gIR4dPliYrknTJ
 Z+0SMtseWoCs2v4iMjh8h7fU6QgT7S/ibEkLBn+My1JMpNHJOYWkwVq6sdW3WwjaOmU2
 EJzijSI8N0xCBrfp7wkjkms/RSM+3GAvR9wrtCTwlph0LecfXmP1GCLym6AxnpmXQluM
 Zenw==
X-Gm-Message-State: AOJu0YymbFoK9ftmXBpEivyOOW/QXkvbtyGagOqkzyqFDNDoXgnPSXHN
 za7KGbbPeGeeFDBh2zpZrmzKCnhKVWzggEFOcGaiG9W62GIF5EmaFp/o8BUjezCP4nQ=
X-Gm-Gg: ASbGncs1IICC1s4eT5+Z6bhnUmeAlkeNz18SqRLitl7GI8wPFKr9+qDAdhQYdD0b5/G
 BsWX5YnEsXKDDj1yVg4ImbJ9EggEitMitSQOdfouc0FbDQvrV/VcybuEfXHMq0zZJ9m/YNfuCY7
 HAk2Stee8M0BjX2tnOGxQa6t9+SoRLtxxekq1qtsZkzgyk4OKmYBxiVboDDtHHeqdIRmGmhxmVw
 W1kvgxmMZQ0ctPs4iG0H7dw7BW7aJrMV+4uYN6Ntnb7sxFvoo8NBi6JpbuVMgHwolkdQW2DImq5
 MidLEzGNX6VsAV//vC19PsSpuM51VzNiA5N0Cr3AyqKGtaNGlFAnHdti2fr0OtSbwlMp7fvq/N+
 8ceWyiWQlSGmOm0OrneRQCLCEOUV67K3ZzPxji1e+
X-Google-Smtp-Source: AGHT+IFJ2dzhbA7AS66Am/DJLv0M0N+kubAZsKkWqs3D2gOnCtcFq+eIstRODMqR92FI66ozNZuD7w==
X-Received: by 2002:a05:600c:4594:b0:43d:47b7:b32d with SMTP id
 5b1f17b1804b1-4538ee8c45emr157635275e9.25.1751364690947; 
 Tue, 01 Jul 2025 03:11:30 -0700 (PDT)
Received: from [192.168.69.166] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538233c05csm191355995e9.5.2025.07.01.03.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 03:11:30 -0700 (PDT)
Message-ID: <8d72bfca-b79d-431b-b9c9-8e21fccd22f4@linaro.org>
Date: Tue, 1 Jul 2025 12:11:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/26] hw/arm/virt: Only require TCG || QTest to use
 TrustZone
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Bernhard Beschow <shentey@gmail.com>, John Snow <jsnow@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
 <20250623121845.7214-19-philmd@linaro.org>
 <CAFEAcA_M+nXYL5HaN7QUUwWywJw8VaxU3T54YCMQsVd42PQ+PA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_M+nXYL5HaN7QUUwWywJw8VaxU3T54YCMQsVd42PQ+PA@mail.gmail.com>
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

On 1/7/25 12:05, Peter Maydell wrote:
> On Mon, 23 Jun 2025 at 13:20, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> We only need TCG (or QTest) to use TrustZone, whether
>> KVM or HVF are used is not relevant.
>>
>> Reported-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   hw/arm/virt.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 99fde5836c9..b49d8579161 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -2203,7 +2203,7 @@ static void machvirt_init(MachineState *machine)
>>           exit(1);
>>       }
>>
>> -    if (vms->secure && (kvm_enabled() || hvf_enabled())) {
>> +    if (vms->secure && !tcg_enabled() && !qtest_enabled()) {
>>           error_report("mach-virt: %s does not support providing "
>>                        "Security extensions (TrustZone) to the guest CPU",
>>                        current_accel_name());
> 
> The change is fine, but the commit message is odd. You
> only get to pick one accelerator. The reason for preferring
> "fail unless accelerator A or B" over "fail if accelerator
> C or D" is that if/when we add a new accelerator type E
> we want the default to be "fail". Then the person implementing
> the new accelerator can add E to the accept-list if they
> implement support for an EL3 guest.
> 
> For the not-yet-implemented case of a hybrid hvf+TCG
> accelerator, it's not clear what to do: in some cases
> where we check the accelerator type you'll want it to
> act like TCG, and sometimes like hvf.

In that case we want to defer to the accelerator, not block
from the machine init.

BTW hybrid hw/sw accelerators *is* implemented, but not yet ready
to be merged:
https://lore.kernel.org/qemu-devel/20250620172751.94231-1-philmd@linaro.org/


> 
> I'll take these patches, with an updated commit message.

Thank you!

