Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDF6C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 17:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU7sw-0001bZ-6q; Tue, 24 Jun 2025 13:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uU7sq-0001YX-15
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:56:36 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uU7so-0003D8-FN
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:56:35 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3121aed2435so940217a91.2
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 10:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750787793; x=1751392593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iPurwVmlFL652YkXyzmyB3RAvsR9pd714uCu4sXgkPE=;
 b=CziWA4qR9s9LCIBy1b04+2Cq86HV3hCiZd5mDQHKjxNMxvVrL7x1sfqoYfBaXxuP27
 /oqreY6tErU3npk1ZOhvC+tSadWEQFECqPARqo976fRCra55+RBel4a35rMpCQfU4mjn
 C0rLEdyh7QjxllWbXiVoO9rkcQRA71ac5+FJbxssXYyBoTkgTk3PM6CDKyvhWn9WqRmw
 DL22pq5cvUGou7viqma0RigO3QUcCG3cNlUXza6Hm14I75cVfpy9R9LyAeDdpuUErHVk
 /RJdnJNjQ3G3vyWoHxOg6tL7yJyCrvv/mw8uAiPmiNosrorcJ4ECGeosKN7Oz7XT68oW
 EkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750787793; x=1751392593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iPurwVmlFL652YkXyzmyB3RAvsR9pd714uCu4sXgkPE=;
 b=L9Vgg53sseHvoq2sawBWOh8ImsdVsx+xWulIbLpNxyFbh3AVmWuSIaXd5X564TbJ3g
 il+OqfRwAmyuLSm2dXjuvAVHNUbIH2YHGr8E1WFdOEajrg8n6y732EX/VJalaqw5Dcna
 Pr2LvKfDBj4IoJ3bTWaD4EDZSi7Ohlh9o6qNx+T9ra1HyrVwxjSVRUEVBYiavWhCV+nR
 bErJU++dQ+ZU4hh4A3aTwI2wpsgRn0gGRif79yDibNeg+VNN+bk/keZsdLn7zY54OFtc
 M5/Kph/A4u8GJtaZIDtEihdiraVPBEwRAQXJZ3bwx1En9MUQ58zwTp+4oKWaczWLFuSU
 H+0A==
X-Gm-Message-State: AOJu0YzKlu8fDjaaJ7OXTew2r/5HTfDaK1mpy1/o57CC4OWviOSc2DJh
 l+UXl8m49AnFN+Oe0RlEuk0RsMlMKe1Honwve13HtWeZghfKIC8v4dmI
X-Gm-Gg: ASbGncuuHk931ZyKkx2S0ijgjBZfqY1TPJuW9dCKCXv4n+LiKsOAU1u7LWrLYIdArrW
 nnb8KZ+t2P/lz5SV/Oychw6kpcBBITUIZtvEvY350Qq7F4N30Ux8AgOUWPyPa2LVzW5RoQ3aY3T
 SmnFu2OfmMIMkudPW7vpSgrPzaQj65+SC398cQqZyX6ajBfll9RoPfM9FcZkifezOkEYXFEt5+j
 htiWA33KXrgD7+9Urg3DSfrBOK4BPdOACLwX5AeyMNBFDmhkd32OE7xVk8BGnqktIKdfuns2ezm
 MYqMXsQkgIxahH6+qHUTTQqqWE0kW9ycVROpId1jQLVY0+04f6bshY+vWUpxSbnRPQ==
X-Google-Smtp-Source: AGHT+IGa9IEmuR5EaExENs5q0YIU4oA/Whz7dOXAZqV/zFvuw2XOiDfGnPFddA/M1VyYdgnUMEMUrQ==
X-Received: by 2002:a17:90b:1f8b:b0:313:279d:665c with SMTP id
 98e67ed59e1d1-3159d6196f0mr30574431a91.7.1750787792828; 
 Tue, 24 Jun 2025 10:56:32 -0700 (PDT)
Received: from [192.168.1.119] ([50.46.174.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3159df71bbbsm12066527a91.9.2025.06.24.10.56.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 10:56:32 -0700 (PDT)
Message-ID: <e381ef92-e814-4577-850e-839df47f43a3@gmail.com>
Date: Tue, 24 Jun 2025 10:56:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 0/7] Add additional plugin API functions to read and
 write memory and registers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250619161547.1401448-1-rowanbhart@gmail.com>
 <87bjqd1j33.fsf@draig.linaro.org>
Content-Language: en-US
From: Rowan Hart <rowanbhart@gmail.com>
In-Reply-To: <87bjqd1j33.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=rowanbhart@gmail.com; helo=mail-pj1-x1030.google.com
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

>    make[1]: *** No rule to make target 'patch-target', needed by 'run-plugin-patch-target-with-libpatch.so'.  Stop.
>    make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:56: run-tcg-tests-x86_64-softmmu] Error 2
>
> You need to ensure vpath is set, something like:
Thanks for the note Alex. It turns out I'd been testing like `make -C 
build -j$(nproc) run-tcg-tests-x86_64-softmmu`, making this succeed when 
it shouldn't have. I updated it in v14.

> novafacing (6):
>    gdbstub: Expose gdb_write_register function to consumers of gdbstub
>    plugins: Add register write API
>    plugins: Add memory virtual address write API
>    plugins: Add memory hardware address read/write API
>    plugins: Add patcher plugin and test
>    plugins: Update plugin version and add notes
> Could you update the Author fields so the Author matches the s-o-b tags
> please and is consistent please.

Absolutely, fixed this in v14 as well. One of my computers must have had 
my alias set instead of real name, apologies!

-Rowan


