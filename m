Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C013FE83849
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 06:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsEMr-00030w-6K; Tue, 17 Feb 2026 01:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vsEMp-00030F-33; Tue, 17 Feb 2026 01:15:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vsEMn-0006k8-Bx; Tue, 17 Feb 2026 01:15:26 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61GEpuWn3434976; Tue, 17 Feb 2026 06:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=KmEL1nILeh+/WiiNrYCOUymWsYVNf0
 sfte4Zh6gy64A=; b=QeHKeuig0Mvucpi2Qn+CISaO7JocvwxajRCRwH7YdMuvKR
 kS+DdOlyjkrf1WGHDuEYYci5ZOMGt+TXVNsJRg+QcbGUPbUfNweygFA4lcnc7yh8
 dD0CQ8QAR8rrj8i5r5HLv7D8WQSZ41pnyxAti5LKAQ5M4qFiysYyf8i1d2+snpMu
 jnAx38U0hG21Yr0YTWfVBmpXwvYvpBFmbCHGf60Gp1S9jmlVlTsrxoSwxe4HU5Ah
 wxCEuYNqfdEcx5euhfgVyuw70tF9LvL1pvDyy3qdBSBBOUEq3yuNHjiuZ9bQRuPT
 yf5IqhlQTEQMk5VitpHDY6/yIbnTN8v7/bCMlmEg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6ujqdp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Feb 2026 06:15:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61H3F1Nh015679;
 Tue, 17 Feb 2026 06:15:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb451ang-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Feb 2026 06:15:21 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61H6FHgV23593404
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Feb 2026 06:15:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4840420043;
 Tue, 17 Feb 2026 06:15:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9446A20040;
 Tue, 17 Feb 2026 06:15:15 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.109.199.210])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 17 Feb 2026 06:15:15 +0000 (GMT)
Date: Tue, 17 Feb 2026 11:45:13 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 0/9] Implement MPIPL for PowerNV
Message-ID: <aZQG2za5x2D-kZEJ@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20251206055648.1908734-1-adityag@linux.ibm.com>
 <d1d537b7-5fbb-4cfc-be4a-5e65324a63a3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1d537b7-5fbb-4cfc-be4a-5e65324a63a3@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E+/AZKdl c=1 sm=1 tr=0 ts=6994077a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=8NfC5G9XakLViSh7LEMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0OSBTYWx0ZWRfX46N9d4s2MH1Z
 1dfzEsw2hC6i6y9T2NvzjaBr+lnPE4Jg6L2lkITuzhEFPIi1XOVwc4HqbcHj485dVqjSy7MAtFw
 FhAykyxbmK7rGL9L1RKtWicc/BwgrIhlCUyy6XI3vEZ0a1TMF+7SBSk4WcydfjwYXr+hwDx+V2A
 uo2S2Bs1Dn8rnWHxO2LskerN7bcUq1TxRFV3x13B8KE45AsdaygVyVhnZaOArrDDGc+oiJxf8FV
 nXHOGlA8ogrXUnEsB7C7tzr/8z3LPDpdVP2mJXmzjCLLMCGe4A81pGRh9talKc5jaO3cKJbogT4
 ObBs2T0362ZE/BfRvFHKoswuGCFvrQBGaEajdil9I3NhdQTU+B8Tdy4i+1g/Y+aCWY2i1U1g7aD
 RpQeT3Y++UghrCvuobKzhR76C0HYby0QRBtB5S0048K3elBJ7Xpdi7nhmKv8MBwGR3P58pa93JT
 nFK43g9rwg+tcMf1bMA==
X-Proofpoint-ORIG-GUID: 4NgUwf9zHST6-Q_WK2-fGAXMA_Ph-i1r
X-Proofpoint-GUID: 4NgUwf9zHST6-Q_WK2-fGAXMA_Ph-i1r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170049
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

Thanks for your reviews, and sorry for the delay Hari, got involved with
other things.

On 26/01/19 01:08PM, Hari Bathini wrote:
> 
> 
> On 06/12/25 11:26 am, Aditya Gupta wrote:
> > Overview
> > =========
> > 
> > <...snip...>
> >
> > Once kernel sees the support, and "fadump=on" is passed on commandline,
> > kernel will register memory regions to preserve with Skiboot.
> > 
> > Kernel sends these data using OPAL calls, after which skiboot/opal saves
> > the memory region details to MDST and MDDT tables (S-source, D-destination)
> > 
> > Skiboot then triggers the "S0 Interrupt" to the SBE (Self Boot Engine),
> > along with OPAL's relocated base address.
> 
> This sounds as though skiboot triggers S0 Interrupt right after kernel
> registers through OPAL calls, which is not the case. Please make it
> explicit that kernel initiates fadump with another OPAL call after
> registering..

Right Hari, will reword the sentence and add this detail.

Thanks,
- Aditya G

> 
> - Hari

