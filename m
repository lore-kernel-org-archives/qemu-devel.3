Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53274C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZs7T-0007ej-Aj; Fri, 02 Aug 2024 09:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZs7P-0007Ro-Og
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:14:52 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZs7L-00051N-FA
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:14:50 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-428ec6c190eso2112445e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722604483; x=1723209283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f3Ig9qrNqS796eTen6yC/TdSkvMI/5+1PaGFCTS3GZw=;
 b=wUq4Jz1pzBmEXhn3H1LiLVu6P7lkE1N1ZNUObpl6Gon4CjpP5sabWm5/GOgIZiLXje
 P8LBcQmHG2fUAJTgGtOolA4wWMF+sC//4FgKueot2WqCr2QNDvHqtWYgwlBavPWON+Py
 iGEZpm4BWIfL9Nq4hXxTv5+r37pVxrSwZOQFTHaI6fhIMYAHstNXqfKa8y7FMOflh/hD
 b+X2DrWCte+daERIj3jL+8tOR1hM+IQimg0tXZXMGlEHqPQT2VzmKqiBVFndnHfsJ/x1
 1FF5SZb+q7WOGsomoAXFBTPXqyTDEHu1dV+d9LVUI06PX4zlFY617ohHnhF1v9l/RcVC
 aFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722604483; x=1723209283;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f3Ig9qrNqS796eTen6yC/TdSkvMI/5+1PaGFCTS3GZw=;
 b=kYNm1TAetTu4CFsjf4/eoIs5gQF2o+CV6bDIM7ebJIyFrZ828liqjNu8ly78ZaSg5p
 LqzSSdXj2iLb1EU5IAbgUCQx4u4nPXI2HDMKIU+oF7GJNZiXWpgSfJrU65a4kToF4+7B
 Jbu+Jd25UMdHaj+Pbej08MwbpK5f9YaZojnq2Sdi6hANGr2quuuy4RlrBeM9jqzhuIsg
 /rm8ckdtMutX5QbeCSVHMKkBDFwJKpGnB+IQc+cNnN2AEbiwqNexE3J91M3YJXvmmsoP
 SGp1qAyxQax61V2p/TsCoL/FE3q4FJcCJ3ZhEFdedlOW/Wn/yZZ2TupOnwTJPClm9mUv
 H6mg==
X-Gm-Message-State: AOJu0Yzzx7GCUN/Izm30FgS9pdhhrMT7ZYJdgJuC507e/MS9tCdJiopk
 lf7tfOYzSfzSEyinY+dAtlv1TNdVgGNykXuLsppmnS01IASFirzNS+lsFuhlL98=
X-Google-Smtp-Source: AGHT+IFJ5Jrfc3nemcN+4XkWnV3Ou5dWwp24s/GYXu+YmOcgrmVE6SAsu4lL4UQAOfp1KYf9z5Vqvw==
X-Received: by 2002:a05:600c:4f8d:b0:427:b995:5bd0 with SMTP id
 5b1f17b1804b1-428e6b7c5a4mr23302515e9.23.1722604482796; 
 Fri, 02 Aug 2024 06:14:42 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.94])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e11356sm32059165e9.19.2024.08.02.06.14.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 06:14:41 -0700 (PDT)
Message-ID: <6874940a-8a89-476d-a8ac-b6622aafe7c6@linaro.org>
Date: Fri, 2 Aug 2024 15:14:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] tests/avocado/kvm_xen_guest.py: cope with asset RW
 requirements
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>
References: <20231208190911.102879-1-crosa@redhat.com>
 <20231208190911.102879-7-crosa@redhat.com>
 <20efca0c-982c-4962-8e0c-ea4959557a5e@linaro.org>
 <CA+bd_6K5S9yrD6hsBsTmW4+eJpPsquE8Ud9eHZzptUwDrHcpeQ@mail.gmail.com>
 <a3b0ebf6-47ca-4aad-9489-16458ffd6ff3@linaro.org>
 <CA+bd_6LmuOdQ8ZdLjwt+MCusjQ8ROv23d9PXoF-Ku3j4j73wsg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CA+bd_6LmuOdQ8ZdLjwt+MCusjQ8ROv23d9PXoF-Ku3j4j73wsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/8/24 17:17, Cleber Rosa wrote:
> On Thu, Aug 1, 2024 at 8:57 AM Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>> I agree those files should not be modified, but I wonder if you
>>> thought about any solution to this? Given that the same user writes
>>> (downloads) those files, do you think setting file permissions between
>>> the download and the use of the files should be done?
>>
>> We want to share a cachedir on development hosts with multiple
>> developers. OK to alter a downloaded file before adding it to
>> the cache; but then once a file is added/hashed it shouldn't be
>> modified IMO.
>>
> 
> I was asking more in terms of what to do before/after the test.  When
> it comes to this type of setup, Avocado's cache was designed to
> support this use case.  You can provide multiple cache dirs in the
> configuration, and some (the first ones, ideally) can be RO (life NFS
> mounts).
> 
> But this is hardly something that can be configured without proper
> user input, so this is not present in the generic "make
> check-avocado".
> 
>> So far this directory is group=RW but we like the ability to track
>> a read-only directory (like owned by a particular user) and adding
>> missing assets to current user cachedir, to avoid duplication of
>> files and waste of network transfer.
>>
> 
> That can be done in avocado.conf, something like:
> 
> [datadir.paths]
> cache_dirs = ['/path/that/is/ro/because/owned/by/someone/else',
> '/home/cleber/avocado/data/cache']
> 
> The asset library will take care of trying to find assets in the RO
> directories, while writing to the RW ones.

Great, thanks!


