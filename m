Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5907C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ZQh-0004W4-MX; Fri, 18 Sep 2026 10:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1x7ZQd-0004Vq-A4; Fri, 18 Sep 2026 10:19:03 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1x7ZQa-0007Kf-Vm; Fri, 18 Sep 2026 10:19:03 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6B0035832AB;
 Fri, 18 Sep 2026 16:18:55 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id cNwInrsmcsOu; Fri, 18 Sep 2026 16:18:52 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E75745831F1; Fri, 18 Sep 2026 16:18:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E57425831F0;
 Fri, 18 Sep 2026 16:18:52 +0200 (CEST)
Date: Fri, 18 Sep 2026 16:18:52 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: "Kirill A. Korinsky" <kirill@korins.ky>, 
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org
Subject: Re: [PATCH 5/5] tests/functional: Boot OpenBSD on mac99
In-Reply-To: <7b782da8-5424-4c6c-b9b7-7ca50fc6749b@ilande.co.uk>
Message-ID: <0a82d49f-61ad-32e5-fd78-9adbe2e6c2c6@eik.bme.hu>
References: <20260903115229.95811-1-kirill@korins.ky>
 <20260903115229.95811-6-kirill@korins.ky>
 <7b782da8-5424-4c6c-b9b7-7ca50fc6749b@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Fri, 18 Sep 2026, Mark Cave-Ayland wrote:
> On 03/09/2026 12:50, Kirill A. Korinsky wrote:
>
>> OpenBSD device discovery exercises CTPR masking, zero decrementer
>> writes, and CUDA reply timing and layout; regressions in any of these
>> paths stall the guest before the installer starts.
>> 
>> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
>> ---
>>   tests/functional/ppc/meson.build     |  2 ++
>>   tests/functional/ppc/test_openbsd.py | 46 ++++++++++++++++++++++++++++
>>   2 files changed, 48 insertions(+)
>>   create mode 100755 tests/functional/ppc/test_openbsd.py
>> 
>> diff --git a/tests/functional/ppc/meson.build 
>> b/tests/functional/ppc/meson.build
>> index ae061fe5a6..1055cdaa17 100644
>> --- a/tests/functional/ppc/meson.build
>> +++ b/tests/functional/ppc/meson.build
>> @@ -2,6 +2,7 @@
>>     test_ppc_timeouts = {
>>     '40p' : 240,
>> +  'openbsd' : 240,
>>   }
>>     tests_ppc_system_quick = [
>> @@ -15,6 +16,7 @@ tests_ppc_system_thorough = [
>>     'bamboo',
>>     'mac',
>>     'mpc8544ds',
>> +  'openbsd',
>>     'ppe42',
>>     'replay',
>>     'sam460ex',
>> diff --git a/tests/functional/ppc/test_openbsd.py 
>> b/tests/functional/ppc/test_openbsd.py
>> new file mode 100755
>> index 0000000000..cf45930a7c
>> --- /dev/null
>> +++ b/tests/functional/ppc/test_openbsd.py
>> @@ -0,0 +1,46 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Test that OpenBSD boots on mac99 and reaches the installer.
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +from qemu_test import QemuSystemTest, Asset
>> +from qemu_test import wait_for_console_pattern
>> +
>> +
>> +class OpenBSDMac99(QemuSystemTest):
>> +
>> +    ASSET_CD = Asset(
>> +        'https://ftp.eu.openbsd.org/pub/OpenBSD/7.9/macppc/cd79.iso',
>> + 
>> '227fef3d5089d56ce8376d8bfa28181ce5b19f0eceef0a6d82d58d8e52832b24')
>> +
>> +    def test_openbsd_79_installer(self):
>> +        self.set_machine('mac99')
>> +        self.require_accelerator('tcg')
>> +        cdrom_path = self.ASSET_CD.fetch()
>> +
>> +        self.vm.set_console()
>> +        self.vm.add_args('-M', 'via=cuda,graphics=off,usb=off',

Isn't via=cuda still the default? But why not use via=pmu instead that 
actually emulates something that exists in real life as opposed to G4 with 
cuda which does not match the rest of the hardware mac99 emulates. With 
mac99,via=pmu it is close to a real PowerMac3,1 Mac which is also what 
OpenBIOS tells the guest so I think that's a better config to use.

Regards,
BALATON Zoltan

>> +                         '-cpu', '7400',
>> +                         '-accel', 'tcg,thread=single',
>> +                         '-smp', '1',
>> +                         '-m', '2g',
>> +                         '-nic', 'none',
>> +                         '-device', 'VGA',
>> +                         '-global', 'cuda.sr-delay-ns=0',
>> +                         '-prom-env', 'input-device=ttya',
>> +                         '-prom-env', 'output-device=ttya',
>> +                         '-cdrom', cdrom_path,
>> +                         '-boot', 'd',
>> +                         '-no-reboot')
>> +        self.vm.launch()
>> +
>> +        wait_for_console_pattern(self, 'OpenBSD 7.9 (RAMDISK)', 'panic:')
>> +        wait_for_console_pattern(
>> +            self,
>> +            '(I)nstall, (U)pgrade, (A)utoinstall or (S)hell?',
>> +            'panic:')
>> +
>> +
>> +if __name__ == '__main__':
>> +    QemuSystemTest.main()
>
> LGTM, although I'm curious as to why you need to set usb=off - given that USB 
> is mandatory for mac99 machines, presumably this means there is a bug 
> somewhere in our OHCI emulation somewhere being tickled by OpenBSD?
>
>
> ATB,
>
> Mark.
>
>
>

