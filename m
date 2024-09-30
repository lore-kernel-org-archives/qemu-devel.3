Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49032CE8342
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 13:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svGFt-0002ig-2L; Mon, 30 Sep 2024 09:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1svGFq-0002Tf-E8; Mon, 30 Sep 2024 09:15:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1svGFo-0000fD-K5; Mon, 30 Sep 2024 09:15:58 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UBjnFP010428;
 Mon, 30 Sep 2024 13:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=+
 iukJg8cPRE4foNMwWHwRkB+hiQprUTb2FpNAHux6jU=; b=okr3pIUL4vFcqDzKw
 3JyWqXaMJUtVgCjGYpK1j7V69bsKv9P5IA6/HMgz1o23LF+ua9pzGmu1UXdpHg/0
 6SRCWkUEBuyyjxPJzsRfavwcDiIsl59MNQcs6o7Rqxy3CSC/bYMcewWlVxdCtAil
 02CDpLmKR/5TEqXXBwkgZwXmvu+ZWzUVEsKIfD6NJ7iWac6wzqX35OPk1m75HG4n
 +dLhAl/tI3/7WaqDpIJF5DHKLqggWe0k+NW2VWg2/5AfXIPfJb4LX80ayf0E0Yvm
 u2CrKjPnvmhYGC4/L9+PsS398RkF9c1gUmhnkVDWWo0AyvN+89sM3QTALXeUfcH1
 bL79w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x87khqku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 13:15:55 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48UDFsL0006880;
 Mon, 30 Sep 2024 13:15:54 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x87khqkp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 13:15:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UC7XHw013030;
 Mon, 30 Sep 2024 13:15:54 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxbj6edg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 13:15:53 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48UDFrpN27984602
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 13:15:53 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBD8558057;
 Mon, 30 Sep 2024 13:15:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 953285805D;
 Mon, 30 Sep 2024 13:15:52 +0000 (GMT)
Received: from [9.61.73.98] (unknown [9.61.73.98])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 30 Sep 2024 13:15:52 +0000 (GMT)
Message-ID: <5bc51db1-196b-4e86-98e2-fff2d5dfdfef@linux.ibm.com>
Date: Mon, 30 Sep 2024 09:15:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] pc-bios/s390-ccw: Remove panics from Netboot IPL
 path
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
 <20240927005117.1679506-12-jrossi@linux.ibm.com>
 <8079dbae-eb38-482b-ae69-a6b1e2a83c15@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <8079dbae-eb38-482b-ae69-a6b1e2a83c15@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8KsdpVqUOsL1dxW_SuL7Kn7HKNao_om9
X-Proofpoint-ORIG-GUID: uZl5S8JDLDgamtGVhK2f74ZNsFXxbq1f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=826 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300095
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 9/30/24 5:39 AM, Thomas Huth wrote:
> On 27/09/2024 02.51, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Remove panic-on-error from Netboot specific functions so that error 
>> recovery
>> may be possible in the future.
>>
>> Functions that would previously panic now provide a return code.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>>
>> ---
> ...
>> index bc6ad8695f..013f94d932 100644
>> --- a/pc-bios/s390-ccw/netmain.c
>> +++ b/pc-bios/s390-ccw/netmain.c
>> @@ -464,7 +464,7 @@ static bool find_net_dev(Schib *schib, int dev_no)
>>       return false;
>>   }
>>   -static void virtio_setup(void)
>> +static int virtio_setup(void)
>>   {
>>       Schib schib;
>>       int ssid;
>> @@ -479,7 +479,10 @@ static void virtio_setup(void)
>>       enable_mss_facility();
>>         if (store_iplb(&iplb)) {
>> -        IPL_assert(iplb.pbt == S390_IPL_TYPE_CCW, "IPL_TYPE_CCW 
>> expected");
>> +        if (iplb.pbt != S390_IPL_TYPE_CCW) {
>> +            puts("IPL_TYPE_CCW expected");
>> +        }
>
> I think in this case, the IPL_assert() could maybe even stay: If we 
> end up here without the correct type in iplb.pbt, there was likely a 
> bug elsewhere in the earlier setup code already, or do you see a way 
> we could end up here with another type?
>
I agree that the panic can stay in this case. The only way that the PBT 
could
be wrong at this stage is if there were in error earlier when building the
IPLB, so it is appropriate to terminate the entire IPL in that case.

Jared Rossi


