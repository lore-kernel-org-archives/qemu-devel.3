Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED29CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 21:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6xjO-0002Ww-KX; Thu, 09 Oct 2025 16:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v6xjM-0002WR-Bi; Thu, 09 Oct 2025 16:59:20 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v6xjK-0003Cx-CV; Thu, 09 Oct 2025 16:59:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 8CF47C0548;
 Thu, 09 Oct 2025 23:59:15 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:162::1:3a] (unknown
 [2a02:6bf:8080:162::1:3a])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ExRB131FKGk0-kNosNbKe; Thu, 09 Oct 2025 23:59:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760043555;
 bh=M9Py21Dd2Nh55ZgOTUI+3ecbIR7LYGocwR9OsyxhdU0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=kP0tp5NUQhZL6DrXsbe84P1rDGVPYZy8/GD++ro7e/TgD1sxZrrt6OTKQAV+zW6Ns
 7tdu2ETkHr+oV3DEpszoPhQFdirxESMMxQRYhzK4kTblbXNY5iOwU8vK/IF/jGkBMy
 X7Jm16hbC/h6RcTBGk1KwmuOjM2QzeB+zKsiEAaQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <727971fa-f181-460d-80f9-9fab24774269@yandex-team.ru>
Date: Thu, 9 Oct 2025 23:59:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/33] virtio: support vhost backend migration
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael@enfabrica.net, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-31-vsementsov@yandex-team.ru>
 <CAFubqFs_N0bUF9Gh2y14fX1W0ZwtrJfTomR7Q6sHXNGWMY7QrQ@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFubqFs_N0bUF9Gh2y14fX1W0ZwtrJfTomR7Q6sHXNGWMY7QrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 09.10.25 22:09, Raphael Norwitz wrote:
> A few nits. Looks like there has been some churn here so this patch
> will need to be rebased.
> 
> On Wed, Aug 13, 2025 at 1:01 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> Add logic to transfer virtio notifiers through migration channel
>> for vhost backend migration case.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---

[..]

>> @@ -3317,6 +3340,10 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>>           }
>>       }
>>
>> +    if (migrating_backend) {
> 
> nit: spurious spaces after &vdev->config_notifier

Oh, kept in v2) Will fix.

> 
>> +        event_notifier_init_fd(&vdev->config_notifier   , qemu_file_get_fd(f));
>> +    }
>> +
>>       virtio_notify_vector(vdev, VIRTIO_NO_VECTOR);
>>
>>       if (vdc->load != NULL) {

[..]

>> @@ -3394,6 +3434,18 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>>                   continue;
>>               }
>>
>> +            if (migrating_backend) {
>> +                /*
> 
> "prior to backend migration"?
> 

Right, will fix.

> 
> 
>> +                 * Indices are not synced prior backend migration (as we don't
>> +                 * stop vrings by GET_VRING_BASE). No reason to sync them now,
>> +                 * and do any checks.
>> +                 */
>> +                vdev->vq[i].used_idx = 0;
>> +                vdev->vq[i].shadow_avail_idx = 0;
>> +                vdev->vq[i].inuse = 0;
>> +                continue;
>> +            }

[..]

-- 
Best regards,
Vladimir

