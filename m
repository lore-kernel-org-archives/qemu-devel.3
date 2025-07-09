Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3ABC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 18:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZZsZ-0006qQ-Cy; Wed, 09 Jul 2025 14:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1uZZqI-0005Rf-VG; Wed, 09 Jul 2025 14:48:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1uZZqF-0002El-QN; Wed, 09 Jul 2025 14:48:30 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569FRWS9028222;
 Wed, 9 Jul 2025 18:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ynpQ9G
 +gOz+5zyEME62jSnyj13Lrr83nUTymQyemZdk=; b=ExOYBMNr5aj7MkCVmrSj7q
 g9a1KbckeZsGUd/l9znm7vDfHkn3+MJ7qENVYLuIy6ccdebOsFW6mT0R4iUsUfVi
 ttf7bj/O9it7nECO5YI9XJuozsT3GtbTACLdBu0LREzDJPAC9cck4Q+4xGK3CFg8
 YVcl385JEqTOApzBrzdvpoxw90eVTTzF7xYC8Q+lapDTeLT5UiQuruPJlxZ9HA2T
 UjOiq/a7WP2s+ar3SMYJMk2K6GwmOA3fhI1IvnsjOq18Q/pxFC6sgYygSR7hyk5R
 0AUnNxkORseB0GLGJCu7E2yLi9yVUQ73z7AkfgycZXDj9qNkbDgATVrFU5sueN7w
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk488fg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jul 2025 18:48:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 569ITYYp025642;
 Wed, 9 Jul 2025 18:48:24 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfcp9nws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jul 2025 18:48:24 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 569ImNLH525056
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Jul 2025 18:48:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DE3658065;
 Wed,  9 Jul 2025 18:48:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 335705804B;
 Wed,  9 Jul 2025 18:48:22 +0000 (GMT)
Received: from [9.61.75.155] (unknown [9.61.75.155])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  9 Jul 2025 18:48:22 +0000 (GMT)
Message-ID: <c160ab5e-57fe-4c63-9cec-b35985c9ed43@linux.ibm.com>
Date: Wed, 9 Jul 2025 14:48:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] tests/functional: Add a test for s390x
 pxelinux.cfg network booting
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Zhuoying Cai <zycai@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20250709083443.41574-1-thuth@redhat.com>
 <20250709083443.41574-6-thuth@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20250709083443.41574-6-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE2OCBTYWx0ZWRfX+E9nzSRrJHCI
 sILzi0FQTHNobH1/yh91v5ipUdqQJaQu3lhRf9G2VsysAMyvvi/X26vPNYaJotdVpl6bghtz822
 2CNGslGvJOQMJgDhlsO2Gcdnsp0z7x8/xM5Vn98BGNQGTLFH9j6Tj+nwnmhG0x0XSXBWSzoH82H
 3L/UK9fs/Btw0oahpKaUAhsIAHRXBaQr76zsJ0ERaNekuvBhBIckTlfRNedMSQH5YhNLmMcTTeG
 M3lc23cxnU1/UEljVetkfNw2Q3Jm6AQ1wLF8iKSNgXsx3gppSWgS5nWnPJux7HKe94lkdHKingK
 jJGiZXORiWFrQYzZII7uqL2jaPc7StEjTVTelVEyS9EkNr0tehaOXnNxFESimw/mHNzeTUUhPjV
 NSMlPPRIuhqUC2+I/oxSrClChB8SUZsIWnqGY8OEChCBa0vCz5x798YNCKLHxC/cyBH7XPeG
X-Authority-Analysis: v=2.4 cv=XYeJzJ55 c=1 sm=1 tr=0 ts=686eb979 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=xNf9USuDAAAA:8
 a=vTr9H3xdAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=69wJf7TsAAAA:8 a=kcwvHxqCf9KhxvEk92EA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: iJb9vt9OCK30Djl6MH0KY57IpXEOUAbS
X-Proofpoint-GUID: iJb9vt9OCK30Djl6MH0KY57IpXEOUAbS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090168
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

On 7/9/25 4:34 AM, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
>
> Check the various ways of booting a kernel via pxelinux.cfg file,
> e.g. by specifying the config file name via the MAC address or the
> UUID of the guest. Also check whether we can successfully load an
> alternate kernel via the "loadparm" parameter here and whether the
> boot menu shows up with "-boot menu=on".
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                             |   1 +
>   tests/functional/meson.build            |   1 +
>   tests/functional/test_s390x_pxelinux.py | 119 ++++++++++++++++++++++++
>   3 files changed, 121 insertions(+)
>   create mode 100755 tests/functional/test_s390x_pxelinux.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1842c3dd83f..e88ed2c0a97 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1805,6 +1805,7 @@ F: hw/s390x/ipl.*
>   F: pc-bios/s390-ccw/
>   F: pc-bios/s390-ccw.img
>   F: docs/devel/s390-dasd-ipl.rst
> +F: tests/functional/test_s390x_pxelinux.py
>   T: git https://github.com/borntraeger/qemu.git s390-next
>   L: qemu-s390x@nongnu.org
>   
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 050c9000b95..1ae5f02fb37 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -281,6 +281,7 @@ tests_rx_system_thorough = [
>   
>   tests_s390x_system_thorough = [
>     's390x_ccw_virtio',
> +  's390x_pxelinux',
>     's390x_replay',
>     's390x_topology',
>     's390x_tuxrun',
> diff --git a/tests/functional/test_s390x_pxelinux.py b/tests/functional/test_s390x_pxelinux.py
> new file mode 100755
> index 00000000000..4fc33b8c46d
> --- /dev/null
> +++ b/tests/functional/test_s390x_pxelinux.py
> @@ -0,0 +1,119 @@
> +#!/usr/bin/env python3
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Functional test that checks the pxelinux.cfg network booting of a s390x VM
> +# (TFTP booting without config file is already tested by the pxe qtest, so
> +#  we don't repeat that here).
> +
> +import os
> +import shutil
> +
> +from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
> +
> +
> +pxelinux_cfg_contents='''# pxelinux.cfg style config file
> +default Debian
> +label Nonexisting
> +kernel kernel.notavailable
> +initrd initrd.notavailable
> +label Debian
> +kernel kernel.debian
> +initrd initrd.debian
> +append testoption=teststring
> +label Fedora
> +kernel kernel.fedora
> +'''
> +
> +class S390PxeLinux(QemuSystemTest):
> +
> +    ASSET_DEBIAN_KERNEL = Asset(
> +        ('https://snapshot.debian.org/archive/debian/'
> +         '20201126T092837Z/dists/buster/main/installer-s390x/'
> +         '20190702+deb10u6/images/generic/kernel.debian'),
> +        'd411d17c39ae7ad38d27534376cbe88b68b403c325739364122c2e6f1537e818')
> +
> +    ASSET_DEBIAN_INITRD = Asset(
> +        ('https://snapshot.debian.org/archive/debian/'
> +         '20201126T092837Z/dists/buster/main/installer-s390x/'
> +         '20190702+deb10u6/images/generic/initrd.debian'),
> +        '836bbd0fe6a5ca81274c28c2b063ea315ce1868660866e9b60180c575fef9fd5')
> +
> +    ASSET_FEDORA_KERNEL = Asset(
> +        ('https://archives.fedoraproject.org/pub/archive'
> +         '/fedora-secondary/releases/31/Server/s390x/os'
> +         '/images/kernel.img'),
> +        '480859574f3f44caa6cd35c62d70e1ac0609134e22ce2a954bbed9b110c06e0b')
> +
> +    def pxelinux_launch(self, pl_name='default', extra_opts=None):
> +        self.require_netdev('user')
> +        self.set_machine('s390-ccw-virtio')
> +
> +        debian_kernel = self.ASSET_DEBIAN_KERNEL.fetch()
> +        debian_initrd = self.ASSET_DEBIAN_INITRD.fetch()
> +        fedora_kernel = self.ASSET_FEDORA_KERNEL.fetch()
> +
> +        # Prepare a folder for the TFTP "server":
> +        tftpdir = self.scratch_file('tftp')
> +        shutil.rmtree(tftpdir, ignore_errors=True)   # Remove stale stuff
> +        os.mkdir(tftpdir)
> +        shutil.copy(debian_kernel, os.path.join(tftpdir, 'kernel.debian'))
> +        shutil.copy(debian_initrd, os.path.join(tftpdir, 'initrd.debian'))
> +        shutil.copy(fedora_kernel, os.path.join(tftpdir, 'kernel.fedora'))
> +
> +        pxelinuxdir = self.scratch_file('tftp', 'pxelinux.cfg')
> +        os.mkdir(pxelinuxdir)
> +
> +        cfg_fname = self.scratch_file('tftp', 'pxelinux.cfg', pl_name)
> +        with open(cfg_fname, 'w', encoding='utf-8') as f:
> +            f.write(pxelinux_cfg_contents)
> +
> +        virtio_net_dev = 'virtio-net-ccw,netdev=n1,bootindex=1'
> +        if extra_opts:
> +                virtio_net_dev += ',' + extra_opts
> +
> +        self.vm.add_args('-m', '384',
> +                         '-netdev', f'user,id=n1,tftp={tftpdir}',
> +                         '-device', virtio_net_dev)
> +        self.vm.set_console()
> +        self.vm.launch()
> +
> +
> +    def test_default(self):
> +        self.pxelinux_launch()
> +        # The kernel prints its arguments to the console, so we can use
> +        # this to check whether the kernel parameters are correctly handled:
> +        wait_for_console_pattern(self, 'testoption=teststring')
> +        # Now also check that we've successfully loaded the initrd:
> +        wait_for_console_pattern(self, 'Unpacking initramfs...')
> +        wait_for_console_pattern(self, 'Run /init as init process')
> +
> +    def test_mac(self):
> +        self.pxelinux_launch(pl_name='01-02-ca-fe-ba-be-42',
> +                             extra_opts='mac=02:ca:fe:ba:be:42,loadparm=3')
> +        wait_for_console_pattern(self, 'Linux version 5.3.7-301.fc31.s390x')
> +
> +    def test_uuid(self):
> +        # Also add a non-bootable disk to check the fallback to network boot:
> +        self.vm.add_args('-blockdev', 'null-co,size=65536,node-name=d1',
> +                         '-device', 'virtio-blk,drive=d1,bootindex=0,loadparm=1',
> +                         '-uuid', '550e8400-e29b-11d4-a716-446655441234')
> +        self.pxelinux_launch(pl_name='550e8400-e29b-11d4-a716-446655441234')
> +        wait_for_console_pattern(self, 'Debian 4.19.146-1 (2020-09-17)')
> +
> +    def test_ip(self):
> +        self.vm.add_args('-M', 'loadparm=3')
> +        self.pxelinux_launch(pl_name='0A00020F')
> +        wait_for_console_pattern(self, 'Linux version 5.3.7-301.fc31.s390x')
> +
> +    def test_menu(self):
> +        self.vm.add_args('-boot', 'menu=on,splash-time=10')
> +        self.pxelinux_launch(pl_name='0A00')
> +        wait_for_console_pattern(self, '[1] Nonexisting')
> +        wait_for_console_pattern(self, '[2] Debian')
> +        wait_for_console_pattern(self, '[3] Fedora')
> +        wait_for_console_pattern(self, 'Debian 4.19.146-1 (2020-09-17)')
> +
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()


