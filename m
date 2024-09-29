Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE49CF6497
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 20:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sv0W3-0000bA-1Y; Sun, 29 Sep 2024 16:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1sv0W0-0000af-RD
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 16:27:36 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1sv0Vy-0007HS-DE
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 16:27:36 -0400
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
 by m0409410.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id
 48TJcOOj031468; Sun, 29 Sep 2024 21:27:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=WLSaVWkT/8QIj9C+qWbo6D/jnJyng7ssSQNByIiYOv4=; b=LhQMI2zDf+/a
 tVsB3i1u4JAmD/Ae6W20tY32EZwIWpDe8jgRXERQa151Ag1mVcgyPdQbC5ljZbwi
 NVI19D339baK4OyuHYChLuaIgLwYXUmTWksrLEIHvek3+YOClUsuZZR4tZSXC+nk
 1nkBI25NaggNu5cA5kVoOSBQvoeNJUAYfqAs1Q7gUCyIjLW0vdvq6TwLdGn1S34k
 LM94NZkpwYJjHCPlbfTelW16gH9fD+QvyiEFTdxr0dxXRGTxkvETzBhbAXxQtbNT
 bnf4TIa0MjQ1icYmQBIgzkabbQy5AIF8ejW5Z/HsRTlQ8dCrLJiVu/RUSS45k6aw
 UnucRpyJnQ==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60]
 (may be forged))
 by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 41xvqfpafn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 29 Sep 2024 21:27:02 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
 by prod-mail-ppoint5.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 48THK3Cp012118; Sun, 29 Sep 2024 13:27:01 -0700
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
 by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 41xfs8m46j-1;
 Sun, 29 Sep 2024 13:27:01 -0700
Received: from [100.64.0.1] (prod-aoa-csiteclt14.bos01.corp.akamai.com
 [172.27.97.51])
 by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 4858534188;
 Sun, 29 Sep 2024 20:26:59 +0000 (GMT)
Message-ID: <46f8e54e-64a4-4d90-9b02-4fd699b54e41@akamai.com>
Date: Sun, 29 Sep 2024 15:26:58 -0500
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
Content-Language: en-US
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <20240929141323-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-29_19,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409290159
X-Proofpoint-ORIG-GUID: DrUfjuSp5PNXAajFwMcCv4Pidzts2pN3
X-Proofpoint-GUID: DrUfjuSp5PNXAajFwMcCv4Pidzts2pN3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=782 priorityscore=1501 clxscore=1015 adultscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409290160
Received-SPF: pass client-ip=67.231.157.127; envelope-from=mgalaxy@akamai.com;
 helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 9/29/24 13:14, Michael S. Tsirkin wrote:
> !-------------------------------------------------------------------|
>    This Message Is From an External Sender
>    This message came from outside your organization.
> |-------------------------------------------------------------------!
>
> On Sat, Sep 28, 2024 at 12:52:08PM -0500, Michael Galaxy wrote:
>> A bounce buffer defeats the entire purpose of using RDMA in these cases.
>> When using RDMA for very large transfers like this, the goal here is to map
>> the entire memory region at once and avoid all CPU interactions (except for
>> message management within libibverbs) so that the NIC is doing all of the
>> work.
>>
>> I'm sure rsocket has its place with much smaller transfer sizes, but this is
>> very different.
> To clarify, are you actively using rdma based migration in production? Stepping up
> to help maintain it?
>
Yes, both Huawei and IONOS have both been contributing here in this 
email thread.

They are both using it in production.

- Michael

