Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F30606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQG76fqU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLR4C-0007na-AW; Mon, 26 Oct 2026 16:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLR49-0007mx-2k; Mon, 26 Oct 2026 16:13:09 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLR47-0007QO-Bl; Mon, 26 Oct 2026 16:13:08 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 302B542E58;
 Mon, 26 Oct 2026 20:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44091F01825;
 Mon, 26 Oct 2026 20:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793045585;
 bh=E2iFOs934WpliDmYAYioQN7s7aQqrIuN5257mq5FjSU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=hQG76fqUmk4zQ57DV+Sz/2xMYWFEWdGiplFcP8e7HFRs/R5917mQdReuYXTkPAT3t
 +UCRCf/CwPHyszD4wIFm6qYapwLO4JxmUb2mlqAL/tVBuz1la96hpTzrqYVhikk32C
 YMNGEfi9SUUxzdXZehgxw+VIabwdH0PDtcy0JGEdsSoezNjL8Oi8Lx3wwTLjTEqU70
 ck1mumzBSl9QVVxlIInXYg5iEoHXgjc3cBdAw5goUUROCSjmKATAA2GOmYEzywFRF/
 3MkSUPkRl5xuY7m0BJf8CwqAMAxnVFUXGwOPKSmPpi0FcaqX6KX3ZPa30JqUYuD9Qm
 R0B2L9Mq8ee/Q==
Message-ID: <e7e0796a-f72d-457b-804b-df763dcdea7e@kernel.org>
Date: Mon, 26 Oct 2026 21:13:00 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 0/7] hw/nvme: lift IOV_MAX limit in DMA path
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20261026-align-nvme-mdts-with-linux-v3-0-a33bd7c32df9@samsung.com>
 <at9AJGxUZvRoBrBw@AALNPWKJENSEN.aal.scsc.local>
 <85edb886-aa9a-4fab-a60f-ba73e00f7d25@kernel.org>
 <at-UlkpzVjYpu5hO@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <at-U5wQHWpZTamYy@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
In-Reply-To: <at-U5wQHWpZTamYy@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26/10/2026 18.59, Peter Xu wrote:
> Cc Stefan & Kevin, for real.
> 
> On Mon, Oct 26, 2026 at 01:57:42PM -0400, Peter Xu wrote:
>> On Mon, Oct 26, 2026 at 01:39:58PM +0100, Daniel Gomez wrote:
>>> On 26/10/2026 13.03, Klaus Jensen wrote:
>>>> On Oct 26 11:11, Daniel Gomez wrote:
>>   - the existing qemu_iovec_discard_back() was introduced back in 2014 in
>>     commit 58f423fbd5, with a mention of fixing
>>     /x86_64/ide/bmdma/short_prdt.  Then if patch 1 fixed it up due to some
>>     regression, first question I have is why it wasn't spot by unit test.
>>     Maybe we missed some test?  Or others?

I can't seem to find the test sending unaligned requests? discard_back is
only triggered if the caller (the prdt various test) sends unaligned
requests.

For clarity, the patch only restores the behavior back:

The regression (99868af3d0):

@@ -160,8 +161,9 @@ static void dma_blk_cb(void *opaque, int ret)
         return;
     }

-    if (dbs->iov.size & ~BDRV_SECTOR_MASK) {
-        qemu_iovec_discard_back(&dbs->iov, dbs->iov.size & ~BDRV_SECTOR_MASK);
+    if (!QEMU_IS_ALIGNED(dbs->iov.size, dbs->align)) {
+        qemu_iovec_discard_back(&dbs->iov,
+                                QEMU_ALIGN_DOWN(dbs->iov.size, dbs->align));

Fix:

@@ -174,8 +174,7 @@ static void dma_blk_cb(void *opaque, int ret)
     }

     if (!QEMU_IS_ALIGNED(dbs->iov.size, dbs->align)) {
-        qemu_iovec_discard_back(&dbs->iov,
-                                QEMU_ALIGN_DOWN(dbs->iov.size, dbs->align));
+        qemu_iovec_discard_back(&dbs->iov, dbs->iov.size % dbs->align);
     }

>>   - qemu_iovec_discard_back() alone seems risky on its own, which is the
>>     fundation of this whole series: 

Not really. But this is what triggered patch 2: to ensure requests are 
always aligned. This means, qemu_iovec_discard_back() is never in the path
for large IO.

>>   - for patch 2, it seems to me it's only fixing the case when discard
>>     worked in the middle not at the end.  

We don't trigger the discard path. Patch 2, ensures that by sending always
aligned requests.


