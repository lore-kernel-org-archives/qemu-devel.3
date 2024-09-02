Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0698CCA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 20:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slDEE-0000NN-DW; Mon, 02 Sep 2024 16:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slDE6-0000L1-3q
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 16:00:40 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slDE2-0007GJ-Nb
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 16:00:36 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-53345dcd377so6269717e87.2
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 13:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725307230; x=1725912030; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3MMrtHA5sT2aNyDhcNj28OxY3n+8qln5d9m2QgKTyow=;
 b=HzySVdN1xZk2UYwGBRb92a9e3or3Y48s8usETkpk76urRKZNa+K9Csfq7k0v/qlTHW
 xnOppwGHV5l02SA7LOZhs+s/tcd6qCZahNSvAZ+cHVgqXTeTrOBcz2XlpZFihRK9o8L7
 lJaeJV2vtobQnVhDVDqxNqDxbUiMYA/uNY3QekJxzSYWyTeBfGkVriUwJYhEjFzByuF5
 GoQ98S312Wa90XxhuFqoZnNScTG1BHV2kSmMN8uKICqBSAYsN68vRf8MYab91Ue5CMnV
 7HIq5//4fCP+Pmg9C9Rp2JbsoY3YHFUopKl0hclJrMPqLrhjYdiLEfTcT0V8a7hiU6BR
 JZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725307230; x=1725912030;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3MMrtHA5sT2aNyDhcNj28OxY3n+8qln5d9m2QgKTyow=;
 b=MpQH7MDG/IZWTiad02YLs5zBve/bx3jp5nNZ5jcDKlAiWllUBbIbz77rw6Pkgyoyts
 eSk2vI7eQKEKpIys69tZMUCnFcsEMynAEGACkaQkExP6SHuxriRc72+E3ANoRbpNOARv
 4YDwUQtIdflb5ooToNueuej6pC3Srykvlc7WXMsxDdV+HJBoYbTEuTn/Jqe/7PhJoH3I
 yyWd5vXN49dUekbvqsf0MlYFYco3eYRunZtXP0GC5J2GmwtLdOKuIkGBWltg8dp/8VBg
 kJbtX+Z2zSUNuSKBfFd7N55veomHea6vpYokUP+l0n0VEUNXUJhT5ApfXeQafDZtx9bt
 C1LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCWYDu09qPLpUSwtzu8DagdJxryw65HdV+9k61TVQ2KtS50sSdqUqqD82kfi0FLTC7m1WRVVbeUp4p@nongnu.org
X-Gm-Message-State: AOJu0YwZRrvJHn10Ej39mGVWrOjOyNcD5gy1Xe3fRcTM7WAf/cGTJXPP
 15kN/sT9STkkLHhaeRjtfNNPI84g+6EXj5ee5/MipghMemV9zsJ3oHQPpR7pHbM=
X-Google-Smtp-Source: AGHT+IGmwPwx3YCzWNW57dBNf7B44DJecUJ4EMPoyybIQ9NdVYyetib744gVHPxbQ6D1gGwBzfcRwg==
X-Received: by 2002:a05:6512:3352:b0:530:b7f4:3aaa with SMTP id
 2adb3069b0e04-53546bb5f64mr6125636e87.52.1725307229981; 
 Mon, 02 Sep 2024 13:00:29 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-535407ac472sm1728954e87.112.2024.09.02.13.00.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 13:00:29 -0700 (PDT)
Message-ID: <6c9429e2-90c0-423a-812f-33f98fe1bdc8@linaro.org>
Date: Mon, 2 Sep 2024 22:00:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/arm/boot: Report error msg if loading elf/dtb failed
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Changbin Du <changbin.du@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240830105304.2547406-1-changbin.du@huawei.com>
 <7c67704e-a067-4b6e-8acb-51b33cf17ee0@linaro.org>
Content-Language: en-US
In-Reply-To: <7c67704e-a067-4b6e-8acb-51b33cf17ee0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/9/24 21:55, Philippe Mathieu-Daudé wrote:
> Hi Changbin,
> 
> On 30/8/24 12:53, Changbin Du via wrote:
>> Print errors before exit. Do not exit silently.
>>
>> Signed-off-by: Changbin Du <changbin.du@huawei.com>
>>
>> ---
>> v2: remove msg for arm_load_dtb.
>> ---
>>   hw/arm/boot.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>> index d480a7da02cf..e15bf097a559 100644
>> --- a/hw/arm/boot.c
>> +++ b/hw/arm/boot.c
>> @@ -839,6 +839,7 @@ static ssize_t arm_load_elf(struct arm_boot_info 

Note that header error is also silently ignored and could be logged:

     load_elf_hdr(info->kernel_filename, &elf_header, &elf_is64, &err);
     if (err) {
-        error_free(err);
+        error_report_err(err);
         return ret;
     }

(untested)

>>       if (ret <= 0) {
>>           /* The header loaded but the image didn't */
>> +        error_report("could not load elf '%s'", info->kernel_filename);
> 
> "Could ..." (caps)
> 
> "hw/loader.h" is not well documented, but it seems load_elf*() returns:
> 
>    #define ELF_LOAD_FAILED       -1
>    #define ELF_LOAD_NOT_ELF      -2
>    #define ELF_LOAD_WRONG_ARCH   -3
>    #define ELF_LOAD_WRONG_ENDIAN -4
>    #define ELF_LOAD_TOO_BIG      -5
> 
> And we can display this error calling:
> 
>    const char *load_elf_strerror(ssize_t error);
> 
> So we can be more precise here using:
> 
>    error_report("Could not load elf '%s'", info->kernel_filename,
>                 load_elf_strerror(ret));
> 
>>           exit(1);
>>       }
> 
> Better (but out of scope of this patch) could be to pass an Error *errp
> argument to the load_elf*() family of functions, and fill it with the
> appropriate error message.
> 
> Regards,
> 
> Phil.


