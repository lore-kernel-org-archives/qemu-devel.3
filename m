Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3AACD4F2C
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXx8W-0008Eq-Um; Fri, 12 Jun 2026 04:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wXx8V-0008Eb-Sv; Fri, 12 Jun 2026 04:21:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wXx8U-0004lv-1V; Fri, 12 Jun 2026 04:21:07 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BN3bDn4146938; Fri, 12 Jun 2026 08:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=aQVbaR
 XVaZHiCNp/nbMczn8YBpGzUovu2Xdsvx/xcCY=; b=a3Alc/rbo+IfjKpq/dGRvl
 4nrrmdZS4VnDPtQavjEzeK9PwpLOix3cpjMuhdsRxkro4fRJ0PZhqLTviQEG+q4q
 aJSuVaKI4sCQSGqyR/31yj7vQq5RpipdbbhdRD0DOtg23rW4AgmKVOCTrvCQQuBA
 umvgRXj4blE236kTAW7RT95JiL6ofxVyPx+AYJ/qCWLPvBy5KI/EzAA1MdXCkQXR
 G++agau1BEIEZ2a5ncyGOgZGj61lO/OTxj6dGWoELY4qprvZHbpDl/q04eAf6F35
 v8qp4sEHd+0axpAZiK68kkmRcJ+PdQv7T5yNR4L75VZCRxd6feFxyOIESvZOhHkA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8c7y8e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 08:21:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65C8JhDh000451;
 Fri, 12 Jun 2026 08:21:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09xy2y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 08:21:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65C8Kv3I26542546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jun 2026 08:20:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF05220040;
 Fri, 12 Jun 2026 08:20:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61B212004B;
 Fri, 12 Jun 2026 08:20:56 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Jun 2026 08:20:56 +0000 (GMT)
Message-ID: <4b7da748b92e9105503d62dcb73039337ad81471.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ppc/spapr: make fadump collect regs for maxcpus
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: anushree.mathur@linux.vnet.ibm.com, harshpb@linux.ibm.com,
 mahesh@linux.ibm.com, sourabhjain@linux.ibm.com
Date: Fri, 12 Jun 2026 13:50:55 +0530
In-Reply-To: <0dc91b46-a643-4e2f-b452-59ee2ec49ded@linux.ibm.com>
References: <20260429065127.366813-1-shivangu@linux.ibm.com>
 <20260520092857.1079193-1-shivangu@linux.ibm.com>
 <0dc91b46-a643-4e2f-b452-59ee2ec49ded@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA3MiBTYWx0ZWRfXwc9BfTLTyQd1
 WByZyW7bQetx5hNT85QpvmwsH2bFa5mGOldg9ed3gI1+Nyfe/n8XcdFi4uHp0g9m25HaFStvT/W
 A++VbZCgZNj6hdh9pxaqrrZoxE17dVI=
X-Authority-Analysis: v=2.4 cv=AYCB2XXG c=1 sm=1 tr=0 ts=6a2bc16f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=P-IC7800AAAA:8
 a=egPWfHYs18hlGN6UQSsA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: xLbrmO2kCrQ33uIAHXBW-MNyN4PJkhfn
X-Proofpoint-ORIG-GUID: xLbrmO2kCrQ33uIAHXBW-MNyN4PJkhfn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA3MiBTYWx0ZWRfX0qRYaFMNCpqq
 JvcjRj9hmlUCyGbMt1vz3m/hAmtC9vf9u98YiBb0pUToxjA0WoPdn0wWbdCTbQ9xyzap8Yzompf
 zVnv8Snohy/O8FaFvqHF4izWUXWdzkCti8eWwPJf2ZYgxJVNfuQ0LpRjmmHoUT1FBqc5PgQoZsH
 3deoTlSthUGfgwGyGdwur50X3rfy5C2XrY1EpFV2xR9/9hBPwauBWN7lDvtk6DOPEOZHKBLqe28
 X04VHKQlDBhMKa6BikZ1MVKnb7oSRkbcltoiD3gWmPEccwYkBpHzTwQyV5R/OaAQY0KRLm1wH4v
 RFtRP2mi3UPzV3HRwRn9W3Bo3UfYdJ/8+0ySGIIQKm4tfVhy1Ta53XLXgVjKhi+wo00B2KX/v+G
 JaCaY+OeRS3sG93LDRNAf5ojTcbmLgBN/mNtainDeOjnSUYg8lGdk76vWByFBExKXX/lPyMkRHh
 e+3wQdAYu1qrTbOEnQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120072
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On Wed, 2026-06-10 at 22:33 +0530, Aditya Gupta wrote:
> On 20/05/26 14:58, Shivang Upadhyay wrote:
>=20
> > When a ppc machine is started with maxcpus greater than the number
> > > of present CPUs (e.g., -smp cpus=3D2,maxcpus=3D8), firmware allocates
> > >=20
> the CPU state data buffer based on maxcpus and advertises this size >
> to=20
> the kernel during fadump registration. > > However, fadump currently=20
> fails to generate a vmcore during the > rebooted kernel because: > >
> 1.=20
> The CPU state buffer length does not match what firmware > advertised
> (QEMU only populates entries for present CPUs, not > maxcpus) > 2.
> The=20
> kernel cannot find CPU data for all maxcpus slots
> Hello Shivang, same thing from our discussion offline, can you see if
> this
> fix belongs in the kernel instead of qemu ?
>=20
> PAPR (section H.1) states:
>=20
> > Only CPUs that are online at the start of the Firmware Assisted
> > Dump > will have their register data saved.
> QEMU's implementation is aligned with PAPR.
> The PAPR doesn't say anything about the offline CPUs, so that may be
> considered as undefined.
> Let's see if it's an assumption from kernel side, and if it's
> possible to be
> fixed there, else if we will take this patch in qemu.
>=20
> Thanks,
> - Aditya G

Hi Aditya,

 I get your point about PAPR, it just mentions about saving online CPUs
and doesnt go in detail about the case of offline/inactive/not-added
CPUs.

But the case of DLPAR'ed cpus is interested. It would be important to
save the state of new CPUs, as per me.=20

Anyways regarding the Kernel fix. there is this concerning line in
kernel[1].=20


switch (type) {
		case RTAS_FADUMP_CPU_STATE_DATA:
		case RTAS_FADUMP_HPTE_REGION:
		case RTAS_FADUMP_REAL_MODE_REGION:
			if (fdm_active->rgn[i].error_flags !=3D 0) {
				pr_err("Dump taken by platform is not
valid (%d)\n", i);
				rc =3D -EINVAL;
			}
			if (fdm_active->rgn[i].bytes_dumped !=3D
fdm_active->rgn[i].source_len) {
				pr_err("Dump taken by platform is
incomplete (%d)\n", i);
				rc =3D -EINVAL;
			}


Basically it panics if the size advertised by Firmware is not the same
as the size it recieves at the fadump time. in qemu the advertiesed
size comes from here. [2]

    /*
     * CPU State Data contains multiple fields such as header, num_cpus
and
     * register entries
     *
     * Calculate the maximum CPU State Data size, according to maximum
     * possible CPUs the QEMU VM can have
     *
     * This calculation must match the 'cpu_state_len' calculation done
in
     * 'populate_cpu_state_data' in spapr_fadump.c
     */
    fadump_cpu_state_size +=3D sizeof(struct FadumpRegSaveAreaHeader);
    fadump_cpu_state_size +=3D 0xc;                      /* padding as in
PAPR */
    fadump_cpu_state_size +=3D sizeof(uint32_t);         /* num_cpus */
    fadump_cpu_state_size +=3D max_possible_cpus   *     /* reg entries
*/
                             FADUMP_PER_CPU_REG_ENTRIES *
                             sizeof(struct FadumpRegEntry);


So its the same problem here. It too advertizes to kernel that
collection needs to happen on max_possible_cpus. atleast this change
need to be made. But if we make this change, what will we fill the
empty cpu's slot with?

~Shivang.

[1]https://elixir.bootlin.com/linux/v6.15.6/source/arch/powerpc/platforms/p=
series/rtas-fadump.c#L458

[2]https://elixir.bootlin.com/qemu/v11.0.1/source/hw/ppc/spapr.c#L941

