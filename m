Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070CDCFA775
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 14:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swiwg-0003fP-AD; Fri, 04 Oct 2024 10:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1swiwe-0003f5-D2
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 10:06:12 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1swiwc-0000cx-Is
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 10:06:12 -0400
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
 by m0409410.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id
 494Aef4j005990; Fri, 4 Oct 2024 15:05:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=cDzShXqZUIeOFDNiM7ALzvX12ZLi3q2gLs4ApwvZIh0=; b=LIBtfQ0LUOTp
 J3Ww/o3GeqBF3TuGMP7hLa7zQ7A4Czt60LC6hD+rKGubMq9NOw97O5MinH0mpxLY
 LJ/XFTwYS8mY59RetP3/3EWQEMYZ4hVn4B2aoP9WM4du57IuWlgEAOAge5oxCuCq
 esMkGGqkrx7Z9O6J2ypFXtyyzVTEZFsitFF4uIr6pk2Bp6cqpBjBlbzTxSd457YE
 iVGmjxXkwwBILqPU4PbppXryZPTw5FDDw1NdefCKvEXLUy2lB+PLfmcONXJfisvz
 a3FMU97jDjhaWK0Hc3fvnzlv0xm89UqA6ADdnmbt2a0w54USHa/CXifjB0TJVE4p
 I0CpI+9EIA==
Received: from prod-mail-ppoint3
 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be
 forged))
 by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 42205hg8yv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Oct 2024 15:05:40 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
 by prod-mail-ppoint3.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 494A3jQb017773; Fri, 4 Oct 2024 10:05:00 -0400
Received: from prod-mail-relay18.dfw02.corp.akamai.com ([172.27.165.172])
 by prod-mail-ppoint3.akamai.com (PPS) with ESMTP id 42206tnx2d-1;
 Fri, 04 Oct 2024 10:05:00 -0400
Received: from [100.64.0.1] (unknown [172.27.166.123])
 by prod-mail-relay18.dfw02.corp.akamai.com (Postfix) with ESMTP id 6A7AE18FD; 
 Fri,  4 Oct 2024 14:04:58 +0000 (GMT)
Message-ID: <6211c525-0b9b-4eba-ac3c-2ac796c8ec83@akamai.com>
Date: Fri, 4 Oct 2024 09:04:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
To: Peter Xu <peterx@redhat.com>
Cc: Sean Hefty <shefty@nvidia.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
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
References: <20240827165643-mutt-send-email-mst@kernel.org>
 <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com>
 <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com> <ZvQnbzV9SlXKlarV@x1n>
 <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com> <Zvrq7nSbiLfPQoIY@x1n>
 <DM6PR12MB4313D6BA256740DE1ACA29E9BD762@DM6PR12MB4313.namprd12.prod.outlook.com>
 <ZvsAV0MugV85HuZf@x1n> <c24fa344-0add-477d-8ed3-bf2e91550e0b@akamai.com>
 <Zv8P8uQmSowF8sGl@x1n>
Content-Language: en-US
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <Zv8P8uQmSowF8sGl@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_10,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410040098
X-Proofpoint-ORIG-GUID: EoC6yLGP9G2_5stWyddk4ZJIDLZR2bEN
X-Proofpoint-GUID: EoC6yLGP9G2_5stWyddk4ZJIDLZR2bEN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410040099
Received-SPF: pass client-ip=67.231.157.127; envelope-from=mgalaxy@akamai.com;
 helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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


On 10/3/24 16:43, Peter Xu wrote:
> !-------------------------------------------------------------------|
>    This Message Is From an External Sender
>    This message came from outside your organization.
> |-------------------------------------------------------------------!
>
> On Thu, Oct 03, 2024 at 04:26:27PM -0500, Michael Galaxy wrote:
>> What about the testing solution that I mentioned?
>>
>> Does that satisfy your concerns? Or is there still a gap here that needs to
>> be met?
> I think such testing framework would be helpful, especially if we can kick
> it off in CI when preparing pull requests, then we can make sure nothing
> will break RDMA easily.
>
> Meanwhile, we still need people committed to this and actively maintain it,
> who knows the rdma code well.
>
> Thanks,
>

OK, so comments from Yu Zhang and Gonglei? Can we work up a CI test 
along these lines that would ensure that future RDMA breakages are 
detected more easily?

What do you think?

- Michael


