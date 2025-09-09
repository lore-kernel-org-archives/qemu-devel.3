Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0012ACAC587
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 09:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvuVi-0006Nb-Fi; Tue, 09 Sep 2025 05:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvuVe-0006N2-M2
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 05:19:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvuVc-0007oC-DR
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 05:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757409564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6e51UfDr+YC9BDm+tXUwtIngjqJUr+hk5YarBZY3QoQ=;
 b=dWv72+TegV84QV22N3517dOVurR4Qsh5v99Y4ZtmgBT+mRSi534p+lWIAaLm4ZSr8TEtBr
 r8HjGOs23cHHXRjp1ERzJIJ6b8RdDpk3tFg+YTQLdxwwtD1IP4rBIm7CbDUfB5rYIgd6Ni
 1oOgBtQd39cYTulZiGZTKPoEzIsReZQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-cgiW0z2_Nyq7tdP6ySxJWg-1; Tue, 09 Sep 2025 05:19:23 -0400
X-MC-Unique: cgiW0z2_Nyq7tdP6ySxJWg-1
X-Mimecast-MFC-AGG-ID: cgiW0z2_Nyq7tdP6ySxJWg_1757409562
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45de18e7eccso15748015e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 02:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757409562; x=1758014362;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6e51UfDr+YC9BDm+tXUwtIngjqJUr+hk5YarBZY3QoQ=;
 b=cabLFJsy02xdIwiF1qDWtIutoLe+uemIcnlZvdpw+8nuc0y6VsUDgyJKkIPq3DiaR+
 mjAFUKT79p9iiB+fETDFB/dpPGHJiVzDayznzbfQzE7rJLvpCoTYlDsNFqy3WzNOG/uY
 fI+cX5oaR9+jeaWJDrBh40FVsh5F/VN8v03ZP+OvpZAD0AlD/ssHF/480ifiIt4Vma3f
 ABz6lPxxcRF99cSu7prLCOYDuF99P5byrms7wKz8XCSXcgzTCFPsJIPHYGedXR/Cqi1o
 3Q54d7i5FDRPGxcstw/UvA4v2Wrrx3mETq6rBaWDyNoKhePpLjDtWQp5/EFpiETV9c/F
 hRXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKEyAr/dMcrMwPOh0cIUclLT/BLqPYby+4JoHZUWd6oYeVGT1laiFH9UEXRK+3yVbIIe80ee0JJKWL@nongnu.org
X-Gm-Message-State: AOJu0YwQu7uwcDMJDZWNjTy6nBBHzt5y/y8/zIKQmjn50v49x6bszYSd
 JJuPHK+Ryd5yAjs5GGXvX6IRJs8Qni9m2eC5dgtzUQqkuOqp7oZhkzM7EjJW2DHcZPHUlGpG/86
 ey3Qce+r1YuSQznOVkWpwqCECkwYdZxgVhsM71MfkwYRZgOkcXwTgfCTv
X-Gm-Gg: ASbGncuZxfAD+27rec1N6NzGhYZuvpaNvWPt+4j+nwiT0OJq62ORzmUrP+RSCVd1gf5
 OxwlarZ9G++ek+QGyvBQO+P81IvJouQoqzKug8a7JVnEwnmlNxw60yYexEFTJymtttUwOM57ASe
 Ya0P0Zkqrwort8ZtgksSGIig1Vq/rpdhp4E5n1y006O33j/9a0ktc6SgQVgDBQFsc/K9xS51OIo
 SQHweBG66iwbp65RdBR2aeoxFwoDpPd/44aKFVLd8wZj4r/c0XZeNAOfrAIlvEh/r5cGOLVHLKm
 hinsls7IlDxr83+g4mUdW/rPz69uhnjBLek/TldpTAd8Q+Ujyvt6DwpWNdqjhQt88kJXTYq9GMA
 lV0ebew==
X-Received: by 2002:a05:600c:548a:b0:45d:db33:fa0a with SMTP id
 5b1f17b1804b1-45dddee3772mr96514995e9.33.1757409561774; 
 Tue, 09 Sep 2025 02:19:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBR9vAp8SgOQOaw1IV8f/xgeKzhJv86ZaiyvOOhB0e4kav5ZP86zpSAVuoj+PvafLAfCFboA==
X-Received: by 2002:a05:600c:548a:b0:45d:db33:fa0a with SMTP id
 5b1f17b1804b1-45dddee3772mr96514755e9.33.1757409561353; 
 Tue, 09 Sep 2025 02:19:21 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-183.pools.arcor-ip.net.
 [47.64.113.183]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45cb61377a7sm275841295e9.13.2025.09.09.02.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 02:19:20 -0700 (PDT)
Message-ID: <fd7b3742-c445-4b26-9f3f-e277f4131545@redhat.com>
Date: Tue, 9 Sep 2025 11:19:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Failure of func-x86_64-memlock
To: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
References: <7ceb8d59-be3f-4dad-9e2b-9db62fbf92cb@linaro.org>
 <666dce10-2359-4211-b761-daf9a828523e@redhat.com>
 <4957da97-4d2e-41db-9bb1-9197a577369d@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <4957da97-4d2e-41db-9bb1-9197a577369d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 09/09/2025 09.48, Richard Henderson wrote:
> On 9/8/25 10:12, Thomas Huth wrote:
>> On 05/09/2025 12.26, Richard Henderson wrote:
>>> Hi guys,
>>>
>>> This test has been failing on my laptop for a few weeks.
>>> Any idea why?
>>
>> FWIW, the test still works for me (after enabling it with "ulimit -l 
>> 2097152").
>>
>>> There's nothing logged in tests/functional/x86_64/test_memlock*/*,
>>> which itself seems like a bug.
>>
>> Is there maybe any hint in meson-logs/testlog-thorough.txt instead?
> 
> Ah, yes, there it is:
> 
> TAP version 13
> not ok 1 test_memlock.MemlockTest.test_memlock_off
> ok 2 test_memlock.MemlockTest.test_memlock_on
> ok 3 test_memlock.MemlockTest.test_memlock_onfault
> 1..3
> ----------------------------------- stderr -----------------------------------
> /home/rth/qemu/src/python/qemu/qmp/legacy.py:89: DeprecationWarning: There 
> is no current event loop
>    self._aloop = asyncio.get_event_loop()
> Traceback (most recent call last):
>    File "/home/rth/qemu/src/tests/functional/x86_64/test_memlock.py", line 
> 40, in test_memlock_off
>      self.assertTrue(status['VmLck'] == 0)
> AssertionError: False is not true
> 
> 
> So it seems there's some non-zero amount of memory locked in the process, 
> likely nothing to do with what we're trying to test, but we're asserting 
> anyway.
> 
> Digging into /proc/pic/smaps, I have:
> 
> 79d7d3547000-79d7d354b000 rw-p 00000000 00:00 0
> Size:                 16 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:                  16 kB
> Pss:                  16 kB
> Pss_Dirty:            16 kB
> Shared_Clean:          0 kB
> Shared_Dirty:          0 kB
> Private_Clean:         0 kB
> Private_Dirty:        16 kB
> Referenced:           16 kB
> Anonymous:            16 kB
> KSM:                   0 kB
> LazyFree:              0 kB
> AnonHugePages:         0 kB
> ShmemPmdMapped:        0 kB
> FilePmdMapped:         0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:                  0 kB
> SwapPss:               0 kB
> Locked:               16 kB
> THPeligible:           0
> ProtectionKey:         0
> VmFlags: rd wr mr mw me lo ac sd
> 
> It's not labeled in /proc/pid/maps, so without more work I don't know where 
> it comes from, but *something* in my system libraries has asked for 4 pages 
> of locked memory.

Ok, then the easiest fix is likely to allow some few locked pages in that 
assert statement? Care to send a patch?

  Thomas


