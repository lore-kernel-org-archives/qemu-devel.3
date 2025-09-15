Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61939CAC598
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 10:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy64t-0006OY-6K; Mon, 15 Sep 2025 06:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uy64m-0006NO-SE; Mon, 15 Sep 2025 06:04:49 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uy64f-0005cP-5P; Mon, 15 Sep 2025 06:04:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:999c:0:640:51a7:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 82FFAC0166;
 Mon, 15 Sep 2025 13:04:26 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:130::1:7] (unknown [2a02:6bf:8080:130::1:7])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id P4MLxh1Gw8c0-SYdFSUJY; Mon, 15 Sep 2025 13:04:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757930666;
 bh=Dd4QO+/302SYGLq2Lyc9EAalzfkBk6p8GK+UN1KL840=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=0PqKlZF2DNSU05T7il3swVhsWXrWt5ZpssL8n1lEFHwi6wKY0ZuSH5BApJIwTbDv/
 AKImZEHMy8SuljShwcCfd4POoAnhiDWi5jzzJTkUXU1RgHAVBtiTWGPd51GXPJqadc
 7v1yaLuuqMgi1I8+6Y7Z+hOrxWrb4WZ7Ug8hRWh4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c578236f-d145-4a2f-8317-f3931b63da88@yandex-team.ru>
Date: Mon, 15 Sep 2025 13:04:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] use qemu_set_blocking instead of
 g_unix_set_fd_nonblocking
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 leiyang@redhat.com, marcandre.lureau@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Gustavo Romero
 <gustavo.romero@linaro.org>, Stefano Garzarella <sgarzare@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Darren Kenny <darren.kenny@oracle.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
References: <20250911092007.1370002-1-vsementsov@yandex-team.ru>
 <20250911092007.1370002-9-vsementsov@yandex-team.ru>
 <aMRUWCLd_U6FRLM9@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aMRUWCLd_U6FRLM9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 12.09.25 20:11, Daniel P. Berrangé wrote:
> On Thu, Sep 11, 2025 at 12:20:06PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Instead of open-coded g_unix_set_fd_nonblocking() calls, use
>> QEMU wrapper qemu_set_blocking().
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   chardev/char-fd.c                  |  4 ++--
>>   chardev/char-pty.c                 |  3 +--
>>   chardev/char-serial.c              |  3 +--
>>   chardev/char-stdio.c               |  3 +--
>>   hw/input/virtio-input-host.c       |  3 +--
>>   hw/misc/ivshmem-flat.c             |  3 ++-
>>   hw/misc/ivshmem-pci.c              |  7 ++++++-
>>   hw/virtio/vhost-vsock.c            |  8 ++------
>>   io/channel-command.c               |  9 ++++++---
>>   io/channel-file.c                  |  3 +--
>>   net/tap-bsd.c                      | 12 ++++++++++--
>>   net/tap-linux.c                    |  7 ++++++-
>>   net/tap-solaris.c                  |  7 ++++++-
>>   net/tap.c                          | 21 ++++++---------------
>>   qga/commands-posix.c               |  3 +--
>>   tests/qtest/fuzz/virtio_net_fuzz.c |  2 +-
>>   tests/qtest/vhost-user-test.c      |  3 +--
>>   tests/unit/test-iov.c              |  5 +++--
>>   ui/input-linux.c                   |  3 +--
>>   util/event_notifier-posix.c        |  4 ++--
>>   util/main-loop.c                   |  5 ++++-
>>   21 files changed, 64 insertions(+), 54 deletions(-)
>>
>> diff --git a/chardev/char-fd.c b/chardev/char-fd.c
>> index 6f03adf872..739dc68c36 100644
>> --- a/chardev/char-fd.c
>> +++ b/chardev/char-fd.c
>> @@ -212,8 +212,8 @@ void qemu_chr_open_fd(Chardev *chr,
>>       FDChardev *s = FD_CHARDEV(chr);
>>       g_autofree char *name = NULL;
>>   
>> -    if (fd_out >= 0 && !g_unix_set_fd_nonblocking(fd_out, true, NULL)) {
>> -        assert(!"Failed to set FD nonblocking");
>> +    if (fd_out >= 0) {
>> +        qemu_set_blocking(fd_out, false, &error_abort);
> 
> Every caller of this method has an 'errp' available that we
> can plumb into qemu_chr_open_fd().

Will look a it.

> 
>>       }
>>   
>>       if (fd_out == fd_in && fd_in >= 0) {
> 
> 
>> diff --git a/hw/misc/ivshmem-flat.c b/hw/misc/ivshmem-flat.c
>> index fe4be6be17..89495f6a11 100644
>> --- a/hw/misc/ivshmem-flat.c
>> +++ b/hw/misc/ivshmem-flat.c
>> @@ -154,7 +154,8 @@ static void ivshmem_flat_add_vector(IvshmemFTState *s, IvshmemPeer *peer,
>>        * peer.
>>        */
>>       peer->vector[peer->vector_counter].id = peer->vector_counter;
>> -    g_unix_set_fd_nonblocking(vector_fd, true, NULL);
>> +    /* WARNING: qemu_socket_set_nonblock() return code ignored */
>> +    qemu_set_blocking(vector_fd, false, NULL);
> 
> Perhaps &warn_report so we at least diagnose this awkward situation ?
> 

Ok

>>       event_notifier_init_fd(&peer->vector[peer->vector_counter].event_notifier,
>>                              vector_fd);
>>   
> 
> 

Thanks for reviewing!

-- 
Best regards,
Vladimir

