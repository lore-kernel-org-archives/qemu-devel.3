Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AACDFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 07:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK9kX-00047B-Lu; Tue, 05 May 2026 02:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wK9kW-00046t-8p; Tue, 05 May 2026 02:59:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wK9kU-0006nZ-RY; Tue, 05 May 2026 02:59:20 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644Nx5Yu1446669; Tue, 5 May 2026 06:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UA6Itk
 uMM6eCkxb6YEAHQvVKhknayqGZFBsDGarR2HQ=; b=FVfZlw5BbespHuSsO+3VG/
 8699rxPT1aQMgyPmX9r/9Y4bBRBuAGkhqRYObBoFB9FzsEU/CtstapcYEw0Lmnrj
 FqfR3jr9dJws6lhPdx3+3fFSjrgB1xdeACBIII56hJjZmBiqDka+wWIBuPFSdrCW
 AVE1d13hNRbPWw28U0O2HHEEcaR6az4KWsAnIOn2AYCSwpdyEKv3/sl1k4KEoQgI
 1ii0hxkuC5Eg6Hcgmy4Tqn3/YCQakrZLnGEACPl1+8/Dezwm0prDDyCJ54OBL4nj
 rxd05YGFS4pNwlLqdTJQJt59gWGiG9iA+WiWABYM67Z0b5PNo2KrMN84ItADrepA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7ac08-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 06:59:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6456sUwA001109;
 Tue, 5 May 2026 06:59:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9y85wy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 06:59:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6456x9rC31064468
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 May 2026 06:59:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5EA72004B;
 Tue,  5 May 2026 06:59:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6193C20043;
 Tue,  5 May 2026 06:59:07 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 May 2026 06:59:07 +0000 (GMT)
Message-ID: <ad3d91fea41cafb529a08dcc4a29c4801a02091b.camel@linux.ibm.com>
Subject: Re: [PATCH] ppc/spapr: Skip system reset for quiesced CPUs
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Date: Tue, 05 May 2026 12:28:16 +0530
In-Reply-To: <65e1b092-146c-4839-89ee-66d2b0589000@linux.ibm.com>
References: <20260430085409.680930-1-shivangu@linux.ibm.com>
 <65e1b092-146c-4839-89ee-66d2b0589000@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA1OSBTYWx0ZWRfXx2DyKcIedbu6
 W/+vN+R0urHLg9mXPBPoLLjnRsCt9Z4OZW3LLz2kdyOOAYvmFiynEUGQKmyhY5rKhgTxvGD86VV
 hOYSnFZOckcwt3mEe10zlQ1UBb6hcTPkwTBjahhBxEvTs5GSZPQ+JCaqIUdPA+0KQwFlG6WeoB0
 JHAu7gZnk8x8obfEfBu5INh6HzZf/+e+Yezs8w0Vp4c2hIsblAEnsaoG9C8rWzcWVdjMvUoRhAO
 A6pXxTvcFgTsQYdazqSz6k1Bs7T67DD79Yp19wL6fMKrRwwNA7p1fLp1n1y7PVW73jl320ohE/5
 YVPhYBlIgzdFvxxJ2lJlgFC93XYHO7ZJ6lMwjZOnjH/EvJrMVFTrKXVorxv2P7gM7/VTLrk9Pbk
 Uen0u03egJCwS+cWsmNQqjckV/WYG/Zw/NY6zsPo5JmZcDaFI78hNodGLtqKuGeQ9BOsdm2oLH0
 zEM5W0o9lY8c9wq3r8A==
X-Proofpoint-GUID: q4OQJivS85nAtZTelgT-eu1XIBzNUQy1
X-Proofpoint-ORIG-GUID: q4OQJivS85nAtZTelgT-eu1XIBzNUQy1
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69f99543 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=jsGQUsDf8KSS3J6dCNEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050059
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

On Thu, 2026-04-30 at 21:27 +0530, Vishal Chourasia wrote:
> Reviewed-by: Vishal Chourasia <vishalc@linux.ibm.com>
Thanks Vishal.

~Shivang

