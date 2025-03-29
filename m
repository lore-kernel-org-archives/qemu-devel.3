Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80F5C36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 10:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyTXi-0005Ra-KZ; Sat, 29 Mar 2025 06:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyTXV-0005R5-5y
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 06:35:51 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyTXT-0006Tg-7S
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 06:35:44 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-54298ec925bso4523388e87.3
 for <qemu-devel@nongnu.org>; Sat, 29 Mar 2025 03:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743244541; x=1743849341; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QU0AQ3Kvvuj3SzS4Nwv6B6aWNz3nMlieMR81fKnfDgA=;
 b=PNzaVrIQjGyuvCVDAmp0+NVR2bVciGLFjmj0Ts/kRq/201gB0PGOc12mVQzrh/JTja
 YHQT2QYNozOLuk8wSUCxQuKti4D9jywqQ5rO/dAEqIcqxNBdysk+JM40/dblnqMCmRpF
 nFU5j8vbp0Wv1BOYMIpbrQUL///KbC8ShQew4dyedjoae3RrvVdfpiyqBb+oJjP70637
 5/khR80Pmu/FnTfn4JsQk6/MrNjd2FjVmH+Dxe/1Sm14WTz0SRAcX33GyAqkwqCgVfkm
 LFmfDgacC+0Vm5TxlS/MLVpQmkQZ1/BPWpZqOpRxSlSk0K67+fMriRftiof6WSJponzo
 YCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743244541; x=1743849341;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QU0AQ3Kvvuj3SzS4Nwv6B6aWNz3nMlieMR81fKnfDgA=;
 b=lnnuvFrteDEPNik1d6NQ77RUgvIVUL3+Z/XbonSM14661T02LdASsaeKbFa4RlgKEc
 4gS9GLYUNrycXaT68uyUhejh+L2ifI/Sov+6jraVJLbqRB2oKwRY7yIiIVjdbouaZB+g
 cZ/PfSInMUIRKrV7jWVkkkPGz9PZVJF71po6zti4XYT2fgTG2WR92UGB5Cd18grsEiU7
 d6M8x1OZz7K7cgmxQ5a0MckfiaxJDj1MJRqsda2eMfXvDy455fVzjLbuX2ztVx7mVRpE
 Y1XrfuumxnbFf2N4lZ4pizhI5IVZ4diBmzoJo3FKfoKMc+mq6+oP6a8/q7U+TDdk+fUd
 N0IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI4+00aE4q0la+t4VSXL/tXS35swM8n1ZFzc+Qwbb2kV6QQxoNYb/ELQ91i7Go1crT5rV/3JTbkcYp@nongnu.org
X-Gm-Message-State: AOJu0YxF+eoHH+XV5GdrAmZ7ZFRymetRPYyg882G54EuhOLwRrmxOsE7
 +bXuf6aG63/FKfC/KLZ+mfeOz9fY8gKac9jWQE7ypkM4gLlGzr+R4IMok7ROTg4=
X-Gm-Gg: ASbGncsdFamUhE6sXSFUmc7cOJJOfc5kcWEZ4XCg9222mT0tU5UmcZbJ3zdIHPpqNNE
 dZCx+2ubxFBXupXdlRVPZS5G5YfkqW6Q87UZgt8QX1V8ai9VMUzE8y4Ka8kFdeT8JJAEpZ1Xq3i
 FoiD5MGBomjtq1Jk2UHX/+Kfr0ZJAiYLpKP76YxCK07aPwSeCH7/NxpYzlVtxVZqzcsazYEQBUn
 3QfHtR0BSIME32ewzDQsRvfywKNo+500wE67PbVAxLUt08HLi3JP61fonG3x/dOuGI/IehKkMVT
 QtJjZ2/sBYC5uqT5SwR4ZoYWhCBOs0zGmkkAn7XYbKyfuI8Q00ePtIBacQ==
X-Google-Smtp-Source: AGHT+IE8c1dtftzWYGmR4cS8Q4gHeLy97Qm7zbF1pLXA1FzZCyNosgeJq4Yvo5CU0SXujVYo8JzJdQ==
X-Received: by 2002:a05:6512:108a:b0:549:38d2:f630 with SMTP id
 2adb3069b0e04-54b10ecbef7mr705563e87.24.1743244541121; 
 Sat, 29 Mar 2025 03:35:41 -0700 (PDT)
Received: from [192.168.55.161] ([80.215.212.24])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54b094bb32esm565027e87.26.2025.03.29.03.35.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Mar 2025 03:35:40 -0700 (PDT)
Message-ID: <3956f3b4-2317-4e7f-a2b4-e53546473d62@linaro.org>
Date: Sat, 29 Mar 2025 11:35:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci-host/gt64120.c: Fix PCI host bridge endianness
 handling
To: Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: rakeshj <rakeshjb010@gmail.com>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, thuth@redhat.com
References: <20250327153627.307040-1-rakeshjb010@gmail.com>
 <364c91ef-b086-9aea-4073-e0be49b77d76@eik.bme.hu>
 <ca76bcb1-7cea-4153-ae74-02718a6a1cfb@redhat.com>
 <971ac7f1-618d-c94a-93db-9ba887bdc997@eik.bme.hu>
 <CABgObfbL0b7G-Okq=0xnbDMJ4viu0Uk8gduuTUeCS0C4Xtn6aw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfbL0b7G-Okq=0xnbDMJ4viu0Uk8gduuTUeCS0C4Xtn6aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

On 28/3/25 18:34, Paolo Bonzini wrote:
> On Fri, Mar 28, 2025 at 3:16 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>> It should be fine.  You should take into account:
>>>
>>> - the endianness produced by pci_data_read/pci_data_write (always little
>>> endian)
>>>
>>> - the endianness expected by the guest (big endian under the conditions in
>>> the patch)
>>>
>>> - the endianness expected by memory.c (always little endian, as specified in
>>> gt64120_pci_data_ops)
>>>
>>> Because there is either zero or one mismatch, bswap32 is fine.
>>
>> This may worth a comment but I'm still not convinced this works on big
>> endian host because I think pci_data_read returns val in host endianness
>> and if you want big endian then you only need to bswap on LE host not on
>> BE host. Was this tested on BE host and confirmed it works?
> 
> Looking again at the code, there is definitely one problem: since you have
> 
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> 
> the bswap can also be bswap16 if size == 2 (and bswap32 only if size == 4).

Per 'PCI LOCAL BUS SPECIFICATION, REV. 3.0':

'''
3.2.2.3.2. Software Generation of Configuration Transactions

Anytime a host bridge sees a full DWORD I/O write from the host
to CONFIG_ADDRESS, the bridge must latch the data into its
CONFIG_ADDRESS register. On full DWORD I/O reads to CONFIG_ADDRESS,
the bridge must return the data in CONFIG_ADDRESS. Any other types
of accesses to this address (non-DWORD) have no effect on CONFIG_ADDRESS 
and are executed as normal I/O transactions on the PCI bus. Therefore,
the only I/O Space consumed by this register is a DWORD at the given
address. I/O devices that share the same address but use BYTE or WORD
registers are not affected because their transactions will pass through
the host bridge unchanged.
'''

IIUC we don't need the bswap16.


