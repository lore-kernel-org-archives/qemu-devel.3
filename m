Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC8FC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 12:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uATBY-0001yi-FI; Thu, 01 May 2025 08:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uATBT-0001yN-SL
 for qemu-devel@nongnu.org; Thu, 01 May 2025 08:38:36 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uATBS-00070h-5l
 for qemu-devel@nongnu.org; Thu, 01 May 2025 08:38:35 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3d8020ba858so10309305ab.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 05:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746103112; x=1746707912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v+6UrxRer3XJ+KyYC6UWeJuFzvpNZZgrFnu4Dy5DyJI=;
 b=m0Y9EsHWX594HFR9tw9lZHasSI2l1BXHWHp1p+muc7cwCidDMHzpxFpmh/p61Rey1O
 B6R9QGhI2+0pgSY2XrG8duc196P8F1CF9YGJCoeNY/mkBAvu+YmkPM1fZBXowUyHJGe0
 i2wE/jehdwy0OiU69arZ4vZAtvUODJhNY8Cidd/PyLJXB+Ukb+ZWWRGzPIYBmoCMmhRn
 I8xqJ97WAOZ2pCEl7x8rfjKbyQqqWVBoHTjQj1P8OZq2sHLKYcxOsR84MnkSi3pVoR0Y
 bEt1UWWz1Bs7kzVny+aObqKFyY/0xxZ5lAaOmbj51PNI3+8pLxTAMgShWEJdL/L2ohq5
 mFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746103112; x=1746707912;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v+6UrxRer3XJ+KyYC6UWeJuFzvpNZZgrFnu4Dy5DyJI=;
 b=S88PB2OH5H2jvhynaVXJC8ALDK4T85ZS7RL5JuhJxANfkXAnQeP2RAuoKCyiQeONcD
 x2WuzsTRuywW2nd1j+5Z4YYpa2q9MT0Yhydu8SfLT4IW815BLo4FTliF/ZADRZ5O46Kv
 B7oKGHNPKPFy0TOxPLdFl4V6iZpow7s45w/ooiCMdzmK/vnZRdt8z4YukhaCPykYEpLP
 407aCWZELY1/xgbEXmn3sgdhK5aEe4OIHlzKQvINCedkNNS+v3Gr/5oRgguTK9Cdcy0Z
 8OI1COjs4d27ffxRgmd45euILlGy4a9fGtxQDERnkwOxuA3L3ynZA5cdPLLkGZpT8O74
 kkyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc6/zuLxi8hl9R6h2avotoPf/b8WK7FmEXAHnJeHso4TGCy6782jTSpnNxBmUQAHNHuQ1Ab1X/TxA/@nongnu.org
X-Gm-Message-State: AOJu0Yz4K5XwKYc/9Do+F6nY1qodCse+NxXpF6K7mvNvJVsLJM39NbWL
 ZufjFHlL7bMS8QUY28sxrW60gpL9TIZESi+coGee/1hd112XMjNy8s16WEkRy5Q=
X-Gm-Gg: ASbGncs5mpQh+hOGVm7Z//XbPUA+m8YaVXQBz5715LezU2UPlaJPTQzuvMsyoRyKhbS
 M0U1Yek17sas/QSbZ4zitb3hhJFDgkUiZJzN0qVKTotu3sS0mGFiOYTymoxShMvlZsXqa9GsV+c
 oGOiKuJLmaQOMYy7rpeyEc1jQQNS7BybbH368gUXsljohqTKdQv4wbcqLWSnhffvbaH0waTsRmX
 ebIbP4ctqnz8aKnWXIyCDoWIriIRq/wRJmtgNlQh06Ib1MA6McIxJpVq25sMw+Og9vDyE39i/Zv
 NPJDUMEAOV2Dwnci53058d3ktt6gwAeZT4Ag4ZjxIogVP2pi8mzl2B2TFWG1071jtsiuEa1Xvw9
 AvatCKTyp
X-Google-Smtp-Source: AGHT+IEdhrlJh1ZqHtaOOYeRnL8UxsWR1JzHioPyGm/4VpoceY+hfhYqh+MlBlZpigyPS3wtF2Ujyg==
X-Received: by 2002:a05:6e02:1543:b0:3d8:1bd0:9a79 with SMTP id
 e9e14a558f8ab-3d97029b01emr33717015ab.21.1746103112467; 
 Thu, 01 May 2025 05:38:32 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f882f00ba9sm145591173.66.2025.05.01.05.38.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 05:38:32 -0700 (PDT)
Message-ID: <9e7dcb41-bc61-4064-a530-c49dcc607841@linaro.org>
Date: Thu, 1 May 2025 14:38:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] hw/i386/pc: Remove deprecated 2.6 and 2.7 PC machines
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250430142609.84134-1-philmd@linaro.org>
 <97a8c6f1-822d-4012-9d66-039fa409047f@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <97a8c6f1-822d-4012-9d66-039fa409047f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 30/4/25 16:51, Thomas Huth wrote:
> On 30/04/2025 16.26, Philippe Mathieu-Daudé wrote:
>> The versioned 'pc' and 'q35' machines up to 2.12 been marked
>> as deprecated two releases ago, and are older than 6 years,
>> so according to our support policy we can remove them.
>>
>> This series only includes the 2.6 and 2.7 machines removal,
>> as it is a big enough number of LoC removed. Rest will
>> follow.
>>
>> Based-on: <20250429140825.25964-1-philmd@linaro.org>
>>
>> Philippe Mathieu-Daudé (5):
>>    hw/i386/intel_iommu: Remove IntelIOMMUState::buggy_eim field
>>    hw/intc/ioapic: Remove IOAPICCommonState::version field
>>    hw/virtio/virtio-pci: Remove VirtIOPCIProxy::ignore_backend_features
>>      field
>>    hw/char/virtio-serial: Do not expose the 'emergency-write' property
>>    hw/virtio/virtio-pci: Remove VIRTIO_PCI_FLAG_PAGE_PER_VQ definition
> 
> Shouldn't there be a patch in this series that removes the machines 
> first? ... or did I just miss this?

Doh, I picked the wrong base commit =)

