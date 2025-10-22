Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25CACCD1BE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 05:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBRez-0008BB-F6; Wed, 22 Oct 2025 01:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vBRer-00088a-GR; Wed, 22 Oct 2025 01:45:13 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vBReo-00060P-6g; Wed, 22 Oct 2025 01:45:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 317EC884C6;
 Wed, 22 Oct 2025 08:45:05 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a4a::1:14] (unknown
 [2a02:6bf:8080:a4a::1:14])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 3jPgFG0IniE0-lhBx47Hj; Wed, 22 Oct 2025 08:45:04 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761111904;
 bh=oj17m890x5/eMG/+Yym7ZmwXI18Z46tQwF/zfZdQAUk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=VOJCcSNpzxFtGFhVXlszFnwHp/GzZStgkH66/ffQ0Ns1ODL8Lr8ACvWJn7uGqANuc
 Awg5L2K3mBjGdK4iU15ZnXmML6fORSg/nnLIVSI88biGb9jKTiZreAxFJ2luQ+JG2U
 3J0tW41T1cv+CvI7kxKeDNujVo8CR5lctRnrWGfc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <194f7090-b0d9-49e6-8cee-231871714b1a@yandex-team.ru>
Date: Wed, 22 Oct 2025 08:45:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/25] vhost-user-blk: move first vhost_user_blk_init()
 to _realize()
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de,
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 steven.sistare@oracle.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, jasowang@redhat.com
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-13-vsementsov@yandex-team.ru>
 <CAFubqFsKOJwD8w_jNRCuyTVs=LytbYF+ZsKTP986g-An-6Pbdw@mail.gmail.com>
 <a9afaaef-08a9-44cb-b401-b5b3bac1bff4@yandex-team.ru>
 <CAFubqFvQY_FN2yTJz_Yyf0AVhjFjPXfE5ndn3o6OhDP375mn9w@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFubqFvQY_FN2yTJz_Yyf0AVhjFjPXfE5ndn3o6OhDP375mn9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 21.10.25 21:06, Raphael Norwitz wrote:
> ACK on your point. One more question about setting s->connected = false.
> 
> On Tue, Oct 21, 2025 at 12:29 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> On 21.10.25 02:35, Raphael Norwitz wrote:
>>> On Thu, Oct 16, 2025 at 7:48 AM Vladimir Sementsov-Ogievskiy
>>> <vsementsov@yandex-team.ru> wrote:
>>>>
>>>> We'll need to postpone further connecting/reconnecting logic to the
>>>> later point to support backend-transfer migration for vhost-user-blk.
>>>> For now, move first call to vhost_user_blk_init() to _realize() (this
>>>> call will not be postponed). To support this, we also have to move
>>>> re-initialization to vhost_user_blk_realize_connect_loop().
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> ---
>>>>    hw/block/vhost-user-blk.c | 17 ++++++++++++++---
>>>>    1 file changed, 14 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>>>> index 36e32229ad..af4a97b8e4 100644
>>>> --- a/hw/block/vhost-user-blk.c
>>>> +++ b/hw/block/vhost-user-blk.c
>>>> @@ -464,14 +464,12 @@ static int vhost_user_blk_realize_connect(VHostUserBlk *s, Error **errp)
>>>>        DeviceState *dev = DEVICE(s);
>>>>        int ret;
>>>>
>>>> -    s->connected = false;
>>>> -
>>>>        ret = qemu_chr_fe_wait_connected(&s->chardev, errp);
>>>>        if (ret < 0) {
>>>>            return ret;
>>>>        }
>>>>
>>>> -    ret = vhost_user_blk_init(dev, true, errp);
>>>> +    ret = vhost_user_blk_connect(dev, errp);
>>>>        if (ret < 0) {
>>>>            qemu_chr_fe_disconnect(&s->chardev);
>>>>            return ret;
>>>> @@ -501,7 +499,16 @@ static int vhost_user_blk_realize_connect_loop(VHostUserBlk *s, Error **errp)
>>>>                error_prepend(errp, "Reconnecting after error: ");
>>>>                error_report_err(*errp);
>>>>                *errp = NULL;
>>>> +
> 
> Having removed setting s->connected = false from
> vhost_user_blk_realize_connect() we will now only set s->connected =
> false here in the if (*errp) {} error path. Shouldn't we also set
> s->connected = false outside the error path here or in
> vhost_user_blk_device_realize()?
> 

On success path we are calling vhost_user_blk_realize_connect() for the first
time, so s->connected was never set to true at this time, it must be false
(due to zero-initialization of the structure). We can add an assertion.

>>>> +            s->connected = false;
>>>> +
>>>> +            ret = vhost_user_blk_init(dev, false, errp);
>>>> +            if (ret < 0) {
>>>> +                /* No reason to retry initialization */
>>>> +                return ret;
>>>> +            }
>>>>            }
>>>> +
>>>>            ret = vhost_user_blk_realize_connect(s, errp);
>>>>        } while (ret < 0 && retries--);
>>>>
>>>> @@ -566,6 +573,10 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
>>>>        s->inflight = g_new0(struct vhost_inflight, 1);
>>>>        s->vhost_vqs = g_new0(struct vhost_virtqueue, s->num_queues);
>>>>
>>>
>>> Why call vhost_user_blk_init() here if we call it in
>>> host_user_blk_realize_connect_loop()?
>>
>> To be able to postpone the whole realize-connect-loop to the later
>> point (not in realize) in further commits.
>>
>> So this first init will stay in realize, for early initialization of the device.
>>
> 
> Makes sense - I missed that vhost_user_blk_init() is only called in
> the error path.
> 
>>>
>>>> +    if (vhost_user_blk_init(dev, false, errp) < 0) {
>>>> +        goto fail;
>>>> +    }
>>>> +
>>>>        if (vhost_user_blk_realize_connect_loop(s, errp) < 0) {
>>>>            goto fail;
>>>>        }
>>>> --
>>>> 2.48.1
>>>>
>>>>
>>
>>
>> --
>> Best regards,
>> Vladimir


-- 
Best regards,
Vladimir

