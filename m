Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FACCD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 12:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOx8G-0003ke-HB; Mon, 18 May 2026 08:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOx80-0003hN-MR
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:31:37 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOx7w-00049O-DW
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:31:23 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-45ae6a0e523so1058617f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 05:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779107463; x=1779712263; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o9dCBHREVN4FOUkZ7TOOiDnBqojjUMpj/VFwISRHQ94=;
 b=pyhKWZw01tbH+FbfgP/gmM7TiMGYpfTm2gMXvZ62qSWUn/P9fm0YMq0KNSXihaFeIl
 u2adrskv4tpERrPJvq9tIkX192+yPfFC7B5gKw55T9wwI1gcUcc/DDg1SoyLogsBXLA+
 ygUsUmVJq8BVC5a/8TvBvvMLwkMP40p3WYyS+smdz526LbYUJnIljzpOCERVDH/zwToo
 D0ENIdZ4T96Ssn0AOD9ElfeQva4kcVfa7G7gUKBYPU/TKz9Xtz62LdUJ5rB6PFauiQ/T
 BpNUuk8PsfCBCTH6QxV4kMSeJqxLdDlHZ1K9rQkR+/iB/jV77fEx1cIHwoXJbCZ0v5GN
 FYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779107463; x=1779712263;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o9dCBHREVN4FOUkZ7TOOiDnBqojjUMpj/VFwISRHQ94=;
 b=ctI9jGkht83zTMpbvUUgm9dmtllRc6e7uFUBze7kWjkROGiHyr/YcYSp9jGR8Ru8RF
 /aMmoiksuFt+At+UIGsVeiPGRj/Kuh8eIooruGls9KfgP69XUe8fZSUEG2iedXruMFO/
 gLX02Zb4u6fF/syHnglRi/5xQWjTOh9FWljYsJ+54RKTNPqisVMSsY03yeSI5dHcpqi1
 5aK5JFUUHWaa4Dnzgf88hV+Gm9Jupp6FK/qDPwOg3BADgPTBZVj48XhG9NQbVrW5ZUbM
 MOiiIZS6Q4ZCeOQC9DyGTMCHWVx7LQxyWNHR7bO38gvZABSmdte3Kto23dwy4E72YKF3
 SaEw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8jihKr/pzxFLLP5QDz0cWXlnDR+4ldUfneVRih7qhy54LxJCCJWm3OQS6J4GLuo0ATNyDE1EQI/ZNq@nongnu.org
X-Gm-Message-State: AOJu0Yx63xIQHmExrWzhjb1wFvAP3KhHcRjfbQ8qpjCQUN/wHiscdU55
 6rixIGLs2HoDkmQe2Ch3vUh7t4vsgX75BRQck297BZ8TJVvbOFfGnn0Syq0E/RDhG5g=
X-Gm-Gg: Acq92OHmDrpjPTCNYWTKEeps6gL95c5Qv40jIb+0bV2YJkKPC+6idN7CpwnQrDOZKvV
 ajTRVfQoGawxzVcHRC9Wyae1YUyOz04HW1QlkFtHHVVXIXExnq3cPWknSzYIZmH8vo9z0B+zof7
 1nu3zhNYx4BxptUUCMqfj23VTfIVqWkSI0Iaysh7NB8fMvAZriQ5T5BnPyvc8bBgCVZ3ODi8XNf
 Wk8jf0aGUfoPHqljkmMGK7dzA+Hf7bHLS+lgp+BRBdCiY428OaE1/9B+PkR0xeMbHnwY26SM4Kh
 qjKLIkwfPi9aiEZEGmebqWAr7/hVrU166/5m6mtZ9X8EEuS3EBUHHdoPEvr6RdcnccVhW6NhoGs
 NfjiqhIdj2smUCTKQ0gECubXuzdZUmW0K+gqfyjtA8PQEd1I8W9A1PC/M28iVi8G0DT5HUPNH07
 vpP8TyIIukWKEsocBdntQIR8YXH+pde1vSRMapdKUESEQccwhjl7iUguwxcDvNdZ2F3w==
X-Received: by 2002:a5d:5d82:0:b0:45c:1c89:b1c6 with SMTP id
 ffacd0b85a97d-45e5c5952e7mr24788660f8f.33.1779107462934; 
 Mon, 18 May 2026 05:31:02 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec39806sm36236632f8f.9.2026.05.18.05.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 05:31:02 -0700 (PDT)
Message-ID: <eae9fbe5-a09a-40a0-b299-d0039fcbfab8@linaro.org>
Date: Mon, 18 May 2026 14:31:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/vl: Free allocate memory for pid file name in case
 realpath() failed
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: f.ebner@proxmox.com, qemu-trivial@nongnu.org,
 Qemu-block <qemu-block@nongnu.org>
References: <20260515143854.2010741-1-thuth@redhat.com>
 <1aec7543-ea5a-482c-a42e-fb1cdb0e7498@linaro.org>
 <b6cc3aa4-6c32-4ebf-90f9-efb7f2a9b897@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b6cc3aa4-6c32-4ebf-90f9-efb7f2a9b897@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 18/5/26 13:50, Thomas Huth wrote:
> On 16/05/2026 12.13, Philippe Mathieu-Daudé wrote:
>> On 15/5/26 16:38, Thomas Huth wrote:
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> In case realpath() fails, the code returns early in the function
>>> qemu_maybe_daemonize(), without freeing the allocated memory. Add
>>> a g_free() here to fix it.
>>>
>>> Fixes: dee2a4d4d2f ("vl: defuse PID file path resolve error")
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   system/vl.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/system/vl.c b/system/vl.c
>>> index d2f4044e5d8..7e2ed898240 100644
>>> --- a/system/vl.c
>>> +++ b/system/vl.c
>>> @@ -2670,6 +2670,7 @@ static void qemu_maybe_daemonize(const char 
>>> *pid_file)
>>>                   warn_report("not removing PID file on exit: cannot 
>>> resolve PID "
>>>                               "file path: %s: %s", pid_file, 
>>> strerror(errno));
>>>               }
>>> +            g_free(pid_file_realpath);
>>>               return;
>>>           }
>>
>> Don't we also need to release the other paths?
>>
>>   - qemu_unlink_pidfile()
>>   - pid_file_init()
>>   - pid_file_cleanup()
> 
> Adding it to qemu_unlink_pidfile() makes sense here (though QEMU is 
> terminating anyway afterwards, some malloc sanitizers might complain 
> otherwise), so I sent a v2 for this.
> 
> pid_file_init() and pid_file_cleanup() is in the storage daemon, so this 
> is a separate problem (the variable just has the same name there). Not 
> sure whether it's worth the effort to free the memory there, too, since 
> the code exits afterwards anyway, and the pointer is kept 'til the end?

OK, fine!

> 
>   Thomas
> 
> 


