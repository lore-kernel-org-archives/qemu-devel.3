Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B3CC71135
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 21:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPSYB-0002Wj-Qm; Wed, 11 Jun 2025 16:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uPSY9-0002QC-LM
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 16:59:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uPSY6-0002ks-4k
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 16:59:56 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BIWb6t022979;
 Wed, 11 Jun 2025 20:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TKaFZ8
 sYr94pxWeI9o4rzqjbRpkw0R/bDHQqdOK3JEg=; b=KEu76//rSo7uEs9fWwBAjw
 PRRLbFprCtvVOZ5vmF3W68nbSWs97fpGqfbOaVmEGbe3Pcww3Lx+1D2WvZHNf6YZ
 GwsnqjX/fbVQ8h/h55k1jSBm2mXJAEfddUv1jBbfcM7UXzL2L5Nh8smBW2kDxlm/
 O/hMUiGJnMWwduhIlZILW76Erx0FuNqZ88O6+xiWhm74qIwGIxdHScF6xnffXb0Q
 5uzj0S0kdX1Oy62apUChPh6srALmzBpqiYzCuS+ifzQ+tiRNI/Un8Xc9ewec4OJB
 lhjH5kSq0ofaQ9jQPjHNVn//qSke0kF+g4Qp5o8wzuoktogrEE8GVnFHMeAX9kkA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474cxjf28v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Jun 2025 20:59:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55BHQR2u021895;
 Wed, 11 Jun 2025 20:59:49 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750501mku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Jun 2025 20:59:49 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55BKxn2228246780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Jun 2025 20:59:49 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2408D58059;
 Wed, 11 Jun 2025 20:59:49 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B550A5804B;
 Wed, 11 Jun 2025 20:59:48 +0000 (GMT)
Received: from [9.61.250.224] (unknown [9.61.250.224])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Jun 2025 20:59:48 +0000 (GMT)
Message-ID: <e2796793-632d-40c4-80ac-24ce305af7a2@linux.ibm.com>
Date: Wed, 11 Jun 2025 15:59:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] migration: Support fd-based socket address in
 cpr_transfer_input
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, peterx@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
References: <20250610223342.553744-1-jhkim@linux.ibm.com>
 <20250610223342.553744-2-jhkim@linux.ibm.com>
 <d9deb49b-dce4-4cbc-bc7d-53a781e20977@oracle.com>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <d9deb49b-dce4-4cbc-bc7d-53a781e20977@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WCPP7Dj4uNai1Efr2iXhNkmDzFFPKLYv
X-Proofpoint-GUID: WCPP7Dj4uNai1Efr2iXhNkmDzFFPKLYv
X-Authority-Analysis: v=2.4 cv=fZWty1QF c=1 sm=1 tr=0 ts=6849ee46 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8
 a=X2UCRlzkMfj9qmpsFYsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDE3NiBTYWx0ZWRfX6Zk50WNx7cct
 SGVzaSE04NLgGoE46c3xHshIDuaC7OuYAJz/Fh7GopEUHzO77L5jKMC1KZPnoBfacBHt2J2Mq9N
 shKAuRuTcLpVHTFtjsjpCjL+KcZhpQkd1PIk/MGeRMa3umhQ8pbvex3X2wi0Qniiplyp5SBFdKl
 rAnjC0+9lQfTuTtulqYW/9LJeVJjgdAV3p0C2K5qPbcfdHfSc3kbLOhopMP9yHgwoSoh2SEQZZ8
 N9ZvG+D5zdOjl5rQCRGhuSBN8R58ISTcUzE+ugX+K9jMykda/xD48rbjfxY1y6eUeNI6X7HuNBm
 f6ptDRjjg+iPHyx3ePFnjKzU8k2OxPuyV39qPl/DvZqDxh5goWcvfD6HufBxXU+0go5PRLJ5yCo
 1j63YE6fNAnU4CHL63euKESXS4USRIhs5D25mY/Q8OMigH4vfFrGpzbLsBQoa7NkdgLU1bHZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110176
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 6/11/2025 7:28 AM, Steven Sistare wrote:
> On 6/10/2025 6:33 PM, Jaehoon Kim wrote:
>> Extend cpr_transfer_input to handle SOCKET_ADDRESS_TYPE_FD alongside
>> SOCKET_ADDRESS_TYPE_UNIX. This change supports the use of pre-listened
>> socket file descriptors for cpr migration channels.
>>
>> This change is particularly useful in qtest environments, where the
>> socket may be created externally and passed via fd.
>>
>> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
>> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
>> ---
>>   migration/cpr-transfer.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
>> index e1f140359c..00371d17c3 100644
>> --- a/migration/cpr-transfer.c
>> +++ b/migration/cpr-transfer.c
>> @@ -46,7 +46,8 @@ QEMUFile *cpr_transfer_input(MigrationChannel 
>> *channel, Error **errp)
>>       MigrationAddress *addr = channel->addr;
>>         if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
>> -        addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
>> +        (addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX ||
>> +            addr->u.socket.type == SOCKET_ADDRESS_TYPE_FD)) {
>>             g_autoptr(QIOChannelSocket) sioc = NULL;
>>           SocketAddress *saddr = &addr->u.socket;
>> @@ -60,7 +61,9 @@ QEMUFile *cpr_transfer_input(MigrationChannel 
>> *channel, Error **errp)
>>             sioc = qio_net_listener_wait_client(listener);
>>           ioc = QIO_CHANNEL(sioc);
>> - trace_cpr_transfer_input(addr->u.socket.u.q_unix.path);
>> +        trace_cpr_transfer_input(
>> +            addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX ?
>> +            addr->u.socket.u.q_unix.path : addr->u.socket.u.fd.str);
>>           qio_channel_set_name(ioc, "cpr-in");
>>           return qemu_file_new_input(ioc);
>
>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
>
Thank you for your review.

I have addressed your comment in patch 1 by using `%d` directly in 
`g_strdup_printf`, as suggested.
Patch 2 remains unchanged, with only your Reviewed-by tag added.

I've just sent out v4 of the patch series.
Please let me know if you have any further comments.

-- Jaehoon Kim

