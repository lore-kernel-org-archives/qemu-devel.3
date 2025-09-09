Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD3ACAC58C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 07:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvt5v-0007Sd-1s; Tue, 09 Sep 2025 03:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uvt5o-0007SB-7V
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 03:48:44 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uvt5k-0004fq-E1
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 03:48:42 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-628f29d68ecso3422994a12.3
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 00:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757404116; x=1758008916; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/kniX1Um2GQmVikiPu9kyIxLBJJm+Pz4wwjXXfTyiOM=;
 b=AyGwnwejmTr74pb/4ymwMvUOQNtIpmF/V4+AlpWTgPVvqPGow2VdwtC62gE2viY/9f
 y6MsXDjlXpV2iVfx/vAndfb4/rGYSE9Pt4xsdY/N5lkPnWvZJNvP6uYsQVqCvhj7EeG4
 VgLyVW1Afj2a1kS3J4AtyhlfBDHO3yHnsYLqsCMmn1sl3dEhc5R023ehgXzGulLRugNd
 gK1H0wo9PkG6u+xJJEV3TrLZ79LLrC5OutqYk3VUhnWuxKyn4viVQ57ivehTaZbKk0l1
 CX6/USKGD5d0IpLu2HdAj75uxw6dI31jS2DDdKkcOGRGkzQuD7QfeGaa0a7jg3bCY0mT
 1FyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757404116; x=1758008916;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/kniX1Um2GQmVikiPu9kyIxLBJJm+Pz4wwjXXfTyiOM=;
 b=kNhGDaTP+ejshmXT5qvGGD+WCUZiizEDv7RjSNLOKmGsYp0GcUp1ifo/axuL3YEx6b
 1zpGjBugZbQSWVT4ypU/dfhx1bIusg0Cj+B2bU3ZQPVHhnsKc+EZAyXNlwgb25slWZgv
 M+qgmUypLCBrQSjjz8sOIKiFwvwg4z7krLZVtcFq0mxkeMRgOQIV6lRh+AjEzeP9sMEE
 Cs3W+uUcs3iwJWw0zPTa7z5ZES2dzH2PG5ulkNpRJC2DLbrgjWnCeJ6Si+6VycS5mo2P
 XiPoKcXkUGdOSUMprJtT4TFlylEv2D1z2rOT+bD+Wi5nkAXLy7r0w5V0SSKk7CmhUCNj
 4jLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJD6g6/R+Vmv4d7UxV6Bt9ffwTgfHj6+69Zd1Tn4japJLAAb/soNMefP95ITn4YPzQfm0Mno6ui2It@nongnu.org
X-Gm-Message-State: AOJu0Yw83AaNiyLqYzcFgpHIQXUoANiQZZDivhUFN24qdB9COBGmCrV8
 W+erPeQdON6F63bvFuU2Fnu+z5ci8Er9Tj8c5ApLFa6/kMIgE0HzQWCCtqt6TzsPfYs=
X-Gm-Gg: ASbGncs4YCj+mJVGS4MVIRovIfOjlGkkI3qsZwvBqx1BC9/Ld8PEREwBjvVjsOwpAJp
 wOMKgGAY2e6Ao5rGAhqkEGp+YsbtPhKydQWIhGqZ4m2L1D1QUtiorYgopVZ+0DX2+obMgy41hHk
 G9JKAIehrzHVV/lzNgv3CAlsLQKLPUBnb23w0nr9UBrTLHubA/Yccgg1YILLoE8ovlO+nO7MRLD
 HRO1UgHg47Of2Xdw7kjkj/9CAj/7K9i0l6BCl7R5BYGi4vICvVIz8NxVbAYJ7FbDwxmOZopCEk8
 0ZxvlzGoZOdepykZxPraG65+/HYcuOiKD6/6X1PoXzVRSgJhU5ZIaLCpkQzwO0vZw8YIYx8f94y
 ar196TnGtBNaZG21x0pOr63oN1tx2dXzr6FQbWiU2ngg3ijHqQLoFOtqx8b6kCe8RK2NA51GE+f
 zJFNWxRXdC228gOv+E
X-Google-Smtp-Source: AGHT+IGHL1LTzNA6IgpsD7t/GtpoGyraS0yBEfQjp5qCpLXbnchJM6pt7Pefy1FQUO2GarPS6SL/Ig==
X-Received: by 2002:a05:6402:5110:b0:627:5841:7ae1 with SMTP id
 4fb4d7f45d1cf-62758417d89mr7563196a12.21.1757404115773; 
 Tue, 09 Sep 2025 00:48:35 -0700 (PDT)
Received: from ?IPV6:2a01:6f02:331:6601:e160:1208:59c9:40f2?
 ([2a01:6f02:331:6601:e160:1208:59c9:40f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-62c018f65afsm747790a12.41.2025.09.09.00.48.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 00:48:35 -0700 (PDT)
Message-ID: <4957da97-4d2e-41db-9bb1-9197a577369d@linaro.org>
Date: Tue, 9 Sep 2025 07:48:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Failure of func-x86_64-memlock
To: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
References: <7ceb8d59-be3f-4dad-9e2b-9db62fbf92cb@linaro.org>
 <666dce10-2359-4211-b761-daf9a828523e@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <666dce10-2359-4211-b761-daf9a828523e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/8/25 10:12, Thomas Huth wrote:
> On 05/09/2025 12.26, Richard Henderson wrote:
>> Hi guys,
>>
>> This test has been failing on my laptop for a few weeks.
>> Any idea why?
> 
> FWIW, the test still works for me (after enabling it with "ulimit -l 2097152").
> 
>> There's nothing logged in tests/functional/x86_64/test_memlock*/*,
>> which itself seems like a bug.
> 
> Is there maybe any hint in meson-logs/testlog-thorough.txt instead?

Ah, yes, there it is:

TAP version 13
not ok 1 test_memlock.MemlockTest.test_memlock_off
ok 2 test_memlock.MemlockTest.test_memlock_on
ok 3 test_memlock.MemlockTest.test_memlock_onfault
1..3
----------------------------------- stderr -----------------------------------
/home/rth/qemu/src/python/qemu/qmp/legacy.py:89: DeprecationWarning: There is no current 
event loop
   self._aloop = asyncio.get_event_loop()
Traceback (most recent call last):
   File "/home/rth/qemu/src/tests/functional/x86_64/test_memlock.py", line 40, in 
test_memlock_off
     self.assertTrue(status['VmLck'] == 0)
AssertionError: False is not true


So it seems there's some non-zero amount of memory locked in the process, likely nothing 
to do with what we're trying to test, but we're asserting anyway.

Digging into /proc/pic/smaps, I have:

79d7d3547000-79d7d354b000 rw-p 00000000 00:00 0
Size:                 16 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                  16 kB
Pss:                  16 kB
Pss_Dirty:            16 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:        16 kB
Referenced:           16 kB
Anonymous:            16 kB
KSM:                   0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
FilePmdMapped:         0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:               16 kB
THPeligible:           0
ProtectionKey:         0
VmFlags: rd wr mr mw me lo ac sd

It's not labeled in /proc/pid/maps, so without more work I don't know where it comes from, 
but *something* in my system libraries has asked for 4 pages of locked memory.


r~

