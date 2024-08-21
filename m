Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95424C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 10:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgiQc-0002uc-Md; Wed, 21 Aug 2024 06:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgiQa-0002rj-Fq
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 06:18:56 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgiQY-0004Mq-OA
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 06:18:56 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-428ec6c190eso54888045e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 03:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724235532; x=1724840332; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8cJ8ZLRBQXJpfN0/YVV8zxPpEjdPLb4aPd4vjCY4qWo=;
 b=VAiNnifcDHdmBRjQ/TPDsnKLHDccFfERQxcr7NGeHh66YgS+mSgGaD+i5zkR479Uhw
 vtS3wBGVKeAh+m3Smzeh76fw/juMc1fkVXarkTmVV2Zn4uf1El5QZSnKl12GhOXLLcPP
 ptQLA2rmlt967skFBat2coo798FUORQC77zn+Rkb2iEbFQv+JXvAtQglhidHu8Q7C8dq
 0LXjE8oVedl71iPjeImicw7SseSv42dQ1GmCjOZtoW76u+OaHr2s3QokcNMH2qiqHjM6
 JMToIwVYGuK2iWfdZjxtT3W7TX6u4rU9DMg7M7eqLuLScNMTrwF8x6v4ZlnXM0Y60mrq
 WFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724235532; x=1724840332;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8cJ8ZLRBQXJpfN0/YVV8zxPpEjdPLb4aPd4vjCY4qWo=;
 b=knc6WEgM2yTuM+yBYUDjJ3h8LUjToKovCpjGHDiHODvJBqT3HZZO3mG5j1L9Jh6HKK
 HsZFsI1O18bRC4W3mPVKX+IYdanbFOr5hbS9KyKiooL0jpBBlasX4Vu9NFBTmax3oN9L
 c6Zu2FZzLHCjGExiNFc+0qNVjzybQ8LsdYmyTw5/C95VpINeyaXKZn+b9M3Jc2EkZM73
 Y9M+/zJ2oMrQ7V3aY4UfHkvP3HbTOMy4lM485OJbdSDjdy6IE1fQ4yt/B2VQDOS0VHCC
 UFIOOKCQIDLnPZWtriQSHuIH/fnOFGa1tEFfYmEFU9o7KCMYRScKH4sDIOUtVOMqSlxe
 Xreg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTCiX+FySzmrYKRYa2dUEiWXoxq0Fpjdj40YsO05htaBrqHApbAnfWuwvHksECrgVK0Tjf5q+KauJX@nongnu.org
X-Gm-Message-State: AOJu0YwxWtYGXwhsCCH/lbYIiOrf+Zt6Gmq8/c3rRBJWhPhuqFGrwDkb
 RLImBf2ZwvAXNm41aGD5LbP2hCnL86cxk3QEqls5gdti2e/jT6s7glwGc8OA+4w=
X-Google-Smtp-Source: AGHT+IEx/GaXauXCcpMnLVmbeOkmJKzJVIfHbZmVpe0BQzIb+cIiTM2JVyP4mrH4tJuFVcKRXmR67g==
X-Received: by 2002:a05:600c:4f09:b0:427:b995:5bd0 with SMTP id
 5b1f17b1804b1-42abd25ddf5mr13907405e9.23.1724235532117; 
 Wed, 21 Aug 2024 03:18:52 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.218.99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42abed8bbebsm20287035e9.7.2024.08.21.03.18.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 03:18:51 -0700 (PDT)
Message-ID: <5ddfefcd-2c74-43b6-bb5f-9169facc6b88@linaro.org>
Date: Wed, 21 Aug 2024 12:18:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/35] tests/avocado/avocado_qemu: Fix the "from"
 statements in linuxtest.py
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-6-thuth@redhat.com>
 <b5d2ffce-3f78-4e20-98b3-f5017f31e227@linaro.org>
 <ea5ff51b-c0e9-4e20-8100-540c6e711110@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ea5ff51b-c0e9-4e20-8100-540c6e711110@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 21/8/24 12:07, Thomas Huth wrote:
> On 21/08/2024 11.31, Philippe Mathieu-Daudé wrote:
>> On 21/8/24 10:27, Thomas Huth wrote:
>>> Without this change, the new Avocado v103 fails to find the tests
>>> that are based on the LinuxTest class.
>>
>> Reorder before previous patch?
> 
> The funny thing is that Avocado v88 breaks the other way round if this 
> patch gets applied first. So if you are worried about bisecting, we'd 
> need to squash this into the patch that updates the version. OTOH, it's 
> not a big breakage, just some tests are not run by the test runner, so I 
> think it's ok to keep it separate.

Argh OK, fine then!

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

I'm not adding my R-b because I don't understand what is
wrong in the current code and the commit description is
a justification but not an explanation; but I don't mind.

> 
>   Thomas
> 
> 
>>> Suggested-by: Cleber Rosa <crosa@redhat.com>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   tests/avocado/avocado_qemu/linuxtest.py | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/avocado/avocado_qemu/linuxtest.py 
>>> b/tests/avocado/avocado_qemu/linuxtest.py
>>> index e1dc838b1c..66fb9f1507 100644
>>> --- a/tests/avocado/avocado_qemu/linuxtest.py
>>> +++ b/tests/avocado/avocado_qemu/linuxtest.py
>>> @@ -13,8 +13,8 @@
>>>   from avocado.utils import cloudinit, datadrainer, process, vmimage
>>> -from . import LinuxSSHMixIn
>>> -from . import QemuSystemTest
>>> +from avocado_qemu import LinuxSSHMixIn
>>> +from avocado_qemu import QemuSystemTest
>>>   if os.path.islink(os.path.dirname(os.path.dirname(__file__))):
>>>       # The link to the avocado tests dir in the source code directory
>>
> 


