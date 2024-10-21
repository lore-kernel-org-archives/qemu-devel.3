Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B7AD0E6F0
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 10:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2pyk-0002Qb-VH; Mon, 21 Oct 2024 06:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2pyi-0002QJ-2S
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:49:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2pyg-0003od-13
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729507772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0BAe0Azdt5/qe4cPQChGlzur7tFIrObRJgi/NlfweVw=;
 b=BvPI8+D4c/UypS663kHmkAIDZ+UVGtCy6V3dmBSZJM3N3IE2hwyOwMvJwUva2A3zGpz1S0
 N8NM2MtE5Bc/HNQfIL7YN9Lo6opxLUaPeoJlDa+HPxg44g45fET48LZ8MXNmyjDhyao5XA
 LRWD5HWXb2bwjnce6Y7EApkgYDzXuo4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-4weVbn1xOAS7Wo7Od5euaw-1; Mon, 21 Oct 2024 06:49:31 -0400
X-MC-Unique: 4weVbn1xOAS7Wo7Od5euaw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43151e4ef43so31975285e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 03:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729507770; x=1730112570;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0BAe0Azdt5/qe4cPQChGlzur7tFIrObRJgi/NlfweVw=;
 b=RR0EhK7e0nSJajcxQmUg5j2rM+KOcJzJaEYNmydbuxZZKDa3GJU8tAaySqErlsTw2r
 J8HHBwkKnfu3EVlejjuyY47Ef0D8QgFvRJ0v3ARKn8CQtTcqNl8Z30Mx9kThxxJ2Gjnx
 n+CHeVkIBqpTVKPDEHeCzZIyL3m1x5YT4NqX4WMPIxaOwYkRKgQqkyVrNE46P9IkVerQ
 sZK4uUjoQCSGITj5Rnu5lsxYmP9g1vG4IEAYEdTyVSQrdOKM/aETTyKgIGCAf43CsrV/
 q7V3iCmUryl8DnAVvBB8clQ2Pyx8VX3o68sRHGfhYvBHQp9DG2aGeqJC5ZRIfM2b1j58
 vaew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDvh96XyRYoI20k6dHWFXm5ANCLWfd1ggpOwXW3p+o3kmB+A285fCsPqyFR8pk10JxOocHTQBnl+y2@nongnu.org
X-Gm-Message-State: AOJu0Yx7ysQVdoHF35uJD/Y/y7Lo4azEby3bWBiw7cnIo6+tLV8ZPoH6
 /mpAucZkv6Gd4nSVdEu8vfaoU2OU++XD8JU4KoAgCyFY34gftJ/8FBVZeXQLaDtmEMQwD4gPsBd
 mfJGX5wvGqoAz+KczAhlDOUIQcx++grlZ35qjCfZsCxtXh6IStucv
X-Received: by 2002:a05:600c:5489:b0:431:5a27:839c with SMTP id
 5b1f17b1804b1-43161636f10mr94521025e9.5.1729507770217; 
 Mon, 21 Oct 2024 03:49:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd7QVaDp5S/y2xqYL43HplEMVuCf/dHex9sHqev7f1bU+lU7z029W1+4MaPqetwpvkqNoQow==
X-Received: by 2002:a05:600c:5489:b0:431:5a27:839c with SMTP id
 5b1f17b1804b1-43161636f10mr94520745e9.5.1729507769829; 
 Mon, 21 Oct 2024 03:49:29 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-24.web.vodafone.de. [109.42.50.24])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5c2c8esm53444745e9.36.2024.10.21.03.49.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 03:49:29 -0700 (PDT)
Message-ID: <c6f9071b-4473-4d12-9f89-283289eab5a0@redhat.com>
Date: Mon, 21 Oct 2024 12:49:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/vm: update openbsd image to 7.6
To: Brad Smith <brad@comstyle.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Alex Benn_e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud_ <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <ZwtmfVlWgFRF9G8W@humpty.home.comstyle.com>
 <ZxYee2xa-VJjOQSV@redhat.com>
 <c086dbe4-bcd9-4a90-99ef-8c2cda37471d@comstyle.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <c086dbe4-bcd9-4a90-99ef-8c2cda37471d@comstyle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 21/10/2024 11.58, Brad Smith wrote:
> On 2024-10-21 5:27 a.m., Daniel P. Berrangé wrote:
>> On Sun, Oct 13, 2024 at 02:19:41AM -0400, Brad Smith wrote:
>>> tests/vm: update openbsd image to 7.6
>>>
>>> Remove tomli as Python has been updated to 3.11.
>>>
>>> Signed-off-by: Brad Smith <brad@comstyle.com>
>>> ---
>>>   tests/vm/openbsd | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
>>> index 49cab08782..dfd11c93f0 100755
>>> --- a/tests/vm/openbsd
>>> +++ b/tests/vm/openbsd
>>> @@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
>>>       name = "openbsd"
>>>       arch = "x86_64"
>>> -    link = "https://cdn.openbsd.org/pub/OpenBSD/7.5/amd64/install75.iso"
>>> -    csum = 
>>> "034435c6e27405d5a7fafb058162943c194eb793dafdc412c08d49bb56b3892a"
>>> +    link = "https://cdn.openbsd.org/pub/OpenBSD/7.6/amd64/install76.iso"
>>> +    csum = 
>>> "60cba8cb391b50bba8fa10fc768bd0529636f5345d82133c93e22c798d8e5269"
>>>       size = "20G"
>>>       pkgs = [
>>>           # tools
>>> @@ -32,7 +32,6 @@ class OpenBSDVM(basevm.BaseVM):
>>>           "pkgconf",
>>>           "bzip2", "xz",
>>>           "ninja",
>>> -        "py3-tomli",
>>>           # gnu tools
>>>           "bash",
>>> @@ -160,6 +159,7 @@ class OpenBSDVM(basevm.BaseVM):
>>>           self.print_step("Installation started now, this will take a 
>>> while")
>>>           self.console_wait_send("Location of sets",        "done\n")
>>> +        self.console_wait_send("Time appears wrong.  Set to", "\n")
>> Have you any idea why this line has suddenly become neccessary ?
> Thomas provided that piece.
>> Without your patch, I'm seeing OpenBSD VM installs fail with the existing
>> 'install75.iso' image, with the error matching this line
>>
>>    con recv: Time appears wrong.  Set to 'Mon Oct 21 04:07:03 UTC 2024'? 
>> [yes]
>>
>> The OpenBSD installer can't have changed behind our back, because we've
>> recorded the original ISO image checksum.
>>
>> So I'm wondering what other thing has changed to suddenly make this
>> "Time appears wrong" message appear ?  Have we accidentally broken
>> something in QEMU ?
>>
>> With regards,
>> Daniel
> 
> 
> This is not new in the installer as far as I can see. But I have never seen 
> this until now.
> 
> https://github.com/openbsd/src/blob/ 
> ad7ea506c1758b3b614d7becde019d9bf8d29459/distrib/miniroot/install.sub#L3315
> 
>      # If we got a timestamp from the cgi server, and that time diffs by more
>      # than 120 seconds, ask if the user wants to adjust the time.
>      if _time=$(http_time) && _now=$(date +%s) &&
>          (( _now - _time > 120 || _time - _now > 120 )); then
>          ln -sf /mnt/usr/share/zoneinfo/$TZ /etc/localtime
>          if ask_yn "Time appears wrong.  Set to '$(date -r 
> "$(http_time)")'?" yes; then
>              date $(date -r "$(http_time)" "+%Y%m%d%H%M.%S") >/dev/null
>              # N.B. This will screw up SECONDS.
>          fi
>          rm -f /etc/localtime
>      fi

I just tried some older versions of QEMU (where it used to work fine), but 
the error is still there. Is maybe the time of the server wrong?

  Thomas


