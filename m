Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B142D3940B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8F1f-0001nW-8h; Thu, 02 Apr 2026 06:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8F1d-0001mJ-QN
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:11:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8F1b-0006ou-U1
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775124702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wrBVZM3AMbMOspKC+++3FN6lbOjBu+2fg0w1RRpekFQ=;
 b=YWow3USDu3dLZJ4RK1FSBvtFYa9MFjeS/qzGNYOVQoHikabA+tt9iGM7V0LsJUbW14abyb
 OrRnHbRy7MLMIjVLpA8Vcx+1n8y1SxfdwQdvHcCZ5snVpPLwdegf9jI58vJgon0UYQ4MlB
 0dxJ/GyUzp8Aln+W347zv7esX7h7a2M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-1pqwh8XqODWtDSokV_8bXQ-1; Thu, 02 Apr 2026 06:11:41 -0400
X-MC-Unique: 1pqwh8XqODWtDSokV_8bXQ-1
X-Mimecast-MFC-AGG-ID: 1pqwh8XqODWtDSokV_8bXQ_1775124700
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4871fc50fe7so10706185e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 03:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775124700; x=1775729500; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=wrBVZM3AMbMOspKC+++3FN6lbOjBu+2fg0w1RRpekFQ=;
 b=crWvKOuxEU8IRklD7miq0IX9FUYpoHVz+FUU1lD8De4kHqVUOJIoQqFR4uWfSyJGOj
 Z2O1lTQK/YiPkzpqdpg8pGRBYFC+/kLfHZV7NbIfIZp7bDX0BGMR/7XsMnQn6G7ssM/9
 zHSb5PAFa8fiuN2IH0oVpJqHzR426kHj9gfKGflQbRY8Qf4kxqkeDN8V6XSS2qOG19RC
 iJ0aSfcmURVBdwldnRICOpelAgK6XVEcIr5bHJ9PLhxBmEzErONf3qSReRTlRB7Aum+O
 zPe6Pv3YaKwT5y15blBlctIsWnayXTC4c/oRfB2o4qqxU7z7YLtkghOFj28lU1Zw9TYE
 +quQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775124700; x=1775729500;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wrBVZM3AMbMOspKC+++3FN6lbOjBu+2fg0w1RRpekFQ=;
 b=Cq5za4ucd1+NjXkD170MJLeXUrMYeHxzvKluOfB9PshqiL1NLwJ6LsqA2EjmWgQ+5m
 eUCpawds7TrjnqjRcECzqH2B92gfHuP2lIH4e8YS5VkVXGaJrx+MtiPdAaqt/hZ9WWKI
 J4VxOZCt9BK9TptrUdwHDJhuMT85GMaQ3naH1jf2k5tdk64TjaJcxAg59w72//8zCQWY
 2gtcg3VAN1t7DK7C4PudvOyu/2zb70meNwNCQlHIU/kFHAub3pf8fQfAN4SBkeYwmWE4
 1am+64m9ky8WbOk9F25z52Len3kA86KOKtnB0TDVJtSZfoOW/nEI8f6jUAgNOp5Z0YOq
 YYGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXysiic7Fh/PobRuijOPgJZExlO0NESQjaOy1MhmYMirAWPwtSeMbdShy88QlNPmkjjDfZGA3q0Ixax@nongnu.org
X-Gm-Message-State: AOJu0YxqUVNmR9N9kV1H1I/CnOKX4E0jsSY/0Boib+LjK0IENRvz75l1
 Dk2q/H0en9r0ichOlAvxeer9yp2d7ifQIolNufDetq1zp8SCBHZMoudUzP6GeVu5cFhsPv2m/xy
 zcJB+A6FxHoYWY5v1rYYPL8dPXvv6FEC/a/9I5fF53YO19jDiP3PRmGor
X-Gm-Gg: ATEYQzySSGy9KNERNK9/GiuLzjQlrquk/Ll5sbWlIXNDZk1iwsJNayoo90ELxBtoB7V
 9TrYhAk/SOcTWAVXNbDh4ICgmNlYbbMZjbk7lE7Uq/Q8YaIlZBm6Amw+m93Tf/bKNSRMm5jIgmt
 SlftiziwShpy5jrRMREHaSIG/5o6uZ/5fr1D7kArpDKs+Oe+cysDvG0qxS8eJy8XtUesepr7oJu
 lQ94liIT10RJf6BaW6q7rLORZclRAxOtxtCSvXU9MKU7ljqqmiOxVnwkpTDqn4Ov5KJ8IXg4WGi
 2AHiwiJg8xesShWDRkVz0Bh3jmxdLwk4C66HIUD8v0RTLlNfzP7yb0XWMStKt1X1kA8metulTLX
 XMjqLtLkYdtayJ0PFHNo=
X-Received: by 2002:a05:600c:8708:b0:488:8bdd:cfb9 with SMTP id
 5b1f17b1804b1-4888bddd12fmr44192835e9.1.1775124700045; 
 Thu, 02 Apr 2026 03:11:40 -0700 (PDT)
X-Received: by 2002:a05:600c:8708:b0:488:8bdd:cfb9 with SMTP id
 5b1f17b1804b1-4888bddd12fmr44192375e9.1.1775124699587; 
 Thu, 02 Apr 2026 03:11:39 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a65635fsm59204645e9.6.2026.04.02.03.11.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2026 03:11:39 -0700 (PDT)
Message-ID: <a47f39f1-c881-4130-ba0b-18edf7816bcd@redhat.com>
Date: Thu, 2 Apr 2026 12:11:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] docs/about/deprecated: Deprecate the
 qemu-system-i386 binary
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260402095132.29245-1-thuth@redhat.com>
 <20260402095132.29245-11-thuth@redhat.com> <ac4_kKUYE00oRr9j@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ac4_kKUYE00oRr9j@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 02/04/2026 12.06, Daniel P. Berrangé wrote:
> On Thu, Apr 02, 2026 at 11:51:32AM +0200, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> Aside from not supporting KVM on 32-bit hosts, the qemu-system-x86_64
>> binary is a proper superset of the qemu-system-i386 binary. And with
>> the 32-bit x86 host support being removed now, it is possible to
>> deprecate the qemu-system-i386 binary now, too.
>>
>> With regards to 32-bit KVM support in the x86 Linux kernel,
>> the developers confirmed that they do not need a recent
>> qemu-system-i386 binary here:
>>
>>   https://lore.kernel.org/kvm/Y%2ffkTs5ajFy0hP1U@google.com/
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   docs/about/deprecated.rst | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index a6d6a713265..2de51337d75 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -301,6 +301,25 @@ machine must ensure that they're setting the ``spike`` machine in the
>>   command line (``-M spike``).
>>   
>>   
>> +System emulator binaries
>> +------------------------
>> +
>> +``qemu-system-i386`` binary (since 11.1)
>> +''''''''''''''''''''''''''''''''''''''''
>> +
>> +The ``qemu-system-i386`` binary was mainly useful for running with KVM
>> +on 32-bit x86 hosts, but most Linux distributions already removed their
>> +support for 32-bit x86 kernels, so hardly anybody still needs this. The
>> +``qemu-system-x86_64`` binary is a proper superset and can be used to
>> +run 32-bit guests by selecting a 32-bit CPU model, including KVM support
>> +on x86_64 hosts. Thus users are recommended to reconfigure their systems
>> +to use the ``qemu-system-x86_64`` binary instead. If a 32-bit CPU guest
>> +environment should be enforced, you can switch off the "long mode" CPU
>> +flag with ``-cpu max,lm=off``, or rename/symlink ``qemu-system-x86_64``
>> +to ``qemu-system-i386`` -- QEMU will then run with the 64-bit extensions
>> +disabled.
> 
> Why don't we just have our install rules create the symlink from
> qemu-system-x86_64 to qemu-system-i386. That gives us near zero
> ongoing maint cost, without need to deprecate stuff / impact users

I think we should do that once the deprecation period is over and we don't 
allow to build QEMU in this mode anymore. I would rather not jump directly 
to that state to provide people some time for experimenting whether this new 
approach works as expected in all scenarios that are in use.

  Thomas


