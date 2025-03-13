Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0177BC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 09:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsfCW-0005En-VX; Thu, 13 Mar 2025 05:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tsfCT-0005DN-EZ; Thu, 13 Mar 2025 05:50:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tsfCQ-0006RY-PI; Thu, 13 Mar 2025 05:50:00 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D9X97d025427;
 Thu, 13 Mar 2025 09:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cvCX3K
 D3A123F6RvCwfX/kmBdACilChV6bhkNJ1FtYM=; b=OO/AhxudZZ9VvTLYRVG+I+
 0DhD1nnMcfv04EQ6EFLF39ZAf+ky5+TDdRDV1r2hC/hK5YqMP2MkwdPRNTaVyBAG
 K89vncOadOyt8M4wqbV5GZhNNUGFN9hKmA9hROORoH2oO8Cr+pzqX3hrLqghWCQf
 iHmSQZXTuQAIBIz3H62lg8pSP7lNKkmOgmaMBT/MQ1mOchamwMfi5CMa/cgYLqu6
 yjhW1pc7J2lkjw3rmjjUHM9QVcp5uCigJX09qeHV5i95IvC6NV/9xo8nTuH9G8J1
 PrG9XZ1Rlj47hrDTd5fP6W7/7ID8tFCYISz4jrOWXem7MaSDz5c68JrktHa9CssQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45baa2wgue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 09:49:55 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52D9Zoj9019218;
 Thu, 13 Mar 2025 09:49:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45baa2wgud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 09:49:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52D8ZQ9S012311;
 Thu, 13 Mar 2025 09:49:54 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsrh1vb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Mar 2025 09:49:54 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52D9nrmV23265976
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Mar 2025 09:49:53 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E3DC5805F;
 Thu, 13 Mar 2025 09:49:53 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5568B58043;
 Thu, 13 Mar 2025 09:49:51 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Mar 2025 09:49:51 +0000 (GMT)
Message-ID: <b3e88144-4b24-4bbe-92c9-b2cd053a40b9@linux.ibm.com>
Date: Thu, 13 Mar 2025 15:19:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/spapr: fix default cpu for pre-10.0 machines.
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250312055804.2134569-1-harshpb@linux.ibm.com>
 <Z9KmFPu-vplBDPcw@redhat.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <Z9KmFPu-vplBDPcw@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JuZzydDKHb_qV3zQdC9PkaoYc710qI4D
X-Proofpoint-GUID: -LEUMMXIgZxbknMrau5EcYQ2Gt-myXhU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503130074
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 3/13/25 15:02, Daniel P. Berrangé wrote:
> On Wed, Mar 12, 2025 at 11:28:04AM +0530, Harsh Prateek Bora wrote:
>> When POWER10 CPU was made as default, we missed keeping POWER9 as
>> default for older pseries releases (pre-10.0) at that time.
>> This caused breakge in default cpu evaluation for older pseries
>> machines and hence this fix.
>>
>> Fixes: 51113013f3 ("ppc/spapr: change pseries machine default to POWER10 CPU")
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   hw/ppc/spapr.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index c15340a58d..b31a91e2e2 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -4748,6 +4748,7 @@ static void spapr_machine_9_2_class_options(MachineClass *mc)
>>   {
>>       spapr_machine_10_0_class_options(mc);
>>       compat_props_add(mc->compat_props, hw_compat_9_2, hw_compat_9_2_len);
>> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");
>>   }
> 
> This doesn't make sense.
> 
> AFAICT, the commit 51113013f3 was introduced in the QEMU 9.0.0 release,
> so it is correct that every machine from pseries-9.0 and newer had the
> POWER10 CPU model.
> 
> What broke were the machines that already existed prior to the
> 9.0.0 release, whose default CPU got changed.  IOW, the pseries-8.2
> and earlier machines.

Thanks Daniel for catching this.
I should have checked using git tags. I have posted v2 here:

https://lore.kernel.org/qemu-devel/20250313094705.2361997-1-harshpb@linux.ibm.com/T/#u

regards,
Harsh

> 
> 
> With regards,
> Daniel

