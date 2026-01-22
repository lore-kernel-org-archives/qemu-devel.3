Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80E8C44536
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 10:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1virz8-0007At-Me; Thu, 22 Jan 2026 05:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1viryn-0006jy-Ui
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:32:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1virym-0002xL-5N
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769077914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Dh0VoldX6HwIsXJwMSBRVlwRUz6xTZdsuY3zdjlex5o=;
 b=SV05yj/y+ZfBPI/uR0+OLtZNfxIaW4AUg4mt+bF09qiklCdFZeHQj5I6teQjOqiZTbGSMM
 2c0J/NVLTSt622oeZunJO7tgzlHjCh8TUX9WmMrG4P292WvvLyZzpM/sOi/lbUOWYivsZU
 vxpFDR2wEnZr1WM1oYf2+u8z+XiIgkA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-7Po9usWSPhGSzBrH8-XERw-1; Thu, 22 Jan 2026 05:31:52 -0500
X-MC-Unique: 7Po9usWSPhGSzBrH8-XERw-1
X-Mimecast-MFC-AGG-ID: 7Po9usWSPhGSzBrH8-XERw_1769077911
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47ed980309aso14291515e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 02:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769077911; x=1769682711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Dh0VoldX6HwIsXJwMSBRVlwRUz6xTZdsuY3zdjlex5o=;
 b=K9N+hh5Qinrljxljtz65Cmra3uh2hb8zyYbAI756+CEN7cix6i1lhv0nMXTm9C4s46
 nzOVUVdpsPe46T/LwMRJ6pUIP4FbhEzk0mFZubUVemy3V4YcEo+2Z000RUrfGXl4dryp
 w+16v4mq2A37l4EYZbcoDhccNlS9PCGt9eh6pLAayzDOJZWXVSwf2bgDASWbUafFIcKM
 RRIs8+RBXJbM0Fto1YZOzPDKKCtkEK58ly731QVfKVYm3zC4Xo9xzv4rjq2NBzCwh2Tw
 o95bJbDTC4iJ55TnuROT/YlqHIqQUWAXOW+vB3VJnk3KRj0ebDEi1ryB2U5GwiCFHz4Y
 p01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769077911; x=1769682711;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dh0VoldX6HwIsXJwMSBRVlwRUz6xTZdsuY3zdjlex5o=;
 b=DOGkTnTRVr/eFkO/f9znjCfOiJmMuapSqH57qeV4XLTXNyVmlWAir/Wn4M3W7fo+Sn
 QcOgXgZC5mtdu5BLlXRI+8vg4H0ghRco6yCoBZESxUwNmPiGZSyxeUGM92uXgFTMEUBG
 ChYK9PzHyccb0pPC7X5muw2fF9XsJ2/XEb5vZpwBilLKcW7oGYzpXy4l13o/eB7WoFRK
 FQxUXqREwJnW7YCXEPa5qUVC9aghu8y4uzddX2lDYTcDAH6m1dFPrvXSNd+dFO+JTRCE
 UjFADRn1OOgABP5PUVu9YZQLBF1QUbqtrTVti6Jp45n19wdKmIEmNBhdWxgQzULLQZUN
 OIsg==
X-Gm-Message-State: AOJu0Yw1/gr0ViXgNJ4b2P7lJGxrQFDN857PhiI9GyT9GfyZkJ1l8UH0
 MwcPrwleObB+DCmklMpAnncGLH9QJa/afkDBzhePLSQwx6Ii4mzj3Fo/JY1zCs9ZBU0tiyWGZ/Z
 eHx1EMmE88CB4gv/xffhWBOr1jMxA+aBuwpE2s9Vv9tDQg/lUh4NkS+vJ
X-Gm-Gg: AZuq6aJzxeRkyuCLEoccUulVTi/M7G5x7lfAGde3yngE0zAa4/NvPFZL3G3pRHVr8l2
 QBXgCwphjtKYsZQDjXbZmvOu4xaUeuF6GHDlA3wYn4Xl6gmW6JFjiVdsI5GZQ7a6AJLrTgQFW1u
 1Q9S5gnk/oyBeFmlVYEzAQH9ule8vmuOwAMZnqf+uwZPQKMnDigBDy7mbkAHs+kfBcl1VS07tZy
 dYonE7HmdDgIn5Bw5DAYenT/qIvFpEUFqYq/AMW8mh6mTs7QWHZPWOSWTr3TYhYE3TJqC4tfMxn
 z9Oa3zzZCUW6xi0UY+PvR0U7v+kJ3emkFlnD54lgP+Oh4bljaBQsAiyJn6vTUvkP/S3uGlZr+8r
 O9MHfCM4=
X-Received: by 2002:a05:600c:8691:b0:47d:7004:f488 with SMTP id
 5b1f17b1804b1-480470b7d42mr25018915e9.10.1769077911089; 
 Thu, 22 Jan 2026 02:31:51 -0800 (PST)
X-Received: by 2002:a05:600c:8691:b0:47d:7004:f488 with SMTP id
 5b1f17b1804b1-480470b7d42mr25018725e9.10.1769077910633; 
 Thu, 22 Jan 2026 02:31:50 -0800 (PST)
Received: from [192.168.0.9] ([47.64.112.255])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470287c3sm59544315e9.3.2026.01.22.02.31.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 02:31:50 -0800 (PST)
Message-ID: <92bcd2dc-7dca-49aa-8af3-dcd9acda5b9d@redhat.com>
Date: Thu, 22 Jan 2026 11:31:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/vm: Make the haiku VM usable again
To: Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, kallisti5@unixzen.com
References: <20260122093036.16085-1-thuth@redhat.com>
 <CAE8KmOxyA107Uc-E8rDXGJ7wXcMXwirNtdUM8dytPMw=6j+1YA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAE8KmOxyA107Uc-E8rDXGJ7wXcMXwirNtdUM8dytPMw=6j+1YA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 22/01/2026 11.15, Prasad Pandit wrote:
> On Thu, 22 Jan 2026 at 15:01, Thomas Huth <thuth@redhat.com> wrote:
>> The haiku VM bitrotted in the course of time. Make sure to use the
>> latest version of the repositories here and install missing pieces
>> like "pip" and "tomli" now.
>>
>> We also have to add a little "hack" to our configure script: For some
>> weird reasons, the meson binary shows up as pyvenv/non-packaged/bin/meson
>> here, and not in the expected location pyvenv/bin/meson. Use a symlink
>> to fix it.
> 
>     -> https://github.com/haiku/haiku/blob/master/docs/user/storage/storageintro.dox
> 
> * Packages not available in the HPKG format are installed under the
> "/non-packaged/" directory, it seems.

Ah, great, that could be the reason, indeed! Thanks for the pointer, I 
somehow did not manage to to find this though tried to search the internet 
for "non-packaged" ...

I'll add that information to v2 of the patch.

>> For this new version, we also have to compile with "-pie", otherwise
>> the linker complains about bad relocations in the object files, so
>> allow compiling with PIE in the configure script now.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   configure             | 8 +++++++-
>>   tests/vm/haiku.x86_64 | 4 ++++
>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index 9d7fd13a98b..587cd2a2fe6 100755
>> --- a/configure
>> +++ b/configure
>> @@ -967,6 +967,12 @@ mkvenv="$python ${source_path}/python/scripts/mkvenv.py"
>>   $mkvenv ensuregroup --dir "${source_path}/python/wheels" \
>>        ${source_path}/pythondeps.toml meson || exit 1
>>
>> +# For some unknown reason, the meson binary shows up in the wrong
>> +# folder on Haiku. Use a symlink to fix it.
>> +if test "$host_os" = "haiku" && test ! -e pyvenv/bin/meson ; then
>> +    ln -s "$PWD"/pyvenv/non-packaged/bin/meson pyvenv/bin/meson
>> +fi
>> +
...
> * Instead of creating a symlink for meson, could we add
> '/non-packaged/' directory to an appropriate PATH variable, so that
> all such binaries are accessible from 'non-packaged/bin/' directory?
> That way we avoid creating symlinks for many /non-packaged/ binaries.

The problem is that our "configure" script explicitly expects the meson 
binary in this location and does *not* use the meson from $PATH. We also 
have hard-coded this in a couple of other spots (see "grep -r bin/meson *") 
... so I think using a symlink is still the easiest solution?

> * Otherwise change looks okay.
> Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thanks!

   Thomas


