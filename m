Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4453CC5AD2B
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 02:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsWM2-0005g0-TC; Fri, 07 Aug 2026 22:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wsWM0-0005fE-Fj
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 22:00:04 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wsWLy-0002ea-9l
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 22:00:04 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38f0f132f56so2109046a91.0
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 19:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786154400; x=1786759200; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wcff7Qc7G4NPhKObhvB8cmR7HEnvuR9tx458N9ysRiw=;
 b=k5P0md2kG9o7rRWG+pFUXgFOAEPAFuxM+AX4OiCE4JLrqG2SFv5uilQ1ZI+XlQhDEk
 SyG2yyOysb3RG1V4mWjD3sLUD3KZCNPN0B00jiHUVQZ2BCRbPz6K9pWT47gET3o6NwIA
 BZPtVfROBtIWeS1T0lpixN5UkuVxHSJzk7DY2Wg7wLOrvvpRhhA7SmyEQTn8NLsKI/kY
 yqxwmiz7kKYuAQjdnX1kQ7kqKFZbV/0FCEF45eMtrZqz+1g2V3RgINk9aK7mCY5zNUsh
 lNnd8RW9TK78EPT5r+qJpqLH/BnnPaqspxztLahPVkxz72FBR0BIsjW1SzJY8n84VysX
 OPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786154400; x=1786759200;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Wcff7Qc7G4NPhKObhvB8cmR7HEnvuR9tx458N9ysRiw=;
 b=MP5qt1uiT/TdfYhOuUdi9H/m2J09JGosvjYppqIAwWimAXTekdM2Yqgb3UAB0H+4SF
 YJwpvqTd2sDkPFkLggxHF6P9fXMzsUzaaj5D+0fySolQilpeqggOvQH4S463Hr3vY30x
 yDNoxLLUacrOIXHZPLaxY8yYq8QEfL36ca5m7c9NjXLT+Z7f9Nrvj+npNXx1H44f995N
 72zgBt+InxqmaJJSF+9vvmBNFymTfkYvG+yh1rGznsEv4GlhPLgOyjF0d1541F+tJXFK
 RsZtIdDNIDF+9HE4LwwN98SRsK6Kt7/JUcg/ieoUzsTIiuRoc14Myf+ebXGMTHloWrfS
 M2zg==
X-Gm-Message-State: AOJu0YxJLLLa8BCnSy76Rd+9Fyph80MSM6GXEtTzevAZxtFQhyHIfY4H
 Q80ffjAzmDSICIg8AZz5p3I1VIaQuapBYylZ0aBo4QETC2ODeO20eQ/ONbioEytylDfFV9bd4i3
 3Nq02
X-Gm-Gg: AR+sD11bRs1wbNEvsJXc1zvy8WYqpX2X2BajmvfStYgpyR8e/TcPCYLGm2GomQVBzig
 DTQ2Jpt76ydpdsu2M9gCEl96VtFRShyZpr+Zp5ZiXz/74k1feL/agBRZNRb2F7WepS9XeJelF/V
 pQadU9Xs00wp3N1/cO1/CFy03Oh5qYSjlPNuZ2MABCaqgtjWpqU10rFsf1E4jg/5sIelQVATKVi
 JRDB5zOBXYI4fpgCWqMWckU/ZzpI50EeU87eXhfE74A8nyueDCoVpmer7LEqNVF1cWIEMpE+k5T
 aqxb/MigcZ5Hb32i7oN/WTFMgdyEN6QXXNf0en1ndHJw4BBgJoHYlnz8kXO+fUcJwIZvz04z9pN
 5iBAFPjEuv3X9Tw4XcgxmZv5plLfmjTp2ZmkqVFLCqhBWQm0ZDpsXpK9jyzRQHMBhYvpuUjNALz
 cYVbwy6ikFFrEBBMa3PWkpN2DE5Z98A0Cn/9yuTzIaGHxxDd9HD3Plg849MREJ5UAwVlJnj+iE/
 euVBsB/nigIdqdbdq8s/aL18V/GSH4SWjBZdzKe
X-Received: by 2002:a17:90b:4fcb:b0:386:ca4b:16a9 with SMTP id
 98e67ed59e1d1-392846f2325mr1215967a91.16.1786154399742; 
 Fri, 07 Aug 2026 18:59:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3925ff6658bsm4443479a91.14.2026.08.07.18.59.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 18:59:59 -0700 (PDT)
Message-ID: <6f08e939-fc56-406c-b7d6-b095db111e9b@linaro.org>
Date: Fri, 7 Aug 2026 18:59:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix issues with mmap on 4K guest on 16K host
 and library load
To: qemu-devel@nongnu.org
References: <20260805164052.199608-1-andreas@kemnade.info>
 <6f98eb42-54ae-4909-b4f1-4ff683d3d6f9@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <6f98eb42-54ae-4909-b4f1-4ff683d3d6f9@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 8/7/26 14:26, Helge Deller wrote:
> On 8/5/26 18:40, Andreas Kemnade wrote:
>> Strace in qemu:
>> 198005 openat(AT_FDCWD,"/lib/arm-linux-gnueabihf/libselinux.so.1",O_RDONLY|O_LARGEFILE| 
>> O_CLOEXEC) = 3
>> 198005 read(3,0x40802570,512) = 512
>> 198005 statx(3,"",AT_EMPTY_PATH|AT_NO_AUTOMOUNT| 
>> AT_STATX_SYNC_AS_STAT,STATX_BASIC_STATS,0x408022a8) = 0
>> 198005 mmap2(NULL,269428,PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_DENYWRITE,-1,0) = 
>> 0x40868000
>> 198005 mmap2(0x40870000,203892,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE| 
>> MAP_FIXED,3,0) = 0x40870000
>> 198005 munmap(0x40868000,32768) = 0
>> 198005 munmap(0x408a2000,31860) = 0
>> 198005 mprotect(0x40890000,61440,PROT_NONE) = 0
>> 198005 mmap2(0x4089f000,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRITE| 
>> MAP_FIXED,3,0x1f) = -1 errno=14 (Bad address)
>>
>> strace outside qemu:
>> [pid 195331] readlinkat(AT_FDCWD, "/usr/lib", 0x7fffd1a7fd00, 1023) = -1 EINVAL (Invalid 
>> argument)
>> [pid 195331] readlinkat(AT_FDCWD, "/usr/lib/arm-linux-gnueabihf", 0x7fffd1a7fd00, 1023) 
>> = -1 EINVAL (Invalid argument)
>> [pid 195331] readlinkat(AT_FDCWD, "/usr/lib/arm-linux-gnueabihf/libselinux.so.1", 
>> 0x7fffd1a7fd00, 1023) = -1 EINVAL (Invalid argument)
>> [pid 195331] faccessat(AT_FDCWD, "/usr/gnemul/qemu-arm/lib/arm-linux-gnueabihf/ 
>> libselinux.so.1", F_OK) = -1 ENOENT (No such file or directory)
>> [pid 195331] openat(AT_FDCWD, "/lib/arm-linux-gnueabihf/libselinux.so.1", O_RDONLY| 
>> O_CLOEXEC) = 3
>> [pid 195331] read(3, 
>> "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\0\0\0\0004\0\0\0"..., 512) = 512
>> [pid 195331] statx(3, "", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT|AT_EMPTY_PATH, 
>> STATX_BASIC_STATS, {stx_mask=STATX_ALL|STATX_MNT_ID|STATX_SUBVOL, stx_attributes=0, 
>> stx_mode=S_IFREG|0644, stx_size=132612, ...}) = 0
>> [pid 195331] mmap(0x408a8000, 16384, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS| 
>> MAP_DENYWRITE, -1, 0) = 0x408a8000
>> [pid 195331] mprotect(0x408a8000, 16384, PROT_WRITE) = 0
>> [pid 195331] mprotect(0x408a8000, 16384, PROT_NONE) = 0
>> [pid 195331] mmap(0x40868000, 262144, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS| 
>> MAP_DENYWRITE, -1, 0) = 0x40868000
>> [pid 195331] mprotect(0x408a0000, 16384, PROT_WRITE) = 0
>> [pid 195331] pread64(3, "", 8192, 196608) = 0
>> [pid 195331] mprotect(0x408a0000, 16384, PROT_READ) = 0
>> [pid 195331] mmap(0x40870000, 196608, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 
>> 0) = 0x40870000
>> [pid 195331] mmap(0x40868000, 32768, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS| 
>> MAP_NORESERVE, -1, 0) = 0x40868000
>> [pid 195331] mmap(0x408a4000, 32768, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS| 
>> MAP_NORESERVE, -1, 0) = 0x408a4000
>> [pid 195331] mprotect(0x4089c000, 16384, PROT_READ) = 0
>> [pid 195331] mprotect(0x40890000, 49152, PROT_NONE) = 0
>> [pid 195331] mprotect(0x4089c000, 16384, PROT_WRITE) = 0
>> [pid 195331] pread64(3, 0x4089f000, 4096, 126976) = -1 EFAULT (Bad address)
>>
>> That makes simple commands like ls --version to fail.
>> Tested was arm32 on a arm64 only host.
>>
>> Fix that issue by truncating file mapping and replacing out-of-file
>> mappings by anonymous mappings.
> 
> Could you please explain "the issue" and not just referring to the strace?
> It's not that easy to see the problem.
> 
> Thanks!
> Helge
> 
> Btw: you patch might fix this problem, but you may run into other problems too,
> see e.g.: https://gitlab.com/qemu-project/qemu/-/work_items/3410
> 
> 
>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>> ---
>>   linux-user/mmap.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
>> index 423c77856a..4fce6fae3c 100644
>> --- a/linux-user/mmap.c
>> +++ b/linux-user/mmap.c
>> @@ -796,6 +796,32 @@ static abi_long mmap_h_gt_g(abi_ulong start, abi_ulong len,
>>       bool misaligned_offset = false;
>>       size_t host_len;
>> +    if (!(flags & MAP_ANONYMOUS)) {
>> +        struct stat sb;
>> +
>> +        if (fstat(fd, &sb) == -1) {
>> +            return -1;
>> +        }
>> +        if (offset >= sb.st_size) {
>> +            /*
>> +             * The entire map is beyond the end of the file.
>> +             * Transform it to an anonymous mapping.
>> +             */
>> +            flags |= MAP_ANONYMOUS;
>> +            fd = -1;
>> +            offset = 0;

This is incorrect.  Even natively, accessing past the end of the file should SIGBUS.
For host page size > guest page size, as we are here, you should never encounter that 
particular emulation problem.

I've no idea what you're trying to solve.


r~

