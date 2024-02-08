Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781E0C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 17:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY7rr-0001Tt-GD; Thu, 08 Feb 2024 12:07:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=cJ39=JR=kaod.org=clg@ozlabs.org>)
 id 1rY7rp-0001Tg-VN; Thu, 08 Feb 2024 12:07:17 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=cJ39=JR=kaod.org=clg@ozlabs.org>)
 id 1rY7ro-0003Fl-B7; Thu, 08 Feb 2024 12:07:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TW3Lh0ZQTz4wcq;
 Fri,  9 Feb 2024 04:07:08 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TW3Ld6KDBz4wcL;
 Fri,  9 Feb 2024 04:07:05 +1100 (AEDT)
Message-ID: <17a2931a-5b3e-4eed-ae63-63b14032db6f@kaod.org>
Date: Thu, 8 Feb 2024 18:07:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] hw/arm/mps3r: Initial skeleton for mps3-an536 board
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-9-peter.maydell@linaro.org>
 <b8fbf313-1b24-4cf3-b5c1-f9289b413a75@linaro.org>
 <CAFEAcA8UqeGKf8pP90i6Jn=AYgqtzFw141ptir=5BEZtpwjD2Q@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CAFEAcA8UqeGKf8pP90i6Jn=AYgqtzFw141ptir=5BEZtpwjD2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=cJ39=JR=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


>>> +/*
>>> + * The MPS3 DDR is 3GiB, but on a 32-bit host QEMU doesn't permit
>>> + * emulation of that much guest RAM, so artificially make it smaller.
>>> + */
>>> +#if HOST_LONG_BITS == 32
>>> +#define MPS3_DDR_SIZE (1 * GiB)
>>> +#else
>>> +#define MPS3_DDR_SIZE (3 * GiB)
>>> +#endif
>>
>> Generically, can we migrate a VM started on a 32-bit host to a 64-bit
>> one?
> 
> I think it's one of those things that in theory is supposed
> to be possible and in practice nobody tests so it might well
> not work. At any rate, this is the same thing we do already
> in mps2-tz.c for the 2GB DRAM those boards have.

We could have a common helper may be. Aspeed does:

   /* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
   #if HOST_LONG_BITS == 32
   #define ASPEED_RAM_SIZE(sz) MIN((sz), 1 * GiB)
   #else
   #define ASPEED_RAM_SIZE(sz) (sz)
   #endif

Thanks,

C.


