Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4961CE7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 10:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ8nK-00054t-7D; Thu, 05 Dec 2024 05:09:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tJ8nI-00054V-8E
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:09:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tJ8nG-0000DT-7V
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 05:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733393347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wCTwDYT7UwOYjwW89hzAmV986bRLzZkT8PKASSePyKc=;
 b=ANVZEzQQOMaJ/MVz2HnWuYgiLQ1G7YDinDc7Fqb/k24JQyvqJHFEGJl3KsMPsPrZSf1in5
 nxvKwj92fMI0nmcvSvB4NEkANenEZRgPmIBvSLthATwy15YwDFLJZAfjq+3eDNnnLh13Wc
 laeVXts2lK1jgl46buwZt3pP5gHzHqs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-YWnv_V4CMUe_Ud_SPeyHew-1; Thu, 05 Dec 2024 05:09:04 -0500
X-MC-Unique: YWnv_V4CMUe_Ud_SPeyHew-1
X-Mimecast-MFC-AGG-ID: YWnv_V4CMUe_Ud_SPeyHew
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3860bc1d4f1so445079f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 02:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733393343; x=1733998143;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wCTwDYT7UwOYjwW89hzAmV986bRLzZkT8PKASSePyKc=;
 b=L0RDqRIAUTURmWBUCiKX7ckNA6yDyqFjHZw7HZagI9WnVbwbzzgzLW630/1VmJmGAV
 vG8wRrEiQW0FoRvtF0/wIJup0OUfIH/fFJXDR+OG7jRvFiluVs9vBRy9Nz3qj1cZ5fgx
 mU6/ntevrk1NiyD2IYpWOIvXhJFrPG8VXGxhGb4XyxKNQICKKS2almwwk0cBbzs1UuUd
 /UdfZoKH6/3NKfSycfzl2BpPhMmHWN9eiRmRUW0SzXNAi0NpQZGreZO7vzhV7+UuPc70
 Q9YoYZBiyOAGoMYU/vTa6sLO95P2cbRsyAE+GkwKjYym+ggJfbGTOM51GCArnd76sXtK
 /PTw==
X-Gm-Message-State: AOJu0Yxsc0CzyalPtfHdURctVGg2QRsDh1VbYIu070c0+uJyBN4am0vn
 OIJesXU/xjMCqHP2zmuryZwwBu4c90KIrworr0X477e/T9BaSUGiqRMc9//tBuwG8lY8i3+CZu1
 0rlzKm5/JyaNxX8vaRqsJgFytaWR9BuAwuIuwh7XuMWO+4wttSxcd
X-Gm-Gg: ASbGncvdkohs6smUNXtrB0bYqeGEJ9ec8pyBW/HsrqbuoWSad3eHkEh5TtMfNEO5b1X
 fhpwQcyyRmy3swqxdJlgTy30a1Z2EAuMjeyctS9NPvkFaB96+OiNWFZYE2aBZUb987PAJObXdQe
 L7neakcQUtM+SSz/5QnHYBm81SzCLYUN/geeGduGX3y/DCXg9sxEc6WyQYkcBbF8uj8Kh6cBNub
 pFNZJ4y/BFiwyAmYQ0sJvL/Vvk6VidFDniQWd6i+uo/ggLf7WPATic/4FyR6brBjOjfc30VofJX
 IXiGkw==
X-Received: by 2002:a5d:64e8:0:b0:385:f5c4:b318 with SMTP id
 ffacd0b85a97d-385fd3ed9e9mr7950335f8f.31.1733393343250; 
 Thu, 05 Dec 2024 02:09:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsmFjMso0SXuQ8TCk1J6QXz8ahFoBjDahW326rPlrofGUBMGjbPkR29zQz8Yxmz+gV29CFBg==
X-Received: by 2002:a5d:64e8:0:b0:385:f5c4:b318 with SMTP id
 ffacd0b85a97d-385fd3ed9e9mr7950312f8f.31.1733393342913; 
 Thu, 05 Dec 2024 02:09:02 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-244.web.vodafone.de.
 [109.42.48.244]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3862190975fsm1495471f8f.68.2024.12.05.02.09.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 02:09:02 -0800 (PST)
Message-ID: <8b4f3905-dd97-47de-b8e5-05b5e072ced1@redhat.com>
Date: Thu, 5 Dec 2024 11:09:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] gitlab: clean packages in cirrus tasks
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241204194807.1472261-1-berrange@redhat.com>
 <20241204194807.1472261-4-berrange@redhat.com>
 <c632357b-bfd0-483d-8f80-6310a0ffee13@redhat.com>
 <Z1FwGo_7AfYjwX6X@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z1FwGo_7AfYjwX6X@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 05/12/2024 10.19, Daniel P. Berrangé wrote:
> On Thu, Dec 05, 2024 at 09:58:54AM +0100, Thomas Huth wrote:
>> On 04/12/2024 20.48, Daniel P. Berrangé wrote:
>>> The FreeBSD VM is somewhat low on disk space after all QEMU build deps
>>> are installed and a full QEMU build performed. Purging the package
>>> manager cache is a simple thing that reclaims about 1 GB of space.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>    .gitlab-ci.d/cirrus.yml       | 2 ++
>>>    .gitlab-ci.d/cirrus/build.yml | 1 +
>>>    2 files changed, 3 insertions(+)
>>>
>>> diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
>>> index 16411f3d2b..2bd3cb35c9 100644
>>> --- a/.gitlab-ci.d/cirrus.yml
>>> +++ b/.gitlab-ci.d/cirrus.yml
>>> @@ -42,6 +42,7 @@ x64-freebsd-14-build:
>>>        CIRRUS_VM_RAM: 8G
>>>        UPDATE_COMMAND: pkg update; pkg upgrade -y
>>>        INSTALL_COMMAND: pkg install -y
>>> +    CLEAN_COMMAND: pkg clean -y --all
>>>        CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,microblaze-softmmu,mips64el-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4eb-softmmu,xtensa-softmmu
>>>        TEST_TARGETS: check
>>> @@ -54,6 +55,7 @@ aarch64-macos-build:
>>>        CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-runner:sonoma
>>>        UPDATE_COMMAND: brew update
>>>        INSTALL_COMMAND: brew install
>>> +    CLEAN_COMMAND: brew cleanup --prune=all
>>
>> Are we also short on disk space in the macOS jobs? Otherwise, I wonder
>> whether we should rather skip the step here to save some seconds of run
>> time?
> 
> I've not measured it, but I've not seen disk space issues on macOS. Still
> this command is quick and lost in the noise of the package install process
> which will vary depending on network performance and homebrew server load.

Ok, fair, so if it is a quick command:

Reviewed-by: Thomas Huth <thuth@redhat.com>


