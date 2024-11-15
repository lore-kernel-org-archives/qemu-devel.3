Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B363ED68BC8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBy6I-0000Di-GJ; Fri, 15 Nov 2024 10:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBy6G-0000Au-1k
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:19:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBy6D-0003Y9-J3
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731683943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7u4b808Y+q2C3vbV9o9jWUtktAaTT4hUHtVeMg0WlMk=;
 b=fFJ3L622qmjqt3uUC4ffg736lm1xkYbBcY+FP0wcfrL9rijU3V8SsUlsORUcNtM8sO9GP1
 pu6cPD41Vek4jK71KThGYQ7O6pT/mHGKJiBbIpGIbipnfweqwkOD073ayM3AAb7nDnUab8
 Ey1wMphM6ZIsqYM7lD/z1U9/Pf2cy70=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-5U_ACZsmMqufJ_3eC4LxgQ-1; Fri, 15 Nov 2024 10:17:49 -0500
X-MC-Unique: 5U_ACZsmMqufJ_3eC4LxgQ-1
X-Mimecast-MFC-AGG-ID: 5U_ACZsmMqufJ_3eC4LxgQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4314f1e0f2bso13097765e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:17:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731683868; x=1732288668;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7u4b808Y+q2C3vbV9o9jWUtktAaTT4hUHtVeMg0WlMk=;
 b=RNT3qu+Tg1oz7KEGJr9Apuw9xB2dOTF3soTKGATgeaMp2cGR5x6tPEuU0pRj38gJgT
 VGpQeQmnIwnLjysVd0bPSTpqmOOCGLI7JN+pjFpRSJIQOlWPae9jLy74iLy1WC1Z7RX4
 LHllI4OKpIc2m812YjnfVymrwabGVYJkNJIZJ2l/UoJJYRaBIBeJje0if/6GqCei7GTR
 Ayn49NcwPgHag16dPZoO7z60Pliai9Rs/LQ9HzyCuNybFehv2bEJWjm6ybD8QyKT6X/3
 70d/yEw7RqM4AGddx6yCROcMiC6gQiF4NeQz5nw9XpM/VFPxW9y9aP6NJs54rubJB5/3
 IBMw==
X-Gm-Message-State: AOJu0YwhH5h/Lul+1gMEb6Eci/mJb5mZoVU1Y+T62RUa2zDy3RYdp0xe
 zbMBQZHprttQexGeaMGVKdXkGhukgPmvhAalABnra55LHM9uvwxGVTaeML0A7od9MiT4xESF0Sx
 Fos0uc878WoeXVTkrgvUluRnt+pNTm0FEDkcEf41D72DG3E8OYBhZ
X-Received: by 2002:a05:600c:510b:b0:430:563a:b20a with SMTP id
 5b1f17b1804b1-432df72a7c3mr24953355e9.11.1731683868278; 
 Fri, 15 Nov 2024 07:17:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJyW/wRgcoD+m/LxSBpIb7QClcDaRYX3AOUXRqPkkGzdAxqND/D2YNIzacylIHi8Pqk3ImMw==
X-Received: by 2002:a05:600c:510b:b0:430:563a:b20a with SMTP id
 5b1f17b1804b1-432df72a7c3mr24953145e9.11.1731683867851; 
 Fri, 15 Nov 2024 07:17:47 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432dac1d85fsm56179425e9.36.2024.11.15.07.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 07:17:47 -0800 (PST)
Message-ID: <8c43d658-5099-4a56-a095-fdd839de3c7d@redhat.com>
Date: Fri, 15 Nov 2024 16:17:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure: Use -ef to compare paths
To: Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, devel@daynix.com, Eric Blake <eblake@redhat.com>
References: <20241111-p-v1-1-001006c68b7e@daynix.com>
 <1bbab4b1-ab02-4544-b9e0-814947b2b888@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <1bbab4b1-ab02-4544-b9e0-814947b2b888@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
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

On 11/11/24 08:50, Thomas Huth wrote:
> On 11/11/2024 08.19, Akihiko Odaki wrote:
>> configure checks if it is executed in the source directory by comparing
>> the literal paths, but there may be multiple representations of a
>> directory due to symbolic links. Use the -ef operator to tell if they
>> point to the same directory.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   configure | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index aa7aae70fa1b..853fa0b81f70 100755
>> --- a/configure
>> +++ b/configure
>> @@ -13,7 +13,7 @@ export CCACHE_RECACHE=yes
>>   # make source path absolute
>>   source_path=$(cd "$(dirname -- "$0")"; pwd)
>> -if test "$PWD" = "$source_path"
>> +if test "$PWD" -ef "$source_path"
>>   then
>>       echo "Using './build' as the directory for build output"
> 
> Looking at https://pubs.opengroup.org/onlinepubs/9699919799/utilities/ 
> test.html it sounds like "-ef" is not part of all posix compliant 
> shells? Did you check whether it is working with all of our destination 
> host types?

dash has it (https://www.man7.org/linux/man-pages/man1/dash.1.html), and 
it looks like it's only really ancient Solaris shells that do not.

OpenBSD has it in ksh 
(https://cvsweb.openbsd.org/src/bin/ksh/c_test.c?rev=1.28).

NetBSD has it in test(1) and seems to use the same sources for the shell 
(https://github.com/NetBSD/src/blob/trunk/bin/sh/Makefile#L53).

So I'm queuing the patch.

Paolo


