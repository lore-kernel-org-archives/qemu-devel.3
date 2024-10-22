Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D7AD1715E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 04:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t36IB-00046o-3s; Tue, 22 Oct 2024 00:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t36I9-00046X-C1
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:14:45 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t36I7-0004lB-No
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:14:45 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e2e88cb0bbso3784118a91.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 21:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729570482; x=1730175282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AstIRiyH5rf0gbmmJ/VewQ6+5e+RTLDUASJu7xbFM8A=;
 b=qJ/hL/VxR1WmJeLOLj0eE0dh7AEC4kfIViag05QQMyAMakXYBV3ieNJmPZJlTm1y2C
 DBOxRJ+GMCLuCkTVWcVn3xnO4JML4G6/ReHJXhRfVK57V9USNTQDCTS03goBY2GpMJ8T
 ypbc3dusmCNMfJ9z7MImuZZpjcXwqmxPFrv2D9lZawnv0jOTkJ2P3IRgGgLVijB2tL/0
 WTay04MPwxt9s/MvptGmQlU1DC+oNYIczGtjr8NEiz66OScPM/Qij3N/RU1FST+O31DV
 VDjwpU8ZVvxAEp2Q22w8npHhgAi/mU2p9pueMvwLpJH/ds0N8Xb8wuobLVKDApCXP1PL
 K2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729570482; x=1730175282;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AstIRiyH5rf0gbmmJ/VewQ6+5e+RTLDUASJu7xbFM8A=;
 b=qQbRxaXk+1mQ5ETBGwol6y07UJcwYgd8O1Pjfr+UXUXIWXRUClWrFxp8L4iesHRAUV
 4wDNHWjK8HbCvaamQlmb6Y9JU7GsZ6dIOqgPv7zUPqXgHUB3ZXAbc6SB+XfSi/pSB6X+
 a0ABPXzCa9DOR5NLngDQCK4DKNDY40/HdTwu4ZtbXwi5weC4e+Dhfzeynlaw1FCUuVd5
 UqIwz/f6ty+VeGp9rJVH8E1Z1EWk3+ZzztGKtK8ckwFr0rgJkOSlckScp0OjCz3EsA+5
 81V95fWMtF+p4W2BuXuYPu1yo1BPNnqcu0UEML5194nuizcsXB+RRFJG5a+nYAfFKA1v
 X7Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCUivpFkhzVNGRSUKnLoYNqgXJ2CpXYyWm3OlyHukegyR30U7Ou2RvP2TdUbd45OwCUSvx4PpjURYOIz@nongnu.org
X-Gm-Message-State: AOJu0YzGXQRvDM2GL52a/X1i3iA3fkskJpNM4PtkyxP2ROR4cuS2c3pr
 gvgsiVe9Bgoaz+qkclJLnX2sinZ+15c8zMmGn9F9JtBdCp7Kkxiajv2Y/o9NUf/vh7VMPnqeRhz
 N
X-Google-Smtp-Source: AGHT+IHYZm2QQiHHFW1u3XAqTSI+Oyx0oWX/5/Z/bi/uOkSkZXXHkeXq0OOhPqVtfkpwHpkSbKiEzg==
X-Received: by 2002:a17:90b:f87:b0:2e2:d821:1b77 with SMTP id
 98e67ed59e1d1-2e5616509b4mr15802958a91.24.1729570482171; 
 Mon, 21 Oct 2024 21:14:42 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad3677efsm4935687a91.17.2024.10.21.21.14.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 21:14:41 -0700 (PDT)
Message-ID: <4faa9e31-7bb5-4486-a56e-cedaf7a13371@linaro.org>
Date: Tue, 22 Oct 2024 01:14:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg: Stop using exit() in the gdbstub testcases
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20241021150153.487057-1-iii@linux.ibm.com>
 <CAFEAcA9W6Fb-gvCx268xV+CV7LyWJwCQGqkKFpGQjdT+WiAEUQ@mail.gmail.com>
 <e22adb4e-86a2-43aa-a9f4-2e9f40bb4d87@linaro.org>
 <cd561063296a9e42053d7e1c07cf49617938466a.camel@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cd561063296a9e42053d7e1c07cf49617938466a.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1035.google.com
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

On 21/10/24 16:31, Ilya Leoshkevich wrote:
> On Mon, 2024-10-21 at 16:08 -0300, Gustavo Romero wrote:
>> Hi,
>>
>> On 10/21/24 12:08, Peter Maydell wrote:
>>> On Mon, 21 Oct 2024 at 16:02, Ilya Leoshkevich <iii@linux.ibm.com>
>>> wrote:
>>>>
>>>> GDB 15 does not like exit() anymore:
>>>>
>>>>       (gdb) python exit(0)
>>>>       Python Exception <class 'SystemExit'>: 0
>>>>       Error occurred in Python: 0
>>>>
>>>> Use the GDB's own exit command, like it's already done in a
>>>> couple
>>>> places, everywhere.
>>>
>>> This is the same bug that commit 93a3048dcf4565 is
>>> fixing, but it looks like we didn't catch everywhere.
>>
>> Yep.
>>
>> So maybe now change in test_gdbstub.py this line:
>>
>>       gdb.execute(f"exit {fail_count}")
>>
>> to use the new gdb_exit()?
> 
> Thanks for taking a look! I think I'm already doing this here?
> 
> @@ -62,4 +68,4 @@ def main(test, expected_arch=None):
>           pass
>   
>       print("All tests complete: {} failures".format(fail_count))
> -    gdb.execute(f"exit {fail_count}")
> +    gdb_exit(fail_count)
> 
>> BTW, last news from this issue is that it seems to be fixed
>> in GDB 15.2 [0] (I haven't tried it). However, the fix using
>> gdb.exit(n) is still correct.
> 
> Interesting, I didn't realize this was a bug and not a design
> change. Still, given that the buggy GDBs are out there, I'd prefer to
> have this change.

Preferably mentioning commit 93a3048dcf4565,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
>> Acked-by: Gustavo Romero <gustavo.romero@linaro.org>
>>
>>
>> Cheers,
>> Gustavo
>>
>> [0] https://sourceware.org/bugzilla/show_bug.cgi?id=31946
> 


