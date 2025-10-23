Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55165CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 13:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuu7-0005u8-Ie; Thu, 23 Oct 2025 08:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBuu4-0005tc-TG; Thu, 23 Oct 2025 08:58:53 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vButx-00048F-Ue; Thu, 23 Oct 2025 08:58:49 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B62BF5972EA;
 Thu, 23 Oct 2025 14:58:39 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id GQrIU0lILz0X; Thu, 23 Oct 2025 14:58:37 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B323C5972DE; Thu, 23 Oct 2025 14:58:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B10D05972E8;
 Thu, 23 Oct 2025 14:58:37 +0200 (CEST)
Date: Thu, 23 Oct 2025 14:58:37 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v4 08/12] hw/ppc/pegasos2: Move hardware specific parts
 out of machine reset
In-Reply-To: <ee9b01ab-fd91-453e-b1d3-1a91d9447a2a@linaro.org>
Message-ID: <81856e15-36e0-be76-d51c-55915a8d1233@eik.bme.hu>
References: <cover.1761176219.git.balaton@eik.bme.hu>
 <f6633a68a72aad4fefb8d2373b52561f8ca8d41d.1761176219.git.balaton@eik.bme.hu>
 <ee9b01ab-fd91-453e-b1d3-1a91d9447a2a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-392806474-1761224317=:38722"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-392806474-1761224317=:38722
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 23 Oct 2025, Philippe Mathieu-Daudé wrote:
> On 23/10/25 02:06, BALATON Zoltan wrote:
>> Move the pegasos2 specific chipset reset out from machine reset to a
>> separate function and move generic parts that are not pegasos2
>> specific from build_fdt to machine reset so now build_fdt only
>> contains pegasos2 specific parts and can be renamed accordingly.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/ppc/pegasos2.c | 79 ++++++++++++++++++++++++-----------------------
>>   1 file changed, 41 insertions(+), 38 deletions(-)
>
>
>> -#define PCI1_IO_BASE  0xfe000000
>
> Can't we keep such definition?
>
>> @@ -308,23 +307,12 @@ static void 
>> pegasos2_pci_config_write(Pegasos2MachineState *pm, int bus,
>>     static void pegasos2_superio_write(uint8_t addr, uint8_t val)
>>   {
>> -    cpu_physical_memory_write(PCI1_IO_BASE + 0x3f0, &addr, 1);
>> -    cpu_physical_memory_write(PCI1_IO_BASE + 0x3f1, &val, 1);
>> +    cpu_physical_memory_write(0xfe0003f0, &addr, 1);
>> +    cpu_physical_memory_write(0xfe0003f1, &val, 1);
>
> Otherwise it is harder to notice we are accessing the MMIO mapped ISA space.

It might be misleading as it's PCI1 on pegasos2 but PCI0 on pegasos1 so 
the define does not clarify much either way even if I rename it to 
PCI_IO_BASE. Generally I think for numbers that are only used once having 
a define just obfuscates it as I then have to look up what the number is 
elsewhere instead of seeing right away. I guess I'll leave it as it is now 
that this version was pulled.

>>   }
> Consider renaming as pegasos_superio_write() since this method becomes
> common to PegasOS I and II.

This could have removed one hunk from patch 12 and adding it here making 
that patch shorter but this one longer so not much difference. Now that 
these are reviewed I think it does not matter any more.

Regards,
BALATON Zoltan

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>
>
--3866299591-392806474-1761224317=:38722--

