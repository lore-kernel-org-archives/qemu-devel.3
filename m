Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7167DCDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 19:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc6sC-0000dN-L7; Tue, 23 Jun 2026 15:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wc6sB-0000d3-4v; Tue, 23 Jun 2026 15:33:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wc6s9-00070T-NM; Tue, 23 Jun 2026 15:33:26 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBmPBJ1826014; Tue, 23 Jun 2026 19:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Ql1NCF
 fJXpAkJig/ZEn+FEUWckjjGHnr9nrBWl2SlWs=; b=ffk5NYbtYOE6NZGXOGKLys
 uGh0mMJqokkBL0NCwgPPABYrje1NkCSCODLFJyE5esF3Taq0tohms0EszTDDn4Ge
 Zs1hha0uFxcnt3B0t95QQu3MmD96iyoMD+KnxtKskzkqwhnNGNK+r5rSrEPvEzNl
 rkq20wfEliMn+ik1Ixku3Uw+bvPNUTj8wZvphh5zb6oNz/Tp9fV+GoA2pc/lWFu3
 pQYiftBwAhDLZozup55/+woNFgU9AkezA/Ujh9vJ6F4mkaTlIc9+lgSDZ5zWp0IV
 xsEDnqsQX1c+UqGuXn1XJmoLj1DJaoX5aCtZEZA3GF+LeAQzUb/Y3sD1F7qUabaQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsrbu4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 19:33:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NJJpD4019909;
 Tue, 23 Jun 2026 19:33:23 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phcyy2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 19:33:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65NJXL6X22348334
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 19:33:22 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E170D58054;
 Tue, 23 Jun 2026 19:33:21 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B8E2A5805C;
 Tue, 23 Jun 2026 19:33:20 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.119.138]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 19:33:20 +0000 (GMT)
Message-ID: <5528e528250b5e67ea33fe433842601f5eeaa292.camel@linux.ibm.com>
Subject: Re: [PATCH 3/5] pc-bios/s390-ccw: write IPLB location for
 virtio-blk-pci IPL
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: zycai@linux.ibm.com, jdaley@linux.ibm.com, jjherne@linux.ibm.com,
 nrb@linux.ibm.com, Jared Rossi <jrossi@us.ibm.com>
Date: Tue, 23 Jun 2026 15:33:20 -0400
In-Reply-To: <20260623002539.126124-4-jrossi@linux.ibm.com>
References: <20260623002539.126124-1-jrossi@linux.ibm.com>
 <20260623002539.126124-4-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE1OSBTYWx0ZWRfX/FiRX0HecYNy
 E8HtYWuWSRowiSgeTpfvkX/8kjQ4nTLnvdYJMOHl+jxN+xs/UU0YgAOSavD66sJsF0btXdHDSCl
 p99Z52HJgP9aIAz0Q/C4853CyrzDiJrjh9oPH9IVbYeDHsCwfwUuEuIJaYxldmEM3R3/fQTBwPy
 zk0VcSDTZ1a5mO3QhbJ/EuZVu32MPDEIFQicwPu8wtzY7zX7UQo/5E/LTx28XdDR10aFdPUpzFh
 FsC9JxSyzmrQO5q6DUGdjmwdHg/EA7NYUNd9m0JRlG+7P7f+CQc804KxvCenKQoU3Mo+VXdNuBR
 CprPzuCnEOs/W0HfGfG2wMhCckmsYeJRYsXpAZWq3zC7ivu7dh4WB8mg7B1DqQlVLFNjHXQWsHG
 YhP0DGnv6Qf0+eF50IvBWO844hEzwUc/V7X4We0U9jd0to9I8dyfXW2SCLL5zpOKwup7MyvtXWn
 PueHSQhFznpxQEShDZQ==
X-Proofpoint-GUID: gKTHUCaFUoF5csRFhXwfesaAGIvKz0zP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE1OSBTYWx0ZWRfX9UIkPNZzvUfN
 VTjm9dFZJV0aoh/h5SISIJmEhi50sO81+n7EsqrsyAx1bYCXkRilN9oElwhncUDchNG4j+xQd+j
 BuIsqQb07M1jaJhy9OyVYWJIfrprHyc=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3adf83 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=bH-O2YikLjVYf5wsl58A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gKTHUCaFUoF5csRFhXwfesaAGIvKz0zP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230159
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

On Mon, 2026-06-22 at 20:25 -0400, jrossi@linux.ibm.com wrote:
> From: Joshua Daley <jdaley@linux.ibm.com>
>=20
> When IPL type is PCI, cutype is unknown, so the IPLB location does not
> get written to lowcore. Update the condition to check IPL type as well.
>=20
> Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
> signed-off-by: Jared Rossi <jrossi@us.ibm.com>

I suppose "signed" is to be capitalized, but you mentioned this line is to =
be fixed anyway.

> ---
>  pc-bios/s390-ccw/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 26287cfd81..1059fda03c 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -52,7 +52,8 @@ void write_subsystem_identification(void)
> =20
>  void write_iplb_location(void)
>  {
> -    if (cutype =3D=3D CU_TYPE_VIRTIO && virtio_get_device_type() !=3D VI=
RTIO_ID_NET) {
> +    if ((cutype =3D=3D CU_TYPE_VIRTIO || iplb.pbt =3D=3D S390_IPL_TYPE_P=
CI) &&

Why iplb.pbt and not virtio_get_device()->ipl_type?

> +        virtio_get_device_type() !=3D VIRTIO_ID_NET) {
>          lowcore->ptr_iplb =3D ptr2u32(&iplb);
>      }
>  }

