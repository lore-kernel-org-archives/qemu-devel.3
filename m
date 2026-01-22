Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21300C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 11:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1visVG-0002n0-8M; Thu, 22 Jan 2026 06:05:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1visVA-0002iy-NN
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:05:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1visV8-0006T8-2A
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769079920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=30noYZHuWAssSIqIEcBn/MiCq2hJ2f1fdsIQNRSpmKc=;
 b=ZbuhQ+SiMPg7CjIa7UimOd3o7wOF4Z+50ArYHGzDD/ocIW4P4kpYc0XNdktdT422/sADjs
 CfCEQI0aVWv8cNI3UR7AyX66Xfo2MQL7WI25qa9uYMwIwLALe4i+C1+AD/zLJCjFY699Dx
 RlpeEywyrB6zQVv+6M8MuOq8pJ/axqI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-g5L4xWT9OJKAaQ-lkDwKhw-1; Thu, 22 Jan 2026 06:05:19 -0500
X-MC-Unique: g5L4xWT9OJKAaQ-lkDwKhw-1
X-Mimecast-MFC-AGG-ID: g5L4xWT9OJKAaQ-lkDwKhw_1769079918
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477c49f273fso7797155e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 03:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769079918; x=1769684718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=30noYZHuWAssSIqIEcBn/MiCq2hJ2f1fdsIQNRSpmKc=;
 b=iHZjsoD3hXalRAL01ihYu3GnG0RsgPcmjK8LLx28WiFsigDVES4CakhmftZFQYTVPB
 p4i8v6WMWL8Vx4YHLsC7/n2+8d2K7Z4pz0NzySXITCmzSUlBLNquwH07Sskv18kse0P4
 eGggCm0NzGzooiEKMtpe8L0+a1RyLs7mPHlA0Plzxnki/wAEM252qA10GVfxoFMZt03B
 HFL+qrphwjsL7b9VzUR0ZfZ42wqamAoY3oH5TRRsrFKxYOA/5MRBlBaKatz+aeufEOE0
 tR3uUdNC4n03llHVWqbOlsY+nYoUCfDCW/xweZ1NVkAA/LqgDialInPfZDseoc9QGMbv
 lsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769079918; x=1769684718;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=30noYZHuWAssSIqIEcBn/MiCq2hJ2f1fdsIQNRSpmKc=;
 b=sqBUFn33xSewcrQZydXj2pMYm+pYhslc5BvTat+3ihhWJLV7UFDy6MdWOJqfAw/50I
 S+q0oUSLsm2qykMxnFUPEgDWiPdTjDGs3r2Rr9bRUgLfhqgo8f2gtU1XtllUvxafV5M4
 s9aQtbhCAAVDdNLh2/QHdZnpB7S/Es4eIWWmKRMB6tCjArTZqN7cWUY01Bb1hROtDQAA
 k2zrGDu/HR7Jo+M1vWr4Ia9sGwBP/YRKeutCrxir+dwZYyVpKvZ2laKaTxMK4s2xcx5K
 G5eXspq3ANs3gAAfy3d//4GkxWh/S4ld62QsTBf9Ej4ysLIlYADd595U1c5n73hbXhHv
 kmPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlJT3SG76X1RTLPIWDLNhnvmxfquKJE8bV1V/OCiM8tRjpKSae2eLuu9AECnE4CZenOjBodjHA6gXg@nongnu.org
X-Gm-Message-State: AOJu0Yz/QqUXvPYW+7MOvab6K48jNnVgVK6DS/zMINIZEiGlmzAFJwRO
 qyFETiIByofXgxdC8FzVcInKPlpuuuTKitw4n7tAtcIosGwQwGNe+sMCZt3GAne2U8jMaYBMrxy
 eFhf4H32g5Q0vTQFe21g+lhNEb3hhXOnIxHlOGF073bBwhyPDwBV22yF3
X-Gm-Gg: AZuq6aIUwjxn+sW3znf5Ki7NanLhwblvbH9h9rF00fiIYdvG1iRWj8ZSXYH6bYk3fy3
 Ld7P4Rh4DXLEq/MIZGH/qzyctqRkXNRoHLdqIqD7jkOOYiJBVEHXG2P4Xjc6gFlUhWz4e2GYFSx
 Dby8m3f1DxquMEHqJ5CHR6kHvOjjO2+Dsz9cdrkYkYGTjLhYrG5lt296QG15KYB9ILDlo+oUGBU
 wjd4+zqGwTrHIElV4atN0G8D1iKCRvNKojrbDaQyHdHpG6njc5chKMG6eZBoF2nt2CY11416zCf
 ruTQYsoWXCpwqT9o9FJ5omCSb3VKcNMBhDNal4+Xi63h9TCJxo0VFk9nznLiB8tghTAbLxz5zMr
 e8jbmKks=
X-Received: by 2002:a05:600c:1549:b0:46e:35a0:3587 with SMTP id
 5b1f17b1804b1-48038b7872amr181948985e9.27.1769079917848; 
 Thu, 22 Jan 2026 03:05:17 -0800 (PST)
X-Received: by 2002:a05:600c:1549:b0:46e:35a0:3587 with SMTP id
 5b1f17b1804b1-48038b7872amr181948165e9.27.1769079917265; 
 Thu, 22 Jan 2026 03:05:17 -0800 (PST)
Received: from [192.168.0.9] ([47.64.112.255])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48042c773e3sm48917535e9.20.2026.01.22.03.05.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 03:05:16 -0800 (PST)
Message-ID: <995d4aaf-bbff-42be-9114-1f04bb51e37c@redhat.com>
Date: Thu, 22 Jan 2026 12:05:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Call for GSoC internship project ideas
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, German Maglione <gmaglione@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aXH4PpkC4AtccsOE@redhat.com>
 <130b8f26-2369-48f5-bbd6-e27210707b9f@redhat.com>
 <aXIAmeEWMFjQM84o@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aXIAmeEWMFjQM84o@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/01/2026 11.48, Daniel P. Berrangé wrote:
> On Thu, Jan 22, 2026 at 11:43:35AM +0100, Thomas Huth wrote:
>> On 22/01/2026 11.14, Daniel P. Berrangé wrote:
>>> On Tue, Jan 20, 2026 at 04:42:38PM -0500, Stefan Hajnoczi wrote:
>>>> Hi Marc-André,
>>>> I haven't seen discussion about the project ideas you posted, so I'll
>>>> try to kick it off here for the mkosi idea here.
>>>>
>>>> Thomas: Would you like to co-mentor the following project with
>>>> Marc-André? Also, do you have any concerns about the project idea from
>>>> the maintainer perspective?
>>
>> I'm fine with co-mentoring the project, but could you do me a favour and add
>> some wording about AI tools to
>> https://wiki.qemu.org/Google_Summer_of_Code_2026 to set the expectations
>> right? Since we don't allow AI generated code in QEMU, I'd appreciate if we
>> could state this in a prominent place here to avoid that some people think
>> they could get some quick money here by using AI tools, just to finally
>> discover that AI generated code is not allowed in the QEMU project. Thanks!
>>
>>> IMHO, our baseline for functional testing images ought to be
>>> a Linux Kconfig recipe used to build a dedicate kernel, plus
>>> a busybox build for the target.
>>
>> Not sure if we want to add kernel compilation time to the functional tests
>> (even if it's only done once during the initial build)...? That could easily
>> sum up to a couple of hours for a fresh checkout of QEMU...
> 
> That's absolutely *NOT* what I was suggesting.
> 
> We should have a 'qemu-test-images.git' repository that maintains all
> the recipes, with CI jobs to build and publish them (along with corresponding
> source). Those prebuilt images would be consumed by QEMU functional tests.
> This would be quicker than what we have today, as the images downloaded by
> functional tests could be an order of magnitude smaller, and boot more
> quickly too.

Ah, sorry for getting that wrong!

Ok, so this sounds basically just like a gitlab-CI wrapper around what 
buildroot.org already provides. ... not sure whether that's challenging 
enough for a GSoC project?

Also, adding this as a separate repository will easily burn your gitlab-CI 
minutes if you don't have a dedicated runner for this, so developing this 
feature might be no fun at all...

  Thomas


  Thomas


