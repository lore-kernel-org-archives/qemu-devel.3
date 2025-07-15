Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0295C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubh6f-0005h9-84; Tue, 15 Jul 2025 10:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1ubgVR-0005pr-GN; Tue, 15 Jul 2025 10:19:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1ubgVP-0002h2-09; Tue, 15 Jul 2025 10:19:41 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FA0o7h029388;
 Tue, 15 Jul 2025 14:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fRcdQQ
 XN0CMnsUESFCsH7ltSTPNqyjWVjf1Y91CHfT0=; b=mujy/8tDJ99u6oIeX0ePyX
 hRFFYDSrf5X2ynPEdMh53iYzWfHKv/5lOCodeuhv67rclHw0IJQn99Lc1YdzINm3
 dHT+Fv9hmswAAs6Xf+Rh2MKquzyvJ27cMDOOB7JUvWdfTKuZIdybNTkFt014U/w4
 yMuqYfFE5hDesv4in9xcNa3SpcJ3SE3I9sPU7oOSCfve40VlDWhi/Tedfd+1cOvT
 BDR9q31oZUwBdWlxkgdvEHUPOt2HHAVzEEOcOILLYjikFXE/V3iT5ITRGOFdlw1q
 Zld4ccDlMuzkIB+6cRj/Awp2cQJ6NDd0PDjT6v9EkIK0Y+Zs8uhdAkdW2Jy/FwCg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7cyr4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 14:19:32 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56FEHq1J005520;
 Tue, 15 Jul 2025 14:19:32 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7cyr4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 14:19:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56FCGkcf031905;
 Tue, 15 Jul 2025 14:19:31 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v21u307s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 14:19:31 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56FEJTNY32047816
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Jul 2025 14:19:29 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FC385805E;
 Tue, 15 Jul 2025 14:19:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF4385805A;
 Tue, 15 Jul 2025 14:19:27 +0000 (GMT)
Received: from [9.61.114.9] (unknown [9.61.114.9])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Jul 2025 14:19:27 +0000 (GMT)
Message-ID: <7eca1e6b-9c70-4526-909b-0adfcb4ad7b6@linux.ibm.com>
Date: Tue, 15 Jul 2025 10:19:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/22] s390x/s390-pci-vfio.c: use QOM casts where
 appropriate
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-22-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20250715093110.107317-22-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zc5vnTqke3mX0dOJmLGs89CyP4CdUaz8
X-Authority-Analysis: v=2.4 cv=LoGSymdc c=1 sm=1 tr=0 ts=68766374 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=64Cc0HZtAAAA:8 a=VnNF1IyMAAAA:8
 a=6V_Z78ehL-hMsaM6yTMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RXMXXy-SbI07QefzcXLhIpobU6tcMoJm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEzMSBTYWx0ZWRfXyGjufKPjQ3Qp
 zBtfol6LGjEWeKtOsSrVKW74eV5ULsfwPAYEwUgErwR9p+YnzmBbMErOpySXqsxnUw93ESAKi57
 M61JmkJI45L5albD+pEEr8iYeJHi9gXWAj+e7gPfuGjYXW2tyxSdc+yUr+CG/pBPSxse92HvRM4
 s5axT6/WBQ6yRrTHeN0Qw4BJiwHCcij7uQAzgNpLKHuVJfZ+lcgYhcMP+wsULAypsPORrhal9Qd
 7zQabqMrGvu1yCffLtmiT2btMVkERywH0RsltYOzxx3Ih49op2OZoC9GjVAhGAFUoB/ZThIcVZg
 JIdLADw06EfY9SFMxOzAf+99TbBhE1BhMokDpmwbqn+Nlz9K7rr0wnLdKdUBbtFLSvZnOwLKtKl
 4H1AaAuJZeCau5AiW2AAZX735r1JLmvKfujrLm93+hyF2Awu+NF+LaAw43RATlgfSCRX+B4F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 phishscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150131
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 7/15/25 5:26 AM, Mark Cave-Ayland wrote:
> Use QOM casts to cast to VFIOPCIDevice instead of using container_of().
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/s390x/s390-pci-vfio.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

