Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB016606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 06:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=r9lqrz6b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMJtk-0007rB-Kk; Thu, 29 Oct 2026 02:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xMJta-0007pZ-7e; Thu, 29 Oct 2026 02:45:54 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xMJtY-0005nZ-58; Thu, 29 Oct 2026 02:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793256348; bh=6fWg9KTd0CdUXcJEKKdYndInVTd0HhT+Drf33nf52QQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=r9lqrz6bcRowTXVfVcBa2bHo3TeCa1CtJAlNyCZLrngjbbHOV0endv1ufbR0Cvjqo
 xnx3EhwWlWIrF4UCw7yGZbnN8ddCU+xSYqkV/DzBN1lgbasyilTTKczLOfpkqVauJp
 9syRPirVrEuREDO5WTKxANbp/iJXsdglZ3Gy3GkUeWZCEeqeEzJjTGOL+irBtf+xf+
 P347fgdi5h7nDz1j0rAfZ/w93shtixVl79BCkrkAB+x5PoycptY1eJi3jEhFQEgLPY
 aydqpEKaQDDwtjB1dwLzJ0Ej2bW0lmPQZBh7PQVMtRDAI5zbFUgHsUtJ0g3JsjPWAP
 jxIX0j1Vz8qGw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 275091E21E6;
 Thu, 29 Oct 2026 09:45:48 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1231844DF83;
 Thu, 29 Oct 2026 09:45:48 +0300 (MSK)
Message-ID: <4985e605-c4cb-4fd3-b48c-b2019fa6ebf7@tls.msk.ru>
Date: Thu, 29 Oct 2026 09:45:48 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] hw/sd: Improve performance of read/write/erase
To: Christian Speich <c.speich@avm.de>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Conor Dooley <conor.dooley@microchip.com>
References: <20260417-sdcard-performance-b4-v4-0-119e66be10c2@avm.de>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260417-sdcard-performance-b4-v4-0-119e66be10c2@avm.de>
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 4/17/26 12:51, Christian Speich wrote:
> This patch series improves the performance of read/write/erase operations
> on sdcards.
> 
> This is done by increasing the maximum buffer size that is worked on.
>  From 1 byte (master) to 512 bytes (commit 1-3) to larger than 512
> (adma commit).
...
> Christian Speich (7):
>        hw/sd: Switch read/write primitive to buf+len
>        hw/sd/sd: Allow multi-byte read/write for generic paths
>        hw/sd/sd: Use multi-byte/block writes for block path
>        hw/sd/sdhci: Don't use bounce buffer for ADMA
>        hw/sd/sdcard: Add erase-blocks-as-zero option.
>        hw/sd/sdcard: Optimize erase blocks as zero.
>        hw/sd: Update trace events for buf+len data

3 changes from this series landed in the master branch for v11.1.0
release:

  468fa450a7e0c hw/sd: Switch read/write primitive to buf+len
  eff58d3d9681a hw/sd/sd: Allow multi-byte read/write for generic paths
  d7f3ab9d5a186 hw/sd: Update trace events for buf+len data


I don't see discussion about the other 4 changes, why these weren't
applied at the time, but ok.

Currently I'm picking up another change:

  b5424abaf8e9a hw/sd/sdcard: Keep high-capacity memory blocks at 512 bytes

to the current stable qemu series, and it touches the same area.
But the mentioned-above 3 changes are not included in 10.0 release,
while 10.0.x is an LTS stable series.  And without the first change
(switch to buf+len), things in 10.0.x are quite different.

So I can either pick the above 3 changes for 10.0.x, or I can omit
b5424abaf8e9a for 10.0.x.

To me it feels like picking up the above 3 optimization changes is the
way to go for 10.0.x.

What do you think?

BTW, doesn't b5424abaf8e9a actually fix 468fa450a7e0c, not 2d7adea4fe57?

Thanks,

/mjt

