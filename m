Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E263D606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 06:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=rGiCKgys
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTCVh-00062G-AQ; Tue, 17 Nov 2026 01:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xTCVf-000622-3D; Tue, 17 Nov 2026 01:17:39 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xTCVc-00050b-K5; Tue, 17 Nov 2026 01:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794896251; bh=W4QMNqJvelowpXLZgWLjQIdCf9FCvtCjG/QAYFcoN40=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=rGiCKgysLbKgVgMCfWykzedKyYAVHzBQoNDaB1NezQQUv4+pkzUwSl//z/rtx9TvN
 fXz48C+kYaW8Y7fC3NhfwS1s4MiktauXm7JDC+gg3YV1hlpIm3Tcp+lpr3eoqKV042
 ltRNNOzailK6FMHyMyeVMZ598d7CQG2x9uhe65UwEXFtazAZfLMM1EhFvRe6bUXfiK
 8GNUpUJ+3PsoyFpE6b8nppoYWzInT+Uq+9ZLfDZHLxqh5KTjLXr7bbHjZLntScw8+X
 RABMB9Rko9A/hwklXqeQeBKAs4BTjDlhhAL8GCtW4T9v/iwfCXiyaahqCVTxtbz2NZ
 Dy5i1MuyCc1kA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B992F1E7426;
 Tue, 17 Nov 2026 09:17:31 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A9EFE45FF30;
 Tue, 17 Nov 2026 09:17:31 +0300 (MSK)
Message-ID: <b7a1cdca-b6d2-4d17-a1d1-5b88e60219b5@tls.msk.ru>
Date: Tue, 17 Nov 2026 09:17:31 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/net/eepro100: fix use-after-free on reset after
 hot-unplug
To: Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowangio@gmail.com>
Cc: qemu-devel@nongnu.org, Hui Peng <benquike@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20261103215430.703404-1-sw@weilnetz.de>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261103215430.703404-1-sw@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 00:54, Stefan Weil via qemu development wrote:
> e100_nic_realize() registers a system reset handler via
> qemu_register_reset(nic_reset, s), but pci_nic_uninit() never
> unregisters it. After the device is hot-unplugged, the LegacyReset
> object stored in the root reset container still holds the raw pointer
> to the freed EEPRO100State, so the next system reset invokes
> nic_reset() on freed memory.
> 
> Instead, define a reset phase on the device itself: assign
> phases.hold in eepro100_class_init() to a wrapper around nic_reset().
> The device is already part of the resettable tree via its parent bus
> (TYPE_DEVICE implements the Resettable interface), so no explicit
> registration is needed, and the reset state is automatically dropped
> when the device is unplugged. This follows the approach used by the
> e1000, e1000e and igb emulations.
> 
> Reported-by: Hui Peng <benquike@gmail.com>
> Reported-by: MyeonghunPak <https://gitlab.com/mhun512>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4058
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4510
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
> 
>   hw/net/eepro100.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)

I'm picking this one up for qemu-stable too.  It's not a big deal
since the situation is quite obscure and the emulated nic is rather
obsolete by now, it's unlikely someone will try to hot-unplug it.
But qemu should not crash in such cases, and the change is simple
enough.

Thanks,

/mjt

