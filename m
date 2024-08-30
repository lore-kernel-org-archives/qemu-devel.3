Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29501CA0FE1
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 11:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk0GU-0005Tn-Eg; Fri, 30 Aug 2024 07:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sk0GS-0005E9-Nk
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:58:04 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sk0GP-0002u0-KF
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:58:03 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-428101fa30aso15763765e9.3
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 04:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725019080; x=1725623880;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HonSDCs1dG51Vj3dbd3hEKki6Dlobzcw8NrSam1TS7I=;
 b=zubPyV84YdmCzm9MROILkxmbo3XfbOY3jchn6ohNC6Q1dwJAjK9cBXXP0H8mg4T7zk
 TRrIovxVma9uUuiNWicNAfiKzUyARQuaz0ZkUKBuQSa+ekucroY+IKgSz6ICwY2RyZIH
 ZHu6YfQRjaaJo3O9ZfEB0KAM9/9QIFv/PADJr7RVJUthuBTDmyop7W42r1PCKytHNhvZ
 IcFOYaTBx4rYbjk4hnpOIQ1lUicUrNNzdAYGy9vUEj7MIl9oPJqRwhHK2lJWjr1l77L2
 JpwGlQ8DHutIhYNJ4XhM9HgrawpQEGm15uQ9p7X99sYJN5yMTZkfsWzMo49tqmerEt3S
 LHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725019080; x=1725623880;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HonSDCs1dG51Vj3dbd3hEKki6Dlobzcw8NrSam1TS7I=;
 b=K759POSLCxuJ2QE9J9B46Wfx4KgjyuCXfa0x4JA1Mwzft+ytqt1ydraYsJW/JZLReF
 h9SWpqAzuTMCKtAN+MLS+nYOhDfs1veTuVDkihwTGwNGzUy3IlWL17hnXsZvzAcZ9XVd
 hJmI5x0UpRg0WHwVaTAw9EvukW2hjkPdaKm2Dh9qYY6H7//2WPVxPxfEcw/ljhxnZjQf
 zqwQ6UMwcrMw+aPBiPepXruq3O1G+SN1SANFxPGU2qlVXho1ydEsdQBXi+L0hWfkegH3
 GEWiRFUJdaY05VCa4aWMqd8V6ikvYdv8nEfoVGpmg7Izb/RN9iIiCcMS70WAhpxaXyTB
 ylzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXEmb+2MjBh407UZy65vkEGeJ8lD5azrAlrebV87lL/tCYWJkKj5/BdrdE6gAPZISCmBEYYJ7sdyw5@nongnu.org
X-Gm-Message-State: AOJu0YwsQ4haB2mjNwk6wOeexAQzIdLv3YDnt2MOMKyvna9zCtwqXl7m
 GptVGUz/QXHkth99wO8ZfNfAErZ06v+PbGMFmE7TsqScYh/b7gq/Opl93otLs8g=
X-Google-Smtp-Source: AGHT+IHuMb/cXpWa+1pUzXmNqP2zj1lHSaVUX+fLlRRtL9oG8Qok09qHc04w6tSyPf08ISItQv36sQ==
X-Received: by 2002:a05:600c:3596:b0:426:614b:1a72 with SMTP id
 5b1f17b1804b1-42bb0306805mr49605465e9.17.1725019079320; 
 Fri, 30 Aug 2024 04:57:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626?
 ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749efb0df8sm3823558f8f.100.2024.08.30.04.57.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Aug 2024 04:57:59 -0700 (PDT)
Message-ID: <dd28ea4f-67eb-4c42-84d2-24956cde7896@rivosinc.com>
Date: Fri, 30 Aug 2024 13:57:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qemu/osdep: handle sysconf(_SC_OPEN_MAX) return value
 == -1
To: Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240830111451.3799490-1-cleger@rivosinc.com>
 <20240830111451.3799490-3-cleger@rivosinc.com>
 <de7b12a3-7480-41b9-837a-880da9264dea@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <de7b12a3-7480-41b9-837a-880da9264dea@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 30/08/2024 13:31, Michael Tokarev wrote:
> 30.08.2024 14:14, Clément Léger wrote:
>> On some systems (MacOS for instance), sysconf(_SC_OPEN_MAX) can return
>> -1. In that case we should fallback to using the OPEN_MAX define.
>> According to "man sysconf", the OPEN_MAX define should be present and
>> provided by either unistd.h and/or limits.h so include them for that
>> purpose. For other OSes, just assume a maximum of 1024 files descriptors
>> as a fallback.
>>
>> Fixes: 4ec5ebea078e ("qemu/osdep: Move close_all_open_fds() to oslib-
>> posix")
>> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> 
>> @@ -928,6 +933,13 @@ static void qemu_close_all_open_fd_fallback(const
>> int *skip, unsigned int nskip,
>>   void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
>>   {
>>       int open_max = sysconf(_SC_OPEN_MAX);
>> +    if (open_max == -1) {
>> +#ifdef CONFIG_DARWIN
>> +        open_max = OPEN_MAX;
>> +#else
>> +        open_max = 1024;
>> +#endif
> 
> BTW, Can we PLEASE cap this to 1024 in all cases? :)
> (unrelated to this change but still).

Hi Michael,

Do you mean for all OSes or always using 1024 rather than using the
sysconf returned value ?

In any case, the code now uses close_range() or /proc/self/fd and is
handling that efficiently.

Thanks,

Clément

> 
> /mjt


