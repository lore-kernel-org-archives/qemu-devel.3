Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D902ACEF161
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 12:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy9aG-0005zd-4d; Tue, 08 Oct 2024 08:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=q5zo=RE=kaod.org=clg@ozlabs.org>)
 id 1sy9aD-0005yA-2L; Tue, 08 Oct 2024 08:44:57 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=q5zo=RE=kaod.org=clg@ozlabs.org>)
 id 1sy9aA-0001J3-U1; Tue, 08 Oct 2024 08:44:56 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XNG1n2Ch0z4xVR;
 Tue,  8 Oct 2024 23:44:45 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XNG1h3Rv4z4xQW;
 Tue,  8 Oct 2024 23:44:40 +1100 (AEDT)
Message-ID: <39750f12-b3ce-4653-91e0-988889ef0d02@kaod.org>
Date: Tue, 8 Oct 2024 14:44:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.2 v3 0/3] hw/ssi/pnv_spi: Remove PnvXferBuffer and
 get_seq_index()
To: Nicholas Piggin <npiggin@gmail.com>,
 Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, calebs@linux.ibm.com,
 chalapathi.v@ibm.com, saif.abrar@linux.ibm.com, dantan@linux.vnet.ibm.com,
 milesg@linux.ibm.com, philmd@linaro.org, alistair@alistair23.me
References: <20240918165045.21298-1-chalapathi.v@linux.ibm.com>
 <D4Q989HQVNJA.3LVK3LEUYT1G4@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <D4Q989HQVNJA.3LVK3LEUYT1G4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=q5zo=RE=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/8/24 09:43, Nicholas Piggin wrote:
> On Thu Sep 19, 2024 at 2:50 AM AEST, Chalapathi V wrote:
>> Hello,
>>
>> v3:
>> 1. Update the PowerNV maintainer section to include hw/ssi/pnv_spi*
>> 2. Use of PnvXferBuffer results in a additonal process overhead due to
>> frequent dynamic allocations and hence use an existing Fifo8 buffer.
>> 3. Use a local variable seq_index and use it with in while loop instead
>> of repeatedly calling get_seq_index() and make sure s->seq_op doesn't
>> overrun when seq_index is incremented.
>>
>> Tested:
>> passed make check and make check-avocado
>>
>> Supersedes: <20240807202804.56038-1-philmd@linaro.org>
> 
> Hi Chalapathi,
> 
> To be clear, this fixes Coverity CID 1558831? A Resolves:
> tag for the CID should be there, I guess it's patch 2?


Patches should have a tag :

Resolves: Coverity CID XYZZY

Thanks,

C.


> 
> I like patch 2, but since it is quite a significant change,
> should we take the v2 series first which is much smaller,
> then add this conversion on top of it?
> 
> If it was long-standing code that would be important (because
> you don't want to introduce regressions or conflicts when
> backporting fixes). Since this is a new model I guess there
> is leeway to just take v3 as is.
> 
> Thanks,
> Nick
> 
>>
>> Philippe Mathieu-Daudé (1):
>>    MAINTAINERS: Cover PowerPC SPI model in PowerNV section
>>
>> Chalapathi V (2):
>>    hw/ssi/pnv_spi: Replace PnvXferBuffer with Fifo8 structure
>>    hw/ssi/pnv_spi: Use local var seq_index instead of get_seq_index().
>>
>>   MAINTAINERS              |   2 +
>>   include/hw/ssi/pnv_spi.h |   3 +
>>   hw/ssi/pnv_spi.c         | 228 +++++++++++++++------------------------
>>   3 files changed, 89 insertions(+), 144 deletions(-)
> 


