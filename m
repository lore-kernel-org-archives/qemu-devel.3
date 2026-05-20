Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037CACD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmjM-0006yL-VM; Wed, 20 May 2026 15:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmjI-0006y6-N1
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:37:20 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmjG-0006D7-RA
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:37:20 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488b0046078so46600005e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305836; x=1779910636; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DgFtYzA9dX+ghkoPZtbWiIEKi6fJOeKrcYSoPgt7hOw=;
 b=bIAQIlVp5E9AB57ifnWFL/pDE1BBCeor9Z2wZgL6N52R35JSvcs7SYR4aPK4sY56El
 93/20u2iCKcfszjjix0h7QcxD0JZz4AOacQUxPNP4mTaeYoWQtDNtc+q/AwKD4txMr7N
 EYyEJBMcOIv1eWKbzeU/01XVT0ETtUj/TX2SHDT+Yjnm2KHYmR7cN7DDVSIe76Ta+TEi
 HL0g5npLOp5urZVbhxf9VdjilAsVt+SCBDg5X+gUwCDDT2dtO6S3Bz+/lOziA+LYp9In
 MqY10loqsbg7KHZ311hR7vNi+9SlS2cGoQB+EznfGMkcQFil4lOzTpuT3Zo9nAV1WZQM
 rSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305836; x=1779910636;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DgFtYzA9dX+ghkoPZtbWiIEKi6fJOeKrcYSoPgt7hOw=;
 b=LzQ7p/UpYWimUMoGJeT+cQ863XqtX1xrtMvm0ESga+LP2leGa7Cw8+Qe0yyF2BzUmv
 AParr48LVF2l+5kVUIRK6UF+STq+mWWaMGFtRiYVmRH/BBU8rqeUTfkxJfd7GbDfLYkA
 0tQP1YWz9t/XLknlYrBeyt9AJeljLZKZHHGp+0DTGrDUXcyb9elhCZGBKIiidTYrUxdi
 T36Pxlx4U1MNfirfMcfdRoctY+xqdQUBmNu/hfRNfNHSKrZubJQnjOmw1gu3PQQTCkMx
 ed58phDAHJSRxVewX6JLTV0wFQDUoemMZbGnPM9+izdo5mO3hgFBQMYpNdyMVHMtv4M8
 C05g==
X-Gm-Message-State: AOJu0Yzh2tSk8a8C+himC6FBUngxI2+iDr9zRtO7TJEdu3OJEMgrFKw9
 ux+M4kaFJvo5qEXIb0RnkDZJnMESfrvDB5jtSe6OifFPHQONvJ7AzIH+gfs18lRpjO4=
X-Gm-Gg: Acq92OH9KjQw08oeWZb4pxduRFkUbYHyh0tD4JhpQXwu/1MEgpcegqsYmNcBb4Mgb8G
 AG44+2Pw3jX2uS0JYcCT+G9pdl7kICY95BzITJgQuVDzCtxUkQ1PUgsAkG2iaZVWJC1zcbTXSDS
 aV/XxLBqRsAPFlZQ0L1cazd8JNPKWAq6DF2++1A/4cp/1QjpENKIj7gQh/FWloo8AlG2HNN868h
 KHuH8P7pXVSAjAkUKVGt5yx3440LrkMJkxIxxR25SmxI4YLD757bSJyBmowpVJqktD3Cu4uwWn/
 ZF/dEUliDfU0+KrXbJkw0JsGr/46rOBbfOMPp3TaGX4VB2PzgPx1heHkxMxgkntjfLay35ijRCM
 yejz6m9AxH7PSrS6cGqhTsqg8VzzmKRoRhYvaXgSpdPu6ixXofNlXZTfPM3OvtzNEVHUjaYns/i
 gshun8jOwSkb3Gp+kj9sIc6ohdHa701A6LunrDI4db/56nATileS3OS64ueG6PNwhSAh0thXUt2
 gbc
X-Received: by 2002:a05:600c:1d0d:b0:489:1ff1:74df with SMTP id
 5b1f17b1804b1-48fe5fcdf50mr372332845e9.1.1779305835611; 
 Wed, 20 May 2026 12:37:15 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3ac86sm55378341f8f.14.2026.05.20.12.37.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 12:37:14 -0700 (PDT)
Message-ID: <3104a00e-4c13-4bf7-95a0-1f2840bec50d@linaro.org>
Date: Wed, 20 May 2026 21:37:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Replace my amsat.org email address
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Akihiko Odaki <akihiko.odaki@gmail.com>
References: <20221017182005.43015-1-philmd@linaro.org>
 <87pmeohtj1.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87pmeohtj1.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

On 19/10/22 14:44, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> The amsat.org domain is having issues with DMARC / SPF / DKIM:
>> https://lore.kernel.org/qemu-devel/CAMVc7JUy5NeEN0q=4zfZvn_rppgqn9wicV1z=TsLuHKS3RY3Sw@mail.gmail.com/
>>
>> Consolidate all of my MAINTAINERS entries on my work address.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   .mailmap    |  4 +++-
>>   MAINTAINERS | 62 ++++++++++++++++++++++++++---------------------------
>>   2 files changed, 34 insertions(+), 32 deletions(-)
>>
>> diff --git a/.mailmap b/.mailmap
>> index 1f7319b70b..35dddbe27b 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -70,7 +70,9 @@ Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
>>   Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
>>   Paul Burton <paulburton@kernel.org> <paul@archlinuxmips.org>
>>   Paul Burton <paulburton@kernel.org> <pburton@wavecomp.com>
>> -Philippe Mathieu-Daudé <f4bug@amsat.org> <philmd@redhat.com>
>> +Philippe Mathieu-Daudé <philmd@linaro.org> <f4bug@amsat.org>
>> +Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@redhat.com>
> 
> I think this retroactively credits all your contributions to Linaro.
> Intentional?

Certainly not intentional. I was seeing this as a git limitation, but
Alex pointed to me we are doing an invalid use of git-mailmap, since
it is described as:

   ... the file .mailmap [...] is used to map author and committer
   names and email addresses to canonical real names and email addresses.

so more for typos, not developers changing email addresses. So our
"replace old addresses by a more recent one" section might not be
the best use. I think it was useful for the get_maintainer.pl fallback
option: when a file is not cover in MAINTAINERS then the script look
at git history. If all files are well covered, then we shouldn't need
this fallback anymore, nor this .mailmap translation.

> 
>> +Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@fungible.com>
>>   Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
>>   Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
>>   
> 
> [...]
> 


