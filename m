Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3D9CAC587
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 09:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvuOE-0002Gt-RJ; Tue, 09 Sep 2025 05:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvuOB-0002CN-8b; Tue, 09 Sep 2025 05:11:47 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvuO3-000758-Sk; Tue, 09 Sep 2025 05:11:45 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 71601C016E;
 Tue, 09 Sep 2025 12:11:21 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b64::1:1] (unknown [2a02:6bf:8080:b64::1:1])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id JBFAiM5GoKo0-4NVRwbsR; Tue, 09 Sep 2025 12:11:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757409080;
 bh=L3lH1hM15uuVrbXA8zALL5Uubc/LbFJobFlzjr+v/Fs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=NGzm+y5D74z3rqKNhQXBHLlVN9jNaRZpo573EW2r0tWQOVuvLHeF1fQKSCkKU5Maq
 zCuDHAb/tpSc1+dmBhCgExHotuv7zltvm/CMbC6g1Ivd045LG+QkTIjkiRG5O8S60s
 sCcQtuiCx6vrkF7gJ9DJFztyoBBtZVBzj3gOkiM4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4b0de513-12fa-4891-8dde-82971efa4778@yandex-team.ru>
Date: Tue, 9 Sep 2025 12:11:19 +0300
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
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aL_ssg0m_4FOfpHo@redhat.com>
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

On 09.09.25 12:00, Daniel P. Berrangé wrote:
> On Wed, Sep 03, 2025 at 12:44:07PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Instead of open-coded g_unix_set_fd_nonblocking() calls, use
>> QEMU wrapper qemu_socket_set_nonblock().
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   chardev/char-fd.c                  |  4 ++--
>>   chardev/char-pty.c                 |  3 +--
>>   chardev/char-serial.c              |  3 +--
>>   chardev/char-stdio.c               |  3 +--
>>   hw/input/virtio-input-host.c       |  3 +--
>>   hw/misc/ivshmem-flat.c             |  4 +++-
>>   hw/misc/ivshmem-pci.c              |  8 +++++++-
>>   hw/virtio/vhost-vsock.c            |  8 ++------
>>   io/channel-command.c               |  9 ++++++---
>>   io/channel-file.c                  |  3 +--
>>   net/tap-bsd.c                      | 12 ++++++++++--
>>   net/tap-linux.c                    |  8 +++++++-
>>   net/tap-solaris.c                  |  7 ++++++-
>>   net/tap.c                          | 21 ++++++---------------
>>   qga/commands-posix.c               |  3 +--
>>   tests/qtest/fuzz/virtio_net_fuzz.c |  2 +-
>>   tests/qtest/vhost-user-test.c      |  3 +--
>>   tests/unit/test-iov.c              |  5 +++--
>>   ui/input-linux.c                   |  3 +--
>>   util/event_notifier-posix.c        |  5 +++--
>>   util/main-loop.c                   |  6 +++++-
>>   21 files changed, 69 insertions(+), 54 deletions(-)
> 
>> diff --git a/io/channel-command.c b/io/channel-command.c
>> index 8966dd3a2b..8ae9a026b3 100644
>> --- a/io/channel-command.c
>> +++ b/io/channel-command.c
>> @@ -277,9 +277,12 @@ static int qio_channel_command_set_blocking(QIOChannel *ioc,
>>       cioc->blocking = enabled;
>>   #else
>>   
>> -    if ((cioc->writefd >= 0 && !g_unix_set_fd_nonblocking(cioc->writefd, !enabled, NULL)) ||
>> -        (cioc->readfd >= 0 && !g_unix_set_fd_nonblocking(cioc->readfd, !enabled, NULL))) {
>> -        error_setg_errno(errp, errno, "Failed to set FD nonblocking");
>> +    if (cioc->writefd >= 0 &&
>> +        !qemu_set_blocking(cioc->writefd, enabled, errp)) {
>> +        return -1;
>> +    }
>> +    if (cioc->readfd >= 0 &&
>> +        !qemu_set_blocking(cioc->readfd, enabled, errp)) {
>>           return -1;
>>       }
>>   #endif
>> diff --git a/io/channel-file.c b/io/channel-file.c
>> index ca3f180cc2..5cef75a67c 100644
>> --- a/io/channel-file.c
>> +++ b/io/channel-file.c
>> @@ -223,8 +223,7 @@ static int qio_channel_file_set_blocking(QIOChannel *ioc,
>>   #else
>>       QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
>>   
>> -    if (!g_unix_set_fd_nonblocking(fioc->fd, !enabled, NULL)) {
>> -        error_setg_errno(errp, errno, "Failed to set FD nonblocking");
>> +    if (!qemu_set_blocking(fioc->fd, enabled, errp)) {
>>           return -1;
>>       }
>>       return 0;
> 
> This is wrong for Windows. fioc->fd is not a socket, but this is passing
> it to an API whose impl assume it is receiving a socket.
> 

But what is changed with the patch? g_unix_set_fd_nonblocking(fioc->fd, ..) is wrong for Windows as well.

And making separate qemu_set_blocking() and qemu_socket_set_blocking(), which do the same
thing, doesn't make sense..

Hmm. But we can define qemu_set_blocking() only for Linux, keeping qemu_socket_set_blocking() the generic
function. Still, nothing prevents using qemu_socket_set_blocking() on non-sockets..

I don't know. For me it seems better to have one qemu_set_blocking, and rely on Windows realization to
correctly error-out for non-socket fds.

Do you have and idea, how final API should look, covering sockets and non-socket fds?

I also found ff5927baa7ffb9c978 commit about it, see my last answer to the cover-letter.

-- 
Best regards,
Vladimir

