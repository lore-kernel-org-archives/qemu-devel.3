Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F3D1125858
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Nhg-0001eh-Mx; Wed, 11 Mar 2026 13:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0Nhe-0001du-De
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:50:38 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0Nhc-0005mY-OJ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:50:38 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82985f42664so110631b3a.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 10:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773251434; x=1773856234; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Hr3CJ529aQUAC6Gc0ww+0xsT8MqRoRjBREHxdIbU84=;
 b=ixsd6x0mjisdyUoCoCPxAcAkdqwXR2YqORrWSNmsf3eGKvdWZ40bbpvfbGL17JQOsc
 hrLqTL/ZwYT98OIG78IH079bVkFt5WQbDBILHfME36VToCywFIDn9DfDWFqeCJJ7ZIve
 aH8L0KUnKS/SeRi77AbjkV4tK0qBQiajkA1c7JyL3FCBWbdjpdZebesasQX4ff2u5l9i
 SxB+T3TtEDA1aTqLdqf+8Et7ef9cAuJoud5EHFVvjja+t6mrVt263PwrDu13VEFAPMaQ
 2+PfL9Z0pLsZILGyTBX1kfxQd+TzVdZDEPSa+pltT5rjqzyS1/PSPF5zxYOjUsQb5MlI
 qr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773251434; x=1773856234;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Hr3CJ529aQUAC6Gc0ww+0xsT8MqRoRjBREHxdIbU84=;
 b=XZfTIzyZHwMWwcToKNx4wd7np/cWDAgHOxtuxFgYdTkHzTOPNwNgIFFRq2+tS6VgnQ
 3TAl/2sqTEOVxFF2CCUtdIIO5WDvRnUOsUhRG6zjS5FlVVEmLYrecIetNmkYE2po1iDD
 TSWT7tLaRN1b071Vx0314K7z10CkNj1Zl02J56/OUlJU+eQ4hfrCsOy6ie5V7JjZIB09
 Y16oX8lWvkvKunLRJEs4EGdvIbv2QdaxM+S+zmoHfsJFkcZEycxvwM3opeBGFVfAyoyC
 Z0fafwUlFD0x9kRGSFodx6ooGIbIfR98dhEjbFTGQ/sgbGpadsO3SXqackH/Tpy70aA7
 wVBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtns4c9ON9/N2dQIE4pUjFAAerJ68N7fYcCQ0QltWCf2wS16ioVY2O7GZ3rn8m8ETrhcfggx6Xwk43@nongnu.org
X-Gm-Message-State: AOJu0YxOt3fbE4Wt3K717f56V4RVvjTBlc9NBq5tNTSgzGMVvQW8tINW
 t/MjnTWuQJKQWcXFcdx8gVvliq/BmpRIO3uMX5ZedRpfkRAK01hsw3NfgWgrCdiiafYVtpYr0kA
 /SQow
X-Gm-Gg: ATEYQzyZgCPjep4LAQaZPHHUXMQSH2ptvIaw1vnpRqo6Xnc+1z8U1dU6GDAf3hrLrfU
 xUuM4pNk6LfEkkVwZMd6RUBVWIoiNC6tizML3AUu2CWlH/Ga/psg/Mv+hsVgsbCjgnfTOqY9AzB
 oksTRLK2cYO80zoImmer1cmg9FkFB0biTFAEhF4wocnoqIkBDNYOnC28ch/TQc+1d6M/TbxgP/Q
 JPx98/ob6mIthl510zrqkR4YzeHNLtO5B3uVen7dFEa6htn8izbZIRQv1Mq/hJw/ZVEGjU++W5T
 NicSLuJRZhEh5DY4C9L2j+SD03qSoUgTd/T8d2Kox6pwEuPgTen3QA2v7YfZa/WL2oPW7j3Qd0E
 VM+GTR+ShsqaObSvwRRMfMYhF2o23iutmxIgl6xNGLcjbxq4hPmbNtxwQQ2l/99i3kvBuWS2kN7
 0RDxJlk6mjJ04HbdHm/z6BuGDyLeJIbtfCZ7fZ5gY9QVcjxqPKbgURAXlxpJIoynpo3O6R
X-Received: by 2002:a05:6a00:7617:b0:81f:40e5:34c2 with SMTP id
 d2e1a72fcca58-829f70f0602mr2600178b3a.32.1773251434389; 
 Wed, 11 Mar 2026 10:50:34 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a0736e64bsm248768b3a.50.2026.03.11.10.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 10:50:34 -0700 (PDT)
Message-ID: <3a411a2e-a853-410f-a3f1-5af02c04005e@linaro.org>
Date: Wed, 11 Mar 2026 10:50:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: OS command injection in QEMU
Content-Language: en-US
To: =?UTF-8?Q?Yakup_Ate=C5=9F?= <yakup.ates@yatesh.de>, qemu-devel@nongnu.org
References: <17617957-ddba-4c4d-aa0c-c7bc26e06166@yatesh.de>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <17617957-ddba-4c4d-aa0c-c7bc26e06166@yatesh.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

Hi Yakup,

On 3/11/26 9:56 AM, Yakup Ateş wrote:
> Dear ladies and gentleman,
> 
> I found an OS command injection vulnerability in QEMU.
> 
> I want to file a CVE ID and explain  the vulnerability to you and get 
> you to confirm the vulnerability for the CVE ID.
> 
> How does the process work exactly with you guys? How can I transmit this 
> to you on an encrypted channel?
> 
> Thank you in advance!
> 
> -- 
> 
> Best Regards
> 
> *Yakup Ateş*
> 
> Chief Executive Officer
> 
> yatesh
> 
> 	yatesh Logo
> 
> Phone Icon +49 1523 8023340
> Email Icon yakup.ates@yatesh.de
> Website Icon yatesh.de <https://yatesh.de>
> Address Icon Kostheimer Straße 12, 60326 Frankfurt am Main
> 
> *yatesh thinks green.* Please consider the environment before printing 
> this email.
> 
> This email message and any attachments are sent by yatesh, are 
> confidential, and may be proprietary or privileged. If you are not the 
> named or intended recipient, please notify us immediately by replying to 
> this message or sending an email to info@yatesh.de and delete all copies 
> of this message and attachments. Do not disseminate, distribute, or copy 
> this email.
> 

you can report it using this process:
https://www.qemu.org/contribute/security-process/

Thanks,
Pierrick

