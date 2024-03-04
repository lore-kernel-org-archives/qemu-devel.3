Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11712C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 12:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7ek-0002c5-D5; Mon, 04 Mar 2024 07:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rh7ee-0002XJ-2D
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:42:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rh7eb-0002et-Q4
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709556167;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vMQZhMHqnOOjRpBBPSLo6naP+qfewpCm9KZiy1Mjtlk=;
 b=VYLKZPq8BM+q9ExSA+m8YYN84YIhW4ia0rNcAbHi+FpK3xgdT54AKJnCk3abTvWntbRDvp
 jYBByumj5MrGymtKxe86tc9HdrIDVCwBqs4vCTaEO4aWAy9laZ24VVExlCAL/qxXPmV4zV
 D+nx6YlOu4DmlTsF7weirZV0hMp096g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-M-6Wi5NMM7SPNsut4CHWBg-1; Mon,
 04 Mar 2024 07:42:44 -0500
X-MC-Unique: M-6Wi5NMM7SPNsut4CHWBg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D59153C40B5A;
 Mon,  4 Mar 2024 12:42:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2801492BC7;
 Mon,  4 Mar 2024 12:42:27 +0000 (UTC)
Date: Mon, 4 Mar 2024 12:42:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v6 00/23] migration: File based migration with multifd
 and mapped-ram
Message-ID: <ZeXBsR0ctl4evdYb@redhat.com>
References: <20240229153017.2221-1-farosas@suse.de>
 <ZeXAGEVFWt4Z8QeN@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZeXAGEVFWt4Z8QeN@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Mar 04, 2024 at 08:35:36PM +0800, Peter Xu wrote:
> Fabiano,
> 
> On Thu, Feb 29, 2024 at 12:29:54PM -0300, Fabiano Rosas wrote:
> > => guest: 128 GB RAM - 120 GB dirty - 1 vcpu in tight loop dirtying memory
> 
> I'm curious normally how much time does it take to do the final fdatasync()
> for you when you did this test.
> 
> I finally got a relatively large system today and gave it a quick shot over
> 128G (100G busy dirty) mapped-ram snapshot with 8 multifd channels.  The
> migration save/load does all fine, so I don't think there's anything wrong
> with the patchset, however when save completes (I'll need to stop the
> workload as my disk isn't fast enough I guess..) I'll always hit a super
> long hang of QEMU on fdatasync() on XFS during which the main thread is in
> UNINTERRUPTIBLE state.

That isn't very surprising. If you don't have O_DIRECT enabled, then
all that disk I/O from the migrate is going to be in RAM, and thus the
fdatasync() is likely to trigger writing out alot of data.

Blocking the main QEMU thread though is pretty unhelpful. That suggests
the data sync needs to be moved to a non-main thread.

With O_DIRECT meanwhile there should be essentially no hit from fdatasync.

> 
> [<0>] rq_qos_wait+0xbb/0x130
> [<0>] wbt_wait+0x9c/0x100
> [<0>] __rq_qos_throttle+0x23/0x40
> [<0>] blk_mq_submit_bio+0x183/0x580
> [<0>] __submit_bio_noacct+0x7e/0x1e0
> [<0>] iomap_submit_ioend+0x4e/0x80
> [<0>] iomap_writepage_map+0x22a/0x400
> [<0>] write_cache_pages+0x17c/0x4c0
> [<0>] iomap_writepages+0x1c/0x40
> [<0>] xfs_vm_writepages+0x7a/0xb0 [xfs]
> [<0>] do_writepages+0xcf/0x1d0
> [<0>] filemap_fdatawrite_wbc+0x66/0x90
> [<0>] __filemap_fdatawrite_range+0x54/0x80
> [<0>] file_write_and_wait_range+0x48/0xb0
> [<0>] xfs_file_fsync+0x5a/0x240 [xfs]
> [<0>] __x64_sys_fdatasync+0x46/0x80
> [<0>] do_syscall_64+0x5c/0x90
> [<0>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> Do you also have it, or it's just my host kernel / other config that is
> different?
> 
> -- 
> Peter Xu
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


