Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925E2CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gRo-0003m7-EN; Mon, 22 Sep 2025 09:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1v0gRm-0003lu-CC; Mon, 22 Sep 2025 09:19:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1v0gRi-0004IY-Qe; Mon, 22 Sep 2025 09:19:14 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MBB0xl008695;
 Mon, 22 Sep 2025 13:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=AA7DrP
 RahOWpcb6feQcbgSX7/4dZrh0OzKGuyMwZSyg=; b=OLZoy4cb6xak9bb5h0wovz
 iZBunjpMAOhrurUIVKE+tjzqvpD3axF53ngyMw95xqDnOGQUWMkkHiZXspQHOHuj
 syeVCEAt4hWPnIl2W6JO95WVvhr5qldpHJFF4CFXQtZHXH3LFLA0G/En70nHP+Xe
 oZ3I6HK1TY5yIOAuDLP8ugyWirNxsxPQwbHCP4GhAnlea5tqWTVRKBUiRwkwJCRe
 /z0gGNMte6dXK5bwqM8DQNhdZL6/QDpLoRX3rwrdyUeqJVPLC8ShwUXyiNHzck3z
 Id4ygmWCzRBkqVJqsnuhoWuJ0SaUG4UsrgNsDdkoUIBm+FQ05AH5lJ8Qu6HPjXfw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0jau0f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Sep 2025 13:19:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58MCxlUT019675;
 Mon, 22 Sep 2025 13:19:04 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a83jx675-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Sep 2025 13:19:04 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58MDJ28333882376
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 13:19:02 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96A0758058;
 Mon, 22 Sep 2025 13:19:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 137A158057;
 Mon, 22 Sep 2025 13:19:02 +0000 (GMT)
Received: from [9.61.15.5] (unknown [9.61.15.5])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 22 Sep 2025 13:19:01 +0000 (GMT)
Message-ID: <d6ac9824-341f-4a9e-9a02-4a35bc292e20@linux.ibm.com>
Date: Mon, 22 Sep 2025 09:19:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/s390x/test_pxelinux: Fix warnings from
 pylint
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Zhuoying Cai <zycai@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
References: <20250912085251.274294-1-thuth@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20250912085251.274294-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX7NhFrBRaslbs
 9uXvqX1AWY80BTDNItrAWewwCFfYo8xc2YQui2ViAsgQx+k8jnQYOWJ8mTquyOZ/LiFZRyO8E1F
 wUdr1EmqfsIzwFprxzAAUrYuCHaK3Z5zbBJhpDRvQJ3Cefe6w1U6BIFMHt0jg5RTfzmfXTUdXZV
 yI2UiDxubLtJ9v8pGMssy8yIM+3NPUmvq8vZE7/veFU3U/i+P75hewI618PgGw//VCnVF08o0oH
 3WEkIhRxW3NbEeNbQSVuou1C+XagekDPrZ/gjRVdzPZitLiXZZZaEekbodR4QZvdcXKVIJwgZcf
 p3yziM31RYkPnSs6XuRsjwvUyhoYSgeVqWH+A0CKxrLcQjqiFHJIVSx2T4HVo2ZXMEDH9bLHFQc
 G2HWopS7
X-Authority-Analysis: v=2.4 cv=TOlFS0la c=1 sm=1 tr=0 ts=68d14cc9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=S0mpSi8qAAAA:8 a=xNf9USuDAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=hLWjwHo3PZUOhdj4sggA:9 a=QEXdDO2ut3YA:10
 a=BJr6rvadb4IWsfPgq2g9:22
X-Proofpoint-ORIG-GUID: Zgsd-XOK8uNHIx2_oFFh5DKp5HRRXPz8
X-Proofpoint-GUID: Zgsd-XOK8uNHIx2_oFFh5DKp5HRRXPz8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 9/12/25 4:52 AM, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
>
> pylint complains about wrong identation in one of the lines and
> that the pxelinux_cfg_contents is a constant that should be written
> with capital letters. While we're at it, also add the missing doc
> strings.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/s390x/test_pxelinux.py | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/tests/functional/s390x/test_pxelinux.py b/tests/functional/s390x/test_pxelinux.py
> index 4fc33b8c46d..c00cce6a5a4 100755
> --- a/tests/functional/s390x/test_pxelinux.py
> +++ b/tests/functional/s390x/test_pxelinux.py
> @@ -1,10 +1,11 @@
>   #!/usr/bin/env python3
>   #
>   # SPDX-License-Identifier: GPL-2.0-or-later
> -#
> -# Functional test that checks the pxelinux.cfg network booting of a s390x VM
> -# (TFTP booting without config file is already tested by the pxe qtest, so
> -#  we don't repeat that here).
> +'''
> +Functional test that checks the pxelinux.cfg network booting of a s390x VM
> +(TFTP booting without config file is already tested by the pxe qtest, so
> +we don't repeat that here).
> +'''
>   
>   import os
>   import shutil
> @@ -12,7 +13,7 @@
>   from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
>   
>   
> -pxelinux_cfg_contents='''# pxelinux.cfg style config file
> +PXELINUX_CFG_CONTENTS='''# pxelinux.cfg style config file
>   default Debian
>   label Nonexisting
>   kernel kernel.notavailable
> @@ -26,6 +27,10 @@
>   '''
>   
>   class S390PxeLinux(QemuSystemTest):
> +    '''
> +    Test various ways of booting via a pxelinux.cfg file, for details see:
> +    https://wiki.syslinux.org/wiki/index.php?title=PXELINUX#Configuration
> +    '''
>   
>       ASSET_DEBIAN_KERNEL = Asset(
>           ('https://snapshot.debian.org/archive/debian/'
> @@ -46,6 +51,7 @@ class S390PxeLinux(QemuSystemTest):
>           '480859574f3f44caa6cd35c62d70e1ac0609134e22ce2a954bbed9b110c06e0b')
>   
>       def pxelinux_launch(self, pl_name='default', extra_opts=None):
> +        '''Create a pxelinux.cfg file in the right location and launch QEMU'''
>           self.require_netdev('user')
>           self.set_machine('s390-ccw-virtio')
>   
> @@ -66,11 +72,11 @@ def pxelinux_launch(self, pl_name='default', extra_opts=None):
>   
>           cfg_fname = self.scratch_file('tftp', 'pxelinux.cfg', pl_name)
>           with open(cfg_fname, 'w', encoding='utf-8') as f:
> -            f.write(pxelinux_cfg_contents)
> +            f.write(PXELINUX_CFG_CONTENTS)
>   
>           virtio_net_dev = 'virtio-net-ccw,netdev=n1,bootindex=1'
>           if extra_opts:
> -                virtio_net_dev += ',' + extra_opts
> +            virtio_net_dev += ',' + extra_opts
>   
>           self.vm.add_args('-m', '384',
>                            '-netdev', f'user,id=n1,tftp={tftpdir}',
> @@ -80,6 +86,7 @@ def pxelinux_launch(self, pl_name='default', extra_opts=None):
>   
>   
>       def test_default(self):
> +        '''Check whether the guest uses the "default" file name'''
>           self.pxelinux_launch()
>           # The kernel prints its arguments to the console, so we can use
>           # this to check whether the kernel parameters are correctly handled:
> @@ -89,11 +96,13 @@ def test_default(self):
>           wait_for_console_pattern(self, 'Run /init as init process')
>   
>       def test_mac(self):
> +        '''Check whether the guest uses file name based on its MAC address'''
>           self.pxelinux_launch(pl_name='01-02-ca-fe-ba-be-42',
>                                extra_opts='mac=02:ca:fe:ba:be:42,loadparm=3')
>           wait_for_console_pattern(self, 'Linux version 5.3.7-301.fc31.s390x')
>   
>       def test_uuid(self):
> +        '''Check whether the guest uses file name based on its UUID'''
>           # Also add a non-bootable disk to check the fallback to network boot:
>           self.vm.add_args('-blockdev', 'null-co,size=65536,node-name=d1',
>                            '-device', 'virtio-blk,drive=d1,bootindex=0,loadparm=1',
> @@ -102,11 +111,13 @@ def test_uuid(self):
>           wait_for_console_pattern(self, 'Debian 4.19.146-1 (2020-09-17)')
>   
>       def test_ip(self):
> +        '''Check whether the guest uses file name based on its IP address'''
>           self.vm.add_args('-M', 'loadparm=3')
>           self.pxelinux_launch(pl_name='0A00020F')
>           wait_for_console_pattern(self, 'Linux version 5.3.7-301.fc31.s390x')
>   
>       def test_menu(self):
> +        '''Check whether the boot menu works for pxelinux.cfg booting'''
>           self.vm.add_args('-boot', 'menu=on,splash-time=10')
>           self.pxelinux_launch(pl_name='0A00')
>           wait_for_console_pattern(self, '[1] Nonexisting')


