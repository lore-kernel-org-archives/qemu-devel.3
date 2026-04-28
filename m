Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B67CFF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 05:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHbTI-00058R-8T; Tue, 28 Apr 2026 01:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbTE-000557-66
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 01:58:56 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHbTC-0004Dh-Le
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 01:58:55 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d74086e5bso10386758f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 22:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777355933; x=1777960733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wp6/+swH8UtlBUJwoZipXsUqU7m6hWS6O+3Lv6wC/ak=;
 b=TjQsZflf8PKigTVjIodI1rmPqqRzzyUG2TjE0dxya/S+BH9nNPrlJcrYdwYjXz3iFn
 HXkY/uLX/a+qe0XjojBgHJ+G3sNTBlzqGs5dSojSbdaHl8odqPZAWjmC+DqVcEfCGuPd
 eywwkpVnk84UAIUuzAcCj4fUzMZBuAsXe/XiudlsUqW+i0YhEGPI1gsQB9A4WRaZmYC7
 Sr0e4gpreL4x8qGonDmqnSPK3Rd5NWQCwI52q1aqqADAPsP51taUdC1yUEWhUMXFeZmL
 B01dp4K7ZGCAiBVVRwkW3o/5RFeR6+5Ky6Uex0PQlky0Bblb8xZRU+inecvB40fz/Fv5
 wTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777355933; x=1777960733;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wp6/+swH8UtlBUJwoZipXsUqU7m6hWS6O+3Lv6wC/ak=;
 b=EcRvUkR/3YtDs9FGq2QPwaNs5wUGmjMdFw39v7KUELFv9jEcNabVS+cknOqiKP45Q7
 ATC2oY2f6K6rGx0lHdn6akgM/RdJ9c2nm8gUv8dhvUMoFnuNKINp4Q3Bwrc4BZkPA4Xn
 vt9rVrwz+kwVZMSMMD1LS8J6E0Rixa8QFsefuBK42VwASom2Tfjg9mUTX8VfahghffRF
 mswr4GFi+W9xFVsxQrTXDGDuRsFgQpA9VlRl6k3CGIkEF1o14+I9Lo20TspNVZJZCwql
 ABxs9QwNWhITg53SRn2GgdtjfS0NRAf6hTs++Q/311hHxmyC9s4x+/HKlfgSH2WvTlpH
 h7UQ==
X-Gm-Message-State: AOJu0YwuYC8/2UarNPTHAmSasBqvkSEQCKeYxSQVTVtGvLyiEmqJDYy9
 RbfBEsWZmldxk0W9yHDqYmnVRudWrxlerT6U/DtFqGBsxtE8Jorxo57WEq0wvs2PDLc=
X-Gm-Gg: AeBDiesJ7UEQPBQhuSBoIeTCSucjF/1V5w+xWYZ6MpQhluwfNX62hyPvSNIJFfnW4p1
 Nx85VicA/R0VAFDi9jUzxbWrb+/vCRa4dbnkgQVoi1Ks9llTX4zboYy6gCATzl0VbZo2addmQFz
 EOw4HsEJwYPaNq5DypTcT+eSfbqeN/YKT+uxo/RxeVrAAW1tvH263Vah5WZwPubrUEPFabZeWib
 3rurotLhlWIE+jTkC7WrRwaCZSl7TlyLpzTKoaN0nfpv3gZTfKb7YKBhJ0s/JUo+xUmfZJQ0qMg
 KQLxPijiL7B8iQA/dWqaNP/4yar2v/RqfC+qr5qem6OWewpqA2djAZcxepiScdBZcwoSj4g/Lfk
 Muw6S21EUfZnmianIkvItil/fgnHiNIIH39mQKUVvLo/f64KuLM8kapxnJ0sddF3haF7SuC3q3c
 9bECJ9ixZBhwXVunZR0vTjlx6umGihToniv/+cq/4zeRpYoR87xC2IvBXxGMK7YOkcGyn2Gtbag
 OuB
X-Received: by 2002:a05:6000:18a6:b0:43b:5672:efe with SMTP id
 ffacd0b85a97d-4464761b872mr2913035f8f.9.1777355932794; 
 Mon, 27 Apr 2026 22:58:52 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d02f6a1sm3650099f8f.13.2026.04.27.22.58.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 22:58:52 -0700 (PDT)
Message-ID: <0c46bcf1-5d33-4c6c-a849-7b47a104844d@linaro.org>
Date: Tue, 28 Apr 2026 07:58:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/display/cirrus_vga: Fix packed-24 color-expansion
 ops
Content-Language: en-US
To: Junjie Cao <junjie.cao@intel.com>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, balaton@eik.bme.hu,
 chad@jablonski.xyz
References: <20260410183249.4046456-1-peter.maydell@linaro.org>
 <20260428101211.3469935-1-junjie.cao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260428101211.3469935-1-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 28/4/26 12:12, Junjie Cao wrote:
> On Fri, 10 Apr 2026 19:32:47 +0100, Peter Maydell wrote:
>> Big disclaimer on this: I have no guest images that try to use the
>> Cirrus bitblt handling at all, so I have only developed these against
>> the reference manual and confirmed that it fixes the UB repro case
>> from the bug. If anybody does have test images for these that would be
>> good to test...
> 
> Confirmed: the qtest reproducer from the linked issue fires on
> unpatched master and is clean with both patches applied.  I also
> fuzz-tested the patched cirrus-vga (generic-fuzz, ASan + UBSan,
> 20 workers, ~47M executions / 8 hours) with no new issues.

Thank you Junjie :)

> 
> I have reviewed both patches and they look correct to me.
> 
> Junjie


