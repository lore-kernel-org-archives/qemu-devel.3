Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37445C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu4Q0-0002Tn-S9; Wed, 12 Aug 2026 04:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wu4Py-0002TW-S9
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:34:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wu4Pw-0005ij-44
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 04:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786523638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PAriZ0b2AnlO0TmkwJIU1ZeCGi1wH1KIonsquKKcxqw=;
 b=DSs88ntzoyy8Jgb5vR66Y+1rYQ53wMlaTeAAisdJmYn9qWOr0LXyO0CUxW6S7jUeB4tg7D
 H1KR6y7c0aZUalwXoSerIP6ud0nyrWS+cQVrGfZEmDh5pvLBTT+dUwkb//gZu3mNn3kjCa
 c8Ye9wPdEeqcdsM1OlQJ7rmI7BBiYQo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-KHg0Oi8bMIWQZK8vDxRSYw-1; Wed, 12 Aug 2026 04:33:57 -0400
X-MC-Unique: KHg0Oi8bMIWQZK8vDxRSYw-1
X-Mimecast-MFC-AGG-ID: KHg0Oi8bMIWQZK8vDxRSYw_1786523636
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-495529a93f9so7569865e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 01:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786523636; x=1787128436; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PAriZ0b2AnlO0TmkwJIU1ZeCGi1wH1KIonsquKKcxqw=;
 b=KRHUxys8h4EHHdyRhPRiOjzHVwT1L8D44t2jjDlyfvW0iRTxvakjVzxZE5yErfdVuO
 kn/D3UzYRW/HbMwBpiizYTEzQnOv3fgQnjRqx+fduZh2WLGATi9BjAx4P6jpvtiQ7GGP
 Y3OnXPCQdCx9vHbAQykuSHZXd7nQyWGrnd4nEX81BMvbjUOY62mqC5FEYBz0CX16tzJC
 OeaZttysXntJJ2mNVJyW8tYGMTwZ/ULYoEECMo1a43n6INFjY7yWMeRFmKH7iabQAE0b
 nRx3ThPPWK1w5PeI76tXD1XSn6sywihSTCPqYwsxDA6BzLIvbasOuajgrUvYEd9qj5cE
 uEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786523636; x=1787128436;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PAriZ0b2AnlO0TmkwJIU1ZeCGi1wH1KIonsquKKcxqw=;
 b=i1GOzDwxYiGL5sF5ExKDWoLqTlj07c/sSW1wlbilBwDou3xB/ep5jEHc8Jc6ftcyoM
 H7X3avfm3ruagg2Eorm6kWnoBYbvKaW3vbXdu9J+hfkiArESiEOW1n2xNcocWiPYqpfN
 V7tKESqQYHw+1FLfc5okUlKhOH4YnHoZOiawrMJ9fNolY3CPJUva/vVur9qCOLWDiZZy
 XiT4TFuVtP5vg89H3y7IpiYttIegF6MByeYL+qUdcARJKZR8kvBo+6qYFOwyTeMnqzG5
 3vOTNsvp346n+bbpaKwcSvz9def7Hl1eTI/2truNt92CY1lZpdXxXjVWE35N3TuuoHFZ
 /+ww==
X-Forwarded-Encrypted: i=1;
 AHgh+RrK1L4++N2Ul/xjAGDi2ezzttWEJeQ/nr7381UEHXoN7ObpDocF26e6DRfKwbXjnclQ7UqfEVmM5L3h@nongnu.org
X-Gm-Message-State: AOJu0YzZeS38lVh1qorpcBmzwFPBOBEVfGh9Lq6KBE2TPPsyLPDFCOtf
 iu7m2a0i/qfXcs1CQutqirJmWJuVCiCLUezaxl8l70YikgaIoTMXmYnuQ6HodRf2jnbIpx/XcJf
 sacrYz8x9F4bc9R1OdCXIxUV0C9gU3u47xOC8l7fPVyx3mhMkTr3mKhrP
X-Gm-Gg: AR+sD11H1SwEdaf2ZxPIy2G8rhVoO98tuOTB4NJ4/3jpBoTBb8WkZeVh25P47bvLbtz
 tp4vFmNc4eRpPfqUKNfi9PkCX/WTmSClBbxj008hIpwOBG9kfVlb5Li6W9V/uEcgWMaHoNCKHtX
 kY3f+8whg0NBYpb22dGimcWOROpNtIPlaP+Ha3aLay7AqJ/RBjnW0aJk4ImZC9Dbe9Z1tKFLOlo
 vsalx53PRJvZ28DL1J7TjoR4qVr0yCQz1JsEzgwioO496ieymbvRZIE5xhwOpEUIfG780l3SF/s
 yEAWXvAJpiYzJktfNOafsTpbvfcpuXFQze4xYPkcSUNT21560lLvkF1NjQRzW6y7ljM6pq7C
X-Received: by 2002:a7b:cb8b:0:b0:499:726c:50e with SMTP id
 5b1f17b1804b1-4997c118a17mr28324165e9.14.1786523635762; 
 Wed, 12 Aug 2026 01:33:55 -0700 (PDT)
X-Received: by 2002:a7b:cb8b:0:b0:499:726c:50e with SMTP id
 5b1f17b1804b1-4997c118a17mr28323675e9.14.1786523635380; 
 Wed, 12 Aug 2026 01:33:55 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.27]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c946ce1sm28570255e9.5.2026.08.12.01.33.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 01:33:54 -0700 (PDT)
Message-ID: <1c83a42a-0579-4606-89aa-ee1df66ed309@redhat.com>
Date: Wed, 12 Aug 2026 10:33:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Do not use versioned pc-q35-5.2 machine
 anymore
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260811183144.190135-1-stefanha@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260811183144.190135-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/08/2026 20.31, Stefan Hajnoczi wrote:
> As of QEMU v11.1.0, the v5.2.0 machines are not usable anymore.
> 
> Use the latest x86 q35 machine instead, otherwise we get:
> 
>    $ qemu-system-x86_64 -M pc-q35-5.2
>    qemu-system-x86_64: unsupported machine type: "pc-q35-5.2"
>    Use -machine help to list supported machines
> 
> See commit a35f8577a07 ("include/hw: add macros for deprecation
> & removal of versioned machines") and f59ee044067 ("include/hw/boards:
> cope with dev/rc versions in deprecation checks") for explanation
> on automatically removed versioned machines.
> 
> This commit message is taken from commit 9eef3854d309 ("tests/qtest: Do
> not use versioned pc-q35-5.0 machine anymore") by Philippe Mathieu-Daudé
> <philmd@linaro.org>.
> 
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   tests/qtest/fuzz-virtio-scsi-test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/fuzz-virtio-scsi-test.c b/tests/qtest/fuzz-virtio-scsi-test.c
> index e37b48b2cc1..102a5ccb67e 100644
> --- a/tests/qtest/fuzz-virtio-scsi-test.c
> +++ b/tests/qtest/fuzz-virtio-scsi-test.c
> @@ -19,7 +19,7 @@ static void test_mmio_oob_from_memory_region_cache(void)
>   {
>       QTestState *s;
>   
> -    s = qtest_init("-M pc-q35-5.2 -m 512M "
> +    s = qtest_init("-M q35 -m 512M "
>                      "-device virtio-scsi,num_queues=8,addr=03.0 ");
>   
>       qtest_outl(s, 0xcf8, 0x80001811);

I wonder whether we should rather remove the test completely instead? Those 
tests based on the fuzzers rely on a certain way of doing their MMIO - if a 
newer machine type has a slightly different MMIO layout, the test basically 
does not test anything useful anymore. WDYT?

  Thomas


