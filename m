Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2ED7D2F7E8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 08:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1iaI-0007dc-MN; Fri, 18 Oct 2024 04:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1t1iaG-0007dA-TY; Fri, 18 Oct 2024 04:43:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1t1iaE-0003RB-2u; Fri, 18 Oct 2024 04:43:44 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I8bNMY025156;
 Fri, 18 Oct 2024 08:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=aNgMLq
 eyJ+9ETqBnDGbeS8eewDF/fybCxfnEDW5Wpmk=; b=rfiFKBUvWOUoeuDEcz6T5B
 GQVONlXFI6VD2hR+sBr677fnN8Q/3ggDli17ujrb71CC+bRGlm9EauWHxxdTEDD5
 KWvyOsRmCJBLuzWA7gAOj4HsOCv81FnosqynHC3Bw7HGSj0DV7/iT3LfMxEpZqAi
 quexOFxe8ojOFvwjNFTIUnxb2wzZaCzoEI9VYK0zkY6V+OUjv0NW7rY4uP+lNHnE
 tHWDjPDiW21E/iVa1x2iNjiuyEBI3dTABhXknFZevmJjzP9rjZkplxNfIpnc5fk7
 EJrC3lnCJwV2eLJyNaT0TB8r1qsg/W9tE71/UCvHPcX/JQEr3WjkcABOyTU6GZQg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42asbd7wku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Oct 2024 08:43:35 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49I8hZJO011914;
 Fri, 18 Oct 2024 08:43:35 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42asbd7wkq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Oct 2024 08:43:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49I7cDiO002426;
 Fri, 18 Oct 2024 08:43:34 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284en3f79-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Oct 2024 08:43:34 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49I8hW2649676690
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Oct 2024 08:43:32 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 830F258060;
 Fri, 18 Oct 2024 08:43:32 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAD665804E;
 Fri, 18 Oct 2024 08:43:29 +0000 (GMT)
Received: from [9.124.220.95] (unknown [9.124.220.95])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 18 Oct 2024 08:43:29 +0000 (GMT)
Message-ID: <952fc526-03a5-4965-9bba-f3aa30147370@linux.ibm.com>
Date: Fri, 18 Oct 2024 14:13:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spapr: nested: Add support for DPDES SPR in GSB for TCG L0
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20241017110033.3929988-1-amachhiw@linux.ibm.com>
 <07af4e02-aa2a-494c-9279-cd70389fc97e@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <07af4e02-aa2a-494c-9279-cd70389fc97e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ipi2fBEKfu4kddEj_ZYxpp9K1bgVyA3A
X-Proofpoint-GUID: plfxq4MFxZaFzvh5uAVEkp57vi5iax2a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 mlxlogscore=910
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180052
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

Hi Amit,

On 10/18/24 10:47, Harsh Prateek Bora wrote:
> Hi Amit,
> 
> On 10/17/24 16:30, Amit Machhiwal wrote:
>> The DPDES support for doorbell emulation and handling for KVM on PAPR
>> guests was added in Linux via [1]. Subsequently, a new GSB element for
>> DPDES was added in Linux; the same has been missing in QEMU L0. Add
> 
> s/QEMU L0/ TCG L0 implementation?
> 
>> support for DPDES register's APIv2 GSB element and required handling in
>> `spapr_nested.c`.
>>
>> Currently, booting a KVM guest inside a QEMU TCG guest fails with the
>> below crash. The crash is encountered when GUEST_RUN_VCPU hcall made
>> into QEMU TCG L0 fails because H_INVALID_ELEMENT_VALUE is returned as
>> the mapping of the element ID corresponding to DPDES (unknown to QEMU
>> TCG L0) in GSR (Guest State Request) of TCG guest's KVM to the GSB
>> (Guest State Buffer) elements of QEMU TCG L0 fails.
> 
> GSB full form would be more appropriate along with first mention of GSB 
> in above text.
> 
> With that:
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> 
>>

<snip>

>> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
>> index c02785756c1e..b696ad537a77 100644
>> --- a/hw/ppc/spapr_nested.c
>> +++ b/hw/ppc/spapr_nested.c
>> @@ -194,6 +194,7 @@ static void nested_save_state(struct 
>> nested_ppc_state *save, PowerPCCPU *cpu)
>>           save->fscr = env->spr[SPR_FSCR];
>>           save->pspb = env->spr[SPR_PSPB];
>>           save->ctrl = env->spr[SPR_CTRL];
>> +        save->dpdes = env->spr[SPR_DPDES];
>>           save->vrsave = env->spr[SPR_VRSAVE];
>>           save->dar = env->spr[SPR_DAR];
>>           save->dsisr = env->spr[SPR_DSISR];
>> @@ -293,6 +294,7 @@ static void nested_load_state(PowerPCCPU *cpu, 
>> struct nested_ppc_state *load)
>>           env->spr[SPR_FSCR] = load->fscr;
>>           env->spr[SPR_PSPB] = load->pspb;
>>           env->spr[SPR_CTRL] = load->ctrl;
>> +        env->spr[SPR_DPDES] = load->dpdes;
>>           env->spr[SPR_VRSAVE] = load->vrsave;
>>           env->spr[SPR_DAR] = load->dar;
>>           env->spr[SPR_DSISR] = load->dsisr;

Looks like we overlooked above inits already present in existing code.
I just checked above inits in nested_{save,load}_state are already
present as common code between apiv1 & apiv2. So, we only need the inits
below for initializing the lookup table.

regards,
Harsh
>> @@ -982,6 +984,7 @@ struct guest_state_element_type 
>> guest_state_element_types[] = {
>>       GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_FSCR,  fscr),
>>       GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_PSPB,   pspb),
>>       GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_CTRL,  ctrl),
>> +    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_DPDES, dpdes),
>>       GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_VRSAVE, vrsave),
>>       GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_DAR,   dar),
>>       GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_DSISR,  dsisr),
>> diff --git a/include/hw/ppc/spapr_nested.h 
>> b/include/hw/ppc/spapr_nested.h
>> index 93ef14adcc5e..3b5cd993c256 100644
>> --- a/include/hw/ppc/spapr_nested.h
>> +++ b/include/hw/ppc/spapr_nested.h
>> @@ -99,7 +99,8 @@
>>   #define GSB_VCPU_SPR_HASHKEYR   0x1050
>>   #define GSB_VCPU_SPR_HASHPKEYR  0x1051
>>   #define GSB_VCPU_SPR_CTRL       0x1052
>> -                    /* RESERVED 0x1053 - 0x1FFF */
>> +#define GSB_VCPU_SPR_DPDES      0x1053
>> +                    /* RESERVED 0x1054 - 0x1FFF */
>>   #define GSB_VCPU_SPR_CR         0x2000
>>   #define GSB_VCPU_SPR_PIDR       0x2001
>>   #define GSB_VCPU_SPR_DSISR      0x2002
>>
>> base-commit: aa54f5be44be786636a5d51cc1612ad208a24849
> 

