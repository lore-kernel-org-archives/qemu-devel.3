Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F17AD59F61
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Dec 2025 07:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUJbv-0004BQ-Cd; Sat, 13 Dec 2025 02:00:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vUJbt-0004AY-Ai
 for qemu-devel@nongnu.org; Sat, 13 Dec 2025 02:00:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vUJbq-0008Rx-Kc
 for qemu-devel@nongnu.org; Sat, 13 Dec 2025 02:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765609204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hxQHF0v3ylXdJHyuoDl+gSSdAqHy4ABvXAyU5ZIOnL8=;
 b=iFNQSSwJYivsUqSUbNYwf3YkfcMImh0681PU1A605zr+4k7DROkmqjb+KUo5OywN4AMfoz
 BpCR4yN9VZYnIVztusjGwZND/AnTzevtO+kRC0bJe2Eyys7QxmROtF3t4561VZBWuwWg6K
 C/VuyhInk2kgJIsNb33ovetOOUQBrSI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-8vGx4moaM7KUoN9A-KAD2A-1; Sat, 13 Dec 2025 02:00:02 -0500
X-MC-Unique: 8vGx4moaM7KUoN9A-KAD2A-1
X-Mimecast-MFC-AGG-ID: 8vGx4moaM7KUoN9A-KAD2A_1765609201
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b56125e77so954811f8f.3
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 23:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765609201; x=1766214001; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hxQHF0v3ylXdJHyuoDl+gSSdAqHy4ABvXAyU5ZIOnL8=;
 b=JWRHG8YoA6MKQO7y5NEnAE5K5Gfm3JNm35LC2Dbo5gdSSJlR83LyXOC/+ozTAMCmp7
 1BFnFOnkPiZN2I4tphlt1KNUmyCmikuarecXJW0fxjNsID4kFTNzZs+ZbLVuAovQPqH2
 bXaOq4o3vSxgBhXlJVfftZ7SYVqMLFRASNP0iothHAB6FEaf1+3+luhzmC9IjWPkqGUn
 ap0bjFlvfE6Xi1U8ZVrdZvBGhDj2EaLkJWYNKzplgXidFFbZu/3fPxC1KcVH1PhVprU0
 Gf+5zXKNdqc/tjgAsZq67IaDiC5NJY+hnfVpdyvU6zG73C1vnB3g3AkhAtWw0To4cEfb
 keHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765609201; x=1766214001;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxQHF0v3ylXdJHyuoDl+gSSdAqHy4ABvXAyU5ZIOnL8=;
 b=TJXjM/3tm8JNUWM6nht2vEVHAENULcycZ0HpRWaCMJL0ki1h0RMfjnRxE7eR0JKKVX
 LEZszmE9b2DY9FKruQAMdSBeZPycdfTZYq42c4WjclnGG+HWgD5UKAITWRl1DRishOIO
 qMlAZR64AbVE+jTvSh8V9EI1OPUXKIcAIzDhsOv6jIGVeYmKqYWdLg1mahG/uEiSWPFh
 SJ6eg0ZRODIqW77nVqy5J9sghQZfHkiYI27VFm5+S4mrJxu/n9p/sY4UIX4khnlieGBi
 BJUUsQtZEgSqpIAYZ4FEbiXRnzrElpPzNpcBkW6dk2QEI2btgTDnsrWLVYjy4GPNL/ZN
 +vsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeCSfGHN2mV1CcF61pmv8QK/fDSjN8ynPSskys9nwIJNXdTMjmrbozSKsn4yjKW91TYZgMn8VjEKgb@nongnu.org
X-Gm-Message-State: AOJu0YzWbwxtzynAjp7cLfKbqr7rZGlGxHgbHHUga4o8Nc575ey/LBQb
 xIM04sEsM44iULBe+uq1vqqFXjitTiIJcKZCZvG3kIrS7w47XNTGr36GJhDQ4AWgU6AUw6OhMdc
 iR9I3iZNkcbTXMsQd0MwXhAtm+biQgOOjbmS4CrPU1QVb3gcSM2N7P/Jb
X-Gm-Gg: AY/fxX78wKeuDHDfBD7x7iGAwYwj4DQWhbUBWOmJ4FhJZjhux4EiTZjgPkU57+NiPvq
 RltZt8zZYqeXVU0reqr/PIEdzIVlW1pECZWOj2Z6U8f5tLD0BxJwJupGxzmJpgDbhUPrHa/9FZs
 fl0WX62SvZF3A05slTky7oQ0j1AOhtVx2FVlqGbWAwFpbgXlaUC/A8drlwuFj5R0Ki5MLGOb4xa
 Kli5Bl1XggxdMCmZ4s3mk+nqFaYTo6dcsDGiM0iizGU0+eoC+lKciOL4ZNojDGs34kRaFNPgY7v
 IvUqSTLddeSj65+MYltXYo0W6qwCKUEWza1FWI7RrKzMf5k5mPrdrQF+2vpFKyLMkMbsHawGiaz
 DWDB6PE3R0SKcZ+s+0jgBeHoyv47hVmoabaEQprrHc7DOnQNM
X-Received: by 2002:a05:6000:40c7:b0:42b:40b5:e64c with SMTP id
 ffacd0b85a97d-42fb46e39f8mr4494237f8f.30.1765609200612; 
 Fri, 12 Dec 2025 23:00:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF85dh9k3rZDgcNiuaoF1oithXvXaA1jKJgBYnHJG0iRlfypxWgbTyMCry1SOKwRCz7dvIfOA==
X-Received: by 2002:a05:6000:40c7:b0:42b:40b5:e64c with SMTP id
 ffacd0b85a97d-42fb46e39f8mr4494217f8f.30.1765609200098; 
 Fri, 12 Dec 2025 23:00:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fbbeb5298sm4554997f8f.20.2025.12.12.22.59.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 22:59:59 -0800 (PST)
Message-ID: <b0a2d9da-1a8d-4352-b761-9b1f604c6894@redhat.com>
Date: Sat, 13 Dec 2025 07:59:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/vhost-user-bridge.c: Fix const qualifier build
 errors with recent glibc
To: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20251210181306.926334-1-clg@redhat.com>
 <20251210181306.926334-3-clg@redhat.com>
 <bc52f621-493d-4df6-8403-1e4c7e2be424@yodel.dev>
 <2a9859fa-1617-4d26-a618-acb63fbe0bb6@yodel.dev>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <2a9859fa-1617-4d26-a618-acb63fbe0bb6@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 12/13/25 01:17, Yodel Eldar wrote:
> 
> On 12/12/2025 17:33, Yodel Eldar wrote:
>> Hi, Cédric!
>>
>> On 10/12/2025 12:13, Cédric Le Goater wrote:
>>> A recent change in glibc 2.42.9000 [1] changes the return type of
>>> strstr() and other string functions to be 'const char *' when the
>>> input is a 'const char *'. This breaks the build in :
>>>
>>> ../tests/vhost-user-bridge.c: In function ‘vubr_parse_host_port’:
>>> ../tests/vhost-user-bridge.c:749:15: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>>>    749 |     char *p = strchr(buf, ':');
>>>        |               ^~~~~~
>>>
>>> Fix this by using the glib g_strsplit() routine instead of strdup().
>>>
>>> [1] https://sourceware.org/git/? p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690
>>>
>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   tests/vhost-user-bridge.c | 10 ++++------
>>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
>>> index a5c711b1de8e9c164dd1614f4329b8e3c05d0402..ce4c3426d3938a0b54195f3e95bb1f1c3c4ae823 100644
>>> --- a/tests/vhost-user-bridge.c
>>> +++ b/tests/vhost-user-bridge.c
>>> @@ -746,14 +746,12 @@ vubr_run(VubrDev *dev)
>>>   static int
>>>   vubr_parse_host_port(const char **host, const char **port, const char *buf)
>>>   {
>>> -    char *p = strchr(buf, ':');
>>> -
>>> -    if (!p) {
>>> +    g_auto(GStrv) tokens = g_strsplit(buf, ":", 2);
>>> +    if (!tokens[0] || !tokens[1]) {
>>>           return -1;
>>>       }
>>> -    *p = '\0';
>>> -    *host = strdup(buf);
>>> -    *port = strdup(p + 1);
>>> +    *host = g_steal_pointer(&tokens[0]);
>>> +    *port = g_steal_pointer(&tokens[1]);
>>>       return 0;
>>>   }
>>
>> Thanks for addressing this before the glibc change is widely propagated
>> among distros.
>>
>> Acked-by: Yodel Eldar <yodel.eldar@yodel.dev>
>> Tested-by: Yodel Eldar <yodel.eldar@yodel.dev>
>>
>> For testing, I built and installed glibc (76 commits ahead of cd748a63a)
>> in an x86_64 Linux container and built vhost-user-bridge on top of that.
>> Ran it with:
>>
>> ./build/tests/vhost-user-bridge -H
>>
>> qemu-system-x86_64 \
>>      -enable-kvm -m 4G \
>>      -object memory-backend-ram,id=mem0,size=4G,share=on \
>>      -numa node,memdev=mem0 -mem-prealloc \
>>      -chardev socket,id=char0,path=/tmp/vubr.sock \
>>      -netdev type=vhost-user,id=net0,chardev=char0,vhostforce=on \
>>      -device virtio-net-pci,netdev=net0 \
>>      -drive file=linux.qcow2
>>
>> and visually inspected the logged traffic.
>>
>> Thanks,
>> Yodel
>>
> 
> P.S. To build vhost-user-bridge, I had to modify util/log.c as in
> the PULL submission "<20251209200537.84097-9-philmd@linaro.org>".
> 
> For completion, the commands used:
> 
> ../configure --enable-tools --enable-vhost-user --disable-system \
>    --disable-user
> 
> ninja tests/vhost-user-bridge
> 
> Yodel
> 


Thanks Yodel,

My plan is to send a small PR as soon as QEMU 10.2 is out and ask
Michael T. to include the changes in the stable branches.

C.


