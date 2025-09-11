Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E51ECAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 09:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwdGC-0001C3-4Z; Thu, 11 Sep 2025 05:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>) id 1uwdG9-0001Bg-6O
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 05:06:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>) id 1uwdG6-0006dn-Ge
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 05:06:28 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B7Bi4N023577;
 Thu, 11 Sep 2025 09:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fUP3x5
 3iHaL6TVoX/rIskgNPxXDNQLevbP8vZNNZqv8=; b=hGxFYpfaTszYyr0XT3kZMx
 xqLCaoyuoOIR7O5j0rYcW2g7EBVQ9KTRszaT8kn5pkJO0WocHQ9WJmWNYAZReqeh
 Z5L7NiL2Cl2UTFWcbqSoMWME8DdcKusWiGLMh/08Kihxw0c0ERFHVfWYP8U+zRvM
 Ec2CsyG0e2Li34/nelHz24Doe38a18TqopdoVRFLo86zCFTacBMHHBDZ9nt9sJmH
 /hn9wJ6edNZNF51KjtGIa8z5QnEDeTYAw9mbzbV+nDVUXuHFvxKRTDLU23l09UX/
 T6xv1+3GVNjbS0HEquv3mMdx8P9npibNXKoRKoZX0fgoWmtsltay7Ls+cpMXwOCg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx3kga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Sep 2025 09:05:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58B740MN017218;
 Thu, 11 Sep 2025 09:05:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gmmskw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Sep 2025 09:05:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58B95XP833423688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Sep 2025 09:05:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E31422004B;
 Thu, 11 Sep 2025 09:05:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BDEF20040;
 Thu, 11 Sep 2025 09:05:33 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.87.154.222]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Sep 2025 09:05:33 +0000 (GMT)
Message-ID: <79a95a4349a8e97f65717139857432741701d489.camel@linux.ibm.com>
Subject: Re: [PATCH RFC] tests/functional: add tests for SCLP event CPI
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>, qemu-s390x
 mailing list <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>
Cc: Daniel Berrange <berrange@redhat.com>, qemu-devel mailing list
 <qemu-devel@nongnu.org>, Hendrik Brueckner <brueckner@linux.ibm.com>
Date: Thu, 11 Sep 2025 11:05:10 +0200
In-Reply-To: <20250812123124.382696-1-shalini@linux.ibm.com>
References: <20250812123124.382696-1-shalini@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: geE7_a0FYm5NnghVdwSxjGR9f65HhT7n
X-Proofpoint-ORIG-GUID: geE7_a0FYm5NnghVdwSxjGR9f65HhT7n
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c290e2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=WP5zsaevAAAA:8 a=xRRHrJYrEx2pfNY0FpYA:9 a=QEXdDO2ut3YA:10
 a=t8Kx07QrZZTALmIZmm-o:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfXxUuF5FdCqorJ
 Z4nAGbl1L4YAPIxIuNMYECObIfH5w9qFrjDfdDPCFWzjN3MA6wmdrnV3yiFrWDY1m1dEjEdML1C
 S9d3R06hCE+jabLDTFHzIiZQxmMQ3e9r70TMhhggOBMF7UBAD0F/J+VbgpGODotDd1prNUMcAWL
 7VPimoe0hTD+JK+jMPYvmOqTXq2P3OHlaWQAD6o+myQNihZvn6sfJgx1+F++D/7ySk6hQjeoXiN
 jbrvTHySBu/iJuPVUCjDx/o++LsLN1D5jiqF+CWcgT1cxK2Kqji/rYAXV2DqkMwjiwHEyfHBfvt
 xR+lgWJLQDTcTQTN4iSIB7UTprWzFHLZCuMCnGw215xGhzZVi90cZSjjx04Uxfepww7Q0Xc6TLn
 GHdCmYtH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
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

On Tue, 2025-08-12 at 14:31 +0200, Shalini Chellathurai Saroja wrote:
> Add tests for SCLP event type Control-Program Identification
> (CPI) to s390x CCW virtio tests.
>=20
> Please note that these tests are skipped as the guest OS does not
> trigger the SCLP event type CPI when the command
> 'echo 1 > /sys/firmware/cpi/set' is executed in the guest. I
> believe that the guest OS must to be updated to support the SCLP
> event type CPI.
>=20
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/test_s390x_ccw_virtio.py | 24 +++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/tests/functional/test_s390x_ccw_virtio.py b/tests/functional=
/test_s390x_ccw_virtio.py
> index 453711aa0f..c14379cbaa 100755
> --- a/tests/functional/test_s390x_ccw_virtio.py
> +++ b/tests/functional/test_s390x_ccw_virtio.py

Is this the best file to put it?
It seems mostly to be about device testing.

> @@ -15,6 +15,7 @@
>  import tempfile
> =20
>  from qemu_test import QemuSystemTest, Asset
> +from qemu_test import exec_command
>  from qemu_test import exec_command_and_wait_for_pattern
>  from qemu_test import wait_for_console_pattern
> =20
> @@ -270,5 +271,28 @@ def test_s390x_fedora(self):
>                          'while ! (dmesg -c | grep Start.virtcrypto_remov=
e) ; do'
>                          ' sleep 1 ; done', 'Start virtcrypto_remove.')
> =20
> +        # Test SCLP event Control-Program Identification (CPI)
> +        cpi =3D '/sys/firmware/cpi/'
> +        sclpcpi =3D '/machine/sclp/s390-sclp-event-facility/sclpcpi'
> +        self.log.info("Test SCLP event CPI")
> +        exec_command(self, 'echo TESTVM > ' + cpi + 'system_name')
> +        exec_command(self, 'echo LINUX > ' + cpi + 'system_type')
> +        exec_command(self, 'echo TESTPLEX > ' + cpi + 'sysplex_name')
> +        exec_command(self, 'echo 1 > ' + cpi + 'set')
> +        try:
> +            event =3D self.vm.event_wait('SCLP_EVENT_CTRL_PGM_ID')
> +        except TimeoutError:
> +            self.skipTest('SCLP Event type CPI is not supported by guest=
 OS')
> +        ts =3D self.vm.cmd('qom-get', path=3Dsclpcpi, property=3D'timest=
amp')
> +        self.assertNotEqual(int(ts), 0)
> +        name =3D self.vm.cmd('qom-get', path=3Dsclpcpi, property=3D'syst=
em_name')
> +        self.assertEqual(name, 'TESTVM')
> +        typ =3D self.vm.cmd('qom-get', path=3Dsclpcpi, property=3D'syste=
m_type')
> +        self.assertEqual(typ, 'LINUX')
> +        sysplex =3D self.vm.cmd('qom-get', path=3Dsclpcpi, property=3D's=
ysplex_name')
> +        self.assertEqual(sysplex, 'TESTPLEX')
> +        level =3D self.vm.cmd('qom-get', path=3Dsclpcpi, property=3D'sys=
tem_level')
> +        self.assertNotEqual(int(level), 0)
> +
>  if __name__ =3D=3D '__main__':
>      QemuSystemTest.main()

--=20
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stuttg=
art, HRB 243294

