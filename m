Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFD9CD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 06:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS7eu-0005XM-R3; Wed, 27 May 2026 02:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wS7es-0005Wz-8K
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:22:26 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wS7eo-0000jJ-UK
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:22:24 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4905e190c71so34148195e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 23:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779862941; x=1780467741; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=64TzK3svwOxTh2XTVm+owsgybYQF7CIoJU7bOfWr3PE=;
 b=v12aN220bM+n6e49AgvB0SR1FFfAJ1CSZrlkfXE5/F5pgz6ubxFI/v2EK864Jdg0ST
 94zAZZKZTC+FnxUfLjK7Vqr9IT8Lz6E4+1537Nh9YXm+yNHHNGiHTymzkUmu+OXjOmH8
 fCjiu2hPHMwc2sXF1qz9RC/ry7N3gGLnV8zV9uFbUor1qhrV8NBVnrpwOVG8kODX1ufD
 xFVNxd9DeRC34QyrFpU6Hvm7DZWVvcoYEgxStxGL39j9LUYNnjDJYKkPdM2pCpjWhJZv
 trrMlgbcP3NbTqNJWZ8bUFDZgthVntLQnZ5HLer3ddAryRdWgmM81RYOs4TLIgM5lFJx
 HBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779862941; x=1780467741;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=64TzK3svwOxTh2XTVm+owsgybYQF7CIoJU7bOfWr3PE=;
 b=URx9IoHydUgAldRYSe/ISekDdnUAQAwPrOKixjRfBfsBAAcdx2B07VAWn38Tkw/C2F
 3Q2BIGUC8FPbwEzi+v83cGiQugJRWePairbhf7FA4UQiv2mm1K8R469QwypLgm5wvB+Q
 kwB15ns7J0KBlQ/aDTLUS/y21udrbIdtI50J86UIY7MoAwiXGnXh6HM/a+7IphGC7Om/
 xTdirHT3PpTG0azQksFAi+5aRzdvH2aIm7F1hxVppSyoSx25solBB9Q2mBaePC8VivAY
 910k2LPBMa6XX9MHS7NO5pYi5OC104wYndW508SjDBA9tlPGAsFKyimGZgORp8mUG9OU
 pkjA==
X-Gm-Message-State: AOJu0YzAawsqNvA743J/l3bVgrFRPXKzp2yINyR4thtJkbYAxIrm/lM6
 cmlOu5Rh0Jth3MvbO5GzoNHvmb3tVZCrUHp6epkvGsCKtetxXItW268dk24Mwc0Nt6p11LRUgvN
 8OlI3LQKrdPuK
X-Gm-Gg: Acq92OFlGlnivfqIucEVAvkGyjlwGSxHDO8sHrfh7gLeJsD8bLb18zBtyEXXjbkxw3M
 Os8b0ZPgDKsw6T6BfYj9zKmyINd/I6Wws4OME60YF9VXZmJ4buwybXk9G/nm+NhIgAmpRf35Z4l
 LsKyapY6trTgvjQahSF5GBF67q8Q6PkewdYQuXRh/iU5Pb0KTlxWz6KnyOLGUI7gIF2r8TZwCHL
 zYGK86O9qlBTCVObLwrsrb+t/DLrqvkSzh06BM7Gyyfg5da+wmMu16ll7etRd/0kNAAp4h8Qp9A
 Wf+4rYZLFC0xi/AUxzfYCq3JCTo4c3Ni4aM7z1rqBA7FRJLw38Yd8FEtYRqqdg4FQvl0OuidHxZ
 yfsPintoLqqteZU1r8ig5IjQAPPqOgi4oNTk3X0AHHvuVsyJYQ9YPUSfXZXQHbIWxg2Xn7jnc6r
 xwcJ7Ttc9nubi+wQq8lkcmL83MJevuYTZ+NDjPhjliGWR7li1pBYsanLI7QrT1AIhGgwEjmcrqZ
 oqV
X-Received: by 2002:a05:600c:8681:b0:490:b07:5f27 with SMTP id
 5b1f17b1804b1-490428cc2d7mr254746045e9.24.1779862940967; 
 Tue, 26 May 2026 23:22:20 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4907e6a60c4sm15599035e9.1.2026.05.26.23.22.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 23:22:20 -0700 (PDT)
Message-ID: <4236f3aa-e3ac-4449-bd35-4265a684ada4@linaro.org>
Date: Wed, 27 May 2026 08:22:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove Yuri Benditovich bouncing email
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <ybendito@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>
References: <20260513072703.9710-1-philmd@linaro.org>
 <87y0he1vh2.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87y0he1vh2.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

On 20/5/26 07:49, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>>   Final-Recipient: rfc822; yuri.benditovich@daynix.com
>>   Action: failed
>>   Status: 5.1.1
>>   Diagnostic-Code: smtp; 550-5.1.1 The email account that you tried to reach does not exist. Please try
>>    550-5.1.1 double-checking the recipient's email address for typos or
>>    550-5.1.1 unnecessary spaces. For more information, go to
>>    550 5.1.1  https://support.google.com/mail/?p=NoSuchUser ffacd0b85a97d-45c62bf01dbsor217235f8f.7 - gsmtp
>>   Last-Attempt-Date: Wed, 13 May 2026 00:02:47 -0700 (PDT)
>>
>> Cc: Yuri Benditovich <ybendito@redhat.com>
>> Cc: Andrew Melnychenko <andrew@daynix.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   MAINTAINERS | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0790d13505c..64849c6e866 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4487,7 +4487,6 @@ F: tests/functional/x86_64/test_vfio_user_client.py
>>   EBPF:
>>   M: Jason Wang <jasowang@redhat.com>
>>   R: Andrew Melnychenko <andrew@daynix.com>
>> -R: Yuri Benditovich <yuri.benditovich@daynix.com>
>>   S: Maintained
>>   F: docs/devel/ebpf_rss.rst
>>   F: ebpf/*
> 
> Yuri posted a fix some time ago, but it fell through the cracks:
> 
>      Subject: [PATCH] MAINTAINERS: update ebpf reviewers
>      Date: Sat,  6 Dec 2025 11:33:45 +0200
>      Message-ID: <20251206093345.71031-1-ybendito@redhat.com>
>      https://lore.kernel.org/qemu-devel/20251206093345.71031-1-ybendito@redhat.com/
> 
> I'll pick it up.

No worries, I already put Yuri in my ignore list. I suppose this is the
fate of email lists workflow.

