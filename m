Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108AECA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 10:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl4Db-0005yT-TM; Mon, 02 Sep 2024 06:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sl4Da-0005xo-I6
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 06:23:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sl4DY-0006gb-RV
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 06:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725272605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AZ2xDhBEhoBmrOlGJPO5TgQtF3BHSB44Ptz162fxdUk=;
 b=VCVNOPGnTWqN2mNJBHhK29wa2llpUkcnW+FVkHoiu1+W0vBq1MVMr6eoaq1ATjXCx/babO
 pl1mNeuTu6Z/ZoQ7jAm6FosBrKfuRXUxwm7Ft51sZlNtTd8TK06SoshvMoA/JwIZ08moJq
 CpnVCFAmloblBpMwTAzZiRlXiN2LPDE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-OaUyQMbWPTO6NymleW7W6w-1; Mon, 02 Sep 2024 06:23:22 -0400
X-MC-Unique: OaUyQMbWPTO6NymleW7W6w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42c7b6358a6so15123945e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 03:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725272601; x=1725877401;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZ2xDhBEhoBmrOlGJPO5TgQtF3BHSB44Ptz162fxdUk=;
 b=PjFOyicGRaECiG2I6eYuQV512XZiROVBD25l/AwiO6aPde1wz19eXTIZ7oPh5v8YZ3
 jBLSLvI3dOGFoSDyzy71+J4R8aNR4icsGSMFzoK8uSxOyDHi7C0Wzz/W71CFaput3fuA
 oQAMgjNlCYEU+DARun2QbiiJNwByIRSgFLznrCUQS/5EMk0IXrGgv3BMIlnjAkVP1MQk
 IxkZsMvc9O/B/QDazRVwYzCP0JmXahgn8AtM4aT4jbRtWGQmWr+ttNW8OfBkGaTO0xD7
 2oUkOJDQArdb/f+kuaukYo5dy38nAZbmny/v6/AZpzP1IMmoz830hJvMiS7teI+zhSrp
 wdDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfZ7GAvQlJz3XRmI2pYGSdGQcLT56PPU78P5FFGqApfwgMLl3V2zqG61S21bTMJUkqYONC0der8ATa@nongnu.org
X-Gm-Message-State: AOJu0YwDYLcu/pQpwReVJnr+weNTfhrR8AHbSkcvSXTDuAaKw5z2qQZZ
 dNoVUr777i7D+5/NJ8zAa5DFrpa8ZDQ3reftW4C2w7D8fVJE0PHs/NgUZGOktwAHg8TtcLB9k4t
 0elKkmsiX+nSaxeG+iO0WI6ZpFrbhxsS19vXxCH4SoombMOf5OJDF
X-Received: by 2002:a05:600c:3b1e:b0:426:62df:bdf0 with SMTP id
 5b1f17b1804b1-42c82f5318fmr18992485e9.10.1725272601474; 
 Mon, 02 Sep 2024 03:23:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiXhHHFEj+NfX/TzP3dRzsu/PzlxaqfajSl3hxkib0MBqqLmveBY6pO6+zTESdO3MHnbUYXw==
X-Received: by 2002:a05:600c:3b1e:b0:426:62df:bdf0 with SMTP id
 5b1f17b1804b1-42c82f5318fmr18992325e9.10.1725272600981; 
 Mon, 02 Sep 2024 03:23:20 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6deb43esm133588675e9.7.2024.09.02.03.23.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 03:23:20 -0700 (PDT)
Message-ID: <d72b302a-ec99-4eed-bd7b-cb79ec714a49@redhat.com>
Date: Mon, 2 Sep 2024 12:23:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 32/44] tests/functional: Convert the vnc test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240830133841.142644-1-thuth@redhat.com>
 <20240830133841.142644-33-thuth@redhat.com>
 <a11813f6-6a11-4467-8f4f-1435f5284f28@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <a11813f6-6a11-4467-8f4f-1435f5284f28@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 02/09/2024 11.48, Philippe Mathieu-Daudé wrote:
> On 30/8/24 15:38, Thomas Huth wrote:
>> Nothing thrilling in here, it's just a straight forward conversion.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/functional/meson.build                     |  1 +
>>   tests/{avocado/vnc.py => functional/test_vnc.py} | 12 +++++++-----
>>   2 files changed, 8 insertions(+), 5 deletions(-)
>>   rename tests/{avocado/vnc.py => functional/test_vnc.py} (97%)
>>   mode change 100644 => 100755
>>
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index 34a9b277f8..58f6bcf95d 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -107,6 +107,7 @@ tests_x86_64_system_quick = [
>>     'pc_cpu_hotplug_props',
>>     'virtio_version',
>>     'x86_cpu_model_versions',
>> +  'vnc',
>>   ]
>>   tests_x86_64_system_thorough = [
>> diff --git a/tests/avocado/vnc.py b/tests/functional/test_vnc.py
>> old mode 100644
>> new mode 100755
>> similarity index 97%
>> rename from tests/avocado/vnc.py
>> rename to tests/functional/test_vnc.py
>> index 862c8996a8..b769d3b268
>> --- a/tests/avocado/vnc.py
>> +++ b/tests/functional/test_vnc.py
>> @@ -1,3 +1,5 @@
>> +#!/usr/bin/env python3
>> +#
>>   # Simple functional tests for VNC functionality
>>   #
>>   # Copyright (c) 2018 Red Hat, Inc.
>> @@ -11,7 +13,7 @@
>>   import socket
>>   from typing import List
>> -from avocado_qemu import QemuSystemTest
>> +from qemu_test import QemuSystemTest
>>   VNC_ADDR = '127.0.0.1'
>> @@ -51,10 +53,7 @@ def find_free_ports(count: int) -> List[int]:
>>   class Vnc(QemuSystemTest):
>> -    """
>> -    :avocado: tags=vnc,quick
>> -    :avocado: tags=machine:none
>> -    """
>> +
>>       def test_no_vnc(self):
>>           self.vm.add_args('-nodefaults', '-S')
>>           self.vm.launch()
>> @@ -113,3 +112,6 @@ def test_change_listen(self):
>>           self.assertFalse(check_connect(a))
>>           self.assertTrue(check_connect(b))
>>           self.assertTrue(check_connect(c))
>> +
>> +if __name__ == '__main__':
>> +    QemuSystemTest.main()
> 
> For a faithful conversion we need to squash:
> 
> -- >8 --
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 6b00d240dd..a590646adc 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -26,6 +26,7 @@ tests_generic_system = [
>     'empty_cpu_model',
>     'info_usernet',
>     'version',
> +  'vnc',
>   ]
> 
>   tests_generic_linuxuser = [
> @@ -123,7 +124,6 @@ tests_x86_64_system_quick = [
>     'pc_cpu_hotplug_props',
>     'virtio_version',
>     'x86_cpu_model_versions',
> -  'vnc',
>   ]
> 
> ---
> 
> (each test is <1s so I'd keep it generic).

Unfortunately that doesn't really work - the test cannot be really be run in 
parallel since the find_free_ports() stuff here is racy.

  Thomas



