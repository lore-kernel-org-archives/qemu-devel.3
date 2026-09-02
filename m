Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B441C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 05:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1dsD-0003ET-IH; Wed, 02 Sep 2026 01:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1dsC-0003BS-22
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 01:51:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1dsA-0001Ln-E9
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 01:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788328257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kk2tXehgSG/d8iUkFzhXDdKyOW1F5AgE0XCmtjv96Qs=;
 b=NtcoEVhuLgUaX7DuDX6b9/6DI22PDFA+liwSX7o8PilcSxKRXMZb8HRlximpI2CsRg30pq
 H3QZ+Gz2RgGJ0dApGhMlEw4Z3UIXNLqd0C/OP5YN+lD1y5FusUnrXCQbwxstNJiDZeeHGZ
 y1gEG/W02XNzYmMOUrAf4gZdsWw56iY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-27yhhv_5PMCEReNEW92-EQ-1; Wed, 02 Sept 2026 01:50:54 -0400
X-MC-Unique: 27yhhv_5PMCEReNEW92-EQ-1
X-Mimecast-MFC-AGG-ID: 27yhhv_5PMCEReNEW92-EQ_1788328253
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-499b99a8a10so12806585e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 22:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788328253; x=1788933053; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:references:cc:to:subject:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kk2tXehgSG/d8iUkFzhXDdKyOW1F5AgE0XCmtjv96Qs=;
 b=H5bdkaAagp5gF7L/tgEox4rivSoIAVsvYn4DeFkR4qn1Z143+5mxy4eKyHV+nftwEw
 7BibaFEq15U6lsz6ked5uiROYehH8uVHbmAMMukseNiiFCozRu63lD5VI9Zt+otEJ6mV
 dG8a2G/SBpKS1BADvSMFzYnOcxNBWCq0v1K4lJ4VCdL6u+ym0gVCz0PVZASPgXTY73Ti
 mIe0yxa+iw+vaqhOT3G/BBuf/q6o74XZJJf52uxUcHP25IMEURRK7SsmykaOOvz8oHCQ
 gYqckkw4yuNNRdk7yU7ZolbtXnY47Vnwd9tqrpK781n2PV1rxCVoK4TYPWf8UYuQAVzz
 2rFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788328253; x=1788933053;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:references:cc:to:subject:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kk2tXehgSG/d8iUkFzhXDdKyOW1F5AgE0XCmtjv96Qs=;
 b=lPohoVMZs3tFvsxZOMZafT2dZZ5yxHNv9EyApyupYjw0M3NZ7dY+GNfQT61d+nzKlQ
 Abt7H1t2AyFYUN/lHZKEafBcvoyhll1d4jmjVqZFMAlzMBRUr0bVu4bOh7Y3I/oOfyrt
 SK0tfiOMiibJCbJjX08BXxLqQw/OAdR6qpt3WX4EHHfJg9tlPl5X50sP2D5T8Z0Otova
 CoaU0tGCsBD82uJm4KKQfoLDfP+vS5DC3UTJbs02ImsDHxTaNibcAzoC0QvkWsFRSSZJ
 0qo3i5c4ymV6FJDcarkCkdmjZgbKMNAvZKfYJCO1dMQ77hr5VouXAy9WrfI0mA45FdK+
 KVrw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpWAnLHCumJGgqU0hPseQ4tUsLXheyiXxCWdT4uVWkm17dg/zGgv8RATpngW2Tagb+icgnNdNZkzkQ4@nongnu.org
X-Gm-Message-State: AFuF++n4lJNmyiDrkDsu1hsrv9XzTUDK9r8eGVACjnCcTcAJt0UGYHBI
 faYsVA4K8NCeIO2mL4Osb12qED6W40Ifc/OX+KyxE/kHVdsIMhXHCVRWfCSa2qigdXxqlOJab+r
 FBlQSrO9KiqD4t7q2nMUGGm4CpThlydkYBrfoERTiwbhMFjxvH8FbHjXu
X-Gm-Gg: AR+sD13RfdLip9n7yq6ckB2OOqo93eTsh6KF6aLm1eqVWXnUtJuAYw1ZHxXKmy0vvgW
 GyoLTWcUBEPm2YmbdHSz8uBHsTtJQTLISG4+jEivN5hHiDCct6s5+3sHQtc4yiQ71ZLweJDcw4P
 L346elyr7B1mt4OYfa+HAvdxsKh0eLjWrJfMslxAiDSCtL46ZslYrbU7evcYXYDbsB5hjBcTD46
 mj9XDoJZLBvhMAoIw2ti8+TxYCFnP2xUdsUXs628bN6j18ptz2tzPgAhnKK+d3JPwhSD1xcIWUa
 GhmC50KZ08xQg9qjz1axgw3TRp/W2WLU6lJnc2ctSu9rbnNJX1MgVXw+JAKlB7JV5pJVnF/LW/1
 8/mFV8nIcP9ZojR0h1unfukK/vlKQEH7G0+Nt0Y0=
X-Received: by 2002:a05:600c:4f87:b0:499:59fd:dbfc with SMTP id
 5b1f17b1804b1-49ce7bb7823mr8892535e9.1.1788328253246; 
 Tue, 01 Sep 2026 22:50:53 -0700 (PDT)
X-Received: by 2002:a05:600c:4f87:b0:499:59fd:dbfc with SMTP id
 5b1f17b1804b1-49ce7bb7823mr8892265e9.1.1788328252866; 
 Tue, 01 Sep 2026 22:50:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4?
 ([2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce44ea9sm115442565e9.14.2026.09.01.22.50.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 22:50:52 -0700 (PDT)
Message-ID: <be0b34b8-21b5-4584-8ab8-1d9f09399cbc@redhat.com>
Date: Wed, 2 Sep 2026 07:50:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH v2 16/25] tests/functional: aspeed: optionally check the
 device tree model on boot
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Emmanuel Blot <eblot@meta.com>
References: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
 <20260731-sanmiguel-bmc-locator-v2-16-1266926ba769@free.fr>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-16-1266926ba769@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 7/31/26 12:45, Emmanuel Blot wrote:
> Add an optional 'dt_model' argument to do_test_arm_aspeed_openbmc().
> When
> provided, the helper also waits for the kernel's "Machine model: ..."
> line,
> letting a test confirm the booted image actually matches the expected
> board
> device tree rather than only the SoC revision.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   tests/functional/aspeed.py | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
> index 076da1036c..08af6b4839 100644
> --- a/tests/functional/aspeed.py
> +++ b/tests/functional/aspeed.py
> @@ -8,7 +8,8 @@
>   class AspeedTest(LinuxKernelTest):
>   
>       def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
> -                                   cpu_id='0x0', soc='AST2500 rev A1'):
> +                                   cpu_id='0x0', soc='AST2500 rev A1',
> +                                   dt_model=None):
>           self.set_machine(machine)
>           self.vm.set_console()
>           self.vm.add_args('-drive', f'file={image},if=mtd,format=raw',
> @@ -19,6 +20,8 @@ def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
>           self.wait_for_console_pattern('## Loading kernel from FIT Image')
>           self.wait_for_console_pattern('Starting kernel ...')
>           self.wait_for_console_pattern(f'Booting Linux on physical CPU {cpu_id}')
> +        if dt_model:
> +            self.wait_for_console_pattern(f'Machine model: {dt_model}')
>           self.wait_for_console_pattern(f'ASPEED {soc}')
>           self.wait_for_console_pattern('/init as init process')
>           self.wait_for_boot_complete()
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


