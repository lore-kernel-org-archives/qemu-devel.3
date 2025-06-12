Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C02C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 14:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPivz-0006Je-0A; Thu, 12 Jun 2025 10:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uPivg-0006AN-KO; Thu, 12 Jun 2025 10:29:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uPiva-0007Zz-RX; Thu, 12 Jun 2025 10:29:20 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CDx8W6012194;
 Thu, 12 Jun 2025 14:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RBgt9X
 Nr7GAwdmi2tIA5G1Te9LZO+sTjrhoiqLlvtXc=; b=qP1GCLD8VMTRgkOtUpcmS/
 OdEPncUpr4HYK/w7QDfJvr8K1/uTJUG01c0NNLwXNXlwsikrxmAPB0owQuBAadSR
 XnwV1TM0dPVhTW+PUbIeVBSpEj48ognHtV6qqdyxC8EKhcZXYdnJ4Ehc3le9j5PY
 TiHN1rrc7qnIW0YGnVv6zmKEWvykTQrIP5dqviR7SGvz2cAtevhV+qiY1kBuwdUF
 tvJIKgrQjeIrAWjAzfeg8r7bBuX3rcdb6fRkNVaRClB6sGJhmD5FEDDZQZYZdylU
 JKgj4xKzJwzL+gqBN6CZgA838J7R+uTG9OXPsEeF8lnjUTpL5qvCzqDkKUZTYCEw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hgutehm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Jun 2025 14:29:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55CEHrFv021895;
 Thu, 12 Jun 2025 14:29:12 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750505ag8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Jun 2025 14:29:12 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55CETARm30409458
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Jun 2025 14:29:11 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9780958052;
 Thu, 12 Jun 2025 14:29:10 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A440558056;
 Thu, 12 Jun 2025 14:29:09 +0000 (GMT)
Received: from [9.61.251.201] (unknown [9.61.251.201])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Jun 2025 14:29:09 +0000 (GMT)
Message-ID: <61622329-5af4-4f50-9438-a30d529dc00b@linux.ibm.com>
Date: Thu, 12 Jun 2025 10:29:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] hw/vfio/ap: attribute constructor for
 cfg_chg_events_lock
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250611211252.82107-1-rreyes@linux.ibm.com>
 <7db34f93-e373-4a27-a0e9-e76d6fe5e032@redhat.com>
Content-Language: en-US
From: Rorie Reyes <rreyes@linux.ibm.com>
In-Reply-To: <7db34f93-e373-4a27-a0e9-e76d6fe5e032@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Pfr/hjhd c=1 sm=1 tr=0 ts=684ae438 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=qZpv2hzm9qyOo8pYOh0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KMdF1W1UsJaskWLISbzR8f6CiuV03jzU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDExMCBTYWx0ZWRfX8vfl41s22R26
 9Wlze/L6WYNkk/B+RD7egT+TUTOSIJShFq5dTnhw4QqpN/nUn0wQONT2IwIzerNLBfMSlxr3QWk
 OP0fLKp/+5u+Jk5ZLeJzGdj10mEwG8e4vjqZR8mRQp1533TCxOybS5zPRLhk+cXn4bjz2lQmemO
 YbC4kDdH5+61bLqEFDB4Ve7x61qhyjONypkOhuNhzkjKZxsQFoWrck7VvYUVtQ8eCjhzXaE8TwH
 93YMjNLvqDVJGh+4Jo6Jq4gjwkSyZMX+SXxqYLQcXjw9ieQgn6lYNNj6Mr1SE8K/JWZMZLbh8WE
 ypgCK3sQW885/wUOCaLygFhw/iH2knUNWM9bvW+g/UERBKSd63jqQRhTUwyWkUp39m2Z/ba/KS9
 bnKApg4i3E+5aU45ZvtljNmj1AOlBr7dZjc9KiZZFhlLSCaPLjrLGjTDIOYQj+G9bXywP34O
X-Proofpoint-ORIG-GUID: KMdF1W1UsJaskWLISbzR8f6CiuV03jzU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_09,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506120110
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 6/12/25 2:18 AM, Cédric Le Goater wrote:
> On 6/11/25 23:12, Rorie Reyes wrote:
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
>> +
>>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
>>     static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>> @@ -230,13 +235,6 @@ static void vfio_ap_realize(DeviceState *dev, 
>> Error **errp)
>>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
>>       VFIODevice *vbasedev = &vapdev->vdev;
>>   -    static bool lock_initialized;
>> -
>> -    if (!lock_initialized) {
>> -        qemu_mutex_init(&cfg_chg_events_lock);
>> -        lock_initialized = true;
>> -    }
>> -
>>       if (!vfio_device_get_name(vbasedev, errp)) {
>>           return;
>>       }
>
>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>
> Applied to vfio-next.
>
> Thanks,
>
> C.
>
Thank you!

