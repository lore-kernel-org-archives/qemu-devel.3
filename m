Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEC6C021BC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 15:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmagK-0004NY-FJ; Mon, 24 Feb 2025 10:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@imap.linux.ibm.com>)
 id 1tmZDO-0007Id-A5; Mon, 24 Feb 2025 09:13:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@imap.linux.ibm.com>)
 id 1tmZDK-0003RN-Iq; Mon, 24 Feb 2025 09:13:43 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O7XIQZ006492;
 Mon, 24 Feb 2025 12:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Iu67g/
 gJXgfLeBgHNgD69fBZoBpn1Atzm/PcRhMJLaA=; b=f6fSwOWhyR5JZgGJpTdctz
 25vtYlwArKqUrfNcFQx0xsaEjHt5ActOsqv74j0/uM4xxyPqZIg7DPVbrtYfhIwp
 v/a5sT/hVpJRFLzS7UOzbKlRjUYlxskhi6vupkgcc03HUkrrBgZ4SEcEE6Doyj7w
 K1B/YWc2y+sS7n6g3thx/i8tySaR4lU3cxAbRW+YZzCN1gpyFlvkRrfRNpkPOTBT
 9EUYJEGvoz8WJjfPWy3bBk4eZlbck5qyPcMEBfQwB8U6ykNmrHac3n6ZtfytU4Vk
 TWEzTsmTW/qbfPABOMvFHu4fpxK6gdw/9RMgnZgfmWEYAZ4gOrNuG+bEAdisUT+A
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450mfp18c5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 12:29:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51OB1U3h012741;
 Mon, 24 Feb 2025 12:29:13 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yrwsfbbv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 12:29:13 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51OCTB7f58065380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2025 12:29:12 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C64A058056;
 Mon, 24 Feb 2025 12:29:11 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C6C458052;
 Mon, 24 Feb 2025 12:29:11 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Feb 2025 12:29:11 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 24 Feb 2025 13:29:11 +0100
From: shalini <shalini@imap.linux.ibm.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.ibm.com>, qemu-s390x mailing
 list <qemu-s390x@nongnu.org>, qemu-devel mailing list
 <qemu-devel@nongnu.org>, Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH v1 3/3] hw/s390x: support migration of CPI values
In-Reply-To: <1c844d5fefcbcfa5c969c4b6d5ad1ebf121861b2.camel@linux.ibm.com>
References: <20250115133106.3034445-1-shalini@linux.ibm.com>
 <20250115133106.3034445-3-shalini@linux.ibm.com>
 <1c844d5fefcbcfa5c969c4b6d5ad1ebf121861b2.camel@linux.ibm.com>
Message-ID: <92d79572c7781a9faf7b7a729fb68a18@imap.linux.ibm.com>
X-Sender: shalini@imap.linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pLINUEzP11X-czi8AJbyaUz8fdcQlubK
X-Proofpoint-GUID: pLINUEzP11X-czi8AJbyaUz8fdcQlubK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_05,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1034 bulkscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240091
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=shalini@imap.linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_NXDOMAIN=0.9,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NO_DNS_FOR_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 24 Feb 2025 10:47:37 -0500
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

On 2025-01-24 19:09, Nina Schoetterl-Glausch wrote:
> On Wed, 2025-01-15 at 14:31 +0100, Shalini Chellathurai Saroja wrote:
>> This commit saves the state of CPI values in the guest and
>> transfers this state during live migration of the guest.
> 
> IMO, using active voice and directly stating what is done is 
> preferable.
> 
> Something like:
> Register Control-Program Identifier data with the migration 
> infrastructure.
> 
> "This commit" doesn't really add anything.
> (Applies to other commits also)
> I also prefer verbosity when it comes to abbreviations.
> 
>> 
>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>> 
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 35fb523af9..8fe0c5c1cb 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -259,6 +259,20 @@ static void s390_create_sclpconsole(SCLPDevice 
>> *sclp,
>>      qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
>>  }
>> 
>> +static const VMStateDescription vmstate_cpi = {
>> +    .name = "s390_cpi",
>> +    .version_id = 0,
>> +    .minimum_version_id = 0,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_UINT8_ARRAY(system_type, Cpi, 8),
>> +        VMSTATE_UINT8_ARRAY(system_name, Cpi, 8),
>> +        VMSTATE_UINT64(system_level, Cpi),
>> +        VMSTATE_UINT8_ARRAY(sysplex_name, Cpi, 8),
>> +        VMSTATE_UINT64(timestamp, Cpi),
>> +        VMSTATE_END_OF_LIST()
> 
> I see, you need the Cpi type here.
> How about naming it ControlProgramId and renaming CPI
> to ControlProgramIdMsg or similar?
> 
> With that sorted out:
> 
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Hello Nina,

Thank you for your comments. I have implemented all the changes 
according to your feedback and I have sent the version 2 of my patch 
series.

-- 
Mit freundlichen Grüßen / Kind regards
Shalini Chellathurai Saroja
Software Developer
Linux on IBM Z & KVM Development
IBM Deutschland Research & Development GmbH
Dept 1419, Schoenaicher Str. 220, 71032 Boeblingen
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht 
Stuttgart, HRB 243294

