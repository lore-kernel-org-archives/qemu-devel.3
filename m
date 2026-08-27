Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2592C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzT3D-0003di-Dp; Thu, 27 Aug 2026 01:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wzT3C-0003dQ-0F; Thu, 27 Aug 2026 01:53:22 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wzT39-0006dB-UC; Thu, 27 Aug 2026 01:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787809994; bh=nJYCRP3YtgI3/Gj07gaFuwr5YqENN20vPeQGQZEzP/k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=lLjje0VMDEXtL8k+6TnKF3fssWr+Wc98oGCLG5xUM/GEmFhfcwFGoE9SeP2epAWRr
 0fe7r7xd6WA+HOf85A9SPzrZIJ7nX87A9FNv5CEJPYe7lbmvVDlMSPaRa//J0TxcyF
 D0uOD2TsN99xrX8rqy86HABcw9niC5eX+Z17oKMxUDg0n6yguCVffgGyG4MHS+N5kz
 V6tzsQxeUzxLWcSvL6sUMCNVkn9uUVBAuVlzTxXnIX5f6dvuQC3YESomwUJ9+XDg0o
 S10hpd2pCvlJIkjdyDGYVd3o7CHl+wytxNkmhtTs/3l52K18cBix9e+FmQRK81YMy/
 PWJoaKtfyb74g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EAA1B1CEFB0;
 Thu, 27 Aug 2026 08:53:14 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 508AD418DAD;
 Thu, 27 Aug 2026 08:53:16 +0300 (MSK)
Message-ID: <110b1360-1476-4300-b3e6-4f5bb6be1d76@tls.msk.ru>
Date: Thu, 27 Aug 2026 08:52:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x/sclp: pv: only copy the original SCCB buffer
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Janosch Frank <frankja@linux.vnet.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20260814125857.1729543-1-borntraeger@de.ibm.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260814125857.1729543-1-borntraeger@de.ibm.com>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/14/26 15:58, Christian Borntraeger wrote:
> From: Christian Borntraeger <borntraeger@linux.ibm.com>
> 
> With variable length and EXTENDED_LENGTH_SCCB, some callbacks might
> change the length field. For example read SCP info might write a new
> length into the SCCB header. We must not use that new length for the
> buffer copy, since the buffer was allocated with the original length.
> Only the length field in the work SCCB is changed, to indicate the
> "necessary" size. Using the new length reads past the allocation, so
> tools like ASAN might detect a buffer overrun.
> 
> Secure guests do not have EXTENDED_LENGTH_SCCB, and the ultravisor checks
> and sanitizes the length field, so no qemu heap contents are exposed to
> the guest and the non pv-path already has the same header.length.
> 
> Fixes: 0f73c5b30b8b ("s390x: protvirt: SCLP interpretation")
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
>   hw/s390x/sclp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

I'm picking this one up for the currently active stable qemu series.
Please let me know if I shouldn't.

Thanks,

/mjt

