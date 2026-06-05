Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DEBCD6E7D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 16:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVXMu-0006NV-1z; Fri, 05 Jun 2026 12:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wVXMs-0006KC-SY; Fri, 05 Jun 2026 12:25:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wVXMq-0003Pq-8w; Fri, 05 Jun 2026 12:25:58 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 655D1eQe096369; Fri, 5 Jun 2026 16:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mgPQEX
 nR6f22yxSgMW6EvHYd4gYGwfaDgCZYfEdelxg=; b=ZXr6iyMfV4qdlB1ypsk3eD
 /FTSgFhYj4CHZhpH+wQn+7PlLc4FC1oP2r70DUj1QAZmOnzGjfK/THAbJVZxgdZ2
 BXIg73YOF/JbG2dVbY7wID/jvHW8wzgvkxwnMR995T+OGIttExulEGJcO+T0SExZ
 0PI6Mu6cFcGLJ8FmSAIgtTNYDcoDd4CFArNF/3jXhEYXWqgrch6UzcFdxHYgl/cZ
 l6jA4XyU2bAWC6rrRVDooP2uP8sXjdEtXQ2frLJ/TSkN5bySmUfDBIGB3TLaDEvn
 9BTMf/tO0OLKePwOyaqsAuv0jCZOM2k8YFBAciMbb6fw8xZRIFWGwZIqCp1Hz3jg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjqn7y5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 16:25:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 655GOdtQ013158;
 Fri, 5 Jun 2026 16:25:49 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwyt4vs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 16:25:49 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 655GPmBV28115542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 5 Jun 2026 16:25:48 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E10B58059;
 Fri,  5 Jun 2026 16:25:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FED858058;
 Fri,  5 Jun 2026 16:25:47 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.143.205]) by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  5 Jun 2026 16:25:47 +0000 (GMT)
Message-ID: <b82d095dd3616822279151e562e06689e3bd4b7b.camel@linux.ibm.com>
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
Date: Fri, 05 Jun 2026 12:25:46 -0400
In-Reply-To: <ba1b75db4c3c110a7edae5a1753c32e5854a3ee5.camel@linux.ibm.com>
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-31-zycai@linux.ibm.com>
 <ba1b75db4c3c110a7edae5a1753c32e5854a3ee5.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Bg6FXyCVQM-nC2lVdoOxq4tIeb5o3nnp
X-Proofpoint-GUID: Bg6FXyCVQM-nC2lVdoOxq4tIeb5o3nnp
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a22f88e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=vTr9H3xdAAAA:8
 a=VnNF1IyMAAAA:8 a=WP5zsaevAAAA:8 a=3KEBKUrHcnjVZyrDqD8A:9 a=QEXdDO2ut3YA:10
 a=t8Kx07QrZZTALmIZmm-o:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDE1OSBTYWx0ZWRfXwP64GfH3Fm/4
 7yDCkeUOKtRJd6JVf97dTtW50mbpKq9zzp4W5OtoIvsE+BQR+/VL0tESXwREZdmFwG72wyJjAIq
 qKuseYr3srxxtI25sY/MVWUqAlPfxvpWjHh8e5fAqnLefHLE94Z6fvZTGV4KIkhwF7YMxoNjaqv
 3JktAxYOu8Tsa4LTPljz5ECf4/U4Nt9ciRFSARtJa8ltQbXpnJIjJvEufAn+cXnXIK6hcVvwhVc
 R6Ynwwg8k8251xsIJZuYKXnGge2bQOqH1aYkzVFhaf0zgguN5cCJ0Jhj2cK21JouyUY7I0PXyUS
 dLuksQxCnAOgLwfvZn4MBWhSHQ/taqrtidk2O1VwhH5eqehkBlnwASmkg7bUBzN9WkSqvODPD6N
 oOfltsNGBuZEzeUf0NC58leXogzweQwWKtop0AKbiUqZpH1OpWowAHQ9kcnedE1vATXOlsZo61t
 dgsG/YY9Oc7oBsrhwLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050159
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Wed, 2026-06-03 at 14:50 -0400, Eric Farman wrote:
> On Tue, 2026-05-05 at 16:19 -0400, Zhuoying Cai wrote:
> > Add functional test for secure IPL.
> >=20
> > Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> > ---
> >  tests/functional/s390x/meson.build        |   2 +
> >  tests/functional/s390x/test_secure_ipl.py | 148 ++++++++++++++++++++++
> >  2 files changed, 150 insertions(+)
> >  create mode 100755 tests/functional/s390x/test_secure_ipl.py
> >=20
> > diff --git a/tests/functional/s390x/meson.build b/tests/functional/s390=
x/meson.build
> > index b065b666bc..01cb2d1d4c 100644
> > --- a/tests/functional/s390x/meson.build
> > +++ b/tests/functional/s390x/meson.build
> > @@ -2,6 +2,7 @@
> > =20
> >  test_s390x_timeouts =3D {
> >    'ccw_virtio' : 420,
> > +  'secure_ipl' : 280,
>=20
> How'd you come up with this value?
>=20
> >  }
> > =20
> >  tests_s390x_system_quick =3D [
> > @@ -14,6 +15,7 @@ tests_s390x_system_thorough =3D [
> >    'ccw_virtio',
> >    'pxelinux',
> >    'replay',
> > +  'secure_ipl',
> >    'topology',
> >    'tuxrun',
> >  ]
> > diff --git a/tests/functional/s390x/test_secure_ipl.py b/tests/function=
al/s390x/test_secure_ipl.py
> > new file mode 100755
> > index 0000000000..0980daace1
> > --- /dev/null
> > +++ b/tests/functional/s390x/test_secure_ipl.py
> > @@ -0,0 +1,148 @@
> > +#!/usr/bin/env python3
> > +#
> > +# s390x Secure IPL functional test: validates secure-boot verification=
 results
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-or-later
>=20
> A general comment, you'll need some form of docstring for the entire file=
, and any classes/methods
> defined later on.
>=20
> > +
> > +from subprocess import check_call, DEVNULL
> > +
> > +from qemu_test import QemuSystemTest, Asset, get_qemu_img
> > +from qemu_test import exec_command_and_wait_for_pattern, exec_command
> > +from qemu_test import wait_for_console_pattern, skipBigDataTest
> > +
> > +class S390xSecureIpl(QemuSystemTest):
> > +    ASSET_F40_QCOW2 =3D Asset(
> > +        ('https://archives.fedoraproject.org/pub/archive/'
> > +         'fedora-secondary/releases/40/Server/s390x/images/'
> > +         'Fedora-Server-KVM-40-1.14.s390x.qcow2'),
> > +        '091c232a7301be14e19c76ce9a0c1cbd2be2c4157884a731e1fc4f89e7455=
a5f')
> > +
> > +    def __init__(self, *args, **kwargs):
> > +        super().__init__(*args, **kwargs)
> > +        self.root_password =3D None
> > +        self.qcow2_path =3D None
> > +        self.cert_path =3D None
> > +        self.prompt =3D None
> > +
> > +    # Boot a temporary VM to set up secure IPL image:
> > +    # - Create certificate
> > +    # - Sign stage3 binary and kernel
> > +    # - Run zipl
> > +    # - Extract certificate
>=20
> Can we break out those four chunks into standalone routines, so that we c=
an identify them
> individually rather than as part of the novella that follows?
>=20
> > +    def setup_s390x_secure_ipl(self):
> > +        temp_vm =3D self.get_vm(name=3D'sipl_setup')
> > +        temp_vm.set_machine('s390-ccw-virtio')
> > +
> > +        asset_path =3D self.ASSET_F40_QCOW2.fetch()
> > +        self.qcow2_path =3D self.scratch_file('f40.qcow2')
> > +        qemu_img =3D get_qemu_img(self)
> > +        check_call([qemu_img, 'create', '-f', 'qcow2', '-b', asset_pat=
h,
> > +                    '-F', 'qcow2', self.qcow2_path], stdout=3DDEVNULL,=
 stderr=3DDEVNULL)
> > +
> > +        temp_vm.set_console()
> > +        temp_vm.add_args('-nographic',
> > +                         '-accel', 'kvm',
> > +                         '-m', '1024',
> > +                         '-drive',
> > +                         f'id=3Ddrive0,if=3Dnone,format=3Dqcow2,file=
=3D{self.qcow2_path}',
> > +                         '-device', 'virtio-blk-ccw,drive=3Ddrive0,boo=
tindex=3D1')
> > +        temp_vm.launch()
> > +
> > +        # Initial root account setup (Fedora first boot screen)
> > +        self.root_password =3D 'fedora40password'
> > +        wait_for_console_pattern(self, 'Please make a selection from t=
he above',
> > +                                 vm=3Dtemp_vm)
> > +        exec_command_and_wait_for_pattern(self, '4', 'Password:', vm=
=3Dtemp_vm)
> > +        exec_command_and_wait_for_pattern(self, self.root_password,
> > +                                          'Password (confirm):', vm=3D=
temp_vm)
> > +        exec_command_and_wait_for_pattern(self, self.root_password,
> > +                                    'Please make a selection from the =
above',
> > +                                    vm=3Dtemp_vm)
> > +
> > +        # Login as root
> > +        self.prompt =3D '[root@localhost ~]#'
> > +        exec_command_and_wait_for_pattern(self, 'c', 'localhost login:=
', vm=3Dtemp_vm)
> > +        exec_command_and_wait_for_pattern(self, 'root', 'Password:', v=
m=3Dtemp_vm)
> > +        exec_command_and_wait_for_pattern(self, self.root_password, se=
lf.prompt,
> > +                                          vm=3Dtemp_vm)
> > +
> > +        # Certificate generation
> > +        exec_command_and_wait_for_pattern(self,
> > +                                          'openssl version', 'OpenSSL =
3.2.1 30',
> > +                                          vm=3Dtemp_vm)
> > +        exec_command_and_wait_for_pattern(self,
> > +                            'openssl req -new -x509 -newkey rsa:2048 '
> > +                            '-keyout mykey.pem -outform PEM -out mycer=
t.pem '
> > +                            '-days 36500 -subj "/CN=3DMy Name/" -nodes=
 -verbose',
> > +                            'Writing private key to \'mykey.pem\'', vm=
=3Dtemp_vm)
> > +
> > +        # Install kernel-devel (needed for sign-file)
> > +        exec_command_and_wait_for_pattern(self,
> > +                                'sudo dnf install kernel-devel-$(uname=
 -r) -y',
> > +                                'Complete!', vm=3Dtemp_vm)
>=20
> This is the last thing I see in base.log when running this test on my sys=
tem. Looking at console
> log, this errors out:
>=20
> 2026-06-03 20:08:33,829: ^[[?2004h[root@localhost ~]# sudo dnf install ke=
rnel-devel-$(uname -r) -y
> 2026-06-03 20:08:34,147: ^[[?2004l^MFedora 40 - s390x        [=3D=3D=3D  =
               ] ---  B/s |   0=20
> B     --:-- ETA^MFedora 40 - s390x                               0.0  B/s=
 |   0  B     00:00
> 2026-06-03 20:08:34,147: Errors during downloading metadata for repositor=
y 'fedora':
> 2026-06-03 20:08:34,147: - Curl error (6): Couldn't resolve host name for
> https://mirrors.fedoraproject.org/metalink?repo=3Dfedora-40&arch=3Ds390x =
[Could not resolve host:
> mirrors.fedoraproject.org]
> 2026-06-03 20:08:34,207: Error: Failed to download metadata for repo 'fed=
ora': Cannot prepare
> internal mirrorlist: Curl error (6): Couldn't resolve host name for
> https://mirrors.fedoraproject.org/metalink?repo=3Dfedora-40&arch=3Ds390x =
[Could not resolve host:
> mirrors.fedoraproject.org]
>=20
>=20
> Surrounding this, I'm noting that this is surrounded by messages from Net=
workManager waiting for it
> to come online, so maybe there needs to be a check that there's actually =
a network here, so we can
> bail out rather than timeout.

Josh suggested (thank you!!) that perhaps I didn't have slirp enabled in my=
 build when I tried this,
which is indeed the cause for my hangup. Easy fix on my side, but it's a de=
pendency that maybe you
can account for in this test (or maybe -net none, if you dont need to conne=
ct it to anything?).

Of course, remedying THAT problem gives me yet another error which I haven'=
t chased down. Looks like
the first of these [*] failed later on. This is a particularly crusty syste=
m I'm using, so maybe
it's simply another thing that is missing.

>=20
> > +        wait_for_console_pattern(self, self.prompt, vm=3Dtemp_vm)
> > +        exec_command_and_wait_for_pattern(self,
> > +                                    'ls /usr/src/kernels/$(uname -r)/s=
cripts/',
> > +                                    'sign-file', vm=3Dtemp_vm)
> > +
> > +        # Sign stage3 binary and kernel
> > +        exec_command(self, '/usr/src/kernels/$(uname -r)/scripts/sign-=
file '
> > +                    'sha256 mykey.pem mycert.pem /lib/s390-tools/stage=
3.bin',
> > +                    vm=3Dtemp_vm)
> > +        wait_for_console_pattern(self, self.prompt, vm=3Dtemp_vm)
> > +        exec_command(self, '/usr/src/kernels/$(uname -r)/scripts/sign-=
file '
> > +                    'sha256 mykey.pem mycert.pem /boot/vmlinuz-$(uname=
 -r)',
> > +                    vm=3Dtemp_vm)
> > +        wait_for_console_pattern(self, self.prompt, vm=3Dtemp_vm)
> > +
> > +        # Run zipl to prepare for secure boot
> > +        exec_command_and_wait_for_pattern(self, 'zipl --secure 1 -VV',=
 'Done.',
> > +                                          vm=3Dtemp_vm)
> > +
> > +        # Extract certificate to host
> > +        out =3D exec_command_and_wait_for_pattern(self, 'cat mycert.pe=
m',
> > +                                                '-----END CERTIFICATE-=
----',
> > +                                                vm=3Dtemp_vm)
> > +        # strip first line to avoid console echo artifacts
> > +        cert =3D "\n".join(out.decode("utf-8").splitlines()[1:])
> > +        self.log.info("%s", cert)
> > +
> > +        self.cert_path =3D self.scratch_file("mycert.pem")
> > +
> > +        with open(self.cert_path, 'w', encoding=3D"utf-8") as file_obj=
ect:
> > +            file_object.write(cert)
> > +
> > +        # Shutdown temp vm
> > +        temp_vm.shutdown()
> > +
> > +    @skipBigDataTest()
> > +    def test_s390x_secure_ipl(self):
> > +        self.require_accelerator('kvm')
> > +        self.setup_s390x_secure_ipl()
> > +
> > +        self.set_machine('s390-ccw-virtio')
> > +
> > +        self.vm.set_console()
> > +        self.vm.add_args('-nographic',
> > +                         '-machine', 's390-ccw-virtio,secure-boot=3Don=
,'
> > +                         f'boot-certs.0.path=3D{self.cert_path}',
> > +                         '-accel', 'kvm',
> > +                         '-m', '1024',
> > +                         '-drive',
> > +                         f'id=3Ddrive1,if=3Dnone,format=3Dqcow2,file=
=3D{self.qcow2_path}',
> > +                         '-device', 'virtio-blk-ccw,drive=3Ddrive1,boo=
tindex=3D1')
> > +        self.vm.launch()
> > +
> > +        # Expect two verified components
> > +        verified_output =3D "Verified component"
> > +        wait_for_console_pattern(self, verified_output)
> > +        wait_for_console_pattern(self, verified_output)

[*] Failure occurs here, because guest panicked. Surely it's something not =
set up correctly on the
guest that was created, because it's happening as soon as it tries to kick =
over to the guest kernel,
but I don't see any errors in the log that suggests anything amiss:

console.log:
...
2026-06-05 17:51:03,344: -----END CERTIFICATE-----
2026-06-05 17:51:03,398: LOADPARM=3D[        ]
2026-06-05 17:51:03,398:
2026-06-05 17:51:03,398: Using virtio-blk.
2026-06-05 17:51:03,399: Using SCSI scheme.
2026-06-05 17:51:03,408: ..........

base.log:
...
2026-06-05 17:51:03,398 - DEBUG: qemu.qmp.protocol.default._set_state Trans=
itioning from
'Runstate.CONNECTING' to 'Runstate.RUNNING'.
2026-06-05 17:51:03,398 - DEBUG: qemu-test._console_interaction Console int=
eraction:
success_msg=3D'Verified component' failure_msg=3D'None' send_string=3D'None=
'
2026-06-05 17:51:03,398 - DEBUG: qemu.machine.machine.console_socket Openin=
g console socket
2026-06-05 17:51:03,410 - DEBUG: qemu.machine.machine.shutdown Shutting dow=
n VM appliance;
timeout=3D30
2026-06-05 17:51:03,410 - DEBUG: qemu.machine.machine._soft_shutdown Attemp=
ting graceful termination
2026-06-05 17:51:03,410 - DEBUG: qemu.machine.machine._early_cleanup Closin=
g console socket
2026-06-05 17:51:03,411 - DEBUG: qemu.machine.machine._soft_shutdown Polite=
ly asking QEMU to
terminate
2026-06-05 17:51:03,411 - DEBUG: qemu.qmp.protocol.default._cb_outbound -->=
 {
  "execute": "quit"
}
2026-06-05 17:51:03,411 - DEBUG: qemu.qmp.protocol.default._cb_inbound <-- =
{
  "timestamp": {
    "seconds": 1780674663,
    "microseconds": 409153
  },
  "event": "GUEST_PANICKED",
  "data": {
    "action": "poweroff",
    "info": {
      "core": 0,
      "psw-addr": 17682,
      "reason": "disabled-wait",
      "psw-mask": 562952100904960,
      "type": "s390"
    }
  }
}


> > +
> > +        # Login and verify the vm is booted using secure boot
> > +        wait_for_console_pattern(self, 'localhost login:')
> > +        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
> > +        exec_command_and_wait_for_pattern(self, self.root_password, se=
lf.prompt)
> > +        exec_command_and_wait_for_pattern(self, 'cat /sys/firmware/ipl=
/secure', '1')
> > +
> > +if __name__ =3D=3D '__main__':
> > +    QemuSystemTest.main()

