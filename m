Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F671C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 17:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmz74-0002MN-Vf; Tue, 25 Feb 2025 12:52:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tmz6y-0002LV-QD
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 12:52:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tmz6w-0000Os-NC
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 12:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740505969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xH90nkLnxB/u8D/vSUp68h1vMT3kvhGLhe+hpCjLgY4=;
 b=iMA3BdPC0RAB1+PKu2evHfnQrgC60yuq7cpLOcEVaVa9GoiFbTGx4V3tL40ErH1+/BX3Ll
 cC0fUSpHRlozeIne7TExV+jzi3Gbiw8UZqEOu26GyfeLXJ4X/bXSiF8jjnMnmThfNqySX6
 IkX4Om7lnycvxPxxeLduAfVE/fy5s6k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-X2QqQYjzPYWu4wAgky0EbQ-1; Tue, 25 Feb 2025 12:52:46 -0500
X-MC-Unique: X2QqQYjzPYWu4wAgky0EbQ-1
X-Mimecast-MFC-AGG-ID: X2QqQYjzPYWu4wAgky0EbQ_1740505966
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4399c5ba9e4so32606155e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 09:52:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740505965; x=1741110765;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xH90nkLnxB/u8D/vSUp68h1vMT3kvhGLhe+hpCjLgY4=;
 b=VRzdQVo9SgFslTKhpzFOSY/41c2RMV7H333ftbRr5jwDROiO8RyeqUMILnJEPT9QyB
 8OokWNhyHUdax30cESuqYqkuCxECFfiMhjJWI1rF1JI8TArItR39X0rnIsjjJ02Sw8YA
 GyPNdWl+7ql/3SKvWeQFYMHkVuUTvDA+txE0ssh0ndy/rI5Fo6Nh+aiJg3o0NHps/9Hx
 DeXGoTFtbr1W6vEC2uJlCZTVCqvZCWKVFrzUqr4uOkCt9wGqtxTrySSudM3RAj6E4RAo
 vC1mM7KJM4x2iiAlq+w89JUH2SnSuhFbpcZBHTq96oEnFO3Ucz2FuqvEJQFr4eZzPQ1z
 j9XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3NwQpYbSmkTXSFKhZQaSRr0dmxsKGJmuUzgHq7R4oUi7zB7SUjHZvW6nAO6Gg2yJ9ezbVQ5LZDW9j@nongnu.org
X-Gm-Message-State: AOJu0Yw3d77ZxCATLb4xz71fqP2pjiSPUlJj32CubN9uczPKwSoFPtHu
 4s+SYxYCAk1jWw9Ohh6/8hpa89A+OWg/aSaml5t+0UvvCVqdCDqPyEwnrsHaOS2zEBcV1XJxUN5
 /GJaZb+4kXCdZDdDNYNgcJ7aG7aNnQLhhONM2ZL2gcdnD33lqnD6c
X-Gm-Gg: ASbGncs7CqjkTN9TJVDR6bb5RSctiIdwTTDn2oYCbznVVzUuDqrc6G1G8VLVt2A32fl
 jul+6Ury3eldvORD7umJWUh2uw1ane2mli3OTqYGHH2Zwnj50WM8zHOkplIWrLpr3Rb19Xhi3yU
 tGm+PfdBoneMXysFMsFMWWCjvZjJshi2R34KV0xdR74qialW5jTyO7RwzBwPjRnWbAe3RGR0yBw
 dFix3wxEVw3SCsi/DZ0hKiPVxTZTLZqq9ckIaAXre776UWRLk9/z2k47Po9px+yktN0pyhGvfmc
 fivjV238aSXLxijnpqiE96zk+9N74UxlxrbtxDp1Oefbl+0=
X-Received: by 2002:a05:6000:1aca:b0:38f:229a:b48 with SMTP id
 ffacd0b85a97d-390cc60ab90mr3289381f8f.32.1740505965607; 
 Tue, 25 Feb 2025 09:52:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuU5Xaw01q1aWStkzkBxEIW3sFK9ji3qDaivW5n/x8SWA/rjxaFmBN4bAl0Gz64lSmP/0mWQ==
X-Received: by 2002:a05:6000:1aca:b0:38f:229a:b48 with SMTP id
 ffacd0b85a97d-390cc60ab90mr3289355f8f.32.1740505965107; 
 Tue, 25 Feb 2025 09:52:45 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-245.web.vodafone.de.
 [109.42.49.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8fbb5dsm3000065f8f.84.2025.02.25.09.52.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 09:52:44 -0800 (PST)
Message-ID: <574cdf2e-6b8c-4ff3-9a2b-a7d00c92a788@redhat.com>
Date: Tue, 25 Feb 2025 18:52:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with iotest 233
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <5a31e4fb-3e0f-4455-9941-18b00287b276@redhat.com>
 <Z72XfP8gI9-SB4B9@redhat.com>
 <f500b606-b999-426c-8d72-50a9ba9e84ac@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <f500b606-b999-426c-8d72-50a9ba9e84ac@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 25/02/2025 18.44, Thomas Huth wrote:
> On 25/02/2025 11.12, Kevin Wolf wrote:
>> Am 25.02.2025 um 08:20 hat Thomas Huth geschrieben:
>>>
>>>   Hi!
>>>
>>> I'm facing a weird hang in iotest 233 on my Fedora 41 laptop. When running
>>>
>>>   ./check -raw 233
>>>
>>> the test simply hangs. Looking at the log, the last message is "== check
>>> plain client to TLS server fails ==". I added some debug messages, and it
>>> seems like the previous NBD server is not correctly terminated here.
>>> The test works fine again if I apply this patch:
>>>
>>> diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/common.nbd
>>> --- a/tests/qemu-iotests/common.nbd
>>> +++ b/tests/qemu-iotests/common.nbd
>>> @@ -35,7 +35,7 @@ nbd_server_stop()
>>>           read NBD_PID < "$nbd_pid_file"
>>>           rm -f "$nbd_pid_file"
>>>           if [ -n "$NBD_PID" ]; then
>>> -            kill "$NBD_PID"
>>> +            kill -9 "$NBD_PID"
>>>           fi
>>>       fi
>>>       rm -f "$nbd_unix_socket" "$nbd_stderr_fifo"
>>>
>>> ... but that does not look like the right solution to me. What could prevent
>>> the qemu-nbd from correctly shutting down when it receives a normal SIGTERM
>>> signal?
>>
>> Not sure. In theory, qemu_system_killed() should set state = TERMINATE
>> and make main_loop_wait() return through the notification, which should
>> then make it shut down. Maybe you can attach gdb and check what 'state'
>> is when it hangs and if it's still in the main loop?
> 
> I attached a gdb and ran "bt", and it looks like it is hanging in an exit() 
> handler:
> 
> (gdb) bt
> #0  0x00007f127f8fff1d in syscall () from /lib64/libc.so.6
> #1  0x00007f127fd32e1d in g_cond_wait () from /lib64/libglib-2.0.so.0
> #2  0x00005583df3048b2 in flush_trace_file (wait=true) at ../../devel/qemu/ 
> trace/simple.c:140
> #3  st_flush_trace_buffer () at ../../devel/qemu/trace/simple.c:383
> #4  0x00007f127f8296c1 in __run_exit_handlers () from /lib64/libc.so.6
> #5  0x00007f127f82978e in exit () from /lib64/libc.so.6
> #6  0x00005583df1ae9e1 in main (argc=<optimized out>, argv=<optimized out>) 
> at ../../devel/qemu/qemu-nbd.c:1242

Ah, now that I wrote that: I recently ran "configure" with 
--enable-trace-backends=simple ... when I remove that from "config.status" 
again, then the test works fine again 8-)

Still, I think it should not hang with the simple trace backend here, should it?

  Thomas


