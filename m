Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D0FCE8343
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 13:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svGcR-0007XH-0q; Mon, 30 Sep 2024 09:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1svGcP-0007W3-48; Mon, 30 Sep 2024 09:39:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1svGcN-0003D7-82; Mon, 30 Sep 2024 09:39:16 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U2wHor011680;
 Mon, 30 Sep 2024 13:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=+
 qEcVUctaEZ2b0nDAHkl2fBznJJnWqGIwnKBtUQdFk0=; b=CSuCYHVg+kxphSXul
 LxjAc11V8vkc5gRvMQVJnnfRmTu71yWik5Ozepf0ly4+gtUnsPRmUPUk8MdWKemC
 hnTFOf5CVhCUzF0i/n8gcHcTKtAKcohcfddAnJ1ToAyI3a/0LZN+yqDoT8GmYVjb
 eQ6mg0reuZGwgZ10e7GMMHeixufBFKh+VbhRn6soMJl7fOxgpEa1xVyYEhH0j//4
 uIGrwrEIxyaPhlZCxJhBbL+iOaGKyD8yV/gED8y5dY+Q3aILVfy6ss8V8tHNea88
 48bKCpI3i4F9HOuC2D1gNveD8VcOOdDRlzlVXbO3QImXQZOmdbkxZkekkbozcDp5
 RzvYw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9hb23tt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 13:39:12 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48UDdCD8013254;
 Mon, 30 Sep 2024 13:39:12 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9hb23tq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 13:39:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UAxRd1017866;
 Mon, 30 Sep 2024 13:39:11 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4mpsen-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 13:39:11 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48UDdAxa43975016
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 13:39:10 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B8ED58057;
 Mon, 30 Sep 2024 13:39:10 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01EE558058;
 Mon, 30 Sep 2024 13:39:10 +0000 (GMT)
Received: from [9.61.73.98] (unknown [9.61.73.98])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 30 Sep 2024 13:39:09 +0000 (GMT)
Message-ID: <9b32531b-2f83-42fe-baf4-1dfb8e15e040@linux.ibm.com>
Date: Mon, 30 Sep 2024 09:39:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/18] hw/s390x: Build an IPLB for each boot device
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
 <20240927005117.1679506-16-jrossi@linux.ibm.com>
 <b3674e3b-5a23-41a0-a100-7fb2810a2775@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <b3674e3b-5a23-41a0-a100-7fb2810a2775@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 05hhSHgpn2gb0hsPkzlgJ2W61wuOu69m
X-Proofpoint-ORIG-GUID: uYnY3sZ3W-V11JUzlx83EQXQKzv6zBza
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=664 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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



On 9/30/24 7:59 AM, Thomas Huth wrote:
> On 27/09/2024 02.51, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>> ... 
>> @@ -484,8 +499,8 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>>               lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
>>           }
>>   -        s390_ipl_convert_loadparm((char *)lp, ipl->iplb.loadparm);
>> -        ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;
>> +        s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
>> +        iplb->flags |= DIAG308_FLAGS_LP_VALID;
>>             return true;
>>       }
>> @@ -493,6 +508,58 @@ static bool s390_gen_initial_iplb(S390IPLState 
>> *ipl)
>>       return false;
>>   }
>>   +static bool s390_init_all_iplbs(S390IPLState *ipl)
>> +{
>> +    int iplb_num = 0;
>> +    IplParameterBlock iplb_chain[7];
>> +    DeviceState *dev_st = get_boot_device(0);
>> +
>> +    /*
>> +     * Parse the boot devices.  Generate an IPLB for the first boot 
>> device,
>> +     * which will later be set with DIAG308. Index any fallback boot 
>> devices.
>> +     */
>
> The comment looks like it rather belongs to the whole function, and 
> not to the if-statement below? So maybe move it at the top?

Agreed.

>
>> +    if (!dev_st) {
>> +        ipl->qipl.chain_len = 0;
>> +        return false;
>> +    }
>> +
>> +    iplb_num = 1;
>> +    s390_build_iplb(dev_st, &ipl->iplb);
>> +    ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;
>
> Isn't DIAG308_FLAGS_LP_VALID set within s390_build_iplb() already?
>
>> +    while (get_boot_device(iplb_num)) {
>> +        iplb_num++;
>> +    }
>
> I'd maybe move the code block below to this spot here, so you've got 
> to assign ipl->qipl.chain_len only once:
>
> +    if (iplb_num > MAX_IPLB_CHAIN + 1) {
> +        warn_report("Excess boot devices defined! %d boot devices 
> found, "
> +                    "but only the first %d will be considered.",
> +                    iplb_num, MAX_IPLB_CHAIN + 1);
> +
> +        iplb_num = MAX_IPLB_CHAIN + 1;
> +    }
>
>> +    ipl->qipl.chain_len = iplb_num - 1;
>> +
>> +    /*
>> +     * Build fallback IPLBs for any boot devices above index 0, up to a
>> +     * maximum amount as defined in ipl.h
>> +     */
>> +    if (iplb_num > 1) {
>> +        if (iplb_num > MAX_IPLB_CHAIN + 1) {
>> +            warn_report("Excess boot devices defined! %d boot 
>> devices found, "
>> +                        "but only the first %d will be considered.",
>> +                        iplb_num, MAX_IPLB_CHAIN + 1);
>> +
>> +            ipl->qipl.chain_len = MAX_IPLB_CHAIN;
>> +            iplb_num = MAX_IPLB_CHAIN + 1;
>> +        }
>
> i.e. move this code block -^
> and remove the "ipl->qipl.chain_len = MAX_IPLB_CHAIN;" in there.
>
>> +        /* Start at 1 because the IPLB for boot index 0 is not 
>> chained */
>> +        for (int i = 1; i < iplb_num; i++) {
>> +            dev_st = get_boot_device(i);
>> +            s390_build_iplb(dev_st, &iplb_chain[i - 1]);
>> +            iplb_chain[i - 1].flags |= DIAG308_FLAGS_LP_VALID;
>
> Again, setting DIAG308_FLAGS_LP_VALID should not be necessary since it 
> is already done in s390_build_iplb() ?
>

I’ll see if I can clean section this up and remove redundant flag 
assignments.

Jared Rossi

