Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512B8CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 18:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUqfS-0001vu-EZ; Wed, 03 Jun 2026 14:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wUqfM-0001uf-LX; Wed, 03 Jun 2026 14:50:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wUqfK-0003IG-0C; Wed, 03 Jun 2026 14:50:12 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653IEku12403947; Wed, 3 Jun 2026 18:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3RJjzH
 quuhB1LLqv+sdkfE+SLvuNJeMxjghEqBGyioQ=; b=iyE3AxnnvIGiFbuuyH1+Na
 QU4WqQSh6uw799nIj5TNoqSqOdyHDzsFMWIoFroUoVM5L/++N+3r4kalrRHGjXK1
 csH0pcxfL5KHWfyy8xNJJueOjHlSyzNqNlfXmV5NwbdAUDbG7smTz4s164U+wHH2
 s3oPSspaxuRGGfmOu+EmKPh0PScqwQqUV/H2GQa6xOVKhYx91yeORHHrkiWhTWTA
 CsuQRMHTOHwZymAwU35oOK8PEuez5w6zC4TdAN0Lfc0wtmfBvcVqsbgz5Tj2qbhQ
 GvlNz5F67sKaDl4K5tPJydZbDZpT/fdWKJAliy8mFjWS7eTxpvQXcTTAG5V6u/1A
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpaec060-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Jun 2026 18:50:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653Id7Mj006268;
 Wed, 3 Jun 2026 18:50:04 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakw1rw1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Jun 2026 18:50:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 653Io3102294730
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 3 Jun 2026 18:50:03 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD7AB58043;
 Wed,  3 Jun 2026 18:50:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BAE1F58066;
 Wed,  3 Jun 2026 18:50:00 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.143.205]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  3 Jun 2026 18:50:00 +0000 (GMT)
Message-ID: <ba1b75db4c3c110a7edae5a1753c32e5854a3ee5.camel@linux.ibm.com>
Subject: Re: [PATCH v11 30/32] tests/functional/s390x: Add secure IPL
 functional test
From: Eric Farman <farman@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Date: Wed, 03 Jun 2026 14:50:00 -0400
In-Reply-To: <20260505201905.997996-31-zycai@linux.ibm.com>
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-31-zycai@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a20775c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=vTr9H3xdAAAA:8
 a=VnNF1IyMAAAA:8 a=WP5zsaevAAAA:8 a=UkDPGh-J0cAZ0a7bUPkA:9 a=QEXdDO2ut3YA:10
 a=t8Kx07QrZZTALmIZmm-o:22
X-Proofpoint-GUID: F-DKLg1KHiq5iH_jkrq90VsLL4d5JcvF
X-Proofpoint-ORIG-GUID: F-DKLg1KHiq5iH_jkrq90VsLL4d5JcvF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE4MCBTYWx0ZWRfX7OQvEyEUUlYo
 98sEFqAgvH8XM4LGvVXKtbbpg1Sg3yn47K2A5gDycrVqV9vhzGxe1P1BxXnQek679puRKYfrjpP
 8CmbiFavo/sBG/XTQFuPyNRIfLHBYd1x0LouPx0CgWliLPAeuRwtAHrKGQtVmQJlpv1zMLIwFhP
 jZAo6QmEtEzRfhzScMVlevDfxHPUNjLQ+wzF4xNIaLl7x3Nl9qjCHYVfYeN83ZFj149vsY7miTD
 QCA3VS/qXNXPsiL2DWQdX0xfXFTboNxAX4RJCZ/+JwL1WwkgOLV9zcW2v2KqwWNCNotWGiQ+tZS
 NMhb6mq+QAlSb0X/ILNp4uQUemenb8n6tTPdmwEeaxfQ6Q6DiYlJbE8l8ruzoGb8Mt4StnJpPlS
 HJqJZ5AhHzOFpOtPqI/vI2GYq/08jtFpGBarzIMhpie6qtyyhpBVxkjiOz2Uk/RO3M+ks+I+GSJ
 j37X5MU1GX/kFtFeFFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030180
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

On Tue, 2026-05-05 at 16:19 -0400, Zhuoying Cai wrote:
> Add functional test for secure IPL.
>=20
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  tests/functional/s390x/meson.build        |   2 +
>  tests/functional/s390x/test_secure_ipl.py | 148 ++++++++++++++++++++++
>  2 files changed, 150 insertions(+)
>  create mode 100755 tests/functional/s390x/test_secure_ipl.py
>=20
> diff --git a/tests/functional/s390x/meson.build b/tests/functional/s390x/=
meson.build
> index b065b666bc..01cb2d1d4c 100644
> --- a/tests/functional/s390x/meson.build
> +++ b/tests/functional/s390x/meson.build
> @@ -2,6 +2,7 @@
> =20
>  test_s390x_timeouts =3D {
>    'ccw_virtio' : 420,
> +  'secure_ipl' : 280,

How'd you come up with this value?

>  }
> =20
>  tests_s390x_system_quick =3D [
> @@ -14,6 +15,7 @@ tests_s390x_system_thorough =3D [
>    'ccw_virtio',
>    'pxelinux',
>    'replay',
> +  'secure_ipl',
>    'topology',
>    'tuxrun',
>  ]
> diff --git a/tests/functional/s390x/test_secure_ipl.py b/tests/functional=
/s390x/test_secure_ipl.py
> new file mode 100755
> index 0000000000..0980daace1
> --- /dev/null
> +++ b/tests/functional/s390x/test_secure_ipl.py
> @@ -0,0 +1,148 @@
> +#!/usr/bin/env python3
> +#
> +# s390x Secure IPL functional test: validates secure-boot verification r=
esults
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later

A general comment, you'll need some form of docstring for the entire file, =
and any classes/methods
defined later on.

> +
> +from subprocess import check_call, DEVNULL
> +
> +from qemu_test import QemuSystemTest, Asset, get_qemu_img
> +from qemu_test import exec_command_and_wait_for_pattern, exec_command
> +from qemu_test import wait_for_console_pattern, skipBigDataTest
> +
> +class S390xSecureIpl(QemuSystemTest):
> +    ASSET_F40_QCOW2 =3D Asset(
> +        ('https://archives.fedoraproject.org/pub/archive/'
> +         'fedora-secondary/releases/40/Server/s390x/images/'
> +         'Fedora-Server-KVM-40-1.14.s390x.qcow2'),
> +        '091c232a7301be14e19c76ce9a0c1cbd2be2c4157884a731e1fc4f89e7455a5=
f')
> +
> +    def __init__(self, *args, **kwargs):
> +        super().__init__(*args, **kwargs)
> +        self.root_password =3D None
> +        self.qcow2_path =3D None
> +        self.cert_path =3D None
> +        self.prompt =3D None
> +
> +    # Boot a temporary VM to set up secure IPL image:
> +    # - Create certificate
> +    # - Sign stage3 binary and kernel
> +    # - Run zipl
> +    # - Extract certificate

Can we break out those four chunks into standalone routines, so that we can=
 identify them
individually rather than as part of the novella that follows?

> +    def setup_s390x_secure_ipl(self):
> +        temp_vm =3D self.get_vm(name=3D'sipl_setup')
> +        temp_vm.set_machine('s390-ccw-virtio')
> +
> +        asset_path =3D self.ASSET_F40_QCOW2.fetch()
> +        self.qcow2_path =3D self.scratch_file('f40.qcow2')
> +        qemu_img =3D get_qemu_img(self)
> +        check_call([qemu_img, 'create', '-f', 'qcow2', '-b', asset_path,
> +                    '-F', 'qcow2', self.qcow2_path], stdout=3DDEVNULL, s=
tderr=3DDEVNULL)
> +
> +        temp_vm.set_console()
> +        temp_vm.add_args('-nographic',
> +                         '-accel', 'kvm',
> +                         '-m', '1024',
> +                         '-drive',
> +                         f'id=3Ddrive0,if=3Dnone,format=3Dqcow2,file=3D{=
self.qcow2_path}',
> +                         '-device', 'virtio-blk-ccw,drive=3Ddrive0,booti=
ndex=3D1')
> +        temp_vm.launch()
> +
> +        # Initial root account setup (Fedora first boot screen)
> +        self.root_password =3D 'fedora40password'
> +        wait_for_console_pattern(self, 'Please make a selection from the=
 above',
> +                                 vm=3Dtemp_vm)
> +        exec_command_and_wait_for_pattern(self, '4', 'Password:', vm=3Dt=
emp_vm)
> +        exec_command_and_wait_for_pattern(self, self.root_password,
> +                                          'Password (confirm):', vm=3Dte=
mp_vm)
> +        exec_command_and_wait_for_pattern(self, self.root_password,
> +                                    'Please make a selection from the ab=
ove',
> +                                    vm=3Dtemp_vm)
> +
> +        # Login as root
> +        self.prompt =3D '[root@localhost ~]#'
> +        exec_command_and_wait_for_pattern(self, 'c', 'localhost login:',=
 vm=3Dtemp_vm)
> +        exec_command_and_wait_for_pattern(self, 'root', 'Password:', vm=
=3Dtemp_vm)
> +        exec_command_and_wait_for_pattern(self, self.root_password, self=
.prompt,
> +                                          vm=3Dtemp_vm)
> +
> +        # Certificate generation
> +        exec_command_and_wait_for_pattern(self,
> +                                          'openssl version', 'OpenSSL 3.=
2.1 30',
> +                                          vm=3Dtemp_vm)
> +        exec_command_and_wait_for_pattern(self,
> +                            'openssl req -new -x509 -newkey rsa:2048 '
> +                            '-keyout mykey.pem -outform PEM -out mycert.=
pem '
> +                            '-days 36500 -subj "/CN=3DMy Name/" -nodes -=
verbose',
> +                            'Writing private key to \'mykey.pem\'', vm=
=3Dtemp_vm)
> +
> +        # Install kernel-devel (needed for sign-file)
> +        exec_command_and_wait_for_pattern(self,
> +                                'sudo dnf install kernel-devel-$(uname -=
r) -y',
> +                                'Complete!', vm=3Dtemp_vm)

This is the last thing I see in base.log when running this test on my syste=
m. Looking at console
log, this errors out:

2026-06-03 20:08:33,829: ^[[?2004h[root@localhost ~]# sudo dnf install kern=
el-devel-$(uname -r) -y
2026-06-03 20:08:34,147: ^[[?2004l^MFedora 40 - s390x        [=3D=3D=3D    =
             ] ---  B/s |   0=20
B     --:-- ETA^MFedora 40 - s390x                               0.0  B/s |=
   0  B     00:00
2026-06-03 20:08:34,147: Errors during downloading metadata for repository =
'fedora':
2026-06-03 20:08:34,147: - Curl error (6): Couldn't resolve host name for
https://mirrors.fedoraproject.org/metalink?repo=3Dfedora-40&arch=3Ds390x [C=
ould not resolve host:
mirrors.fedoraproject.org]
2026-06-03 20:08:34,207: Error: Failed to download metadata for repo 'fedor=
a': Cannot prepare
internal mirrorlist: Curl error (6): Couldn't resolve host name for
https://mirrors.fedoraproject.org/metalink?repo=3Dfedora-40&arch=3Ds390x [C=
ould not resolve host:
mirrors.fedoraproject.org]


Surrounding this, I'm noting that this is surrounded by messages from Netwo=
rkManager waiting for it
to come online, so maybe there needs to be a check that there's actually a =
network here, so we can
bail out rather than timeout.

> +        wait_for_console_pattern(self, self.prompt, vm=3Dtemp_vm)
> +        exec_command_and_wait_for_pattern(self,
> +                                    'ls /usr/src/kernels/$(uname -r)/scr=
ipts/',
> +                                    'sign-file', vm=3Dtemp_vm)
> +
> +        # Sign stage3 binary and kernel
> +        exec_command(self, '/usr/src/kernels/$(uname -r)/scripts/sign-fi=
le '
> +                    'sha256 mykey.pem mycert.pem /lib/s390-tools/stage3.=
bin',
> +                    vm=3Dtemp_vm)
> +        wait_for_console_pattern(self, self.prompt, vm=3Dtemp_vm)
> +        exec_command(self, '/usr/src/kernels/$(uname -r)/scripts/sign-fi=
le '
> +                    'sha256 mykey.pem mycert.pem /boot/vmlinuz-$(uname -=
r)',
> +                    vm=3Dtemp_vm)
> +        wait_for_console_pattern(self, self.prompt, vm=3Dtemp_vm)
> +
> +        # Run zipl to prepare for secure boot
> +        exec_command_and_wait_for_pattern(self, 'zipl --secure 1 -VV', '=
Done.',
> +                                          vm=3Dtemp_vm)
> +
> +        # Extract certificate to host
> +        out =3D exec_command_and_wait_for_pattern(self, 'cat mycert.pem'=
,
> +                                                '-----END CERTIFICATE---=
--',
> +                                                vm=3Dtemp_vm)
> +        # strip first line to avoid console echo artifacts
> +        cert =3D "\n".join(out.decode("utf-8").splitlines()[1:])
> +        self.log.info("%s", cert)
> +
> +        self.cert_path =3D self.scratch_file("mycert.pem")
> +
> +        with open(self.cert_path, 'w', encoding=3D"utf-8") as file_objec=
t:
> +            file_object.write(cert)
> +
> +        # Shutdown temp vm
> +        temp_vm.shutdown()
> +
> +    @skipBigDataTest()
> +    def test_s390x_secure_ipl(self):
> +        self.require_accelerator('kvm')
> +        self.setup_s390x_secure_ipl()
> +
> +        self.set_machine('s390-ccw-virtio')
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-nographic',
> +                         '-machine', 's390-ccw-virtio,secure-boot=3Don,'
> +                         f'boot-certs.0.path=3D{self.cert_path}',
> +                         '-accel', 'kvm',
> +                         '-m', '1024',
> +                         '-drive',
> +                         f'id=3Ddrive1,if=3Dnone,format=3Dqcow2,file=3D{=
self.qcow2_path}',
> +                         '-device', 'virtio-blk-ccw,drive=3Ddrive1,booti=
ndex=3D1')
> +        self.vm.launch()
> +
> +        # Expect two verified components
> +        verified_output =3D "Verified component"
> +        wait_for_console_pattern(self, verified_output)
> +        wait_for_console_pattern(self, verified_output)
> +
> +        # Login and verify the vm is booted using secure boot
> +        wait_for_console_pattern(self, 'localhost login:')
> +        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
> +        exec_command_and_wait_for_pattern(self, self.root_password, self=
.prompt)
> +        exec_command_and_wait_for_pattern(self, 'cat /sys/firmware/ipl/s=
ecure', '1')
> +
> +if __name__ =3D=3D '__main__':
> +    QemuSystemTest.main()

