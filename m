Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19C1FF8873
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIC4h-0003o0-UB; Wed, 29 Apr 2026 17:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIC4f-0003f9-5T
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:04:01 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIC4c-0003JD-RM
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:04:00 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8296dabef74so221676b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 14:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777496637; x=1778101437; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O+lJTz9HmPluv508e7JwiB4tGCitMUuOPuXqa+lBO2o=;
 b=L6BK+4ghndttyP+0oGR5P0bLGt+w76sm1j2J8Kngvg3ecBBYimL7T4mdjowAJkZxQR
 /arvgZUXsli/AQndHhwhN4L52lsudJAubN9J9PvrkU8/SoTlPU2UJywCtSFL/e7ZsNu/
 x5pQ/scERXccH/mEVCua9QAN8IcX5tHy71aPTLy7+Om2YlVQTrIMmh781tovxmvR7/Ro
 leVUdqT7ZSEK+Stv2W0MzPljp0igCKhRjqkBjIz6UqK9GJLDUl9PyJbwoilHyt+LnMV1
 HAQ/JOJnTnSejzOBlK5iJIuXkFVwdG+VKP+XFHiXgSsx5RT08RFrZchL71LlJrcJZr7N
 j1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777496637; x=1778101437;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O+lJTz9HmPluv508e7JwiB4tGCitMUuOPuXqa+lBO2o=;
 b=T0S5+AerjhJuFtec1fodBGBVdiuMY0hb4llnFCFnRCdKBIPc7eQFfaA9Uczu35bscK
 PCDET48XwTYJgmsMaPPDgSgYyeOw4rh98TdkaU9c7ojqESmBXorrFBGTKeMxU2h2sNA8
 UtdysuEKlN+PQg0b495bG1KwerWdSjBFp0HK9ss0wM5+eCExum9z6kg5yGMhCTfue38b
 jwdzo+RtmuWkWp5Da/96Oq2zC8JO5b/+yU6u8arMBh91O5eLxC2fA4dLb7dYw9IymCNp
 8FnarbcQYMBCR7Tx7ImlTj+6VJBacv8LKK8eFDbjZwglrkzpYn91YYhoaiPQmsUjLZ2W
 +qaA==
X-Gm-Message-State: AOJu0YyEAmUZjJUa5BCeWZ/Be0n4UDcturN12A1IJM9dqLknnz1mpjc7
 guMAKuu/jz47FOD4dvt4p/kn+o2BVeb4SbwB3MJQjRF6qHOn3b9rXmUZzsMtYpJIZskcn9B8smO
 oUVsqhB4=
X-Gm-Gg: AeBDietJyB8lRFJT1c9EKbYMD6PACkMQjSxArgLjynWYv+Wz+96RYmjLAnSIDLBVG6R
 BBjRBfqSFIp3TXdBoqzeZQMDmX9+j1V/emhj1GLNfTGSrbX8NGi3zpQit8QzAmz7owTV9jaseBh
 xPfHTT6eaomuTc2UjdqRw1Gg/HEl60SEST7CXBdHj0gJ/4VmhqR2uHNZ/U51Py7kpGv2sazSdQd
 yctKgE7xAhEguIeG19n2BE2HUUKhpEymRYc+FR8bhOUWlRpvl22uzPYgPHwPYF4UwLeZplrFfUQ
 1aJ5/vvMFLLH0FMv2G8Fc/8pNfY0GZtf/8uveBsvJ4jZxu47Oq5zrNAqGJ0++SVOOgfxKS1bMv+
 goCznt2DXRLTR4iJ5ETzo7qaoUYtmn1RoaED8KQna5UyYWo9Sfe+MMyUo5NEOB08dOKcg1cdvb+
 TUuWMcMZRJExBzsINkncH+eMCVMxnJn0qIoeGvjz6J1L9CCXuhyDfb
X-Received: by 2002:a05:6a00:4b4f:b0:834:e043:ffd8 with SMTP id
 d2e1a72fcca58-834fdb166b9mr265379b3a.17.1777496636766; 
 Wed, 29 Apr 2026 14:03:56 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed6de621sm3679035b3a.29.2026.04.29.14.03.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 14:03:56 -0700 (PDT)
Message-ID: <feda4269-fe96-4c73-a87e-c3181b43efdd@linaro.org>
Date: Thu, 30 Apr 2026 07:03:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] system/vl.c: inline qemu_opts_parse_noisily() result
 checks
To: qemu-devel@nongnu.org
References: <20260429062004.36582-1-guobin@linux.alibaba.com>
 <20260429062004.36582-4-guobin@linux.alibaba.com>
 <708ac3f4-bb55-459a-9506-77751133c973@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <708ac3f4-bb55-459a-9506-77751133c973@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 4/29/26 18:04, Philippe Mathieu-Daudé wrote:
> On 29/4/26 08:20, Bin Guo wrote:
>> In qemu_init()'s option parsing switch, several cases assigned the
>> return value of qemu_opts_parse_noisily() to the shared 'opts'
>> variable solely to check for NULL, without using the pointer
>> afterwards.  Inline the call directly into the if-condition, matching
>> the style already used by QEMU_OPTION_action.
>>
>> This affects the following options:
>>    -drive, -numa, -iscsi, -m, -mon, -chardev, -fsdev, -fwcfg
>>
>> Cases where the returned QemuOpts* is subsequently used (e.g.
>> -acpitable, -smbios, -virtfs) are left unchanged.
>>
>> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
>> ---
>>   system/vl.c | 37 +++++++++++++++----------------------
>>   1 file changed, 15 insertions(+), 22 deletions(-)
>>
>> diff --git a/system/vl.c b/system/vl.c
>> index 0e1fc217b4..0e0d3cb761 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -2961,9 +2961,8 @@ void qemu_init(int argc, char **argv)
>>                       break;
>>                   }
>>               case QEMU_OPTION_drive:
>> -                opts = qemu_opts_parse_noisily(qemu_find_opts("drive"),
>> -                                               optarg, false);
>> -                if (opts == NULL) {
>> +                if (!qemu_opts_parse_noisily(qemu_find_opts("drive"),
>> +                                             optarg, false)) {
>>                       exit(1);
>>                   }
>>                   break;
> 
> For clarity I'd also squash in this patch:
> 
> -- >8 --
> diff --git a/system/vl.c b/system/vl.c
> index cab8106984a..237334236aa 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2842,3 +2842,2 @@ void qemu_init(int argc, char **argv)
>   {
> -    QemuOpts *opts;
>       QemuOpts *icount_opts = NULL, *accel_opts = NULL;
> @@ -2921,2 +2920,4 @@ void qemu_init(int argc, char **argv)
>       for(;;) {
> +        QemuOpts *opts;
> +
>           if (optind >= argc)
> ---
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

If you're going to move the decl, the innermost block is just below with

         } else {
             const QEMUOption *popt;
+           QemuOpts *opts;

             popt = lookup_opt(argc, argv, &optarg, &optind);


r~

