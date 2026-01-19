Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A995CCF2D2
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 10:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhmLa-0000WY-53; Mon, 19 Jan 2026 05:18:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vhmLU-0000U0-HO; Mon, 19 Jan 2026 05:18:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vhmLT-0007lB-0Y; Mon, 19 Jan 2026 05:18:52 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60IJ04oh013793;
 Mon, 19 Jan 2026 10:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=ubUCM69XEC7ovSjDDle/gOzdBIT14F
 9NFLoIT2xDlyU=; b=dwmgs/TncPFTlxydiuAcQMBdx52qskPNrHYg2OonPuUOSb
 3PIv9k6/Vbm8pFt4r0S20cnw9aO6MKXcaEXhHn5VioPB+AxL1Z1Mj0Ka/0/x9vYe
 2gOlhci/4i7DNZWi+6Srp7TgXSaIBTRbppygHCnYIBzROkKgp7XB/GlJBiQpEdb2
 gjb04Zy6EPE+dghAw1R/UFfoNY1B1HWkddt7vDf4cJLo257nf/cUuKo2GszzL8Gi
 57T1XYUYxYmnfLicQRtM8TVnpdCLTj0xQWEazxOwnn+hg9A0a/vbvthye5ZvATZB
 PRr2mC3RD06xiCGpSc3i6R/oqeRbkCPIIi6zB0FA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br1x4ymu6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 10:18:47 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60JAIltZ032147;
 Mon, 19 Jan 2026 10:18:47 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br1x4ymu2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 10:18:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60J89Cvx006394;
 Mon, 19 Jan 2026 10:18:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brqf15t8a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 10:18:46 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60JAIgDp21889542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Jan 2026 10:18:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAFF220040;
 Mon, 19 Jan 2026 10:18:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85BCC2004B;
 Mon, 19 Jan 2026 10:18:40 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.21.137]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 19 Jan 2026 10:18:40 +0000 (GMT)
Date: Mon, 19 Jan 2026 15:48:36 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>
Cc: milesg@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 npiggin@gmail.com, chalapathi.v@linux.ibm.com
Subject: Re: [PATCH 1/4] ppc/pnv: Suppress some "pnv_chiptod unimplemented
 register" messages
Message-ID: <aW3wVCdyn3WkeUoF@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20251218200353.301866-1-calebs@linux.ibm.com>
 <20251218200353.301866-2-calebs@linux.ibm.com>
 <1fa38659565cf4dc1dfe24cc365d685554faecf0.camel@linux.ibm.com>
 <5e13f2c3-2075-4d31-bddc-06dcc31f6eae@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e13f2c3-2075-4d31-bddc-06dcc31f6eae@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=R8AO2NRX c=1 sm=1 tr=0 ts=696e0507 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zemG__UicHLbtfz2P7kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: S6R0EB-vWz5gesV1N_ES0FnU-yTrHfib
X-Proofpoint-GUID: j2QbtWwQdKM6WYqDYv_mhaLakagH0v89
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA4NCBTYWx0ZWRfX62AYeTvM+eFq
 d0gsRHJADHK7qeN7phS7QJV2F7s0QCAGOX/KckJfMT5Qa14O6hGGVctsWmKk9XG996V5u+pRzMw
 9d6PxhTOTqKHwfTzV5l31TJ1w5ksMxIENo6j1WD9D15IDjWqhjjMFJ0APBxqKudVbZ43rvc89PH
 h7QQHKJ59zx5OiARDIQQeRIKwDVpczH6q6FnrzfC7AYga4o2wTS2BHS3YuDobsRyvxyTujszQPg
 lFKgJDLr5ATFNbdojcpO64aqonCb5F/nzJitI8O8E9eNPrmeiKRZ0foVY5lkRsKfyIubMqoJa55
 +ftCNvaGMgtDa5xuebXccguLNRjXVUetzlY7V9aceT0asxLKNXp3/gQlIBTWus4Y/jQi0vb6gCa
 FPyonk6jtzzxVwIeoVFdn44MFjjStN5vER0YVqhqN89WuaYNwYdMWbfRZ0gxaQqVsx4zhfB5k/o
 BAnnRuDDNxYDrtFYyaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601190084
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 26/01/06 11:07AM, Caleb Schlossin wrote:
> 
> 
> On 1/6/26 10:49 AM, Miles Glenn wrote:
> > Hi Caleb.  I wonder if it makes sense to upstream this commit since I
> > suspect that most upstream users will not have the "unimp" log messages
> > enabled unless they are debugging a problem and in that case, we would
> > be erroneously masking these unimplemented registers from the logged
> > output.
> > 
> > Thanks,
> > 
> > Glenn
> 
> I understand your point. Here are my thoughts:
> - Cleaning up these logs for valid accesses (PowerVM bringup and development) reduces the overall log output and helps find real errors
> - In the future, there may be a customer that wants to run PowerVM with upstream QEMU. The more we upstream, the easier that will be.
> - In the future, we are going to have a number of cases like this where we accept accesses and don't log for every unimp access (to clean up log output). If we choose to keep those patches private and don't upstream them it's going to increase the number of private patches we keep, making future rebasing more difficult.
> - I'd prefer to upstream more patches, and focus on keeping only the patches we need to private (for confidentiality or other reasons). To make future rebasing easier.

I agree with Glenn that we shouldn't mask these warnings for everyone.

Since a warning saying a feature is unimplemented is better than
silently not doing anything without any warnings.

Maybe the excessive warnings should only be masked for PowerMV
development work, rather than upstreaming, or we can always upstream
once those are implemented.

- Aditya G


