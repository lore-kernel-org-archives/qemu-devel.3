Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A0CCF5389
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 13:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3bb2-0007jr-76; Wed, 23 Oct 2024 09:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1t3bas-0007iF-3z; Wed, 23 Oct 2024 09:40:11 -0400
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgalaxy@akamai.com>)
 id 1t3bao-0005do-IS; Wed, 23 Oct 2024 09:40:09 -0400
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
 by mx0a-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBZ2RA025467;
 Wed, 23 Oct 2024 14:39:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=FYxnhDIBLQ/qjhRWAhgoaLCw8A/R/HrVh/Bp/zfrNUY=; b=esR+YNFKHsg+
 8CNi1AxCVWhLTtrEsbLfBeK9GMQUizP8wMNreTCKFT/EXgnk7tNH7dhYISXvmUg0
 il97Ns+nXq6FGaI9F7ByHtND0LXVjKi+TVmRIPyhqthPnVDr9lwQnz2/3FDADafe
 FV7BGTuHtpPI0ZAUC/Jk3yb12H+2wZh/jprqGEda8kA3abQw+e5k2U2nQ2Wm59OO
 iZqXaLK/4GbfWXJXfagvA1z5T3Q+UwGNMUPWTwzyCMwaUSlmqGvTzsZdl7XRAVmo
 5WcMt2aehQO453ivVE7BBsgUw6e9MjqcliSHDS7VTee8Hjeg+cTU7kmH49/slHNZ
 jRAtHVKQYA==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61]
 (may be forged))
 by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 42em2ch79b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 14:39:54 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
 by prod-mail-ppoint6.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 49ND3GDJ000864; Wed, 23 Oct 2024 09:39:53 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
 by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 42en2tkj16-1;
 Wed, 23 Oct 2024 09:39:53 -0400
Received: from [100.64.0.1] (prod-aoa-csiteclt14.bos01.corp.akamai.com
 [172.27.97.51])
 by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 2C15865F29;
 Wed, 23 Oct 2024 13:39:52 +0000 (GMT)
Message-ID: <65ab672b-5cbb-461e-a3b8-bbd044d423b5@akamai.com>
Date: Wed, 23 Oct 2024 08:39:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] scsi: fetch unit attention when creating the request
To: Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org,
 Mike Christie <michael.christie@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 Fam Zheng <fam@euphon.net>, dharnett@akamai.com,
 "Hunt, Joshua" <johunt@akamai.com>
References: <20230712134352.118655-1-sgarzare@redhat.com>
 <20230712134352.118655-2-sgarzare@redhat.com>
 <6187274e-7223-4c13-b950-57137f4422d1@akamai.com>
 <CABgObfaP+PAAFkGjYmwxWqSdKDcd_mDrb7rC9=TfcTrvqAu1Pg@mail.gmail.com>
 <4b94aa38-e4b4-4322-9b1b-8484e3b78c32@akamai.com>
 <140b967a-0e88-46ba-b495-39a5bccd4aca@tls.msk.ru>
Content-Language: en-US
From: Michael Galaxy <mgalaxy@akamai.com>
In-Reply-To: <140b967a-0e88-46ba-b495-39a5bccd4aca@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_11,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230081
X-Proofpoint-ORIG-GUID: pP__GVRVul5qzsXS_6NtleiKaY21UT4g
X-Proofpoint-GUID: pP__GVRVul5qzsXS_6NtleiKaY21UT4g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0
 mlxlogscore=985 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230082
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=mgalaxy@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/11/24 14:44, Michael Tokarev wrote:
> !-------------------------------------------------------------------|
>  This Message Is From an External Sender
>  This message came from outside your organization.
> |-------------------------------------------------------------------!
>
> On 09.10.2024 21:00, Michael Galaxy wrote:
>> Thanks for your help.
>>
>> - Michael
>>
>> On 10/9/24 11:28, Paolo Bonzini wrote:
>>> Yes, it looks like an easy backport. Adding Michael Tokarev and 
>>> qemu-stable.
>>>
>>> Paolo
>>>
>>>
>>> On Wed, Oct 9, 2024 at 6:03 PM Michael Galaxy <mgalaxy@akamai.com> 
>>> wrote:
>>>> Hi All,
>>>>
>>>> We have stumbled upon this bug in our production systems on QEMU 
>>>> 7.2.x.
>>>> This is a pretty nasty bug because it has the effect of causing the 
>>>> root
>>>> filesystem in the guest to switch into read only mode if our block
>>>> storage products change attachments to running virtual machines.
>>>>
>>>> Could we kindly ask to pull this identical patch for 7.2.15?
>>>>
>>>> Last year, it just went to master and landed in 8.0.50. We're planning
>>>> to upgrade, but it will be quite some time before we get around to 
>>>> that,
>>>> and I suspect others are also running 7.2.x in production.
>
> I picked this one up for 7.2.next.  The change applies cleanly
> to 7.2, but I yet to try to even build-test it (I'm traveling
> currently).

Acknowledged. Thank you!

- Michael


