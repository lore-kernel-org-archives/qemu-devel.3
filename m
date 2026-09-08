Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AB1C79FA0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 06:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3pZP-0002mt-Cs; Tue, 08 Sep 2026 02:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1x3pZN-0002mb-QM; Tue, 08 Sep 2026 02:44:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1x3pZL-0003Rv-Gh; Tue, 08 Sep 2026 02:44:37 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886VY7k4125370; Tue, 8 Sep 2026 06:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vu7iau
 vV00cS1Dx5a+lbFPp72vZtDNB+CMMKBaqGbRI=; b=g0L2QSNfMLMPkmlX0rZYc3
 RI6pkC7ot+QiGEpmdS30Zohic9/ICqgR3Hg5DVVSAte5FpjLpgehfro5VXhDId0D
 kfNnaVah6YBxeORfrQlxKnIZlw6ZF/FR50+5ZocV6KmbrYekxP/ntktMJ+DyjajR
 ha+Zv/BD1JPIPLR6jDAi/6gy1VG5Dd9XDyurm6ZKEUST/B/TNzVdU/rmerOs5tr7
 YWZCzoeg6fpRW2J/w9d8/RlwO1wIMOrIsWFVuNd0u7FOviotEfx5HBx/Um9OC9F7
 FfqeYZpQHJOhrQExFMCIFSb0VTLsT5WYJJ5bDv/F9523mAtwWebPiCdt5w1RRBAw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbj84unn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 06:44:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6886fI0h000974;
 Tue, 8 Sep 2026 06:44:31 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxdjt644-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 06:44:31 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6886iUmq6816372
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Sep 2026 06:44:30 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 476D85805C;
 Tue,  8 Sep 2026 06:44:30 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94A825805A;
 Tue,  8 Sep 2026 06:44:26 +0000 (GMT)
Received: from [9.123.8.44] (unknown [9.123.8.44])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Sep 2026 06:44:26 +0000 (GMT)
Message-ID: <039b3deb-bc68-4722-8d36-7e02fecfa29d@linux.ibm.com>
Date: Tue, 8 Sep 2026 12:14:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/ppc64: add pseries migration and powernv
 NVMe tests
To: Thomas Huth <thuth@redhat.com>, npiggin@gmail.com,
 Chinmay Rath <rathc@linux.ibm.com>, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: anushree.mathur@linux.ibm.com, misanjum@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com
References: <77e89fea-0284-4e19-8ee7-04b900b13749@linux.ibm.com>
 <ba2ecdc6-8a8f-4217-a3e1-0cfb52a9636f@redhat.com>
Content-Language: en-US
From: Aniket Sahu <asahu1x@linux.ibm.com>
In-Reply-To: <ba2ecdc6-8a8f-4217-a3e1-0cfb52a9636f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 51ZaIacL2iLVnzi7D1Wu9V-KXN8s9jrc
X-Proofpoint-ORIG-GUID: GdmW6eQtbRHVzmdjq3qYpT-tOr_vQmEO
X-Authority-Analysis: v=2.4 cv=RNCD2Yi+ c=1 sm=1 tr=0 ts=6a9faed0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=OFzRsJEkfH1q1aqOoxkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA2OSBTYWx0ZWRfXzhzU0V9Ma7bD
 56Lze6RWe1dJWuaqGJooaPl6oik9dq8NKe7hfERQHibYPlZYdlXY5F4YcTjVkqsO++LzJz7YPe7
 /4+AzBrwa5mZQCoiQZvk+bG/rq/HTPM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA2OSBTYWx0ZWRfX7jogoNChOnHe
 YL6SyY6YvBH0bEXD01nPfCU2fc94mPyDyaE0ODhNIA1jG5ICdQpFRiAvcL31L06JpCVPvnJeYCc
 gOgt1BoMR9ej5FZZO+ihuCwAuqm/UwJNX+hiWhoHc6oJQdezsmcUcwGSNPXOizqNvh/8VpPKtYC
 1fuzwFjbb9Kcev8Pn4sO3BQGwHB0vVOq8hwlOPOai7NYeOc5kkNsPq5eXUkjlCJ3mAuzVaWHvzD
 E1J9Q4j/VMIPgWVXBMJKAjPX4vgu5tRKYxUNu3pRgcykSjEAlpCvwduNjDXqRVhQge6dsc0TkIP
 82vSLAiwlg7A9iH2FMrX4yhVfUcE5xAXr1tX8o1LUqI+Lc2kG6IJ7rseZ9dJMPxh4KazmwxWjBE
 ckjxTKRRzZS+uLkQKBmUfGi+/Y7/8dvUXQlFSc+oQnZXykitK/3FMQuniTCTdO0eJe43gYlJodb
 WbJDvBkRhVJQuntA0/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080069
Received-SPF: pass client-ip=148.163.158.5; envelope-from=asahu1x@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Thomas,

Thanks for reviewing my patch!

On 07/09/26 5:08 PM, Thomas Huth wrote:
> On 30/08/2026 19.52, Aniket Sahu wrote:
>> Add two new groups of functional tests that cover scenarios currently
>> missing from the ppc64 test suite:
>>
>> 1. pseries live migration (pseries machine type)
>>     - Extends the quick migration suite (already covering mac99) with
>>       tcp-localhost, UNIX socket, and exec (socat) migration tests for
>>       the pseries machine type.  This complements the existing
>>       test_ppc64_linux_migration test in test_pseries.py (which boots a
>>       full kernel) by providing lightweight no-boot migration smoke 
>> tests
>>       that run quickly.
>
> Is this worth the effort? If we already have a full migration test 
> with a booted kernel, what do we really gain by testing again without 
> a kernel?
The full migration tests are longer and part of the thorough execution 
cycle. Moreover, the full migration test only exercises migration with 
TCP-localhost. The tests defined add a quick TCP-localhost test, along 
with UNIX socket and socat migration tests. The idea was I saw these 
tests were covered for mac99 in tests/functional/ppc64/test_migration.py 
and I wanted to add those for powervm and powernv too. These would run 
within a few seconds and will be covered in the quick cycle, acting as 
smoke tests for all the migration paths. Perhaps we can consider keeping 
these tests as a quick regression check, or remove the no boot tests 
entirely while also expanding the full-boot tests with UNIX socket and 
socat migration path tests?
>
> Also, you are adding two completely different tests with one patch 
> here. I'd suggest to split this into two separate patches instead.
Ack, will address in V2 series.
>
>> 2. PowerNV NVMe + network device boot (powernv machine type)
>>     - The existing do_test_ppc64_powernv() helper in test_powernv.py
>>       already boots a rootfs from NVMe for P8/P9/P10/P11.  This patch
>>       adds a complementary test that also verifies the e1000e network
>>       adapter and USB xHCI controller are probed successfully by Linux -
>>       previously these were present in the device args but no console
>>       check was made for them.
>>     - Adds test_powernv10_rainier() for the powernv10-rainier variant
>>       that models the IBM Rainier system board.
>>
>> Signed-off-by: Aniket Sahu <asahu1x@linux.ibm.com>
>>
>> diff --git a/tests/functional/ppc64/meson.build 
>> b/tests/functional/ppc64/ meson.build
>> index cb3c745624..19c32c8b67 100644
>> --- a/tests/functional/ppc64/meson.build
>> +++ b/tests/functional/ppc64/meson.build
>> @@ -1,6 +1,8 @@
>>   # SPDX-License-Identifier: GPL-2.0-or-later
>>
>>   test_ppc64_timeouts = {
>> +  'pseries_migrate' : 60,
>
> Default timeout for the tests is 90, please don't add something with 
> lower values, ie. simply drop the above line.
Ack. Will address in V2
>
> ...
>> diff --git a/tests/functional/ppc64/test_powernv_devices.py b/tests/ 
>> functional/ppc64/test_powernv_devices.py
>> new file mode 100644
>> index 0000000000..6135855612
>> --- /dev/null
>> +++ b/tests/functional/ppc64/test_powernv_devices.py
>> @@ -0,0 +1,151 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Functional tests that boot Linux on powernv machines and explicitly
>> +# verify that PCIe-attached devices (NVMe, e1000e, xHCI USB) are
>> +# detected by the guest kernel.  Also covers the powernv10-rainier
>> +# board variant.
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +from qemu_test import LinuxKernelTest, Asset
>> +
>> +
>> +class PowerNVDevicesTest(LinuxKernelTest):
>> +    """
>> +    Boot Linux on powernv variants and verify that PCIe devices are
>> +    detected by the guest.
>> +
>> +    The existing test_powernv.py::do_test_ppc64_powernv() attaches an
>> +    NVMe drive, an e1000e NIC, and an xHCI USB controller, but only
>> +    waits for the CPU-generation string and the init process. This
>> +    test adds explicit console pattern checks for each device so that
>> +    regressions in device enumeration or PCI/PCIe topology are caught.
>> +
>> +    An additional test covers powernv10-rainier (the IBM Rainier system
>> +    board variant) which has a slightly different PHB topology.
>> +    """
>> +
>> +    timeout = 480
>> +
>> +    ASSET_KERNEL = Asset(
>> + ('https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/'
>> +         'buildroot/qemu_ppc64le_powernv8-2025.02/vmlinux'),
>> + '6fd29aff9ad4362511ea5d0acbb510667c7031928e97d64ec15bbc5daf4b8151')
>> +
>> +    ASSET_INITRD = Asset(
>> + ('https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/'
>> +  'buildroot/qemu_ppc64le_powernv8-2025.02/rootfs.ext2'),
>> + 'aee2192b692077c4bde31cb56ce474424b358f17cec323d5c94af3970c9aada2')
>> +
>> +    def setUp(self):
>> +        super().setUp()
>> +        self.require_accelerator('tcg')
>> +
>> +    def _do_test_powernv_pcie_devices(self, machine):
>> +        """
>> +        Boot *machine* and verify NVMe, e1000e, and xHCI are detected.
>> +
>> +        Device topology (matches the existing do_test_ppc64_powernv 
>> helper):
>> +          pcie.2  → NVMe drive (boot device, rootfs)
>> +          bridge1 → e1000e NIC (addr 0x3)
>> +          bridge1 → nec-usb-xhci (addr 0x2)
>> +
>> +        Expected kernel log patterns checked:
>> +          * "nvme nvme0" — NVMe controller probe
>> +          * "e1000e"     — Intel e1000e NIC probe
>> +          * "xhci_hcd"   — USB xHCI host controller probe
>> +          * "Run /sbin/init as init process" — reached userland
>> +        """
>> +        kernel_path = self.ASSET_KERNEL.fetch()
>> +        initrd_path = self.ASSET_INITRD.fetch()
>> +
>> +        self.set_machine(machine)
>> +        self.vm.set_console()
>> +        self.vm.add_args(
>> +            '-kernel', kernel_path,
>> +            '-drive',
>> + f'file={initrd_path},format=raw,if=none,id=drive0,readonly=on',
>> +            '-append', 'root=/dev/nvme0n1 console=tty0 console=hvc0',
>> +            '-device', 
>> 'pcie-pci-bridge,id=bridge1,bus=pcie.1,addr=0x0',
>> +            '-device', 
>> 'nvme,drive=drive0,bus=pcie.2,addr=0x0,serial=1234',
>> +            '-device', 'e1000e,bus=bridge1,addr=0x3',
>> +            '-device', 'nec-usb-xhci,bus=bridge1,addr=0x2',
>> +        )
>> +        self.vm.launch()
>> +
>> +        # NVMe controller should be detected first (it is the boot 
>> disk).
>> +        self.wait_for_console_pattern('nvme nvme0')
>> +
>> +        # e1000e NIC detection.
>> +        self.wait_for_console_pattern('e1000e')
>> +
>> +        # USB xHCI host controller detection.
>> +        self.wait_for_console_pattern('xhci_hcd')
>> +
>> +        # System reached userland — final sanity check.
>> +        self.wait_for_console_pattern('Run /sbin/init as init process')
>> +
>> +    def test_powernv8_pcie_devices(self):
>> +        """powernv8 (P8): NVMe + e1000e + xHCI detected."""
>> +        self._do_test_powernv_pcie_devices('powernv8')
>> +
>> +    def test_powernv9_pcie_devices(self):
>> +        """powernv9 (P9): NVMe + e1000e + xHCI detected."""
>> +        self._do_test_powernv_pcie_devices('powernv9')
>> +
>> +    def test_powernv10_pcie_devices(self):
>> +        """powernv10 (P10): NVMe + e1000e + xHCI detected."""
>> +        self._do_test_powernv_pcie_devices('powernv10')
>> +
>> +    def test_powernv11_pcie_devices(self):
>> +        """powernv11 (P11): NVMe + e1000e + xHCI detected."""
>> +        self._do_test_powernv_pcie_devices('powernv11')
>
> Booting a kernel always takes a lot of time. So please don't add new 
> test for this. If you feel like we really should check for those PCIe 
> devices, please extend the existing test in 
> tests/functional/ppc64/test_powernv.py instead.

Ack, it seems the devices are already covered in test_powernv.py, the 
only difference being the console checks are not done, as udev probing 
is not reliable according to the comments left by you.

 > +    def test_powernv10_rainier_pcie_devices(self):
 > +        """
 > +        powernv10-rainier: NVMe + e1000e + xHCI detected.
 > +
 > +        The Rainier board variant maps PCIe root ports slightly
 > +        differently from the default powernv10 topology. Verify that
 > +        the same device set is enumerated successfully.
 > +        """
 > + self._do_test_powernv_pcie_devices('powernv10-rainier')

However, the rainier variant test is a new addition. Will raise a patch 
as part of V2 series adding just this test to test_powernv.py.

Thanks and Regards,
Aniket.


