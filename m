Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846A4CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 09:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvuzO-0007U3-Hm; Tue, 09 Sep 2025 05:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvuzM-0007TJ-3F; Tue, 09 Sep 2025 05:50:12 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvuzI-0002ik-Bv; Tue, 09 Sep 2025 05:50:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:999c:0:640:51a7:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 073F2C00A8;
 Tue, 09 Sep 2025 12:50:02 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b64::1:1] (unknown [2a02:6bf:8080:b64::1:1])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 0oF3PH6GnKo0-UANnleBx; Tue, 09 Sep 2025 12:50:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757411401;
 bh=j7iYtYzVekjFPJR0abNsrxmkzVrVCp+wdFUOX+Rgstc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=TiGPp3ieezkxEuhJvtUElUaUDc3HAYwxaj/QpmyHq0N5+/i2qcJ7UYCScOsAwroFO
 fbMJRHhDGK/tY3V29ovJsVe6l37H7swEHoZnPmI0Jt/iVBH7PA+44Upoiitp2WQl0r
 enXhrTEWrWXcMJ0nKvzjHYBcaWmyMQXB2AdP4UnM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b3a67bc3-757a-4d11-b9cc-a6c69073add9@yandex-team.ru>
Date: Tue, 9 Sep 2025 12:50:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] use qemu_set_blocking instead of
 g_unix_set_fd_nonblocking
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kostiantyn Kostiuk
 <kkostiuk@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Darren Kenny <darren.kenny@oracle.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-8-vsementsov@yandex-team.ru>
 <aL_ssg0m_4FOfpHo@redhat.com>
 <4b0de513-12fa-4891-8dde-82971efa4778@yandex-team.ru>
 <aL_wTKuHCaTdDFRd@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aL_wTKuHCaTdDFRd@redhat.com>
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

On 09.09.25 12:15, Daniel P. Berrangé wrote:
> On Tue, Sep 09, 2025 at 12:11:19PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 09.09.25 12:00, Daniel P. Berrangé wrote:
>>> On Wed, Sep 03, 2025 at 12:44:07PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> Instead of open-coded g_unix_set_fd_nonblocking() calls, use
>>>> QEMU wrapper qemu_socket_set_nonblock().
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> ---
>>>>    chardev/char-fd.c                  |  4 ++--
>>>>    chardev/char-pty.c                 |  3 +--
>>>>    chardev/char-serial.c              |  3 +--
>>>>    chardev/char-stdio.c               |  3 +--
>>>>    hw/input/virtio-input-host.c       |  3 +--
>>>>    hw/misc/ivshmem-flat.c             |  4 +++-
>>>>    hw/misc/ivshmem-pci.c              |  8 +++++++-
>>>>    hw/virtio/vhost-vsock.c            |  8 ++------
>>>>    io/channel-command.c               |  9 ++++++---
>>>>    io/channel-file.c                  |  3 +--
>>>>    net/tap-bsd.c                      | 12 ++++++++++--
>>>>    net/tap-linux.c                    |  8 +++++++-
>>>>    net/tap-solaris.c                  |  7 ++++++-
>>>>    net/tap.c                          | 21 ++++++---------------
>>>>    qga/commands-posix.c               |  3 +--
>>>>    tests/qtest/fuzz/virtio_net_fuzz.c |  2 +-
>>>>    tests/qtest/vhost-user-test.c      |  3 +--
>>>>    tests/unit/test-iov.c              |  5 +++--
>>>>    ui/input-linux.c                   |  3 +--
>>>>    util/event_notifier-posix.c        |  5 +++--
>>>>    util/main-loop.c                   |  6 +++++-
>>>>    21 files changed, 69 insertions(+), 54 deletions(-)
>>>
>>>> diff --git a/io/channel-command.c b/io/channel-command.c
>>>> index 8966dd3a2b..8ae9a026b3 100644
>>>> --- a/io/channel-command.c
>>>> +++ b/io/channel-command.c
>>>> @@ -277,9 +277,12 @@ static int qio_channel_command_set_blocking(QIOChannel *ioc,
>>>>        cioc->blocking = enabled;
>>>>    #else
>>>> -    if ((cioc->writefd >= 0 && !g_unix_set_fd_nonblocking(cioc->writefd, !enabled, NULL)) ||
>>>> -        (cioc->readfd >= 0 && !g_unix_set_fd_nonblocking(cioc->readfd, !enabled, NULL))) {
>>>> -        error_setg_errno(errp, errno, "Failed to set FD nonblocking");
>>>> +    if (cioc->writefd >= 0 &&
>>>> +        !qemu_set_blocking(cioc->writefd, enabled, errp)) {
>>>> +        return -1;
>>>> +    }
>>>> +    if (cioc->readfd >= 0 &&
>>>> +        !qemu_set_blocking(cioc->readfd, enabled, errp)) {
>>>>            return -1;
>>>>        }
>>>>    #endif
>>>> diff --git a/io/channel-file.c b/io/channel-file.c
>>>> index ca3f180cc2..5cef75a67c 100644
>>>> --- a/io/channel-file.c
>>>> +++ b/io/channel-file.c
>>>> @@ -223,8 +223,7 @@ static int qio_channel_file_set_blocking(QIOChannel *ioc,
>>>>    #else
>>>>        QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
>>>> -    if (!g_unix_set_fd_nonblocking(fioc->fd, !enabled, NULL)) {
>>>> -        error_setg_errno(errp, errno, "Failed to set FD nonblocking");
>>>> +    if (!qemu_set_blocking(fioc->fd, enabled, errp)) {
>>>>            return -1;
>>>>        }
>>>>        return 0;
>>>
>>> This is wrong for Windows. fioc->fd is not a socket, but this is passing
>>> it to an API whose impl assume it is receiving a socket.
>>>
>>
>> But what is changed with the patch? g_unix_set_fd_nonblocking(fioc->fd, ..) is wrong for Windows as well.
> 
> Actually I missed the #ifdef. This code is in an #else branch that excludes
> compilation on Wnidows - the Windows brach just raise an error.
> 
>> And making separate qemu_set_blocking() and qemu_socket_set_blocking(), which do the same
>> thing, doesn't make sense..
>>
>> Hmm. But we can define qemu_set_blocking() only for Linux, keeping qemu_socket_set_blocking() the generic
>> function. Still, nothing prevents using qemu_socket_set_blocking() on non-sockets..
> 
> We just relying on the name of the function alerting the developer / reviewer.
> If you're dealing with a FIFO pipe FD you are (hopefully) going to realize
> that qemu_socket_XXX is not a function to be used.
> 

Understand. But having both qemu_XXX() and qemu_socket_XXX(), I'd be confused, why not just use qemu_XXX() everywhere.

So, for final API, either we have one function qemu_set_blocking() (as the series propose), and lose this alert,

or, we should have something like:

qemu_socket_set_blocking() - generic, for calling on sockets, Windows or Linux

qemu_unix_set_blocking() - defined only for Linux

What I dislike with the latter:

1. For Linux functions are duplicates actually. So, we have a defined only for Linux duplicate of generic function

2. Nothing prevents using qemu_socket_set_blocking() on any fds in Linux except name (and it will succeed!!)


-- 
Best regards,
Vladimir

