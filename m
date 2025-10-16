Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD01CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mh6-0006wM-K4; Thu, 16 Oct 2025 08:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MgX-0006mW-4O; Thu, 16 Oct 2025 08:02:25 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MgO-0006Bp-9N; Thu, 16 Oct 2025 08:02:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 87A0E807A1;
 Thu, 16 Oct 2025 15:01:59 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a8c::1:19] (unknown
 [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id v1QGxO3FU4Y0-7nd8kGOt; Thu, 16 Oct 2025 15:01:58 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760616118;
 bh=NHb38OUiqZXgSaC8IVKwJ0dD65lfqrd3/dZAyp7Br2o=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=H7BmWk1u9DGtwrI+Y0X2vucKO8ikVX+Ljrmns036OTn62/dnxvORbjW8GoluRafSR
 afpYOWjMzrBtrxitJRebtNMP16QaAJqQmPziaU83wLJpspKq2EVVU3pKx8Ff1wd52E
 IeJSO8B13ChXlHyRcwpNJqTaZxOk2wNperUknwxw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <15fc4cbf-33b0-4dd4-9387-db657e1d88d6@yandex-team.ru>
Date: Thu, 16 Oct 2025 15:01:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/25] chardev: introduce backend-transfer vmstate for
 chardev
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de,
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, steven.sistare@oracle.com,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, jasowang@redhat.com
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-19-vsementsov@yandex-team.ru>
 <aPDdThfXS4lOB8nV@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aPDdThfXS4lOB8nV@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 16.10.25 14:55, Daniel P. Berrangé wrote:
> On Thu, Oct 16, 2025 at 02:40:55PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> We'll need to transfer the chardev attached to vhost-user-blk, to
>> support backend-transfer migration for vhost-user-blk. So, prepare
>> chardev vmsd now.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   chardev/char-backend-transfer.c         | 52 +++++++++++++++++++++++++
>>   chardev/meson.build                     |  1 +
>>   include/chardev/char-backend-transfer.h | 17 ++++++++
>>   3 files changed, 70 insertions(+)
>>   create mode 100644 chardev/char-backend-transfer.c
>>   create mode 100644 include/chardev/char-backend-transfer.h
>>
>> diff --git a/chardev/char-backend-transfer.c b/chardev/char-backend-transfer.c
>> new file mode 100644
>> index 0000000000..f1a399c7fa
>> --- /dev/null
>> +++ b/chardev/char-backend-transfer.c
>> @@ -0,0 +1,52 @@
>> +/*
>> + * Event notifier migration support
>> + * Copyright (c) Yandex Technologies LLC, 2025
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "chardev/char-fe.h"
>> +#include "migration/vmstate.h"
>> +
>> +typedef struct CharBackendTransferTmp {
>> +    CharBackend *parent;
>> +    int fd;
>> +} CharBackendTransferTmp;
>> +
>> +static int char_backend_transfer_pre_save(void *opaque)
>> +{
>> +    CharBackendTransferTmp *tmp = opaque;
>> +
>> +    tmp->fd = qemu_chr_get_client(tmp->parent->chr);
>> +    if (tmp->fd < 0) {
>> +        return -1;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int char_backend_transfer_post_load(void *opaque, int version_id)
>> +{
>> +    CharBackendTransferTmp *tmp = opaque;
>> +
>> +    return qemu_chr_add_client(tmp->parent->chr, tmp->fd);
>> +}
>> +
>> +const VMStateDescription vmstate_backend_transfer_char_tmp = {
>> +    .name = "backend-transfer-char-tmp",
>> +    .pre_save = char_backend_transfer_pre_save,
>> +    .post_load = char_backend_transfer_post_load,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_FD(fd, CharBackendTransferTmp),
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>> +const VMStateDescription vmstate_backend_transfer_char = {
>> +    .name = "backend-transfer-char",
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_WITH_TMP(CharBackend, CharBackendTransferTmp,
>> +                         vmstate_backend_transfer_char_tmp),
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
> 
> On the one hand this code is positioned as if it were a generic
> mechanism for transferring chardev vmstate, but on the oother
> hand it is hardcoded to only work with the socket chardev and
> is only able to transfer an FD, no other state.
> 
> Socket chardevs can involve telnet, tls or websocket protocol
> layering all of which have considerable state that is being
> ignored by this.
> 
> IMHO each chardev backend needs to be directly responsible
> for handling vmstate, and it needs to be able to raise an
> error if there is state which cannot be transferred. This
> would avoid creatin of the undesirable qemu_chr_get_client
> method as public API.
> 

Ow, that's right, me ashamed. I implemented it in a wrong layer.
Will rework, thanks!

-- 
Best regards,
Vladimir

