Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B392BC3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 12:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0JwA-0003pO-AY; Thu, 03 Apr 2025 08:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Jw4-0003kb-5B
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 08:44:45 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Jw1-0000Kq-Tp
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 08:44:43 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so8538045e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 05:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743684279; x=1744289079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n2ohynJjnfD5DeT1HE5SEIg9+Jkq0bbN0Tyd9EntOxI=;
 b=o7ltH+Nz3tNP2k/rf9mRIn8xtAof3h0FN3xedmXhnw7KaqnO7754x6txJJGoBv6rAG
 kGBqKtJeSShRXsIq4horhgjCX1zMrHDJwsF2xtAMNslehQDn2NDarGuGS7PYl0Anhl+L
 whozF+6Po0u5A0w+rscfv6jKxCrkuHrahvL4Mx8ui29kO1otQxIsazjqJJ7fYmoz3FGV
 U7D+PBrrPabGuq0Vm4k2BdmaTe9ytY4H4w2l2lUCCLIXj95z5btFbyCZhGG0o1IdNX/F
 n7rwHL8C8/i0cwbSW7R/qlePhbhow3yLf2DF1YYg0qdTJ2vOlFPB8ULlB6lagfVbOWHl
 vqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743684279; x=1744289079;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n2ohynJjnfD5DeT1HE5SEIg9+Jkq0bbN0Tyd9EntOxI=;
 b=oibmw0noAxXXtnj5IT9gSV2Hsm7nPAN7VQNn8czSR4c6+d9oQ2+h4A3HHA3DPy/k57
 9Higsx/AxD8yyugFJ44odR+Ohjk5aFQRnZOEvi2psu8L50SkXWlJ+IJlaMDcWAaPsknt
 l0vl+OaW0KiBbDKKkQC/F+nMXtpzDHQtg0ZAjnejDLmG9tBmIc6AbumrpEdbsZBOVAFM
 WIeRbVM6ZZD7sI6LqbHPkpwfA2h5q6P/LkuJm/unuU41A24I5mYlTObi67Mz8mhu5Esg
 7DlYlFurrTdvmssAKeb9t7RqCNVX7sXD3z+orID8Mm/84i6P5GHmlE7YRe4BndUas+6e
 T9kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVjLo4BNwqwTz+bYG27eN79v0Pd0uErJKuWH6utjPRbSbqaWAvF226i3uFzZ8kRq3Iiie41fDOrq6W@nongnu.org
X-Gm-Message-State: AOJu0YxCoDWRXsKpPPG3OcY38YmeDVVl1p5VnOiQSHphh4UbZVHNfMPG
 nlrRbjbaoCahBiuRT2GelebyLkrOAFTXGgcf9p4CxZ32Yi8odatLVyQwuC6aaGA=
X-Gm-Gg: ASbGncsSSZ+Wn0fn9xB84gndHWqj9JnbJsVWvOAvKQgQ/yAMDmgpLFRaJqbuFtzG+ky
 d2iS3TSbgRGgu5gp2Qbd/NZrqUtVqlxAow5i6Pg1dd34S0Qv4pjuW1lvAFh7c4TFodlEi0hPho0
 XhNYxm5q24DP5FGFdsTqO2/8iIPLz/RpS3rooNKebbwWxJQe/C+zRv5/uEHSL1v/DXx/6e8b2sy
 pcLCvH28t6EWrM/cvkegD++ZCC7Ghr3SxEkySTEX26c/FIvzKqWyea1MoDvF26NU5XBU1kTEV4e
 mU+r7wc2vNfvZ6f4isZ0myolMeBZvowwHc8HL+GtdA36qQjMVpkpjo+HNjI9d5RJrEtMDmULG9o
 kJTz6MNBXqQHGSZ2WMg==
X-Google-Smtp-Source: AGHT+IFi+MxMQ+kjXKcs0F0juB2ynhdNy1rzmHCReIbLQt+GuPpPoc3gYPRdYOOUAzWVZ71u8Lip3w==
X-Received: by 2002:a05:600c:1d1a:b0:43d:fa59:be39 with SMTP id
 5b1f17b1804b1-43ec14e7168mr22806635e9.33.1743684278744; 
 Thu, 03 Apr 2025 05:44:38 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d62fsm1722586f8f.79.2025.04.03.05.44.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 05:44:38 -0700 (PDT)
Message-ID: <5f5e6140-d8d9-4cbc-9510-098bfddb661c@linaro.org>
Date: Thu, 3 Apr 2025 14:44:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.0] hw/vmapple: Allow running QTest framework on
 macOS
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
References: <20250401090607.36375-1-philmd@linaro.org> <87msd0f27g.fsf@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87msd0f27g.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 1/4/25 15:20, Fabiano Rosas wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> First, the VMapple machine only works with the ARM 'host' CPU
>> type, which isn't accepted for QTest:
>>
>>    $ qemu-system-aarch64 -M vmapple -accel qtest
>>    qemu-system-aarch64: The 'host' CPU type can only be used with KVM or HVF
>>
>> Second, the QTest framework expects machines to be createable
>> without specifying optional arguments, however the VMapple
>> machine requires few of them:
>>
>>    $ qemu-system-aarch64 -M vmapple -accel qtest
>>    qemu-system-aarch64: No firmware specified
>>
>>    $ qemu-system-aarch64 -M vmapple -accel qtest -bios /dev/null
>>    qemu-system-aarch64: No AUX device. Please specify one as pflash drive.
>>
>> Restrict some code path to QTest so we can at least run check-qtest,
>> otherwise we get:
> 
> Or add vmapple as an exception in qtest_cb_for_every_machine():
> 
>      for (i = 0; machines[i].name != NULL; i++) {
>          /* Ignore machines that cannot be used for qtests */
>          if (!strncmp("xenfv", machines[i].name, 5) ||
>              g_str_equal("xenpv", machines[i].name) ||
>              g_str_equal("xenpvh", machines[i].name) ||
>              g_str_equal("nitro-enclave", machines[i].name)) {
>              continue;
>          }
>          ...
>      }

Oh, I was not aware of qtest_cb_for_every_machine(), thanks!

