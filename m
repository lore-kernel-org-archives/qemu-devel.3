Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9D3C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wochi-00010d-KK; Tue, 28 Jul 2026 03:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wochf-0000zm-7p; Tue, 28 Jul 2026 03:58:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wochd-0003Hn-Qf; Tue, 28 Jul 2026 03:58:19 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3ltwg4032691; Tue, 28 Jul 2026 07:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/xaOjd
 xw6A75XhvU/T7VFCdxTpc0YbETlgfhGwwZ2C8=; b=RnctnQul/3/EPwn/+edifD
 r1ZrCg/7EsdK+gUZs7Sbx4Pb2NnyylsW5uqkvgjEwAf3NQot/cpPterIl9FgnppI
 l3nLUykdrWlHsnFEc0JdfmFmH4famCnHekRcmLsi4A5BbvW3eSSvBcDo1b1b+N98
 Y5TKgATFe9jazz4lOgRl44CZB6iAGqn2pV3jbW2XLSq00xvH8IulcDODurIvjUDE
 fAg6RH5HvQsc3FKJyImnPYdeABOzgb7V3XTLJKMtuJKMfrkbZYE7X4oJSmoxuSR6
 PDillllGM2Vt3e1C892JWlGd0uRmZdoF/iE48P4w4UXPhJTvVCha1+xQHZql93Rw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj3j1m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 07:58:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S7uSHL019826;
 Tue, 28 Jul 2026 07:58:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh8s6b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 07:58:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66S7wAO625821464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2026 07:58:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA5C8201D4;
 Tue, 28 Jul 2026 07:58:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5009C201D3;
 Tue, 28 Jul 2026 07:58:08 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.23.204])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jul 2026 07:58:08 +0000 (GMT)
Message-ID: <57a0da8cef93a17859e989f5b8bf63ada8da4cf1.camel@linux.ibm.com>
Subject: Re: [PATCH v3] tests/functional/ppc: skip remote interrupts test if
 -net user not built
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 thuth@redhat.com
Date: Tue, 28 Jul 2026 13:28:06 +0530
In-Reply-To: <20260728132223.288d56ce-6c-amachhiw@linux.ibm.com>
References: <20260728074612.42397-1-shivangu@linux.ibm.com>
 <20260728132223.288d56ce-6c-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2NiBTYWx0ZWRfXxJOzDWLGTJW5
 lv0Inp6Zm8nI2RMsbGKJw4AWBj/dkIFWn6WKg4JInNd1U1BuTGofL9EBt6s0oyrj9RW/iAtWrYR
 zN79byoUTMJ0u+75YE/YpZvEXVJBII4=
X-Proofpoint-GUID: GLO1yX_GGZjBlbvdJi20bmeYt6-_8_TL
X-Proofpoint-ORIG-GUID: gndEQ9WWWoKjrh56OrvPBmVgMIl43UJZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2NiBTYWx0ZWRfX3X60btRfTiAT
 8oXOQ2jZmvU4JRZl9TOnB9vxaADDXRkBDO1cmp3sIRdMz4tbQu687Y3zAv9azIkzyKMZyG28uDj
 xYqAMisgvq+tKVVHEj80J3k8gZlkQ79z7Nch/r/2G5lauE5+k8V5eX1T7CmQ9Mly2jGJWuPptBg
 BQxxPU/930jEg3HQiEMfb1v4+Oi0sYRJWdOVircXTY9S8VBLhVHNDbhdkgFwVdb0asA9IIQKjjU
 wakXnuYylRNWJzql5Srqf/WFTFXO43tnYyYtse7rYdxZL5KydY3f8C6eGnyEsPU7gRicKSyZVXL
 iLwM+FVPkJvMM5lvaQROJUaClp7WTaT1hXFELR9OnmbP7YxHPUQnlHjR5jMTmyxdmMHhO2ieUro
 NNpDqCWOH6jjzzE4fWwfkzr1in5eGLv4mUPOHeKqbfVuszUsWYAcjkPAOrG8lTwv800PhqoQJKR
 tp28sY98bZpwkpnnwwQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a686118 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=8hvMHH6gQBY4jWk-vcsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280066
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On Tue, 2026-07-28 at 13:23 +0530, Amit Machhiwal wrote:
> > Suggested-by: Thomas Huth <thuth@redhat.com>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Fixes: 63f5ba80921 ("tests/functional: tests/functional: Add remote
> > interrupts test for PowerNV")
> > Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> > ---
>=20
> Looks like my Tested-by: from v2 got missed. Anyhow, sharing it again
> here...
>=20
> Tested on a system without libslirp-devel. Test is correctly skipped:
>=20
> =C2=A0 ok 1 test_powernv.PowernvMachine.test_linux_remote_interrupts #
> SKIP no support for user networking
> =C2=A0 1..1
>=20
> Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
>=20
Thanks for posting again. I missed to pick it.

~Shivang.

