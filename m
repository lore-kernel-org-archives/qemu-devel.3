Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074D8C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 11:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWx5Q-0002WN-Hg; Thu, 25 Jul 2024 07:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWx5L-0002AH-1c
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 07:56:40 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWx5I-00060K-Ez
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 07:56:38 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-368440b073bso526763f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 04:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721908594; x=1722513394; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SNRaLDhXuaXBbogo9lc9RUzaiHflqExCllZdrRfY1c4=;
 b=Flf/JSxouVXCUDzeGkx/yMHuaSgWWdx6XQXSSCoSQ7Podt6InNawYF29B9cOi2bUwZ
 ZctSjYsRA5IgdkXub3aI6K7Uvt1tQjCsJz9Ru8MT9uCRVR2RqW0is8PXWurWBgadsAPu
 17kQMGOIvRUJaK2QokEAwDHs+Ko+BiC7UUSeLlDyRp8UGiWcT/6DE6QJWD1ZtJBnVKZg
 sa4hiE1gptfVVp7tKnyPj63H1ijvb/FIIAfYcQ+A6/GtCP9Z2zmPiHExER9DhTVZKJeO
 jm8frcVx/1faJiCQry0YTV8HnkDoeOZ4c35U2NbD2aFQJKVk4hVkGoqiDceKrqDTJf7D
 MnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721908594; x=1722513394;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SNRaLDhXuaXBbogo9lc9RUzaiHflqExCllZdrRfY1c4=;
 b=SFDsr9NMbIc/sltCUT43xHDwlO5e1WxxI4c/thDxFc+QwkrB65jvtW1dwu9E4Z1wbf
 OFQfQGqFv6zTZrPoZOVGM9c8hfLpmVzA8unZYqQQDlk5TkJ/vTccTr6sTSsBJjxqz4fm
 Kfn5ERL8vRHXkwmciUujWXKQKEgMd+jCrz//WrSRaU/iaYMC6sblNTvykd/H4mWFA6wp
 Sioxm7wn5xUO4zoQ57LwHVfxnlOOeCVlb8dLieKopHnFePfs6xZmsoybo27OpflT1pLN
 lCXXtleZf1apgjKWKA6uRBV6a9/qf5lI395NsYlIb4T2QjMLnk0nZNHpJhiNdI519PW+
 xfEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWAYuGU+ELWwyB0gTArcrPlpxCD4IcmeUJgfeh7zNizHP+bKh8i5faAOThe7Kty1D+/MvX2yQfNeOgF56Q/vlxqPZnkqc=
X-Gm-Message-State: AOJu0YwvyN9ASu+BI/6x1HxB6zYCsHM6J6qxhBbYmpCv+P6fFMSN0Fcj
 jqkYC0JEEOgC1tRaXDWzKGlvsEN1Ok0C3K2oWGSVWsLwwJwmhFPByClIjwD22lk=
X-Google-Smtp-Source: AGHT+IEhaD+zGagEKOj3m50/9uk4Vbqwj4eoZFp+NVJ5M/Z7gikORJQbTPtrIwwZ0K950VfGmH+Z1w==
X-Received: by 2002:a5d:6d8a:0:b0:362:ad01:5435 with SMTP id
 ffacd0b85a97d-36b31baa14dmr2324315f8f.29.1721908594355; 
 Thu, 25 Jul 2024 04:56:34 -0700 (PDT)
Received: from [192.168.1.102] ([176.187.216.35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36857f23sm1949092f8f.78.2024.07.25.04.56.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 04:56:33 -0700 (PDT)
Message-ID: <2172b10d-6100-4f91-9b33-d2482254d4ea@linaro.org>
Date: Thu, 25 Jul 2024 13:56:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/23] tests/functional: Convert simple avocado tests
 into standalone python tests
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240724175248.1389201-1-thuth@redhat.com>
 <20240724175248.1389201-6-thuth@redhat.com>
 <d60683bf-724a-474a-ae97-6ec2eac775a9@linaro.org>
Content-Language: en-US
In-Reply-To: <d60683bf-724a-474a-ae97-6ec2eac775a9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 25/7/24 08:55, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> On 24/7/24 19:52, Thomas Huth wrote:
>> These test are rather simple and don't need any modifications apart
>> from adjusting the "from avocado_qemu" line. To ease debugging, make
>> the files executable and add a shebang line and Python '__main__'
>> handling, too, so that these tests can now be run by executing them
>> directly.
>>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/functional/meson.build                  |  5 ++
>>   .../test_cpu_queries.py}                      |  7 ++-
>>   .../test_empty_cpu_model.py}                  |  7 ++-
>>   .../test_mem_addr_space.py}                   | 52 +++----------------
>>   .../test_pc_cpu_hotplug_props.py}             | 11 ++--
>>   .../test_virtio_version.py}                   |  8 +--
>>   6 files changed, 34 insertions(+), 56 deletions(-)
>>   rename tests/{avocado/cpu_queries.py => 
>> functional/test_cpu_queries.py} (89%)
>>   mode change 100644 => 100755
>>   rename tests/{avocado/empty_cpu_model.py => 
>> functional/test_empty_cpu_model.py} (84%)
>>   mode change 100644 => 100755
>>   rename tests/{avocado/mem-addr-space-check.py => 
>> functional/test_mem_addr_space.py} (93%)
>>   mode change 100644 => 100755
>>   rename tests/{avocado/pc_cpu_hotplug_props.py => 
>> functional/test_pc_cpu_hotplug_props.py} (90%)
>>   mode change 100644 => 100755
>>   rename tests/{avocado/virtio_version.py => 
>> functional/test_virtio_version.py} (98%)
>>   mode change 100644 => 100755
> 
> 
>> @@ -22,9 +24,6 @@ class MemAddrCheck(QemuSystemTest):
>>       # for all 32-bit cases, pci64_hole_size is 0.
>>       def test_phybits_low_pse36(self):
>>           """
>> -        :avocado: tags=machine:q35
>> -        :avocado: tags=arch:x86_64
> 
> Could we keep the tags, but renaming as:
> 
>            qemu-test-tag=machine:q35
>            qemu-test-tag=arch:x86_64
> 
> ?

Bah, let's just remove that for now, since this feature implementation
might use a different format.

> 
> I'm OK to implement the equivalent feature in QEMU functional framework.
> 
>>           With pse36 feature ON, a processor has 36 bits of 
>> addressing. So it can
>>           access up to a maximum of 64GiB of memory. Memory hotplug 
>> region begins
>>           at 4 GiB boundary when "above_4g_mem_size" is 0 (this would 
>> be true when
> 


