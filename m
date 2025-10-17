Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449D2CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 04:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9cUP-0003yw-To; Fri, 17 Oct 2025 00:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v9cUN-0003yD-Iv; Fri, 17 Oct 2025 00:54:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v9cUK-0004CX-6v; Fri, 17 Oct 2025 00:54:51 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GJgbxB012367;
 Fri, 17 Oct 2025 04:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JyeMjK
 zYsjFSVxf6kg4wHLg531dRT/wXxS6jIUUCdr0=; b=skNs48SQYFbPIoimrssACE
 6dqwo6jgdTv9aR5rA8bvWd0ge2Vd+ObZF/wXTXWfcMjJL6joGlyA+5yHssAwu7eg
 Jdk82/PmKvy0dGaVY8kvGmqd+FiuJatV5N5cjAgFMBvsspzi4D1P1eM0+cOZQw7g
 +Lmt+HuW6VUmXbH/t7ASTgitvBMiSkCQmtYfscDUVduDDwyGE60xx3cXduab7DzD
 mx4BYOfxSBfsiL2HvmR4yA3Zhpo2XCVWIVjkSBfOM9OWOwqFWe7aj5iIVppXVC4/
 O2ew8Q4v71miMQIJkrIPhpUP3aVNHtEv2Mcy/lsWhh+BjzY++XyrrVSmqRguvFcA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnrnt2n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 04:54:41 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59H4nb0s010394;
 Fri, 17 Oct 2025 04:54:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnrnt2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 04:54:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59H0qM3G003618;
 Fri, 17 Oct 2025 04:54:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xy9g9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 04:54:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59H4sa9B51315096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Oct 2025 04:54:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3CB1200DD;
 Fri, 17 Oct 2025 04:54:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C0DD8200DC;
 Fri, 17 Oct 2025 04:54:34 +0000 (GMT)
Received: from [9.124.220.19] (unknown [9.124.220.19])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Oct 2025 04:54:34 +0000 (GMT)
Message-ID: <fb95ba4d-cd05-4e57-8c24-aebba4cc37be@linux.ibm.com>
Date: Fri, 17 Oct 2025 10:24:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] hw/ppc: Pass errp to load_image_targphys() and report
 errors
To: Vishal Chourasia <vishalc@linux.ibm.com>, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com
References: <20251016173502.1261674-1-vishalc@linux.ibm.com>
 <20251016173502.1261674-8-vishalc@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20251016173502.1261674-8-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68f1cc11 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=iNsD6hmKjbe9THaIYngA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: r4lvoc0xG-CEaeqj1-as9IK8pbKJrn6z
X-Proofpoint-ORIG-GUID: y6gKBbuTVRQrHKg4gBI8DDEaWlZu_N0o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfXyw2jc9AKDX5t
 dezqKl41YBEGkAMO6MSvsZ7AAbytX0Kr9Ux7ULBKuFkLnK9sXdvOO7Ax513PVfPlQjsvLwyi+fg
 tVkmwy54u+2M0mJ/MhG2pQ9tIH3uBOC5iwi1AXnCuFgjmg/wZ/YzEllUdVyy5jV/xmMkHUIHsg1
 Vrl/vtarAIRYEVl8nCDBtbm5utsF7C2mTxOsMSm6l2i7BbxrSFZYgHBcGquQpiqMBT6iaWAUhPs
 S1AJ2jCA8ts3epOFn4asQFNsgE1fEdUVtDcgP2Xpcrk8dNEmdL0Wa5tv47B0PelO58bjmvVOzCh
 h8PnTOIMv+SVlBLsTDf4YBSoezK0sWkaDTSqCpAOBaxm5pUQRHLdTRO1bGaLb5yZW8mZVvI8xgL
 l9dfnHZDrBnkrkPy0sqsRMA2Id325w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 16/10/25 23:05, Vishal Chourasia wrote:

> Pass errp to load_image_targphys() calls in ppc machine initialization
> to capture detailed error information when loading firmware, kernel,
> and initrd images.
>
> Use error_reportf_err() instead of error_report() to print the
> underlying error details along with context about which image failed
> to load.
>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>


Regards,

- Aditya G



