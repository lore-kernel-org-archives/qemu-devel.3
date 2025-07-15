Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78696C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubgPO-0008WQ-T1; Tue, 15 Jul 2025 10:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1ubfif-0007Wt-Q3; Tue, 15 Jul 2025 09:29:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1ubfia-0003Hs-0K; Tue, 15 Jul 2025 09:29:16 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F90F8W030991;
 Tue, 15 Jul 2025 13:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mYqcNZ
 nf4xI3HoTUWOVhPP9MVutqwHBu+ldfBZTTBbg=; b=btAzQZqEDdGKmZziNIaZxn
 4mp4ETN2SRk5GcvYOjLwPAauZzdcCxr0cWixKxViMxZQ9jK8EmisvhFKUpe+vRjN
 HQVhY8wiWN4WbbcXBQQrOFhbbDapykJgXs8EJr+Vp53fAklnlxVh2q215f+Joydb
 mBSWl1LeuGIV77tgyrtnd2jDl4XdP4tnN8FrUSqoqqN8qAV9oCmenB0MbmPcBUYT
 GfJZXUkshdkuP3Uf3cQq7SG3b+ReumQA9F6+K3LinERbqpRmfU5hKSRWhSQuB7dq
 pWwfFVePe6x5VaDo5Bzd2oF09JwA4ooMnqmgE3NH9OeRA0qPk3hsww5r9QIAHuiw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vamttqah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 13:29:07 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56FDGauC006549;
 Tue, 15 Jul 2025 13:29:06 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vamttqae-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 13:29:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56FCUYiI008180;
 Tue, 15 Jul 2025 13:29:05 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v2e0js7u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 13:29:05 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56FDT4di24969800
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Jul 2025 13:29:04 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FC4858045;
 Tue, 15 Jul 2025 13:29:04 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D40958054;
 Tue, 15 Jul 2025 13:29:02 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.121.87]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Jul 2025 13:29:02 +0000 (GMT)
Message-ID: <ef30116afd1f01f5071f5ba9812459467dc32d3e.camel@linux.ibm.com>
Subject: Re: [PATCH 21/22] s390x/s390-pci-vfio.c: use QOM casts where
 appropriate
From: Eric Farman <farman@linux.ibm.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Date: Tue, 15 Jul 2025 09:29:01 -0400
In-Reply-To: <20250715093110.107317-22-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-22-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KrZGqFs5ZUDjbypI0Ie8fJPkdjqh8td0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEyMiBTYWx0ZWRfXwKkJqvSYJ5lt
 0OkVy9CweUtUiOaht76t8h/m78gaVgbckIMw7CjGAiBvqJXExql54rszKeypLWmr1wqSySmn8d7
 THn46VznftqwnmGXqkLH2rSYCkhx79/m7R27LDv0fDs0ctTTSKzdFZJPsCDJzNElHGTuR/852Yk
 aUXmbX5tiHv/rz+O3TOYervvWfvx0bzPcMnlgBgzFYSTKUIXOtQN/h2QguT8yU54ujsEpnHGEIK
 zANJV6RdTPs7wD5klCElMoMeMcI6+rD5ZkGJVia3dzQK90cVurT1Lpu8aivH4ja9cKiqjGfGdsD
 Ggtb3ltLuZ1Q9lZi/90Ko7Ma4ctMChAcHn3YWyjVWbEpTtj4LspvsY3YcAjecrMdcrsj1gJ0fp4
 qM1RIXJPAJPUy8vprXsrYSedoupht5UTOo2MzhzHBUotQ2zrC4XwEJMjkfLjF8xPafF5ud+Q
X-Proofpoint-ORIG-GUID: JFpLQSbwYoaWd80aGoKvbNYZ9JQcRELD
X-Authority-Analysis: v=2.4 cv=dNSmmPZb c=1 sm=1 tr=0 ts=687657a3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=64Cc0HZtAAAA:8 a=VnNF1IyMAAAA:8
 a=6V_Z78ehL-hMsaM6yTMA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=955 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1011 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150122
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Tue, 2025-07-15 at 10:26 +0100, Mark Cave-Ayland wrote:
> Use QOM casts to cast to VFIOPCIDevice instead of using container_of().
>=20
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/s390x/s390-pci-vfio.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

