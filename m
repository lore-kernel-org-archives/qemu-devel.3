Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EA7CE8D70
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 10:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srE1h-00050Y-4p; Thu, 19 Sep 2024 06:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1srE1g-0004xh-2J
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 06:04:40 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1srE1e-0002Ge-Ca
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 06:04:39 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f74e613a10so8925641fa.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 03:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726740276; x=1727345076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BGYhlLzLoZazpQNoUKwBs3Uwl//YODb3fkfgd9Ni2AY=;
 b=Nq+iT4dCHIOy5LzOYEeqGgDnPpwbc0X5hPI8DwFFrOyPkiZWo4XS55NifxadxKweQa
 i7TuWq1hyc49ssI973ypkC3QDz556ygSEqmwqiIqJW/946t2PvEv2d1Ae8Ia/Z/qlNdL
 MUr39hMLJvivBwQwUXriMEVHZ7tVj5FeJVC/Nh49DR3sM9yR76zAelV09KRUMPnlZBxD
 fe4p5I9r47m3M4sizZj8dR31QDnIVYeK3GA+mldpB1livP1IzLWvCDEbyJXIQpRnMkz2
 OCK86X3HV/X6T9XbvU3sYROldJr2E2UERDjbyFj1h2kz8R0m3Hx5pu1yFOVPJ3n62xwZ
 AbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726740276; x=1727345076;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BGYhlLzLoZazpQNoUKwBs3Uwl//YODb3fkfgd9Ni2AY=;
 b=KGI1AxK/blkjM2UjqgLWxbnUtObNJoCL7jS5KXiHVteosWkFjvwh6iaqJ7jQ3YTtv/
 /SwwUlB9kxFiK6fS20uDbEwPhRKNK59ryncg3bGgJ7Y9FAjj5DswHtOQMAiXzG1AZdmS
 jYH9Zbrmv/rNUKbta17pggzhJcqstB9932W+FYCUO9FM7Mt2gMN+QGCsBJjFKK7qvvez
 EkDaJM2uII20plYjdtwa2SB4s+jPlUG8gPuj9vV4boCWJPRFQXTdyaefV0KD4Sbp5YfF
 uCZ0nFhq1+hbsl+ZfThNlmWr58w8FfMar7L3t8MjIVgNHK4ABvN4lBgpiz/lIVV7o5yz
 lIjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPOOpLLtP69KIT6nFf20klR7CV+5Mdaaj38EC4KCZlVNuzE6LAef1+JsQzk2sLWbqrPd7MmtI2WE4Q@nongnu.org
X-Gm-Message-State: AOJu0Yw97xTH3gqJuoFdjEZAZxvkU9CfguYC0AuC5W2pa5bOZPiAxR24
 eShcUh5Iz+QL9Ve5XBwqwzslglgA+aS8OCjKr7TaUo/yL5ewZ/koAlWsD7EF5jk=
X-Google-Smtp-Source: AGHT+IE5fH1aMGmxhfSelj6lK7DKfqK1pbbTebNQOejyCSH9031Szd5ZZaNUSYO2grLh+iLmuOh2CQ==
X-Received: by 2002:a05:651c:a0a:b0:2f7:562d:cb6c with SMTP id
 38308e7fff4ca-2f7918e95aamr148567571fa.2.1726740276497; 
 Thu, 19 Sep 2024 03:04:36 -0700 (PDT)
Received: from [10.133.7.245] ([83.68.141.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610f3aaesm701574766b.53.2024.09.19.03.04.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2024 03:04:36 -0700 (PDT)
Message-ID: <3850d20c-65dc-478f-a7f3-ea18d6b37c0e@linaro.org>
Date: Wed, 18 Sep 2024 16:24:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qemu-iotests/testenv: Use the "virt" machine for
 or1k
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-trivial@nongnu.org, Jia Liu <proljc@gmail.com>
References: <20240917193028.320400-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240917193028.320400-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 9/17/24 21:30, Thomas Huth wrote:
> When compiling QEMU just with "--target-list=or1k-softmmu", there
> are 8 iotests failing that try to use PCI devices - but the default
> or1k machine does not have a PCI bus. The "virt" machine is better
> suited for running the iotests than the or1k default machine since
> it provides PCI and thus e.g. support for virtio-blk and virtio-scsi,
> too. With this change, there are no failing iotests anymore when
> using the qemu-system-or1k binary for running the tests.
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   tests/qemu-iotests/testenv.py | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

