Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670D2CAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 13:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2Uvw-00078H-44; Sat, 27 Sep 2025 09:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v2Uvm-00075s-91; Sat, 27 Sep 2025 09:25:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v2Uvd-0004aH-Ky; Sat, 27 Sep 2025 09:25:41 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58R1YaPJ028904;
 Sat, 27 Sep 2025 13:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mCl05w
 38/pVlp3HfLr+zYG3MFO6wGu9mNFP+7XhuAsU=; b=ned+Vb7JBQUjtlXkMLS46g
 bh5lyMCCv9Fq9qJkRjcayBFDqtCfQlO9UxVzdjY0n/pXFsEewOD+Pf9zKY/Y9QT9
 ReCBkxCxxlm5Sy/Cbpmf91P3RHFy+QH4jVF9Pqv5iY8FPYOhPJOVBtDHlicigZHP
 81guDqSTXI/JPebUpD85fYx23l59SOzI80e7ORrR52kAcEenZA25WB1x0AjF4Zff
 cWAZEHJudfreCjsmnwzrk6l96bcAflWnZX5talY3Jd+5osqWxLta3mzrmU3SIqnX
 +4lxYXFt0d8mJTZf/2StBtZkQLsNkWajBAj9y/daYJ3GEPDb6pPnAnM9ROziiwMg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bh24gk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 27 Sep 2025 13:25:22 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58RDPL71002238;
 Sat, 27 Sep 2025 13:25:21 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bh24gh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 27 Sep 2025 13:25:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58RB1U87006458;
 Sat, 27 Sep 2025 13:25:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49dawps709-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 27 Sep 2025 13:25:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58RDPHPP31261028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 27 Sep 2025 13:25:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 264BF20043;
 Sat, 27 Sep 2025 13:25:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 604B620040;
 Sat, 27 Sep 2025 13:25:14 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.209.231])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sat, 27 Sep 2025 13:25:14 +0000 (GMT)
Date: Sat, 27 Sep 2025 18:55:21 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Mike Kowal <kowal@linux.ibm.com>, Miles Glenn <milesg@linux.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH v10 3/8] ppc/pnv: Add PnvChipClass handler to get
 reference to interrupt controller
Message-ID: <epxxog4atsi5ga24cevmn5cl7uictslqqmhhdyh4jarahpwf3i@5npqaau76yrj>
References: <20250925173049.891406-1-adityag@linux.ibm.com>
 <20250925173049.891406-4-adityag@linux.ibm.com>
 <9bfc50c6-1bb2-4e94-bf8b-98ae2a33540f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bfc50c6-1bb2-4e94-bf8b-98ae2a33540f@redhat.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68d7e5c2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=Z4z2c3i8t4aBTQXX3UQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfX/EG1WSxdVYgl
 EmpqSwAbU3bLL1vEJhqo13mDFqklpwOhvQdV8dQPd+Um+2bopqaRAXctxcclIr/tdO9927LZsYD
 v++Su8NtEhcBjj/xD2znpU9hRejIEPvaNJsTgzRH0kg93ZPGaVr4VTu7kNd6qMbxpgxQlOovq1s
 Ob9b8+yPybWUMAI7hUO3EyOxCnT2conAU9EjP2Inpshx8ASH6tkNMz9b7Gai94OuV6uYq/WJwxK
 7wMn7ACxN+r1gFd9ZplBDBrMlLKw/cy4CDTonr6xbVTHf2CIVSKHcNtHzaRbi2Y4Cm93LcKJFdP
 WnhZdcvUGpl9KiJ4oQtU9ajjmqkCYfln/PPIL39vfPOOPvyKfsL0z+D6JlxmrW+a/NuMBuEzCXt
 qKnrUuwv37UQ5jHHC9bADj6jor4iUw==
X-Proofpoint-GUID: j00DFPZMcIAT6Ci3Js5nIzoUrAG8Np85
X-Proofpoint-ORIG-GUID: IIbZk1mPHtIN_Yhcb0uInb7dYh-HxkhA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-27_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
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

On 25/09/25 11:02PM, Cédric Le Goater wrote:
> On 9/25/25 19:30, Aditya Gupta wrote:
> > Existing code in XIVE2 assumes the chip to be a Power10 Chip.
> > Instead add a handler to get reference to the interrupt controller (XIVE)
> > for a given Power Chip.
> > 
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> 
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks Cedric.

- Aditya G


