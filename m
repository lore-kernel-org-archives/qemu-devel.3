Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E92C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvvyc-0003Ir-8G; Mon, 17 Aug 2026 07:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wvvxv-00037Q-5v; Mon, 17 Aug 2026 07:57:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wvvxt-0008T1-51; Mon, 17 Aug 2026 07:57:18 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HBDIJw3685354; Mon, 17 Aug 2026 11:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Dhk7Oe
 LK3qeaRYOs+GdovMYbPCypMnpJwYSCFFacrk0=; b=lH/w1pgSefngQnZtHdmzyp
 F3Svj0OVe79RhyHFWsBs4U1rnzSASv+q7vUTi2OQwYXIFEGmfO/cH+Ocs40tLep9
 WaRME7GGWbg3YlvjLg+xzvj4qdiJ2VEErQMqLbDq8qxQsww0oVMQJ+o8wT5psaFb
 ChLF8meK+kczJhgnW3bgD6eZDH/iaeMJeiBSXaWTyA9lXMFTiCpqxmBo+ccFknJc
 jZriCE1cvyYtUe1NrNLR37RDIRm2dieoc5QE/T/p9OWB6pcIdBsQTuzsiJecO0rZ
 r1jf9wM4D8/tiSZUlbK5lBkgzsedphTMQgxWbxAoXoTTPbCXZ6PZw6hSzySN43RA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3j30g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 11:57:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HBuLOg010285;
 Mon, 17 Aug 2026 11:57:13 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32epx28x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 11:57:13 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HBvBap23396958
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 11:57:12 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D08DE58052;
 Mon, 17 Aug 2026 11:57:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4377F58045;
 Mon, 17 Aug 2026 11:57:09 +0000 (GMT)
Received: from [9.39.17.52] (unknown [9.39.17.52])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 11:57:08 +0000 (GMT)
Message-ID: <a759da8e-9ee6-4144-b593-c019310c9af3@linux.ibm.com>
Date: Mon, 17 Aug 2026 17:27:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Add lower bound check for watchdogNumber
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, aik@ozlabs.ru, amachhiw@linux.ibm.com
References: <20260817105854.437724-1-rathc@linux.ibm.com>
 <20260817165901.b9ff4441-8a-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20260817165901.b9ff4441-8a-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: aRcyeHzqdPNkulPw5AAg6TV_cH9VQqfV
X-Proofpoint-ORIG-GUID: 9IEEskGuOQBpDF3F0Z-nepfcmgRvMyIw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA4NyBTYWx0ZWRfX6J+IDk5cqHg1
 e1yjM+bpxrPQ3yJziM0OQ6pq2mO5WBlLDptLJZ3bT+yfS/ZbRuKl15EvOcmw6/F0cLl1C8UmQ/F
 L1VqGH3FwCWi7w8szV9wBNypcPP6AVc=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a82f71a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=dmMU9pk9wbTscCe_uMkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA4NyBTYWx0ZWRfXy47OnkEl2FPY
 8NvBcZzchRYpmQdzxW2on7/RFiYJzjXcrhC/MYxDcfhUyLzbk1+PDnfZNQayV6t+uj00jHvwoo7
 LCPiByCJVkac6Qoe+j4Jb3+Rt27lM9HNDdsH0+xOBjTR9hsY3zdwk1iwB5ph91lPF8YV6fqxnXv
 +6ZyqBa+VEOWO1qFK1i9EDZvWsoBPOYAwWcuHzkOVyT+OBKaoRa6S79J33JsUSqYNZg/Tewl28n
 2Cuj+KASEe65eB100hoNnOkp9Pm9l+veTgq8kjdfSTWyk3t8H65WMByhISEpjgVb2C7igb/3XYe
 qdODeqgKKWf7tLOXvIYorcXC3J6LNTvlzMBobfZ3HFnlpEXH6Sk3WxncL9Rczu3oPxEoh72CXLA
 NsOZ4dhQpmmyjGlGj10v3cmVvB1uZsXpSExCffcgP7OebOz6bzANHof8yN54XSEmwbxd0mVtzem
 MshDx+sKrNgHvxGEC3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170087
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 8/17/26 17:03, Amit Machhiwal wrote:
> On 2026/08/17 04:28 PM, Chinmay Rath wrote:
>> Add missing lower bound check for H_WATCHDOG H_CALL's watchdogNumber parameter
>> as per PAPR documentation ver 12.10.00 section 14.15.5 'H_WATCHDOG'.
>>
>> Closes : https://gitlab.com/qemu-project/qemu/-/work_items/3600
>>
> Nit: This newline is not needed.
>
>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>> ---
>>   hw/watchdog/spapr_watchdog.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/watchdog/spapr_watchdog.c b/hw/watchdog/spapr_watchdog.c
>> index 5b3f50de3a..5d7478e833 100644
>> --- a/hw/watchdog/spapr_watchdog.c
>> +++ b/hw/watchdog/spapr_watchdog.c
>> @@ -145,7 +145,7 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
>>   
>>       switch (operation) {
>>       case PSERIES_WDTF_OP_START:
>> -        if (watchdogNumber > ARRAY_SIZE(spapr->wds)) {
>> +        if (watchdogNumber < 1 || watchdogNumber > ARRAY_SIZE(spapr->wds)) {
>>               return H_P2;
>>           }
>>           if (timeoutInMs <= WDT_MIN_TIMEOUT) {
>> @@ -170,7 +170,8 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
>>       case PSERIES_WDTF_OP_STOP:
>>           if (watchdogNumber == PSERIES_WDT_STOP_ALL) {
>>               ret = watchdog_stop_all(spapr);
>> -        } else if (watchdogNumber <= ARRAY_SIZE(spapr->wds)) {
>> +        } else if (watchdogNumber > 0 &&
>> +                   watchdogNumber <= ARRAY_SIZE(spapr->wds)) {
>>               ret = watchdog_stop(watchdogNumber,
>>                                   &spapr->wds[watchdogNumber - 1]);
>>           } else {
> Nit: The bounds check in OP_STOP uses a positive-selection guard
> (watchdogNumber > 0 && watchdogNumber <= ARRAY_SIZE(...)) with the error
> in the trailing else, which reads differently from the negative guards
> used in OP_START and OP_QUERY_LPM. Consider flipping it to match:
>
>    } else if (watchdogNumber < 1 ||
>               watchdogNumber > ARRAY_SIZE(spapr->wds)) {
>        return H_P2;
>    } else {
>        ret = watchdog_stop(watchdogNumber,
>                            &spapr->wds[watchdogNumber - 1]);
>    }
>
>> @@ -184,7 +185,7 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
>>           trace_spapr_watchdog_query(args[0]);
>>           break;
>>       case PSERIES_WDTF_OP_QUERY_LPM:
>> -        if (watchdogNumber > ARRAY_SIZE(spapr->wds)) {
>> +        if (watchdogNumber < 1 || watchdogNumber > ARRAY_SIZE(spapr->wds)) {
>>               return H_P2;
>>           }
> Suggestion (follow-up patch): After this fix lands, it may be worth
> extracting a small helper to avoid the repeated bounds expression across
> OP_START, OP_STOP, and OP_QUERY_LPM:
>
>    static inline bool watchdog_number_valid(target_ulong n,
>                                             SpaprMachineState *spapr)
>    {
>        return n >= 1 && n <= ARRAY_SIZE(spapr->wds);
>    }
>
> The three call sites then become a uniform !watchdog_number_valid(...)
> or watchdog_number_valid(...) expression, the bounds are defined in
> exactly one place, and any future change to the valid range (e.g. a
> dynamic wds size) has a single point of update. Not a blocker for this
> patch — just a clean-up worth a separate patch.
Hey Amit,
Thanks for the suggestion. I actually did think of this. But, this 
common check would only be used by 2 operations : Start and LPM 
requirement. Stop operation's watchdogNumber validation works 
differently in the sense that unlike others, it can take a specific 
negative value, that is -1, which is used to indicate stopping all 
watchdogs. (This is also the reason why the bound check flow is 
different for stop operation as you have already pointed out above).

Due to this, I decided not to consolidate. However we can definitely 
pass the operation type to the validator function and check accordingly 
though.

Regards,
Chinmay
>
> Thanks,
> Amit

