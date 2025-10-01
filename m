Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A60CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 18:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v41SU-0007JP-HY; Wed, 01 Oct 2025 14:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v41SP-0007I9-Hz; Wed, 01 Oct 2025 14:21:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v41S9-0004uz-WE; Wed, 01 Oct 2025 14:21:41 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591HZqJu016745;
 Wed, 1 Oct 2025 18:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pFim01
 x3tJbmkoWl3sNu+poVKhsCnv0yCcUMIKYb6b8=; b=B4hr6YFdjEgZtUhNlvPN2s
 ajjE+hDlCrdKz5FsC7nKSUqenMvZzAEggaTwuZr8QNtb4t+kFvxtrUdvdrWXZUSI
 PF0NNSk/CBj790P0CEsY0PJpjdXofI7U5XFAQShj/FwAPfUfgvOKkl53olvZGC26
 Zm79T+Gyi+pPpvNMXnnGZNAIwGofBDaWnxm2XRbfTmmcAKBajYjRyeR3FHzdKz1i
 ic+kbokZQSlAprEeNclGUp5LRjZ6tESqCvS5SCSPKaU0gwJK+nN3sxU2xrgNWWAs
 S1t3A+d/qErLNS9W3fuy/tG7U/sFQzaLUt7aAiv8o0+N+r5koUiAmpZxaGyyuTRA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bhrjh6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Oct 2025 18:21:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 591FWeEe020054;
 Wed, 1 Oct 2025 18:21:13 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49et8saf4w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Oct 2025 18:21:13 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 591ILD1623200388
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Oct 2025 18:21:13 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B04658061;
 Wed,  1 Oct 2025 18:21:13 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 388F558059;
 Wed,  1 Oct 2025 18:21:12 +0000 (GMT)
Received: from [9.61.247.182] (unknown [9.61.247.182])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Oct 2025 18:21:12 +0000 (GMT)
Message-ID: <d2dd6aaa-69b5-49ca-bcd1-36d43334b5fe@linux.ibm.com>
Date: Wed, 1 Oct 2025 11:21:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] vfio/pci: Add an error handler callback
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org, mjrosato@linux.ibm.com, thuth@redhat.com,
 alex.williamson@redhat.com
References: <20250925174852.1302-1-alifm@linux.ibm.com>
 <20250925174852.1302-3-alifm@linux.ibm.com> <87qzvtstd7.fsf@pond.sub.org>
 <90de0c70-9309-4fd0-a5d7-3bd9e7088a0e@linux.ibm.com>
 <87ms6gmo4j.fsf@pond.sub.org>
 <4207529b-a0a5-4360-8449-f4c20661e9e8@redhat.com>
 <0c221734-5faf-4829-bc17-21ec96a91fa5@linux.ibm.com>
 <87qzvo9tzk.fsf@pond.sub.org>
 <5ebeb8ec-395b-46ca-b6d4-b2c78ae0465f@linux.ibm.com>
 <87y0pv2pgp.fsf@pond.sub.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <87y0pv2pgp.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68dd711a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=uYONfy6L9GIQZX1KSxkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfX+frLqDhElNHc
 j2/8r3kCux0gCJh9QBnRlurpK/1fiBOnrW+269Bd9ZQ7kzYZ67To08sz6sbNbtz+n6M8DzBKEjB
 DMP2sohkK2KU30WJ81om4kglB7ZrrL2ltHXQ/0tfE0aqZNBQUUvXDEieT0sfue3TXUH8yuVU3p2
 De3rqYtH61MVNCCRLtMyJevKahF0qArymyNnLnpG9GYmaMf0HFan+OrHOBt8N+O5kgINxIsrw1t
 rKMSbkL1qOyKVjwP+gqTK/hNQScTjMSiDfbASifeSJZgHPF8WgauK2twG5EvPCvDO9/O6JXgS3J
 9n/YmXgy7guicRtUSAsCA4SN0WAPfv0z6wAXMdueqtYyisgt+Z3y7gQVVYJBksFomLPllriYaxc
 0VpubNspV8+emYmo1G5Zkrf1PnUWkQ==
X-Proofpoint-GUID: hTrUF22dImHJj5ud_RZ1_Zd9TzyD1s1y
X-Proofpoint-ORIG-GUID: hTrUF22dImHJj5ud_RZ1_Zd9TzyD1s1y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_05,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


On 9/30/2025 9:52 PM, Markus Armbruster wrote:
> Farhan Ali <alifm@linux.ibm.com> writes:
>
>> On 9/30/2025 2:20 AM, Markus Armbruster wrote:
>>> Farhan Ali <alifm@linux.ibm.com> writes:
>>>
>>>> On 9/27/2025 12:05 AM, Cédric Le Goater wrote:
>>>>> On 9/27/25 07:59, Markus Armbruster wrote:
> [...]
>
>>>>>> * Is the comment still accurate?
>>>> This comment would still apply for vfio-pci devices on other architectures except for s390x. We are trying to change this behavior for s390x.
>>> The comment is about things that should be done to handle the error.
>>> Would these things be done here, or in a suitable ->err_handler()?
>> Ideally in the err_handler(). And for s390x we try do what the comment mentions, which is inject the error into the guest through s390x architecture specific mechanism. I can remove the comment block.
> Well, if there's stuff left to do, a comment outlining it is desirable.
> If I understand you correctly, then the one we have is no longer
> accurate.  Could you update it, so it is?
>
> [...]
>
How about something like this?

We can retrieve the error details and decide what action needs to be 
taken in err_handler(). One of the actions could be to pass the error to 
the guest and have the guest driver recover from the error. This 
requires that PCIe capabilities be exposed to the guest. If 
err_handler() is not implemented/fails, we just terminate the guest to 
contain the error.

Thanks

Farhan


