Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDB3C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 10:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tciWe-0008Nm-GR; Tue, 28 Jan 2025 05:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tciWW-0008KB-TB
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:08:48 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tciWV-0004Q6-FC
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:08:48 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so55554155e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 02:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738058926; x=1738663726; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5AGb3SrhqyzN2/engErEyGgNTpp4AYlARHQ3rzT4VFA=;
 b=dfwaCRdnBC7xBAHbD/X54inrlKHk3RxcIihQFazooLGvl7UDYwgqWX4x1s+GSnhYlr
 npRtsFesTp6AVIo01ranX8bfA8K/BhQuSKmXyuG1tRpz26IBtQJz0RR7GeYJpGolVqCz
 Hsf249X30AVYpGVYhIyPS24Y7NbdW7jAj8UpqEa95Kxffroq8xNLIN/OPmPST8mevKcf
 eq0ESqxWqcx1G+tonWIzGJV5j/hWLnP0Dhc180jmcYKKI9A/8tWLCDpjuVdSJY45MEEO
 1HRSzgK0QLjY6lRXEGLjCXVw0xIzONusunuKopEOpWKpCCvU7E5qELJ/3Ku972aQ7j8j
 MLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738058926; x=1738663726;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5AGb3SrhqyzN2/engErEyGgNTpp4AYlARHQ3rzT4VFA=;
 b=tdqMUpm06KnvzJ1LyxpeP+qzPaRTM/Npn/qJFRqqcbodICaMog+sMXmqk10txdKyiy
 Q1nXJDSxZuHCaENVYB+LFABRnwqRuYRLWpg+yPtpqewuLSmUf8GoJ0JIzrqOifPxga/L
 DwCL/lD3ty1HNg7l3hX6lVVhVm5R0Dr97ADp/XmN1KCkxpnXdoqSiQWVbg5h6ib0u3cy
 fE4dF2TDKuqv1l65MoGqLM5qbgE3bw+R4VmvtXVC/7phAPVkphdd3Itqe0YYQm4Hla/r
 6T4aZThLpiSpw/ij2hohc+y4NDLkgquhSn7G2htgF4w/l/P8Wkr7pauAhSndcT5gddDa
 vufA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlkPHr5BniGHMZkiCh4BKHEzAgqsXwIIFkFPQpLr3zA+QJJofzmRshejOvP54aELFExGgIt5jCBME8@nongnu.org
X-Gm-Message-State: AOJu0Ywh2AfHUw5XDzMMGvbNQEQ2Eu9OzkDj4+YbMeyW4ZCBmmh9AgNB
 IteO9iq1xNcSGnv/Bl2iFkYnbhlLAKV1nwgNcXSV1RpyPQdLWMgz+x8HQs20bOM=
X-Gm-Gg: ASbGncu+25p/kngx+OXIAdVjKa2AEmOK9uMV+LYJC1FxdZLByVptzDip50Lcx1XRh9t
 fBAK6IT5rGpoYkGDqoEIfhDK2aiiClI3EoVNCerRog7LYE5bAXlWwOrAenxrxalgw1/9PkHxIsN
 x0O96zt+VruzZsS1HfpB5UeIQrQJAo7gtMXJoQcEMjJuyAX7gzywzCH0Kp6mTPatrfD/sdD9Sd8
 GV5Ted334M/jbq3cwHXQo5cKVO9cgYZC/noPj3bYyxIx+5ScH1jkqcWkskfRppJf147p9tW5nge
 haIOoMjzmKT6GHioIXqf2J/HciGpnKdjMi31lrEZNfJor0RWmngBFyDMEFk=
X-Google-Smtp-Source: AGHT+IEe9bdYOz2eEthQXmCWMBKgDEFMkTFgj/UdcEMpHwSPyKPNI/ngrbV9DWmHGaRhHB3cqcDhfA==
X-Received: by 2002:a05:600c:3b26:b0:434:a0bf:98ea with SMTP id
 5b1f17b1804b1-438913cd4a1mr372209125e9.9.1738058925920; 
 Tue, 28 Jan 2025 02:08:45 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa46esm165389875e9.1.2025.01.28.02.08.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 02:08:45 -0800 (PST)
Message-ID: <00aca9e6-95b0-47a9-86ae-dacabcafa9b4@linaro.org>
Date: Tue, 28 Jan 2025 11:08:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] target/ppc: Remove raise_exception_ra()
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <20250127102620.39159-1-philmd@linaro.org>
 <20250127102620.39159-9-philmd@linaro.org>
 <0e1dfcad-c4fb-49a5-ab8b-0a5673957e3c@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0e1dfcad-c4fb-49a5-ab8b-0a5673957e3c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 28/1/25 10:46, Harsh Prateek Bora wrote:
> 
> 
> On 1/27/25 15:56, Philippe Mathieu-Daudé wrote:
>> Introduced in commit db789c6cd33 ("ppc: Provide basic
>> raise_exception_* functions"), raise_exception_ra() has
>> never been used. Remove as dead code.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Although there are a bunch of raise_exception_err_ra calls passing
> error_code as 0, I hope removing this is fine as still unused.

I dunno about error_code=0, where I'm suspicious is raddr=0,
I'd expect raddr=GETPC(), but I haven't bothered to check yet.

> 
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> 
>> ---
>>   target/ppc/cpu.h         | 2 --
>>   target/ppc/excp_helper.c | 6 ------
>>   2 files changed, 8 deletions(-)


