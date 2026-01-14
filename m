Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0592D37E3C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 14:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg1yq-0002Ou-0a; Wed, 14 Jan 2026 09:36:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vg1ye-0002Ng-2V; Wed, 14 Jan 2026 09:36:05 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vg1yb-0008C8-Pj; Wed, 14 Jan 2026 09:36:03 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 58AD480744;
 Wed, 14 Jan 2026 17:35:56 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c88::1:7] (unknown [2a02:6bf:8080:c88::1:7])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id sZVeXG0ACiE0-70W21c4x; Wed, 14 Jan 2026 17:35:55 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768401355;
 bh=CsLibKXtdk/PJxFMJ86jAnlmPnM0VJjqUv8A8vQAnPI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=euUY1iHCZuLLLUwIWptzkniLjOpJrgZ6CvroB2Y6QXzvKBuqxm0iK+CTPY7G7baZr
 bMz8QTCJG8GcSme6YnqJIpHyyh/qYWQLur1XfUs826jRVpEVg3fcZOFafxwYI1GmVt
 lWQyEX99YZ8gKckFiCQoDFK1BvlI+pRM2b+8bA/U=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <832f4005-2e51-49fd-91e8-9f4cbe9f2adf@yandex-team.ru>
Date: Wed, 14 Jan 2026 17:35:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] support inflight migration
To: Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, mzamazal@redhat.com,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev, "yc-core@yandex-team.ru"
 <yc-core@yandex-team.ru>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260113095813.134810-1-dtalexundeer@yandex-team.ru>
 <20260113181242.GB528940@fedora> <aWaVVJh13ctiW9Ku@x1.local>
 <2af404d1-5e50-4caa-bee6-f8aab6a30a7e@yandex-team.ru>
 <aWeKn5A7-tWaWv0z@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aWeKn5A7-tWaWv0z@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 14.01.26 15:22, Peter Xu wrote:
> On Wed, Jan 14, 2026 at 09:19:10AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 13.01.26 21:56, Peter Xu wrote:
>>> On Tue, Jan 13, 2026 at 01:12:42PM -0500, Stefan Hajnoczi wrote:
>>>> On Tue, Jan 13, 2026 at 02:58:09PM +0500, Alexandr Moshkov wrote:
>>>>
>>>> Peter: Please review the migration aspects (especially the vmstates).
>>>> Thank you!
>>>
>>> Looks good from my side as long as it's based on VMSD, I appreciate that
>>> change from the old versions where it used to use qemufile APIs.
>>>
>>> The major question here is if this series depends on Vladimir's other
>>> series
>>
>> No, it does not. And if we can proceed with merging these series first, I'll
>> be happy to rebase on top of it.
> 
> I thought it requires migrate_local_vhost_user_blk() be present?  The
> inflight feature should not be enabled only if there's a hint that it's a
> local migration..

Oh right, I missed it.

We discussed that Alexandr will rebase the series on master without dependency
on my RFC.

> 
> I'll comment inline on the patch later.
> 
>>
>>> while there's still one patch that is not-for-merge:
>>>
>>> https://lore.kernel.org/all/20251016114104.1384675-24-vsementsov@yandex-team.ru/#t
>>>
>>> Does it automatically mark this series RFC as well?
>>>
>>> Personally speaking, a new migration cap would work all fine, we should
>>> have discussed it somewhere previously.  Said that, "local-vhost-user-blk"
>>> capability is likely not the right one.  IMHO it should be either "local"
>>> or "fd-passing" / "fd-passthrough" (or something generic) as the name.  If
>>> we are not sure if we will leverage more than "passing the FDs around", we
>>> can make it as simple as "local" as a new migration capability.
>>>
>>> Then migration's misc.h should export a function migrate_is_local() then
>>> device code can probe that in its own vmstate handling paths on save/load.
>>>
>>> A note to Vladimir: please remember to add a check to enforce UNIX socket
>>> when a formal patch 23 will be proposed some day, no matter what is the
>>> name of the capability.  It should fail qmp "migrate" or qmp
>>> "migrate_incoming" command if the main URI is not a unix socket.
>>>
>>
>> Thanks! I'll keep that in mind when prepare next version.
>>
>> -- 
>> Best regards,
>> Vladimir
>>
> 


-- 
Best regards,
Vladimir

