Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A7BD3DEA6
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 18:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1rJG-0007vC-H9; Fri, 18 Oct 2024 14:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t1rJD-0007um-HK; Fri, 18 Oct 2024 14:02:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t1rJB-0007Ub-Cd; Fri, 18 Oct 2024 14:02:43 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IAiVpf008225;
 Fri, 18 Oct 2024 18:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=d5NZNk
 Zqh78Lbl1qV5s3wd32xFybVl2w6L0EJQd8YJg=; b=VcQTKhUdTOPcLXF0xETShe
 OxG/l3tipDxjXEcm7Xf/AlTGpw1q/0kcXsAsmnPKt/K5CTiwJek91nHHcQAoH6kY
 hggkejKNnSkt3DjTaBe9pUrAuWqv+4i9ZGrSLAOwFnmul993fI8Ga784uFaYRFqZ
 5z7Z9OfhQi0V4I6c2zoje/eSvgZJDhZCkbyryl2nXl+HABYMIH35JvviI2l0Y+kb
 Z/c8XZSKwK9TUUC00jE3pDWxKne7oWhWeEETlsLVQf6ieSgOIHAB3XL+4WoJfJxP
 lAbZSjFoxEviKwDdWcRtIKJzhSnA1DFuUd+Wk+8RcQLExiNxLgp9wtnvzKr+yDHQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42as8aa5aq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Oct 2024 18:02:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49IF8EW1007025;
 Fri, 18 Oct 2024 18:02:38 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284xknxyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Oct 2024 18:02:38 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49II2bJQ42533252
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Oct 2024 18:02:38 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E67B558058;
 Fri, 18 Oct 2024 18:02:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C68D58061;
 Fri, 18 Oct 2024 18:02:37 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 18 Oct 2024 18:02:37 +0000 (GMT)
Message-ID: <eadd4212-e662-4952-9e53-96e2c97f6c3b@linux.ibm.com>
Date: Fri, 18 Oct 2024 14:02:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: Wait for migration completion on destination QEMU
 to avoid failures
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 marcandre.lureau@redhat.com, Fabiano Rosas <farosas@suse.de>
References: <20241016152159.1168722-1-stefanb@linux.ibm.com>
 <a3462080-f37d-45c9-a220-d3475b25997f@tls.msk.ru>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <a3462080-f37d-45c9-a220-d3475b25997f@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CYGBSZw74hEX_yduHoN3Q92cmONePMIJ
X-Proofpoint-ORIG-GUID: CYGBSZw74hEX_yduHoN3Q92cmONePMIJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=728 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180113
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/18/24 12:23 PM, Michael Tokarev wrote:
> 16.10.2024 18:21, Stefan Berger wrote:
>> Rather than waiting for the completion of migration on the source side,
>> wait for it on the destination QEMU side to avoid accessing the TPM TIS
>> memory mapped registers before QEMU could restore their state. This
>> error condition could be triggered on busy systems where the destination
>> QEMU did not have enough time to restore the TIS state while the test 
>> case
>> was already reading its registers. The test case was for example reading
>> the STS register and received an unexpected value (0xffffffff), which
>> lead to a segmentation fault later on due to trying to read 0xffff bytes
>> from the TIS into a buffer.
>>
>> Cc: qemu-stable@nongnu.org
>> Reported-by: Fabiano Rosas <farosas@suse.de>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> 
> Queued for qemu-stable, though this one might better be applied through
> the test tree.

Thanks.  I actually already sent it as part of my PR today...

> 
> Thanks,
> 
> /mjt

