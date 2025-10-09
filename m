Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00737CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 20:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6x3P-0002MK-6t; Thu, 09 Oct 2025 16:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v6x3N-0002LW-AV; Thu, 09 Oct 2025 16:15:57 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v6x3K-00079t-7p; Thu, 09 Oct 2025 16:15:57 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id CFEA5C04D7;
 Thu, 09 Oct 2025 23:15:47 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:162::1:3a] (unknown
 [2a02:6bf:8080:162::1:3a])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id kFRfq91FoSw0-AXm4rbDU; Thu, 09 Oct 2025 23:15:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760040947;
 bh=PTLZDIc/CNTa7e0Qnl7K8ZaroUem2dJUE/PHuBpoJbw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=pSiYFH5EJ7rRnq3MzDiWRUChv7woSRmtg1W14UztV6guGYg8x1KT0aY/O6uId9dhl
 z3S80k2HsWqi6xxoCQ43+Hb9tFBoJMkx/QOblW8xoO/YXNxIa7qQbEnUUGjG5R1cpE
 20LUXRbbncy44rpl7EMi2ZTuE3oM5KMem9Zxg0VM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a2644d77-e2ab-469d-a501-6e7057362be0@yandex-team.ru>
Date: Thu, 9 Oct 2025 23:15:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/33] vhost: vhost_dev_init(): drop extra features
 variable
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael@enfabrica.net, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-20-vsementsov@yandex-team.ru>
 <CAFubqFvDAWborVr0BKff_CWM9gt5f3ZvNsPd6RroA=+yyL469g@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFubqFvDAWborVr0BKff_CWM9gt5f3ZvNsPd6RroA=+yyL469g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 09.10.25 22:06, Raphael Norwitz wrote:
> Looks like this patch no longer applies cleanly but looks like the
> same cleanup to drop the local array may be fine?

Yes, seems we can do simply

vhost_dev_get_features(hdev, hdev->features_ex)

without extra copying.

> 
> On Wed, Aug 13, 2025 at 12:51 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   hw/virtio/vhost.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index f9163ba895..e796ad347d 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -1596,7 +1596,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>>                      VhostBackendType backend_type, uint32_t busyloop_timeout,
>>                      Error **errp)
>>   {
>> -    uint64_t features;
>>       int i, r, n_initialized_vqs = 0;
>>
>>       hdev->vdev = NULL;
>> @@ -1616,7 +1615,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>>           goto fail;
>>       }
>>
>> -    r = hdev->vhost_ops->vhost_get_features(hdev, &features);
>> +    r = hdev->vhost_ops->vhost_get_features(hdev, &hdev->_features);
>>       if (r < 0) {
>>           error_setg_errno(errp, -r, "vhost_get_features failed");
>>           goto fail;
>> @@ -1631,8 +1630,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>>           }
>>       }
>>
>> -    hdev->_features = features;
>> -
>>       hdev->memory_listener = (MemoryListener) {
>>           .name = "vhost",
>>           .begin = vhost_begin,
>> --
>> 2.48.1
>>
>>


-- 
Best regards,
Vladimir

