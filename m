Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FC4CCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 15:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEqn3-0006sV-Fi; Fri, 31 Oct 2025 11:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEqmy-0006rg-9Q
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:11:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEqmr-0006nj-WE
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761923491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RnZeyHtVAtvPV9a/Dusp8LBG7X9+F5Lh5m0KxsAUvRU=;
 b=RSXgVdtERlCD2NOKUEumsx/XARzQ5kbULAqvkyqkNgXTma9nMb4KXSmyTnXkiaAjf1iADo
 KRSXpV3cBfxXwAFILHCiHkxfWqezGytX8PHt+H2AN7RrwhMcPqIjo+WMigXZ/LJo+bI/oq
 ZPMoU+mXVkzKDdXRvPFq6qCjSnTKYY0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-HHQJXThVNE-cHYyWuC2IKg-1; Fri, 31 Oct 2025 11:11:28 -0400
X-MC-Unique: HHQJXThVNE-cHYyWuC2IKg-1
X-Mimecast-MFC-AGG-ID: HHQJXThVNE-cHYyWuC2IKg_1761923487
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-475dca91610so13932625e9.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 08:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761923487; x=1762528287;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RnZeyHtVAtvPV9a/Dusp8LBG7X9+F5Lh5m0KxsAUvRU=;
 b=Dk81Af7ZkLiAi3KjnFxQ2yYN69RH7q7nHBDXK0lljpLYenahw7M+mvTIeoqjNgDAH4
 XosIJNr51piKcTtQmi9VXpQ5D9CgTS9gQ1UPBpXEwKdbrtb4CWx0ZSlgh7Kv88Uf6zNb
 nEba0aXdG4V34ePyVQeXu+oz8hz0rvcTtyCGpScznn0iwDTSzcBTXQcnZ7k95raElwPn
 dj4cG3nSJjK+7SykMyB2EiktYa7Fkfq0HudVqaHO8cUm70g2tMEQJTkVB/g0OX5BQn/o
 o5L7chtoDs+MUg4BncwCnQYIjom070PIehBGOdBkD7lLb1CT9IFfQGaPO7FtYThMskTw
 g8dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdI54+xi/IjTNhlFJ0qLva2bQSomX9EOnfAWDofLNvUbtnVL2NvDM9KLRgRvxjw6rZ7hcxxpaYiLda@nongnu.org
X-Gm-Message-State: AOJu0YxFOe2EQt1+OaUsKIteBKdCG1vk5aq8iuLfJ9OSxKo1b5gUuB1V
 30kUtPAGKxkwdbXxESjXuMhambHjwXserrQAm0xXROIkgJeVd3aWKpBe2G/0QUnWWH+T5p00Ftq
 HVGsxV49dynJpZ2f7dLygQKl7qrlTiCMAeI+mjhzCiZ6OVePJAkZ3L3YN
X-Gm-Gg: ASbGncuYIW7PxTbdUJ37FoOyDwRfc5IjchjB9e7wEjGy3wKYTDVPB6E7M86ikVvalg2
 rcfbbe+vTa5BGDrG0+/3aJrJqlKA3ZE4VLHU6X83HCR0j8CAmur+lgrmOlsayZMxFqXWivKs4oZ
 gf5zzxz/fSU2U1JxInaHUR6nSUokWsI81+u6OWuSBR5pQiBoLIY+3I8qRfGdQtnlnNCOovJCmd1
 lOdgVl6TC7dDAlywr1di25kqYdBqXA7LHX5KSLrqS6riTN8M9xYw71ZwTcrKuSn82F7rMb0Yqx7
 sH8VNM9tjNVCUoeFTQtGJessFcbbohxqlEcV23KyTUgAoPhUv3I81C/rV7vSRgGMElcWWiE=
X-Received: by 2002:a05:600c:198a:b0:477:bb0:5e0e with SMTP id
 5b1f17b1804b1-477308a118dmr30231945e9.20.1761923487145; 
 Fri, 31 Oct 2025 08:11:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzQYEeGr6ZXuJwIcJ6WVM4wuaJOh0wVnjCgBei5G5OktSU9APnX+l8pczvM92r2JZilhdkYA==
X-Received: by 2002:a05:600c:198a:b0:477:bb0:5e0e with SMTP id
 5b1f17b1804b1-477308a118dmr30231615e9.20.1761923486673; 
 Fri, 31 Oct 2025 08:11:26 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c13e1d8bsm3997071f8f.25.2025.10.31.08.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 08:11:26 -0700 (PDT)
Message-ID: <4be7cca9-0de4-441a-bfe7-559c96e598a0@redhat.com>
Date: Fri, 31 Oct 2025 16:11:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/functional: Mark the MIPS Debian Wheezy tests
 as flaky
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251031094118.28440-1-philmd@linaro.org>
 <20251031094118.28440-3-philmd@linaro.org>
 <171d963f-9543-4a1d-9852-3ba48e9e7310@redhat.com>
 <507f6a8f-6d1e-4146-b318-db342e870b3b@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <507f6a8f-6d1e-4146-b318-db342e870b3b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 31/10/2025 14.30, Philippe Mathieu-Daudé wrote:
> On 31/10/25 12:33, Thomas Huth wrote:
>> On 31/10/2025 10.41, Philippe Mathieu-Daudé wrote:
>>> test_malta.py sometimes times out (likely hang) under GitLab CI:
>>>
>>>    1/57 qemu:func-thorough+func-mips-thorough+thorough / func-mips- 
>>> malta    TIMEOUT   480.11s   killed by signal 15 SIGTERM
>>
>> Do you have an URL from a test job where this happened? I clicked through 
>> a bunch of failed pipelines in the qemu-project, but I only saw failures 
>> of the replay test in recent runs...
> 
> I was thinking of https://gitlab.com/philmd/qemu/-/jobs/11869641060

Thanks! ... I looked through dozens of jobs of the qemu-project (with the 
private runners), and I did not spot it there, so maybe that's something 
that only occurs with the shared runners from Gitlab? --> Might get 
important if someone tries to reproduce the problem.

  Thomas


