Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B31E9A058
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 18:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt8R2-0003Pp-8n; Thu, 19 Feb 2026 13:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vt8R0-0003NG-Bi
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 13:07:30 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vt8Qx-0001Mp-3z
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 13:07:30 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1e1e:0:640:c6a6:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id C9A338079E;
 Thu, 19 Feb 2026 21:07:08 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:192::1:26] (unknown
 [2a02:6bf:8080:192::1:26])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 77ggsv3AmqM0-7eHxc0wB; Thu, 19 Feb 2026 21:07:08 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771524428;
 bh=dz31cU15y/vBCpwG0mYg2eXBlTS6NhEWlqY5VDRyUHk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=chX2gKi9O4QYhEin56SqgYwQPx6kiT7a2dIeonfdPcr5CR1/9rfo1WM+Ayx9jWgfE
 7dmk3WYjaUpBZbeSCoGmuN65DvW8G74mj9u90Uj5OVnahVeJNW1MT38Pm+MsSHQ+FP
 nj1RCZ5d4NFltyIDIpIyoOoV+nKnpW9juGVeT7is=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c70aacec-aa10-4a0c-8eae-f6c48da5b9f1@yandex-team.ru>
Date: Thu, 19 Feb 2026 21:07:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] char: qemu_chr_write_log() use qemu_write_full()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 qemu-devel@nongnu.org, philmd@linaro.org
References: <20260201173633.413934-1-vsementsov@yandex-team.ru>
 <20260201173633.413934-2-vsementsov@yandex-team.ru>
 <aYCJ3Mu9XJYnl1-r@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aYCJ3Mu9XJYnl1-r@redhat.com>
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

On 02.02.26 14:26, Daniel P. Berrangé wrote:
> On Sun, Feb 01, 2026 at 08:36:29PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> logfd is blocking, so we don't need to care about EAGAIN.
>> Let's simply use qemu_write_full().
> 
> Are you sure logfd is always blocking ?  It can be an FD passed in
> from outside QEMU, and off-hand, I'm not sure where we force that to
> be blocking. Though we could argue it is the client't fault if they
> passed a non-blocking FD to QEMU.
> 
> NB, we can *not* assume logfd is a plain file as libvirt will pass
> in a pipe to send logging via virtlogd.
> 

I'm sorry I missed the email. And the commit is in master now.

And, I missed the fact that

    qemu_create(common->logfile, flags, 0666, errp);

Can actually chose fd from "fdset". All named fds in monitor are set blocking
explicitly except for the case when QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING flag
take place.. But fds coming through add-fd commandline options are not handled
this way, as I can see.


Looking through:

1. util/oslib-posix.c: qemu_write_pidfile()

Uses qemu_write_full(), *unprepared* to non-blocking.

2. ui/ui-qmp-cmds.c: qmp_screendump()

2.1. png_save() wraps the fd to fdopen(), which I assume should work well
with blocking and non-blocking fds

2.2. ppm_save() wraps it into qio_channel_file_new_fd()

qio_channel_write_all() -> qio_channel_writev_full_all() do handle QIO_CHANNEL_ERR_BLOCK

3. qio_channel_file_new_path()

In general qio-channels are prepared to work with non-blocking fds.

qio_channel_file_new_path() is used (except for 2.2 and tests) from migration code, which
I think should be prepared to non-blocking fds. At least, qemu_fill_buffer()
handles QIO_CHANNEL_ERR_BLOCK.

4. hw/usb/bus.c: usb_qdev_realize()

Wraps by fdopen()

5. hw/uefi/var-service-pcap.c: uefi_vars_pcap_init()

Wraps by fdopen()

6. hw/uefi/var-service-json.c: uefi_vars_json_init()

Use write() and don't handle EAGAIN: *unprepared* for non-blocking.

7. dump/dump.c: qmp_dump_guest_memory()

Use qemu_write_full() - *unprepared*

8. chardev/char.c: logfd - *unprepared* after my commit

9. block/file-posix.c: raw_co_create()

May use write() and not handle EAGAIN during raw_regular_truncate() - unprepared.


What to do with it? I see several possibilities:

1. simply support EAGAIN in qemu_write_full()? Like it was in qemu_chr_write_log()
- with g_usleep(100)?

2. switch to qio_channel_file_new_path() + qio_channel_write_all()

3. call qemu_set_blocking() on fd for *unprepared* cases

> 
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   chardev/char.c | 22 +++++-----------------
>>   1 file changed, 5 insertions(+), 17 deletions(-)
>>
>> diff --git a/chardev/char.c b/chardev/char.c
>> index 3e432195a5..64006a3119 100644
>> --- a/chardev/char.c
>> +++ b/chardev/char.c
>> @@ -82,29 +82,17 @@ void qemu_chr_be_event(Chardev *s, QEMUChrEvent event)
>>       CHARDEV_GET_CLASS(s)->chr_be_event(s, event);
>>   }
>>   
>> -/* Not reporting errors from writing to logfile, as logs are
>> - * defined to be "best effort" only */
>>   static void qemu_chr_write_log(Chardev *s, const uint8_t *buf, size_t len)
>>   {
>> -    size_t done = 0;
>> -    ssize_t ret;
>> -
>>       if (s->logfd < 0) {
>>           return;
>>       }
>>   
>> -    while (done < len) {
>> -    retry:
>> -        ret = write(s->logfd, buf + done, len - done);
>> -        if (ret == -1 && errno == EAGAIN) {
>> -            g_usleep(100);
>> -            goto retry;
>> -        }
>> -
>> -        if (ret <= 0) {
>> -            return;
>> -        }
>> -        done += ret;
>> +    if (qemu_write_full(s->logfd, buf, len) < len) {
>> +        /*
>> +         * qemu_write_full() is defined with G_GNUC_WARN_UNUSED_RESULT,
>> +         * but logging is best‑effort, we do ignore errors.
>> +         */
>>       }
>>   }
>>   
>> -- 
>> 2.52.0
>>
> 
> With regards,
> Daniel


-- 
Best regards,
Vladimir

