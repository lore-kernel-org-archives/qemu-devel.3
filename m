Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3C4C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 13:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc3TT-0001iD-47; Mon, 19 Feb 2024 08:14:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rc3TR-0001hA-EV; Mon, 19 Feb 2024 08:14:21 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rc3TP-0004TO-3j; Mon, 19 Feb 2024 08:14:21 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 60EBE4E6013;
 Mon, 19 Feb 2024 14:14:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id favqpBJ_dTtN; Mon, 19 Feb 2024 14:14:12 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6A5994E6003; Mon, 19 Feb 2024 14:14:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 68A437456B4;
 Mon, 19 Feb 2024 14:14:12 +0100 (CET)
Date: Mon, 19 Feb 2024 14:14:12 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH] tests/qtest: Fix boot-serial-test when using
 --without-default-devices
In-Reply-To: <359e3bf6-bd94-42e5-b8e7-06b41805fd03@redhat.com>
Message-ID: <f551a54a-788c-392a-e9b5-ff486aafa4e3@eik.bme.hu>
References: <20240219111030.384158-1-thuth@redhat.com>
 <b56a11d4-ef54-64ae-76ef-25c600255b59@eik.bme.hu>
 <359e3bf6-bd94-42e5-b8e7-06b41805fd03@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-722608179-1708348452=:77986"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--3866299591-722608179-1708348452=:77986
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 19 Feb 2024, Thomas Huth wrote:
> On 19/02/2024 12.37, BALATON Zoltan wrote:
>> On Mon, 19 Feb 2024, Thomas Huth wrote:
>>> If "configure" has been run with "--without-default-devices", there is
>>> no e1000 device in the binaries, so the boot-serial-test currently fails
>>> in that case since it tries to use the e1000 with the sam460ex machine.
>>> 
>>> Since we're testing the serial output here, and not the NIC, let's
>>> simply switch to the "pci-bridge" device here instead, which should
>>> always be there for PCIe-based machines like the sam460ex.
>> 
>> It's not actually testing PCIe but PCI bus but I think that does not 
>> matter. PCIe on sam460ex does not work yet, I've only implemented it 
>> partially to pass the firmware init but devices attached to the PCIe bus 
>> probably won't work. I have some patches to improve that but not yet ready.
>
> Ah, ok, I looked at the Kconfig file and saw the "select PCI_EXPRESS" there 
> that got selected by PPC440 (which gets selected by SAM460EX), that's why I 
> concluded that it must be "PCIe-based" ... I'll drop the "e" here.
>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>> tests/qtest/boot-serial-test.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>> 
>>> diff --git a/tests/qtest/boot-serial-test.c 
>>> b/tests/qtest/boot-serial-test.c
>>> index 6dd06aeaf4..e3b7d65fe5 100644
>>> --- a/tests/qtest/boot-serial-test.c
>>> +++ b/tests/qtest/boot-serial-test.c
>>> @@ -156,7 +156,7 @@ static const testdef_t tests[] = {
>>>       "Open Firmware" },
>>>     { "ppc64", "powernv8", "", "OPAL" },
>>>     { "ppc64", "powernv9", "", "OPAL" },
>>> -    { "ppc64", "sam460ex", "-device e1000", "8086  100e" },
>>> +    { "ppc64", "sam460ex", "-device pci-bridge,chassis_nr=2", "1b36 
>>> 0001" },
>> 
>> So if you want to check if PCI bus works then maybe there's no need to add 
>> a device at all just look for the sm501 display chip ("126f 0501") that's 
>> soldered on the board so it's always created even with -nodefaults and 
>> should always present on sam460ex. The -device option just adds a device 
>> that appears before the sm501 and stops the test there. Not sure if this is 
>> testing more than looking for a PCI device created by the board code.
>
> I was considering the sm501, too, but I thought that we might test a little 
> bit more if we check that cold-plugging via "-device" works, too, so I'd 
> prefer to keep it this way.

No problem, if testing -device is adding more coverage than testing for a 
device created by the board then I'm OK with it but not sure these are 
really different other than maybe -device going through options parsing 
but at the end for testing the PCI but they are probably the same.

Regards,
BALATON Zoltan
--3866299591-722608179-1708348452=:77986--

