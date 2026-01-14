Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A42D39000
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 17:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg55D-0004fP-Je; Wed, 14 Jan 2026 12:55:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vg55B-0004et-C6; Wed, 14 Jan 2026 12:55:01 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vg556-0000fM-Pd; Wed, 14 Jan 2026 12:55:00 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 9D572C02C8;
 Wed, 14 Jan 2026 20:54:52 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c88::1:7] (unknown [2a02:6bf:8080:c88::1:7])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id osYk8G0AtmI0-f6zcrlHI; Wed, 14 Jan 2026 20:54:52 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768413292;
 bh=l2hhGgOopvhCBxO4xytx/xL/4yJaI+IULU+1glcfZ+I=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=0GBc273VanSIBGrWdySnnDcGkuB0uJ+nw4VNN9LdQ8wLIi8Z2UlsLSqNNMz10yuN7
 rVaLqUqCS3KsASvZ5vpdkfzEn8uFokzksMrZAsxN6uvGtWERrtWo4t21DuzKr+cLpg
 8za8zEgtWeP/eZW1G7YAkxo4J05PbWBcjJ3oiKWA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d5c106d9-9e37-4f44-b0e9-4321d12f8bf1@yandex-team.ru>
Date: Wed, 14 Jan 2026 20:54:50 +0300
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
 <832f4005-2e51-49fd-91e8-9f4cbe9f2adf@yandex-team.ru>
 <aWezg94AB5a3F0EV@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aWezg94AB5a3F0EV@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14.01.26 18:17, Peter Xu wrote:
> On Wed, Jan 14, 2026 at 05:35:53PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 14.01.26 15:22, Peter Xu wrote:
>>> On Wed, Jan 14, 2026 at 09:19:10AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> On 13.01.26 21:56, Peter Xu wrote:
>>>>> On Tue, Jan 13, 2026 at 01:12:42PM -0500, Stefan Hajnoczi wrote:
>>>>>> On Tue, Jan 13, 2026 at 02:58:09PM +0500, Alexandr Moshkov wrote:
>>>>>>
>>>>>> Peter: Please review the migration aspects (especially the vmstates).
>>>>>> Thank you!
>>>>>
>>>>> Looks good from my side as long as it's based on VMSD, I appreciate that
>>>>> change from the old versions where it used to use qemufile APIs.
>>>>>
>>>>> The major question here is if this series depends on Vladimir's other
>>>>> series
>>>>
>>>> No, it does not. And if we can proceed with merging these series first, I'll
>>>> be happy to rebase on top of it.
>>>
>>> I thought it requires migrate_local_vhost_user_blk() be present?  The
>>> inflight feature should not be enabled only if there's a hint that it's a
>>> local migration..
>>
>> Oh right, I missed it.
>>
>> We discussed that Alexandr will rebase the series on master without dependency
>> on my RFC.
> 
> The problem is IIUC the new INFLIGHT feature bit will be declared as
> supported to vhost-user-block after applying this series.  Then if we start
> a remote migration (rather than local) it'll be automatically (and wrongly)
> enabled?
> 

No, not so.

We develop inflight-region migraiton (this series) exactly for remote migration,
not for local.

My series about backend transfer (fd-migration) will migrate inflight-region the
other way - by migrating its FD.

> AFAIU, the dependency makes sense, at least to the patch to introduce the
> "local" / ... capability?
> 


-- 
Best regards,
Vladimir

