Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C380BFED9E1
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Vzz-00085u-2q; Tue, 17 Mar 2026 11:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1w2Vzw-00085L-QL; Tue, 17 Mar 2026 11:06:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1w2Vzv-0005vT-1s; Tue, 17 Mar 2026 11:06:20 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62H71IXq969073; Tue, 17 Mar 2026 15:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0r+qPD
 GAdZAhMB4CnRDUS1s8w8qU34q2o094SYJlETk=; b=YNqYnUH3mLRkue70iEiCZR
 vRQ7r+jY/79QGDbXcL8TYVuqB+qPpxuRZLU+zVIkmm5G9kvaawxyJUPMxizHJNLC
 hK20/elyWa/aNjZnYPGcsO8en3HWTe5btHBcmMe+oq8D5hc2YrXmEec1vhNyRrwx
 AxFl0J3h5BBszE7LYfLLWF2vRccdhohPy65ZnZxQkl4QGvWZT4W5q/Swel0pboSJ
 4Y13O/3g0vfiraliTn9ZX1N78ujRF7PYNFbU6NAMEO4cMr7Jp8jMfOsc99QSQKp/
 qb3tS4gyjNAtsN538SNaNyIECe53eu/A/my1Pel8SCcgAXg43pbrgEmahHJ3TOnw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3hw1r8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 15:06:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HCN7sj028510;
 Tue, 17 Mar 2026 15:06:16 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq19ffy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 15:06:16 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62HF6E3957475346
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2026 15:06:14 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69AB25805E;
 Tue, 17 Mar 2026 15:06:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D819658052;
 Tue, 17 Mar 2026 15:06:13 +0000 (GMT)
Received: from [9.61.145.197] (unknown [9.61.145.197])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Mar 2026 15:06:13 +0000 (GMT)
Message-ID: <cf9ea919-882a-449d-9ec2-1c6acfd23fb0@linux.ibm.com>
Date: Tue, 17 Mar 2026 11:06:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x/kvm: Simplify the async pfault handling code
To: Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org
References: <20260317134531.460141-1-thuth@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260317134531.460141-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IU0gcKDJ_VGD61FULnAXCDdu0Xk-F5oN
X-Proofpoint-ORIG-GUID: IU0gcKDJ_VGD61FULnAXCDdu0Xk-F5oN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEzMCBTYWx0ZWRfX3TnhJ2XiI2Mc
 C4nBHg86pnou7s4JB/UbMDaGhMGhfm/PMYzC9AFw85qxqT/kRcu3GqaM1ZGo2noQpzep+ttV/pB
 Q3dHjyurAlFMbhBNxXEuTrmEEZT2pZMB/0SUtC7V2v6nl8rLEoaCpTi7OYpfrZv1HxM9boKxsOW
 BtN2TN0EJYiGTHPLW56EtY17vfCOGK5tsWwfpvtxPhzcxBwRLJMuCC7z76g+TuzTGRc1CmqD8pa
 Ip7rsm8g8vMKNNgKsz3YbnZn9fHNX+q9r7X7nu+WV5iBU0fdCuX/+ydDvbwVbNTLtv9YeIvwVN3
 21rSW6iFnXWwPFiyk34EZ6M+7Ug3aSVWWsaB+jKOYzwQvVuAaKXbLe4TTyTpuX3V2OwEsH1l4W/
 eFuez9TbS6GFafniL0y7kMlpsLToe4RbYLXQhfYtSb1rFTdegurvervW3sBM5qljRTjAPwURm72
 P5lhrvL+2AMNJpW367A==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69b96de9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=1PiBuSbX7Db_E7daJGwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170130
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 3/17/26 9:45 AM, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Since commit 126e7f78036 ("kvm: require KVM_CAP_IOEVENTFD and
> KVM_CAP_IOEVENTFD_ANY_LENGTH") we require at least kernel v4.4 to
> be able to use KVM. KVM_CAP_ASYNC_PF is available in the kernel
> since v3.15 and KVM_SYNC_PFAULT is available since kernel v3.18,
> so we can assume now that they are available in all supported
> kernels. Thus simplify the code a little bit by removing the
> checks for these features.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

LGTM, thanks Thomas!

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



