Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866C9C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 17:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7evj-0005az-Hu; Thu, 16 May 2024 13:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1s7evd-0005Zp-2y; Thu, 16 May 2024 13:30:06 -0400
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1s7evZ-0001oW-4Y; Thu, 16 May 2024 13:30:04 -0400
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
 by mx0a-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44GExpQx017821;
 Thu, 16 May 2024 18:29:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 jan2016.eng; bh=zVJ46asrz6a+R2H0/Ty31SYq7ESChLhYfCkGpV8bJuo=; b=
 lQM0dOodAF9Ydw6mNTEtKNJUsSgEVL9Ja+MooVSfaVTmOOUyu22I1VliAcJoT3Lv
 IPtPjLRngpGlOSZPl5ATia4unNMvutcMapAZEm9Voh4d2EeVbE3kjFReaFEJ2LGj
 nf+VNIdEixRGCYcr3mFnk7CfenqhKcssBDkeDq1aUDOsDOrNzu7Kx8xsmqcd+mve
 SPCKGaykBpsFmDmBUW+Nc1q0K1kggyPAQqzJfCI9n2lxOd2r0eU0GP4DhLcAi62E
 zw16q4cGaGfNYb9arqJ4eNSTYpnBH4WDc6auV2YNsv4r9F/vAfw1m0q1zhDD5ux6
 ZQ9xCx4PpR/X2QLmx4AN8w==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19]
 (may be forged))
 by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 3y1yxggee6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 18:29:25 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
 by prod-mail-ppoint2.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id
 44GFWUmN013723; Thu, 16 May 2024 13:29:23 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
 by prod-mail-ppoint2.akamai.com (PPS) with ESMTP id 3y3s6y1x0e-1;
 Thu, 16 May 2024 13:29:23 -0400
Received: from [100.64.0.1] (prod-aoa-csiteclt14.bos01.corp.akamai.com
 [172.27.97.51])
 by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 3E9A164F17;
 Thu, 16 May 2024 17:29:20 +0000 (GMT)
Message-ID: <04769507-ac37-495d-a797-e05084d73e64@akamai.com>
Date: Thu, 16 May 2024 12:29:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: Yu Zhang <yu.zhang@ionos.com>, Peter Xu <peterx@redhat.com>,
 Jinpu Wang <jinpu.wang@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>
Cc: Zheng Chuan <zhengchuan@huawei.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pannengyuan <pannengyuan@huawei.com>,
 Xiexiangyou <xiexiangyou@huawei.com>
References: <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com>
 <Zi-1OvxA5MIHjklU@x1n> <877cgfe2yw.fsf@pond.sub.org>
 <ZjClMb-6MddpvHqQ@redhat.com> <ZjJgQcPQ29HJsTpY@x1n>
 <7e902e4e576a4e199e36d28f99bd55e5@huawei.com> <Zjj0xa-3KrFHTK0S@x1n>
 <addaa8d094904315a466533763689ead@huawei.com> <ZjpWmG2aUJLkYxJm@x1n>
 <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com> <ZjzaIAMgUHV8zdNz@x1n>
 <CAHEcVy48Mcup3d3FgYh_oPtV-M9CZBVr4G_9jyg2K+8Esi0WGA@mail.gmail.com>
Content-Language: en-US
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <CAHEcVy48Mcup3d3FgYh_oPtV-M9CZBVr4G_9jyg2K+8Esi0WGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405160124
X-Proofpoint-GUID: zWz8T2n34b6woGeWeYF5Ed1y28k47pN2
X-Proofpoint-ORIG-GUID: zWz8T2n34b6woGeWeYF5Ed1y28k47pN2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 adultscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405160125
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=mgalaxy@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

These are very compelling results, no?

(40gbps cards, right? Are the cards active/active? or active/standby?)

- Michael

On 5/14/24 10:19, Yu Zhang wrote:
> Hello Peter and all,
>
> I did a comparison of the VM live-migration speeds between RDMA and
> TCP/IP on our servers
> and plotted the results to get an initial impression. Unfortunately,
> the Ethernet NICs are not the
> recent ones, therefore, it may not make much sense. I can do it on
> servers with more recent Ethernet
> NICs and keep you updated.
>
> It seems that the benefits of RDMA becomes obviously when the VM has
> large memory and is
> running memory-intensive workload.
>
> Best regards,
> Yu Zhang @ IONOS Cloud
>
> On Thu, May 9, 2024 at 4:14 PM Peter Xu <peterx@redhat.com> wrote:
>> On Thu, May 09, 2024 at 04:58:34PM +0800, Zheng Chuan via wrote:
>>> That's a good news to see the socket abstraction for RDMA!
>>> When I was developed the series above, the most pain is the RDMA migration has no QIOChannel abstraction and i need to take a 'fake channel'
>>> for it which is awkward in code implementation.
>>> So, as far as I know, we can do this by
>>> i. the first thing is that we need to evaluate the rsocket is good enough to satisfy our QIOChannel fundamental abstraction
>>> ii. if it works right, then we will continue to see if it can give us opportunity to hide the detail of rdma protocol
>>>      into rsocket by remove most of code in rdma.c and also some hack in migration main process.
>>> iii. implement the advanced features like multi-fd and multi-uri for rdma migration.
>>>
>>> Since I am not familiar with rsocket, I need some times to look at it and do some quick verify with rdma migration based on rsocket.
>>> But, yes, I am willing to involved in this refactor work and to see if we can make this migration feature more better:）
>> Based on what we have now, it looks like we'd better halt the deprecation
>> process a bit, so I think we shouldn't need to rush it at least in 9.1
>> then, and we'll need to see how it goes on the refactoring.
>>
>> It'll be perfect if rsocket works, otherwise supporting multifd with little
>> overhead / exported APIs would also be a good thing in general with
>> whatever approach.  And obviously all based on the facts that we can get
>> resources from companies to support this feature first.
>>
>> Note that so far nobody yet compared with rdma v.s. nic perf, so I hope if
>> any of us can provide some test results please do so.  Many people are
>> saying RDMA is better, but I yet didn't see any numbers comparing it with
>> modern TCP networks.  I don't want to have old impressions floating around
>> even if things might have changed..  When we have consolidated results, we
>> should share them out and also reflect that in QEMU's migration docs when a
>> rdma document page is ready.
>>
>> Chuan, please check the whole thread discussion, it may help to understand
>> what we are looking for on rdma migrations [1].  Meanwhile please feel free
>> to sync with Jinpu's team and see how to move forward with such a project.
>>
>> [1] https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/87frwatp7n.fsf@suse.de/__;!!GjvTz_vk!QnXDo1zSlYecz7JvJky4SOQ9I8V5MoGHbINdAQAzMJQ_yYg_8_BSUXz9kjvbSgFefhG0wi1j38KaC3g$
>>
>> Thanks,
>>
>> --
>> Peter Xu
>>

