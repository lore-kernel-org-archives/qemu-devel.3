Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42003C10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 11:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1lTE-0008Px-4Y; Tue, 30 Apr 2024 07:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s1lTB-0008OA-Pf
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 07:16:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s1lT9-0004tP-W2
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 07:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714475779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xn3psMRettsiwEkjxHMlaszxT/PcG8xOOrto5+1tM5U=;
 b=JVjM5ro4vJ5uqibwXJIegpBEPbtwCaUFq+2hNFvsbzc47dXu+cREKwUDCFJm+DZ+5U7L7U
 qbRgAOr2g6+gEtQ5oxADx71/+FG36n+nEVYDa+jqjPezZv01maQQaQt/EemSvZAiA/EVqv
 +oblwCAguTuXaZwmn5/j2tUqz62fPXs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-5k3KpysaOFS6IzIYy7OeHg-1; Tue, 30 Apr 2024 07:16:15 -0400
X-MC-Unique: 5k3KpysaOFS6IzIYy7OeHg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D0F38032FA;
 Tue, 30 Apr 2024 11:16:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 06AF0EC681;
 Tue, 30 Apr 2024 11:16:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0CD4321E66C8; Tue, 30 Apr 2024 13:16:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-block@nongnu.org,
 raphael@enfabrica.net,  mst@redhat.com,  qemu-devel@nongnu.org,
 eblake@redhat.com,  eduardo@habkost.net,  berrange@redhat.com,
 pbonzini@redhat.com,  hreitz@redhat.com,  kwolf@redhat.com,
 yc-core@yandex-team.ru
Subject: Re: [PATCH v4 2/3] vhost-user-blk: split vhost_user_blk_sync_config()
In-Reply-To: <3c146e4c-8197-457e-99fc-9301879bf41b@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 30 Apr 2024 11:27:58 +0300")
References: <20240429101623.1992943-1-vsementsov@yandex-team.ru>
 <20240429101623.1992943-3-vsementsov@yandex-team.ru>
 <87edanclky.fsf@pond.sub.org>
 <3c146e4c-8197-457e-99fc-9301879bf41b@yandex-team.ru>
Date: Tue, 30 Apr 2024 13:16:14 +0200
Message-ID: <87a5lb9k3l.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 30.04.24 11:15, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> Split vhost_user_blk_sync_config() out from
>>> vhost_user_blk_handle_config_change(), to be reused in the following
>>> commit.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> ---
>>>   hw/block/vhost-user-blk.c | 26 +++++++++++++++++++-------
>>>   1 file changed, 19 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>>> index 9e6bbc6950..091d2c6acf 100644
>>> --- a/hw/block/vhost-user-blk.c
>>> +++ b/hw/block/vhost-user-blk.c
>>> @@ -88,27 +88,39 @@ static void vhost_user_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
>>>       s->blkcfg.wce = blkcfg->wce;
>>>   }
>>>   +static int vhost_user_blk_sync_config(DeviceState *dev, Error **errp)
>>> +{
>>> +    int ret;
>>> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>
>> Note for later: all this function does with paramter @dev is cast it to
>> VirtIODevice *.
>> 
>>> +    VHostUserBlk *s = VHOST_USER_BLK(vdev);
>>> +
>>> +    ret = vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
>>> +                               vdev->config_len, errp);
>>> +    if (ret < 0) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    memcpy(vdev->config, &s->blkcfg, vdev->config_len);
>>> +    virtio_notify_config(vdev);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>  static int vhost_user_blk_handle_config_change(struct vhost_dev *dev)
>>>  {
>>>      int ret;
>>> -    VirtIODevice *vdev = dev->vdev;
>>> -    VHostUserBlk *s = VHOST_USER_BLK(dev->vdev);
>>>      Error *local_err = NULL;
>>>
>>>      if (!dev->started) {
>>>          return 0;
>>>      }
>>>
>>> -    ret = vhost_dev_get_config(dev, (uint8_t *)&s->blkcfg,
>>> -                               vdev->config_len, &local_err);
>>> +    ret = vhost_user_blk_sync_config(DEVICE(dev->vdev), &local_err);
>>
>> dev->vdev is a VirtIODevice *.  You cast it to DeviceState * for
>> vhost_user_blk_sync_config(), which casts it right back.
>> Could you simply pass it as is instead?
>
> vhost_user_blk_sync_config() is generic handler, which will be used as ->sync_config() in the following commit, so it's good and convenient for it to have DeviceState* argument.

Ah, that's what I missed.

>>>      if (ret < 0) {
>>>          error_report_err(local_err);
>>>          return ret;
>>>      }
>>>
>>> -    memcpy(dev->vdev->config, &s->blkcfg, vdev->config_len);
>>> -    virtio_notify_config(dev->vdev);
>>> -
>>>      return 0;
>>>  }


