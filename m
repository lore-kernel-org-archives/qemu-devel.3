Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2965C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 04:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvU0o-0000MP-Qw; Fri, 21 Mar 2025 00:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tvU0m-0000Lu-5l
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 00:29:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1tvU0k-0005iP-CP
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 00:29:35 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L070Nw025394;
 Fri, 21 Mar 2025 04:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=v1nr//
 pF3MFaF/UYfB4A9Mq/IZWVzHrFSXsTlgLHwVI=; b=CHIG3Vpu6ovFWzzb8C1dP3
 cFyj/wFZTxSz74oBWRLFHBhTRpOgi/vrNSuOab842IQ9g7xcxuLn9W1xFZuyiSs/
 6B+zM6S/9vdRSJGWkG/BvmnLS3fBmVYIplYpJcfDqua31jdZNl5azdBHt4Ia3Aa5
 4RuqItx6m/6qZfkypJXgm9D43V9EPdc6Uyd33c82eigYBUQ6t4FnGuTiONrJMM2s
 S5r6o+YY6o6xllC7LRQAlDMS6xpjFrSPaCoWWLtR+WRt1/XU7OHGB6LYwwPgCC9q
 +NGbvWu4hrF+JmwFm/M+HWk+1ZgrMbrvAPDZdbpU8zuQMGUq8fYpQ8gjlXEg7eCQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gmepbue0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Mar 2025 04:29:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52L2lmUs012351;
 Fri, 21 Mar 2025 04:29:30 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dmvpbq3x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Mar 2025 04:29:30 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52L4TTjj54788376
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Mar 2025 04:29:30 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A65315804E;
 Fri, 21 Mar 2025 04:29:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F03A5803F;
 Fri, 21 Mar 2025 04:29:29 +0000 (GMT)
Received: from [9.61.250.157] (unknown [9.61.250.157])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 21 Mar 2025 04:29:29 +0000 (GMT)
Message-ID: <816c6468-9fb4-44d3-9bce-ecdc04f118be@linux.ibm.com>
Date: Thu, 20 Mar 2025 23:29:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: VDPA MAC address problem
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, dtatulea@nvidia.com, Cindy Lu <lulu@redhat.com>,
 eperezma <eperezma@redhat.com>
References: <553b11b5-4cc4-4e59-9211-74c8cce51a96@linux.ibm.com>
 <CACGkMEvrOx=jN9iULQ_svJdqKt3guJuZNEOan9-eeLirLk7_=g@mail.gmail.com>
 <fa821773-225f-4e2b-8642-72d269802d96@linux.ibm.com>
 <CACGkMEsOx5bdpny3y9BfJsefNKbiXk2bG3+TPKtFyr7CWhz1FA@mail.gmail.com>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <CACGkMEsOx5bdpny3y9BfJsefNKbiXk2bG3+TPKtFyr7CWhz1FA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LkyDR9V76aUByQ4SJjaWweIpqDL-EZU1
X-Proofpoint-ORIG-GUID: LkyDR9V76aUByQ4SJjaWweIpqDL-EZU1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_01,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=789 clxscore=1015
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503210029
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 3/20/2025 20:22, Jason Wang wrote:
> On Fri, Mar 21, 2025 at 12:45 AM Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
>>
>> On 3/19/2025 19:58, Jason Wang wrote:
>>> On Thu, Mar 20, 2025 at 12:34 AM Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
>>>> Upon reading this forum, I see that VHOST_VDPA_SET_CONFIG is
>>>> “deprecated”, and so VIRTIO_NET_CTRL_MAC_ADDR_SET must be the right
>>>> method, but it’s apparently called too late.
>>>
>>> VHOST_VDPA_SET_CONFIG requires the vDPA parent support which is not
>>> necessarily there.
>>
>> The mlx5 driver doesn't do anything for VHOST_VDPA_SET_CONFIG. Intel's
>> driver, however, apparently stores the configuration. So, it appears,
>> Intel will avoid the problem... Perhaps mlx5 could do the same so that
>> QEMU can set the address before it starts the VM (QEMU doesn't have to
>> later let the VM change the config).
> 
> The problem is that config space is not allowed to be written, that is
> why mlx5 doesn't implement the write method.
> 
>> Conceptually, setting the address
>> by QEMU cmdline doesn't look different from setting it by "vdpa dev add".
> 
> It's kind of different.
> 
> E.g the device may not even have VIRTIO_NET_F_MAC feature etc.

I'm not sure I understand... This is the MAC address returned by 
VHOST_VDPA_GET_CONFIG. If mlx5 allows it to be set by "vdpa dev add", 
shouldn't it also allow it to be set by VHOST_VDPA_SET_CONFIG called by 
virtio_net_device_realize(), before the VM exists.

When VM starts running, it queries this MAC address and QEMU fetches it 
by VHOST_VDPA_GET_CONFIG. But, because VHOST_VDPA_SET_CONFIG hasn't 
stored it, it fetches a wrong stale address.


