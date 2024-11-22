Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C074FD75E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 13:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEU5N-0002oA-U0; Fri, 22 Nov 2024 08:52:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tEU5L-0002nJ-R1
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 08:52:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tEU5J-0005JV-Pl
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 08:52:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732283552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uMAsz0cucGnnDkVXKJG4RPqzmSqorsO9L0gIyjPa/hc=;
 b=dKKvYIRY1Ib7gBWjQPr36XsNpw9TA4KDzC5QkkTvOVIaD3jfqi3JD6XWHFMLInRKxTqqY5
 p96/xiQO6ai9p90k88sYInD+YffEMiiIgrKGVtx8axM8XO6AdS8zHLgJ5VRDa+chZbjXBN
 PM800+nyjo0pDX1uUEOURwObO7SKi1U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-DHVZx9aXOIy5pQ1u7bNs0A-1; Fri, 22 Nov 2024 08:52:31 -0500
X-MC-Unique: DHVZx9aXOIy5pQ1u7bNs0A-1
X-Mimecast-MFC-AGG-ID: DHVZx9aXOIy5pQ1u7bNs0A
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4316e2dde9eso18656165e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 05:52:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732283547; x=1732888347;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uMAsz0cucGnnDkVXKJG4RPqzmSqorsO9L0gIyjPa/hc=;
 b=n+l6VkC4u2bbbvThhBuX/Hd8pxkREA0lA845QjnVz00chfwTul5z1/Z3rKRZp25Xa5
 B6HoGecAE5wr4i+7XNgJLwZiUZ00LlqZGQsDJXVGFwH0XL4frwmfF3xfKcS0NFpM8Yuo
 UgTceoqptXgv4sK82UaM8iyPuDtD5DvIeqeGKe1zrGTV+9EtR5rO8R84NESm3+0YszjC
 jyScLQA5uBhqL17Xof+f2CXnsPtshl2oJYFscp3hkEbfMuntT7nKtUfdxEIMriImNeVa
 ueZrKnVr/HHAMef7bqwMoUCzcv1GAHaNZ1Eala5zQS7Ud1FcawYeOHUpwr4qjw3DABJ4
 28IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt+w7dkFwyYMMRxUjM+aPxWwrVcO+5rNsXo9rHU+m2Ft+aj5lz/XKFy/7w/QjiNMmNmvNqNmQCI6P2@nongnu.org
X-Gm-Message-State: AOJu0YzoK01XcLlKAI0TXXUL2BLYaaHWUicMFXbOJ3nV1eXQ5QTuzU58
 5C3oGHkJ4KwN0b8k4TIUpgkS04XzABTeWC77dSEvrhUJNqJxErdyMoiSnFf/AY6j9rPACNtOtc8
 KJHYvq5VyfC/UwIxx3l3YtC7sthwAWMTS2MnoQFeEOPrWnuVh6ux33d7BxlxW
X-Gm-Gg: ASbGnct7JKQb5AuUZf30+bqG6GSVIwp/6bNVDBJAPLwPJ1/iRIHiJl0u9IYtqFpQLLu
 M8OQHTt5esYt56/p4dP80kr7aWl385ypjrzmzCUXL6gnhX7i5bLab+D2dUdJW+B6/0Gi16bslYm
 4t9ZbmBAVY/ACAEXJCqMzy4a2zxRvdSLQ/2eE5rpkAiC3sIQGOgZEzlb2PpK7xbRuIXwr2QK/fE
 z2IaegU5Jg3t7EP01IGroVs+mPete9AHg6aGag1Z55y2VibvWQ8p1AY0Y1fLE5dHTn+PxrImX7/
 J+eQZVlGiUYF
X-Received: by 2002:a5d:6d8c:0:b0:382:51ae:755c with SMTP id
 ffacd0b85a97d-38260bc6d05mr3572797f8f.46.1732283547677; 
 Fri, 22 Nov 2024 05:52:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJcJB8wAsUIDBCuWHXrJvPkWMAjljOt6JKMV3bPVNoDeQW4tlR8h4s+wLqfUrpduqUCqzMzg==
X-Received: by 2002:a5d:6d8c:0:b0:382:51ae:755c with SMTP id
 ffacd0b85a97d-38260bc6d05mr3572779f8f.46.1732283547318; 
 Fri, 22 Nov 2024 05:52:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825faf9d97sm2441276f8f.35.2024.11.22.05.52.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 05:52:26 -0800 (PST)
Message-ID: <a02705f0-e07b-4829-81f7-df76bb574df0@redhat.com>
Date: Fri, 22 Nov 2024 14:52:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Remove sleep workarounds from sh4 test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20241122130804.2013662-1-clg@redhat.com>
 <a1026443-c8d4-4e07-9d8c-0bd2356e8cf0@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <a1026443-c8d4-4e07-9d8c-0bd2356e8cf0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/22/24 14:49, Thomas Huth wrote:
> On 22/11/2024 14.08, Cédric Le Goater wrote:
>> These were introduced in the avocado tests to workaround read issues
>> when interacting with console. They are no longer necessary and we can
>> use the expected login string instead.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   tests/functional/test_sh4_tuxrun.py | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/tests/functional/test_sh4_tuxrun.py b/tests/functional/test_sh4_tuxrun.py
>> index 352cb360ef74..dcb49f28b9aa 100755
>> --- a/tests/functional/test_sh4_tuxrun.py
>> +++ b/tests/functional/test_sh4_tuxrun.py
>> @@ -15,7 +15,7 @@
>>   import time
>>   from unittest import skipUnless
>> -from qemu_test import Asset, exec_command_and_wait_for_pattern, exec_command
>> +from qemu_test import Asset, exec_command_and_wait_for_pattern
>>   from qemu_test.tuxruntest import TuxRunBaselineTest
>>   class TuxRunSh4Test(TuxRunBaselineTest):
>> @@ -46,10 +46,8 @@ def test_sh4(self):
>>                            console_index=1)
>>           self.vm.launch()
>> -        self.wait_for_console_pattern("Welcome to TuxTest")
>> -        time.sleep(0.1)
>> -        exec_command(self, 'root')
>> -        time.sleep(0.1)
>> +        self.wait_for_console_pattern("tuxtest login:")
>> +        exec_command_and_wait_for_pattern(self, 'root', 'root@tuxtest:~#')
>>           exec_command_and_wait_for_pattern(self, 'halt',
>>                                             "reboot: System halted")
> 
> Could we also remove the  @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS')...) now?
> 
>   Thomas
> 

I didn't because of this comment :

     # Note: some segfaults caused by unaligned userspace access

It does not reproduce on my systems though.

C.


