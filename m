Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE073C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 08:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1iqS-0003vW-79; Tue, 30 Apr 2024 04:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1iqQ-0003v4-LR; Tue, 30 Apr 2024 04:28:10 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1iqM-00048p-NZ; Tue, 30 Apr 2024 04:28:10 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:c10a:0:640:882f:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 3D2B660A8D;
 Tue, 30 Apr 2024 11:28:00 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8829::1:3c] (unknown
 [2a02:6b8:b081:8829::1:3c])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wRM1Ju1IdOs0-z2DtAN6k; Tue, 30 Apr 2024 11:27:59 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714465679;
 bh=sqPjVVoyz2TngqouqpSyXkZFAx8LmV+r/MynyCFBB84=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=vMFgMBYvI6Aqb8UJZMsY7MLLMHJLkO601fbSweyn9Bk0KEW2D6TNtnpkbE/+hPn8U
 78yHUW3kN7de9OsHiHsHbWAhpWjdRwPb3KUsZmWw2n5GGhixgh2F+c5sQbjluRq0EX
 qPq6tEvO4ZVzfZpQzLBoc8wRfosBFbis+Sl0kwMo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3c146e4c-8197-457e-99fc-9301879bf41b@yandex-team.ru>
Date: Tue, 30 Apr 2024 11:27:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] vhost-user-blk: split vhost_user_blk_sync_config()
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, raphael@enfabrica.net, mst@redhat.com,
 qemu-devel@nongnu.org, eblake@redhat.com, eduardo@habkost.net,
 berrange@redhat.com, pbonzini@redhat.com, hreitz@redhat.com,
 kwolf@redhat.com, yc-core@yandex-team.ru
References: <20240429101623.1992943-1-vsementsov@yandex-team.ru>
 <20240429101623.1992943-3-vsementsov@yandex-team.ru>
 <87edanclky.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87edanclky.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 30.04.24 11:15, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Split vhost_user_blk_sync_config() out from
>> vhost_user_blk_handle_config_change(), to be reused in the following
>> commit.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   hw/block/vhost-user-blk.c | 26 +++++++++++++++++++-------
>>   1 file changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>> index 9e6bbc6950..091d2c6acf 100644
>> --- a/hw/block/vhost-user-blk.c
>> +++ b/hw/block/vhost-user-blk.c
>> @@ -88,27 +88,39 @@ static void vhost_user_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
>>       s->blkcfg.wce = blkcfg->wce;
>>   }
>>   
>> +static int vhost_user_blk_sync_config(DeviceState *dev, Error **errp)
>> +{
>> +    int ret;
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> 
> Note for later: all this function does with paramter @dev is cast it to
> VirtIODevice *.
> 
>> +    VHostUserBlk *s = VHOST_USER_BLK(vdev);
>> +
>> +    ret = vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
>> +                               vdev->config_len, errp);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    memcpy(vdev->config, &s->blkcfg, vdev->config_len);
>> +    virtio_notify_config(vdev);
>> +
>> +    return 0;
>> +}
>> +
>>   static int vhost_user_blk_handle_config_change(struct vhost_dev *dev)
>>   {
>>       int ret;
>> -    VirtIODevice *vdev = dev->vdev;
>> -    VHostUserBlk *s = VHOST_USER_BLK(dev->vdev);
>>       Error *local_err = NULL;
>>   
>>       if (!dev->started) {
>>           return 0;
>>       }
>>   
>> -    ret = vhost_dev_get_config(dev, (uint8_t *)&s->blkcfg,
>> -                               vdev->config_len, &local_err);
>> +    ret = vhost_user_blk_sync_config(DEVICE(dev->vdev), &local_err);
> 
> dev->vdev is a VirtIODevice *.  You cast it to DeviceState * for
> vhost_user_blk_sync_config(), which casts it right back.
> 
> Could you simply pass it as is instead?

vhost_user_blk_sync_config() is generic handler, which will be used as ->sync_config() in the following commit, so it's good and convenient for it to have DeviceState* argument.

> 
>>       if (ret < 0) {
>>           error_report_err(local_err);
>>           return ret;
>>       }
>>   
>> -    memcpy(dev->vdev->config, &s->blkcfg, vdev->config_len);
>> -    virtio_notify_config(dev->vdev);
>> -
>>       return 0;
>>   }
> 

-- 
Best regards,
Vladimir


