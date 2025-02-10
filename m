Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D45C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 11:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thSDT-0007Rc-82; Mon, 10 Feb 2025 06:44:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thSDL-0007PL-5o
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 06:44:36 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thSDJ-0007JV-8f
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 06:44:34 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43946b5920cso3933455e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 03:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739187871; x=1739792671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fq/MaIf7u/qe/AJ/loUwx22EaMeIBHXoGSZ8t/jl0vE=;
 b=voBNaGoI/iQp4Z3NN01n02SGFDlWNDm5Usjfqjz6UHP4CgDIds2TQBDHANYJderM9j
 sYA/lHtRzAqLzOajIppE00Mkx2CfCxGo+zsFiR/sDT0AO+ZkmKkxJ+P8TY+Q1pNGSMGy
 63dXZe0ZmFp8+vor0ulCBPlFlJ+NHqTdzDalzQ1gTl6kYzRD84sUq3zC8hZe2CflFU3e
 2dzqXA3vXaxc7bkEAc2Uw02jK2ooax2jnopy6iLbA11hPR6ozxMONm3m2yrGQssLH8NB
 B7NvVN39elbsvAeUhk6aED2hf/Jc5DEqNkrZNqEMhieJ8amTdYhyphBtSqIB+pH/HPpH
 rb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739187871; x=1739792671;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fq/MaIf7u/qe/AJ/loUwx22EaMeIBHXoGSZ8t/jl0vE=;
 b=HcmzqcrG91KgnGKE5EJ0v+Is1Y/aqVtz5hRBqs7gjA0UeJTfeQicODGTUUsD2KztsO
 45N3+ktfpLB2wMRdjI4GqXYfeCIkOgtvosmNI624wSQVhvg4c5t4KqcsIdK014kC/Oyf
 Xpnmej3NtRC1oF4hxuTFNY92ODLfKk/wDhp+lnwcJNDtDYC/t3fSs9YlfgafcWGC9wm7
 VZf8ne2JKO1Mz4CpmmexDBLV0Q6mjPEdwSe1DppvX3mLBsOSFr7FY8qwOizgB6X+g4VB
 4tPfgILjTLH4my/0iQIu4u3QDUxGwwAgyqvwvi//r84v5pg+isjTsY2ReQkBQdAisFFM
 SolA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsUTYQCS8tQVUM2j7DKgjG0HkIqAeMQgjuY6XMBPge7CAgn5RGbl2a6E5ONHckkkmlEfEf0h68pN6T@nongnu.org
X-Gm-Message-State: AOJu0YwmnvQqhC+49KjvCFpzZtnCk1VofKCwaINdG6RtCp+8k6I4dDXl
 6kNTKbOvO7hJiIv9SzliR+cXJuxPUcV17PH+FKIF5N5XIk8xQf8y7118b7FDGS0=
X-Gm-Gg: ASbGncuIZDJ/vFpnTbVHAcBoudG216IgGXE2ZqwHzAPaNPilSZNIQYim//Vj8eQtnTj
 Q9nOaXtUElzqhnrp3tmzdt05bT1MvKfCSbrlbDfW4sf8LUeQLp4XbkvVMo9lxzJUU1kXWQk9Jho
 UWa8Iauns6LB9AE0t0Pv4QGdc51U1xWqgxZdAb+iRrlfpUT6g6wemqnVxUtN2rRWjes9ciywMLa
 ota16iww6KmvfLfp0fwAVVQ9nmedSOlu1ng+9Vr5Sa4h1yEmVxasFSrcmWO53lNKALsiLNDslvr
 Sy7XvnUDnZGIvyNu0pwRtAk0oDlOwHHhi3nR20UFgvEt2/bCZ4wFAQDBo4pJ20Zs
X-Google-Smtp-Source: AGHT+IHclkkc3V1Mg7e2WiJByU7kP3k3KyklXr7mUmYWGpg/YqefGj2aiF3N2JbFWF3KvylssktNow==
X-Received: by 2002:a05:600c:3b20:b0:438:d9f1:f5cc with SMTP id
 5b1f17b1804b1-43924988c67mr103224345e9.8.1739187871478; 
 Mon, 10 Feb 2025 03:44:31 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390db11750sm181978405e9.40.2025.02.10.03.44.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 03:44:31 -0800 (PST)
Message-ID: <f0518994-e7f2-4341-add5-5265329603ef@linaro.org>
Date: Mon, 10 Feb 2025 12:44:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Remove unused blk_op_is_blocked()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org
References: <20250206165331.379033-1-kwolf@redhat.com>
 <b46b9348-0f28-4714-8b39-13cf2e62a649@linaro.org>
 <Z6UfKeso5lackAKq@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z6UfKeso5lackAKq@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 6/2/25 21:44, Kevin Wolf wrote:
> Am 06.02.2025 um 18:25 hat Philippe Mathieu-Daudé geschrieben:
>> On 6/2/25 17:53, Kevin Wolf wrote:
>>> Commit fc4e394b28 removed the last caller of blk_op_is_blocked(). Remove
>>> the now unused function.
>>
>> fatal: ambiguous argument 'fc4e394b28': unknown revision or path not in the
>> working tree.
>>
>> Is there a patch on the list?
> 
> It's in my pending pull request (which I hope to go through - otherwise
> I'll have to update the commit ID here). This is the patch:
> 
> https://patchew.org/QEMU/20250203182529.269066-1-stefanha@redhat.com/

OK! Then:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


