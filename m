Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AD3D2A52C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 15:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t16AE-0000zL-LV; Wed, 16 Oct 2024 11:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1t16AD-0000z8-EX; Wed, 16 Oct 2024 11:42:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1t16AB-00022d-CO; Wed, 16 Oct 2024 11:42:17 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GFceTU014710;
 Wed, 16 Oct 2024 15:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pyCCmL
 ITDrddd0p8JusdeDyC+SoID39Stnc9mTALo4U=; b=R5GQCZaA+MXdfNWToQTyqs
 OoEJeQ06p49qI4XsQ2X0OxiqRfp2nu59OElXFnN5dMBDdy733U/VT9yv2EvdbOGV
 iC7ck53G1rPN+5LQlfTGAmTHTjo3Pl/Py8ihsqxsQST7xhikXlXq7MFeJQ6ZxY2J
 F/beA51d00uf5pQyKRu4rL8MUqMCKuJcjWlOVX/mpKtrAxPyGTTH1nYSCKDs6v/S
 4YNUdWvrNd/PLmAw1YaETkzeo6FKsPSdhhjAXmFEFdVL0HsCSRFgJCIa9ACExaLL
 rBnF/kg8ErmXIYiwaF9cRsOTVzrmosFbDZNveGIcWltyfnjV+Yvrg1rgu+YkRKJw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42afyx840t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2024 15:42:01 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49GFdvuY018578;
 Wed, 16 Oct 2024 15:42:01 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42afyx840p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2024 15:42:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49GCntJ8006714;
 Wed, 16 Oct 2024 15:42:00 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4283es2dpc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2024 15:42:00 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49GFfwCT31785378
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Oct 2024 15:41:59 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B93E25805A;
 Wed, 16 Oct 2024 15:41:58 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7A5158054;
 Wed, 16 Oct 2024 15:41:57 +0000 (GMT)
Received: from [9.10.80.165] (unknown [9.10.80.165])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Oct 2024 15:41:57 +0000 (GMT)
Message-ID: <ac9a334b-4872-4884-810c-4da71672283c@linux.ibm.com>
Date: Wed, 16 Oct 2024 10:41:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] qtest/xive: Add test of pool interrupts
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, lvivier@redhat.com,
 pbonzini@redhat.com, Fabiano Rosas <farosas@suse.de>
References: <20241015211329.21113-1-kowal@linux.ibm.com>
 <20241015211329.21113-15-kowal@linux.ibm.com>
 <b2274edc-02fc-4c90-9cbb-80a89fd845b3@redhat.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <b2274edc-02fc-4c90-9cbb-80a89fd845b3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VAl6DoguC8E1LspM6cgCMH7AzL594gx7
X-Proofpoint-ORIG-GUID: nu4Tv2XbQfcs7FUq5bCffU3Petl-L-2y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011
 suspectscore=0 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160097
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
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

On 10/16/2024 3:33 AM, Thomas Huth wrote:
> On 15/10/2024 23.13, Michael Kowal wrote:
>> From: Glenn Miles <milesg@linux.ibm.com>
>>
>> Added new test for pool interrupts.
>>
>> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
>> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
>> ---
>>   tests/qtest/pnv-xive2-test.c | 77 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 77 insertions(+)
>>
>> diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
>> index a6008bc053..6e7e7f0d9b 100644
>> --- a/tests/qtest/pnv-xive2-test.c
>> +++ b/tests/qtest/pnv-xive2-test.c
>> @@ -4,6 +4,7 @@
>>    *  - Test 'Pull Thread Context to Odd Thread Reporting Line'
>>    *  - Test irq to hardware group
>>    *  - Test irq to hardware group going through backlog
>> + *  - Test irq to pool thread
>>    *
>>    * Copyright (c) 2024, IBM Corporation.
>>    *


Just an FYI that I forgot to rebase the the Group 3 XIVE qtest changes 
into these patch sets...  and will be done for version 2.

MAK


>> @@ -267,6 +268,79 @@ static void test_hw_irq(QTestState *qts)
>>       g_assert_cmphex(cppr, ==, 0xFF);
>>   }
>>   +static void test_pool_irq(QTestState *qts)
>> +{
>> +    uint32_t irq = 2;
>> +    uint32_t irq_data = 0x600d0d06;
>> +    uint32_t end_index = 5;
>> +    uint32_t target_pir = 1;
>> +    uint32_t target_nvp = 0x100 + target_pir;
>> +    uint8_t priority = 5;
>> +    uint32_t reg32;
>> +    uint16_t reg16;
>> +    uint8_t pq, nsr, cppr, ipb;
>> +
>> +    printf("# 
>> ============================================================\n");
>> +    printf("# Testing irq %d to pool thread %d\n", irq, target_pir);
>
> Please don't use direct printfs in the qtest framework. If you really 
> have to log stuff, use g_test_message() instead.
>
>  Thomas
>

