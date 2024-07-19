Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBB6C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 15:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUpF6-00058S-9Z; Fri, 19 Jul 2024 11:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUpF2-00054a-IJ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 11:09:52 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUpEy-0004uP-Mt
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 11:09:52 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-368f92df172so189255f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 08:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721401784; x=1722006584; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=whNo2DLVeiwZMXGrjrW6VfVwrvZjjABKDqH5F3p3R7k=;
 b=DEexS+Uw6sVNH8TZKh/8S0cDMcIvon4rNJVmjr8uANjKJ493u1IQkods0jDRsAbnRR
 I8WH2dwWqZZEphMLmFI3mAY69H/p0IQl+hg2l9WLBphy35cB0FHQxTBJFKMYop76bbAk
 /w4iRvnumvgGcZ48IGu+1WzBmPGMfBD8f4Pt1/d0V8TCv5PoEUkmcbVt3pNGvoxVUXeh
 N8T99pQ0z0GgkYBT/gVxYVIMBXpJ5RvpbFPshVzLjqo+jW/rUxpAR0FxxVzoNxn6voQX
 c/ThKqThRkrBl3zadMd/tAC9yyGzA4wiqLqUzimo6s+IGSwKkhQAHxTM5MxkYnp452B0
 TsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721401784; x=1722006584;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=whNo2DLVeiwZMXGrjrW6VfVwrvZjjABKDqH5F3p3R7k=;
 b=tJ48j9q2yoS8MF6Zg4EM+zfiynTIoBMVgyZjuGqMXVoZEgD9o8oxJ6ExfqlqdVf+aJ
 Sn/51DsMYNiWxEPXgckS58x5t4ipFsHSm1AVWE9i1ptlNJgGm4cVCIVLSCDVV66UPh8S
 EVK/PLpgsUEKpcj9tHEqsmyNq9vdUwX2stfhEeLxfwUtg/F78sBkShPX+ZauVTUot/tm
 cQJtmbKK71vTY2GquX1IGlmSzb3ExzQ0kG9f6s/JGPNF6p4kO0WrpXGO71mjkpvJkcWd
 6bwy+kgT041F35uCDZGmSZ1wm6bdNGWtxGgBq0F6LEAXDP5oLIKPXPm3IzwD/5nohFQp
 rjEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3vu2ku71GO9pEoNhZJeciAdokHVfRTTSGduyOitGPPwNqytLAyhV1bIM+zykuH/qj/EqDQ8qGeAU4UKwUEajiQkIXqqY=
X-Gm-Message-State: AOJu0YwnoK41ruSdLyI7axvUI3bmjnyFTvWnhvz0R5Gj9HhVn/HsAkTD
 bnqSSpwKEveUnJELPouMtApO/B0ILskEHH9BCXlpw+6ytOnue7P9oVrFTiiXvyY=
X-Google-Smtp-Source: AGHT+IERL9lQThWcYD0JzPVj8qVchh/ZgrkaW0WQNxvN14NVmip/FwXsHmvBYW4QMw0Pbgl95xdM6w==
X-Received: by 2002:adf:fa03:0:b0:367:8876:68e6 with SMTP id
 ffacd0b85a97d-3683175b8aamr6264356f8f.48.1721401783565; 
 Fri, 19 Jul 2024 08:09:43 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878694833sm1850456f8f.55.2024.07.19.08.09.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 08:09:43 -0700 (PDT)
Message-ID: <172eaa4a-ba4f-45e0-8dfb-f8035d553707@linaro.org>
Date: Fri, 19 Jul 2024 17:09:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado: Move LinuxTest related code into a
 separate file
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org
References: <20240719095031.32814-1-thuth@redhat.com>
 <02b2eb32-abbc-481c-8b5d-e6b835d81005@linaro.org>
Content-Language: en-US
In-Reply-To: <02b2eb32-abbc-481c-8b5d-e6b835d81005@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 19/7/24 14:49, Philippe Mathieu-Daudé wrote:
> On 19/7/24 11:50, Thomas Huth wrote:
>> Only some few tests are using the LinuxTest class. Move the related
>> code into a separate file so that this does not pollute the main
>> namespace.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/avocado/avocado_qemu/__init__.py  | 239 +---------------------
>>   tests/avocado/avocado_qemu/linuxtest.py | 253 ++++++++++++++++++++++++
>>   tests/avocado/boot_linux.py             |   3 +-
>>   tests/avocado/hotplug_blk.py            |   2 +-
>>   tests/avocado/hotplug_cpu.py            |   2 +-
>>   tests/avocado/intel_iommu.py            |   2 +-
>>   tests/avocado/replay_linux.py           |   2 +-
>>   tests/avocado/smmu.py                   |   3 +-
>>   8 files changed, 262 insertions(+), 244 deletions(-)
>>   create mode 100644 tests/avocado/avocado_qemu/linuxtest.py
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


