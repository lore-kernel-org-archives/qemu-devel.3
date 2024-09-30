Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA024CE8348
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 13:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svGjR-00044D-Gn; Mon, 30 Sep 2024 09:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1svGjJ-00042A-HJ; Mon, 30 Sep 2024 09:46:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1svGjE-0003qE-Ew; Mon, 30 Sep 2024 09:46:25 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U9S38J000596;
 Mon, 30 Sep 2024 13:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=L
 VU0F8s+6h0BcXN8yUyF6+K+fJNfW8fMF0NBSh+g380=; b=I0i6DAgtbgYOddAMf
 VZ2pqDhMN7hV7GZRybcSa9Gf0NaOFH24idfqb3hVOnLjSscMnZ9kkZw73gw5Igzm
 JYMMhjz9wLPKI37lwiZ59pkNgA2GQyEPL+nAHZzBDbGJUIzmo2bLXLsoJB/bF2SG
 GqnNCg0cEJNaKBNNMGq6BbHy0Qchp3DYd/O/nVNIirXPS2fW0sN+f5n3AqJVaJy8
 2GZbG3I+FTqMnoAiN55QnlSjW66y7kT4kYjwvNmQ4ZvMwyOTcNTTGgPXEwGA3iIJ
 InQrPzyMdQr7zwRkJfy50PRGKw5RPl9UNjvfNnGU0o4EwIJ41BUo+lYj3lu717PE
 9DTlA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9fwt45d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 13:46:10 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48UDk9C6027626;
 Mon, 30 Sep 2024 13:46:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9fwt457-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 13:46:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UBXalh014150;
 Mon, 30 Sep 2024 13:46:08 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xwmjxq0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 13:46:08 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48UDk77S29688156
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 13:46:07 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A646B58058;
 Mon, 30 Sep 2024 13:46:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C3F258057;
 Mon, 30 Sep 2024 13:46:07 +0000 (GMT)
Received: from [9.61.73.98] (unknown [9.61.73.98])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 30 Sep 2024 13:46:07 +0000 (GMT)
Message-ID: <4204b063-b486-4745-b818-291f849b5b16@linux.ibm.com>
Date: Mon, 30 Sep 2024 09:46:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/18] s390x: Rebuild IPLB for SCSI device directly from
 DIAG308
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
 <20240927005117.1679506-17-jrossi@linux.ibm.com>
 <7fdb3ac0-7745-4d97-b575-867b068d17eb@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <7fdb3ac0-7745-4d97-b575-867b068d17eb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5QeAXfMlmVBjoN2VecP4SWs8xBZfg7Yz
X-Proofpoint-GUID: Bo9V6ecRU7bsV2FbgA9-l8nQlVxH0TOh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300098
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



On 9/30/24 8:15 AM, Thomas Huth wrote:
> On 27/09/2024 02.51, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com> ... 
>> @@ -661,35 +629,33 @@ IplParameterBlock *s390_ipl_get_iplb(void)
>>       return &ipl->iplb;
>>   }
>>   -void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
>> +static void s390_ipl_prepare_qipl(S390CPU *cpu)
>>   {
>>       S390IPLState *ipl = get_ipl_device();
>> +    uint8_t *addr;
>> +    uint64_t len = 4096;
>> +
>> +    addr = cpu_physical_memory_map(cpu->env.psa, &len, true);
>> +    if (!addr || len < QIPL_ADDRESS + sizeof(QemuIplParameters)) {
>> +        error_report("Cannot set QEMU IPL parameters");
>> +        return;
>> +    }
>> +
>> +    memcpy(addr + QIPL_ADDRESS, &ipl->qipl, sizeof(QemuIplParameters));
>> +    cpu_physical_memory_unmap(addr, len, 1, len);
>> +}
>
> Why did you move the s390_ipl_prepare_qipl() function around? It does 
> not seem to get moved in the new code below, so the movement does not 
> seem to be required?
>
>
>  Thomas
>

You are correct, it is not necessary to move it.  I moved it in preparation
for a change I ultimately ended up reverting, but I forgot to revert moving
the function itself.  I’ll fix it.

Jared Rossi

