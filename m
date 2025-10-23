Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AE9CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBnOF-0007Uk-2i; Thu, 23 Oct 2025 00:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBnOC-0007UU-Vh
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:57:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBnOA-0003xE-5j
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761195442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JOg7XhGqiczjf1fz47GUtTtPfuhFSWtIfWVBhHmTlgQ=;
 b=CGqeRAH84L8/P8MZM8+CF2KH7lULTDLQVkb0q9gDBIlwUr1X4rq4Z+ivKyqpCpA2j8L+pn
 SLT0fWdaqFbDVhIR4wmWNNstif2uJUXfeOFy/oRjRn/ZbDWg3bHALIMw+ZEzMTz9zM+Jlj
 L9hRVLy9T9WKgbOYM6x8iNA50gTm1NA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-AIDLjuyyMtOtTzEVnLTI0g-1; Thu, 23 Oct 2025 00:57:20 -0400
X-MC-Unique: AIDLjuyyMtOtTzEVnLTI0g-1
X-Mimecast-MFC-AGG-ID: AIDLjuyyMtOtTzEVnLTI0g_1761195439
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b5ffd44fcc0so32913066b.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761195439; x=1761800239;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JOg7XhGqiczjf1fz47GUtTtPfuhFSWtIfWVBhHmTlgQ=;
 b=fzNmfEML7L0NTiJBwVf2G1RS6SdEAHSPzRo/z99RzR7Iu1Hzj+y1YDlxcG9QWzLumm
 twbv/Pg/o/prLwbtBvBAdvkr1OnMvGiJdAfP5bu5zU1RrcCJxrv2yt5MyFB8+XQ4fw0Y
 5NvsVCBj2wgvf3w5183w5iITTmppALedjFgDs5bimjnxeOLqWY1R6zx7nGncasgIVQ18
 y36ZIkOQHmU8Z0HRcyouuk9ClNoZmyTPrUpUt6p3+vc60TiH/Ie0C2scLYOn4p1+VM6R
 1YtcqsrUKwQtoHjgvG5pxykEjsaCNn2UlITIWVaAVwFeXT07nuzntLitO0DniJfFSh/R
 O4mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrRx6tReb/2yFXvaVO7PWnvUzrC22ej5dD/5sKuLu7ZYAULdOdqUJZOMYaMEEJADpX4JvHZ9X05+Jp@nongnu.org
X-Gm-Message-State: AOJu0YydVivBq6CaZdIOlmhpmmST1uVUDl7LIe0+hfYD1Cr6js6pse2i
 O35HuD5oO2fgJukkOe7MytVjXGyhoA6/l+2T+FQCZj/VWcfgOAjOz5Jo1o0KIT5kl8ApGOxaaSB
 vPTD3rZT8HxfYkjlO9Ro2IVVDJdnWxx6TILhlcN0gttBcSEury019rMqa
X-Gm-Gg: ASbGncsoN9VQwsTiOE8yGqJimF/q34ulSa54nN3AO8AUe6cvH+KiI4cyuH4Gh35VaGw
 eK1wPjWGtGl452uIWIbSnEPfXVBP9HzOZgfwEzC4dtXNzOH134UDQy+vpY/NvvO1VgPZa/jpP21
 zCXxtwZuEDPh7NqF48j+IRWvHmBXwIRw/CxdhYAoXQeDIRGEJ3wQR8KgxT5+/srdei+/5W7VF3j
 c5EQOMEGKFGuHBF7tNvC5mpqRFIcYPjC/dTeptAAKZCBY3JxKyyCeptXV42olut4i3UkGiHIQOJ
 ms0AgyxymU3icSTzSRMeMs8IGLl0h7fwJQ3Ov4WdKYe5VBn1VGSpgHLgaz1FQY7h6nNqQkBYyIJ
 5tEPAxM8lUSu4ElgbGG5/3Oyk4GKH8HzIzENVe20=
X-Received: by 2002:a17:907:c06:b0:b46:8bad:6977 with SMTP id
 a640c23a62f3a-b647235ff0emr3109659866b.18.1761195439181; 
 Wed, 22 Oct 2025 21:57:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3y4nZz9OU84Or/P6JzvTvAqbP6zZPygH/B99usQrlqZHot0VWnEN2X6GhFrOWO7Af3SWliA==
X-Received: by 2002:a17:907:c06:b0:b46:8bad:6977 with SMTP id
 a640c23a62f3a-b647235ff0emr3109658066b.18.1761195438792; 
 Wed, 22 Oct 2025 21:57:18 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-081.pools.arcor-ip.net.
 [47.64.113.81]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d5144d565sm104024366b.58.2025.10.22.21.57.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 21:57:17 -0700 (PDT)
Message-ID: <8a763c9e-fa0a-456c-a54b-ee409ff84644@redhat.com>
Date: Thu, 23 Oct 2025 06:57:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] tests/functional: Fix problems in testcase.py
 reported by pylint
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20251015095454.1575318-1-thuth@redhat.com>
 <20251015095454.1575318-5-thuth@redhat.com>
 <a3413bbd-e98c-4267-81c7-aa42aeda8a09@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <a3413bbd-e98c-4267-81c7-aa42aeda8a09@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 22/10/2025 21.10, Philippe Mathieu-Daudé wrote:
> On 15/10/25 11:54, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> - put 3rd party "import pycotap" after the standard imports
>> - "help" is a built-in function in Python, don't use it as a variable name
>> - put the doc strings in the right locations (after the "def" line)
>> - use isinstance() instead of checking via type()
>> - use lazy logging strings
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/functional/qemu_test/testcase.py | 251 +++++++++++++------------
>>   1 file changed, 126 insertions(+), 125 deletions(-)
> 
> 
>> -    def run_cmd(self, bin_path, args=[]):
>> +    def run_cmd(self, bin_path, args=None):
>> +        if args is None:
>> +            args = []
> 
> For my own education, what is the issue reported here?

https://pylint.pycqa.org/en/latest/user_guide/messages/warning/dangerous-default-value.html

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!


