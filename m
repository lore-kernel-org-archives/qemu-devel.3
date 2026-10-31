Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF881606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 20:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=ktAYtiNY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNG2G-0007wX-IP; Sat, 31 Oct 2026 16:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xNG2C-0007wE-Nk; Sat, 31 Oct 2026 16:50:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xNG2A-0004ZG-75; Sat, 31 Oct 2026 16:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793479825; bh=aWvHt17uMo64E+aJMbxlk1LmvKPP0d19UsYBc1/GfMA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ktAYtiNYV/RUfevjHrqXGpWzrPCGP7alTsMgq545IAxqZnZMSxmJl97j/2hXxKLE0
 T4KNVdBANaCxOdpPurB+ANHwyjy5i3whCmafwAgZ7oz8CQbVq76UghGDIfRDYat+IL
 QHZtQVFGZw+Ao/D8ttTH5noFhzDGQJ7XZnw+kGZShVMls9sG/4PhPyU8LymK6TnJ2j
 q060JS2BYMiYMz16JREcGemcRyahfqdv8gEbxeK57mLcuZHjImFVtaF/7oezxiuoz/
 E8ToiAoHLy5BWMqsaZN6EePDC+pG8i/Htu2n/0Z+TM7x9q8HBSsh8zgU5HF+DQghKP
 KSv0aYQn3df3w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4B4331E2CF4;
 Sat, 31 Oct 2026 23:50:25 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D8AE944FC7F;
 Sat, 31 Oct 2026 23:50:24 +0300 (MSK)
Message-ID: <0dccaee9-4294-4645-9432-e17142c7b0d9@tls.msk.ru>
Date: Sat, 31 Oct 2026 23:50:24 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] hw/cxl: fix Type-3 device reset resource leaks and
 convert to three-phase
To: Junjie Cao <junjie.cao@linux.dev>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, jic23@kernel.org,
 philmd@oss.qualcomm.com, linux-cxl@vger.kernel.org
References: <20260729144645.1552511-1-junjie.cao@intel.com>
 <379a2300-b1af-4b32-9d10-7a8347c22476@tls.msk.ru>
 <20261030124431.1066454-1-junjie.cao@linux.dev>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261030124431.1066454-1-junjie.cao@linux.dev>
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

On 10/30/26 15:44, Junjie Cao wrote:
> Hi Michael,
> 
> On 30/10/26 14:35, Michael Tokarev wrote:
>> This patch series has been Cc'ed to qemu-stable@.  It is interesting how
>> it's been Cc'ed, and I think there's some error here.  From whole series,
>> only patch 2 (destroy primary CCI before re-initialization on reset) is
>> tagged for-stable.  Patch 1, which is a fix, is not tagged, and not Cc'ed
>> to qemu-stable@ either.  The rest - patches 3-7 - has been Cc'ed to the
>> qemu-stable mailing list, but are not tagged for-stable.
> 
> Thanks for pointing this out. Only patches 1 and 2 were intended
> for stable; I copied qemu-stable@ on the whole series. I'll keep
> the stable Cc limited to the relevant patches in future.
> 
> Patch 1 carries the tag both on the list and in 259b877eac, and you
> already have it as 4a39c7d61e in 11.1.2.  So for 11.1.x patch 2 is
> indeed the only one left.
> 
>>  From this list, I'm only picking up patch 2, and only for 11.1.x series.
>> The other active stable series, 10.0.x, - apparently it's not needed there.
> 
> Neither applies to 10.0 as-is since cxl_destroy_cci() only exists from
> 10.1, but the leak is there too: ct3d_reset() re-runs cxl_init_cci() on
> all three CCIs, allocating a new timer each time.  I've just sent a
> 10.0 version, "[PATCH stable-10.0] hw/cxl: free the CCI background
> timer on Type-3 reset and exit".
Thank you very much for the explanation and for writing the fix for
10.0.x.  I thought the prob actually doesn't exist there ;)

/mjt

