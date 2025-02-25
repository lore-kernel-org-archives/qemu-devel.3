Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F0EC021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 12:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmuET-0002Wz-3M; Tue, 25 Feb 2025 07:40:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tmuEL-0002Si-Ve; Tue, 25 Feb 2025 07:40:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tmuEI-0002yv-94; Tue, 25 Feb 2025 07:40:09 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P6Qm9b020937;
 Tue, 25 Feb 2025 12:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NdWYEf
 7QeUn6aZqHeJIFpeTifyAEciaEO7AUf06owQY=; b=joOdF/3TdYa4U8lveZRQhW
 BJF1bgO0e3d8LznHRl+JM82YkSRjVWujHWXjEqtx+JmILCHMNTS8BfoxAol01G4C
 qKe665O6H6YG0C9vzaxn0YPh28mv1z4HhkV/sgRH19LbqxPdY4pmmSnHq5QZyw8o
 0yQv9ubKeGpowUSTrVOc9diUQXaEMbZodGlFwofi8R6o9esQatS0PeAr5JTXuDBD
 WSVEaVLw5kOpvMV5k/vaD976G3MvdbTK3v05ZB+rwhO9cR1y+UtXXoRJA1QKXKRI
 7sWH3JbZExlquVncZ1jcezqKipeKKnhUpoVy4/DKvSZVbygV/+6JVoire3oUOHJg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4518k69rj5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Feb 2025 12:40:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51PAogbi026961;
 Tue, 25 Feb 2025 12:40:01 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdkcsfv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Feb 2025 12:40:01 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51PCe1xJ28770852
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Feb 2025 12:40:01 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 042EF58055;
 Tue, 25 Feb 2025 12:40:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A00905804B;
 Tue, 25 Feb 2025 12:40:00 +0000 (GMT)
Received: from [9.41.104.243] (unknown [9.41.104.243])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Feb 2025 12:40:00 +0000 (GMT)
Message-ID: <9cb188a8-2e13-49fe-9104-1e08b1c92964@linux.ibm.com>
Date: Tue, 25 Feb 2025 06:39:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vdpa: Fix endian bugs in shadow virtqueue
To: Michael Tokarev <mjt@tls.msk.ru>, eperezma@redhat.com
Cc: mst@redhat.com, sgarzare@redhat.com, mjrosato@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
References: <20250212164923.1971538-1-kshk@linux.ibm.com>
 <f2a0b9d6-490a-41ca-91ec-1b3b7dcf9eac@tls.msk.ru>
Content-Language: en-US
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <f2a0b9d6-490a-41ca-91ec-1b3b7dcf9eac@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5lMQkLW-46V8JpZGplNftQl8FOYNiCB9
X-Proofpoint-GUID: 5lMQkLW-46V8JpZGplNftQl8FOYNiCB9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 phishscore=0 spamscore=0 mlxlogscore=508 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502250088
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
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

On 2/25/2025 03:30, Michael Tokarev wrote:
> 12.02.2025 19:49, Konstantin Shkolnyy wrote:
>> VDPA didn't work on a big-endian machine due to missing/incorrect
>> CPU<->LE data format conversions.
>>
>> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> 
> This looks like a qemu-stable material.
> Please let me know if it is not.

It won't help without my other "[PATCH v2] vdpa: Allow vDPA to work on 
big-endian machine". With both patches, VDPA works on a big-endian machine.

