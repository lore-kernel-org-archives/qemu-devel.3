Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE51FCED272
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 06:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy48a-00065Q-EQ; Tue, 08 Oct 2024 02:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sy48U-00065A-Hs; Tue, 08 Oct 2024 02:55:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sy48S-0006y3-FG; Tue, 08 Oct 2024 02:55:58 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4986t2YB001399;
 Tue, 8 Oct 2024 06:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=0
 JFY9ZECMQFBsElknI9Q63sCqY3Bn56q4AALNTp1wC0=; b=NYMiSIMm5UicV/VoZ
 sFng4cvPYwgnv7evos7G7VBr2mV3af/YNrO246GpqPbNWPY9oxBpKD6nQu2Vbst+
 b5U/gw3czxfUKE/Kpm/FC52zRBohqprXwuaLu6/BuRY5pm4zl6wGOPhbzt+tYP77
 BVcgoK4M/TObwCWPkmQEj6wWHcp8uyZoK8mD8Su9gfxH086nl4i/h7My0CoTE3zg
 ObKKNxt+zX5D/2a98ftpMaVc7GXnwfoxURMlBs53LiIhPB0aXOM7LJEJvbfbevDP
 Z/qZ4ULoVFLWAJqUWulBguZiL80UmYLv8tg7pE02Xv/2GdM9hAvJLx2/WO9i2A8Y
 kvBsQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424yvv804d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 06:55:52 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4986tq0u002500;
 Tue, 8 Oct 2024 06:55:52 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424yvv804b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 06:55:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4985aesx011598;
 Tue, 8 Oct 2024 06:55:51 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423g5xjtqs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 06:55:51 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4986toXU57475482
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Oct 2024 06:55:51 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF0BF58060;
 Tue,  8 Oct 2024 06:55:50 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8924658051;
 Tue,  8 Oct 2024 06:55:48 +0000 (GMT)
Received: from [9.124.215.170] (unknown [9.124.215.170])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Oct 2024 06:55:48 +0000 (GMT)
Message-ID: <153ea9e3-1b2d-4d55-8e35-4bdd95b14185@linux.ibm.com>
Date: Tue, 8 Oct 2024 12:25:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] ppc/spapr: remove deprecated machine pseries-2.1
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
References: <20241007153838.1085522-1-harshpb@linux.ibm.com>
 <20241007153838.1085522-2-harshpb@linux.ibm.com>
 <4b180079-d800-45b9-a455-5fdebd71179d@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <4b180079-d800-45b9-a455-5fdebd71179d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xc71Xbbca_hlMhYNibvVgFDgfW5jgaJE
X-Proofpoint-GUID: Cfny6qWw8gYUTb1Xsgl4k_eMcj7IaUwa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_04,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 spamscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=991 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410080042
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Philippe,

On 10/8/24 01:53, Philippe Mathieu-Daudé wrote:
> Hi Harsh,
> 
> On 7/10/24 12:38, Harsh Prateek Bora wrote:
>> Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
>> deprecated with reasons mentioned in its commit log.
>> Removing pseries-2.1 specific code with this patch for now.
>>
>> Suggested-by: Cédric Le Goater <clg@kaod.org>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   hw/ppc/spapr.c | 11 -----------
>>   1 file changed, 11 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 2c10a70a48..e9518ff8b3 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -5381,17 +5381,6 @@ static void 
>> spapr_machine_2_2_class_options(MachineClass *mc)
>>   }
>>   DEFINE_SPAPR_MACHINE(2, 2);
>> -/*
>> - * pseries-2.1
>> - */
>> -
>> -static void spapr_machine_2_1_class_options(MachineClass *mc)
>> -{
>> -    spapr_machine_2_2_class_options(mc);
>> -    compat_props_add(mc->compat_props, hw_compat_2_1, 
>> hw_compat_2_1_len);
> 
> Why not remove hw_compat_2_1[] and hw_compat_2_1_len in the same patch?
> 

Nice catch, somehow I missed it. Probably because I saw hw_compat_2_4 
onwards are still shared by other machines. I shall remove the ones for 
which spapr remains the only consumer.

Thanks
Harsh

>> -}
>> -DEFINE_SPAPR_MACHINE(2, 1);
>> -
>>   static void spapr_machine_register_types(void)
>>   {
>>       type_register_static(&spapr_machine_info);
> 

