Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBA1CDD1CD
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 17:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suEip-0001Jq-Pp; Fri, 27 Sep 2024 13:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1suEin-0001H2-1O; Fri, 27 Sep 2024 13:25:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1suEik-0002JB-PV; Fri, 27 Sep 2024 13:25:36 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48RFYKBt027078;
 Fri, 27 Sep 2024 17:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=1
 4TE5404MSD8gWJGBWiDssgB5irRnsICqtZ1De16Py8=; b=A119leylne53RKXpR
 izCv+lb83FgWJLILKwTAlBs4+YQacS5mZViieHKVjglDCzaE5Z3i+/4IFh6QqreG
 KyZjSRVQC+2S91TjxfYkIkyvoQixV44QQs9eJk0NJu5tBfgIhh25K45KnxjD8z05
 ZCGiBan4CtMeQIFsbH1d7TkzO4CPICNyUNRArSrKnToGBBORIHIw9se+hkrbzFZV
 AsHjU0rbaCXZKDltX/l+/k0cR57Ihh9RG9RYmJPIlkSlzt4/fEPBVTWi/sEa7xwA
 66Mg3h7Y8QhY4TbbiDvXoimRIbQb8hXPgHkhlf+zpuV49RydC5F0awIg5RlpmXEB
 QTFsw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41wkmnm6m5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 17:25:32 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48RHPV1h009413;
 Fri, 27 Sep 2024 17:25:31 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41wkmnm6kw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 17:25:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48RFU5bX008715;
 Fri, 27 Sep 2024 17:25:30 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t8v1peag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Sep 2024 17:25:30 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48RHPUVU24969886
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 17:25:30 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0900058056;
 Fri, 27 Sep 2024 17:25:30 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CD4558052;
 Fri, 27 Sep 2024 17:25:29 +0000 (GMT)
Received: from [9.61.124.160] (unknown [9.61.124.160])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 27 Sep 2024 17:25:29 +0000 (GMT)
Message-ID: <04abb1f7-6fe2-4f6b-b6f9-9af547870708@linux.ibm.com>
Date: Fri, 27 Sep 2024 13:25:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] pc-bios/s390-ccw: Remove panics from ECKD IPL path
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
 <20240927005117.1679506-9-jrossi@linux.ibm.com>
 <c842e82e-9631-4533-a529-a704a20d902a@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <c842e82e-9631-4533-a529-a704a20d902a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8QxotecBG8vwhGXqcH0HX1CLgRJefvs3
X-Proofpoint-ORIG-GUID: pAafeYLM4ccDS6bd_u1usGvSrFEWuoUk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=898
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270126
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 9/27/24 11:29 AM, Thomas Huth wrote:
> On 27/09/2024 02.51, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Remove panic-on-error from ECKD block device IPL specific functions 
>> so that
>> error recovery may be possible in the future.
>>
>> Functions that would previously panic now provide a return code.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>>
>> ---
>>   pc-bios/s390-ccw/bootmap.c | 183 +++++++++++++++++++++++++------------
>>   1 file changed, 125 insertions(+), 58 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
>> index 0751a225cd..dc7200c264 100644
>> --- a/pc-bios/s390-ccw/bootmap.c
>> +++ b/pc-bios/s390-ccw/bootmap.c
>> @@ -145,14 +145,17 @@ static block_number_t 
>> load_eckd_segments(block_number_t blk, bool ldipl,
>>       bool more_data;
>>         memset(_bprs, FREE_SPACE_FILLER, sizeof(_bprs));
>> -    read_block(blk, bprs, "BPRS read failed");
>> +    if (virtio_read(blk, bprs)) {
>> +        puts("BPRS read failed");
>> +        return -EIO;
>> +    }
>>         do {
>>           more_data = false;
>>           for (j = 0;; j++) {
>>               block_nr = gen_eckd_block_num(&bprs[j].xeckd, ldipl);
>>               if (is_null_block_number(block_nr)) { /* end of chunk */
>> -                break;
>> +                return 0; /* use 0 to indicate end of load, not real 
>> block 0 */
>
> Can we be very sure that block 0 is never a valid one, so that 
> returning 0 is OK here? Maybe you could use an error code instead 
> (intruducing e.g. ENOENT ?)

Yes, because block 0 is an administrative block and is reserved in both CDL
and LDL disk formats.  That being said, it is simple enough to use a 
specific
RC instead, which would be more resilient to format changes in the future
(e.g. if CDL and LDL are no longer written for list-directed IPL formatted
disks), so it is probably worth while to add a new code as you suggest.


