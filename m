Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23172E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 08:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXcOb-00013P-7h; Tue, 14 Jan 2025 03:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXcOX-00012y-DV
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 03:35:29 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXcOS-00043J-7H
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 03:35:26 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso36995765e9.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 00:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736843722; x=1737448522; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7+5ZC3V9kw4qLGC73M+ijkTpcVLjNeDBoXFfwl2NNaw=;
 b=LeSqpMC+5+N+/FSV8kYmWpIKmFff1rzhcmEAVb7xp1GP6Dzpoe0svEp8E3I9mcW2qH
 Unq2Kaf/rANIOzjO1/azoo2I8l/WECaC+49kvFbz8daLaAKx58WD/BcoJiE88YbT2bi+
 DdXYEaexa0wpueO3cJ+J31ka86sEFuKZKsrSSFPZ+mHNvrIbAZugC6+noBQ6wTQgk3NF
 7mkOJS5qK0uVTnY6LqhOl88vVjIrNrPa4kB+4sgZQmK786AKIfUfItSgWtqGU9jAVPlP
 ElVrx6X7V1611EUR7igomYpU6hUe6zw1g8uuLmyNRuj4VxwUCtaBE1fj7t1BOiOFdHNn
 GzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736843722; x=1737448522;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7+5ZC3V9kw4qLGC73M+ijkTpcVLjNeDBoXFfwl2NNaw=;
 b=UF3ag3K+LDteAYbfJaOIZHAjjUlXTC7lJTtn4goNHisvpsHmtcJatznBqRO88V+5qZ
 wQi2g6wTwSE1SJlyfhLvLD4sVufQ4U5JzxB15KrZyXZfUzdv8Birc65T7QXVgz6eeAlZ
 LNVbLVmLRXSngsoDU1RmTZtqR1UEzXBfddWyLBFxS/pGvq6TexUUAA06kfQqbQ2G3eIC
 HQvQNDA/8ZBPKMMIapSp4Csi0hzY6F6hmVtOmD3dROCB5v8Opccdg1ed2SbeY3k7fgOP
 WoJyYN8P4926O+PI89qaCvpde8XBryPaVeEBpmZKPRsDW9RVrWt05CRa8q0ZP9uP7E2p
 vwKw==
X-Gm-Message-State: AOJu0YwuEGSk7K8h1KLhvelkNhWP7+SpAh+CU171ZXjivyj0WVeOrK2C
 eJ9MeasVIWgo1kYJOpzYxKuYA1h606DXmr/ocFaYcGb/dkRMD+R0TShajhBbyv4=
X-Gm-Gg: ASbGncsyL/itgweNgRswFMbsiB5sj0l9bhDHChcAo+wjjF+sfFZ9/RETOrkXZhAS++g
 9hdW15+23kKLMOMLCdxJeDHC2/RJNW56JU1p8AOHXFr6V+dhd+yrXdVn7bqpuxj6c33goYYOc5G
 mztrMCjyBJJLrMdgRj03A9I5n4JrKnV/b5MIdI7taiwH804UtATzMRPlhOCjGV86rdsz7eurwZx
 PPx9vVPvYBe4JQRBv6chS07hAi1t++/Q3Yb2hQP9sEgTihcNIRKBzQhnW2CUCperhhRT42Q9Kli
 KRwU3mL3Y3ss8zs1o3bEYJVG
X-Google-Smtp-Source: AGHT+IE/o7MzRfrjiECmCBTWGBRlQ8AustEvVSnPGTIrzK5KLYr2RPqENGtHLQE1mDqdmMUdZ2JoZQ==
X-Received: by 2002:a05:600c:8706:b0:434:f0df:9f6 with SMTP id
 5b1f17b1804b1-436e2677356mr205256715e9.3.1736843722206; 
 Tue, 14 Jan 2025 00:35:22 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9dc8826sm167085705e9.11.2025.01.14.00.35.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 00:35:21 -0800 (PST)
Message-ID: <26b48106-e63e-43d2-bd49-3207c245e962@linaro.org>
Date: Tue, 14 Jan 2025 09:35:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Enable clang build on Windows
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
 <87jzaxkdri.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87jzaxkdri.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 14/1/25 09:20, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> For now, it was only possible to build plugins using GCC on Windows. However,
>> windows-aarch64 only supports Clang.
>> This biggest roadblock was to get rid of gcc_struct attribute, which is not
>> supported by Clang. After investigation, we proved it was safe to drop it.
>>
>> Built and tested on Windows (all msys env)/Linux/MacOS for x86_64 and aarch64
>> hosts.
> <snip>
> 
> Queued to maintainer/jan-2025 and testing/next, thanks.

Please also take this one on top:
https://lore.kernel.org/qemu-devel/20250111215244.1680931-1-sw@weilnetz.de/

Thanks!

