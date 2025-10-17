Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9E5CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kfF-0007xv-TS; Fri, 17 Oct 2025 09:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kfC-0007xS-VL
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:38:36 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kf8-00015z-Ot
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:38:34 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42701b29a7eso923882f8f.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760708303; x=1761313103; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SjYIaKYZU1f9NV6j6bd2ip/Hqxryzg3IoehxuhguIyk=;
 b=sIHKKpgbJsC5RAoM4apgUUHJY6gu7xaDhOzVQpYwBIiaXSRdjSaWWeejc+Lsoe8+0B
 9GMvMukOW6rkftOrB2Fhjm5/6mcN74CGe/HA+LQXx0mQkd9iNoxb1fDsR3uIbvejS4bV
 6a8rOfrxVS6wLTjarjrbbo+U2+2zQI9rr3cS/+3WzBk6l9gPuW50Mm9zq9xld2Qpq2ms
 KBqRYzx7F/X2Bd3Q3/R+iXBgwds0wtYHF/A6OpVl+dHk6eC8ZylFnnuRGCXs1/Hzedr/
 yxhZtYkHgPzOXDkh/7002LucynhIdJkSUOL5RAnhQ0YFqpX42NZD5Z0h4ilJcSpapDV5
 DN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760708303; x=1761313103;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SjYIaKYZU1f9NV6j6bd2ip/Hqxryzg3IoehxuhguIyk=;
 b=Ch3kVw+JVGXB9D42aq5Rj6ErXF5gvacD0aVYDMI0MX0hh3Gr7aqhmgVs+l2EMMc9lm
 xUDbx1n6WBIs9w7CN0cG8nfqfHhWEaklcszEBWIXrXcl0mHHIsS21ctIb2Ytmcf/Xv4S
 OUo1WHe5eD/Y2TDPFjDKBW/MmbnURlHyNo7N16NEIGaOfhuno/tRX/QE2KpajQZZp3AR
 UtD1lfhBm61+3+ZThYHtYwGKeck1L6oLo9j1mM/rUbFhyL8Xe5uZi1BCqZ9l2ScwYMJV
 LBevjQRJFGmkLgOjS1wMwvyFNVK/pFXfZSO4OKOcaMNADYWki+hTt3h7/KZf5FaMNMBz
 vXcA==
X-Gm-Message-State: AOJu0Yxb4T/lpjr9g2LrKA06Jn1ohKP+k74RdG9kNnlHGGPm5qml6YUj
 YPtZ2ZoUDsR1p3OXn80UvlFAbI42b5ilpVzKTxP1PtvvSmHyoZ2EsaWzN7dMQfrA1ZQ=
X-Gm-Gg: ASbGnct3xTLvo/994n7Q+z+HM6zj8/JFKnlB2sdGI6xAM3WtsCPNmbMWU2DM/SSvIgv
 zJZbbS0PC9HA6TW7op+tbo9QM9AoWxCPYgz8PTRcZdqbm8GxqLmFl9iY8gBXPth40aaTlkP4VS0
 OzsN6vWp0D+PYADKo+xwy0HZGQsCr55bbZa7X0gWcf3Wgc+bI8p2g1nTC14f2Y53NhvWJ2kIVIU
 N07tTfrTtD+ioWbEL5wxTC0fz+QxvHq4JNrdCzH6YPCjbN+p4/RlPA+3nW2ULyaZxIm3q9bDP+1
 layK556rXfN/1oyP6kJ40bCWi2D4AUZEOxcIzeTgUpKNXnpOnW9u1iKXU7CV9rJ9kQZpzc82wUb
 aC+TCm0JR70booQBROTQwj8CWXUFvFVeY0qPZxP6BWLDZFZG3FzL8xvs676a7JgTzaAxBHeRN9T
 migcKJhYhraHMOKxuvFRMU5z8hzEMWDCnndUn2lDL3a0YFOqcVd0nxJA==
X-Google-Smtp-Source: AGHT+IEMb0kcJemJCc7zTT/C36NO+Vz9FSfbBkCtqBB3CwHqpYpZzNAh4OJx0gO/9y5juqexvfbUWg==
X-Received: by 2002:a5d:5c89:0:b0:426:fff3:5d04 with SMTP id
 ffacd0b85a97d-42704beea04mr3234240f8f.25.1760708302652; 
 Fri, 17 Oct 2025 06:38:22 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42704141cc3sm7565732f8f.9.2025.10.17.06.38.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 06:38:21 -0700 (PDT)
Message-ID: <480c9267-5cf5-4020-b777-3dd994a58282@linaro.org>
Date: Fri, 17 Oct 2025 15:38:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/m68k: Remove deprecated virt-6.0 to virt-7.2 machines
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <20251017124104.56199-1-philmd@linaro.org>
 <aPJBto1ArfyQgKm_@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aPJBto1ArfyQgKm_@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 17/10/25 15:16, Daniel P. Berrangé wrote:
> On Fri, Oct 17, 2025 at 02:41:04PM +0200, Philippe Mathieu-Daudé wrote:
>> The following machines:
>>
>>    - virt-6.0
>>    - virt-6.1
>>    - virt-6.2
>>    - virt-7.0
>>    - virt-7.1
>>    - virt-7.2
>>
>> have been supported for a period of more than 6 years. According
>> to our versioned machine support policy (see commit ce80c4fa6ff
>> "docs: document special exception for machine type deprecation &
>> removal"), they can now be removed.
> 
> Err ythat calculation is wrong.  The 6.0 release dates from 2021,
> so the virt-6.0 machine has not even existed for 5 years yet.
> 
> The versioned machine type macros automatically mark machines as
> deprecated on the required timescale, and will automatically hide
> deprecated machines when they hit the removal point.
> 
> IOW, a versioned machine can be removed if-and-only-if the output
> from '$QEMU -machine help' no longer includes the machine version.
> None of these can be removed yet.

Right, OK.


