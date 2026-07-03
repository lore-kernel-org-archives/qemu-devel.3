Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E65C44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfXER-0006TN-66; Fri, 03 Jul 2026 02:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wfXEJ-0006O4-2z; Fri, 03 Jul 2026 02:18:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wfXEH-0004QR-2e; Fri, 03 Jul 2026 02:18:26 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6636IBN11930356; Fri, 3 Jul 2026 06:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rHQuEG
 952OPTDWlrGCX9ijXTEVgoCzjDGN7IpKBHsPM=; b=h6y7AM2Qsj2Z68ESUAkVyk
 BBw3rJNRsCPv7j7Z+qXt946AC+DTi6TZX93d/ixrtYW42d6Nz0kt6v25mhLuAZp8
 vmyF9btptLgIGdxtqS1QGwWx+PB9fvV6TYBpH4rPbrnyErdBwwMIiAa4AofDU5Yd
 24YpfSH/vXkgkb7YpzVjA6s68azfT6Z+1Lq5v7Wrmq9jq0NAxG3PV4FG52ZvtigP
 alc364ybPvo7/cQHbQmbQy8c9LnOASGbKpxnkZCGsczDofhlTmRnkBeSExyXVmUx
 /vCZq6fKCf9a6ETzHJcVNOri88eNE+Wd6PoS3DlL6dlNKtP24qOdQ7jH+hI09D5w
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pedt9w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 06:18:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663650LN029102;
 Fri, 3 Jul 2026 06:18:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukfhaq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 06:18:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6636I2qw12058900
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 06:18:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C5FA20043;
 Fri,  3 Jul 2026 06:18:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF58120040;
 Fri,  3 Jul 2026 06:17:56 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.24.117])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 06:17:56 +0000 (GMT)
Message-ID: <fc3de9cbc76a682f521fe0d88a7b2adcbf8f2b9a.camel@linux.ibm.com>
Subject: Re: [PATCH v4 5/8] ppc/pnv: Replace Power8E with Power11 for 'none'
 machine test
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?=	 <philmd@oss.qualcomm.com>, "Daniel P ."
 =?ISO-8859-1?Q?Berrang=E9?=	 <berrange@redhat.com>, Sourabh Jain
 <sourabhjain@linux.ibm.com>, Hari Bathini	 <hbathini@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn	 <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier	 <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org, Misbah Anjum
 N <misanjum@linux.ibm.com>, Anushree Mathur
 <anushree.mathur@linux.ibm.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, kvm@vger.kernel.org, Gautam Menghani
 <gautam@linux.ibm.com>, Chinmay Rath	 <rathc@linux.ibm.com>, BALATON Zoltan
 <balaton@eik.bme.hu>, Nikhil Kumar Singh	 <nikhilks@linux.ibm.com>
Date: Fri, 03 Jul 2026 11:47:30 +0530
In-Reply-To: <20260630210355.789109-6-adityag@linux.ibm.com>
References: <20260630210355.789109-1-adityag@linux.ibm.com>
 <20260630210355.789109-6-adityag@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: DgoUh58aUmG03hDnkcHhbLaD8SJ_sERJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA1OCBTYWx0ZWRfX2w2LyWXR0YTX
 IvsJd9yLF0dOD8NBOPX5oZSFXvhfrPEkvB/DOeUXEfFmreVur742cHMv6nwCVExFenN53xpuQBC
 VqVg5r5cLU3OiNWAW/NljLiXDn9lcpc=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a475422 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=syXIhHOfpIr89EnvoDAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA1OCBTYWx0ZWRfX//RlVKO2J3h9
 D7lVi6fQELdnGPbExh/6E+hP8Z+zS1rSwnFZkLZ2xFfnHVVX1Foyu3TY7Bkh36EV/ujueiEylTR
 5G46uTEqCxy6E4oXOLWjNB9/HEUdLp6FH2AAzJ9u7XMXy3AeshqC30Hzi0YKZX6+A2E/VAFd3kp
 oBl6BGNYykKfVOJMuL+biit/NE4PdJwtIi9nVdGpg1+t+k3VfcgzrNFSzH0obgi+YWes5ETQl4r
 JCR+FW6IhpHR/0UsJG77uyQmv3ZSQCrpDtAqtf2Uf8X2wCNgKGDPsWETxp7u3sCVuw36rou/PBA
 cubCjJHUgt3EgCLHEuw05PBN/+rWJ5nPoXvXX4f8ITu4uI2XwaMF8bSff8WEiA/mgrlaVve0nu5
 I6lhiZd2M+32l4nQUDcIFwglp5abtSqNuyQzkavK07sE4saWDRtt5k9Hny5nWCDhIGRRB1MksN8
 MIk3TH9rx2xVAzHrrVA==
X-Proofpoint-ORIG-GUID: jA_-Ib-dsHA4ezN2jel_3MpbTzCX6L3J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030058
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

On Wed, 2026-07-01 at 02:33 +0530, Aditya Gupta wrote:
> Power8E and Power8NVL were deprecated since QEMU 10.1, with
> commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")
>=20
> As Power8E chip is removed in future commits, remove the use of
> Power8E
> chip for use with the none machine test, and replace with Power11 for
> ppc64 test coverage for the test
>=20
> Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
> =C2=A0tests/qtest/machine-none-test.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)

LGTM.

Reviewed-by: Shivang Upadhyay <shivangu@linux.ibm.com>

~Shivang.

