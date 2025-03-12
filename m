Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E73BC28B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 10:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsJCy-0005lm-OD; Wed, 12 Mar 2025 06:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tsJCP-0005dI-JJ; Wed, 12 Mar 2025 06:20:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tsJCJ-0008GJ-NS; Wed, 12 Mar 2025 06:20:28 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C7vGam009001;
 Wed, 12 Mar 2025 10:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RgVFos
 jnRHh0diMVGmHIwU5c6zaMrXguLJuLDILrj04=; b=RE2fbDmz3ycJz0S8I5dMgU
 9K4Q7ij6nmrj46keurSckSjdOguNRt0/4MC0i+SMHdVTl7FxsT/rObOt4olUaLcx
 6W8/FsVUEq3FpycUWBtp4inoAtI1pziuXb6iAetATh/CHL/tbrblLq2ZkmwOhjoO
 0EuZ8h9qyDUq/2zTVa2Lm9E3jtwQw/z8vS4aMsVt2iNaLFnv1rzoPn0IrgCCCJYp
 01Nb3jOD/7fNWlMLthfjUs+ke/+0RqtoeHVSsM9+kgp8zeBpBIFXtd3QzQ2q51bH
 muKmwd44WM4DH7kid6HjbAvAZz41UUEkC2JFBhWxzc4aUOCURGUBHbtHO3cUeLng
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45avk4b2ct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Mar 2025 10:20:19 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52C9ocXU031034;
 Wed, 12 Mar 2025 10:20:18 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45avk4b2cr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Mar 2025 10:20:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52CAJaGN026021;
 Wed, 12 Mar 2025 10:20:17 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspbj45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Mar 2025 10:20:17 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52CAKHUl20382406
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Mar 2025 10:20:17 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3302058055;
 Wed, 12 Mar 2025 10:20:17 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23FA658054;
 Wed, 12 Mar 2025 10:20:13 +0000 (GMT)
Received: from [9.39.20.206] (unknown [9.39.20.206])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Mar 2025 10:20:12 +0000 (GMT)
Message-ID: <89d61c6e-5a4e-49fc-a285-2215fa476709@linux.ibm.com>
Date: Wed, 12 Mar 2025 15:50:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/spapr: fix default cpu for pre-10.0 machines.
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250312055804.2134569-1-harshpb@linux.ibm.com>
 <408efa3d-bd73-47bc-8723-08c805df6815@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <408efa3d-bd73-47bc-8723-08c805df6815@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Gyz-lPdW0cxdB38wlE_9pZjmKMqizh3j
X-Proofpoint-GUID: uAnjqjr5NYIjIeCdf0_U2cHmFf2gPW5h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1015 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=944
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503120068
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 3/12/25 15:39, Philippe Mathieu-Daudé wrote:
> On 12/3/25 06:58, Harsh Prateek Bora wrote:
>> When POWER10 CPU was made as default, we missed keeping POWER9 as
>> default for older pseries releases (pre-10.0) at that time.
>> This caused breakge in default cpu evaluation for older pseries
>> machines and hence this fix.
>>
> 
> Should we also include:
> 
>    Cc: qemu-stable@nongnu.org
> 
> ?
> 

I guess so. Not sure if we need a patch v2 for just that.

>> Fixes: 51113013f3 ("ppc/spapr: change pseries machine default to 
>> POWER10 CPU")
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   hw/ppc/spapr.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index c15340a58d..b31a91e2e2 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -4748,6 +4748,7 @@ static void 
>> spapr_machine_9_2_class_options(MachineClass *mc)
>>   {
>>       spapr_machine_10_0_class_options(mc);
>>       compat_props_add(mc->compat_props, hw_compat_9_2, 
>> hw_compat_9_2_len);
>> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");
> 
> This is confusing because v9.2 has already been released with that...

I think it still needs to be fixed for v9.2 (and older) if someone wants 
to use pseries-9.2 (and older) with future releases.

Thanks
Harsh

> 
>>   }
>>   DEFINE_SPAPR_MACHINE(9, 2);
> 
> 

