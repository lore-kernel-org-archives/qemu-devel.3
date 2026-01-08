Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E97CF6ABC
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 09:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdmmF-000850-JM; Thu, 08 Jan 2026 04:57:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdmmE-00084r-RJ
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:57:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdmmD-0004AV-AL
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767866276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8ozBYcaTQh+M3nATsqJ5ysW/UgDVM7knZ+0JKV686JA=;
 b=KvMSFI0PZiSEQd+7Sj+Z6n8Esv8Xt7dO9bwxsVIS+wWRYiKrrNmjJnpDHjld3rbvnz4gdH
 6FvW4bRQDs59iAljnYnuoUUclXyw+LQX6JDE0RImczWHL7DLz1ktuSOiA96gdKQVty8P9Q
 VgN1/GnxMg7U2OkKHPEPK3TjEBDVd58=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-Bt2vuW3IN_WOChOnaRjYcA-1; Thu, 08 Jan 2026 04:57:55 -0500
X-MC-Unique: Bt2vuW3IN_WOChOnaRjYcA-1
X-Mimecast-MFC-AGG-ID: Bt2vuW3IN_WOChOnaRjYcA_1767866274
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-432c05971c6so1255948f8f.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 01:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767866274; x=1768471074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8ozBYcaTQh+M3nATsqJ5ysW/UgDVM7knZ+0JKV686JA=;
 b=CJ5npvBms9v4/afnpjm8QvfU7dijsJcJ1qbd3jlRqM2Qs3mCzrumIHuxrZA+0/KjxG
 G5u/Bg65tL0nYPXgHlsdaWxy+t4wowHAJjRqxWorXf+tH4fZBx8qOBeKgSUX0jKd1YQd
 DkmAI1ZdpFrCshrxlpdPmxFhjnEBkK6Zn+libzuR8GUSI3TZq9uKD5kDHZUQ+e6sIB+D
 onqCpfJsKHrERddrS+XjjGnwG7q6iaHPWFfji0a4byO+Q4NrVKmb/Pnsna0mIouTIYyw
 ckHTLutJ9lBcbABsQpHnlNF7uql/vaaBFGIWBghW9/4q+AKXs1yzpUyN2dVRV2d/3piy
 GBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767866274; x=1768471074;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8ozBYcaTQh+M3nATsqJ5ysW/UgDVM7knZ+0JKV686JA=;
 b=G5wYceQSBb0CoJ4XN+K9jYPt6rBm32/014njX3W8jNdyfG7ZynjcYfCWf43EcvqzFf
 kCmGAVg2hHez4v+7NBjS8wKBI/SPG4b5Eu2n9gu/OVOAWlENpL3ncH4J61b/HCaweOxU
 bHH8AYEV2M53puze0fXI2kRSl3DJ9gEvIsiIuh4odF4ZFg9rw5+0D2rW7K0G1TSusAsy
 B8vVjzr96wHosGB+WYRRUPlq9VUrGvFv/ekj29z1cMcWt2IOxnqbVXuaZBT3I9nZjcaF
 W/XHHA1DY3IDZ8HZ0DK8FR7CAHKFvR2xBcTXWragLJ2ioOHoBjX4mwfzI1zFw0XrbMUL
 4Xzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQIwIf6GXN1s1cyH1XAyDNA9OOHRFNJ876qjvOM04VYJ16965Sbmpua+1uy6n1yCoL1pcpeoVzsfjl@nongnu.org
X-Gm-Message-State: AOJu0YzZM4W5TC4fXdzt2VcxG63BWWBEwJ1wXrPsvRfw6jWO/QpDicU2
 xZXbfbdcZn5e8kxjO2R+AfRQMnZc3E/A9OXg/dW5rsyYkY8sA3CtW1OwidTx9eCLIhc/foUJHmk
 /ug5YFjlApcQ03WgkP/DSMjvM2la0MvgMNRRghGk9l0ZCdMeHdavTm1n+qTV4L9EH
X-Gm-Gg: AY/fxX7NMTbBsFrReDODSdWn0cPQdBNLwWJCiaru60MdOVn+LMDWGA+57RA8FIUAPCs
 4Aiy3JgZQzunXbCAXvoASFaQX9j+dFnQ6rDdGULcMb5ubGOhoGkevMicUaTeTN53PxHpjrdoHh9
 4luniIL7D80xkwbDDQESjJ9ev4t1VzQr9/YaYhnKL81GmmKAbd/xCAz2yBDAYBvXkAFlCohcPvh
 XotWIxID88NDXDTcUYmVmGWliCfGnO3PtaqxCRGM7PexMxIrLBuTL83wkepiKTcguJ+T2YneFoD
 CjyUS8/7py8XV/AUDHCnx0kplmwp1rxy9ERs0CQE5z339NwDmN14N9PObICwj5VjgUuODlIVDQG
 hbGjAeHY=
X-Received: by 2002:a05:6000:a88:b0:432:c0b8:ee42 with SMTP id
 ffacd0b85a97d-432c0b8ef25mr7659577f8f.11.1767866273706; 
 Thu, 08 Jan 2026 01:57:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtEd+ifRilVsRx0W6T2oQvlVN1olr45AiFkLf/Tv8TNGKYjp2DMfki1haE9JXFHPgHjW9lxA==
X-Received: by 2002:a05:6000:a88:b0:432:c0b8:ee42 with SMTP id
 ffacd0b85a97d-432c0b8ef25mr7659565f8f.11.1767866273341; 
 Thu, 08 Jan 2026 01:57:53 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e180csm15162616f8f.10.2026.01.08.01.57.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 01:57:53 -0800 (PST)
Message-ID: <3b2fba2c-456c-4c8e-9f8f-3aa63aa9a0af@redhat.com>
Date: Thu, 8 Jan 2026 10:57:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/50] *: Remove i386 host support
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-7-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260108053018.626690-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 08/01/2026 06.29, Richard Henderson wrote:
> Move the files from host/include/i386 to host/include/x86_64,
> replacing the stub headers that redirected to i386.
> 
> Remove linux-user/include/host/i386.
> Remove common-user/host/i386.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/i386/host/cpuinfo.h            |  41 ------
>   host/include/i386/host/crypto/aes-round.h   | 152 -------------------
>   host/include/i386/host/crypto/clmul.h       |  29 ----
>   host/include/x86_64/host/cpuinfo.h          |  42 +++++-
>   host/include/x86_64/host/crypto/aes-round.h | 153 +++++++++++++++++++-
>   host/include/x86_64/host/crypto/clmul.h     |  30 +++-
>   linux-user/include/host/i386/host-signal.h  |  38 -----
>   common-user/host/i386/safe-syscall.inc.S    | 127 ----------------
>   host/include/i386/host/bufferiszero.c.inc   | 125 ----------------
>   host/include/x86_64/host/bufferiszero.c.inc | 126 +++++++++++++++-
>   10 files changed, 347 insertions(+), 516 deletions(-)
>   delete mode 100644 host/include/i386/host/cpuinfo.h
>   delete mode 100644 host/include/i386/host/crypto/aes-round.h
>   delete mode 100644 host/include/i386/host/crypto/clmul.h
>   delete mode 100644 linux-user/include/host/i386/host-signal.h
>   delete mode 100644 common-user/host/i386/safe-syscall.inc.S
>   delete mode 100644 host/include/i386/host/bufferiszero.c.inc

Reviewed-by: Thomas Huth <thuth@redhat.com>


