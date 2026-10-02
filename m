Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9037BCA5FE0
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 10:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCalj-0004HT-2M; Fri, 02 Oct 2026 06:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xCalS-0004Gb-51
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:45:27 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xCalN-0006MR-BH
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 06:45:17 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 692Aie52084081
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 2 Oct 2026 19:44:40 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=wkxoaWH/u01wDu1xCmZpGRu38HrqyeH8Lh13jNXJ8UU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1790937881; v=1;
 b=msZJ2I/O8MxN5OEjRzUy8DOxw8XqiHOtGTkPUFQVUzrFWwqsJ2dXsNLDtmu/ySW8
 AHKxPosv84iM2/daGfS5Vot9UcAwvUCM7YbQ1y8Rt/xV4gmPruycoJ5I7wy+l/+c
 1viUtxpMDoK9Db3Y6SYD0FtC/0oxcqW+s0J2D4YxzVtOeZW5Q4qwMPH2dlorAfJ1
 pIBVWt3i+6fHoSvuEru3fTJ/Sn3Az5IINRsc0Bsz1NKpN6M1/jD3BJequAhaDN13
 eHcmyc8SmFsYXu6EENjxf8wlj6PyuBV/euMwtJjfhvafMixIx3yQsRbyz3dfmsfI
 6gwEEOEKYdghO5YpaYYvgA==
Message-ID: <0b16690d-8d74-421f-a4d7-2089e49a1de7@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 2 Oct 2026 19:44:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 15/18] vhost: release ownership in vhost_dev_cleanup()
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: den@openvz.org, dwmw2@infradead.org, peterx@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, vsementsov@yandex-team.ru, farosas@suse.de,
 mark.kanda@oracle.com, dongli.zhang@oracle.com,
 maciej.szmigiero@oracle.com, philmd@oss.qualcomm.com,
 bchaney@akamai.com, clg@redhat.com
References: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
 <20261001-up-vsock-vhost-v5-v10-15-8c094843e98b@virtuozzo.com>
 <44332097-63da-40e8-9908-d0535b7bf8e8@rsg.ci.i.u-tokyo.ac.jp>
 <c8a4e48d-77ee-42a5-be7a-41fc8a7989a9@virtuozzo.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <c8a4e48d-77ee-42a5-be7a-41fc8a7989a9@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/10/02 19:27, Andrey Drobyshev wrote:
> On 10/1/26 2:04 PM, Akihiko Odaki wrote:
>> On 2026/10/01 17:25, Andrey Drobyshev wrote:
>>> vhost_dev_cleanup() closes the backend FD, but that doesn't release the
>>> device ownership taken with VHOST_SET_OWNER if the same file is open
>>> elsewhere.  That's the case on a CPR target: the source keeps the FD,
>>> so if the target fails after SET_OWNER, either inside vhost_dev_init()
>>> or later in its caller, the ownership stays with the target.  Once the
>>> source is resumed it can't take the device back, SET_OWNER fails with
>>> EBUSY.
>>>
>>> Issue VHOST_RESET_OWNER in vhost_dev_cleanup() as the common teardown
>>> for all those paths.  That's safe in any case: the kernel refuses it
>>> from a non-owner, and an owner is about to close the FD anyway.
>>
>> There is one minor counterexample: if a second netdev receives a
>> duplicate of an already-used vhost-net FD, initialization fails with
>> EBUSY, but cleanup then resets the first device.
>>
>> Regards,
>> Akihiko Odaki
> 
> Hmm, IIUC QEMU itself doesn't dup vhostfd backend FD provided to it by
> the management.  So we're talking about the case when the management
> (i.e. libvirt) dup'ed vhostfd and provided same backend FD for multiple
> different devices.  Correct?

Yes, that is the case I had in mind: management supplies two distinct 
FDs referring to the same open file. I agree that this is an invalid 
configuration. My concern is that rejecting the second device should not 
reset the first device's backend.

> 
> I didn't think of such config cause it's clearly illegal.  However I
> agree we should probably be more error-prone for such a case.  So if we
> want to have this covered, then I guess we'll have to add another flag
> to 'struct vhost_dev', indicating whether this particular vhost_dev
> instance currently holds the ownership.  That's pretty much what Stefano
> was suggesting in the previous thread.

A per-vhost_dev ownership flag sounds reasonable.

Regards,
Akihiko Odaki

