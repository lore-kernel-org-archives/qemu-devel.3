Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9091C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 11:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV97E-0004hE-Qz; Wed, 31 Jan 2024 06:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rV97D-0004fO-V8
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 06:50:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rV97C-00032v-91
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 06:50:51 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VBWVrA008248; Wed, 31 Jan 2024 11:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=DZa2yP2H5RZb2MQWDIhhIxkYPsMByvKLmJlBEaCrivY=;
 b=djnG1x43iZj7pJSC+GFEA41tRihKxHaFCfdWO02JCuQgafGG4z9TOjoI+EwsreSL/dFP
 5okJv7Q7a24LxoVGs8KMJKgulfxLtt7VxLnxKvfN2TeZZrjaXf+hl7KDRj2PibfVURfe
 2rxx+vn+sKP8P2gX3D1i5/Nfm8PlUUHAmIzpQnLKUh1gVzNGMnzreqN8u5df1dvvuXKy
 cJedBaivZAQ7aj9LfHMRju1dEdqA4Bj+v5k2FFSR5sY4fNcEsqsMOZdtOGvu4cOzE9br
 u+o9rnTF2VkHHpEEOEebBXiM4Mr5pCSb8lo5uer3AV2ctDNjXgKxg+Mlvcefg4QrkHNG Dg== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyndw8eja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 11:50:48 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VBioFk017797; Wed, 31 Jan 2024 11:50:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwchywb4s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 11:50:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40VBojLl17302222
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 11:50:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAE1D20043;
 Wed, 31 Jan 2024 11:50:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C0A1C20040;
 Wed, 31 Jan 2024 11:50:45 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 Jan 2024 11:50:45 +0000 (GMT)
Message-ID: <dd54902ecdbc3bbcee83d1ef7e9cfe75b2460e13.camel@linux.ibm.com>
Subject: Re: [PULL 13/31] tests/tcg: Add the PROT_NONE gdbstub test
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Date: Wed, 31 Jan 2024 12:50:35 +0100
In-Reply-To: <20240129230121.8091-14-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
 <20240129230121.8091-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: brE6vhkWpKmDxc1_UI2p5cZRARoIvgM0
X-Proofpoint-ORIG-GUID: brE6vhkWpKmDxc1_UI2p5cZRARoIvgM0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_06,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 mlxlogscore=911 clxscore=1015 priorityscore=1501
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310089
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 2024-01-30 at 09:01 +1000, Richard Henderson wrote:
> From: Ilya Leoshkevich <iii@linux.ibm.com>
>=20
> Make sure that qemu gdbstub, like gdbserver, allows reading from and
> writing to PROT_NONE pages.
>=20
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Message-Id: <20240129093410.3151-4-iii@linux.ibm.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> =C2=A0tests/tcg/multiarch/prot-none.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 40
> ++++++++++++++++++++++++
> =C2=A0tests/tcg/multiarch/Makefile.target=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 9 +++++-
> =C2=A0tests/tcg/multiarch/gdbstub/prot-none.py | 36 +++++++++++++++++++++
> =C2=A03 files changed, 84 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 tests/tcg/multiarch/prot-none.c
> =C2=A0create mode 100644 tests/tcg/multiarch/gdbstub/prot-none.py

[...]

> diff --git a/tests/tcg/multiarch/gdbstub/prot-none.py
> b/tests/tcg/multiarch/gdbstub/prot-none.py
> new file mode 100644
> index 0000000000..e829d3ebc5
> --- /dev/null
> +++ b/tests/tcg/multiarch/gdbstub/prot-none.py
> @@ -0,0 +1,36 @@
> +"""Test that GDB can access PROT_NONE pages.
> +
> +This runs as a sourced script (via -x, via run-test.py).
> +
> +SPDX-License-Identifier: GPL-2.0-or-later
> +"""
> +import ctypes
> +from test_gdbstub import main, report
> +
> +
> +def probe_proc_self_mem():
> +=C2=A0=C2=A0=C2=A0 buf =3D ctypes.create_string_buffer(b'aaa')
> +=C2=A0=C2=A0=C2=A0 try:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with open("/proc/self/mem", "=
rb") as fp:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fp.se=
ek(ctypes.addressof(buf))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n fp.read(3) =3D=3D b'aaa'
> +=C2=A0=C2=A0=C2=A0 except OSError:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return False
> +
> +
> +def run_test():
> +=C2=A0=C2=A0=C2=A0 """Run through the tests one by one"""
> +=C2=A0=C2=A0=C2=A0 if not probe_proc_self_mem:

I noticed that I made an embarrassing typo here: this should be
`not probe_proc_self_mem()`. I posted a v5 with the correction.

[...]

