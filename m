Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612DAC71143
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 14:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPivV-000688-IH; Thu, 12 Jun 2025 10:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uPivS-00067E-8a; Thu, 12 Jun 2025 10:29:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uPivP-0007Y7-Nc; Thu, 12 Jun 2025 10:29:05 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CBopxd018328;
 Thu, 12 Jun 2025 14:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=q+ro51
 Q9+TFZJMllYRpb9f8P56K8GnzQNPubz6em+2c=; b=OYC7GWjaLh/yQjykXlIOWF
 flr3JR137uEYSSaV8FKSGdCnrG2sMXDEc/WTJikYJvdYMhPsYJqgMRPghxM+HSz5
 1NMshzkWPQ9VmciPre+3JErTkr5U5hFkObgF5Hb7iDgJy9gaHOEXK/j9haFGeLCg
 oYO5N19PVL5ydwyVINHLaLLSL4sZWf0VPuhjFwYCqkcS/pSl84+K6cEojSpDlUMB
 ObDsUKqOIK4fjs/yZjzO8xG8qGpPJUodA4QudnBLDuJr3oULFIU3sMegCvckp1lg
 BDMsmjX2MZbF4mCJBidsPf+78lhB2Wb9z0RACsKNfCvJAq+glzVJCv03n9RdEQzQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474cxjkfcg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Jun 2025 14:28:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55CE9Ar5021836;
 Thu, 12 Jun 2025 14:28:58 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750505afr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Jun 2025 14:28:58 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55CESufk14746314
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Jun 2025 14:28:57 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C48C15805E;
 Thu, 12 Jun 2025 14:28:56 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5E8058056;
 Thu, 12 Jun 2025 14:28:55 +0000 (GMT)
Received: from [9.61.251.201] (unknown [9.61.251.201])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Jun 2025 14:28:55 +0000 (GMT)
Message-ID: <9a5f8bdb-ccd3-42ad-8aba-1349257f893b@linux.ibm.com>
Date: Thu, 12 Jun 2025 10:28:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] hw/vfio/ap: attribute constructor for
 cfg_chg_events_lock
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, akrowiak@linux.ibm.com
References: <20250611211252.82107-1-rreyes@linux.ibm.com>
 <f986cf46-038e-4e83-8ad8-af0aef23e280@redhat.com>
Content-Language: en-US
From: Rorie Reyes <rreyes@linux.ibm.com>
In-Reply-To: <f986cf46-038e-4e83-8ad8-af0aef23e280@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5CnN8AXYX4WV_xWXnaCoKR2zBAAJWlPI
X-Proofpoint-GUID: 5CnN8AXYX4WV_xWXnaCoKR2zBAAJWlPI
X-Authority-Analysis: v=2.4 cv=fZWty1QF c=1 sm=1 tr=0 ts=684ae42b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=P0cOYzpaa20-vJwTllYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDExMCBTYWx0ZWRfX3iZbMhisGRLH
 iSDZK+/N4eQJwwd/EB/jdYalfLC+ZPunx5IhLXm7sUCEjKYL+5v9l8AsuR7rAIFpLWPI84nr43o
 /Lx1AXdm3pdRy0Js3keNDaGZDEBfLUEmn3AznvV2FlWDBlO9MjKnA67WpiIsuO5idI/XKghRSnP
 o36Syed3wn/d1zokaUp8gzW4mAJEXACQe3qJLZSiknAREsnj+eQ+HkHLvVFFqqbhGOZWGef+3Yv
 qPwRjC/ccVtEKqyVWKcNfqcRBZ15nsZu20ENAo4tDIMlb+5t64O4tdedMrrivGISVTFHWjWMzRq
 sGYLlltYl3jNedgYQZPbAqkYUmwyUHqaa112mLFmRnrTt/whsklg8IoCZAiv2YCniiw5TR7J5y5
 /59ny0+EsKiO2XLPttFzOgF9mwqbfKATFNUoQypnSvYc/6H9jvnsdIKOMudpcKqPktGgyLbV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_09,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120110
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
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


On 6/12/25 12:44 AM, Thomas Huth wrote:
> On 11/06/2025 23.12, Rorie Reyes wrote:
>> Created an attribute constructor for cfg_chg_events_lock for locking
>> mechanism when storing event information for an AP configuration change
>> event
>>
>> Fixes: fd03360215 ("Storing event information for an AP configuration 
>> change event")
>> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
>> ---
>>   hw/vfio/ap.c | 12 +++++-------
>>   1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index 874e0d1eaf..1df4438149 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -52,6 +52,11 @@ static QTAILQ_HEAD(, APConfigChgEvent) 
>> cfg_chg_events =
>>     static QemuMutex cfg_chg_events_lock;
>>   +static void __attribute__((constructor)) vfio_ap_global_init(void)
>> +{
>> +    qemu_mutex_init(&cfg_chg_events_lock);
>> +}
>
> I wonder why we don't have a macro for this yet (there are many other 
> spots in the code that initialize a mutex like this).
>
> Anyway, for your patch:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
Thank you!

