Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3C3CD4F50
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 08:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJSkr-0007h1-Bb; Thu, 13 Nov 2025 03:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vJSkW-0007NA-Rf; Thu, 13 Nov 2025 03:32:19 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vJSkS-0002aw-Dq; Thu, 13 Nov 2025 03:32:11 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AD8W1Db083480
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 13 Nov 2025 17:32:01 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=1pjk0OfvnP7dalQAiYwb8wUhe54KUlFSf6vS27hXgdc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1763022721; v=1;
 b=S3d8rrOoqfGuwMJKZkfxydfBALvoDt075UUokjPQwWNYkOFrWvp+aNYa9414id62
 H0M/dRBSWfCFy2L2YNO3+b8mau/DhUVCp8zyFhC7kbqaUe+2Dt9VSPMSYkh7KkZy
 EVfTh2fgi7Ts0iwu8sgsKhzRze3EnxqFxNA75Ew9UNpJTWauRPi2drP0ajNuhSCQ
 OgpA8BWRuuD3Qye3//rncdSrads653vBlkdM81qAlGA3rnuKp5o/fEIPXwh6HeBj
 WM3cLtRlf65dvGBPwicZw3s37Edrmn9J7VOEala6O9Tut01mlfkkfps1eKhwhF4T
 VvdGJlfTIWybho8NDgSRHQ==
Message-ID: <69532e0f-3636-41d5-b86b-602c616c9f42@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 13 Nov 2025 17:32:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] qemu-img: Fix amend option parse error handling
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
References: <20251023-iotests-v1-0-fab143ca4c2f@rsg.ci.i.u-tokyo.ac.jp>
 <20251023-iotests-v1-1-fab143ca4c2f@rsg.ci.i.u-tokyo.ac.jp>
 <4599f828-0bf8-47b6-8639-340cb29508a3@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <4599f828-0bf8-47b6-8639-340cb29508a3@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/11/13 17:29, Michael Tokarev wrote:
> On 10/23/25 11:10, Akihiko Odaki wrote:
>> qemu_opts_del(opts) dereferences opts->list, which is the old amend_opts
>> pointer that can be dangling after executing
>> qemu_opts_append(amend_opts, bs->drv->create_opts) and cause
>> use-after-free.
>>
>> Fix the potential use-after-free by moving the qemu_opts_del() call
>> before the qemu_opts_append() call.
> 
> This feels like a qemu-stable material, is it not?

It is nice to have it backported.

Regards,
Akihiko Odaki

