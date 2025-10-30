Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AC8CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 06:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEMBS-0005K9-Lv; Thu, 30 Oct 2025 02:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vEMBA-0005Ib-My; Thu, 30 Oct 2025 02:30:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vEMAz-0005Wp-P0; Thu, 30 Oct 2025 02:30:36 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TMTY78025859;
 Thu, 30 Oct 2025 06:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=D1ECpO
 SJ6h9rsrQOVZfWLVwqWZtSxXpOb3HNVp7D+lk=; b=F1nLyIvjb+xnZvoWjLyJDB
 bAFR3JtTz8sNPvGufzMC3fNibUSjq0R3IzNwQH7WCkKyoSc8lkgrk4qK5tVFALdG
 xA8Gs/ZOkWJYmNzjEMK9u5hhzauhb0YD0iKzBXgyBtzrlnzsjmYWwgRpdcDLxabt
 e8MvGWXVBISCra5grF2t10TuZAJ3tHH3ZWPaN00p6Z/d/RZ4V55rYR8fGzKO3dzf
 Gz+HUbu+p+vBZKMdoJya/v25Ixp62ayXhW5Y5UpgMKW/7dkA6ifksBpycOdbdmSx
 FX1oDYIapQ3wUV5kUaL1/KVogj9rsBWCVTfERqcHK5hG8mYAB3MFYxBu1MWZ4XCA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34acpwae-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 06:30:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U6GTXZ027440;
 Thu, 30 Oct 2025 06:30:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33w2q60t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 06:30:14 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59U6UD6U30999050
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Oct 2025 06:30:13 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1A505805C;
 Thu, 30 Oct 2025 06:30:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18CFE58051;
 Thu, 30 Oct 2025 06:30:12 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Oct 2025 06:30:11 +0000 (GMT)
Message-ID: <9a402fdd-17a0-47e2-a5a2-2b6b874c2f8d@linux.ibm.com>
Date: Thu, 30 Oct 2025 12:00:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pegasos2 patches for the freeze
To: Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <bee2d3b0-1565-2c63-93a0-4e84ced610f0@eik.bme.hu>
 <942911e5-0fab-4bf8-a41a-082de491d960@redhat.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <942911e5-0fab-4bf8-a41a-082de491d960@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XbuEDY55 c=1 sm=1 tr=0 ts=690305f7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pcZqCyVeAAAA:8
 a=B6KV-2SKrMV_BjcW9SUA:9 a=QEXdDO2ut3YA:10 a=SGy6VSG0Ue1xmPAwIFl9:22
 a=oH34dK2VZjykjzsv8OSz:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-ORIG-GUID: QpvLTvnWRPo0QlRaq7Qg2aPish9jDuSH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfXyHRqnhnMG7OG
 wHXd3V8z5UgoRoLuwofiGD6vQ8S/73l3gW6FwlMb87ZEEsEE/wH7tmkJNIOoVjCh37B4T5YQ47E
 nXq9HOa9MXUeVjvJk26MSlujlTD8CzEa63Rvx9t4Yr8YWgej69ZhTrbdhYNsXyUqIwKnXoz7XTD
 fEwpplcB++UJX2ZSkzA6LwiZtbbqddFRilgxRleDNiPiq1diyDAxozSZALa+OXDa5hj8ofTpWax
 lqWkwR8VYOps0BMlrHrQLGzdVWDajTddOAy6qBhWG7/Rqmpt8DloyVXlmj3nZS+A5e/laca+rBa
 CA/2G7kj1m2ShEadGQ2rAe69WXePOGaLUBE9MtV7WdCHQ9diGS8fIsRqI+06Lfvd5xyb1H/xnh7
 NhAZz/HVPfS995IIpReyBo76luQN7A==
X-Proofpoint-GUID: QpvLTvnWRPo0QlRaq7Qg2aPish9jDuSH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi BALATON, Paolo,

On 10/30/25 11:44, Paolo Bonzini wrote:
> On 10/29/25 14:55, BALATON Zoltan wrote:
>> To help tracking patches to be merged here's the list I have on my 
>> pegasos2 branch that I hope can be merged for the next release:
>>
>> f5c71e99b5 (HEAD -> pegasos2) hw/pci-host/articia: Add variable for 
>> common type cast
>> 159f8cec9c hw/ppc/pegasos: Update documentation for pegasos1
>> 8835cce4ff hw/ppc/pegasos2: Rename to pegasos
>> 356511cf3d hw/pci-host/articia: Map PCI memory windows in realize
>> 7649f4c174 hw/ppc/pegasos2: Add /chosen/stdin node with VOF
>> b1b9b6668d (master) hw/ppc/sam460ex: Update u-boot-sam460ex
>> 41312cc017 ati-vga: Fix framebuffer mapping by using hardware-correct 
>> aperture sizes
>> 2d1444017d ati-vga: Separate default control bit for source
>>
>> I hope somebody can take care of the ati-vga patches so you don't have 
>> to care about them, you already have the sam460ex u-boot update then 
>> only need the "Some more pegasos patches" series and the last articia 
>> patch I've sent separately based on the series. No review yet on the 
>> 7649f4c174 hw/ppc/pegasos2: Add /chosen/stdin node with VOF patch and 
>> not sure if we can keep Philippe's R-b on 356511cf3d hw/pci-host/ 
>> articia: Map PCI memory windows in realize based on previous 
>> discussion but other's were R-b by Philippe already. I hope these can 
>> be in your last pull request for the freeze.
>>
>> Congrats for becoming ppc maintainer by default :-) but thank you very 
>> much for helping out with this.

Thanks

> 
> Not sure if this was referring to Harsh; if not, please prepare a branch 
> on gitlab or github and I'll pull from there (no need to send a formal 
> pull request to me with git-request-pull, just reply here).

Paolo,

There are some disagreements on this patch:
https://lore.kernel.org/qemu-devel/2dc5e0d6-2b98-49d6-99ef-8969d58a02ed@ilande.co.uk/

I am planning to include other reviewed patches in my next pull req though.


> 
> Paolo
> 

