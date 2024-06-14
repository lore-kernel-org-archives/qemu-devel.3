Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB04C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 08:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI28U-00052K-SZ; Fri, 14 Jun 2024 04:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1sI28T-000522-JU; Fri, 14 Jun 2024 04:18:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1sI28R-0001gZ-6e; Fri, 14 Jun 2024 04:18:13 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E7SlJ8016408;
 Fri, 14 Jun 2024 08:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 8Sg0pf5pTJ2YKs+wm058/6xhtn+NDnK0gBki1xY5NDI=; b=eYmz3T20NbiWKfQt
 2xDg+FDOLf1TilgB5668nJJfYK2Wv488c5nqhjdEf+nFdQGnUvlvNZGkWESQOyve
 /XprGWGVmegjSATi6J+DzJJlhb4tp484SFuA55/HhqyQAi4QfgiW8nKIYmdzj32h
 VDAzdZnEvXrjjnnD2iISgum3jh0N+UpebJ3xS6wVvVUfvEHMaHACmR04VGgWeob3
 /VkXBTrS8Z8BHicrGCm0YQ10zqQjIcUTpNCELc9s8/MPkJ7/k4RvsF4/M+RaKoYp
 H5Eo3PnFbqKGJwBd/rxaic4OnS+LobUKLeaRi5i/9JxWU6nRbCqNfuPwMc6F6qHV
 DGKQUg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrhgfr4u4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 08:18:08 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45E8I8HH002027;
 Fri, 14 Jun 2024 08:18:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrhgfr4u1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 08:18:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45E84IKW027267; Fri, 14 Jun 2024 08:18:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn211fuyq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 08:18:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45E8I14j38863136
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jun 2024 08:18:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 287BA2004D;
 Fri, 14 Jun 2024 08:18:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFC5520040;
 Fri, 14 Jun 2024 08:18:00 +0000 (GMT)
Received: from [9.152.224.222] (unknown [9.152.224.222])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jun 2024 08:18:00 +0000 (GMT)
Message-ID: <dd562095-f104-48d8-abe9-9b22b53b8743@linux.ibm.com>
Date: Fri, 14 Jun 2024 10:17:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: Add a CONFIG switch to disable legacy CPUs
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Ani Sinha <anisinha@redhat.com>
References: <20240613170702.523591-1-thuth@redhat.com>
 <3c138eeb-83df-4953-bdc9-3cf8343a0533@linux.ibm.com>
 <0b932efb-bd0c-435d-a75a-a6608097cb07@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <0b932efb-bd0c-435d-a75a-a6608097cb07@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hzQ8D0wE7aZYIovSxDT5v9qy-whkCSKf
X-Proofpoint-ORIG-GUID: ew6pqpHWoacRSKcLfbIY4HF2rH5WFvy4
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_15,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406140054
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



Am 14.06.24 um 09:15 schrieb Thomas Huth:
> On 14/06/2024 08.07, Christian Borntraeger wrote:
>>
>>
>> Am 13.06.24 um 19:07 schrieb Thomas Huth:
>>> Old CPU models are not officially supported anymore by IBM, and for
>>> downstream builds of QEMU, we would like to be able to disable these
>>> CPUs in the build. Thus add a CONFIG switch that can be used to
>>> disable these CPUs (and old machine types that use them by default).
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   If you're interested, the PDF that can be downloaded from
>>>   https://www.ibm.com/support/pages/ibm-mainframe-life-cycle-history
>>>   shows the supported CPUs in a nice diagram
>>
>> z13 is still supported so the patch needs to be fixed at least.
> 
> Oh, drat, I misread the diagram, indeed. 'should have looked at the table instead :-/
> 
>> Furthermore, z14 has the IBC/VAL cabability to behave like a z13,
>> same for z15. (we do support VAL to N-2)
> 
> Hmm, so if z13 is still supported, and also has the possibility to do N-2, I assume the z114/196 and z12 should still be considered as non-legacy, too?

Yes. z9 and older is no longer relevant (only for people that collect old HW) but the upstream kernel has an minimum requirement for z10 so maybe we still want to support that for testing purposes.
For upstream I prefer to keep the full list but I would be ok to hide those ancient things behind a config switch.


