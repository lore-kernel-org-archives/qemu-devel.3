Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7AED41D66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 08:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAlqE-0001Qp-F1; Tue, 12 Nov 2024 03:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tAlqB-0001QI-2T
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 03:01:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tAlq8-0006tD-3m
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 03:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731398491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=me7m3Ff2If6PHFRvOPduTppYCU+VNRwj/tjOWdLC4rg=;
 b=AMpm8fi/9pq+Vb1X7hdRNBhpaK2bsz4wb8U9KCfuTb9WgJBk8MkIBe6d8gS5qQDdy6+Mho
 mwmWg5FRDS49Zqx+c3GJYGAEyAHynonkCTvgUiFw8joDgovbjKGKcQ2bFvrMpLYrTTPouR
 HHTjM3wTNDFStiDZqaAGw1wPAGnxK7U=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-Bl2JaAjWPACEDaH6usgtNw-1; Tue, 12 Nov 2024 03:01:28 -0500
X-MC-Unique: Bl2JaAjWPACEDaH6usgtNw-1
X-Mimecast-MFC-AGG-ID: Bl2JaAjWPACEDaH6usgtNw
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b14cb9f6f5so728378785a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 00:01:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731398487; x=1732003287;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=me7m3Ff2If6PHFRvOPduTppYCU+VNRwj/tjOWdLC4rg=;
 b=Cc+dTGq9YWAu53yRoKlXkegiQ0g1hWK470ifsvBh5ItkaSHzD0SFKN4tyjUvMXb+0s
 i98Isr67we91scP9AVKCih9V9SEVEXahknV8N91Rv/i8Rn1D2TqReZkYjga/YwOdME+r
 qPbj7gqDmw8gRokE1hSBiTWcf60T1Yl9fDK6GUPzK8pagxNoREzjdfa+5MWDIsVnFJhV
 PHYkL8Qe/SgcBQGokRT2gKLqAwl6HVOBuYm9lWKQ/wLE5kxzEZM/fKbOSrm9Qae7zjSP
 3PotUfUqnW9AjC8swFGvvScNSIwLXRGxLaV4+SA2HdTvKasbeshtS+VVpG70eo6YQ4cz
 Zecw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwnXDh2wkdRoRx6/ikXAe3gDJ4hMqZ/GFsrfaCo+8Oc9cUdDXW4CBG8TIGNoXvHptcedjUF1GxzSe0@nongnu.org
X-Gm-Message-State: AOJu0YxWXUPmORoCzrbjt48Eoc6BafdlM4VT2YAZ2Wlcbh7AwndKtc4k
 V9HbDCjUF6vj5GxHMDMGm4LKchJIojp38ZlJa+YtQUKJ9okGOrYBG6rNP2nycGdIzpNCantOE3s
 N79xfqbTx+z3MdMkzuaH9x/7BWKMztJ4Emt0QR0KSF8J7l05hAJnT
X-Received: by 2002:a05:620a:17ac:b0:7ac:e879:1a20 with SMTP id
 af79cd13be357-7b331e88c15mr2436770285a.1.1731398487662; 
 Tue, 12 Nov 2024 00:01:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzy9r8zc+UdSKz2fSnuavROmhmSnXBGiJ0EioGs5bbu+Ifdyo8sgv+uHiIMsO099lG26QXHA==
X-Received: by 2002:a05:620a:17ac:b0:7ac:e879:1a20 with SMTP id
 af79cd13be357-7b331e88c15mr2436767085a.1.1731398487307; 
 Tue, 12 Nov 2024 00:01:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b32acf47a6sm568556285a.120.2024.11.12.00.01.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 00:01:26 -0800 (PST)
Message-ID: <a84a1d5e-bc7b-46c8-9ab0-5e2470a3811b@redhat.com>
Date: Tue, 12 Nov 2024 09:01:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] tests/functional: Introduce _console_read()
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241112062806.838717-1-clg@redhat.com>
 <20241112062806.838717-2-clg@redhat.com>
 <3bea84f6-098f-4956-a40d-651b567212c2@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <3bea84f6-098f-4956-a40d-651b567212c2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
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

On 11/12/24 08:11, Thomas Huth wrote:
> On 12/11/2024 07.28, Cédric Le Goater wrote:
>> Interaction with the console has been a problem in our avocado
>> tests. In some cases, the expected string does not match in the
>> output, causing the test to fail with a timeout. These were worked
>> around by sleeping before reading the console and even with SSH
>> connections in some places.
>>
>> To fix, process the console output char by char and not with
>> readline. This routine was largely inspired by console_wait() in
>> tests/vm/basevm.py.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   tests/functional/qemu_test/cmd.py | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
>> index cbabb1ceed3c..bb39857e6cae 100644
>> --- a/tests/functional/qemu_test/cmd.py
>> +++ b/tests/functional/qemu_test/cmd.py
>> @@ -12,6 +12,7 @@
>>   # later.  See the COPYING file in the top-level directory.
>>   import logging
>> +import re
>>   import os
>>   import os.path
>>   import subprocess
>> @@ -78,6 +79,20 @@ def run_cmd(args):
>>   def is_readable_executable_file(path):
>>       return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
>> +def _console_read(vm, expect, expectalt = None):
>> +    output = ""
>> +    while True:
>> +        data = vm.console_socket.recv(1)
>> +        if not data:
>> +            break
>> +        output += data.decode("latin1")
>> +        if expect in output:
>> +            break
>> +        if "\r" in output or "\n" in output:
>> +            lines = re.split("[\r\n]", output)
>> +            output = lines.pop()
>> +    return output
>> +
> 
> The idea looks promising, but I just realized that this is breaking the console.log:
> 
> $ cat tests/functional/arm/test_arm_aspeed.AST2x00Machine.test_arm_ast2500_evb_buildroot/console.log  | wc -l
> 12
> 
> Without your patch, the log is way more verbose:
> 
> $ cat tests/functional/arm/test_arm_aspeed.AST2x00Machine.test_arm_ast2500_evb_buildroot/console.log  | wc -l
> 232
> 
> Could you please have another look?

sure. I can add a log.debug.


Thanks,

C.



> 


