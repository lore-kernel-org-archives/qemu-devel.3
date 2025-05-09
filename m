Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7EFC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 08:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDJ08-0007vL-8J; Fri, 09 May 2025 04:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uDJ05-0007uy-Lb
 for qemu-devel@nongnu.org; Fri, 09 May 2025 04:22:33 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uDJ01-0003Dt-QQ
 for qemu-devel@nongnu.org; Fri, 09 May 2025 04:22:33 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7418e182864so1161425b3a.1
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 01:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746778945; x=1747383745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PP8Q+vpS5DGj9SOuvrBN1XF0O6NFK79uubYBtAi9hV0=;
 b=ThpfO1Qz/oADhtVf6Ku50LD9BDv7RW2gylV6UE1/P7NK6L2/9gJBhBh9n87/ifhGaw
 xFEJqtmmJpLmmY9Nhn382xC0X6iYnxFGsn4w2qB1xFxmCoNZLj7VzO3b17k0vr07uzBa
 asWhiV3NJVBbB4djaMokwffFvisx2V/NKz5+JoFpe6ledme4EJ8pAvr/Bv/ijteeS5Wc
 Is4np8I48eXtFUI9rBDikW8TvsY//DDI6qq7FtWL4tKZfVgLlgm+brbJDOBZ1uXOAjot
 443Kq9xAelhYSxeE2YZtzV/haifLytRXtDCnOsyYLBqPcPAZmR916anY4/pQqIrO9qCu
 76hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746778945; x=1747383745;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PP8Q+vpS5DGj9SOuvrBN1XF0O6NFK79uubYBtAi9hV0=;
 b=hvl1orai1i6NMdLpDXH6e40/IibcCRO2WQv2+tUtDoKPl4svpsAawfHl3wrUTm+dFT
 5GmVsqXmSBHXfcLzTFXUZtIT76EA4oSwrndVb7AYQhOwpYri2bLoC69EdDmOLVqA+NEA
 fAa+lNVqvCCorBYiluXdHZ+VUWKBwWu1s1VuD39Hnz4g0erO8yfNXhJ9cXqRHSxkKg1X
 u10XiQWCIwta7Y516uJvoBL/FI5zWRnbJbsJAOkLkEZ7+vsGzAUz5FH2XRxwuOdD9RDf
 ZM/O6AHgGi1zSiMolofiOeNvv165Ps5J4Ag5WSvERfjmK7VQVp/llLmM+5xfQ+cDDyTp
 85mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoL7WhMgp3QptZCXpa3fLm2q5U+Q/gYmEkorDZnWRrTiAUaAmy+dDxVXdDggehK0vd6Prt03Q5bdyL@nongnu.org
X-Gm-Message-State: AOJu0YzKkdgfIiTEoT/VANXIWtdc2SK9Zg34KPmhXR7BqmipqHbTN9WM
 NQCOI1c1l+5LeaE9bwWVXpZKQ+HoN95ZMydTXQxIli1w2e2o5F/xpdhjLFOeYmc=
X-Gm-Gg: ASbGncvUHibEoti4znYYKv1kghsJJLxDGpa0Ed6McoWi4VI6OM4pY+56HiIxmmdofc8
 n8j3tMnbcV3Fm4vFTCJl6RaqwpEuqBOUCemhxTVoStLTuGb/tNvKEUHzZ4aR/EUzpT/Q7dwAA9W
 0XJD+Jdl3LBgzZMgHry9Lcbcm4D2WMBV5ZwE/BVlMjc7yo2Cl86lx7Q24Z214C7PRPTILaZmCPi
 anBnZTinfsRPD73Df9C41xXmLITWuIroG31RZd9tizWeC4HOgK8aKA2X7vVj6yPLwVCAb9aRRCm
 5+GqLJAcAafai2NbzQJpJotYRyJNyczQAR2WaHHTfa/JAF9tkDn3cfvH2++Q/ioTFQV52vJaH8b
 OUUANGYXCy05kGM6ghNI=
X-Google-Smtp-Source: AGHT+IGUcN5mJ4S6NF/lCTkqL/3MJ9RatqnOsBh0jTrzm8sDE4ilP0aI+nVbGXs0NtS0DuE51qaLOA==
X-Received: by 2002:a05:6a00:9286:b0:740:596b:4a7f with SMTP id
 d2e1a72fcca58-7423bfe1d0emr3212655b3a.16.1746778944950; 
 Fri, 09 May 2025 01:22:24 -0700 (PDT)
Received: from [192.168.69.243] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a8f520sm1265678b3a.172.2025.05.09.01.22.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 01:22:24 -0700 (PDT)
Message-ID: <d55583c6-8366-4ec1-b657-73ed050f04c2@linaro.org>
Date: Fri, 9 May 2025 10:22:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Use -no-shutdown in the hppa_seabios
 test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250508180918.228757-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250508180918.228757-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42d.google.com
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

On 8/5/25 20:09, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> qemu-system-hppa shuts down automatically when the BIOS is
> unable to boot from any device. So this test currently fails
> occasionally when QEMU already quit, but the test still
> expected it to be around (e.g. to shut it down cleanly).
> Adding a "-no-shutdown" seems to make it reliable.
> While we're at it, also remove the stray "self.machine" in
> there that does not have any purpose.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/test_hppa_seabios.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/functional/test_hppa_seabios.py b/tests/functional/test_hppa_seabios.py
> index a44d1a3eebe..661b2464e13 100755
> --- a/tests/functional/test_hppa_seabios.py
> +++ b/tests/functional/test_hppa_seabios.py
> @@ -17,9 +17,9 @@ class HppaSeabios(QemuSystemTest):
>       def boot_seabios(self):
>           mach = self.machine
>           bits = self.MACH_BITS[mach]
> +        self.vm.add_args('-no-shutdown')
>           self.vm.set_console()
>           self.vm.launch()
> -        self.machine

Oops, thanks =)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


