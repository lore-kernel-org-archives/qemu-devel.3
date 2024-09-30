Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BF3CE835C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 15:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svHtQ-0006Dq-Vo; Mon, 30 Sep 2024 11:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1svHtN-0006D5-Nn
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 11:00:54 -0400
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1svHtL-0002rm-0z
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 11:00:53 -0400
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
 by m0050095.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id
 48UBbZcD023891; Mon, 30 Sep 2024 16:00:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=UPnBmrmpwqmpGEU3WAric6506SD0FdwqXwgM7diaTHU=; b=GHs+wPwov+cR
 Gq1jdZuzofGoLDVHxohdGq5vagrPqsgT+bX/+JER0DZ8kpaHD5VmH9COY/uFwY4c
 TQoW134TK9IU55eoF5rZ5juTloZJKuJOuwrFq/ZPHIgm4CtpPh6OIzj9phlIAv5b
 esVO25w0pJ7RdATatUgZDfb/YW40k17D417hFpTHzJSNb7v38jGHRVmTefo+zR+k
 8hip9NkTk19yToKnP2cmsjmXEG/qo4AeVPk7JYP/+Q47Ht+Pf6ReYbSztMe7eKQq
 NcUZxHB4HKUvujIwQ7JTVmNGINXiXcBQbSJgOtOII10Rs0yveRNuQq3fKxNL7H0p
 iqKRPUys1A==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18]
 (may be forged))
 by m0050095.ppops.net-00190b01. (PPS) with ESMTPS id 41x9b9an9x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 16:00:23 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 48UENqbF011154; Mon, 30 Sep 2024 11:00:21 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 41xd4wqfdk-1;
 Mon, 30 Sep 2024 11:00:21 -0400
Received: from [100.64.0.1] (prod-aoa-csiteclt14.bos01.corp.akamai.com
 [172.27.97.51])
 by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 06E3E33B25;
 Mon, 30 Sep 2024 15:00:18 +0000 (GMT)
Message-ID: <ce4dc43a-69d7-4623-abc4-b40b681595b2@akamai.com>
Date: Mon, 30 Sep 2024 10:00:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sean Hefty <shefty@nvidia.com>, Peter Xu <peterx@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yu.zhang@ionos.com" <yu.zhang@ionos.com>,
 "elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>,
 zhengchuan <zhengchuan@huawei.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Xiexiangyou <xiexiangyou@huawei.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "lixiao (H)" <lixiao91@huawei.com>,
 "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
 Wangjialin <wangjialin23@huawei.com>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zs4z7tKWif6K4EbT@x1n> <20240827165643-mutt-send-email-mst@kernel.org>
 <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com>
 <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com> <ZvQnbzV9SlXKlarV@x1n>
 <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com>
 <20240929141323-mutt-send-email-mst@kernel.org>
 <46f8e54e-64a4-4d90-9b02-4fd699b54e41@akamai.com>
 <20240929182538-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <20240929182538-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_14,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409300107
X-Proofpoint-ORIG-GUID: i_eQ30-H7HGwGlZJcK3o1G7MT3C5iZUG
X-Proofpoint-GUID: i_eQ30-H7HGwGlZJcK3o1G7MT3C5iZUG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=857
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300108
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=mgalaxy@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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


On 9/29/24 17:26, Michael S. Tsirkin wrote:
> !-------------------------------------------------------------------|
>    This Message Is From an External Sender
>    This message came from outside your organization.
> |-------------------------------------------------------------------!
>
> On Sun, Sep 29, 2024 at 03:26:58PM -0500, Michael Galaxy wrote:
>> On 9/29/24 13:14, Michael S. Tsirkin wrote:
>>> !-------------------------------------------------------------------|
>>>     This Message Is From an External Sender
>>>     This message came from outside your organization.
>>> |-------------------------------------------------------------------!
>>>
>>> On Sat, Sep 28, 2024 at 12:52:08PM -0500, Michael Galaxy wrote:
>>>> A bounce buffer defeats the entire purpose of using RDMA in these cases.
>>>> When using RDMA for very large transfers like this, the goal here is to map
>>>> the entire memory region at once and avoid all CPU interactions (except for
>>>> message management within libibverbs) so that the NIC is doing all of the
>>>> work.
>>>>
>>>> I'm sure rsocket has its place with much smaller transfer sizes, but this is
>>>> very different.
>>> To clarify, are you actively using rdma based migration in production? Stepping up
>>> to help maintain it?
>>>
>> Yes, both Huawei and IONOS have both been contributing here in this email
>> thread.
>>
>> They are both using it in production.
>>
>> - Michael
> Well, any plans to work on it? for example, postcopy does not really
> do zero copy last time I checked, there's also a long TODO list.
>
I apologize, I'm not following the question here. Isn't that what this 
thread is about?

So, some background is missing here, perhaps: A few months ago, there 
was a proposal
to remove native RDMA support from live migration due to concerns about 
lack of testability.
Both IONOS and Huawei have stepped up that they are using it and are 
engaging with the
community here. I also proposed transferring over maintainership to them 
as well.  (I  no longer
have any of this hardware, so I cannot provide testing support anymore).

During that time, rsocket was proposed as an alternative, but as I have 
laid out above, I believe
it cannot work for technical reasons.

I also asked earlier in the thread if we can cover the community's 
testing concerns using softroce,
so that an integration test can be made to work (presumably through 
avocado or something similar).

Does that history make sense?

- Michael


