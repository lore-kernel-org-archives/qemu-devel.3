Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174C4CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 22:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v44rl-0007De-49; Wed, 01 Oct 2025 18:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v44rh-00074H-6h
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 18:00:01 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v44rT-00070f-TS
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 18:00:00 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b609a32a9b6so199760a12.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 14:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759355978; x=1759960778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A7HsVqIFGQ4un/fC+NSS+74utCb+e2GrdAWlNpu/pLQ=;
 b=G7mV+9FhHvA8Tz8BXF8aIZkAsU93gy1syxzhzgF1qwvXjG6ccA6D36hUJgvv/R7+bm
 pMLkkmr9FPiEMfV/bm5aCGCe+WKQQhitSAuEQbPokV7LQ3IPkZUJ40AzQNIwVcsLc/mw
 IsN0pGuUk2HoUQfgajMWOJ6llUFfz4wDOxJd1JuUNTBTzgRsEM2uYLxHmHE5XC/AQomQ
 cVSdv51H9F2jXv76PX76sdSHPA0EWHgAB5+mJxzfK6Cs+/TX4LDtkO2kDsxgEENYV0HY
 ZV0Nap4lC2CEx3JHBdZp3PqH70W6D9otZmAitkgYQ75+6P4NP2Xo3XGws41D0+WtwCAy
 Xt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759355978; x=1759960778;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A7HsVqIFGQ4un/fC+NSS+74utCb+e2GrdAWlNpu/pLQ=;
 b=N2gas+ekbFnd68XV3eVn19PLXNrIlF1n2w9t5JrfMYsz3CzjqheGPq54na9bweDk7N
 7Uo+TPxEmu5jsOKDS1ncYBK3jmXSEf4evA0HDl1FbgpW9ryFtE9xgQ6IQR8zmTu6XM7J
 99biPzrLvhzscaC3o5aC5/yzHjoJARMNeehXFHrZ1lBOlo+3vh5LJPbVxC0ybBNDQ4eo
 xwxQF+4TLM7ldBPvJ+RUH3WEg07agMBnEEidkszogGXplVdUUTKHUUzgC5l6BpNAB6hQ
 B6SM+c6TSOvM7IvnPgekHniR/qMdsTdj95sTr26XixgQ+G4d6x463V1A6FoKlb30Ynrf
 9k9w==
X-Gm-Message-State: AOJu0Yynk89C2ITg+tIf7vXEZk6WN0AOpDtJOTNYeYgMf7k3z0Jn9+uU
 4dVEswc04TTo89lvkEUgHsA3K//tXAOG8lPDOH5jvTBjOtknT7RSBERzrzp/WgxotWs=
X-Gm-Gg: ASbGncvvEdOAmkSQm2MeMOZZo1Vuifb35u3DpxZ6pwn8gz4esCMFqVlbUata5iJoy5o
 vmgnCUBQeqHwTQ4BSBsiwt8h4tQe43rTMo3AE6/ThNnBFRQJfc2Zlwx6FtEpypGMeA+PfjCWRXk
 lXn7kGDIjBGdy0Ltra5YdSMC0qIGYYmYOKZeQq3N62HuKw+sXCXrpfyzzuolFV0KiWKJ3bEhZTs
 bYBAYINBzfv817n34TeEOCpiS+cWIafXkh9hvzRxqdTGyhK10nGFivIx2yFbwUMWL8ThOJ+pPY6
 f5E3jxN4GvRDaqTx/fBZBbZ1M3ynXobQFD3vlJqt5T6QhBN9OP7Nq88ZfnJcUt1A77unPYN+RMP
 WgidaWqG3mY4hjRGz6uzZzVR0o2BN3tqb0ya2VuIiGf/R15R2j9RX21WfhLE6
X-Google-Smtp-Source: AGHT+IE4dvjkijQeHqSDFBGwW52rULdL2YQWBfpfH/WZvS+UP1QBiR5QjZEIjz7d98yazFbnu59J8w==
X-Received: by 2002:a17:902:ce02:b0:267:776b:a315 with SMTP id
 d9443c01a7336-28e7f32ffa9mr59534775ad.32.1759355978170; 
 Wed, 01 Oct 2025 14:59:38 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d126ae6sm6075295ad.42.2025.10.01.14.59.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 14:59:37 -0700 (PDT)
Message-ID: <98ec5131-8468-4484-800d-36439c6b5ae9@linaro.org>
Date: Wed, 1 Oct 2025 14:59:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] system: Don't leak CPU AddressSpaces
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250929144228.1994037-1-peter.maydell@linaro.org>
 <1c567b4a-4966-4374-8851-81c9b1393d8a@linaro.org> <aN2fKu6wfPSQx05S@x1.local>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <aN2fKu6wfPSQx05S@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 14:37, Peter Xu wrote:
> I only have a very preliminary understanding on this, so please bare with
> me if I'll make silly mistakes...
> 
> I was expecting QEMU provides both the global view (address_space_memory),
> and the per-vcpu view.

My hypothesis is that separate views for each cpu doesn't make sense.

In the true symmetric multiprocessor case, which is the vast majority of everything we 
emulate in QEMU, each processor has the exact same view(s).

In the rare asymmetric multiprocessor case, of which we have a few, we have a couple of 
clusters and within each cluster all cpus share the exact same view(s).

Thus access to address spaces on a per-cpu basis makes sense, but allocating them on a 
per-cpu basis does not.

> We have another question to ask besides this design discussion: Peter's
> series here solidly fixes a memory leak that can easily reproduce with
> x86_64 + KVM on cpu hotplugs.
> 
> Should we still merge it first considering it didn't change how we manage
> per-vcpu address spaces, but only fixing it?  Then anything like a big
> overhaul can happen on top too.

Sure, I'm happy with that.  I just wanted to raise the related problem that we encountered 
over this past week.



r~

