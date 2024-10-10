Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63114CEDDA9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 01:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syi7o-0002uX-Gy; Wed, 09 Oct 2024 21:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1syi7i-0002tx-9n; Wed, 09 Oct 2024 21:37:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1syi7f-0007Sq-C0; Wed, 09 Oct 2024 21:37:50 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A0SxYb020861;
 Thu, 10 Oct 2024 01:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=L
 LNLy2uLCuMxqMyph6Aw/FDsKbN/RDUSbg4YvEELzm0=; b=BQq6INvxyvV0Tgv3E
 2LRJewctcHnXsl7vDlxOOn5/9vcFCusnas2OpZT9y9A/SosivTKdYTN2V/lpsGeP
 SmlKSq4yanF7dLuJIGbBtxVw80dR6zMQjqlB6vC6/hBnOBR0GpiGLn1Cbt0mBeNT
 2R/+Z26yu4TeLB0axUae5RnNn3HXvq1FdE/powGZIoj5H8cdRvPT4xYZbWJoyzz+
 YT13mz5J70bZOBslpjiLwTcIq9nONrWWqMvzQ6SSHNPs1NQb97C79jYpQP5Hmu2x
 RWwy+BVSSJEHVNDa5g8ADzVhWS5pp9t/52RXDarXavn81c80tFrp+xjexWgNPv6X
 QK/dQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4264dv86w7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 01:37:31 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49A1bUXo019730;
 Thu, 10 Oct 2024 01:37:30 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4264dv86w5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 01:37:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 499N98L4010715;
 Thu, 10 Oct 2024 01:37:30 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 423j0jmy1j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 01:37:29 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49A1bTDI13894188
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 01:37:29 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2DE858056;
 Thu, 10 Oct 2024 01:37:28 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CC7858052;
 Thu, 10 Oct 2024 01:37:28 +0000 (GMT)
Received: from [9.61.177.235] (unknown [9.61.177.235])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 10 Oct 2024 01:37:28 +0000 (GMT)
Message-ID: <a3717113-4961-4dc2-935f-96399ec904e2@linux.ibm.com>
Date: Wed, 9 Oct 2024 21:37:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/19] pc-bios/s390-ccw: Remove panics from ECKD IPL
 path
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20241008011552.2645520-1-jrossi@linux.ibm.com>
 <20241008011552.2645520-9-jrossi@linux.ibm.com>
 <704bffd2-09b7-4ce0-8fb4-d6f33145bcca@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <704bffd2-09b7-4ce0-8fb4-d6f33145bcca@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C5dUH9g9taeksSmzW3vRuo8-Nhxu3fbd
X-Proofpoint-ORIG-GUID: KFWoNOXP2V1A5BUIwMoZWozAQXD1JgvW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_22,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410100005
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



On 10/9/24 6:53 AM, Thomas Huth wrote:
> On 08/10/2024 03.15, jrossi@linux.ibm.com wrote:
>> [snip...]
>
> load_eckd_segments() returns a value of type block_number_t which is 
> an unsigned type, so returning a negative error value will likely not 
> work as expected...
>
> ...
>> @@ -317,21 +352,28 @@ static void run_eckd_boot_script(block_number_t 
>> bmt_block_nr,
>>             do {
>>               block_nr = load_eckd_segments(block_nr, ldipl, &address);
>> -        } while (block_nr != -1);
>> +        } while (block_nr >= 0);
> [snip...]

There already exists a special block number defined in bootmap.h, 
NULL_BLOCK_NR 0xffffffffffffffffULL. Therefore I would propose simply 
adding another as ERROR_BLOCK_NR 0xfffffffffffffffeULL.

ERROR_BLOCK_NR would replace the negative error codes and NULL_BLOCK_NR 
would represent expected end of chunk.  Does this seem reasonable?

     Jared


