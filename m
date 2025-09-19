Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B259CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 18:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzfRp-0001a2-Ue; Fri, 19 Sep 2025 14:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uzfRm-0001ZX-Ej; Fri, 19 Sep 2025 14:03:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uzfRc-0002aF-5i; Fri, 19 Sep 2025 14:03:01 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDlLxh011030;
 Fri, 19 Sep 2025 18:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=r0hyVT
 G6cxYH2KgwueNDu0k3JPpzOSXF0fwiV/RkxV8=; b=D1GSfRb5JvL1GoWLf5Al6P
 wUsCsnAOqN76hamuE6w4nqkZijQLmxPTEI94Xn9VcNBAjdUamKgZJl6Km9S9x6Eg
 P1pwIrW5aNFWCpAjtWXG1fvJlw4pgtolpsSvd4xzKQF5h1JMJSDjJ7TuD9e2FcPa
 ukF0g7V262W3bsb3raPfcW+FRGBcetgBKUNLrSO8Av90Iq+t8rGxsai3gG81Cb6+
 pSbly6X4P8pi4/RRVMn0lkugwkp4m5A9OsQZv0ZC3/KS9ha7nXpsB/jII5cRbp6q
 I5c9DHr4P2KsYFhyF9sSRCYPeKjCihQGt2OeO7L0x5/SnS+2VAzM/I+9sXWGqVyw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4nsnfp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Sep 2025 18:02:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58JFZiPN008988;
 Fri, 19 Sep 2025 18:02:46 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 495nn3vtev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Sep 2025 18:02:46 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58JI2jmX26673688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 18:02:45 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB62758056;
 Fri, 19 Sep 2025 18:02:45 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4AA85805D;
 Fri, 19 Sep 2025 18:02:44 +0000 (GMT)
Received: from [9.61.246.121] (unknown [9.61.246.121])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 19 Sep 2025 18:02:44 +0000 (GMT)
Message-ID: <c8938dac-1fd0-4b90-b402-c074bc0351a9@linux.ibm.com>
Date: Fri, 19 Sep 2025 11:02:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/28] crypto/x509-utils: Add helper functions for DIAG
 320 subcode 2
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-9-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250917232131.495848-9-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MN5gmNZl c=1 sm=1 tr=0 ts=68cd9ac7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=j3SwWdo30wvGsQaUlywA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: ZD3isix7x28ACa2tvlt_PmSQbFB3sumy
X-Proofpoint-ORIG-GUID: ZD3isix7x28ACa2tvlt_PmSQbFB3sumy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX5BOlJzw3n3jQ
 hh6w4y4UBPmbSeKIpt9T3Z98mtMq6W4ztqOTEn9n9S0L6Qd1+0CM+u8JSq2/qGdzuqyNfg7syWA
 kj4g7CyHMTa3IdRyKfleM8umJXrncPKwkZd56spzaInF2IhCH7bMFyQDmYtDUrz2JzKFG1GRMgV
 WLd2ry5Lzr+SDBo53X6YAY/ZIEzxQn1UyAlSFERFlf3DeGbE0AByJh3K0KvHG9jEI4P/l5ilVod
 784FFMrZ47sZE2mcDJB4Ul67fL5LA+nCTH2PbOS7XwH+jNKzigoUQX89EXtNbKj7C5z8f6MiRwD
 IpafUsch3q3lUJvLpH8Inwzzu6DVEKc4Xftd+ytEShD9zYxzIOrlbVQbHic+CBtr0IaSd7FxR2Q
 OKuDptTw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
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


On 9/17/2025 4:21 PM, Zhuoying Cai wrote:
> Introduce new helper functions to extract certificate metadata needed for
> DIAG 320 subcode 2:

Since we are adding generic helper functions to extract certificate 
metadata, maybe we should avoid mentioning about "DIAG 320 subcode 2"?

Thanks
Farhan

>
> qcrypto_x509_check_cert_times() - validates the certificate's validity period against the current time
> qcrypto_x509_get_pk_algorithm() - returns the public key algorithm used in the certificate
> qcrypto_x509_get_cert_key_id() - extracts the key ID from the certificate
> qcrypto_x509_is_ecc_curve_p521() - determines the ECC public key algorithm uses P-521 curve
>
> These functions provide support for metadata extraction and validity checking
> for X.509 certificates.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>

