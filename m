Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2170B606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 06:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=UNs4/6EG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMgCy-0001YE-99; Fri, 30 Oct 2026 02:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xMgCj-0001XT-BS; Fri, 30 Oct 2026 02:35:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xMgCh-0000b7-OW; Fri, 30 Oct 2026 02:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793342104; bh=6731h3+ujd/myX06y5bK3DkN8Lvanfed0M3yzMI/1/Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=UNs4/6EGiUQrp7K27j03TLu3m0xonlLk4OET4/pPhdA90gsj4byccyKO7FwWkPmNU
 e0ASXJHpMk1WxSlQqERdgRZglcFupWi3ELkc+8sMQ7x1aME4E6EvUJ37XmEDDk983E
 vccwFmNn0J6ACKw+RILYgBqqai2oRfNAyPNdxf3pu2TfZtNGQ7vBVlgys+9qw4FwtR
 nXDy9bCPaU+VWGsYJp6CXK+ABkXhDdB8APKDg4zG1vYS292TqTwBwAPnCPwiujCz0q
 6B5ra8+em9kUPz0p9src6vq70djihmkELX9Ke7bYNKFVOLtLj0qGoJHJ9NbHnNFZP/
 vgE72DNTb4NRA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E9EBD1E2740;
 Fri, 30 Oct 2026 09:35:04 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A3E8144EC5D;
 Fri, 30 Oct 2026 09:35:04 +0300 (MSK)
Message-ID: <379a2300-b1af-4b32-9d10-7a8347c22476@tls.msk.ru>
Date: Fri, 30 Oct 2026 09:35:04 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] hw/cxl: fix Type-3 device reset resource leaks and
 convert to three-phase
To: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org
Cc: jic23@kernel.org, linux-cxl@vger.kernel.org, philmd@oss.qualcomm.com,
 qemu-stable@nongnu.org
References: <20260729144645.1552511-1-junjie.cao@intel.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260729144645.1552511-1-junjie.cao@intel.com>
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

On 7/29/26 17:46, Junjie Cao wrote:
> The CXL Type-3 device reset path (ct3d_reset) has several issues:
> 
> 1) Resource leaks:
> 2) Incomplete state cleanup:
> 3) Deprecated API usage:
> 
> This series fixes the issues incrementally:
>    - Patches 1-2: fix resource leaks (deterministic bugs)
>    - Patch 3: mechanical conversion to three-phase reset
>    - Patch 4: factor the primary CCI teardown into a
>      cxl_destroy_mailbox_t3() helper pairing cxl_initialize_mailbox_t3()
>    - Patches 5-7: clean up device state on reset

> Junjie Cao (7):
>    hw/cxl: fix timer leak in cxl_destroy_cci()
>    hw/cxl: destroy primary CCI before re-initialization on reset
>    hw/cxl: convert cxl-type3 to three-phase reset
>    hw/cxl: add cxl_destroy_mailbox_t3() as the mailbox teardown
>      counterpart
>    hw/cxl: discard in-flight sanitize state on mailbox teardown
>    hw/cxl: clear event logs, scan media and interrupt policy on reset
>    hw/cxl: clear poison lists and feature transfer state on reset
Hi!

This patch series has been Cc'ed to qemu-stable@.  It is interesting how
it's been Cc'ed, and I think there's some error here.  From whole series,
only patch 2 (destroy primary CCI before re-initialization on reset) is
tagged for-stable.  Patch 1, which is a fix, is not tagged, and not Cc'ed
to qemu-stable@ either.  The rest - patches 3-7 - has been Cc'ed to the
qemu-stable mailing list, but are not tagged for-stable.

 From this list, I'm only picking up patch 2, and only for 11.1.x series.
The other active stable series, 10.0.x, - apparently it's not needed there.

FWIW.

Thanks,

/mjt

