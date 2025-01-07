Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259B1E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 11:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV7Mk-0004gJ-Kl; Tue, 07 Jan 2025 06:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV7Mj-0004fo-5r
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:03:17 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV7Mh-0007XC-EW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:03:16 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso95201745e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 03:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736247793; x=1736852593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jmVz6/MdTnR4ugxw3O4sk6hmLbf8CpPtFnplNuen3sc=;
 b=DgAY4x9Ak4zXWtLhrPrFNR31/jAE6Q30d0FY5G/kXO575TCT0XxcmTVV0lyF5f0XMz
 0xW8xpNCg4J8Y7E/sBa3endeS/P6uU4FPKVf8SEVMDjvZ0AQbG6+dhBA4ryH4oSPBrtO
 gsId014dmczyjT220eQhcKZyu6zvoM3q3fy1fmeS4V7UC/0bnLdH/OcQVQgU5QdSquG9
 E8KnDvviHp7Dt6nBx3mnLYIS/ztl5tXl8AyKLIHohc5InNSZvF1bLxJQ79EC48kcMiUz
 Sopa8ifyLTYQDaCsH0MEddwsvegeByvFTIQ63hdkbc9WJOODTPcXhzVjgQSnfnero3u5
 7p0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736247793; x=1736852593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jmVz6/MdTnR4ugxw3O4sk6hmLbf8CpPtFnplNuen3sc=;
 b=GVXEy+kNEFPyVp6lLF6idXtwGUBoLXlgxpGDTilLVb25pi51vKJTg4MqdngNTfBlP9
 KJgIWBlziKOl5vQwohDfbshcOxUCNbKdmQRNXsTDJkAmVWJsyqYENl6EqDyyvhEK/XYk
 XtXM9enoSBBtZLG/kAgZlewA8O8jFjDml+XNhg9OhMsY9pKy2+o/8eYysjcAU27hwV76
 C649ttiEgwKCpK59Id6sxClnGwO3xXgb+85CYJdaFXJrTVT9M3R6fFlVH/PML5rvFnuQ
 AiHBKmBahZguLwSRqVY6b9vxeLb3QDxd+tBxXhAjhSBcyCprqEifxnqnxOxppBBt5pHL
 7QqQ==
X-Gm-Message-State: AOJu0Yz0qpLV2C2LZcr9cyg26c5743peXQAZW+uCji17C0bkVUgqEyAr
 MBMFhA+8wLkFhbcldNSX8qbYFbhM0dnpEoaizCSLwSGuZSSqf1iUUZEVAEnLv7Y=
X-Gm-Gg: ASbGncuo3GTH95OPJcWiFKIYHoFMQ4AJ4VbPKhIYAm7bAhkPaY6TTIDA+WxQU3N20ZG
 pqoYKvewvdvWvdfVYUhSZR+KLqfIJ24fPGRsplANmrDhTLIVjOwHrXSRC8HAuw6UE+lfIvU2DYt
 ZEqskSxJoMWNroEVJnBleUr5nNKraCCq41MgCHMlZjPZlgFlHBs7JxIO56j8DTyB4bhWuEpRl1N
 wAJu7jUhqEc6RCb86/UnerIZSzx/q7XjGpJv/Q3yv5Rb0degWzu8WOThs6yfXKDUiiw4r4JDndP
 nBaWCHhbzWErADgQPEuJ8WeS
X-Google-Smtp-Source: AGHT+IFXoAHc/YlyR8pMX0UIJ/g85XHkPJDEPvJBHUzHLSEb3j+kqWelpRLOMJZFBPy/QFL2PSjdtQ==
X-Received: by 2002:a05:6000:1886:b0:386:3bde:9849 with SMTP id
 ffacd0b85a97d-38a7912c989mr2010677f8f.12.1736247793313; 
 Tue, 07 Jan 2025 03:03:13 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8acadcsm49590643f8f.105.2025.01.07.03.03.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 03:03:12 -0800 (PST)
Message-ID: <b467ee64-274d-4e69-b5b8-4b92ecbf428d@linaro.org>
Date: Tue, 7 Jan 2025 12:03:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] hw/s390x/s390-virtio-ccw: Remove the deprecated 2.4
 and 2.5 machine types
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20250103144232.520383-1-thuth@redhat.com>
 <20250103144232.520383-2-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250103144232.520383-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 3/1/25 15:42, Thomas Huth wrote:
> They are older than 6 years, so according to our machine support
> policy, they can be removed now.
> 
> This removes the requirements for the storage keys "migration-enabled"
> property which will be removed in the next patch. It also removes
> the code that sets "max_revision" to 0 for some CCW devices, but
> the relating code in virtio-ccw.c indicates that 0 could have also
> been in use for other machines types < 5.1, so further clean-up for
> code related to "max_revision" won't be done yet.

Please mention commit d55f518248f ("virtio: skip legacy support check
on machine types less than 5.1")

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/s390-virtio-ccw.c | 37 -------------------------------------
>   1 file changed, 37 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


