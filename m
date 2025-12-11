Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4B8D3E79C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 07:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTbWO-00051w-3z; Thu, 11 Dec 2025 02:55:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTbWM-00051N-3n
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 02:55:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTbWK-0006Bb-Ix
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 02:55:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765439727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rajnSTw5kEnrq1eByjiOXIBPQe8kyawfNbti4aS+f1c=;
 b=fmc7aUVmCYnwTTi1FuG4GkBqxLwHCZmdsPnd46cbhcPyJk3gU3nlcyBPDF4NTUNDe3VaqU
 eJCKlyfE1jPIZdKTqcDpsqtYfsZMna3YjgrEshF9XdPeiCxJd4rqJ2/gnDmZ8+SVlyLrlo
 8QEOIM4k4+2KupK/8H19Z0484jlJe2U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-aYY6PUUjP12YjX_Kds00Ag-1; Thu, 11 Dec 2025 02:55:25 -0500
X-MC-Unique: aYY6PUUjP12YjX_Kds00Ag-1
X-Mimecast-MFC-AGG-ID: aYY6PUUjP12YjX_Kds00Ag_1765439725
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4792bd2c290so5659555e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 23:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765439723; x=1766044523; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=rajnSTw5kEnrq1eByjiOXIBPQe8kyawfNbti4aS+f1c=;
 b=jAyDlh04Pccx8JuQv1Ns10Dp/jvhq2EygkvmxMmu58AWWsgEZEcWlWZg4vKofEwPyf
 63P8uOyA2zQiqSv7Dduu9ObjLuEdngKhonERmTCiOAA9MaaX95WaiddTg1ZXQoPRvz/g
 WrU2wf2beJUTMwPmkal3NEQ8EonaOQA/WefM9H+MvsA1DHokDoToM0qq4I5ainFgx0Mm
 tP8KXBpYCtpAtDI+LgDqWm5PeMwGxRHgXOI7DHuNQBZQygfVIFM8Amun3GDqYOsPVBvW
 t+cKMSPvbZQToVYKgTLLaZBbzaNrTqDeQqTZnJ7URrbTxSZ7eICOYs6UIJCmKKQiOfNV
 SQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765439723; x=1766044523;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rajnSTw5kEnrq1eByjiOXIBPQe8kyawfNbti4aS+f1c=;
 b=Ou1YFaIkmg7k31B3FfO4qtYTTe07FMtA6oim/Nj7N3Mqm+jg2prRL1adVW4naEuxQb
 CWl67aAD+H4gVip44N9SPpIsyKA3mElWePQ97JjPKd+AQV19ayAkCS6njvWwG/blCCas
 V2FB3cVpK+D3weKXCir7X8HMTC+tQEo59/OYFrgq4sb0eRIZy7sG4rFozOXabi/E2ATj
 ipsvgrqqV2OK1soz5pkLJpHsxaQ8mH078KMjToV+t7RSS6UrG8iAPHZuxzT402afphsv
 IKHIaNdm3i734oqWmeKPuLLbu5NspXznboXzV48JZ42p9X6U/WziYU8Kd2f7aCxUeeC3
 LoPg==
X-Gm-Message-State: AOJu0Yz09lrz99f2Sx+BKpb2xwNjZqMHEhZ3TAaT7I3oLPyIyUnTyfwN
 aYEtCArEDntH2mRG5zGbokZFTOqZWXAJkwJ6aPB/YMtiyBJmXJo4DUatZBMLw39crKORQQB8dyC
 Fh7M/CHD/C9/kWQrHylLUxs1cYXeyUoUUEkkrqKd9Dd+d0ZSHhbpGarh+OIJS8fdY53AjM6LIGJ
 qYS4eiX6gd4GNeRvCfttdndLBxz1LawUU5cw==
X-Gm-Gg: AY/fxX7gnbRYhsEY7d9HSXK1R1YMW0s2/9oJ8UA8F/FnLPk6dil5Ld2BuS0qelSindE
 obDRJZ/zA7MoagpgehqKrSZQwngf4qroflEMPJE284Af1fzEXqOF/mtCgudydpKdA3FDJ8Dgo++
 gp4GT9Pf6a5SiAuXPzb45dUYbSVfuMrgjwvJIIPULTrtATgeaYop87e+fs+guw9KnTLkE3jpFpb
 TK06QqyqlKGf4JLszYTbj6XpxiIaHlgozwjK1Xu5eyvE/07FsQjJqQY40Bg8TosJ0d5M4leuBxC
 8GDDZUnus+y2dKivZyHHBf5tU70b2q9uLkKRMDox4As1Ep+9t2xeCNM9m0/8KLJyc/ZsbPmknEG
 ssbLZFLLgIhb84AYVEhevcmIIG9hrRuYIhSIzP7wE2wKEwdes
X-Received: by 2002:a05:600c:8183:b0:477:9c73:267f with SMTP id
 5b1f17b1804b1-47a83864325mr53417355e9.33.1765439723331; 
 Wed, 10 Dec 2025 23:55:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeY63eJfjkFNO0h8sr7ILJ0CaZGWsqYdW8ehv1pOLAcSm0/rOdafFuyTk4Z7xL22pH1rUH4A==
X-Received: by 2002:a05:600c:8183:b0:477:9c73:267f with SMTP id
 5b1f17b1804b1-47a83864325mr53416995e9.33.1765439722874; 
 Wed, 10 Dec 2025 23:55:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a89f3902csm21222235e9.7.2025.12.10.23.55.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 23:55:22 -0800 (PST)
Message-ID: <39b211f4-4640-4463-a827-cf8633791eec@redhat.com>
Date: Thu, 11 Dec 2025 08:55:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/vhost-user-bridge.c: Fix const qualifier build
 errors with recent glibc
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20251210181306.926334-1-clg@redhat.com>
 <20251210181306.926334-3-clg@redhat.com>
 <be8600fa-81cd-4c30-8fd1-c0049be4c9ab@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <be8600fa-81cd-4c30-8fd1-c0049be4c9ab@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 12/10/25 19:14, Cédric Le Goater wrote:
> On 12/10/25 19:13, Cédric Le Goater wrote:
>> A recent change in glibc 2.42.9000 [1] changes the return type of
>> strstr() and other string functions to be 'const char *' when the
>> input is a 'const char *'. This breaks the build in :
>>
>> ../tests/vhost-user-bridge.c: In function ‘vubr_parse_host_port’:
>> ../tests/vhost-user-bridge.c:749:15: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>>    749 |     char *p = strchr(buf, ':');
>>        |               ^~~~~~
>>
>> Fix this by using the glib g_strsplit() routine instead of strdup().
>>
>> [1] https://sourceware.org/git/?p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690
>>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   tests/vhost-user-bridge.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> I should have added 'Not Tested' !

It seems to be going well:


$ build/tests/vhost-user-bridge -l 127.0.0.1:1234 -r 127.0.0.1:4321
ud socket: /tmp/vubr.sock (server)
local:     127.0.0.1:1234
remote:    127.0.0.1:4321
Waiting for connections on UNIX socket /tmp/vubr.sock ...
Added sock 3 for watching. max_sock: 3
Added sock 4 for watching. max_sock: 4
Waiting for data from udp backend on 127.0.0.1:1234...


C.


