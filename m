Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E51D58B21
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 06:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w216c-0001dq-Ej; Mon, 16 Mar 2026 02:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w216a-0001dU-Mn; Mon, 16 Mar 2026 02:07:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w216Z-0008QO-1U; Mon, 16 Mar 2026 02:07:08 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62F4dF943113932; Mon, 16 Mar 2026 06:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=eIlplx
 MM6hrl9g2G93itOTsMM8s5gVtNrZlmUVfAxNg=; b=SmPktKFw5Ciu0pTPD+8xOb
 n5Ur0f8e2hswg3mhLyYEhjG8r1iMn3dCEvdpVXeumPpN2CifQDstG/INZvXux4rf
 rkPcAJwREY/Y5A253zqRlNDYbUdBMlKnDTQV1X5muHA/dZYz23GKEpfysYAXkHus
 I0nlCcTSLd4cV2ZgK/Hadt3WI4pVBbBOIBZq0UXIUX6WZpxq613eI3FHAJH5Vuak
 p0XpgII6F5tr73lh2LtRb/oFiEHeMcnoEzWM16cMNth+SImpscRaF4/IhkXrH4VX
 fVOnESB2FMyahFRGxry7VDDLqNebxjfIkb4KChIVhD4q/DVG8WNZ4bBa6l+FEOTA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybrxej1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 06:06:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62G5GYns028720;
 Mon, 16 Mar 2026 06:06:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgk3m04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 06:06:48 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62G66gO246662088
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Mar 2026 06:06:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACCF92004B;
 Mon, 16 Mar 2026 06:06:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 296BF20043;
 Mon, 16 Mar 2026 06:06:41 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Mar 2026 06:06:40 +0000 (GMT)
Message-ID: <ded33af5aa226bc7762476cedefb4627968f98c2.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ppc/pnv: fix dumpdtb option
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, Harsh Prateek Bora <harshpb@linux.ibm.com>, Peter
 Maydell	 <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-stable@nongnu.org
In-Reply-To: <abPy6W6-_putw9Tz@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260311143549.118720-1-shivangu@linux.ibm.com>
 <abPy6W6-_putw9Tz@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date: Fri, 13 Mar 2026 22:03:25 +0530
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b79df9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=13-aQ6eR0b4uENYIoH8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eakGyd2RFVMzPsOe53gBdLkbuUQO11X7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA0MSBTYWx0ZWRfX+DnCHGxfQdqg
 d587gUMHo7tm5DPXNFnoVDwRohPVIq3JLq6byOO1WpNz/c6Anse8YOb/uOw0Yx6QLV2rXWDl46y
 CFCN4WHvSVBuLYg1cDu3XySblodv34AKI3OcsLN4MHisF/20WN9OGqOgreSKUCfVx2vbvNFS+1c
 jLtGpuutn1ZAUmqn3GB08TdPVq9z5TcSzy5T9NNHvGka77u1bpRBz9kT4/a3TVqxDE8Iy6Uuzl5
 tjvU80DkTUbgVd/eGRMkBgeKnr1Q9kFk41xalqHcSwFcDfO7JJZpVjwq29jl9OJSLBQ9p2IND9A
 +RoMMMNSZa0mfLFSFKUZgTUYBmtYYef0rrAYOCANaEON7KhWacZsTgiQ/5GAJhvbKK9IOOEDrKv
 STVgPeZIS6VDlHHqCSS3hv5NDPXXJ7MIZWFrHHW43DSZY0S0mPlUWczi92NUEVSO/q3tVp2Vsoa
 VrSP8FLE/robICEyJ+g==
X-Proofpoint-GUID: Ou5vc65dQFrih82XngFFj_DjT2MTc5Mq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160041
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 2026-03-13 at 16:50 +0530, Aditya Gupta wrote:
>=20
> Looks good to me.
>=20
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
>=20
> Thanks,
> - Aditya G

Thanks Aditya G.

~Shivang.

