Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7A0CE8343
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 13:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svGT7-0003H9-60; Mon, 30 Sep 2024 09:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1svGT5-0003C6-Pg; Mon, 30 Sep 2024 09:29:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1svGT3-0001yP-TG; Mon, 30 Sep 2024 09:29:39 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48TLxx7p010995;
 Mon, 30 Sep 2024 13:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=Q
 K79OzDXxdNoTcYHCt1btr4YsB2ZPY0Vbs+cl8Qs9AQ=; b=YIrdazua0A39UWg2G
 Xeg/sMNKPFxSJKQBVhaHvacs/2emMI1nS5xa/47LiuJHeBKubLRPVIx0KCHvqbry
 u35HQyqxnW0KiYA2lItC3IA8d4TYQ8bjtX2mxPBR7X2TN1k7brGsBBEBgtzHAh9F
 ax5wvHIlx/xoCPOUaIXQ9Of4FGiGXHz0agCQM4WwWFja9y7Rc5Kq9mzkMkM5D2iA
 rARvpiP9IqK1ydCccEpjy6+qq2kp2zf6DDo//odJp+h0GEeOWh/w/ni2Cs0oPk8w
 yQRQ7AjPrrhq5UijQfEJi4k0r4QI7eh4bhfZQ7XtI8QDmECJ79NemSpcUle1dysQ
 Ht+ug==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9fwt1r0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 13:29:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48UDTDLm025857;
 Mon, 30 Sep 2024 13:29:35 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9fwt1qx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 13:29:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UAANoF020424;
 Mon, 30 Sep 2024 13:29:34 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xv4rxwvm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 13:29:34 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48UDTXlq15401576
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 13:29:33 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57DC658065;
 Mon, 30 Sep 2024 13:29:33 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E615F5805D;
 Mon, 30 Sep 2024 13:29:32 +0000 (GMT)
Received: from [9.61.73.98] (unknown [9.61.73.98])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 30 Sep 2024 13:29:32 +0000 (GMT)
Message-ID: <93f13152-e3c8-4169-9420-0de8692e3358@linux.ibm.com>
Date: Mon, 30 Sep 2024 09:29:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/18] pc-bios/s390-ccw: Enable failed IPL to return after
 error
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
 <20240927005117.1679506-13-jrossi@linux.ibm.com>
 <e935ee2e-6e6e-44fa-a580-e0ac848d7686@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <e935ee2e-6e6e-44fa-a580-e0ac848d7686@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rK4U61sn-7PfpmY6uwfxe1xiHzsabVU6
X-Proofpoint-GUID: B7Ig_Iv_YDqlwfKk4actxej7leAdpcdj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=922 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300095
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 9/30/24 6:11 AM, Thomas Huth wrote:
> On 27/09/2024 02.51, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
> ...
>>   unsigned long virtio_load_direct(unsigned long rec_list1, unsigned 
>> long rec_list2,
>> @@ -73,13 +73,13 @@ unsigned long virtio_load_direct(unsigned long 
>> rec_list1, unsigned long rec_list
>>       unsigned long addr = (unsigned long)load_addr;
>>         if (sec_len != virtio_get_block_size()) {
>> -        return -1;
>> +        return 0;
>>       }
>>         printf(".");
>>       status = virtio_read_many(sec, (void *)addr, sec_num);
>>       if (status) {
>> -        panic("I/O Error");
>> +        return 0;
>>       }
>>       addr += sec_num * virtio_get_block_size();
>
> Ah, here's the fix for virtio_load_direct() ... since you changed the 
> call site in patch 09 already, I think you should move this hunk to 
> patch 09, too.

Yes, that would be a more appropriate place for it.  Will do.
>
>> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
>> index 8c6b0a8a92..e3fdb95b3c 100644
>> --- a/pc-bios/s390-ccw/virtio.c
>> +++ b/pc-bios/s390-ccw/virtio.c
>> @@ -217,16 +217,19 @@ int virtio_run(VDev *vdev, int vqid, VirtioCmd 
>> *cmd)
>>       return 0;
>>   }
>>   -void virtio_setup_ccw(VDev *vdev)
>> +int virtio_setup_ccw(VDev *vdev)
>>   {
>> -    int i, rc, cfg_size = 0;
>> +    int i, cfg_size = 0;
>>       uint8_t status;
>>       struct VirtioFeatureDesc {
>>           uint32_t features;
>>           uint8_t index;
>>       } __attribute__((packed)) feats;
>>   -    IPL_assert(virtio_is_supported(vdev->schid), "PE");
>> +    if (!virtio_is_supported(vdev->schid)) {
>> +        puts("PE");
>
> Do you remember what "PE" means here? ... might be a good opportunity 
> to fix this error message as well...

Unfortunately I don't know what it means. I guess it would be better to 
write
a new message than continue carrying this mysterious one forward, though.

I'll make those messages you pointed out more useful.

Jared Rossi


