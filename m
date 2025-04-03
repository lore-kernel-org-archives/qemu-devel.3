Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6890C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 18:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0OsT-0003m5-Cn; Thu, 03 Apr 2025 14:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u0Ort-0003QQ-Ub
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 14:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u0Orr-0006AP-5W
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 14:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743703240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tDhXga8I+eW/Cyg6XZ6X7k/EkQpsb8wB/HingNiAwaM=;
 b=KK3IGbldhDioMDE2jYDJS0LuzXn11BrR00KHD3kxjFXGHzYuDDbqvGQfAC4fX6G48Dh5v3
 phnMWIBDfjRfTBInZ8I5THLvbTIIyZH4pOZ7c8BhIZA8WypCK+7DGMnZfMdEzYIXqoKOeJ
 kowaCqktvXgNu6WK74prI75AjOlLmXY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-59AORO9tPIi7zN_tm4VLKg-1; Thu, 03 Apr 2025 14:00:37 -0400
X-MC-Unique: 59AORO9tPIi7zN_tm4VLKg-1
X-Mimecast-MFC-AGG-ID: 59AORO9tPIi7zN_tm4VLKg_1743703236
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912b54611dso771805f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 11:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743703236; x=1744308036;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tDhXga8I+eW/Cyg6XZ6X7k/EkQpsb8wB/HingNiAwaM=;
 b=d49UGifn+CrhTr1gLnYITLLtawdTBDdp1mgyJ9ETqgVBfTEt/qRoJeC7ercmWaZm6f
 KPGzwySqg/pfFGZr+vcUalx8G8KL6FjBWl5/Em4nHE2tJ6nbcWU3yFfcPN+M3AYsjgVa
 0+IAcTaXQGjKqeesWrNwvlMMtEk24JxdH9Eo+JZ6FP4FOT2F18w/57X/+5FOLFdH6/Vr
 tkutzBqgP434MAPpKDKDl+8e/W57zle5I5USbftTp+ph7pXOYgQMnX/zp4GbdgLwa0wb
 uP3OALfamQMuHuTsdgblzmC9LtR92vDuNsO9kD+wLph54xXNgfekg1JN19bqTsZ2Hpd4
 11Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfs10upKMSRVnF96gMJa68MUG2ldHUkPZy4cHnKarlNmO2EnOgF7X4SeJwAEG+y3tW2d30eb0S1bRK@nongnu.org
X-Gm-Message-State: AOJu0Yy2+jUrGiMh66uzy7XnoHCRLOTftzZ6LjTxJXbCg+44zKCN2gqP
 A84l+IM0KiWkKqW/jAYneTZmcCaNAHeKdaRedpQ9HddJTie0L+GhQl8+9tDn8VzC8iIlToVQJBW
 S819Ldb8alhKbMZEKFaijWRIMW5A0OQ9vp/wAMutyejAJnJw/eg/7
X-Gm-Gg: ASbGnctutYv0XZ0i0ktp2VxcGsPGnT4JhLLbzAv2Vdf6VaIhpTpvQOK3DeRgcXigYwA
 DAYzVuW4iXErBVECwWKK17jNAPrxRA5HMwTCvZwlTSF1uKjr7rj+TjSu8AWvHofUBkO9S18HVNU
 MyMAlQbAmVtDjjXyUWvf18I8naVPV4T6Bc4Fuy/VLXTvItxlya7uvzoK3nNj5kyz6ddSN8B/1XG
 iWn5U8wiuWwtAfGYQV7ekVKly5pvOB+/z4su2A80+ebVui39uBNeTObUr8kNCupVLay0WqiJ7Ye
 0VzE2g3kDcB4BTve+/dywsAxf40hdpz4Z7JUMl9MnwjP
X-Received: by 2002:a05:6000:1acb:b0:390:f6aa:4e7c with SMTP id
 ffacd0b85a97d-39cba93534emr210756f8f.28.1743703236566; 
 Thu, 03 Apr 2025 11:00:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7qVT3JKr2cqd/7LysPSGmIymxSbpXL0i9rRBvpGZ/0B6ghb/HJkGUFBTE+ZB+ozjE87szxg==
X-Received: by 2002:a05:6000:1acb:b0:390:f6aa:4e7c with SMTP id
 ffacd0b85a97d-39cba93534emr210718f8f.28.1743703236189; 
 Thu, 03 Apr 2025 11:00:36 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-76.web.vodafone.de. [109.42.51.76])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301ba2dfsm2396422f8f.60.2025.04.03.11.00.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 11:00:35 -0700 (PDT)
Message-ID: <4bd6f358-3de7-44f9-9cf2-7c2086a87fca@redhat.com>
Date: Thu, 3 Apr 2025 20:00:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 v2 04/14] tests/qtest: Skip Aarch64 VMapple
 machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Udo Steinberg <udo@hypervisor.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>
References: <20250403151829.44858-1-philmd@linaro.org>
 <20250403151829.44858-5-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250403151829.44858-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 03/04/2025 17.18, Philippe Mathieu-Daudé wrote:
> First, the VMapple machine only works with the ARM 'host' CPU
> type, which isn't accepted for QTest:
> 
>    $ qemu-system-aarch64 -M vmapple -accel qtest
>    qemu-system-aarch64: The 'host' CPU type can only be used with KVM or HVF
> 
> Second, the QTest framework expects machines to be createable
> without specifying optional arguments, however the VMapple
> machine requires few of them:
> 
>    $ qemu-system-aarch64 -M vmapple -accel qtest
>    qemu-system-aarch64: No firmware specified
> 
>    $ qemu-system-aarch64 -M vmapple -accel qtest -bios /dev/null
>    qemu-system-aarch64: No AUX device. Please specify one as pflash drive.
> 
> Restrict this machine with QTest so we can at least run check-qtest,
> otherwise we get:
> 
>    $ make check-qtest-aarch64
>    qemu-system-aarch64: The 'host' CPU type can only be used with KVM or HVF
>    Broken pipe
>    ../tests/qtest/libqtest.c:199: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
>    ...
>     7/26 qemu:qtest+qtest-aarch64 / qtest-aarch64/test-hmp     ERROR      24.71s   killed by signal 6 SIGABRT
>     2/26 qemu:qtest+qtest-aarch64 / qtest-aarch64/qom-test     ERROR      71.23s   killed by signal 6 SIGABRT
> 
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/qtest/libqtest.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 2750067861e..fad307d125a 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -1788,6 +1788,7 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
>           if (!strncmp("xenfv", machines[i].name, 5) ||
>               g_str_equal("xenpv", machines[i].name) ||
>               g_str_equal("xenpvh", machines[i].name) ||
> +            g_str_equal("vmapple", machines[i].name) ||
>               g_str_equal("nitro-enclave", machines[i].name)) {
>               continue;
>           }

Reviewed-by: Thomas Huth <thuth@redhat.com>


