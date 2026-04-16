Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF40F8D776
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 20:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDSxg-0008Ft-Jx; Thu, 16 Apr 2026 16:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1wDSxZ-0008FT-4N
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 16:05:10 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1wDSxU-00081s-5j
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 16:05:06 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 308C83F867
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 20:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1776369900;
 bh=I8Wmzce83Qaglm/E/OuPhtAxgZT+LNUHczg0wcNfiwU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=i4E7AgVQruhvyIlT/6E/OvCj3hU7u0T1bUZLuNhCSpg7tzlBC5JHdLIxvIGNy7n03
 hwasdNndZrN2fuJy/DMoR1TvsDWpzOhfHXpapOvD+uoCIeNAmHjbYexTAvL9Jet3HU
 7QbootFdgYfCePMyKnZvvwUx2CICPdzbQ6tuYyOIzM5WpoGHAJ4mBpVG+Od4YdtPNp
 nXSG5R43H3XOMueAXu2qvuQgigy+jrCxfP9QOcutUvV0gC6ocGl5y0YiJO4j+0SrtG
 LBzgb/AQcEcZLMUnbrib6JZmbZoqYnJwca81+XbgopZwjDbFD6x73ZMdECe6abNfOU
 Z0Thic2X6z1dMmEc3Rlp8o7tDR4DK8sI1OyBSDFzKVUB1iX368zmzYGEz70TWS0DzD
 k+uhFxcwkFdG1btjk6hTFUyiFHuGndtyLYmSY1aDYli7R6r/N2cwX0EfY/mkLo9qnd
 3OUO4DVJkujdqWySrEVDF3iU1TyAxWNXilQ8o98d0aFJbivg4VuS2uCvi5tepoxP+V
 5XQ7/FfscV6PYv1FJUgOrSWcodG/8AH6yXr1DjEj8lPHD4YXecchgQqh4020b5cGpH
 8GyAcTERenNvr0ErFImeffCDMdOfg7kbVcYdVsXuKeM+6gvun4aqZWr63jMTxxAH20
 7426oCvG5Oyd9mf+AWzs9bu4=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488d56f87e8so59066885e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 13:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776369900; x=1776974700;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I8Wmzce83Qaglm/E/OuPhtAxgZT+LNUHczg0wcNfiwU=;
 b=sX3xsd4/uWMh8gthUvQYRFQtfY36nVrD5n0a5/V6I6WxQVWx7H4ZpUMNlkO0Fk64K8
 Tw6xvTVSqpjsg9YQfu2RXtqvYS8lEG0/wIJOd0cEZ15u6j0KzbaQslzUb+raGo+IK305
 4HKSEpcZnrsRmimko7ARiqJDCS0qPiJ6aFpAgGs4KhpagymjOtWBFzwBGAsSO3WDxD3D
 6stNI75H06lgilYDW8ALCguFlEDVD7XhopiMGNoZDeueBlDzABU5oQOtLO0iDsB1mYwn
 tHFD8isVUXEvzxVpWXp36YaxtCWxfzH2Iiw+hROH2w+XSKlRNMm2xGb6tQ7dLKvop8y1
 FhEA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+9WuG6lG1sJQyG8UV3vU3qp0HSey35LZabzRrLzOBob4i7hPg9DJYSUn/wuQUYBtJzEJQcZ143zQ/V@nongnu.org
X-Gm-Message-State: AOJu0YwzyMEeofb+19gZL5DYqf83NExsTdWZzRnAsQdVZOawgRQCAqlC
 Yurj+SWNVKifFzSi+ZxbbOOPh8/XqxXvMhiUpXCrewtJl8cUWvBQgPj1w+RN7bp78cf2jpMQSUT
 CZT5WFONAicU5Z87ZpR5ctX7KHSYV3Mc9j12qv0e0moVzfhYII6HN3Hv/bLQAcDy79ufr5OfF
X-Gm-Gg: AeBDiev6K3GP919zSzpjdpkJaQ0jVbnIv96d/67/XQF0goyWqimFwSYFQMayZ+QcJcR
 NthLZRwU4Jrz2hEFBQ1GO032iWSeyugUGW3xtDy71bj//d+ONIpH+L6k4jzHgsukejIFYfwCPNo
 je9ntxCJutK+F0KbXNIGKyVdGnWo58YzrldlrFioPLS9sznkqHiPfkFYXUMvPq5kPenpsLY3Vun
 aYYwbH9oLJUgwwDzx5aaWZ9y6LGwsi35sRJ0sBxyN2UFb3IFYgxK/Tb/MKiNjBqfozu0R03NLlq
 DR08b8ZqynIYeJ4ZY4mu8uV9VTC9Z52mPVDpQu0XRylrLrDqiqIY5F/hicED845oLs9jdKURQtz
 3UU8cdIuIGJ3FKX6RNDYX3+4yuJQZ5UdQrEYoc72xZ4xpwtbgqmPKlO8Xc0a+ZYoPknQ6KMEEcp
 2Azef29jqFmIMzX0F75Ti/7+Nqktcx2B7/pAaZPKWtkWu9k9lW2JC4JFvudlV6/3EWcWQ=
X-Received: by 2002:a05:600c:6297:b0:486:d76c:fa57 with SMTP id
 5b1f17b1804b1-488fb77155dmr569565e9.17.1776369899742; 
 Thu, 16 Apr 2026 13:04:59 -0700 (PDT)
X-Received: by 2002:a05:600c:6297:b0:486:d76c:fa57 with SMTP id
 5b1f17b1804b1-488fb77155dmr569235e9.17.1776369899391; 
 Thu, 16 Apr 2026 13:04:59 -0700 (PDT)
Received: from [192.168.123.154]
 (ip-176-199-115-125.um44.pools.vodafone-ip.de. [176.199.115.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f584e243sm148274265e9.10.2026.04.16.13.04.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 13:04:58 -0700 (PDT)
Message-ID: <8112ea21-10ca-4784-b530-2143218dbb05@canonical.com>
Date: Thu, 16 Apr 2026 22:04:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tests/data/acpi: Update SPCR golden-ref for RISC-V virt
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, tangtao1634@phytium.com.cn,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260412012501.1808602-1-chao.liu.zevorn@gmail.com>
 <CAKmqyKP9k5ku8hfNbq=4XxPrukAn0Php_QyZuero=MEHVtd0BA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAKmqyKP9k5ku8hfNbq=4XxPrukAn0Php_QyZuero=MEHVtd0BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 4/16/26 04:35, Alistair Francis wrote:
> On Sun, Apr 12, 2026 at 11:25 AM Chao Liu <chao.liu.zevorn@gmail.com> wrote:
>>
>> Update the expected SPCR binary to match the corrected field
>> sequence after the Terminal Type and Language fields were swapped
>> back to their proper order.
>>
>> This fixes the qtest-riscv64/bios-tables-test CI failure:
>>    https://gitlab.com/TaoTang/qemu/-/jobs/13879552268
>>
>> Fixes: 977c6fefcd04 ("hw/acpi: correct field sequence in SPCR table")
>> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
>> Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
> 
> Thanks for the fix!
> 
> Do you guys (Heinrich and Chao) mind if I squash this with "hw/acpi:
> correct field sequence in SPCR table"? They are both in my tree and if
> I can squash them then it keeps the tree bisectable
> 
> Alistair

Sounds reasonable to me.

Best regards

Heinrich

> 
>> ---
>>   tests/data/acpi/riscv64/virt/SPCR | Bin 90 -> 90 bytes
>>   1 file changed, 0 insertions(+), 0 deletions(-)
>>
>> diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
>> index 09617f8793a6f7b1f08172f735b58aa748671540..59d2c8f7f215a604612cbd0294c18bc6301e208a 100644
>> GIT binary patch
>> delta 10
>> Rcma!wnqbGo%rMbG3IGpM0&@TW
>>
>> delta 10
>> Rcma!wnqbGoz&z1G3IGpJ0&@TW
>>
>> --
>> 2.53.0
>>
>>


