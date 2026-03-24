Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7305F532C3
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 02:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4rt7-0001fV-Ge; Mon, 23 Mar 2026 22:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1w4rt1-0001em-TM; Mon, 23 Mar 2026 22:52:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1w4rsx-0002RU-TV; Mon, 23 Mar 2026 22:52:55 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NLaATS3056990; Tue, 24 Mar 2026 02:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=8o+Eoq
 ajTIVOWcUzw0pXn6zRjyRhWdyRDAU8FJpERNw=; b=MnsatVdU9qxjdX2pxvNJ/J
 q62oi5oMdqav813C+vFoFUUFBn7k+t2H+inNy0GXvGWCwB/udkxarxExbz62xw+o
 LWmFmyjx3PHgDdpvsFpWn2Z3kjB4p0kOoZfrMzyvaPA2aF5UBlP9RNzxGlu77bEC
 V2Ztu/ZKmEsyfi1TJ5kVAvcATH2pVYZhJmZuK0iqPDFy1OdA1GDeOgAIwSa3H1Se
 5tlyIJPVmCx6r4Uh/BpoPg/hNrn7r+TBzuu1KfBUnWp4UAodfa6lCFxFX6+0GYLG
 fO6jiYkTpIlmZckT328/Cxn6QWtU0gstchN9Va2b+RnMhwC1s+y6akpwg4Pxztig
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxsguj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 02:52:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62O258n1031687;
 Tue, 24 Mar 2026 02:52:48 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nsr0du-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 02:52:48 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62O2qlMU28770820
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 02:52:47 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D5C6580A8;
 Tue, 24 Mar 2026 02:52:47 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D611A580A7;
 Tue, 24 Mar 2026 02:52:46 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.5.54]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Mar 2026 02:52:46 +0000 (GMT)
Message-ID: <c238a5cbbb85a8a79588b70f6d83c0dd604c4a09.camel@linux.ibm.com>
Subject: Re: [PATCH] tests/functional/s390x: Add test for booting from a
 disk with 4k sectors
From: Eric Farman <farman@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck
 <cohuck@redhat.com>, jrossi@linux.ibm.com
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>
Date: Mon, 23 Mar 2026 22:52:46 -0400
In-Reply-To: <20260323171423.112205-1-thuth@redhat.com>
References: <20260323171423.112205-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c1fc81 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=xXoDWlY1S6veOxXS:21 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=2ObfEJX_2zprj2BvoksA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDAyMSBTYWx0ZWRfXwAEX6rFCON3D
 UoUr6fTrAdQIeqcfKjULzI/5ae3IuRRo5lXFLlg1yWKq8ZnHrEPmZIBCoAOXPBJGvP999MNnxiI
 Y45V3uDFz9oN1tRZmWAuFXN6XjMYDtkQjk9YEZ/h74KpGKYM/9OnDJu7EMsP0WZZqI4Ym7B82a5
 Z8cV5ueuIu9yKTYmlcWnvQSrs73o/gsDG/sAFlauTi6ydcczbCtV7gdfyFItcAIFj4UOMlw/bea
 qWBtk6DgAGzuPn1m9QBFyS9Emyw9kjOr8Q8rv87gbvt54x5I2ZiSFzgH1ruziU9cqtb557H31UT
 ROQvTaAsKZ3qdrL5o2VIrgw8Q6+pgDHdEP6PYO89eu8N/fz0gRlDnmXO86avsyqoBCzBsMVYgQc
 StrIL6z2ggOyOMV6RAfmECDAVeq+dWIg/1fqs7kHhzF4zyKeRCRy/06W7fCp8MB6ifwS3GzSkWq
 f9x6lFe38RmSUA6hyrQ==
X-Proofpoint-GUID: 9NWV98bN26GW8GNgy9jvncrKmuLwDobh
X-Proofpoint-ORIG-GUID: 9NWV98bN26GW8GNgy9jvncrKmuLwDobh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_01,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240021
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 2026-03-23 at 18:14 +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
>=20
> The DASD disks on s390x have a different sector size (4k) and use
> a different layout of the boot loader data compared to the usual
> "SCSI"-style disks with 512 sectors that are used with most modern
> guests. To make sure that there are no regressions with 4k disk
> booting, add a test case that uses a disk image with these 4k sectors
> and check that we can successfully show the boot menu and and load the
> right kernel in all supported cases.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/s390x/meson.build     |   1 +
>  tests/functional/s390x/test_boot_4k.py | 138 +++++++++++++++++++++++++
>  2 files changed, 139 insertions(+)
>  create mode 100755 tests/functional/s390x/test_boot_4k.py

Thanks, Thomas!

Reviewed-by: Eric Farman <farman@linux.ibm.com>

>=20
> diff --git a/tests/functional/s390x/meson.build b/tests/functional/s390x/=
meson.build
> index 0f03e1c9db8..b065b666bc2 100644
> --- a/tests/functional/s390x/meson.build
> +++ b/tests/functional/s390x/meson.build
> @@ -10,6 +10,7 @@ tests_s390x_system_quick =3D [
>  ]
> =20
>  tests_s390x_system_thorough =3D [
> +  'boot_4k',
>    'ccw_virtio',
>    'pxelinux',
>    'replay',
> diff --git a/tests/functional/s390x/test_boot_4k.py b/tests/functional/s3=
90x/test_boot_4k.py
> new file mode 100755
> index 00000000000..965123ebd31
> --- /dev/null
> +++ b/tests/functional/s390x/test_boot_4k.py
> @@ -0,0 +1,138 @@
> +#!/usr/bin/env python3
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright 2026 Red Hat, Inc.
> +#
> +# Author:
> +#  Thomas Huth <thuth@redhat.com>
> +'''
> +Functional test that boots from a (incomplete) disk with 4k sectors
> +(DASD/ECKD geometry) and multiple kernels installed, so we can check
> +the boot menu and various LOADPARM options.
> +'''
> +
> +from qemu_test import QemuSystemTest, Asset, skipFlakyTest
> +from qemu_test import wait_for_console_pattern
> +
> +
> +class S390Boot4k(QemuSystemTest):
> +
> +    # This disk image has been taken from a DASD with 4k sectors.
> +    # Note: It's incomplete (to keep it small), it contains just enough
> +    # data for booting the kernels that are installed on the disk image
> +    ASSET_DISK =3D Asset(
> +        ('https://github.com/huth/qemu-paddock/raw/refs/heads/main/s390x=
/'
> +         'f32-4k-bootmenu.raw.xz'),
> +        'f4e2c91b4ec50a4756e8816b7a7c8ca01cc0d929f7a711cfd8124640c304ea4=
1')
> +
> +    def wait_for_pattern(self, success_message, vm=3DNone):
> +        wait_for_console_pattern(self, success_message, vm=3Dvm,
> +                                 failure_message=3D'panic')
> +
> +    def basic_machine_setup(self):
> +        self.set_machine('s390-ccw-virtio')
> +        disk_path =3D self.uncompress(self.ASSET_DISK, format=3D"xz")
> +
> +        self.vm.set_console()
> +        self.vm.add_args("-nographic", "-no-shutdown", "-blockdev",
> +                         f"driver=3Dfile,filename=3D{disk_path},node-nam=
e=3Dd1")
> +
> +    def test_default(self):
> +        '''
> +        Check that the default kernel boots up correctly from a ccw devi=
ce
> +        '''
> +        self.basic_machine_setup()
> +        self.vm.add_args("-device", "virtio-blk-ccw,drive=3Dd1")
> +        self.vm.launch()
> +        self.wait_for_pattern("Linux version 5.8.15-301.fc33.s390x")
> +        self.wait_for_pattern("Trying to unpack rootfs image as initramf=
s")
> +
> +    def test_loadparm_machine(self):
> +        '''
> +        Check that we can select a kernel via "-machine loadparm=3D..."
> +        '''
> +        self.basic_machine_setup()
> +        self.vm.add_args("-device", "virtio-blk-ccw,drive=3Dd1",
> +                         "-machine", "loadparm=3D2")
> +        self.vm.launch()
> +        self.wait_for_pattern("Linux version 5.6.6-300.fc32.s390x")
> +
> +    def test_loadparm_device(self):
> +        '''
> +        Check that we can select a kernel via  "-device ...,loadparm=3D.=
.."
> +        '''
> +        self.basic_machine_setup()
> +        self.vm.add_args("-device",
> +                         "virtio-blk-ccw,drive=3Dd1,bootindex=3D1,loadpa=
rm=3D3")
> +        self.vm.launch()
> +        self.wait_for_pattern("Linux version 5.6.6-300.fc32.s390x")
> +
> +    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/work_items/33=
50")
> +    def test_loadparm_pci(self):
> +        '''
> +        Check that we can select a kernel via  "-device ...-pci,loadparm=
=3D..."
> +        '''
> +        self.require_device('virtio-blk-pci')
> +        self.basic_machine_setup()
> +        self.vm.add_args("-device",
> +                         "virtio-blk-pci,drive=3Dd1,bootindex=3D1,loadpa=
rm=3D2")
> +        self.vm.launch()
> +        self.wait_for_pattern("Linux version 5.6.6-300.fc32.s390x")
> +
> +    def test_scsi_default(self):
> +        '''
> +        Check that we can boot via SCSI, too (need to set logical block =
size
> +        here to avoid that the auto-detection in the bios fails)
> +        '''
> +        self.basic_machine_setup()
> +        self.vm.add_args("-device", "virtio-scsi", "-device",
> +            "scsi-hd,drive=3Dd1,physical_block_size=3D4096,logical_block=
_size=3D4096")
> +        self.vm.launch()
> +        self.wait_for_pattern("Linux version 5.8.15-301.fc33.s390x")
> +
> +    def test_scsi_loadparm(self):
> +        '''
> +        Check that we can boot via SCSI with loadparm
> +        '''
> +        self.basic_machine_setup()
> +        self.vm.add_args("-device", "virtio-scsi", "-device",
> +                         ("scsi-hd,drive=3Dd1,bootindex=3D1,loadparm=3D3=
,"
> +                          "physical_block_size=3D4096,logical_block_size=
=3D4096"))
> +        self.vm.launch()
> +        self.wait_for_pattern("Linux version 5.6.6-300.fc32.s390x")
> +
> +    def test_menu(self):
> +        '''
> +        Check that boot menu shows up correctly
> +        '''
> +        self.basic_machine_setup()
> +        self.vm.add_args("-device", "virtio-blk-ccw,drive=3Dd1,bootindex=
=3D1",
> +                         "-boot", "menu=3Don")
> +        self.vm.launch()
> +        self.wait_for_pattern("1. Fedora (5.8.15-301.fc33.s390x) 33")
> +        self.wait_for_pattern("2. Fedora (5.6.6-300.fc32.s390x) 32")
> +        self.wait_for_pattern("3. Fedora (0-rescue-b7218f0092704c5a9")
> +        self.wait_for_pattern("Please choose:")
> +        # For some unknown reason, sending a key to the bios does not wo=
rk
> +        # in the testing framework yet:
> +        # exec_command_and_wait_for_pattern(self, '2',
> +        #                              "Linux version 5.6.6-300.fc32.s39=
0x")
> +
> +    def test_menu_timeout(self):
> +        '''
> +        Check that boot menu shows up and boot continues automatically
> +        when a timeout has been specified
> +        '''
> +        self.basic_machine_setup()
> +        self.vm.add_args("-device", "virtio-blk-ccw,drive=3Dd1,bootindex=
=3D1",
> +                         "-boot", "menu=3Don,splash-time=3D1")
> +        self.vm.launch()
> +        self.wait_for_pattern("s390-ccw zIPL Boot Menu")
> +        self.wait_for_pattern("0. default (Fedora (5.8.15-301.fc33.s390x=
)")
> +        self.wait_for_pattern("(default will boot in 0 seconds)")
> +        self.wait_for_pattern("Linux version 5.8.15-301.fc33.s390x")
> +
> +
> +if __name__ =3D=3D '__main__':
> +    QemuSystemTest.main()

