Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4811CF8FA9E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 17:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFEWI-00076B-KC; Tue, 21 Apr 2026 13:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wFEW9-00075O-1d; Tue, 21 Apr 2026 13:04:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wFEW6-0008Ch-4X; Tue, 21 Apr 2026 13:04:08 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LC6kB61685005; Tue, 21 Apr 2026 17:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=uH2evu
 zEgFTDw9yUuGAR/4doWBysVHrK09HuDXPmpRg=; b=ZHqkcmwl5MTWu5+BaPEQfU
 /pNiRQZqhuJAXnrHbI8cQb3oB4JEO7X9u/hJE8nVFhdT5UbaN7C6wHmnhYI6u3uP
 gYfSGUam3/kFAc0wyq9gICpIMZt3jcmmzL85kC2RDXdXLK2xoWDpB1fg3h7zvh4V
 zGJPzr6ZekyUw0eqIvcYq51Z+pPfBj450MFScWwqCPoBzzB75b6L5L/CsfNm4gMX
 qoHTaRBchk10YCNsjg2DXwlvauKLOC4FvznZpZHNM3g7oPGc0YipZlpVFcnYvK/g
 E4aNkvCxONTWB9SHXx1+qjqvX2KsI6LulGy4wxl4Pn5Y74n+DKsSyx26PhVhIonQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2j6ndr1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2026 17:04:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LGoEPe019025;
 Tue, 21 Apr 2026 17:04:00 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmm9q1r82-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2026 17:04:00 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63LH3x5N30474806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Apr 2026 17:03:59 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53E7C58062;
 Tue, 21 Apr 2026 17:03:59 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A44AB58052;
 Tue, 21 Apr 2026 17:03:58 +0000 (GMT)
Received: from [9.61.174.150] (unknown [9.61.174.150])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Apr 2026 17:03:58 +0000 (GMT)
Message-ID: <98ef16d1-2446-40cd-9d14-6793caba7dc4@linux.ibm.com>
Date: Tue, 21 Apr 2026 13:03:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] s390x/pci: Create function to contain
 translation status check
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260411022618.2136588-1-kshk@linux.ibm.com>
 <20260411022618.2136588-3-kshk@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260411022618.2136588-3-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE2NyBTYWx0ZWRfXwgQjVYugwKBh
 MWAdElX4pt23KS31j0wDyDiUCSCAmD7mH2k13ylFkGTY1wrSFwLYbr2scq0hKi6hxHazuuLtqq2
 QCYiZTJTh20H7/nxU2ZzT+JdvPD90TyR/BQwx61TrT/uSMpsTeRahKqeGzG/P7T+Ge8qx4gEClM
 HzQ74Wd5x4BbtVK5kqfY6Wb4nkWgxoLfAc/sRetc/263Z868QSru1/D46pH8LgbeRs78g8JNinB
 fEFGJlLF9hyPvX1xkdh2a/r9TkDBSt3s276ESxdsr5OAtCNmKAY565qsdHvFm//byk1qhaX8TTF
 MbDCmP2PcmeAFrubyKZltbCk+Mcl9LwMIJ8X3dFwWDdsUeMvlnxgFNs9F7kItEoU65l1j1c61Kt
 bnDVrDqO7TTvC2nmBSanI6X1/AE/xrA8uJpeN5XsDh/maNoW7jSDdn8JjaGgbQx5NQp0urQIfKy
 MpLfjog+WDWQgloT8QA==
X-Proofpoint-GUID: h6j3zeY_x2CHUURpt5Ca3EqTZDz6jKP3
X-Authority-Analysis: v=2.4 cv=SOJykuvH c=1 sm=1 tr=0 ts=69e7ae01 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=hku6z8kztkKjzKdHO3YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: h6j3zeY_x2CHUURpt5Ca3EqTZDz6jKP3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210167
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 4/10/26 10:26 PM, Konstantin Shkolnyy wrote:
> Make it more clear what the bit means, and the new function will be called
> from yet another place in the future.
> 
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>

Christian gave you a review comment + a reviewed-by tag for this patch
last version.

You should check if you can apply his suggestion (or if you can't, reply
to his comment and explain why).

Also, please include his review tag on v3.

As-is or with Christian's suggestion incorporated:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



