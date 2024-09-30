Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2821ACE8347
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 13:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svGp0-000462-NX; Mon, 30 Sep 2024 09:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1svGoy-0003yz-SI; Mon, 30 Sep 2024 09:52:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1svGow-0004RL-97; Mon, 30 Sep 2024 09:52:16 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UDmkUX021041;
 Mon, 30 Sep 2024 13:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=9
 Er3w9j3wdrFcLA+2iH89I3sh1hFcnWKsBGHzOT8xx4=; b=Qxu9zC6C+Gmw2ADjU
 5nyez8Wj3aJwMllg2mkePr2ut1jbAmgln7ER3CBkEtwyLbtUx4SHfu5uJmbAw5HT
 /IRh0ezfIQuNkEr/PV7oFoV+ocQVFwlXyAEqgs/c7IPyNdS1ydMpthsEuNhVCRdW
 hLO1flDqLNs/MviD7OiD29VKOWH5FMXnerIwrIxMJsJ83p5PxnHW69fbLE4P8d6x
 b0Gwuey0TMnCVSbfNu7ydgf7NlJpnJmycfXtHCV2ISrbA0qQrvI7WfBqq1FNhOaY
 OsTMUIbfP5sh6E+fOm2rChUxlKf2xxgoUc/7OhWtVy/IY2+6nEqhWj3S2xuRdoU1
 4kcfg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9fwt51r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 13:52:12 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48UDqBn4007581;
 Mon, 30 Sep 2024 13:52:11 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9fwt51k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 13:52:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UDmJuL020424;
 Mon, 30 Sep 2024 13:52:11 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xv4ry0py-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 13:52:10 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48UDqABg42860852
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 13:52:10 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8453A58058;
 Mon, 30 Sep 2024 13:52:10 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D37258057;
 Mon, 30 Sep 2024 13:52:10 +0000 (GMT)
Received: from [9.61.73.98] (unknown [9.61.73.98])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 30 Sep 2024 13:52:10 +0000 (GMT)
Message-ID: <6aebad8d-5e88-407a-a8e6-f514bde764ca@linux.ibm.com>
Date: Mon, 30 Sep 2024 09:52:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] pc-bios/s390x: Enable multi-device boot loop
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
 <20240927005117.1679506-18-jrossi@linux.ibm.com>
 <6c85a009-284b-4fe1-8bab-06d55137090f@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <6c85a009-284b-4fe1-8bab-06d55137090f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9Vvhq1Fi6MmNoKtxQ0djZrGmHc3cu87W
X-Proofpoint-GUID: rTUge09WL7aQFPBNyppMBLNa0FDdKW0c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=650 bulkscore=0 suspectscore=0 lowpriorityscore=0
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



On 9/30/24 9:08 AM, Thomas Huth wrote:
> On 27/09/2024 02.51, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Allow attempts to boot from multiple IPL devices. If the first device 
>> fails to
>> IPL, select the pre-built IPLB for the next device in the boot order 
>> and attempt
>> to IPL from it. Continue this process until IPL is successful or 
>> there are no
>> devices left to try.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>>
>> ---
> ...
>> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
>> index d7c457e0ed..e38eedd83a 100644
>> --- a/pc-bios/s390-ccw/main.c
>> +++ b/pc-bios/s390-ccw/main.c
>> @@ -23,7 +23,7 @@ static SubChannelId blk_schid = { .one = 1 };
>>   static char loadparm_str[LOADPARM_LEN + 1];
>>   QemuIplParameters qipl;
>>   IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
>> -static bool have_iplb;
>> +bool have_iplb;
>>   static uint16_t cutype;
>>   LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
>>   @@ -55,6 +55,12 @@ void write_iplb_location(void)
>>       }
>>   }
>>   +static void copy_qipl(void)
>> +{
>> +    QemuIplParameters *early_qipl = (QemuIplParameters *)QIPL_ADDRESS;
>> +    memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
>> +}
>> +
>>   unsigned int get_loadparm_index(void)
>>   {
>>       return atoi(loadparm_str);
>> @@ -152,6 +158,7 @@ static void menu_setup(void)
>>         /* If loadparm was set to any other value, then do not enable 
>> menu */
>>       if (memcmp(loadparm_str, LOADPARM_EMPTY, LOADPARM_LEN) != 0) {
>> +        menu_set_parms(qipl.qipl_flags && ~BOOT_MENU_FLAG_MASK, 0);
>
> That looks supsicious ... did you mean just one "&" instead of "&&" here?
>

Good catch, yes it should be a single “&”.

Jared Rossi

