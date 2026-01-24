Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B51FD715C6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 12:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjcMA-0006JB-JM; Sat, 24 Jan 2026 07:03:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vjcM8-0006Hu-HQ; Sat, 24 Jan 2026 07:03:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vjcM6-0007fH-Vj; Sat, 24 Jan 2026 07:03:08 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60O4H17f012953;
 Sat, 24 Jan 2026 12:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=CMqMlAgoqxl4BPO01ym3/sQSkjOZaj
 bB++tXSiLy9vQ=; b=s4ByA4J64jGfIXvbE9QZbxByn14SRfqD9NbZlIOs3eT8oA
 rwyPo0ycab0QULFk+UF7ughl3EnUqS5dCN+NCB3QM1VSKIVV1Y2di0PiuTmRXIU7
 slH0OY1tTaDMUT/iH1VbKxzln+TJNG95yklvJ1HBQHkiTYj4p0fcMUsUC2pdCAsA
 ySKVIM6CyZaHz4oU7PRqJ0KaOg1IFKmJcWza0ZsOZ/RzzXoAEx9ttMYLrSErrkFB
 3o2z1zVi5oHmmvmXUVSrmTfH6EvoxoLcq+ymVImeilZTopFjDrO7A9oVhsygm2cu
 PvwkMsCnWhIehJr747AxgPFcWF8pS+7q5TUpKGtQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfh5yp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Jan 2026 12:03:03 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60OC33xi022684;
 Sat, 24 Jan 2026 12:03:03 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfh5yk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Jan 2026 12:03:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60O82WFR024652;
 Sat, 24 Jan 2026 12:03:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brxasbs3a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Jan 2026 12:03:02 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60OC2wKs25559356
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 24 Jan 2026 12:02:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF9C22004D;
 Sat, 24 Jan 2026 12:02:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 648D220040;
 Sat, 24 Jan 2026 12:02:55 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.25.49]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sat, 24 Jan 2026 12:02:55 +0000 (GMT)
Date: Sat, 24 Jan 2026 17:32:52 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, alistair@alistair23.me,
 chalapathi.v@linux.ibm.com, harshpb@linux.ibm.com
Subject: Re: [PATCH v2] hw/ssi/pnv_spi: Fix fifo8 memory leak on unrealize
Message-ID: <aXS0xSD_DcETeixK@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260120145117.602960-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120145117.602960-1-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=6974b4f7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=Nq6B6XspRFDnIH3HezIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: HKBO15dG5dZcQLSY6ZKB1m9R8efqxFbx
X-Proofpoint-ORIG-GUID: 7fMeUmNwPYeSCsZEKK0CpFuDSsw4ZFKb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI0MDA5NCBTYWx0ZWRfX6pLhF2AMMmU2
 Yem88ayQXFodap3AE07pgyiPhufXFiCxjSNFu6cexItr80AAuzYY1pbcQTnxwH+dHeH7/SaQVnD
 5BNdMmtx4jrAPonGjFf8TPx9Bc5nFSa9q6cfCPNilYhE7uAggXVYhmaFajW0HQ2BNxeeGiOQXta
 QD/LN/8W1owA7k6ghGBtY00rkfTKOqOK5WFj3BixqRvV336r5Nb2hzQYhJWVPx0rv1YDj/Chgjj
 ee8363maL3zB2zz4JE9oxuSUMWMkG1PB//5jBdYVWF6S9Hd+serCAIj6cyfTKexJR+T6+G4PFMn
 4das2bYKvqdxI4kAEbrVcZliBxSafKGfTmamAAM4Z6xEjY4OiUSmsa524+wDvWJ9bw2SMzc2r/j
 mcZJXbXAj/9/OqmRy9s0r5HV0r4idgx4hcHs+C+PcNfqs9rxSk24/j6IS+sB93YisOEo5coTZII
 5WWKslfxX+X7RZm9k3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-24_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601240094
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 26/01/20 08:51AM, Caleb Schlossin wrote:
> unrealize should free the fifo8 memory that was allocated by realize.
> 
> Fixes: 17befecda85 ("hw/ssi/pnv_spi: Replace PnvXferBuffer with Fifo8 structure")
> 
> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
> Reviewed-by: Chalapathi V<chalapathi.v@linux.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>

Looks good, thanks for rebasing and sending.

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

- Aditya G


