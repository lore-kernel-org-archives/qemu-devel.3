Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BDAFD376C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 16:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvHKZ-0001D3-RC; Wed, 25 Feb 2026 11:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvHKA-00010D-JU
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:01:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvHK6-000208-LR
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772035265;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SMUGmsXVE6T7qaBrUMjeN3hXdOaT9gJ6ODCBiUJIr9M=;
 b=ZBID2ubB9zif44QvUh6uk5v3PWucNImJL4hJngVtU6X/5lX6PkseTo5deTbD0IwoisDjDD
 qTVhl9N4xPQLjKHBeMaQ35Vk9dA6KIVwQK89jkV2trTray3IWu4kh61ZUxV5ETOwtng6aY
 851bmNYPSKcQHTDtmflU44Tw5D4PoP8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-lP0eCJzJM6SvukokMlvECg-1; Wed,
 25 Feb 2026 11:01:01 -0500
X-MC-Unique: lP0eCJzJM6SvukokMlvECg-1
X-Mimecast-MFC-AGG-ID: lP0eCJzJM6SvukokMlvECg_1772035259
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F1E51955D5A; Wed, 25 Feb 2026 16:00:55 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.165])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 112F419560B6; Wed, 25 Feb 2026 16:00:51 +0000 (UTC)
Date: Wed, 25 Feb 2026 16:00:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, qemu-devel@nongnu.org, philmd@linaro.org
Subject: Re: [PATCH v3 1/3] char: qemu_chr_write_log() use qemu_write_full()
Message-ID: <aZ8csNV0DAHxK7uh@redhat.com>
References: <20260201173633.413934-1-vsementsov@yandex-team.ru>
 <20260201173633.413934-2-vsementsov@yandex-team.ru>
 <aYCJ3Mu9XJYnl1-r@redhat.com>
 <c70aacec-aa10-4a0c-8eae-f6c48da5b9f1@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c70aacec-aa10-4a0c-8eae-f6c48da5b9f1@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 19, 2026 at 09:07:07PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 02.02.26 14:26, Daniel P. Berrangé wrote:
> > On Sun, Feb 01, 2026 at 08:36:29PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > logfd is blocking, so we don't need to care about EAGAIN.
> > > Let's simply use qemu_write_full().
> > 
> > Are you sure logfd is always blocking ?  It can be an FD passed in
> > from outside QEMU, and off-hand, I'm not sure where we force that to
> > be blocking. Though we could argue it is the client't fault if they
> > passed a non-blocking FD to QEMU.
> > 
> > NB, we can *not* assume logfd is a plain file as libvirt will pass
> > in a pipe to send logging via virtlogd.
> > 
> 
> I'm sorry I missed the email. And the commit is in master now.
> 
> And, I missed the fact that
> 
>    qemu_create(common->logfile, flags, 0666, errp);
> 
> Can actually chose fd from "fdset". All named fds in monitor are set blocking
> explicitly except for the case when QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING flag
> take place.. But fds coming through add-fd commandline options are not handled
> this way, as I can see.

> Looking through:
> 
> 1. util/oslib-posix.c: qemu_write_pidfile()
> 
> Uses qemu_write_full(), *unprepared* to non-blocking.
> 
> 2. ui/ui-qmp-cmds.c: qmp_screendump()
> 
> 2.1. png_save() wraps the fd to fdopen(), which I assume should work well
> with blocking and non-blocking fds
> 
> 2.2. ppm_save() wraps it into qio_channel_file_new_fd()
> 
> qio_channel_write_all() -> qio_channel_writev_full_all() do handle QIO_CHANNEL_ERR_BLOCK
> 
> 3. qio_channel_file_new_path()
> 
> In general qio-channels are prepared to work with non-blocking fds.
> 
> qio_channel_file_new_path() is used (except for 2.2 and tests) from migration code, which
> I think should be prepared to non-blocking fds. At least, qemu_fill_buffer()
> handles QIO_CHANNEL_ERR_BLOCK.
> 
> 4. hw/usb/bus.c: usb_qdev_realize()
> 
> Wraps by fdopen()
> 
> 5. hw/uefi/var-service-pcap.c: uefi_vars_pcap_init()
> 
> Wraps by fdopen()
> 
> 6. hw/uefi/var-service-json.c: uefi_vars_json_init()
> 
> Use write() and don't handle EAGAIN: *unprepared* for non-blocking.
> 
> 7. dump/dump.c: qmp_dump_guest_memory()
> 
> Use qemu_write_full() - *unprepared*
> 
> 8. chardev/char.c: logfd - *unprepared* after my commit
> 
> 9. block/file-posix.c: raw_co_create()
> 
> May use write() and not handle EAGAIN during raw_regular_truncate() - unprepared.
> 
> 
> What to do with it? I see several possibilities:
> 
> 1. simply support EAGAIN in qemu_write_full()? Like it was in qemu_chr_write_log()
> - with g_usleep(100)?
> 
> 2. switch to qio_channel_file_new_path() + qio_channel_write_all()
> 
> 3. call qemu_set_blocking() on fd for *unprepared* cases

IMHO, use of FDs in non-blocking mode should always be an explicit
opt-in decision by the code in question.  So my preference is to
ensure FDs coming via -add-fd get forced into blocking mode, the
same as we do for FDs coming via the monitor (or any socket recv
when QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING is NOT set)

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


