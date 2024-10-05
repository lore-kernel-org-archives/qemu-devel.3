Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA16CF887B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 10:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx1kn-0006Gn-Js; Sat, 05 Oct 2024 06:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sx1kl-0006GT-TN; Sat, 05 Oct 2024 06:11:12 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sx1kk-0000uw-8m; Sat, 05 Oct 2024 06:11:11 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37cd8a5aac9so1605371f8f.2; 
 Sat, 05 Oct 2024 03:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728123068; x=1728727868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gx7wEJPYU6nF+8R1X8Q39JtQibkyvPUdm12Li1kywDc=;
 b=E5z05KrO/4Yb9vSG96EAVABwgJLB/+egZf6QehmfK7gGtt3eeZ+YGZ4OnJS4vX4At5
 hxQ5Hf/S6kV5AryyzeYcj/1aXLZbpPVroUKUP+/c8Y8bsDtjC22d5Lg+Sp86nlb6AUtt
 NJ1PNFEfbNUUHjPDvsHX/Thczlo3lDn2TRGHZUF7KeQe+gOjtPdxzHKa883TbR59NaOX
 +zy78/LFuAEFHalk8aYF7q7IDSFCQq0Dz6vDGENrD1Xk1H+P1s9Fq9EXHy8nWmOSp4/i
 YacI2he3lqCjr3SVa0DdDKUVi6aE/4WaMag6MB0OK50iIQ/lijyRuewjQB+9krFy+biB
 ozEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728123068; x=1728727868;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gx7wEJPYU6nF+8R1X8Q39JtQibkyvPUdm12Li1kywDc=;
 b=OVCbbQlxMl6kttkoyWOjaASXp9hC9V5byg8CVyRjpWH4S6JqeM/DxnLrXpjNaSALo8
 VEtwPYCEsE5L2vBU2pZ05WiQnVR2gHsvin3hM8tuGX71j6v9huOhwAw37Pjg2t1+4I+X
 U3g0GCbBtqkN61Ay+RwihvD1jgE12DNKMSuCaPq2eEz4auTbyEnrvLcTDEk5gAF43y0y
 VtQeWjt6covRYbCYGsfzY3GAA9yGwQEO52/umYZso225nWwZjPQxvs8qHH1NV/EXPPG9
 aFQfvqqDHar3RE+13noAN1vogNeQV1mlnezZxAN1vndfC9W2fUoDWwxhw0gbDY78D8fH
 FeEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHNkKtgoeuorUX20KKxq8twzbEq9vj8ad5iAJ4UTZqqQdl9QhDHrjNKVOoiWsA7cTwuJJYNFXgqQ==@nongnu.org,
 AJvYcCVQx+lAKOzRgrr+9XMZIO9eLS2XHKqnq8OSfE/61Hkr2m6SGiNJgCV9snJv7XE2E4+W1swQZgneX3s=@nongnu.org
X-Gm-Message-State: AOJu0Yz1eVpzUc3sVwMT6603TH7+u0Y5NfYnU5z+Kc2S2BLpQMgwS/k+
 66TM9rWkG4Vpj2gJ8mja4+BMPZjKfjM26Kh+BLIA33Xa70e6eoW6wPaPYQ==
X-Google-Smtp-Source: AGHT+IEXC+GaGZHXdFDQlGURS0Dx+UdIB3xXcgagS73V+WjOGP1ucLHcmQpX2wbdYHwTwfepkmLFqA==
X-Received: by 2002:a5d:4ec1:0:b0:374:bb0c:c067 with SMTP id
 ffacd0b85a97d-37d0e7b9b19mr2837949f8f.40.1728123067596; 
 Sat, 05 Oct 2024 03:11:07 -0700 (PDT)
Received: from ?IPv6:::1?
 (p200300faaf0b740060f42ffb9c392035.dip0.t-ipconnect.de.
 [2003:fa:af0b:7400:60f4:2ffb:9c39:2035])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d16920cc7sm1470338f8f.61.2024.10.05.03.11.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 03:11:07 -0700 (PDT)
Date: Sat, 05 Oct 2024 10:11:01 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH 0/3] Split TYPE_GPIOPWR and reuse in E500 machines
In-Reply-To: <CAFEAcA-69b=MJtqpOss97erRH8v01GdUEGLNydQaz3bVxbUQkg@mail.gmail.com>
References: <20240923101554.12900-1-shentey@gmail.com>
 <CAFEAcA-69b=MJtqpOss97erRH8v01GdUEGLNydQaz3bVxbUQkg@mail.gmail.com>
Message-ID: <ADAEF2E0-07DF-40F5-9226-CAC28FFA90D3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 30=2E September 2024 12:57:17 UTC schrieb Peter Maydell <peter=2Emaydel=
l@linaro=2Eorg>:
>On Mon, 23 Sept 2024 at 11:16, Bernhard Beschow <shentey@gmail=2Ecom> wro=
te:
>>
>> This series is part of a bigger series exploring data-driven machine cr=
eation
>> using device tree blobs on top of the e500 machines [1]=2E The idea is =
to
>> instantiate a QEMU device model for each device tree node containing a
>> compatible property=2E [1] achieves feature-parity with the hardcoded m=
achines
>> when supplied the same device tree blob that the hardcoded machine woul=
d
>> generate=2E
>
>FWIW, on Arm I have generally pushed back against the idea
>of "create a QEMU machine from a device tree", because the
>device tree does not in general contain sufficient information
>to create a QEMU machine=2E It only has the information that
>Linux needs to use the devices, which is a subset of the
>total "how do all these devices exist and get wired together"=2E
>(There are some special cases like some Xilinx FPGA systems,
>where both the device tree and the hardware were autogenerated
>from a common source definition, and so there's enough of
>a constraint on what the hardware can be to make it workable=2E)
>
>> Just like the ARM virt machine, the ppce500 machine implements a
>> "gpio-poweroff"-compatible device tree node=2E Unfortunately, the imple=
mentation
>> isn't shared which this series fixes=2E In order to reflect device tree=
 which has
>> separate bindings for gpio-poweroff and gpio-reset, and to prepare for =
the
>> above, the gpio-pwr device model is split=2E
>>
>> Note: If the split seems too fine-grained, the existing gpio-pwr device=
 model
>> could probably be reused in ppce500, too=2E
>
>I definitely like getting rid of the hand-coded
>qemu_allocate_irq() in e500=2Ec=2E But I don't really see
>the benefit of splitting gpio_pwr into two devices=2E
>If you only need the power-off behaviour, you can
>leave the restart gpio input not connected to anything=2E

New series sent which removes qemu_allocate_irq() usage in e500=2Ec: https=
://lore=2Ekernel=2Eorg/qemu-devel/20241005100228=2E28094-1-shentey@gmail=2E=
com/

Best regards,
Bernhard

>
>thanks
>-- PMM

