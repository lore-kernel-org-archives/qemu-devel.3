Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7474C54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 17:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkosT-0007lP-U4; Thu, 14 Mar 2024 13:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rkosS-0007kx-2I
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 13:28:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rkosQ-0008KC-EJ
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 13:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710437300;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UG+muscPwBthZoQXkoT6a/8mTSOynLf+HAbnM/EyCXQ=;
 b=R0k+cBtgppZ0IN4qgH+XuRTTnaHbdazJepnILe7kfwWPbaO8q4peqPVyulwr/Dvnv3O7Bx
 Z9SM9ISYZA3f+pzIMFDGM+Q/hGpsrHsOXAmZs9kBeuE5WET6N/YMkMcrZBVNJcdrFGRxbH
 Q0RaSaRfBfHyLFyGJ/UykWHnXzVGgQA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-jVBxPGKvOYCo45bNAIv5VQ-1; Thu, 14 Mar 2024 13:28:16 -0400
X-MC-Unique: jVBxPGKvOYCo45bNAIv5VQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76B088007A3;
 Thu, 14 Mar 2024 17:28:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 339253C21;
 Thu, 14 Mar 2024 17:28:15 +0000 (UTC)
Date: Thu, 14 Mar 2024 17:28:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: Re: [PATCH v2] block: Use LVM tools for LV block device truncation
Message-ID: <ZfMzrdzbOQfTQZ5Y@redhat.com>
References: <20240313104327.147450-1-alexander.ivanov@virtuozzo.com>
 <ZfLxLKlHKqFvbcKO@redhat.com>
 <46f8e6c4-3a93-43cd-8652-bf574ea26a1a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46f8e6c4-3a93-43cd-8652-bf574ea26a1a@virtuozzo.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Mar 14, 2024 at 06:25:00PM +0100, Alexander Ivanov wrote:
> 
> 
> On 3/14/24 13:44, Daniel P. Berrangé wrote:
> > On Wed, Mar 13, 2024 at 11:43:27AM +0100, Alexander Ivanov wrote:
> > > If a block device is an LVM logical volume we can resize it using
> > > standard LVM tools.
> > > 
> > > Add a helper to detect if a device is a DM device. In raw_co_truncate()
> > > check if the block device is DM and resize it executing lvresize.
> > > 
> > > Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> > > ---
> > >   block/file-posix.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 61 insertions(+)
> > > 
> > > diff --git a/block/file-posix.c b/block/file-posix.c
> > > index 35684f7e21..5f07d98aa5 100644
> > > --- a/block/file-posix.c
> > > +++ b/block/file-posix.c
> > > @@ -2642,6 +2642,38 @@ raw_regular_truncate(BlockDriverState *bs, int fd, int64_t offset,
> > >       return raw_thread_pool_submit(handle_aiocb_truncate, &acb);
> > >   }
> > >   static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
> > >                                           bool exact, PreallocMode prealloc,
> > >                                           BdrvRequestFlags flags, Error **errp)
> > > @@ -2670,6 +2702,35 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
> > >       if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
> > >           int64_t cur_length = raw_getlength(bs);
> > > +        /*
> > > +         * Try to resize an LVM device using LVM tools.
> > > +         */
> > > +        if (device_is_dm(&st) && offset > 0) {
> > > +            int spawn_flags = G_SPAWN_SEARCH_PATH | G_SPAWN_STDOUT_TO_DEV_NULL;
> > > +            int status;
> > > +            bool success;
> > > +            char *err;
> > > +            GError *gerr = NULL;
> > > +            g_autofree char *size_str = g_strdup_printf("%ldB", offset);
> > offset is 64-bit, but '%ld' is not guaranteed to be 64-bit. I expect
> > this will break on 32-bit platforms. Try PRId64 instead.
> > 
> > > +            const char *cmd[] = {"lvresize", "-f", "-L",
> > > +                                 size_str, bs->filename, NULL};
> > > +
> > > +            success = g_spawn_sync(NULL, (gchar **)cmd, NULL, spawn_flags,
> > > +                                   NULL, NULL, NULL, &err, &status, &gerr);
> > > +
> > > +            if (success && WEXITSTATUS(status) == 0) {
> > > +                return 0;
> > > +            }
> > We should probably check  'g_spawn_check_wait_status' rather than
> > WEXITSTATUS, as this then gives us further eror message details
> > that....
> Thank you.
> I think it would be better to use 'g_spawn_check_exit_status' because there
> is no
> 'g_spawn_check_wait_status' in glib before 2.70 and even in 2.78 it leads to
> 'g_spawn_check_wait_status is deprecated: Not available before 2.70' error.

Ah yes, well spotted.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


