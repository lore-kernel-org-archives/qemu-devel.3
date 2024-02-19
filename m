Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F4BC48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc51p-0005Gg-4c; Mon, 19 Feb 2024 09:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=xJN9=J4=kaod.org=clg@ozlabs.org>)
 id 1rc51n-0005GC-4Z; Mon, 19 Feb 2024 09:53:55 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=xJN9=J4=kaod.org=clg@ozlabs.org>)
 id 1rc51l-00081i-1V; Mon, 19 Feb 2024 09:53:54 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Tdlsf2QNJz4wcM;
 Tue, 20 Feb 2024 01:53:42 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tdlsb6Gwpz4wc9;
 Tue, 20 Feb 2024 01:53:39 +1100 (AEDT)
Message-ID: <b2820e70-9e58-4087-b072-5049dda7023a@kaod.org>
Date: Mon, 19 Feb 2024 15:53:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 22/49] hw/pci-host/raven.c: Mark raven_io_ops as
 implementing unaligned accesses
Content-Language: en-US, fr
To: BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
 <20240219082938.238302-23-npiggin@gmail.com>
 <754804d1-8bde-b23b-d136-e93d6d967987@eik.bme.hu>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <754804d1-8bde-b23b-d136-e93d6d967987@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=xJN9=J4=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

On 2/19/24 15:49, BALATON Zoltan wrote:
> On Mon, 19 Feb 2024, Nicholas Piggin wrote:
>> From: Peter Maydell <peter.maydell@linaro.org>
>>
>> The raven_io_ops MemoryRegionOps is the only one in the source tree
>> which sets .valid.unaligned to indicate that it should support
>> unaligned accesses and which does not also set .impl.unaligned to
>> indicate that its read and write functions can do the unaligned
>> handling themselves.  This is a problem, because at the moment the
>> core memory system does not implement the support for handling
>> unaligned accesses by doing a series of aligned accesses and
>> combining them (system/memory.c:access_with_adjusted_size() has a
>> TODO comment noting this).
>>
>> Fortunately raven_io_read() and raven_io_write() will correctly deal
>> with the case of being passed an unaligned address, so we can fix the
>> missing unaligned access support by setting .impl.unaligned in the
>> MemoryRegionOps struct.
>>
>> Fixes: 9a1839164c9c8f06 ("raven: Implement non-contiguous I/O region")
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>> Tested-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> 
> Hm, this seems to be missing the actual patch.

It's merged already and git knows how to handle this.

Thanks,

C.



