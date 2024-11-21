Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B627D6E2A7
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 10:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE46R-0008Si-SG; Thu, 21 Nov 2024 05:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE46J-0008RP-MQ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 05:07:52 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE46H-0007YM-N8
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 05:07:51 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38232cebb0cso479118f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 02:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732183667; x=1732788467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=crMRwIDmujqZpMsYhlToNU7FOG6Dou2KVnBLjiUeznM=;
 b=k5LOOyMZPA9leltq8r750YK6umF9uMJMasM3Gwb3CUoBzrslW1uIjBFOWDWX4VaRuE
 swcafpMXHsDRqcAKJNGJKfGMwQ+W+aIfykpzQHa3Uu/eKE1KwmDEAlAU+5NzuzQmFqWC
 NiasTlmwN1P9oQYX+1Qbs/IIN4GMD56g731VT0tylZEzeudBs0bnFjqoKCZ8wUvKWihD
 nFt4CrNznURm7dlwLifNz3YluB7kiXmo3i/9JxHV1CPBsUqEsN5+pc3VlbK/W6zFZE7U
 FLvByH0wc5G4Wby7jhreCS1HVQXXhtqUQ5dVodhtRDR61J8ANygk0/eg+bEOm3P4Nix3
 ZagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732183667; x=1732788467;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=crMRwIDmujqZpMsYhlToNU7FOG6Dou2KVnBLjiUeznM=;
 b=Ej9nGiS/E9kISIL1UN4yjfZX+V77DSJARHD3nzxRUeE0cWEYvhF9bJ7+22wa2xo0V5
 eqWMjB2UW5ZJs/SZT79VyzDpNZofwbjo9Bd0t7KaPNR56KAimSfo5j8d09u/0M9a9RGt
 scry+wXlcmhlECqCRyxZKC85zdwQO/kblNY0JSCHRqlg89k95gi+vd4jIFYWv0BcX2UU
 xp1fOYri6DPJgFq+uj//nRwpnjKWedZQ0QN17jx4em87YU5j+pnrkZucffvGGt3DBNZA
 V5sdeowvp9EWk2De2ippIHqhZWzsT/Tl68YfmE3T8+ZbDLTYB1m5+j7+65Hdlx+ZlrY0
 WqWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiTaPncv6yFEUPK9/rG7gTeH/tsF0x3S/gC/394FJV5/slU6QK53duMtpl7+puBUz8RGGZi04l5oXC@nongnu.org
X-Gm-Message-State: AOJu0YyzgJBig66I8db5jb0kVVUjdr6Z2rKy/LKxFRvKkmAspfXDOKu5
 rDo7PHQH6YgCqt4UFNmofRRuQqad3H/G+VmLVXVikWJG/WgxbUXv0IhtqOC8gEw=
X-Google-Smtp-Source: AGHT+IFgkSUx6wRZfD5Ix7flDyUMtMwhTFwsxZ5fXvwu3qTtHUZYZbF4p2Y1Fz/+Lhcs45e+NVDY7w==
X-Received: by 2002:a5d:5849:0:b0:382:495c:deca with SMTP id
 ffacd0b85a97d-38254b15741mr4185499f8f.39.1732183666795; 
 Thu, 21 Nov 2024 02:07:46 -0800 (PST)
Received: from [192.168.69.146] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825493ee48sm4479584f8f.98.2024.11.21.02.07.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 02:07:46 -0800 (PST)
Message-ID: <47e35ab6-65f7-451e-b557-8528e2542222@linaro.org>
Date: Thu, 21 Nov 2024 11:07:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: Fix strace output for s390x mmap()
To: iii <iii@imap.linux.ibm.com>, Helge Deller <deller@gmx.de>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-stable@nongnu.org,
 John Reiser <jreiser@BitWagon.com>
References: <20241120212717.246186-1-iii@linux.ibm.com>
 <faeded70-af8e-4c3f-af1a-0bd1e11f5394@linaro.org>
 <66b61760a0cbc8001611a99678b4719e@imap.linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <66b61760a0cbc8001611a99678b4719e@imap.linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 21/11/24 10:26, iii wrote:
> On 2024-11-21 10:00, Philippe Mathieu-Daudé wrote:
>> On 20/11/24 22:26, Ilya Leoshkevich wrote:
>>> print_mmap() assumes that mmap() receives arguments via memory if
>>> mmap2() is present. s390x (as opposed to s390) does not fit this
>>> pattern: it does not have mmap2(), but mmap() still receives arguments
>>> via memory.
>>>
>>> Fix by sharing the detection logic between syscall.c and strace.c.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Fixes: d971040c2d16 ("linux-user: Fix strace output for old_mmap")
>>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> ---
>>>
>>> v1: 
>>> https://lore.kernel.org/qemu-devel/20241119211138.148806-1-iii@linux.ibm.com/
>>> v1 -> v2: Share the detection logic between syscall.c and strace.c
>>>            (Richard).
>>>
>>>   linux-user/strace.c       | 2 +-
>>>   linux-user/syscall.c      | 5 +----
>>>   linux-user/syscall_defs.h | 7 +++++++
>>>   3 files changed, 9 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/linux-user/strace.c b/linux-user/strace.c
>>> index b70eadc19ef..9c55f39b095 100644
>>> --- a/linux-user/strace.c
>>> +++ b/linux-user/strace.c
>>> @@ -3971,7 +3971,7 @@ print_mmap(CPUArchState *cpu_env, const struct 
>>> syscallname *name,
>>>   {
>>>       return print_mmap_both(cpu_env, name, arg0, arg1, arg2, arg3,
>>>                              arg4, arg5,
>>> -#if defined(TARGET_NR_mmap2)
>>> +#ifdef TARGET_ARCH_WANT_SYS_OLD_MMAP
>>
>> We still want to print for mmap2, so:
>>
>>   #if defined(TARGET_NR_mmap2) || defined(TARGET_ARCH_WANT_SYS_OLD_MMAP)
>>
>>>                               true
>>>   #else
>>>                               false
> 
> mmap2() has its own flow from what I can see:
> 
> print_mmap2()
>    print_mmap_both(..., is_old_mmap=false)
> 
> It should not call print_mmap(), which I'm changing here.
> 
> [...]

If so, better to clean that in a previous patch.

Cc'ing Helge since I'm a bit confused by commit d971040c2d intent
("linux-user: Fix strace output for old_mmap").


