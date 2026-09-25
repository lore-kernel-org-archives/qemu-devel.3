Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C01AC98306
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 05:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9yIg-0001MG-50; Fri, 25 Sep 2026 01:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x9yIJ-0001Ld-Dv; Fri, 25 Sep 2026 01:16:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x9yIG-0005f2-RQ; Fri, 25 Sep 2026 01:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790313365; bh=wTAY0cMKTk+NVgQJg3E17q6S40+FzPSusdTGGXf5cLo=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=qwYfp+NvbcHnJJ3UPSM4P3tJnXn3FGahOM/7w6vIEkxRNA2Xf8cErKxiQW1YGb0Y5
 9dv59wOAJc+CmL9VSdz6IaEKtiTjHDNR4t0hX6cDDrFfPbe3B99X3i1JiTaSo/UtJ7
 TK8Kx+Ao473vEtNq1TCSMnTQzAILkE33FCAePQdnsN4QErUknnch+ISk7wTLOrO6zF
 q06arUOJ0IAW2y9CaEvwM96b4dDFsWn/fXsXXhOSFRn7e1ndEkrW5ax8/9KEyvz+8F
 /JQnKrErV/valrQ90Nbumh9jSDI9rKeKXnuMHTYkswYSJruPeXfpGpstunlctaxr+J
 os/zSGjLrcaxw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A26241D7F91;
 Fri, 25 Sep 2026 08:16:05 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 73F1B43091C;
 Fri, 25 Sep 2026 08:16:05 +0300 (MSK)
Message-ID: <3d55a4cf-6d97-4bce-857d-23a4049e842e@tls.msk.ru>
Date: Fri, 25 Sep 2026 08:16:05 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [RFC PATCH] hw/usb/hcd-xhci: Limit DMA transfers to plain memory
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, QEMU Stable <qemu-stable@nongnu.org>
References: <20260915123242.549150-1-thuth@redhat.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260915123242.549150-1-thuth@redhat.com>
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

On 9/15/26 15:32, Thomas Huth wrote:
> XHCI is a complex controller, involving lots of descriptors that
> are written and read via DMA transfers. As some recent bugs like
> https://gitlab.com/qemu-project/qemu/-/work_items/3926 revealed,
> this can sometimes be exploited from the guest side to crash or
> stall QEMU.
> 
> The code currently does DMA writes with the MEMTXATTRS_UNSPECIFIED
> attribute, i.e. the controller is allowed to write to other MMIO
> regions, too. However, in normal operation, this should not be
> necessary, all descriptors should reside in normal memory. So let's
> decrease the attack surface a little bit and limit the DMA writes
> to normal memory here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   This would have prevented bug 3926 from happening, too. However,
>   I'm not sure whether there are some obscure scenarios where writes
>   to MMIO regions could still be necessary, thus I've marked this
>   patch as RFC. Does anybody got an opinion on this? If not, maybe
>   we should give it a try and revert the patch if someone finds
>   a scenario where this is causing problems?
> 
>   hw/usb/hcd-xhci.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)

I'll queue this one up for the stable qemu series too.
Having in mind the above doubt, I'm not applying it immediately
but for the next series.  There is some risk here, but it is
more theoretical, I think.

Thanks,

/mjt

